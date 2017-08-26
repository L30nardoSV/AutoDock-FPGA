Version compiled with Intel `Altera Tools 16.0` **(Quartus upgraded & patched)** and targeting `harp2` machine.

Source first: 

```zsh
source init_aoc_esa.sh
```

**ofdock_datapar_alt**: data-parallel version

**ofdock_taskpar_alt**: task-parallel version

# Update to a new branch
The FPGA program is made of 8 kernels: 

```
`GA` ->  `IC` + `GG` + `LS` -> `Conform` ->  `IE` + `IA` -> `Store`
```                            


The access to off-chip memory in order to update population and energy values is made in `GA`, `IC`, `GG`, `LS`, and `Store`.
The memory access seems to not be synchronized even though `mem_fence(CLK_GLOBAL_MEM_FENCE | CLK_CHANNEL_MEM_FENCE)` was used.

According to [this forum post](https://www.alteraforum.com/forum/showthread.php?t=56402), it is suggested to access off-chip memory using a single kernel. 

A new branch called `fusion` is created where `GA`, `IC`, `GG`, `LS`, and `Store` are merged into a single kernel `GA`.
That way the design doesn't rely anymore on `mem_fence`s.


