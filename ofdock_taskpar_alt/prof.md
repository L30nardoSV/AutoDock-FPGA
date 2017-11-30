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
