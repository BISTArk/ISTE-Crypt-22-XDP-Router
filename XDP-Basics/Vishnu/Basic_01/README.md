
# Basic_01
 This first tutorial helped us in installing the required 
 dependencies and mainly concentrated on the baisc topics 
 such as compiling the code and Loading and about the XDP hook.

## Compiling the code
If all the requirments are correctly installed then a simple `make` 
command in respective directory will do the job.

We can also do this manually by using `LLVM+clang` compiler to convert 
C code to object code by selecting bpf as target while runnig the command.

## Loading and the XDP hook
We know BPF code is stored in ELF(Executable and Linkable Format) file. To load 
this into the kernel, we need a ELF loader. This loading can be done using 
iproute2 tools or by writing a C script and then compiling it to form a 
application(.exe file). 

### C Script Loading
we can load the BPF ELF file into kernel with help of our written program
by executing the following command
```bash
$ sudo ./xdp_loader --dev lo --skb-mode
```
Here `xdp_loader` is the loader application.
## Assignments
No assignments were given in this tutorial
