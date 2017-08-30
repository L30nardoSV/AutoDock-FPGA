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
| Configuration     |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :---------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs     | 367.67       | 59.49            |  0.161    | ~ 6.18x slower | 
| 3ptb, 100 runs    | 3632.54      | 586.27           |  0.161    | ~ 6.19x slower |

Speedup is independent from the number of runs as parallelization is explotied within a single run.

### Measurements from instrumented program 

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
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
| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   97%        |
| ALUTs                                |   41%        |
| Dedicated logic registers            |   57%        |
| Memory blocks                        |   91%        |
| DSP blocks                           |   37%        |


### Measurements from non-instrumented program

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 100 runs   | 2979.04      | 586.27           | 0.197     | ~ 5.08x slower |


### Measurements from instrumented program 

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  346.43      | 59.49            | 0.172     | ~ 5.82x slower | 








## `third_run_harp2`

* Remove `cnt` passed by channels. It is not being used at all.

This optimization step consists of reducing the scope of variable to the deepest scope possible.

** Krnl_Conform **

* `char mode;` moved inside `while(active)`
* `char IC_mode, GG_mode, LS_mode, Off_mode = 0;` removed because was not used at all
* `char IC_active, GG_active, LS_active, Off_active;` moved inside `while(active)` + removal of assignment `IC_active = 0;` and similar
* `bool IC_valid = false;` and similar moved inside `while(active)` + removal of assignment `IC_valid = false;` and similar
* `float phi, theta, genrotangle` moved inside `while(active)` right to its first assignment
* `float genrot_unitvec [3]` moved inside `while(active)` right to its first assignment
* `int rotation_list_element;` moved inside `while(active)` right to its first assignment
* `uint atom_id, rotbond_id;` moved inside `while(active)` right to its first assignment
* `float atom_to_rotate[3];` moved approprietely inside `while(active)`
* `float rotation_unitvec[3];`  moved approprietely inside `while(active)`
* `float rotation_movingvec[3];` moved approprietely inside `while(active)`
* `float rotation_angle;` moved approprietely inside `while(active)`
* `float sin_angle;` moved inside `while(active)` right to its first assignment
* `float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;` moved approprietely inside `while(active)`
* `float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;` moved approprietely inside `while(active)`

** Krnl_InterE **

* `char mode;` moved inside `while(active)`
* `float interE` moved inside `while(active)` right to its first assignment
* `float partialE1, partialE2, partialE3;` moved one level deeper than `interE`
* `char atom1_typeid;` moved inside `while(active)` right to its first assignment
* `float x, y, z;` moved inside `while(active)` right to its first assignment
* `float q;` moved inside `while(active)` right to its first assignment
* `float dx, dy, dz;` moved inside `while(active)` right to its first assignment
* `unsigned int  cube_000, cube_100, cube_010, cube_110;` moved inside `while(active)` right to its first assignment
* `unsigned int  cube_001, cube_101, cube_011, cube_111;` moved inside `while(active)` right to its first assignment
* `float cube [2][2][2];` moved inside `while(active)` right to its first assignment
* `float weights [2][2][2];` moved inside `while(active)` right to its first assignment
* `int x_low, x_high, y_low, y_high, z_low, z_high;` moved inside `while(active)` right to its first assignment
* `unsigned int  mul_tmp;` moved inside `while(active)` right to its first assignment
* Declarations of `g1`, `g2`, `g3` removed. Instead of them, `DockConst_g1` are directly used
* `unsigned int  ylow_times_g1` and similar were moved inside `while(active)` right to its first assignment

** Krnl_IntraE **
* `char mode;` moved inside `while(active)`
* `int contributor_counter;` removed as it was declared already as a ushort iteration counter
* `char atom1_id, atom2_id;` moved inside `while(active)` right to its first assignment
* `char atom1_typeid, atom2_typeid;` moved inside `while(active)` right to its first assignment
* `float subx, suby, subz, distance_leo;` moved inside `while(active)` right to its first assignment
* `float distance_pow_2` and similar were moved inside `while(active)` right to its first assignment
* `float inverse_distance_pow_12` and similar were moved inside `while(active)` right to its first assignment
* `float intraE;` moved inside `while(active)`
* `float partialE1, partialE2, partialE3, partialE4;` moved one level deeper than `intraE`
* `char ref_intraE_contributors_const[3];` moved inside `while(active)`

** Estimated resource usage **
| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   96%        |
| ALUTs                                |   40%        |
| Dedicated logic registers            |   57%        |
| Memory blocks                        |   89%        |
| DSP blocks                           |   37%        |

### Measurements from non-instrumented program

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |    305.04    | 59.49            |   0.195   | ~ 5.13x slower |


### Measurements from instrumented program 

** Execution time (s) **
| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  338.88      | 59.49            |   0.175   | ~ 5.69x slower | 
