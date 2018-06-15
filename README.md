# Set SDAccel up

```zsh
source /opt/cad/xilinx/sdx/SDx/2017.4/settings64.sh
```

# Important commands

* See basic rules under [Makefile](./ofdock_taskpar_xl/Makefile)
* See user compilation flags under [boards.mk](./common_xilinx/utility/boards.mk)
* See OpenCL ICD options under [boards.mk](./common_xilinx/libs/opencl/opencl.mk)

## Software emulation

```zsh
make swemu
```

## FPGA building

```zsh
make hw
```
