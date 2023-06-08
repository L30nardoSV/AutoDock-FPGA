# AutoDock-FPGA

OpenCL task-parallel version of AutoDock4 for Intel FPGAs.

## Tools

Steps to initialize Intel OpenCL development/deployment tools.

### DevCloud

Instructions: https://github.com/intel/FPGA-Devcloud/tree/master/main/Devcloud_Access_Instructions#50-connecting-to-servers-running-fpga-development-software

#### Summary

```
cd adfpga
source ./1_runme_first.sh
```

```
devcloud_login -b A10PAC 1.2.1 walltime=12:00:00 A10_opencl_batch.sh
```

```
devcloud_login -b S10PAC walltime=12:00:00 S10_opencl_batch.sh
```

#### Explanation (perhaps a bit outdated)

Intel tools available in DevCloud.

* First: login into the head node: `% ssh devcloud`
* Second: login into a compute node: `% devcloud_login`
* Third: set intel tools for the PAC Arria 10: `% tools_setup`

Flow:

* Emulation: `make emu` (pac_a10 is enabled by default)

### Local

* On local machine: `% source init_aoc<>.sh`

Flow:

* Emulation: `make emu BOARD=a10gx`
