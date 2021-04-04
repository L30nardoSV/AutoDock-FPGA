# AutoDock-FPGA

OpenCL task-parallel version of AutoDock4 for Intel FPGAs.

## Tools

Steps to initialize Intel OpenCL development/deployment tools.

### DevCloud

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
