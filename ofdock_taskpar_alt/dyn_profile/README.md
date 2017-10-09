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

### Execution time (s) measurements from non-instrumented program

| Configuration     |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :---------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs     | 367.67       | 59.49            |  0.161    | ~ 6.18x slower | 
| 3ptb, 100 runs    | 3632.54      | 586.27           |  0.161    | ~ 6.19x slower |

Speedup is independent from the number of runs as parallelization is explotied within a single run.

### Execution time (s) measurements from instrumented program 

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

**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   97%        |
| ALUTs                                |   41%        |
| Dedicated logic registers            |   57%        |
| Memory blocks                        |   91%        |
| DSP blocks                           |   37%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 100 runs   | 2979.04      | 586.27           | 0.197     | ~ 5.08x slower |

### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  346.43      | 59.49            | 0.172     | ~ 5.82x slower | 








## `third_run_harp2`

* Remove `cnt` passed by channels. It is not being used at all.

This optimization step consists of reducing the scope of variable to the deepest scope possible.

**Krnl_Conform**

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

**Krnl_InterE**

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

**Krnl_IntraE**

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

**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   96%        |
| ALUTs                                |   40%        |
| Dedicated logic registers            |   57%        |
| Memory blocks                        |   89%        |
| DSP blocks                           |   37%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |    305.04    | 59.49            |   0.195   | ~ 5.13x slower |

### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  338.88      | 59.49            |   0.175   | ~ 5.69x slower | 



## `fourth_run_harp2`

**Krnl_GA**

* Increase depth to `MAX_POPSIZE` of channels `interE` and `interE` to avoid stall at all cost between (`Krnl_IntraE`, `Krnl_InterE`) and `Krnl_GA`
* Refactor IC for-loop so it can be fully pipelined. Data from `interE` and `intraE` channels are separated in another for-loop, and potentially can be read faster as such channels have now depth different than 0
* Refactor IC for-loop so data from global memory is copied directly to channels without using and intermediate __local array. This led to the removal of `genotype_tx`
* Refactor GG for-loop in a similar way IC for-loop was. This led to correct the corresponding update of `GlobEnergyNext` after GG
* Create `energyIA_LS_rx_dummy` and `energyIE_LS_rx_dummy` dummy vars so dependencies on `energyIA_LS_rx` and `energyIE_LS_rx` can be relaxed.
* Reduced scope of `energyIA_LS_rx`, moved inside right to its first assignment
* Reduced scope of `entity_for_ls`, moved inside right to its first assignment
* Reduced scope of `offspring_energy`, moved inside right to its first assignment
* Reduced scope of `candidate_energy` moved inside right to its first assignment
* Reduced scope of `LS_eval` moved inside right to its first assignment

**Krnl_Conform**

* Removal of `ref_orientation_quats_const_0` and similar from `Krnl_Conform`. This requires setting additional kernel args in host and passing their values as private


**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   96%        |
| ALUTs                                |   40%        |
| Dedicated logic registers            |   56%        |
| Memory blocks                        |   88%        |
| DSP blocks                           |   37%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  312.48      | 59.49            | 0.190     | ~ 5.25x slower |

### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  324.56      | 59.49            | 0.183     | ~ 5.45x slower | 







## `fifth_run_harp2`

**Krnl_GA**

* Copy `loc_energies` to a private array `tmp_energy` before finding the best entity, this reduces II from 11 downto 6
* `LS` genotype update was simplified to reduce code inside conditional
* Removed write `to GlobPRNG[0]` because it was never needed. Host passes a new prng number on every docking run, so the prng number is passed to `Krnl_GA` as a private arg instead of global

**auxiliary_genetic.cl**

* `myrand` included an explicit convert_float enclosing a multiplication. This is changed with an implicit conversion of only `*prng`. This reduces the II from 24 downto 16 in the latest `gen_new_genotype` for-loop (index: 5 -ACTUAL_GENOTYPE_LENGTH)

**Krnl_Conform**

* Added a local memory as a cache for `KerConstStatic->rotlist_const`. This should resolved bottleneck shown by the profiler


** Estimated resource usage **

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |  95 %        |
| ALUTs                                |  40 %        |
| Dedicated logic registers            |  56 %        |
| Memory blocks                        |  88 %        |
| DSP blocks                           |  36 %        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |   282.95     | 59.49            |   0.210   | ~ 4.75x slower |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  296.88      | 59.49            | 0.200     | ~ 4.99x slower | 


## `sixth_run_harp2`

* In `Krnl_Conform`, `Krnl_InterE`, and `Krnl_IntraE` pass arrays separately instead of including them in a struct (as originally). Declare these as `__constant` kernel arguments. This implies modifying host too.

**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   84%        |
| ALUTs                                |   34%        |
| Dedicated logic registers            |   50%        |
| Memory blocks                        |   64%        |
| DSP blocks                           |   36%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |   276.23     | 59.49            |  0.215    | ~ 4.64x slower |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |   302.54     | 59.49            | 0.196     | ~ 5.08x slower | 










## `seventh_run_harp2`

**Krnl_GA**

* Upper bound of loops over ALL entity elements (ACTUAL_GENOTYPE_LENGTH genes) are changed approprietely to "DockConst_num_of_genes". The aim is to reduce the latency of the for loop while keeping throughput (II = 1)

* Remove sending of "mode" through channel from `Knrl_GA` to `Krnl_Conform`, as it is enough for `Krnl_Conform` to know which `mode` is enabled by reading `active`

* In ** auxiliary_genetic.cl ** / `gen_new_genotype()` add `DockConst_num_of_genes` as argument and replace upper bounds of loops as previously


**Krnl_Conform** 

* Add the argument `DockConst_num_of_genes` so reduction of loop latency can be attempted in this kernel too

* Remove receiving of "mode" through channel from `Knrl_GA` to `Krnl_Conform`, as it is enough for `Krnl_Conform` to know which `mode` is enabled by reading `active`

**Krnl_IntraE**

* Reduce computation inside conditional statement `if (ref_intraE_contributors_const[2] == 1)	//H-bond`


**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   84%        |
| ALUTs                                |   34%        |
| Dedicated logic registers            |   50%        |
| Memory blocks                        |   63%        |
| DSP blocks                           |   36%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 258.59       | 59.49            | 0.230     | ~ 4.34x slower |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 295.76       | 59.49            | 0.201     | ~ 4.97x slower | 















## `eigth_run_harp2`

**Krnl_GA**

* Send genotypes faster from `Krnl_GA` to `Knrl_Conform` during `GG` by using two different for-loops for updating `GlobPopulationNext`, and writing genes to `chan_GG2Conf_genotype`

* Increase the number of variables that hold the `prng` variable in order to avoid data dependence on this variable as much as possible. This requires sending _twenty_ random numbers from host, and then distributing _ten_ to `GG`, and _ten_ to `LS`. this implies passing to global instead to private


**Krnl_Conform**

This is added but commented in the code because it didn't improve loop II, and even increase area usage.
~~* Merge local memories `loc_coords_x`, `loc_coords_y`, and `loc_coords_z` into `loc_coords`, so number of load operations is reduced. The merged local memory is banked to enable parallel access~~

**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   85%        |
| ALUTs                                |   35%        |
| Dedicated logic registers            |   51%        |
| Memory blocks                        |   68%        |
| DSP blocks                           |   36%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 266.47       | 59.49            | 0.223     | ~ 4.47x slower |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 312.61       | 59.49            |  0.190    | ~ 5.41x slower | 











## `9_run_harp2`

It seems changes made in `eigth_run_harp2` were not so effective in terms of performance. We start by undoing things or relaxing changes.

**Krnl_GA**

* From `eigth_run_harp2`: ~~Send genotypes faster from `Krnl_GA` to `Knrl_Conform` during `GG` by using two different for-loops for updating `GlobPopulationNext`, and writing genes to `chan_GG2Conf_genotype`~~. Merge these loops back again

* From `eigth_run_harp2`: ~~Increase the number of variables that hold the `prng` variable in order to avoid data dependence on this variable as much as possible. This requires sending _twenty_ random numbers from host, and then distributing _ten_ to `GG`, and _ten_ to `LS`. this implies passing to global instead to private~~. Use only _six_ prng variables and pass them from host to device as private

* In `IC` merge loop that receives energy values and loop that stores sum in `GlobEnergyCurrent` as II = 1 in the merged loop

* Enable parallel access to `loc_energies` by defining instead two __local arrays `loc_energies1` and `loc_energies2`. This is used to access two __local arrays containing the same data (energies) and avoid serial access that would be required when having only one array, Arrays are passed to `find_best` and `binary_tournament_selection`



>>>
**NOTICE**
At this run, we identified the causes on why GG loop was not pipelined.
* `map_angle_` functions: due to their while-loops
* `gen_new_genotype`: crossover and mutation conditional code inside for loops 
>>>




* Replacement of `while-` by `if-statements` in `map_angle_*` functions. This change seems to not degrade the quality of results so far. Its advantage is the considerable area-usage reduction BUT THE CORRECTNESS OF THIS STEP MUST BE CHECKED AGAIN!!!

*  `gen_new_genotype`: mutation loop with a conditional code inside `for (uchar i=5; i<num_genes; i++)` was unroll with factor  **2** to allow GG loop to be pipelined. Unrolling with a higher factor increases utilization up tp 95% and II = 191

* `gen_new_genotype`: crossover loops were merged into a single one so all crossover cases are covered in a compact statement, and it was fully unrolled

* `gen_new_genotype`: mutation logic and loops were merged into a single loop, and it was fully unrolled

* `gen_new_genotype`: loop that copies internal genotype `priv_offspring_genotype` into output genotype `offspring_genotype` was fully unrolled

* The input genotypes of `gen_new_genotype` such as `local_entity_1` and `local_entity_2` were configured with 3 read ports and 1 write port.



**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   91%        |
| ALUTs                                |   37%        |
| Dedicated logic registers            |   55%        |
| Memory blocks                        |   72%        |
| DSP blocks                           |   56%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  267.59      | 59.49            | 0.222     | ~4.49x slower  |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 275.88       | 59.49            | 0.215     | ~4.63x slower  | 










## `10_run_harp2`

Reduction of execution time was not achieved with previous changes. It was possibly due to the II = 165 of GG. The idea in this optimization is to play around with unrolling, pipelining, so II gets down to the minimum possible.


* In `gen_new_genotype` loops are re-configured with unrolling or pipeling so II (GG) gets reduced. It was possible to reduce it from II (GG) = 165 down to II (GG) = 18

* While loop inside `LS` was recoded so loops are unconditional as much as possible. Now `LS` supports two sets of channels, one for positive and another for negative descent. Adding one set of channels implies adding the logic in the other kernels too.





**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   83%        |
| ALUTs                                |   34%        |
| Dedicated logic registers            |   50%        |
| Memory blocks                        |   70%        |
| DSP blocks                           |   36%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 245.06       | 59.49            | 0.243     | ~4.11x slower  |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 284.09       | 59.49            | 0.209     | ~4.77x slower  | 
























## `11_run_harp2`

The idea here is to pipelined `LS` _at all cost_.

* In `LS`, the exit condition of the while loop is based on `iteration_cnt` and `rho`. `rho` is one obstacle for pipelining as its value is determined originally at the end of the loop, so NO new iteration can be launched when the current iteration is being processed. That's why the calculation of `rho` has been moved at the beginning of such while loop. The correctness of this relies on the initial values of `rho`, `cons_succ`, `cons_fail`

* The update of `offspring_genotype` and `genotype_bias` is done with for-loops which are enclosed by if-statements. Conditional execution of loops prevents their pipelining. **The corresponding for-loops were fully unrolled so while-loop (LS) is pipelined with II = 9, and the main LS loop with II = 3**. Unrolling in such manner causes area usage of 130%!!

* In `GG` `local_entity_1` and `local_entity_2` were changed to `__local` (default) instead of memories with 3 read ports, as the latter left unsued ports 

* `active` variable is removed, and values (char: `1` o `0`) are directly written to "activation" channels

* `positive_new_genotype` and `negative_new_genotype` declarations are moved inside while(LS) loop to reduce area usage

* `genotype_deviate` declaration is moved inside while(LS) loop to reduce area usage

* `genotype_bias` declaration moved inside for(LS) to reduce area usage

* `float rho = 1.0f;` declaration moved inside for(LS) to reduce area usage. It implies removing update after while(LS)

* `uint iteration_cnt = 0;` declaration moved inside for(LS) to reduce area usage. It implies removing update after while(LS)

* `uint cons_succ = 0;` and `uint cons_fail = 0;` declarations moved inside for(LS) to reduce area usage




**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    | 148 %        |
| ALUTs                                |  54 %        |
| Dedicated logic registers            |  93 %        |
| Memory blocks                        | 139 %        |
| DSP blocks                           |  43 %        |


**ATTEMPT TO BUILD FAILED**







Compilation failed: it throws an error message "Evaluation of Tcl script import_compile.tcl unsuccessful". 
At this point it is assumed that over utilization is the cause. We aim to reduce resources:

* Memory blocks are scarce, they are consumed by local memory. Try to declare arrays in the deepest scope possible, and implement small arrays with private memory

* Reduce the type of non-kernel function arguments such as from `int` to `short`, i.e. `pop_size`

>>> Up to here:  `Logic utilization: 144% ` and `Memory blocks: 139%`

* Reduce max. number of rotatblt bonds from 32 downto `#define MAX_NUM_OF_ROTBONDS 	10`

>>> Up to here:  `Logic utilization: 126% ` and `Memory blocks: 84%`

* In `Krnl_GA`: implement arrays (which were already moved to the deepest possible scope) as local variables including the `memory` attribute and multiple ports, singlepump. Try different number of read and write ports, so no ports are left unused and area usage is reduced as much as possible

* In `Krnl_IntraE`: implement local arrays inside the main `while(active)` loop, and make it compact, including the `memory` attribute and multiple ports, singlepump. Try two banks. Try different number of read and write ports, so no ports are left unused and area usage is reduced as much as possible

* In `Krnl_InterE`: implement local arrays inside the main `while(active)` loop, and make it compact, including the `memory` attribute and multiple ports, singlepump. Try two banks. Try different number of read and write ports, so no ports are left unused and area usage is reduced as much as possible

>>> Up to here:  Banking of local memory in `Krnl_IntraE` and `Krnl_InterE` was the solution to pipeline such kernels **perfectly**


* In `Krnl_InterE`: implement local arrays inside the main `while(active)` loop. No performance degradation was caused, neither improvement in area usage

>>> Up to here:  `Logic utilization: 105% ` and `Memory blocks: 92%`

* For mode `Off` or `5`, it is actually not needed to send "dummy" genotypes. Removed corresponding channels and logic in `Krnl_GA` and `Krnl_Conform`

>>> Up to here:  `Logic utilization: 105% ` and `Memory blocks: 91%`


**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |  105%        |
| ALUTs                                |   40%        |
| Dedicated logic registers            |   64%        |
| Memory blocks                        |   91%        |
| DSP blocks                           |   39%        |


**ATTEMPT TO BUILD FAILED**

Error: Compiler Error, not able to generate hardware (SAVED in GitLab )
It is confirmed that over utilization is the cause. We aim to further reduce resources

* For mode `Off` or `5`, it is actually not needed to receive "dummy" energiess. Removed corresponding channels and logic in `Krnl_GA`, `Krnl_InterE`, and `Krnl_IntraE`

>>> Up to here:  `Logic utilization: 104% ` and `Memory blocks: 91%`

* Reduce number of conditional calculation inside conditional for-loops by relocating `genotype_bias`

>>> Up to here:  `Logic utilization: 103% ` and `Memory blocks: 91%`

* Replace `DockConst_num_of_genes` upper bounds of some loops with `ACTUAL_GENOTYPE_LENGTH` to reduce hw but keeping same pipelining

>>> Up to here:  `Logic utilization: 102% ` and `Memory blocks: 91%`


**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |  102%        |
| ALUTs                                |   40%        |
| Dedicated logic registers            |   63%        |
| Memory blocks                        |   91%        |
| DSP blocks                           |   40%        |


Error: Compiler Error, not able to generate hardware.
It is confirmed that over utilization is the cause. We aim to further reduce resources




* Switched to old `crossover implementation` which leads to **non-pipelined GG** + **pipelined LS** but reduces area usage


**Estimated resource usage**

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   99%        |
| ALUTs                                |   39%        |
| Dedicated logic registers            |   60%        |
| Memory blocks                        |   87%        |
| DSP blocks                           |   40%        |

Error: Compiler Error, not able to generate hardware.
It is confirmed that over utilization is the cause. We aim to further reduce resources



* Channel for transmitting `active` signals are changed from `char` to `bool` type

* Use bit-masking on some values such as `mode`

* Reduce type of `entity_for_ls` from `uint` to `ushort`
* Reduce type of `iteration_cnt` from `uint` to `ushort` (max. value it reaches is 300)
* Reduce type of `cons_succ` from `uint` to `uchar` (max. value it reaches is 4)
* Reduce type of `cons_fail` from `uint` to `uchar` (max. value it reaches is 4)
* Reduce type of `best_entity_id` from `uint` to `ushort`
* Reduce type of `parent1` from `uint` to `ushort`
* Reduce type of `parent2` from `uint` to `ushort`
* Reduce type of `covr_point_low` from `uint` to `uchar`
* Reduce type of `covr_point_high` from `uint` to `uchar`
* Reduce type of `temp1` from `uint` to `uchar`
* Reduce type of `temp2` from `uint` to `uchar`
* Replace `myrand_uint` by either `myrand_ushort` or `myrand_uchar` accordingly
* Remove caching of `__constant` memory in `Krnl_InterE`, as it was not done either in `Krnl_IntraE`
* Switched back to **pipelined GG (II=18)**
* Evaluation of `eval_cnt` and `generation_cnt` is moved at the very beginning of main while loop (Something very similar was done with LS while-loop). This allows pipelining basically everything!

>>> 
Macro `PIPELINE_ALL` is added
When enabled, `main while-loop`(II=2), `GG`(II=18) and `LS`(II(main)=2, II(inner)=9) are all pipelined
`Logic utilization: 108% ` and `Memory blocks: 98%`
>>> 

>>>
Macro `PIPELINE_ALL` is added
When disabled, only `GG`(II=18) is pipelined, but `LS` is not pipelined, and therefore `main while-loop` is not pipelined
`Logic utilization: 87% ` and `Memory blocks: 79%`
>>> 

Another try but disabling `PIPELINE_ALL`

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   87%        |
| ALUTs                                |   35%        |
| Dedicated logic registers            |   52%        |
| Memory blocks                        |   79%        |
| DSP blocks                           |   36%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 271.84       | 59.49            | 0.219     | ~4.56x slower  |


### Execution time (s) measurements from instrumented program 

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 287.34       | 59.49            | 0.207     | ~4.83x slower  | 
















## `12_run_harp2`


* Small pipelined-loops have to be switched back to variable upper bound rather then the constant `ACTUAL_GENOTYPE_LENGTH`. Also to those loops depending on `PIPELINE_ALL`

* Update of `iteration_cnt` in `LS` moved close to the update of `cons_succ` and `cons_fail` at the beginning of `LS` while-loop

* Merge for-loops that update `positive_new_genotype` and `negative_new_genotype`. Requires to reduce read ports to 2 of `offspring_genotype`

* Clean up of `binary_tournament_selection`

* To reduce `GG` II, pass 6 prng variables to `binary_tournament_selection`. Reduces II=18 downto II=3 

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   87%        |
| ALUTs                                |   35%        |
| Dedicated logic registers            |   52%        |
| Memory blocks                        |   78%        |
| DSP blocks                           |   36%        |




### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 272.69       | 59.49            | 0.218     | ~4.58x slower  |


### Execution time (s) measurements from instrumented program 
Execution of this instrumented version appears to hang :( ...




## `13_run_harp2`

* Avoid contiditional code by using ternary operator or conditional inside for-loops in `LS`
* Remove `PIPELINE_ALL` as it is no more necessary to unroll
* Re-enable `#define MAX_NUM_OF_ROTBONDS 32`
* In `Krnl_Conform` make for-loops of `genotype` unconditional using ternary operator

>>> 
`main while-loop`(II=2), `GG`(II=3) and `LS`(II(main)=2, II(inner)=9) are all pipelined
`Logic utilization: 105% ` and `Memory blocks: 91%`
It is still too large, but much better in terms of performance and area than previous designs
>>> 

This is saved in GitLab, but the next move is to reduce resource utilization by switching back to one channel in LS, taking advantage of ternary operator.










## `14_run_harp2`

The goal is to start with previous version and switch it back to LS-implementation with one channel for both directions so area utilization is reduced.

* Replaced LS implementation (with channels for positive and negative descent) with only one channel for both directions. The reference is `seventh_run_harp2`. This involves removing `positive_new_genotype` and `positive_new_genotype` arrays, and enabling back `entity_possible_new_genotype` array.

* `ushort rand_ls_entities [16];` moved outside main while-loop and declared as `_local`, in that it uses less logic. A similar procedure is used for re-locating other arrays.


| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   95%        |
| ALUTs                                |   37%        |
| Dedicated logic registers            |   58%        |
| Memory blocks                        |   85%        |
| DSP blocks                           |   35%        |

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  287.49      | 59.49            | 0.207     | ~4.83x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  301.64      | 59.49            | 0.197     | ~5.07x slower  |















## `15_run_harp2`

In order to increase performance: improving pipelining keeping same area usage.

* Increase depth for energies comming back during `LS` but only to 6% of MAX_POP ~ < 20 (in case population size raises up to 300)
* Enable SIMD in `Knrl_Conform`. It requires modifying the host accordingly
* Add a local array `prngLS` so small for-loops can be pipeline with II=1 instead of II=3
* Crossover loop has been pipelined (II=1) instead of unrolled


| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   95%        |
| ALUTs                                |   37%        |
| Dedicated logic registers            |   58%        |
| Memory blocks                        |   81%        |
| DSP blocks                           |   35%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  287.80      | 59.49            | 0.207     | ~4.84x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 315.60       | 59.49            | 0.188     | ~5.30x slower  |










## `16_run_harp2`

* Clean up in auxiliary_genetic(), basically removing optional code for `REPRO`

* myrand() functions implementation is changed to LFSR (Galois32 bits) (https://en.wikipedia.org/wiki/Linear-feedback_shift_register). The coefficients are taken from here: https://web.archive.org/web/20161007061934/http://courses.cse.tamu.edu/csce680/walker/lfsr_table.pdf

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   95%        |
| ALUTs                                |   37%        |
| Dedicated logic registers            |   58%        |
| Memory blocks                        |   81%        |
| DSP blocks                           |   32%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 333.73       | 59.49            |      | ~x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 305.55       | 59.49            |      | ~x slower  |



Results are strange here as they were supposed to be better with a LFSR.





## `17_run_harp2`


* Clean up a bit in `Krnl_Conform` usage of cossin, operations moved outside main loop
* Create six kernels for PRNGs. It requires creating kernels in host
* Moved moce from `binary_tournament` and `gen_new_generation` to `Krnl_GA`

>>>
The order of the operands in the prng calculation can change the clustering quality. 

In this version clustering quality is negatively affected.
>>>

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   97%        |
| ALUTs                                |   38%        |
| Dedicated logic registers            |   59%        |
| Memory blocks                        |   82%        |
| DSP blocks                           |   31%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 294.25      | 59.49            |      | ~x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  311     | 59.49            |      | ~x slower  |






THIS WAS NOT SAVED BECAUSE RESULTS ARE WORSE









## `18_run_harp2`

* Added and Arbiter kernel so prng kernels can be fully pipelined
* Remove active channels in `GA` (those that go from `IC`, `GG`, `LS` to `Krnl_Conform`) as these are not needed. `Krnl_Conform` was also updated
* In `LS` and `GG`, group more computation inside single for-loops as much as possible. That way, even if only one-iteration of containing loop is executed, there will be less of these serialized regions
* Use shift registers to reduce II in finding `best_entity`


| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   87%        |
| ALUTs                                |   35%        |
| Dedicated logic registers            |   52%        |
| Memory blocks                        |   75%        |
| DSP blocks                           |   29%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  267         | 59.49            | 0.222     | ~4.48x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 316    | 59.49            |      | ~x slower  |




>>>
By a typing mistake `18_run_harp2` version was initially saved as `19_run_harp2`, this error was latter corrected.
Anyway, in order to avoid mistakes, `19_run_harp2` is not created and the `20` version is the next one
>>>




















## `20_run_harp2`
* Cleanup: remove struct definition in `Krnl_GA` which are not needed anymore
* Merged for-loops in `IC` to improve pipelining
* Merged for-loops in `GG` to improve pipelining
* Removed `ls_pass_complete` from `LS` as `positive_direction` appears to be enough
* Moved both `map_angle` functions to `Krnl_GA`, i.e. `auxiliary_genetic.cl` is not invoked anymore
* Global memory is not accessed anymore during computation, now only local memory is used. `Next` kernel arguments are removed

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   84%        |
| ALUTs                                |   34%        |
| Dedicated logic registers            |   50%        |
| Memory blocks                        |   68%        |
| DSP blocks                           |   29%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |   267.70     | 59.49            | 0.222     | ~4.5x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |   280.05     | 59.49            |      | ~x slower  |




















## `21_run_harp2`

* Remove `offspring_energy` in `LS` and use simply the local variable `LocalEneNext[entity_for_ls]`
* Remove `offspring_genotype` in `LS` and use simply the local variable `LocalPopNext[entity_for_ls][i & 0x3F]`
* Initialize `genotype_bias[i] = 0.0f` differently, i.e. using ternary operator depending on `iterator_cnt`

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   80%        |
| ALUTs                                |   33%        |
| Dedicated logic registers            |   48%        |
| Memory blocks                        |   64%        |
| DSP blocks                           |   29%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  267.67      | 59.49            |      | ~x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |        | 59.49            |      | ~x slower  |









## `22_run_harp2`

* Replace `0.6f` instead on `0.6` in `LS` `genotype_bias` calculation (0.6 means double while 0.6f means float)
* In `LS`, multiplication of `4.0f` by `genotype_deviate[i]` is moved inside loop before channel read
* Add statement to init correctly `genotype_bias` (missing in previos commit)

BAD IDEA
It is commented out before commiting
* Transform second loop into a conditional execution of unrolled loops


Using BAD IDEA

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   98%        |
| ALUTs                                |   38%        |
| Dedicated logic registers            |   60%        |
| Memory blocks                        |   87%        |
| DSP blocks                           |   34%        |


### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    | 318.04       | 59.49            |      | ~x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |        | 59.49            |      | ~x slower  |



After commenting BAD IDEA:

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   81%        |
| ALUTs                                |   33%        |
| Dedicated logic registers            |   48%        |
| Memory blocks                        |   64%        |
| DSP blocks                           |   29%        |







## `23_run_harp2`

Idea: replicate LS while-loop as this seems to be serial and unlikey to be further optimized.
But first, `LS` is separated an made a kernel.

* Prngs for `LS` are generated all in a sequence.
* Re-enabled `Krnl_LS` which executes only LS while-loop
* Added a kernel for enabling `LS` kernel

Notice that logic utilization is further reduced:

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   78%        |
| ALUTs                                |   32%        |
| Dedicated logic registers            |   46%        |
| Memory blocks                        |   62%        |
| DSP blocks                           |   29%        |


Working frequency is 213.3MHz

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  252.25      | 59.49            |      | ~4.24x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |  262.11      | 59.49            |      | ~x slower  |



## `24_run_harp2` (fits only in the a10gx)

Idea: replicate LS while-loop as this seems to be serial and unlikey to be further optimized.

* Replicate for `LS2`:  `Krnl_LS2`, `Krnl_LS2_Arbiter`, `Krnl_Conform2`, `Krnl_InterE2`, `Krnl_IntraE2`
* Add needed logic so I doesn't stall
* Improve code in `LS` for-loop
* In `Krnl_Conform` and `Krnl_Conform2`, include the multiplication by `DEG_TO_RAD` inside the initial while-loop

CHECK THIS
* Use `#pragma ivdep` to remove loop-carried dependencies caused by accesses to memory arrays (might improve II and reduce hw)




| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   95%        |
| ALUTs                                |   39%        |
| Dedicated logic registers            |   57%        |
| Memory blocks                        |   84%        |
| DSP blocks                           |   45%        |


Working frequency is 213.3MHz

### Execution time (s) measurements from non-instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |        | 59.49            |      | ~x slower  |


### Execution time (s) measurements from instrumented program

| Configuration    |    FPGA      |  CPU (AutoDock)  |  Speed-up | Comments       |
| :--------------: | :----------: | :--------------: | :-------: | :------------: |
| 3ptb, 10 runs    |        | 59.49            |      | ~x slower  |

>>>
It does NOT fit in the bdw, but fits in the a10gx
>>>

hw utilization in the a10gx 

| Resource                             | Usage        |
| :----------------------------------: | :----------: |
| Logic utilization                    |   50%        |
| ALUTs                                |   25%        |
| Dedicated logic registers            |   27%        |
| Memory blocks                        |   54%        |
| DSP blocks                           |   30%        |



