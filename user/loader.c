#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <bpf/libbpf.h>
#include <net/if.h>
#include <linux/if_link.h>

char *interfaceName = "wlp2s0";
char *xdpFilename = "xdp_kernel.o";
char *xdpSection = "xdp";
int xdpFlags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_SKB_MODE;
char *map = "/sys/fs/bpf/wlp2s0";
char *mapName = "/sys/fs/bpf/wlp2s0/tx_port";

int main() {
  struct bpf_object *bpfObject;
  int error;

  /* Determine interface ID from its name*/
  printf("Converting interface name to index\n");
  
  int interfaceIndex = if_nametoindex(interfaceName);
  if (interfaceIndex == 0) perror("Interface Index");
  printf("Converted interface name %s to interface index %i\n", interfaceName, interfaceIndex);
  
  /* Attempt to detatch a current program on that interface */
  printf("Attempting to detach the current program\n");

  __u32 currentProgramID;
  error = bpf_get_link_xdp_id(interfaceIndex, &currentProgramID, xdpFlags);
  if (error) {
    printf("Error getting link XDP ID\n");
    exit(1);
  }

  if (!currentProgramID) {
    printf("No current program loaded\n");
  } else {
    error = bpf_set_link_xdp_fd(interfaceIndex, -1, xdpFlags);
    if (error < 0) {
      printf("Error detaching current program %i\n", currentProgramID);
      exit(1);
    }
    printf("Current program detached\n");
  }

  /* Load the BPF program */
  printf("Loading BPF program from %s\n", xdpFilename);
  
   struct bpf_prog_load_attr programAttributes =
     {
      .prog_type = BPF_PROG_TYPE_XDP,
      .ifindex = 0,
      .file = xdpFilename,
     };

   int programFD = -1;
   error = bpf_prog_load_xattr(&programAttributes, &bpfObject, &programFD);

   if (error) {
     printf("Error loading BPF program\n");
     exit(1);
   }

   printf("Loaded BPF program\n");

   /* Find BPF Section */
   printf("Finding BPF section %s\n", xdpSection);

   struct bpf_program *bpfProgram = bpf_object__find_program_by_title(bpfObject, xdpSection);
   if (!bpfProgram) {
     printf("Error finding BPF section\n");
     exit(1);
   }

   programFD = bpf_program__fd(bpfProgram);
   if (programFD <= 0) {
     printf("Error finding BPF FD\n");
     exit(1);
   }

   printf("Found BPF section\n");

   /* Attach XDP Program */
   printf("Attaching XDP program\n");

   error = bpf_set_link_xdp_fd(interfaceIndex, programFD, xdpFlags);

   if (error < 0) {
     printf("Error attaching XDP program\n");
     exit(1);
   }

   printf("XDP program attached\n");

   /* Remove old maps */
   printf("Removing old maps\n");

   if (access(mapName, F_OK) != -1) {
     error = bpf_object__unpin_maps(bpfObject, map);
     if (error) {
       printf("Error removing old maps\n");
       exit(1);
     }
     printf("Old maps removed\n");
   } else {
     printf("No maps found\n");
   }

   /* Pin maps */
   printf("Pinning maps\n");

   error = bpf_object__pin_maps(bpfObject, map);
   if (error) {
     printf("Error pinning maps\n");
     exit(1);
   }

   printf("Pinned maps\n");
   
   return 0;
}