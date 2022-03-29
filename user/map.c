#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <net/if.h>
#include <linux/if_link.h>
#include <arpa/inet.h>
#include "cbr.h"

char *txMapName = "/sys/fs/bpf/wlp2s0/tx_port";
char *txMapSource = "wlp2s0";
char *txMapRedirect = "gw0";

char *ipsMapName = "/sys/fs/bpf/wlp2s0/xdp_server_ips";
char *ips[] = {"10.0.0.1", "10.0.0.2", "10.0.0.3"};

char *contentMapName = "/sys/fs/bpf/wlp2s0/redirect";
char machines[] = {'b', 'c'};

int main() {

  int error;
  
  // TX Port
  int txPortFD = bpf_obj_get(txMapName);
  if (txPortFD < 0) {
    printf("Error finding %s map\n", txMapName);
    exit(1);
  }

  int sourceIndex = if_nametoindex(txMapSource);
  if (sourceIndex == 0) perror("Source Index");
  
  int redirectIndex = if_nametoindex(txMapRedirect);
  if (redirectIndex == 0) perror("Redirect Index");
  
  error = bpf_map_update_elem(txPortFD, &sourceIndex, &redirectIndex, 0);
  if (error) {
    printf("Error updating tx port\n");
    exit(1);
  }

  printf("tx_port: redirecting %s:%i to %s:%i\n", txMapSource, sourceIndex, txMapRedirect, redirectIndex);

  // IPs
  int ipsFD = bpf_obj_get(ipsMapName);
  if (ipsFD < 0) {
    printf("Error finding %s map\n", ipsMapName);
  }

  for (__u32 key = 0; key < SERVERS + 1; key++) {
    struct ip data = { .addr = inet_addr(ips[key]) };
    error = bpf_map_update_elem(ipsFD, &key, &data, 0);
    if (error) {
      printf("Error updating ips\n");
      exit(1);
    }
    printf("ips: set ip %i to %s\n", key, ips[key]);
  }

  // Content
  int contentFD = bpf_obj_get(contentMapName);
  if (contentFD < 0) {
    printf("Error finding %s map\n", contentMapName);
  }

  for (__u32 key = 1; key <= SERVERS; key++) {
    error = bpf_map_update_elem(contentFD, &machines[key - 1], &key, 0);
    if (error) {
      printf("Error updating content\n");
      exit(1);
    }
    printf("content: routing %c to machine %i\n", machines[key - 1], key);
  }
  
  return 0;
}