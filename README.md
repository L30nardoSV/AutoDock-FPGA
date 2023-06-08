# AutoDock-FPGA

OpenCL task-parallel version of AutoDock4 for Intel FPGAs.

## Tools

Steps to initialize Intel OpenCL development/deployment tools.

### DevCloud

Execute the following commands on a head node (not compute note!):

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

* On local machine: `% source init_intel_opencl.sh`

Flow:

* Emulation: `make emu BOARD=a10gx`
