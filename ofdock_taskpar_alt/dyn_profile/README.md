# Optimizing docking with the Intel-FPGA-SDK-for-OpenCL **Dynamic Profiler GUI**

To be used for analysis.

# Description

This folder stores files containing profiling information when executing the docking program on HARP2 FPGA.

The general command to display profiling info is:

```zsh
aocl report docking.aocx profile.mon
```

* `docking.aocx` is the kernel binary that contains performance counters.
* `profile.mon` is the monitor file obtained after running the previous kernel in the HARP2 machine.


# Folders

## `first_run_harp2`

First version running correctly on hardware.

### Measurements from non-instrumented program

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
|:----------------:|:------------:|:----------------:|:---------:|:--------------:|
| 3ptb, 10 runs    | 367.67       | 59.49            |  0.161    | ~ 6.18x slower | 
| 3ptb, 100 runs   | 3632.54      | 586.27           |  0.161    | ~ 6.19x slower |

Speedup is independent from the number of runs as parallelization is explotied within a single run.

### Measurements from instrumented program 

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
|:----------------:|:------------:|:----------------:|:---------:|:--------------:|
| 3ptb, 10 runs    | 392.30       | 59.49            | 0.151     | ~ 6.59x slower | 
| 3ptb, 100 runs   | 3922.74      | 586.27           | 0.149     | ~ 6.69x slower |






### Improvements





## `second_run_harp2`

* Convert the constant `DockConst` kernel argument, into a bunch of private arguments.
 
This will make the host code much more verbose, but will remove the access to constant in kernel.

* Change value of `DockConst->gridsize_x` passed to kernel, so pass `gridsize_x - 1` instead of `gridsize_x`. Do the same with y and z args as `Krnl_InterE` uses `grid_size - 1`.

* Change the properties of `GlobEvalsGenerations_performed` in host code, from `CL_MEM_READ_WRITE` into `CL_MEM_WRITE_ONLY`.

* In `Krnl_InterE`, change specifier of GlobFgrids from `__global` to `__constant` as HARP2 FPGA has `CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE` of 70 368 744 177 664 bytes.

** Estimated resource usage **
+--------------------------------------------------------------------+
; Estimated Resource Usage Summary                                   ;
+----------------------------------------+---------------------------+
; Resource                               + Usage                     ;
+----------------------------------------+---------------------------+
; Logic utilization                      ;   97%                     ;
; ALUTs                                  ;   41%                     ;
; Dedicated logic registers              ;   57%                     ;
; Memory blocks                          ;   91%                     ;
; DSP blocks                             ;   37%                     ;
+----------------------------------------+---------------------------;

### Measurements from non-instrumented program

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
|:----------------:|:------------:|:----------------:|:---------:|:--------------:|
| 3ptb, 100 runs   | 2979.04      | 586.27           | 0.197     | ~ 5.08x slower |


### Measurements from instrumented program 

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
|:----------------:|:------------:|:----------------:|:---------:|:--------------:|
| 3ptb, 10 runs    |  346.43      | 59.49            | 0.172     | ~ 5.82x slower | 








## `third_run_harp2`

