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


** Estimated resource usage **

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

** Estimated resource usage **

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

* From `eigth_run_harp2`: ~~ Increase the number of variables that hold the `prng` variable in order to avoid data dependence on this variable as much as possible. This requires sending _twenty_ random numbers from host, and then distributing _ten_ to `GG`, and _ten_ to `LS`. this implies passing to global instead to private~~. Use only _six_ prng variables and pass them from host to device as private

* In `IC` merge loop that receives energy values and loop that stores sum in `GlobEnergyCurrent` as II = 1 in the merged loop

* Enable parallel access to `loc_energies` by defining instead two __local arrays `loc_energies1` and `loc_energies2`. This is used to access two __local arrays containing the same data (energies) and avoid serial access that would be required when having only one array, Arrays are passed to `find_best` and `binary_tournament_selection`




** NOTICE **
At this run, we identified the causes on why GG loop was not pipelined.
* `map_angle_` functions: due to their while-loops
* `gen_new_genotype`: crossover and mutation conditional code inside for loops 





* Replacement of `while-` by `if-statements` in `map_angle_*` functions. This change seems to not degrade the quality of results so far. Its advantage is the considerable area-usage reduction BUT THE CORRECTNESS OF THIS STEP MUST BE CHECKED AGAIN!!!

*  `gen_new_genotype`: mutation loop with a conditional code inside `for (uchar i=5; i<num_genes; i++)` was unroll with factor  **2** to allow GG loop to be pipelined. Unrolling with a higher factor increases utilization up tp 95% and II = 191

* `gen_new_genotype`: crossover loops were merged into a single one so all crossover cases are covered in a compact statement, and it was fully unrolled

* `gen_new_genotype`: mutation logic and loops were merged into a single loop, and it was fully unrolled

* `gen_new_genotype`: loop that copies internal genotype `priv_offspring_genotype` into output genotype `offspring_genotype` was fully unrolled

* The input genotypes of `gen_new_genotype` such as `local_entity_1` and `local_entity_2` were configured with 3 read ports and 1 write port.



** Estimated resource usage **

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
| 3ptb, 10 runs    | 275.88       | 59.49            | 0.215     | ~4.63 x slower | 






















## `10_run_harp2`













