This is created using the last work in the branch _gidel_.
The motivation is that any small modification in that branch was not leading to any performance improvement.
Therefore all changes in mind based on profiling-information are applied at once.
These changes are listed here:

1. `Krnl_IntraE`: forgot to replace __constant with __local atom_types_types_const.
2. `Krnl_LS2`, `Krnl_LS3`: remove unneccessary fence between intraE and interE channel read.
3. `Krnl_LS2`, `Krnl_LS3`: remove unneccessary fence between LS2Arbiter and GA2PRNG channel write.
4. `Krnl_IntraE` and `Krnl_IntraE2`: reduce number of accesses to `loc_coords` declaring it as float3.
5. `Krnl_GA`: improve BT access, replacing vector with pipelined read of prng numbers from `Krnl_Prng_BT_ushort` and `Krnl_Prng_BT_float`. `Krnl_GA`: corresponding channels were made deeper.
6. `Krnl_GA`: improve GG access, replacing vector with pipelined read of prng numbers from `Krnl_Prng_GG_uchar` and `Krnl_Prng_GG_float`. `Krnl_GA`: corresponding channels were made deeper.

freq: 185,76 MHz


7. `Krnl_InterE` and `Krnl_InterE2`: reduce number of accesses to `loc_coords` declaring it as float3. Now `loc_coords` requires only one read port.
8. `Krnl_Conform` and `Krnl_Conform2`: native functions: sin, cos
9. `Krnl_IntraE` and `Krnl_IntraE2`: native functions: exp
10. `Krnl_InterE` and `Krnl_InterE2`: transform *(GlobFgrids + a + b) --> into GlobFgrids [a + b]

freq: 197.9 MHz

11. `Krnl_GA`: remove `mem_fence(CLK_CHANNEL_MEM_FENCE)` between BT and GG writes to PRNG
12. `Knrl_Conf_Arbiter.cl`: merge for-loops for into a single one that receives `genotype2` and `genotype3`
13. `Krnl_Conform`: enclose active- and mode-related write channel statements by the for-loop of loc_coords channel statements
14. `Krnl_InterE`, `Krnl_IntraE`: enclose mode-related read channel statements by the for-loop of loc_coords channel statements
15. `Krnl_Conform2`: enclose active- and mode-related write channel statements by the for-loop of loc_coords channel statements
16. `Krnl_InterE2`, `Krnl_IntraE2`: enclose mode-related read channel statements by the for-loop of loc_coords channel statements
17. `Krnl_Conform`, `Krnl_Conform2`: clean up removing commented code
18. `Krnl_InterE`, `Krnl_InterE2`: clean up removing commented code
19. `Krnl_IntraE`, `Krnl_IntraE2`: clean up removing commented code
20. `Krnl_IntraE`, `Krnl_IntraE2`: remove `inverse_distance_pow_12/10/6` and replace it with `native_divide()`
21. `Krnl_IntraE`, `Krnl_IntraE2`: use `native_divide()` for calculating partialE3 
22. `Krnl_LS`, `Krnl_LS2`, `Krnl_LS3`: enclose LS_eval- and current_energy-related write channel statements by the for-loop of genotype channel statements
23. `Krnl_GA`: increase deep of `chan_LS2GA_LS1_eval` and `chan_LS2GA_LS1_energy` from 1 to 8 for LS, LS2, LS3

freq: 195.31 MHz

24. `Krnl_Conform2`: move genotype multiplication by DEG_TO_RAD to `Krnl_Conf_Arbiter`
25. Change name of `Knrl_Conf_Arbiter` to `Krnl_Conf_Arbiter2`
26. Create `Krnl_Conf_Arbiter` so channel read-input logic in `Krnl_Conform` is moved into it, and `Krnl_Conform` is better pipelined
27. Genotype channels are created with depth using ACTUAL_GENOTYPE_LENGTH (instead of MAX_NUM_OF_ROTBONDS+6)
28. `Krnl_Prng_Arbiter`: simplify calculation of `active`
29. `Knrl_Conf_Arbiter`: simplify calculation of `active`
30. `Knrl_Conf_Arbiter2`: simplify calculation of `active`
31. `Krnl_LS_Arbiter`: simplify read & write channel, apply loop fusion, remove local genotype
32. `Krnl_LS2_Arbiter`: simplify read & write channel, apply loop fusion, remove local genotype
33. `Krnl_LS3_Arbiter`: simplify read & write channel, apply loop fusion, remove local genotype
34. `Krnl_GA`: add pragma ivdep to for (ushort ls_ent_cnt=0; ls_ent_cnt<DockConst_num_of_lsentities; ls_ent_cnt+=3)

freq: 190.625 MHz

35. `Krnl_InterE`, `Krnl_InterE2`, `performdocking.cpp`: calculate multiplication of constants in host and pass values via kernel arguments `mul_tmp2` and `mul_tmp3`
36. `Krnl_IntraE`, `Krnl_IntraE2`, `performdocking.cpp`: calculate multiplication of constants in host and pass value via kernel arguments `square_num_of_atypes`

freq: 196.9 MHz

37. `Krnl_GA`, `Krnl_PRNG`: start BT and GG prng calculation by using one channel/simpler call instead of two (one for BT, one for GG)

freq: 177.5 MHz

38. `Krnl_GA`, `Krnl_PRNG`, `performdocking.cpp`: create `Krnl_Prng_LS2_ushort` and `Krnl_Prng_LS3_ushort` +
						  `Krnl_GA`: choosing LS entity is moved into LS ls_ent_cnt for-loop instead of having a separate for-loop

freq: 170.1 MHz

39. `Krnl_GA`: clean up, rename loop index variables to more intuitive ones
40. `Krnl_GA`: merge GG-loops (crossover, mutation, energy-calculation) so pipeline is deeper
41. `Krnl_GA`, `performdocking.cpp`: move multiplication of `two_absmaxdmov` and `two_absmaxdang` to host

freq: 195 MHz

42. `Krnl_GA`: clean up
43. `Krnl_LS`: cleanup + move definitions (rho, iteration_cnt, etc) into  if (active == true){}
44. `Krnl_LS2`: cleanup + move definitions (rho, iteration_cnt, etc) into  if (active == true){}
45. `Krnl_LS3`: cleanup + move definitions (rho, iteration_cnt, etc) into  if (active == true){}
46. `Krnl_GA`: remove `GGoffspring` local memory and replace it with private `tmp_offspring` variable
47. `Krnl_Conf_Arbiter`: simplify the calculation of `mode`

freq: 179.1 MHz

48. replace `Krnl_Conf_Arbiter`, `Krnl_Conf_Arbiter2` by `Krnl_IGL_Arbiter`
    remove `Krnl_Conform2`, `Krnl_InterE2`, `Krnl_IntraE2`
    `Krnl_LS`, `Knrl_LS2`, `Krnl_LS3`: added channels in removed files, added channel calls in LS2
    `Krnl_InterE`, `Krnl_IntraE`: redirect channels depending on new mode codes	
    cleanup `Krnl_GA`

Suggestions not tested yet
`Krnl_Conform`: apply fixed-point arithmetic to reduce II=36

