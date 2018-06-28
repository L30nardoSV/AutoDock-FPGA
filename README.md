# Set SDAccel up

```zsh
source /opt/cad/xilinx/sdx/SDx/2017.4/settings64.sh
```

# Documentation

## Tool used in this branch
A detailed explanation can be found in:

[SDAccel Environment Tutorial: Introduction (UG1021)](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1021-sdaccel-intro-tutorial.pdf) -> Chapter 2 (_Flow Overview_) -> Lab 2 (_Introduction to the SDAccel Makefile_)

## Latest tool available (online)

[SDAccel Development Environment Help](https://www.xilinx.com/html_docs/xilinx2018_2/sdaccel_doc/zrq1526323398130.html)


# Important commands

* See basic rules under [Makefile](./ofdock_taskpar_xl/Makefile)
* See user compilation flags under [boards.mk](./common_xilinx/utility/boards.mk)
* See OpenCL ICD options under [opencl.mk](./common_xilinx/libs/opencl/opencl.mk)

## SW and HW Emulation

```zsh
make swemu
```

```zsh
make hwemu
```

## FPGA building

```zsh
make hw
```

## Where to find reports

A Makefile flow is used. A system estimate can be generated this way:

```zsh
make kerrpt-sw
```

* A [`sdaccel_ini`](./ofdock_taskpar_xl/sdaccel.ini) was created to generate additional reports

* The `sdaccel.ini` has a specific format which is documented in:

[SDAccel Environment User Guide (UG1023)](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1023-sdaccel-user-guide.pdf) -> Appendix H (_Using the Runtime Initialization File_)

## FPGA evaluation on remote server

```zsh
make eva
```

Contrary to the other Altera-based branches, this rule is not set as `make exe`

This is because another `exe` rule is already used internally by the scripts provided by SDAccel.
