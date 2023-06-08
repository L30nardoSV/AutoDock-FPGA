# AutoDock-FPGA

OpenCL task-parallel version of AutoDock4 for Intel FPGAs.

## Instructions

### DevCloud

Execute the following commands on a login node (not compute note!):

```
cd adfpga
source ./1_runme_first.sh
```

```
devcloud_login -b A10PAC 1.2.1 walltime=12:00:00 batch_A10.sh
```

```
devcloud_login -b S10PAC walltime=12:00:00 batch_S10.sh
```

Instructions: https://github.com/intel/FPGA-Devcloud/tree/master/main/Devcloud_Access_Instructions#50-connecting-to-servers-running-fpga-development-software

### Local

Execute the following on any local machine with all tools installed:

```
source init_intel_opencl.sh
```

```
cd adfpga
make emu BOARD=a10gx
```
