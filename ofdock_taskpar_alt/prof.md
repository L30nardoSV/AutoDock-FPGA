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






// This is when Gidel card was removed temporaly from sauron 
// and installed locally to a Xelera student's system


48. replace `Krnl_Conf_Arbiter`, `Krnl_Conf_Arbiter2` by `Krnl_IGL_Arbiter`
    remove `Krnl_Conform2`, `Krnl_InterE2`, `Krnl_IntraE2`
    `Krnl_LS`, `Knrl_LS2`, `Krnl_LS3`: added channels in removed files, added channel calls in LS2
    `Krnl_InterE`, `Krnl_IntraE`: redirect channels depending on new mode codes	
    cleanup `Krnl_GA`

freq: 192 MHz (NOT TESTED IN HW)


49. `calcenergy.cpp`, `performdocking.cpp`: simplify the for-loop in performdocking because not all kernel args change on every loop
50. `performdocking.cpp`, `Krnl_Conform`, pass from host to kernels `Host_num_of_rotbonds`
51. `performdocking.cpp`: calculate prng seeds outside main for-loop
52. `performdocking.cpp`: cleanup unnecesary comments

freq: 195 MHz (NOT TESTED IN HW)

53. `Krnl_PRNG.cl`: cleanup + rename arguments uniformly according to the convention used in other kernels
54. `performdocking.cpp`,
    `Krnl_GA`,
    `PRNG_GG_uchar`, `PRNG_GG_float`, `PRNG_LS_float`, `PRNG_LS2_float`, `PRNG_LS3_float`,
    `LS_Arbiter`, `LS`, `LS2_Arbiter`, `LS2`, `LS3_Arbiter`, `LS3`,
    `IGL_Arbiter`, `Conform`
			: pass data contained in dockpars.num_of_genes as unsigned char (instead of unsignes int, as max size of genotype is 38 genes)
55. `Makefile`: expand `make clean` + add flag FIXED_POINT_CONFORM 
56. `Krnl_Conform.cl`   -> replaced by `Krnl_Conform_fixedpt.cl` 
    `calcenergy.cpp`, `performdocking.cpp`: apply fixed-point 16.16 arithmetic to reduce II=36 in Conform kernels down to II= 15
57. `Krnl_Conform_fixedpt.cl` -> replaced by `Krnl_Conform.cl`: `Krnl_Conform` containes both fixed and floating point version controlled by FIXED_POINT_CONFORM flag

>>> commit "added conform with pragma fixedpt"

58. `Krnl_InterE`: add fixedpt64 support with pragmas
freq: 184 MHz

59. `Makefile`: add defines_fixedpt headers in make `copy`

>>> commit "added intere with pragma fixedpt64"

60.
IMPORTANT:
- [X] check the number of ligandintraE_contributors passed from host to kernel, final_population show zero
- [X] apply fixed point 32.32 to Krnl_Conform with NO overflow NO saturation logic (conform II = 10) -> #define OVERFLOW_AND_SATURATION

freq: 176 MHz
>>> commit "added conform no overf no sat fixedpt16.16"


61. `defines_fixedpt64.h`: change format to 32.32
62. `Krnl_InterE.cl`: use fixedpt64 with no overflow & no saturation
63. `Krnl_InterE.cl` + `performdocking.cpp`: pass GlobFgrids as floats or fixedpt64 depending on the specified precision
64. `Krnl_InterE.cl` + `performdocking.cpp` + `calcenergy.cpp`: pass KerConstStatic_atom_charges_const as floats or fixedpt64 depending on the specified precision

freq: 170 MHz
>>> commit "added intere no overf no sat fixedpt32.32"


	--------------------------------------------------------------
	Changes not commited but tested, produces slowdown
	Some of them are kept

	X65: `Krnl_IntraE`: is divided into `Krnl_IntraE`, `Krnl_IA_pipeline`, `Krnl_IA_pipeline2` to make computation faster

	X66. ref_intraE_contributors_const[] is created as local memory, too big? -> it fits! 
	X67. contributors are passed from calcenergy.cpp to Krnl_IntraE as char3 instead of char

	freq: 187 MHz, freq: 169 MHz
	---------------------------------------------------------------



65. ref_intraE_contributors_const[] is created as local memory
66. contributors are passed from calcenergy.cpp to Krnl_IntraE as char3 instead of char
67. `Krnl_InterE.cl` + `performdocking.cpp`: pass GlobFgrids as floats (just disable switch to pass them as fixedpt64)
68. `Krnl_InterE.cl`: unroll big computation for-loop with unroll-factor = 8 + shift-register + internal fixedpt64, to make II = 1 (without shift & fixedpt, II = 32)

(RECALL: estimated free energy of binding increased by 1 Kcal/mol in all runs)
freq: 185 MHz
>>> commit "unrolled intrae main loop with factor 8"



69. `Krnl_GA.cl`: unroll 8 inner for-loop "update current pops & energies"
		  unroll 4 inner for-loop "local_entity_1 and local_entity_2 are population-parent1, population-parent2"
		  unroll 4 inner for-loop "elitism - copying the best entity to new population"
		  unroll 16 inner for-loop "copy energy to local memory"		

70. `Krnl_LS1.cl`: apply fixedpt (16.16)
    `Krnl_GA.cl` : move include fixedpt libraries from `Conform` and `InterE`
		   define `fixedpt_map_angle_180()` and `fixedpt_map_angle_360()`
    `performdocking.cpp`: pass `base_dmov_mul_sqrt3` and `base_dang_mul_sqrt3` as fixedpt

71. `Krnl_LS2.cl`: apply fixedpt (16.16)
72. `Krnl_LS3.cl`: apply fixedpt (16.16)
73. Reduce data-type size of `max_num_of_iters` and `cons_limit` of LS arguments

freq: 178 MHz, a bit slower


74. `Krnl_GA.cl`: unroll 1 inner for-loop "update current pops & energies"
		  unroll 1 inner for-loop "local_entity_1 and local_entity_2 are population-parent1, population-parent2"
		  unroll 1 inner for-loop "elitism - copying the best entity to new population"
		  unroll 10 inner for-loop "copy energy to local memory"
    `Krnl_IntraE.cl`: unroll 10 main computation loop

freq: 173 MHz
>>> commit "all LS fixed1616 + unrolled intrae 10"

75. `Krnl_Prng_Arbiter`: separate single arbiter into four independent prng arbiters: BT, GG, LS_ushort, LS_float
			 (NOTE: merging BT & GG active signals and having therefore three independent prng arbiters, make GG for-loops execute serially and not pipelined as with current code. So better not do that!)

freq: 185 MHz
>>> commit "split prng arbiters"

76. `performdocking.cpp`, `Krnl_LS`, `Krnl_LS2`, `Krnl_LS3`: rho converted to fixedpt (reduces LS II, from II=7 down to II=2)
freq: 185 MHz

77. `performdocking.cpp`: corrected preprocessor directives that enable `FIXED_POINT_*` in conform, inter, intra, ls1, ls2, ls3
78. `Krnl_IntraE`, `performdocking.cpp`: make Krnl_intraE independent of `FIXED_POINT_INTERE`
79. `Krnl_IntraE`: added partially `FIXED_POINT_INTRAE` support

freq: 170 MHz
>>> commit "correct FIXEDPT_* directives"

80. `calcenergy.h`: correct preprocessor directive that enables FIXED_POINT_INTRAE
81. `Krnl_InterE`, `Makefile`: disable FIXED_POINT_INTERE
82. `Krnl_IntraE`, `Makefile`: disable FIXED_POINT_INTRAE + 
			       pipeline main for-loop (disable unroll 10)

freq: 207 MHz

-> 3ptb, 10runs took 64s, i.e. 64/59 = 1.08 slowdown
-> 1stp, 10runs took 166s, i.e. 166/84 = 1.97 slowdown
>>> commit "disabled fixedpt intere + intrae"


83. `Makefile`
    `calcenergy.cpp`, 
    `getparameters.cpp`,
    `performdocking.cpp`
    `Krnl_GA.cl`: SINGLE_COPY_POP_ENE: pass `cpu_init_populations` + `ref_orientation_quats` only once and not every docking GA cycle

freq: 191 MHz

84. `Makefile`: build using --fpc (reducing rounding operations) and
                            --fp-relaxed (order of floating point)

freq: 185 MHz

again without --fpc and without --fp-relaxed
freq: 191 MHz

>>> commit "added SINGLE_COPY_POP_ENE flag to pass all pop and energy only once"

85. `Makefile`: Disable SINGLE_COPY_POP_ENE
86. `Krnl_IGL_Arbiter`: reduce depth of channels 5x downto 3x
87. `Krnl_GA`: reduce depth of chan_Intere2StoreIC_intere, chan_Intere2StoreGG_intere, 
                               chan_Intrae2StoreIC_intrae, chan_Intrae2StoreGG_intrae channels MAX_POPSIZE downto 20

freq: 167 MHz (but instrumented reached freq: 193 MHz)

88. `performdocking.cpp`: clean up of replicated conform, intrae, intere kernels

89. `performdocking.cpp`: add missing copy of `cpu_init_populations` (host) 
                         to `mem_dockpars_conformations_current` (device) 
		         when SINGLE_COPY_POP_ENE is enabled

90. `performdocking.cpp`: cleanup code (with #if 0) for `cpu_fixedpt64grids` as Fgrids are passed as floats (not fixed-point)

91. `Krnl_GA`: enable SINGLE_COPY_POP_ENE + create __global pointers GlobPopCurr and GlobEneCurr

92. `performdocking.cpp` + `Krnl_InterE`: create create __global pointers GlobFgrids2 and GlobFgrids3

93. `performdocking.cpp` + `Krnl_InterE`: pass `DockConst_gridsize_x_minus1` as float for the case of non-fixed-point
					  to avoid conversion before comparison

94. `Krnl_IntraE`: reduce number of floating-point division (inverse_distance_pow_*)

95. `Krnl_PRNG.cl`, `Makefile`: remove `Krnl_Prng_BT_Arbiter` as not needed
96. `Krnl_PRNG.cl`, `Makefile`: remove `Krnl_Prng_GG_Arbiter` as not needed
97. `Krnl_PRNG.cl`, `Makefile`: remove `Krnl_Prng_LS_ushort_Arbiter` as not needed
98. `Krnl_PRNG.cl`, `Makefile`: remove `Krnl_Prng_LS_float_Arbiter` as not needed
99. `Krnl_GA`: separate channel reads of `chan_PRNG2GA_GG_uchar_prng` and `chan_PRNG2GA_GG_float_prng`
	       so for-loops in GG are nicely pipelined (no serial regions in nested loops)
100. `performdocking`
     `Krnl_LS_Arbiter`, 
     `Krnl_LS2_Arbiter`, 
     `Krnl_LS3_Arbiter` : pass energy and genotype directly from GA to LS (skipping Arbiter)


freq: 195 MHz

>>> commit "removed PRNG arbiters"


101. `Krnl_Conform`: improve access to phi, theta, genrotangle, genotyoe_xyz
102. `calcenergy.h`: corrected preprocessor defines for conform, ls1, ls2,ls3 when fixedpt

	Cleanup  IGL_Arbiter, GA, LS1, LS2, LS3 and respective Arbiters

103. `Krnl_IGL`: active & mode as char2 (bool active uses 8 bits as char, so wasted area)
104. `Krnl_Conform`, `Krnl_IntraE`, `Krnl_InterE`: active & mode as char2 (bool active uses 8 bits as char, so wasted area)
105. `Krnl_GA`, `Krnl_LS`, `Krnl_LS2`, `Krnl_LS3`: eval & energy as float2
106. `Krnl_LS`, `Krnl_LS2`, `Krnl_LS3`: replace blocking read energies with non-blocking

freq: 192.7 MHz
>>> commit "merge channels"

107. `Krnl_GA`: code clean up
108. `Krnl_GA`: mask `local_entity_1` and `local_entity_2` with MASK_GENOTYPE (to see reduced hw use report.html produced with aocl16.1)
109. `Krnl_IGL_Arbiter`: exclude unneccesary channel reads + loop fusion
110. `Krnl_PRNG`: code clean up + merge three `LS_ushort` into a single `Krnl_Prng_LS123_ushort`
111. `Krnl_PRNG`: `Krnl_Prng_GG_uchar` passes data as char2, internally is fully unrolled
112. `Krnl_PRNG`: `Krnl_Prng_BT_ushort_float` passes data as float8, internally is fully unrolled

freq: 193.7 MHz
>>> commit "IGL-loop fussioned + improved PRNGs"


113: `Krnl_GA`: fusioned loops "copy energy to local memory" + "identify best entity"
		redefined `shift_reg` with size SHIFT_REG_SIZE=10 to reach II=1 (if SHIFT_REG_SIZE<10, then aoc had to sacrifice circuit frequency (fmax) to achieve II=1)

114. `Krnl_GA`: code clean up +  
		moved eval_cnt & generation_cnt to terminate while-loop appropriatedly.
		(this while loop is still serialize so shouldn't degrade performance)			
115. `Krnl_PRNG`: code clean up
116. `Krnl_IGL_Arbiter`: recoded including conditionals, redefined active as char instead of bool

freq: 179.6 MHz
>>> commit "pipelined deeper Krnl_GA"

117. `Krnl_GA`: moved elistism loop into genetic-generation loop (deeper pipelined) +
		IC and GG energy-receiving channel-reads are pipelined with a while-loop and nb-channels
118. `Krnl_IGL_Arbiter`: removed unnecessary __local float genotype1 [ACTUAL_GENOTYPE_LENGTH], also genotype2 and genotype3
119. `Krnl_Conform`: use simd for floating point version, reduces II=36 -> II=35		

NOT HW built
>>> commit "deeper Krnl_GA + reduced local in IGL"

120. `Krnl_GA`: moved crossover_rate evaluation outside loop + converted array prngGG[] into internal private var
>>> commit "optimized a bit Krnl_GA"


NOT DONE YET

disable SINGLE_COPY_POP_ENE, disable SEPARATE_FGRIDS_INTER
create internal __constant pointers to Fgrids2 and Fgrids3

mask genotype indexing with MASK_GENOTYPE



Makefile: pass separetely all other PDBS

add to Makefile exe rule for the 3 compounds, otherwise errors maight be silent not caught, 

planned not done successfully yet
. `Krnl_IntraE`: add fixedpt64 support with pragmas

