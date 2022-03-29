#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <linux/if_ether.h>
#include <linux/in.h>
#include <linux/if_packet.h>
#include <linux/if_vlan.h>
#include <linux/ipv6.h>
#include <stdint.h>
#include "cbr.h"

#define MSB(X) ((X & 0xFF) << 8) | ((X & 0xFF00) >> 8)

struct bpf_map_def SEC("maps") xdp_server_ips =
  {
   .type        = BPF_MAP_TYPE_ARRAY,
   .key_size    = sizeof(__u32),
   .value_size  = sizeof(struct ip),
   .max_entries = SERVERS + 1
  };

struct bpf_map_def SEC("maps") tx_port =
  {
   .type = BPF_MAP_TYPE_DEVMAP,
   .key_size = sizeof(int),
   .value_size = sizeof(int),
   .max_entries = 256,
  };

struct bpf_map_def SEC("maps") redirect =
  {
   .type = BPF_MAP_TYPE_HASH,
   .key_size = sizeof(char),
   .value_size = sizeof(__u32),
   .max_entries = 256,
  };

SEC("xdp")
int xdp_prog_simple(struct xdp_md *ctx) {
  
  char fmt[] = "Received message \"%s\", routing to machine %d\n";
  char fwdError[] = "Forwarding Table Error %x\n";
  char redirectError[] = "Redirect Map Lookup Error\n";
  char ipError[] = "IP Map Lookup Error\n";
  char txError[] = "TX Map Lookup Error\n";
  char adjustError[] = "Adjust Tail Error\n";
  
  void *data = (void *)(long) ctx->data;
  void *data_end = (void *)(long) ctx->data_end;

  struct ethhdr *eth = data;
  if (eth + 1 > data_end) return XDP_PASS; 
  if (eth->h_proto != __constant_htons(ETH_P_IP)) return XDP_PASS;

  struct iphdr * iph = data + sizeof(struct ethhdr);
  if (iph + 1 > data_end) return XDP_PASS;
  if (iph->protocol != IPPROTO_TCP) return XDP_PASS;

  struct tcphdr *th = (struct tcphdr *) (iph + 1);
  if (th + 1 > data_end) return XDP_PASS;
  if (MSB(th->dest)) != 7777) return XDP_PASS;
  
    char *payload = (char *) iph + (th->doff * 4) + sizeof(struct tcphdr);
    if (payload + 4 > data_end) return XDP_PASS;
    if (payload[0] == 'c' && payload[1] == 'b' && payload[2] == 'r') {
      
      char machine = payload[3];
      char printMachine[] = "0";
      printMachine[0] = machine;
      
      __u32 *machineNumber = bpf_map_lookup_elem(&redirect, &machine);
      if (!machineNumber) {
        bpf_trace_printk(redirectError, sizeof(redirectError));
        return XDP_ABORTED;
      }
      
      __u32 hostMachine = 0;
      bpf_trace_printk(fmt, sizeof(fmt), printMachine, *machineNumber);
    
      int diff = (th->doff * 4) - sizeof(struct udphdr);
      int dsize = MSB(iph->tot_len) - (sizeof(struct iphdr) + (th->doff * 4));

      char *dataLocation = data + sizeof(struct ethhdr) + sizeof(struct iphdr) + (th->doff * 4);
      char *udpEnd = data + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr);
      dsize = dsize & 0xffff;
      if (dataLocation + 5 > data_end) return XDP_PASS;
      __builtin_memcpy(udpEnd, dataLocation, 5);  
      
      struct udphdr *uh = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
      uh->dest = MSB(7777);
      uh->source = MSB(0);
      uh->check = MSB(0);
      uh->len = MSB(dsize + sizeof(struct udphdr));
    
      struct ip *destValue = bpf_map_lookup_elem(&xdp_server_ips, machineNumber);
      struct ip *srcValue = bpf_map_lookup_elem(&xdp_server_ips, &hostMachine);

      if (!destValue || !srcValue) {
        bpf_trace_printk(ipError, sizeof(ipError));
        return XDP_ABORTED;
      }

      iph->daddr = destValue->addr;
      iph->saddr = srcValue->addr;
      iph->protocol = IPPROTO_UDP;
      iph->tot_len = MSB(MSB(iph->tot_len) - diff);
      iph->check = 0;
    
      uint32_t sum = 0;
      uint8_t * msg = data + sizeof(struct ethhdr);
      
      for (int i = 0; i < 20; i += 2) {
        sum += (((uint16_t) msg[i]) << 8) + msg[i+1];
      }
      
      sum = (sum >> 16) + (sum & 0xFFFF);
      sum = (uint16_t) ~sum;
      sum = ((sum & 0xFF00) >> 8) + ((sum & 0x00FF) << 8);
      
      iph->check = sum;
    
      int x = ctx->ingress_ifindex;
      int *ifindex = bpf_map_lookup_elem(&tx_port, &x);
      if (!ifindex) {
        bpf_trace_printk(txError, sizeof(txError));
        return XDP_ABORTED;
      }
    
      struct bpf_fib_lookup fib_params = {};
      fib_params.family = 2;
      fib_params.tos = iph->tos;
      fib_params.l4_protocol=iph->protocol;
      fib_params.sport = 0;
      fib_params.dport = 0;
      fib_params.tot_len = bpf_ntohs(iph->tot_len);
      fib_params.ipv4_src = iph->saddr;
      fib_params.ipv4_dst = iph->daddr;
      fib_params.ifindex = *ifindex;
      
      int rc = bpf_fib_lookup(ctx, &fib_params, sizeof(fib_params), 0);
    
      if (rc == BPF_FIB_LKUP_RET_SUCCESS) {
        __builtin_memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
        __builtin_memcpy(eth->h_source, fib_params.smac, ETH_ALEN);

        if (bpf_xdp_adjust_tail(ctx, -diff) != 0) {
          bpf_trace_printk(adjustError, sizeof(adjustError));
          return XDP_ABORTED;
        }

        return bpf_redirect_map(&tx_port, ctx->ingress_ifindex, 0);

      }
    
      bpf_trace_printk(fwdError, sizeof(fwdError), rc);
    }
  return XDP_PASS;
}

char _license[] SEC("license") = "GPL";