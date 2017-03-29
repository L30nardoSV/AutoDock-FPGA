-- ------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 14.1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2014 Altera Corporation.  All rights reserved.
-- Your use of  Altera  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Altera Program License Subscription Agreement,
-- Altera  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Altera and sold by
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from acl_fp_exp_a10
-- VHDL created on Thu Jul 31 12:03:38 2014


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

library twentynm;
use twentynm.twentynm_components.twentynm_fp_mac;

entity acl_fp_exp_a10 is
    port (
        xIn_v : in std_logic_vector(0 downto 0);
        xIn_c : in std_logic_vector(7 downto 0);
        a : in std_logic_vector(31 downto 0);
        en : in std_logic_vector(0 downto 0);
        xOut_v : out std_logic_vector(0 downto 0);
        xOut_c : out std_logic_vector(7 downto 0);
        q : out std_logic_vector(31 downto 0);
        clk : in std_logic;
        areset : in std_logic
    );
end acl_fp_exp_a10;

architecture normal of acl_fp_exp_a10 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstBias_uid9_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstBiasM1_uid10_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWE_uid14_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstAllOWE_uid17_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstOneWF_uid18_fpExpETest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal maxInput_uid35_fpExpETest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal minInput_uid39_fpExpETest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal cstBiasPCstShift_uid44_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal shiftUdf_uid48_fpExpETest_a : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftUdf_uid48_fpExpETest_q_i : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftUdf_uid48_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ePOC_uid54_fpExpETest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal ePOC_uid54_fpExpETest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal ePOC_uid54_fpExpETest_q_i : STD_LOGIC_VECTOR (10 downto 0);
    signal ePOC_uid54_fpExpETest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal cste128h_uid68_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cste128l_uid70_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal yP0_uid78_fpExpETest_reset : std_logic;
    signal yP0_uid78_fpExpETest_r :     std_logic_vector (31 downto 0);
    signal yP_uid85_fpExpETest_reset : std_logic;
    signal yP_uid85_fpExpETest_r :     std_logic_vector (31 downto 0);
    signal cstUdfA_uid99_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal oneFP_uid101_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cst16z_uid105_fpExpETest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal b_uid116_fpExpETest_reset : std_logic;
    signal b_uid116_fpExpETest_r :     std_logic_vector (31 downto 0);
    signal cstHalfFP_uid117_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal oPBo2_uid118_fpExpETest_reset : std_logic;
    signal oPBo2_uid118_fpExpETest_q : std_logic_vector (31 downto 0);
    signal eB_uid119_fpExpETest_reset : std_logic;
    signal eB_uid119_fpExpETest_q : std_logic_vector (31 downto 0);
    signal eY_uid120_fpExpETest_reset : std_logic;
    signal eY_uid120_fpExpETest_q : std_logic_vector (31 downto 0);
    signal biasM2_uid124_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal biasP1_uid125_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal excREnc_uid137_fpExpETest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal zeroFracRPostExc_uid139_fpExpETest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal rightShiftStage0Idx1Pad2_uid169_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0Idx2Pad4_uid172_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage0Idx3Pad6_uid175_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_reset0 : std_logic;
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_reset0 : std_logic;
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_kPPreZLow_uid65_fpExpETest_lutmem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage1Idx3Pad3_uid202_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal floatTable_eA_uid96_fpExpETest_lutmem_reset0 : std_logic;
    signal floatTable_eA_uid96_fpExpETest_lutmem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_eA_uid96_fpExpETest_lutmem_aa : STD_LOGIC_VECTOR (8 downto 0);
    signal floatTable_eA_uid96_fpExpETest_lutmem_ab : STD_LOGIC_VECTOR (8 downto 0);
    signal floatTable_eA_uid96_fpExpETest_lutmem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal floatTable_eA_uid96_fpExpETest_lutmem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q : STD_LOGIC_VECTOR (2 downto 0);
    signal reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_signX_uid7_fpExpETest_b_to_Rnd2C_uid55_fpExpETest_a_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_bit8_uid60_fpExpETest_b_to_maxExpCond_uid61_fpExpETest_a_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_InvBit7_uid59_fpExpETest_q_to_maxExpCond_uid61_fpExpETest_b_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_maxExpCond_uid61_fpExpETest_q_to_kPZLow_uid71_fpExpETest_s_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_signYP_uid88_fpExpETest_b_to_addrEATable_uid95_fpExpETest_b_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_udfA_uid100_fpExpETest_n_to_eAPostUdfA_uid102_fpExpETest_s_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_0_q_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_a_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_a_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_mem_reset0 : std_logic;
    signal ld_xIn_v_to_xOut_v_replace_mem_ia : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_mem_iq : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_mem_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_rdcnt_i : UNSIGNED (4 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_rdcnt_eq : std_logic;
    signal ld_xIn_v_to_xOut_v_replace_rdreg_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_v_to_xOut_v_mem_top_q : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_xIn_v_to_xOut_v_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve : boolean;
    attribute preserve of ld_xIn_v_to_xOut_v_sticky_ena_q : signal is true;
    signal ld_xIn_c_to_xOut_c_replace_mem_reset0 : std_logic;
    signal ld_xIn_c_to_xOut_c_replace_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_xIn_c_to_xOut_c_replace_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_c_to_xOut_c_replace_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_c_to_xOut_c_replace_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_xIn_c_to_xOut_c_replace_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_xIn_c_to_xOut_c_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_xIn_c_to_xOut_c_sticky_ena_q : signal is true;
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_reset0 : std_logic;
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_i : UNSIGNED (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_mem_top_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q : signal is true;
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_inputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_reset0 : std_logic;
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i : UNSIGNED (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_eq : std_logic;
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_mem_top_q : STD_LOGIC_VECTOR (3 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q : signal is true;
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_reset0 : std_logic;
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i : UNSIGNED (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_eq : std_logic;
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_mem_top_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q : signal is true;
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_inputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_reset0 : std_logic;
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i : UNSIGNED (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_eq : std_logic;
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_mem_top_q : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q : signal is true;
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_reset0 : std_logic;
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ia : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_iq : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i : UNSIGNED (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_eq : std_logic;
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_mem_top_q : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q : signal is true;
    signal Rnd2C_uid55_fpExpETest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_replace_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_xIn_v_to_xOut_v_cmp_a : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_xIn_v_to_xOut_v_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_xIn_v_to_xOut_v_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_notEnable_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_v_to_xOut_v_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_c_to_xOut_c_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_a : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_a : STD_LOGIC_VECTOR (3 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_a : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_a : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q : STD_LOGIC_VECTOR (4 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_a : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expX_uid6_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signX_uid7_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal signX_uid7_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracX_uid8_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal fracX_uid8_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expXIsZero_uid21_fpExpETest_a : STD_LOGIC_VECTOR (7 downto 0);
    signal expXIsZero_uid21_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expXIsZero_uid21_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid23_fpExpETest_a : STD_LOGIC_VECTOR (7 downto 0);
    signal expXIsMax_uid23_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal expXIsMax_uid23_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid25_fpExpETest_a : STD_LOGIC_VECTOR (25 downto 0);
    signal fracXIsNotZero_uid25_fpExpETest_b : STD_LOGIC_VECTOR (25 downto 0);
    signal fracXIsNotZero_uid25_fpExpETest_o : STD_LOGIC_VECTOR (25 downto 0);
    signal fracXIsNotZero_uid25_fpExpETest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid25_fpExpETest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid26_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid26_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_I_uid27_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_I_uid27_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_I_uid27_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvFracXIsZero_uid28_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvFracXIsZero_uid28_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_N_uid29_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_N_uid29_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_N_uid29_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExc_N_uid30_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExc_N_uid30_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExc_I_uid31_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExc_I_uid31_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid32_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid32_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_R_uid33_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_R_uid33_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_R_uid33_fpExpETest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal exc_R_uid33_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvSignX_uid37_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvSignX_uid37_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftVal_uid45_fpExpETest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftVal_uid45_fpExpETest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftVal_uid45_fpExpETest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftVal_uid45_fpExpETest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal fxpXRedForCstMult_uid51_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fxpXRedForCstMult_uid51_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal eP2CWRnd_uid56_fpExpETest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal eP2CWRnd_uid56_fpExpETest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal eP2CWRnd_uid56_fpExpETest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal eP2CWRnd_uid56_fpExpETest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal maxExpCond_uid61_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal maxExpCond_uid61_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal maxExpCond_uid61_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal kPZHigh_uid69_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal kPZHigh_uid69_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal kPZLow_uid71_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal kPZLow_uid71_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal eAPostUdfA_uid102_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal eAPostUdfA_uid102_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal negInf_uid129_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal negInf_uid129_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal negInf_uid129_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal posInf_uid134_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal posInf_uid134_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal posInf_uid134_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracYP_uid86_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal fracYP_uid86_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expYP_uid87_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expYP_uid87_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal signYP_uid88_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal signYP_uid88_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal udfA_uid100_fpExpETest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal udfA_uid100_fpExpETest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal udfA_uid100_fpExpETest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal udfA_uid100_fpExpETest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal udfA_uid100_fpExpETest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expEY_uid121_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expEY_uid121_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracEY_uid140_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal fracEY_uid140_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signEY_uid147_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal signEY_uid147_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPostExc_uid142_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid142_fpExpETest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal addrEATable_uid95_fpExpETest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expFracX_uid34_fpExpETest_q : STD_LOGIC_VECTOR (30 downto 0);
    signal xFxpLow_uid42_fpExpETest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal xFxpLow_uid42_fpExpETest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftValPos_uid46_fpExpETest_in : STD_LOGIC_VECTOR (2 downto 0);
    signal shiftValPos_uid46_fpExpETest_b : STD_LOGIC_VECTOR (2 downto 0);
    signal expUdfRange_uid47_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expUdfRange_uid47_fpExpETest_b : STD_LOGIC_VECTOR (4 downto 0);
    signal xv0_uid151_eP_uid52_fpExpETest_in : STD_LOGIC_VECTOR (5 downto 0);
    signal xv0_uid151_eP_uid52_fpExpETest_b : STD_LOGIC_VECTOR (5 downto 0);
    signal xv1_uid152_eP_uid52_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal xv1_uid152_eP_uid52_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal expTmp_uid57_fpExpETest_in : STD_LOGIC_VECTOR (9 downto 0);
    signal expTmp_uid57_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal bit7_uid58_fpExpETest_in : STD_LOGIC_VECTOR (10 downto 0);
    signal bit7_uid58_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bit8_uid60_fpExpETest_in : STD_LOGIC_VECTOR (9 downto 0);
    signal bit8_uid60_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal KPZHigh31_uid72_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal KPZHigh31_uid72_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal KPZHigh22dto0_uid73_fpExpETest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal KPZHigh22dto0_uid73_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal KPZHigh30dto23_uid74_fpExpETest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal KPZHigh30dto23_uid74_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal KPZLow31_uid79_fpExpETest_in : STD_LOGIC_VECTOR (31 downto 0);
    signal KPZLow31_uid79_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal KPZLow22dto0_uid80_fpExpETest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal KPZLow22dto0_uid80_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal KPZLow30dto23_uid81_fpExpETest_in : STD_LOGIC_VECTOR (30 downto 0);
    signal KPZLow30dto23_uid81_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracYPTop_uid90_fpExpETest_in : STD_LOGIC_VECTOR (22 downto 0);
    signal fracYPTop_uid90_fpExpETest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal expYPBottom_uid89_fpExpETest_in : STD_LOGIC_VECTOR (2 downto 0);
    signal expYPBottom_uid89_fpExpETest_b : STD_LOGIC_VECTOR (2 downto 0);
    signal shiftValFxpA_uid92_fpExpETest_a : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftValFxpA_uid92_fpExpETest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftValFxpA_uid92_fpExpETest_o : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftValFxpA_uid92_fpExpETest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal newExpA_uid107_fpExpETest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal newExpA_uid107_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal lowerBitOfeY_uid122_fpExpETest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowerBitOfeY_uid122_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal expMaxInput_uid36_fpExpETest_a : STD_LOGIC_VECTOR (33 downto 0);
    signal expMaxInput_uid36_fpExpETest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal expMaxInput_uid36_fpExpETest_o : STD_LOGIC_VECTOR (33 downto 0);
    signal expMaxInput_uid36_fpExpETest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal expMaxInput_uid36_fpExpETest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal expMinInput_uid40_fpExpETest_a : STD_LOGIC_VECTOR (33 downto 0);
    signal expMinInput_uid40_fpExpETest_b : STD_LOGIC_VECTOR (33 downto 0);
    signal expMinInput_uid40_fpExpETest_o : STD_LOGIC_VECTOR (33 downto 0);
    signal expMinInput_uid40_fpExpETest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal expMinInput_uid40_fpExpETest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal oXLow_uid43_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal p0_uid154_eP_uid52_fpExpETest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal p1_uid153_eP_uid52_fpExpETest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal InvBit7_uid59_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvBit7_uid59_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvKPZHigh31_uid75_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvKPZHigh31_uid75_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minusY_uid76_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal InvKPZLow31_uid82_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvKPZLow31_uid82_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minusY_uid83_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal fxpAPreAlign_uid91_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal maskAFP_uid103_fpExpETest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftValFxpAR_uid93_fpExpETest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal shiftValFxpAR_uid93_fpExpETest_b : STD_LOGIC_VECTOR (3 downto 0);
    signal expUpdateVal_uid126_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expUpdateVal_uid126_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal inputOveflow_uid38_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal inputOveflow_uid38_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal inputOveflow_uid38_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal inputUndeflow_uid41_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal inputUndeflow_uid41_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal inputUndeflow_uid41_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal X7dto2_uid168_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal X7dto2_uid168_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (5 downto 0);
    signal X7dto4_uid171_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal X7dto4_uid171_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (3 downto 0);
    signal X7dto6_uid174_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal X7dto6_uid174_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal lev1_a0_uid155_eP_uid52_fpExpETest_a : STD_LOGIC_VECTOR (12 downto 0);
    signal lev1_a0_uid155_eP_uid52_fpExpETest_b : STD_LOGIC_VECTOR (12 downto 0);
    signal lev1_a0_uid155_eP_uid52_fpExpETest_o : STD_LOGIC_VECTOR (12 downto 0);
    signal lev1_a0_uid155_eP_uid52_fpExpETest_q : STD_LOGIC_VECTOR (12 downto 0);
    signal X7dto4_uid188_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal X7dto4_uid188_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (3 downto 0);
    signal fracYPTopPostMask_uid104_fpExpETest_a : STD_LOGIC_VECTOR (6 downto 0);
    signal fracYPTopPostMask_uid104_fpExpETest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal fracYPTopPostMask_uid104_fpExpETest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (1 downto 0);
    signal updatedExponent_uid127_fpExpETest_a : STD_LOGIC_VECTOR (10 downto 0);
    signal updatedExponent_uid127_fpExpETest_b : STD_LOGIC_VECTOR (10 downto 0);
    signal updatedExponent_uid127_fpExpETest_o : STD_LOGIC_VECTOR (10 downto 0);
    signal updatedExponent_uid127_fpExpETest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal regXAndExpOverflowAndPos_uid132_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal regXAndExpOverflowAndPos_uid132_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal regXAndExpOverflowAndPos_uid132_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal regXAndExpOverflowAndNeg_uid130_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal regXAndExpOverflowAndNeg_uid130_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal regXAndExpOverflowAndNeg_uid130_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1_uid170_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage0Idx2_uid173_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage0Idx3_uid176_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal sR_uid156_eP_uid52_fpExpETest_in : STD_LOGIC_VECTOR (11 downto 0);
    signal sR_uid156_eP_uid52_fpExpETest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftStage0Idx1_uid190_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracAFull_uid106_fpExpETest_q : STD_LOGIC_VECTOR (22 downto 0);
    signal rightShiftStage0_uid194_fxpA_uid94_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expR_uid128_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal expR_uid128_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal excRInf_uid135_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid135_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid135_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid131_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid131_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid131_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zEp_uid53_fpExpETest_q : STD_LOGIC_VECTOR (10 downto 0);
    signal a_uid108_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (5 downto 0);
    signal RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_b : STD_LOGIC_VECTOR (4 downto 0);
    signal expRPostExc_uid146_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid146_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal concExc_uid136_fpExpETest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_b : STD_LOGIC_VECTOR (6 downto 0);
    signal A31_uid110_fpExpETest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal A31_uid110_fpExpETest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal A22dto0_uid111_fpExpETest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal A22dto0_uid111_fpExpETest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal A30dto23_uid112_fpExpETest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal A30dto23_uid112_fpExpETest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx1_uid197_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx2_uid200_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx3_uid203_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal finalResult_uid148_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage1Idx1_uid181_fxpXRed_uid49_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal InvA31_uid113_fpExpETest_a : STD_LOGIC_VECTOR (0 downto 0);
    signal InvA31_uid113_fpExpETest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal minusY_uid114_fpExpETest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage1_uid205_fxpA_uid94_fpExpETest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expER_uid150_fpExpETest_in : STD_LOGIC_VECTOR (33 downto 0);
    signal expER_uid150_fpExpETest_b : STD_LOGIC_VECTOR (31 downto 0);
    signal e : std_logic;
    
begin
    e <= en(0);

    -- xIn(PORTIN,3)@0

    -- oneFP_uid101_fpExpETest(CONSTANT,100)
    oneFP_uid101_fpExpETest_q <= "00111111100000000000000000000000";

    -- cstHalfFP_uid117_fpExpETest(CONSTANT,116)
    cstHalfFP_uid117_fpExpETest_q <= "00111111000000000000000000000000";

    -- signYP_uid88_fpExpETest(BITSELECT,87)@11
    signYP_uid88_fpExpETest_in <= STD_LOGIC_VECTOR(yP_uid85_fpExpETest_r);
    signYP_uid88_fpExpETest_b <= signYP_uid88_fpExpETest_in(31 downto 31);

    -- cstZeroWE_uid14_fpExpETest(CONSTANT,13)
    cstZeroWE_uid14_fpExpETest_q <= "00000000";

    -- expYP_uid87_fpExpETest(BITSELECT,86)@11
    expYP_uid87_fpExpETest_in <= yP_uid85_fpExpETest_r;
    expYP_uid87_fpExpETest_b <= expYP_uid87_fpExpETest_in(30 downto 23);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- cstUdfA_uid99_fpExpETest(CONSTANT,98)
    cstUdfA_uid99_fpExpETest_q <= "01110111";

    -- udfA_uid100_fpExpETest(COMPARE,99)@11
    udfA_uid100_fpExpETest_cin <= GND_q;
    udfA_uid100_fpExpETest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 8 => cstUdfA_uid99_fpExpETest_q(7)) & cstUdfA_uid99_fpExpETest_q) & '0');
    udfA_uid100_fpExpETest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & "00" & expYP_uid87_fpExpETest_b) & udfA_uid100_fpExpETest_cin(0));
    udfA_uid100_fpExpETest_o <= STD_LOGIC_VECTOR(SIGNED(udfA_uid100_fpExpETest_a) - SIGNED(udfA_uid100_fpExpETest_b));
    udfA_uid100_fpExpETest_n(0) <= not (udfA_uid100_fpExpETest_o(11));

    -- newExpA_uid107_fpExpETest(MUX,106)@11
    newExpA_uid107_fpExpETest_s <= udfA_uid100_fpExpETest_n;
    newExpA_uid107_fpExpETest: PROCESS (newExpA_uid107_fpExpETest_s, en, expYP_uid87_fpExpETest_b, cstZeroWE_uid14_fpExpETest_q)
    BEGIN
        CASE (newExpA_uid107_fpExpETest_s) IS
            WHEN "0" => newExpA_uid107_fpExpETest_q <= expYP_uid87_fpExpETest_b;
            WHEN "1" => newExpA_uid107_fpExpETest_q <= cstZeroWE_uid14_fpExpETest_q;
            WHEN OTHERS => newExpA_uid107_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expYPBottom_uid89_fpExpETest(BITSELECT,88)@11
    expYPBottom_uid89_fpExpETest_in <= expYP_uid87_fpExpETest_b(2 downto 0);
    expYPBottom_uid89_fpExpETest_b <= expYPBottom_uid89_fpExpETest_in(2 downto 0);

    -- maskAFP_uid103_fpExpETest(LOOKUP,102)@11
    maskAFP_uid103_fpExpETest: PROCESS (expYPBottom_uid89_fpExpETest_b)
    BEGIN
        -- Begin reserved scope level
        CASE (expYPBottom_uid89_fpExpETest_b) IS
            WHEN "000" => maskAFP_uid103_fpExpETest_q <= "1000000";
            WHEN "001" => maskAFP_uid103_fpExpETest_q <= "1100000";
            WHEN "010" => maskAFP_uid103_fpExpETest_q <= "1110000";
            WHEN "011" => maskAFP_uid103_fpExpETest_q <= "1111000";
            WHEN "100" => maskAFP_uid103_fpExpETest_q <= "1111100";
            WHEN "101" => maskAFP_uid103_fpExpETest_q <= "1111110";
            WHEN "110" => maskAFP_uid103_fpExpETest_q <= "1111111";
            WHEN "111" => maskAFP_uid103_fpExpETest_q <= "0000000";
            WHEN OTHERS => maskAFP_uid103_fpExpETest_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- fracYP_uid86_fpExpETest(BITSELECT,85)@11
    fracYP_uid86_fpExpETest_in <= yP_uid85_fpExpETest_r;
    fracYP_uid86_fpExpETest_b <= fracYP_uid86_fpExpETest_in(22 downto 0);

    -- fracYPTop_uid90_fpExpETest(BITSELECT,89)@11
    fracYPTop_uid90_fpExpETest_in <= fracYP_uid86_fpExpETest_b;
    fracYPTop_uid90_fpExpETest_b <= fracYPTop_uid90_fpExpETest_in(22 downto 16);

    -- fracYPTopPostMask_uid104_fpExpETest(LOGICAL,103)@11
    fracYPTopPostMask_uid104_fpExpETest_a <= fracYPTop_uid90_fpExpETest_b;
    fracYPTopPostMask_uid104_fpExpETest_b <= maskAFP_uid103_fpExpETest_q;
    fracYPTopPostMask_uid104_fpExpETest_q <= fracYPTopPostMask_uid104_fpExpETest_a and fracYPTopPostMask_uid104_fpExpETest_b;

    -- cst16z_uid105_fpExpETest(CONSTANT,104)
    cst16z_uid105_fpExpETest_q <= "0000000000000000";

    -- fracAFull_uid106_fpExpETest(BITJOIN,105)@11
    fracAFull_uid106_fpExpETest_q <= fracYPTopPostMask_uid104_fpExpETest_q & cst16z_uid105_fpExpETest_q;

    -- a_uid108_fpExpETest(BITJOIN,107)@11
    a_uid108_fpExpETest_q <= signYP_uid88_fpExpETest_b & newExpA_uid107_fpExpETest_q & fracAFull_uid106_fpExpETest_q;

    -- A31_uid110_fpExpETest(BITSELECT,109)@11
    A31_uid110_fpExpETest_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => a_uid108_fpExpETest_q(31)) & a_uid108_fpExpETest_q));
    A31_uid110_fpExpETest_b <= A31_uid110_fpExpETest_in(31 downto 31);

    -- InvA31_uid113_fpExpETest(LOGICAL,112)@11
    InvA31_uid113_fpExpETest_a <= A31_uid110_fpExpETest_b;
    InvA31_uid113_fpExpETest_q <= not (InvA31_uid113_fpExpETest_a);

    -- A30dto23_uid112_fpExpETest(BITSELECT,111)@11
    A30dto23_uid112_fpExpETest_in <= STD_LOGIC_VECTOR("00" & a_uid108_fpExpETest_q);
    A30dto23_uid112_fpExpETest_b <= A30dto23_uid112_fpExpETest_in(30 downto 23);

    -- A22dto0_uid111_fpExpETest(BITSELECT,110)@11
    A22dto0_uid111_fpExpETest_in <= STD_LOGIC_VECTOR("00" & a_uid108_fpExpETest_q);
    A22dto0_uid111_fpExpETest_b <= A22dto0_uid111_fpExpETest_in(22 downto 0);

    -- minusY_uid114_fpExpETest(BITJOIN,113)@11
    minusY_uid114_fpExpETest_q <= InvA31_uid113_fpExpETest_q & A30dto23_uid112_fpExpETest_b & A22dto0_uid111_fpExpETest_b;

    -- cste128l_uid70_fpExpETest(CONSTANT,69)
    cste128l_uid70_fpExpETest_q <= "00110110111101111101000111001111";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- signX_uid7_fpExpETest(BITSELECT,6)@0
    signX_uid7_fpExpETest_in <= STD_LOGIC_VECTOR(a);
    signX_uid7_fpExpETest_b <= signX_uid7_fpExpETest_in(31 downto 31);

    -- ld_signX_uid7_fpExpETest_b_to_Rnd2C_uid55_fpExpETest_a(DELAY,255)@0
    ld_signX_uid7_fpExpETest_b_to_Rnd2C_uid55_fpExpETest_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 2 )
    PORT MAP ( xin => signX_uid7_fpExpETest_b, xout => ld_signX_uid7_fpExpETest_b_to_Rnd2C_uid55_fpExpETest_a_q, ena => en(0), clk => clk, aclr => areset );

    -- Rnd2C_uid55_fpExpETest(BITJOIN,54)@2
    Rnd2C_uid55_fpExpETest_q <= VCC_q & ld_signX_uid7_fpExpETest_b_to_Rnd2C_uid55_fpExpETest_a_q;

    -- ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b(DELAY,254)@0
    ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => signX_uid7_fpExpETest_b, xout => ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b_q, ena => en(0), clk => clk, aclr => areset );

    -- RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest(BITSELECT,178)@0
    RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_in <= rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q;
    RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_b <= RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_in(7 downto 1);

    -- rightShiftStage1Idx1_uid181_fxpXRed_uid49_fpExpETest(BITJOIN,180)@0
    rightShiftStage1Idx1_uid181_fxpXRed_uid49_fpExpETest_q <= GND_q & RightShiftStage07dto1_uid179_fxpXRed_uid49_fpExpETest_b;

    -- rightShiftStage0Idx3Pad6_uid175_fxpXRed_uid49_fpExpETest(CONSTANT,174)
    rightShiftStage0Idx3Pad6_uid175_fxpXRed_uid49_fpExpETest_q <= "000000";

    -- X7dto6_uid174_fxpXRed_uid49_fpExpETest(BITSELECT,173)@0
    X7dto6_uid174_fxpXRed_uid49_fpExpETest_in <= oXLow_uid43_fpExpETest_q;
    X7dto6_uid174_fxpXRed_uid49_fpExpETest_b <= X7dto6_uid174_fxpXRed_uid49_fpExpETest_in(7 downto 6);

    -- rightShiftStage0Idx3_uid176_fxpXRed_uid49_fpExpETest(BITJOIN,175)@0
    rightShiftStage0Idx3_uid176_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx3Pad6_uid175_fxpXRed_uid49_fpExpETest_q & X7dto6_uid174_fxpXRed_uid49_fpExpETest_b;

    -- rightShiftStage0Idx2Pad4_uid172_fxpXRed_uid49_fpExpETest(CONSTANT,171)
    rightShiftStage0Idx2Pad4_uid172_fxpXRed_uid49_fpExpETest_q <= "0000";

    -- X7dto4_uid171_fxpXRed_uid49_fpExpETest(BITSELECT,170)@0
    X7dto4_uid171_fxpXRed_uid49_fpExpETest_in <= oXLow_uid43_fpExpETest_q;
    X7dto4_uid171_fxpXRed_uid49_fpExpETest_b <= X7dto4_uid171_fxpXRed_uid49_fpExpETest_in(7 downto 4);

    -- rightShiftStage0Idx2_uid173_fxpXRed_uid49_fpExpETest(BITJOIN,172)@0
    rightShiftStage0Idx2_uid173_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx2Pad4_uid172_fxpXRed_uid49_fpExpETest_q & X7dto4_uid171_fxpXRed_uid49_fpExpETest_b;

    -- rightShiftStage0Idx1Pad2_uid169_fxpXRed_uid49_fpExpETest(CONSTANT,168)
    rightShiftStage0Idx1Pad2_uid169_fxpXRed_uid49_fpExpETest_q <= "00";

    -- X7dto2_uid168_fxpXRed_uid49_fpExpETest(BITSELECT,167)@0
    X7dto2_uid168_fxpXRed_uid49_fpExpETest_in <= oXLow_uid43_fpExpETest_q;
    X7dto2_uid168_fxpXRed_uid49_fpExpETest_b <= X7dto2_uid168_fxpXRed_uid49_fpExpETest_in(7 downto 2);

    -- rightShiftStage0Idx1_uid170_fxpXRed_uid49_fpExpETest(BITJOIN,169)@0
    rightShiftStage0Idx1_uid170_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx1Pad2_uid169_fxpXRed_uid49_fpExpETest_q & X7dto2_uid168_fxpXRed_uid49_fpExpETest_b;

    -- fracX_uid8_fpExpETest(BITSELECT,7)@0
    fracX_uid8_fpExpETest_in <= a;
    fracX_uid8_fpExpETest_b <= fracX_uid8_fpExpETest_in(22 downto 0);

    -- xFxpLow_uid42_fpExpETest(BITSELECT,41)@0
    xFxpLow_uid42_fpExpETest_in <= fracX_uid8_fpExpETest_b;
    xFxpLow_uid42_fpExpETest_b <= xFxpLow_uid42_fpExpETest_in(22 downto 16);

    -- oXLow_uid43_fpExpETest(BITJOIN,42)@0
    oXLow_uid43_fpExpETest_q <= VCC_q & xFxpLow_uid42_fpExpETest_b;

    -- expX_uid6_fpExpETest(BITSELECT,5)@0
    expX_uid6_fpExpETest_in <= a;
    expX_uid6_fpExpETest_b <= expX_uid6_fpExpETest_in(30 downto 23);

    -- cstBiasPCstShift_uid44_fpExpETest(CONSTANT,43)
    cstBiasPCstShift_uid44_fpExpETest_q <= "10000101";

    -- shiftVal_uid45_fpExpETest(SUB,44)@0
    shiftVal_uid45_fpExpETest_a <= STD_LOGIC_VECTOR("0" & cstBiasPCstShift_uid44_fpExpETest_q);
    shiftVal_uid45_fpExpETest_b <= STD_LOGIC_VECTOR("0" & expX_uid6_fpExpETest_b);
    shiftVal_uid45_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftVal_uid45_fpExpETest_a) - UNSIGNED(shiftVal_uid45_fpExpETest_b));
    shiftVal_uid45_fpExpETest_q <= shiftVal_uid45_fpExpETest_o(8 downto 0);

    -- shiftValPos_uid46_fpExpETest(BITSELECT,45)@0
    shiftValPos_uid46_fpExpETest_in <= shiftVal_uid45_fpExpETest_q(2 downto 0);
    shiftValPos_uid46_fpExpETest_b <= shiftValPos_uid46_fpExpETest_in(2 downto 0);

    -- rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest(BITSELECT,176)@0
    rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_in <= shiftValPos_uid46_fpExpETest_b;
    rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_b <= rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_in(2 downto 1);

    -- rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest(MUX,177)@0
    rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_s <= rightShiftStageSel2Dto1_uid177_fxpXRed_uid49_fpExpETest_b;
    rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest: PROCESS (rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_s, en, oXLow_uid43_fpExpETest_q, rightShiftStage0Idx1_uid170_fxpXRed_uid49_fpExpETest_q, rightShiftStage0Idx2_uid173_fxpXRed_uid49_fpExpETest_q, rightShiftStage0Idx3_uid176_fxpXRed_uid49_fpExpETest_q)
    BEGIN
        CASE (rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_s) IS
            WHEN "00" => rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q <= oXLow_uid43_fpExpETest_q;
            WHEN "01" => rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx1_uid170_fxpXRed_uid49_fpExpETest_q;
            WHEN "10" => rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx2_uid173_fxpXRed_uid49_fpExpETest_q;
            WHEN "11" => rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0Idx3_uid176_fxpXRed_uid49_fpExpETest_q;
            WHEN OTHERS => rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest(BITSELECT,181)@0
    rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_in <= shiftValPos_uid46_fpExpETest_b(0 downto 0);
    rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_b <= rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_in(0 downto 0);

    -- rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest(MUX,182)@0
    rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_s <= rightShiftStageSel0Dto0_uid182_fxpXRed_uid49_fpExpETest_b;
    rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_s) IS
                    WHEN "0" => rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q <= rightShiftStage0_uid178_fxpXRed_uid49_fpExpETest_q;
                    WHEN "1" => rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q <= rightShiftStage1Idx1_uid181_fxpXRed_uid49_fpExpETest_q;
                    WHEN OTHERS => rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- expUdfRange_uid47_fpExpETest(BITSELECT,46)@0
    expUdfRange_uid47_fpExpETest_in <= shiftVal_uid45_fpExpETest_q(7 downto 0);
    expUdfRange_uid47_fpExpETest_b <= expUdfRange_uid47_fpExpETest_in(7 downto 3);

    -- shiftUdf_uid48_fpExpETest(LOGICAL,47)@0
    shiftUdf_uid48_fpExpETest_a <= expUdfRange_uid47_fpExpETest_b;
    shiftUdf_uid48_fpExpETest_q_i <= "1" WHEN shiftUdf_uid48_fpExpETest_a /= "00000" ELSE "0";
    shiftUdf_uid48_fpExpETest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1 )
    PORT MAP ( xin => shiftUdf_uid48_fpExpETest_q_i, xout => shiftUdf_uid48_fpExpETest_q, ena => en(0), clk => clk, aclr => areset );

    -- fxpXRedForCstMult_uid51_fpExpETest(MUX,50)@1
    fxpXRedForCstMult_uid51_fpExpETest_s <= shiftUdf_uid48_fpExpETest_q;
    fxpXRedForCstMult_uid51_fpExpETest: PROCESS (fxpXRedForCstMult_uid51_fpExpETest_s, en, rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q, cstZeroWE_uid14_fpExpETest_q)
    BEGIN
        CASE (fxpXRedForCstMult_uid51_fpExpETest_s) IS
            WHEN "0" => fxpXRedForCstMult_uid51_fpExpETest_q <= rightShiftStage1_uid183_fxpXRed_uid49_fpExpETest_q;
            WHEN "1" => fxpXRedForCstMult_uid51_fpExpETest_q <= cstZeroWE_uid14_fpExpETest_q;
            WHEN OTHERS => fxpXRedForCstMult_uid51_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xv0_uid151_eP_uid52_fpExpETest(BITSELECT,150)@1
    xv0_uid151_eP_uid52_fpExpETest_in <= fxpXRedForCstMult_uid51_fpExpETest_q(5 downto 0);
    xv0_uid151_eP_uid52_fpExpETest_b <= xv0_uid151_eP_uid52_fpExpETest_in(5 downto 0);

    -- p0_uid154_eP_uid52_fpExpETest(LOOKUP,153)@1
    p0_uid154_eP_uid52_fpExpETest: PROCESS (xv0_uid151_eP_uid52_fpExpETest_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv0_uid151_eP_uid52_fpExpETest_b) IS
            WHEN "000000" => p0_uid154_eP_uid52_fpExpETest_q <= "0000000000";
            WHEN "000001" => p0_uid154_eP_uid52_fpExpETest_q <= "0000001100";
            WHEN "000010" => p0_uid154_eP_uid52_fpExpETest_q <= "0000010111";
            WHEN "000011" => p0_uid154_eP_uid52_fpExpETest_q <= "0000100011";
            WHEN "000100" => p0_uid154_eP_uid52_fpExpETest_q <= "0000101110";
            WHEN "000101" => p0_uid154_eP_uid52_fpExpETest_q <= "0000111010";
            WHEN "000110" => p0_uid154_eP_uid52_fpExpETest_q <= "0001000101";
            WHEN "000111" => p0_uid154_eP_uid52_fpExpETest_q <= "0001010001";
            WHEN "001000" => p0_uid154_eP_uid52_fpExpETest_q <= "0001011100";
            WHEN "001001" => p0_uid154_eP_uid52_fpExpETest_q <= "0001101000";
            WHEN "001010" => p0_uid154_eP_uid52_fpExpETest_q <= "0001110011";
            WHEN "001011" => p0_uid154_eP_uid52_fpExpETest_q <= "0001111111";
            WHEN "001100" => p0_uid154_eP_uid52_fpExpETest_q <= "0010001010";
            WHEN "001101" => p0_uid154_eP_uid52_fpExpETest_q <= "0010010110";
            WHEN "001110" => p0_uid154_eP_uid52_fpExpETest_q <= "0010100010";
            WHEN "001111" => p0_uid154_eP_uid52_fpExpETest_q <= "0010101101";
            WHEN "010000" => p0_uid154_eP_uid52_fpExpETest_q <= "0010111001";
            WHEN "010001" => p0_uid154_eP_uid52_fpExpETest_q <= "0011000100";
            WHEN "010010" => p0_uid154_eP_uid52_fpExpETest_q <= "0011010000";
            WHEN "010011" => p0_uid154_eP_uid52_fpExpETest_q <= "0011011011";
            WHEN "010100" => p0_uid154_eP_uid52_fpExpETest_q <= "0011100111";
            WHEN "010101" => p0_uid154_eP_uid52_fpExpETest_q <= "0011110010";
            WHEN "010110" => p0_uid154_eP_uid52_fpExpETest_q <= "0011111110";
            WHEN "010111" => p0_uid154_eP_uid52_fpExpETest_q <= "0100001001";
            WHEN "011000" => p0_uid154_eP_uid52_fpExpETest_q <= "0100010101";
            WHEN "011001" => p0_uid154_eP_uid52_fpExpETest_q <= "0100100001";
            WHEN "011010" => p0_uid154_eP_uid52_fpExpETest_q <= "0100101100";
            WHEN "011011" => p0_uid154_eP_uid52_fpExpETest_q <= "0100111000";
            WHEN "011100" => p0_uid154_eP_uid52_fpExpETest_q <= "0101000011";
            WHEN "011101" => p0_uid154_eP_uid52_fpExpETest_q <= "0101001111";
            WHEN "011110" => p0_uid154_eP_uid52_fpExpETest_q <= "0101011010";
            WHEN "011111" => p0_uid154_eP_uid52_fpExpETest_q <= "0101100110";
            WHEN "100000" => p0_uid154_eP_uid52_fpExpETest_q <= "0101110001";
            WHEN "100001" => p0_uid154_eP_uid52_fpExpETest_q <= "0101111101";
            WHEN "100010" => p0_uid154_eP_uid52_fpExpETest_q <= "0110001000";
            WHEN "100011" => p0_uid154_eP_uid52_fpExpETest_q <= "0110010100";
            WHEN "100100" => p0_uid154_eP_uid52_fpExpETest_q <= "0110011111";
            WHEN "100101" => p0_uid154_eP_uid52_fpExpETest_q <= "0110101011";
            WHEN "100110" => p0_uid154_eP_uid52_fpExpETest_q <= "0110110111";
            WHEN "100111" => p0_uid154_eP_uid52_fpExpETest_q <= "0111000010";
            WHEN "101000" => p0_uid154_eP_uid52_fpExpETest_q <= "0111001110";
            WHEN "101001" => p0_uid154_eP_uid52_fpExpETest_q <= "0111011001";
            WHEN "101010" => p0_uid154_eP_uid52_fpExpETest_q <= "0111100101";
            WHEN "101011" => p0_uid154_eP_uid52_fpExpETest_q <= "0111110000";
            WHEN "101100" => p0_uid154_eP_uid52_fpExpETest_q <= "0111111100";
            WHEN "101101" => p0_uid154_eP_uid52_fpExpETest_q <= "1000000111";
            WHEN "101110" => p0_uid154_eP_uid52_fpExpETest_q <= "1000010011";
            WHEN "101111" => p0_uid154_eP_uid52_fpExpETest_q <= "1000011110";
            WHEN "110000" => p0_uid154_eP_uid52_fpExpETest_q <= "1000101010";
            WHEN "110001" => p0_uid154_eP_uid52_fpExpETest_q <= "1000110110";
            WHEN "110010" => p0_uid154_eP_uid52_fpExpETest_q <= "1001000001";
            WHEN "110011" => p0_uid154_eP_uid52_fpExpETest_q <= "1001001101";
            WHEN "110100" => p0_uid154_eP_uid52_fpExpETest_q <= "1001011000";
            WHEN "110101" => p0_uid154_eP_uid52_fpExpETest_q <= "1001100100";
            WHEN "110110" => p0_uid154_eP_uid52_fpExpETest_q <= "1001101111";
            WHEN "110111" => p0_uid154_eP_uid52_fpExpETest_q <= "1001111011";
            WHEN "111000" => p0_uid154_eP_uid52_fpExpETest_q <= "1010000110";
            WHEN "111001" => p0_uid154_eP_uid52_fpExpETest_q <= "1010010010";
            WHEN "111010" => p0_uid154_eP_uid52_fpExpETest_q <= "1010011101";
            WHEN "111011" => p0_uid154_eP_uid52_fpExpETest_q <= "1010101001";
            WHEN "111100" => p0_uid154_eP_uid52_fpExpETest_q <= "1010110100";
            WHEN "111101" => p0_uid154_eP_uid52_fpExpETest_q <= "1011000000";
            WHEN "111110" => p0_uid154_eP_uid52_fpExpETest_q <= "1011001100";
            WHEN "111111" => p0_uid154_eP_uid52_fpExpETest_q <= "1011010111";
            WHEN OTHERS => p0_uid154_eP_uid52_fpExpETest_q <= "0000000000";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- xv1_uid152_eP_uid52_fpExpETest(BITSELECT,151)@1
    xv1_uid152_eP_uid52_fpExpETest_in <= fxpXRedForCstMult_uid51_fpExpETest_q;
    xv1_uid152_eP_uid52_fpExpETest_b <= xv1_uid152_eP_uid52_fpExpETest_in(7 downto 6);

    -- p1_uid153_eP_uid52_fpExpETest(LOOKUP,152)@1
    p1_uid153_eP_uid52_fpExpETest: PROCESS (xv1_uid152_eP_uid52_fpExpETest_b)
    BEGIN
        -- Begin reserved scope level
        CASE (xv1_uid152_eP_uid52_fpExpETest_b) IS
            WHEN "00" => p1_uid153_eP_uid52_fpExpETest_q <= "000000000000";
            WHEN "01" => p1_uid153_eP_uid52_fpExpETest_q <= "001011100011";
            WHEN "10" => p1_uid153_eP_uid52_fpExpETest_q <= "010111000101";
            WHEN "11" => p1_uid153_eP_uid52_fpExpETest_q <= "100010101000";
            WHEN OTHERS => p1_uid153_eP_uid52_fpExpETest_q <= "000000000000";
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- lev1_a0_uid155_eP_uid52_fpExpETest(ADD,154)@1
    lev1_a0_uid155_eP_uid52_fpExpETest_a <= STD_LOGIC_VECTOR("0" & p1_uid153_eP_uid52_fpExpETest_q);
    lev1_a0_uid155_eP_uid52_fpExpETest_b <= STD_LOGIC_VECTOR("000" & p0_uid154_eP_uid52_fpExpETest_q);
    lev1_a0_uid155_eP_uid52_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(lev1_a0_uid155_eP_uid52_fpExpETest_a) + UNSIGNED(lev1_a0_uid155_eP_uid52_fpExpETest_b));
    lev1_a0_uid155_eP_uid52_fpExpETest_q <= lev1_a0_uid155_eP_uid52_fpExpETest_o(12 downto 0);

    -- sR_uid156_eP_uid52_fpExpETest(BITSELECT,155)@1
    sR_uid156_eP_uid52_fpExpETest_in <= lev1_a0_uid155_eP_uid52_fpExpETest_q(11 downto 0);
    sR_uid156_eP_uid52_fpExpETest_b <= sR_uid156_eP_uid52_fpExpETest_in(11 downto 2);

    -- zEp_uid53_fpExpETest(BITJOIN,52)@1
    zEp_uid53_fpExpETest_q <= GND_q & sR_uid156_eP_uid52_fpExpETest_b;

    -- ePOC_uid54_fpExpETest(LOGICAL,53)@1
    ePOC_uid54_fpExpETest_a <= zEp_uid53_fpExpETest_q;
    ePOC_uid54_fpExpETest_b <= STD_LOGIC_VECTOR((10 downto 1 => ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b_q(0)) & ld_signX_uid7_fpExpETest_b_to_ePOC_uid54_fpExpETest_b_q);
    ePOC_uid54_fpExpETest_q_i <= ePOC_uid54_fpExpETest_a xor ePOC_uid54_fpExpETest_b;
    ePOC_uid54_fpExpETest_delay : dspba_delay
    GENERIC MAP ( width => 11, depth => 1 )
    PORT MAP ( xin => ePOC_uid54_fpExpETest_q_i, xout => ePOC_uid54_fpExpETest_q, ena => en(0), clk => clk, aclr => areset );

    -- eP2CWRnd_uid56_fpExpETest(ADD,55)@2
    eP2CWRnd_uid56_fpExpETest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((12 downto 11 => ePOC_uid54_fpExpETest_q(10)) & ePOC_uid54_fpExpETest_q));
    eP2CWRnd_uid56_fpExpETest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & "0000000000" & Rnd2C_uid55_fpExpETest_q));
    eP2CWRnd_uid56_fpExpETest_o <= STD_LOGIC_VECTOR(SIGNED(eP2CWRnd_uid56_fpExpETest_a) + SIGNED(eP2CWRnd_uid56_fpExpETest_b));
    eP2CWRnd_uid56_fpExpETest_q <= eP2CWRnd_uid56_fpExpETest_o(11 downto 0);

    -- expTmp_uid57_fpExpETest(BITSELECT,56)@2
    expTmp_uid57_fpExpETest_in <= STD_LOGIC_VECTOR(eP2CWRnd_uid56_fpExpETest_q(9 downto 0));
    expTmp_uid57_fpExpETest_b <= expTmp_uid57_fpExpETest_in(9 downto 2);

    -- ld_expTmp_uid57_fpExpETest_b_to_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_a(DELAY,407)@2
    ld_expTmp_uid57_fpExpETest_b_to_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_a : dspba_delay
    GENERIC MAP ( width => 8, depth => 3 )
    PORT MAP ( xin => expTmp_uid57_fpExpETest_b, xout => ld_expTmp_uid57_fpExpETest_b_to_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_a_q, ena => en(0), clk => clk, aclr => areset );

    -- reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4(REG,211)@5
    reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_q <= "00000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_q <= STD_LOGIC_VECTOR(ld_expTmp_uid57_fpExpETest_b_to_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_a_q);
            END IF;
        END IF;
    END PROCESS;

    -- reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0(REG,208)@2
    reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0_q <= "00000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0_q <= STD_LOGIC_VECTOR(expTmp_uid57_fpExpETest_b);
            END IF;
        END IF;
    END PROCESS;

    -- ld_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_0_q_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_a(DELAY,381)@3
    ld_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_0_q_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_a : dspba_delay
    GENERIC MAP ( width => 8, depth => 3 )
    PORT MAP ( xin => reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0_q, xout => ld_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_0_q_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_a_q, ena => en(0), clk => clk, aclr => areset );

    -- floatTable_kPPreZLow_uid65_fpExpETest_lutmem(DUALMEM,185)@6
    floatTable_kPPreZLow_uid65_fpExpETest_lutmem_aa <= ld_reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_0_q_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_a_q;
    floatTable_kPPreZLow_uid65_fpExpETest_lutmem_ab <= reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZLow_uid65_fpExpETest_lutmem_4_q;
    floatTable_kPPreZLow_uid65_fpExpETest_lutmem_reset0 <= areset;
    floatTable_kPPreZLow_uid65_fpExpETest_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 256,
        width_b => 32,
        widthad_b => 8,
        numwords_b => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "acl_fp_exp_a10_floatTable_kPPreZLow_uid65_fpExpETest_lutmem.hex",
        init_file_layout => "PORT_B",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => floatTable_kPPreZLow_uid65_fpExpETest_lutmem_reset0,
        clock0 => clk,
        address_a => floatTable_kPPreZLow_uid65_fpExpETest_lutmem_aa,
        wren_a => '0',
        address_b => floatTable_kPPreZLow_uid65_fpExpETest_lutmem_ab,
        q_b => floatTable_kPPreZLow_uid65_fpExpETest_lutmem_iq
    );
    floatTable_kPPreZLow_uid65_fpExpETest_lutmem_q <= floatTable_kPPreZLow_uid65_fpExpETest_lutmem_iq(31 downto 0);

    -- bit7_uid58_fpExpETest(BITSELECT,57)@2
    bit7_uid58_fpExpETest_in <= STD_LOGIC_VECTOR(eP2CWRnd_uid56_fpExpETest_q(10 downto 0));
    bit7_uid58_fpExpETest_b <= bit7_uid58_fpExpETest_in(10 downto 10);

    -- InvBit7_uid59_fpExpETest(LOGICAL,58)@2
    InvBit7_uid59_fpExpETest_a <= bit7_uid58_fpExpETest_b;
    InvBit7_uid59_fpExpETest_q <= not (InvBit7_uid59_fpExpETest_a);

    -- ld_InvBit7_uid59_fpExpETest_q_to_maxExpCond_uid61_fpExpETest_b(DELAY,263)@2
    ld_InvBit7_uid59_fpExpETest_q_to_maxExpCond_uid61_fpExpETest_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => InvBit7_uid59_fpExpETest_q, xout => ld_InvBit7_uid59_fpExpETest_q_to_maxExpCond_uid61_fpExpETest_b_q, ena => en(0), clk => clk, aclr => areset );

    -- bit8_uid60_fpExpETest(BITSELECT,59)@2
    bit8_uid60_fpExpETest_in <= STD_LOGIC_VECTOR(eP2CWRnd_uid56_fpExpETest_q(9 downto 0));
    bit8_uid60_fpExpETest_b <= bit8_uid60_fpExpETest_in(9 downto 9);

    -- ld_bit8_uid60_fpExpETest_b_to_maxExpCond_uid61_fpExpETest_a(DELAY,262)@2
    ld_bit8_uid60_fpExpETest_b_to_maxExpCond_uid61_fpExpETest_a : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => bit8_uid60_fpExpETest_b, xout => ld_bit8_uid60_fpExpETest_b_to_maxExpCond_uid61_fpExpETest_a_q, ena => en(0), clk => clk, aclr => areset );

    -- maxExpCond_uid61_fpExpETest(LOGICAL,60)@5
    maxExpCond_uid61_fpExpETest_a <= ld_bit8_uid60_fpExpETest_b_to_maxExpCond_uid61_fpExpETest_a_q;
    maxExpCond_uid61_fpExpETest_b <= ld_InvBit7_uid59_fpExpETest_q_to_maxExpCond_uid61_fpExpETest_b_q;
    maxExpCond_uid61_fpExpETest_q <= maxExpCond_uid61_fpExpETest_a and maxExpCond_uid61_fpExpETest_b;

    -- ld_maxExpCond_uid61_fpExpETest_q_to_kPZLow_uid71_fpExpETest_s(DELAY,266)@5
    ld_maxExpCond_uid61_fpExpETest_q_to_kPZLow_uid71_fpExpETest_s : dspba_delay
    GENERIC MAP ( width => 1, depth => 3 )
    PORT MAP ( xin => maxExpCond_uid61_fpExpETest_q, xout => ld_maxExpCond_uid61_fpExpETest_q_to_kPZLow_uid71_fpExpETest_s_q, ena => en(0), clk => clk, aclr => areset );

    -- kPZLow_uid71_fpExpETest(MUX,70)@8
    kPZLow_uid71_fpExpETest_s <= ld_maxExpCond_uid61_fpExpETest_q_to_kPZLow_uid71_fpExpETest_s_q;
    kPZLow_uid71_fpExpETest: PROCESS (kPZLow_uid71_fpExpETest_s, en, floatTable_kPPreZLow_uid65_fpExpETest_lutmem_q, cste128l_uid70_fpExpETest_q)
    BEGIN
        CASE (kPZLow_uid71_fpExpETest_s) IS
            WHEN "0" => kPZLow_uid71_fpExpETest_q <= floatTable_kPPreZLow_uid65_fpExpETest_lutmem_q;
            WHEN "1" => kPZLow_uid71_fpExpETest_q <= cste128l_uid70_fpExpETest_q;
            WHEN OTHERS => kPZLow_uid71_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- KPZLow31_uid79_fpExpETest(BITSELECT,78)@8
    KPZLow31_uid79_fpExpETest_in <= STD_LOGIC_VECTOR(kPZLow_uid71_fpExpETest_q);
    KPZLow31_uid79_fpExpETest_b <= KPZLow31_uid79_fpExpETest_in(31 downto 31);

    -- InvKPZLow31_uid82_fpExpETest(LOGICAL,81)@8
    InvKPZLow31_uid82_fpExpETest_a <= KPZLow31_uid79_fpExpETest_b;
    InvKPZLow31_uid82_fpExpETest_q <= not (InvKPZLow31_uid82_fpExpETest_a);

    -- KPZLow30dto23_uid81_fpExpETest(BITSELECT,80)@8
    KPZLow30dto23_uid81_fpExpETest_in <= kPZLow_uid71_fpExpETest_q(30 downto 0);
    KPZLow30dto23_uid81_fpExpETest_b <= KPZLow30dto23_uid81_fpExpETest_in(30 downto 23);

    -- KPZLow22dto0_uid80_fpExpETest(BITSELECT,79)@8
    KPZLow22dto0_uid80_fpExpETest_in <= kPZLow_uid71_fpExpETest_q(22 downto 0);
    KPZLow22dto0_uid80_fpExpETest_b <= KPZLow22dto0_uid80_fpExpETest_in(22 downto 0);

    -- minusY_uid83_fpExpETest(BITJOIN,82)@8
    minusY_uid83_fpExpETest_q <= InvKPZLow31_uid82_fpExpETest_q & KPZLow30dto23_uid81_fpExpETest_b & KPZLow22dto0_uid80_fpExpETest_b;

    -- cste128h_uid68_fpExpETest(CONSTANT,67)
    cste128h_uid68_fpExpETest_q <= "01000010101100010111001000010111";

    -- floatTable_kPPreZHigh_uid62_fpExpETest_lutmem(DUALMEM,184)@3
    floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_aa <= reg_expTmp_uid57_fpExpETest_0_to_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_0_q;
    floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_reset0 <= areset;
    floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "acl_fp_exp_a10_floatTable_kPPreZHigh_uid62_fpExpETest_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_reset0,
        clock0 => clk,
        address_a => floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_aa,
        q_a => floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_iq
    );
    floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_q <= floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_iq(31 downto 0);

    -- kPZHigh_uid69_fpExpETest(MUX,68)@5
    kPZHigh_uid69_fpExpETest_s <= maxExpCond_uid61_fpExpETest_q;
    kPZHigh_uid69_fpExpETest: PROCESS (kPZHigh_uid69_fpExpETest_s, en, floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_q, cste128h_uid68_fpExpETest_q)
    BEGIN
        CASE (kPZHigh_uid69_fpExpETest_s) IS
            WHEN "0" => kPZHigh_uid69_fpExpETest_q <= floatTable_kPPreZHigh_uid62_fpExpETest_lutmem_q;
            WHEN "1" => kPZHigh_uid69_fpExpETest_q <= cste128h_uid68_fpExpETest_q;
            WHEN OTHERS => kPZHigh_uid69_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- KPZHigh31_uid72_fpExpETest(BITSELECT,71)@5
    KPZHigh31_uid72_fpExpETest_in <= STD_LOGIC_VECTOR(kPZHigh_uid69_fpExpETest_q);
    KPZHigh31_uid72_fpExpETest_b <= KPZHigh31_uid72_fpExpETest_in(31 downto 31);

    -- InvKPZHigh31_uid75_fpExpETest(LOGICAL,74)@5
    InvKPZHigh31_uid75_fpExpETest_a <= KPZHigh31_uid72_fpExpETest_b;
    InvKPZHigh31_uid75_fpExpETest_q <= not (InvKPZHigh31_uid75_fpExpETest_a);

    -- KPZHigh30dto23_uid74_fpExpETest(BITSELECT,73)@5
    KPZHigh30dto23_uid74_fpExpETest_in <= kPZHigh_uid69_fpExpETest_q(30 downto 0);
    KPZHigh30dto23_uid74_fpExpETest_b <= KPZHigh30dto23_uid74_fpExpETest_in(30 downto 23);

    -- KPZHigh22dto0_uid73_fpExpETest(BITSELECT,72)@5
    KPZHigh22dto0_uid73_fpExpETest_in <= kPZHigh_uid69_fpExpETest_q(22 downto 0);
    KPZHigh22dto0_uid73_fpExpETest_b <= KPZHigh22dto0_uid73_fpExpETest_in(22 downto 0);

    -- minusY_uid76_fpExpETest(BITJOIN,75)@5
    minusY_uid76_fpExpETest_q <= InvKPZHigh31_uid75_fpExpETest_q & KPZHigh30dto23_uid74_fpExpETest_b & KPZHigh22dto0_uid73_fpExpETest_b;

    -- ld_xIn_v_to_xOut_v_notEnable(LOGICAL,418)@0
    ld_xIn_v_to_xOut_v_notEnable_a <= en;
    ld_xIn_v_to_xOut_v_notEnable_q <= not (ld_xIn_v_to_xOut_v_notEnable_a);

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor(LOGICAL,443)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_b <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_q <= not (ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_a or ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_b);

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_mem_top(CONSTANT,439)
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_mem_top_q <= "011";

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp(LOGICAL,440)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_a <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_mem_top_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_b <= STD_LOGIC_VECTOR("0" & ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q);
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_q <= "1" WHEN ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_a = ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_b ELSE "0";

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg(REG,441)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg_q <= STD_LOGIC_VECTOR(ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena(REG,444)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_xIn_a_to_yP0_uid78_fpExpETest_x_nor_q = "1") THEN
                ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q <= STD_LOGIC_VECTOR(ld_xIn_a_to_yP0_uid78_fpExpETest_x_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd(LOGICAL,445)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_a <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_sticky_ena_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_b <= en;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_q <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_a and ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_b;

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt(COUNTER,435)@0
    -- every=1, low=0, high=3, step=1, init=1
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_i <= TO_UNSIGNED(1, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_i <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_i, 2)));

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux(MUX,437)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_s <= en;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux: PROCESS (ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_s, ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q, ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_q)
    BEGIN
        CASE (ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_s) IS
            WHEN "0" => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q;
            WHEN "1" => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_q;
            WHEN OTHERS => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg(REG,436)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q <= "00";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem(DUALMEM,434)@0
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ia <= STD_LOGIC_VECTOR(a);
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_aa <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdreg_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ab <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_rdmux_q;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_reset0 <= areset;
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_xIn_a_to_yP0_uid78_fpExpETest_x_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_aa,
        data_a => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_ab,
        q_b => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_iq
    );
    ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_q <= ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_iq(31 downto 0);

    -- yP0_uid78_fpExpETest(FLOATADD,77)@5
    yP0_uid78_fpExpETest_reset <= areset;
    yP0_uid78_fpExpETest_DSP : twentynm_fp_mac
    -- simple clock setup for add
    generic map (
        operation_mode => "sp_add",
        ax_clock => "0",
        ay_clock => "0",
        az_clock => "none",
        adder_input_clock => "0",
        output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e,  ena(1) => '0', ena(2) => '0',
       aclr(0) => yP0_uid78_fpExpETest_reset, aclr(1) => yP0_uid78_fpExpETest_reset,
       ax => ld_xIn_a_to_yP0_uid78_fpExpETest_x_replace_mem_q,
       ay => minusY_uid76_fpExpETest_q,
       resulta => yP0_uid78_fpExpETest_r);

    -- yP_uid85_fpExpETest(FLOATADD,84)@8
    yP_uid85_fpExpETest_reset <= areset;
    yP_uid85_fpExpETest_DSP : twentynm_fp_mac
    -- simple clock setup for add
    generic map (
        operation_mode => "sp_add",
        ax_clock => "0",
        ay_clock => "0",
        az_clock => "none",
        adder_input_clock => "0",
        output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e,  ena(1) => '0', ena(2) => '0',
       aclr(0) => yP_uid85_fpExpETest_reset, aclr(1) => yP_uid85_fpExpETest_reset,
       ax => yP0_uid78_fpExpETest_r,
       ay => minusY_uid83_fpExpETest_q,
       resulta => yP_uid85_fpExpETest_r);

    -- b_uid116_fpExpETest(FLOATADD,115)@11
    b_uid116_fpExpETest_reset <= areset;
    b_uid116_fpExpETest_DSP : twentynm_fp_mac
    -- simple clock setup for add
    generic map (
        operation_mode => "sp_add",
        ax_clock => "0",
        ay_clock => "0",
        az_clock => "none",
        adder_input_clock => "0",
        output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e,  ena(1) => '0', ena(2) => '0',
       aclr(0) => b_uid116_fpExpETest_reset, aclr(1) => b_uid116_fpExpETest_reset,
       ax => yP_uid85_fpExpETest_r,
       ay => minusY_uid114_fpExpETest_q,
       resulta => b_uid116_fpExpETest_r);

    -- oPBo2_uid118_fpExpETest(FLOATMULTADD,117)@14
    oPBo2_uid118_fpExpETest_reset <= areset;
    oPBo2_uid118_fpExpETest_DSP : twentynm_fp_mac
     -- simple clock setup for mult add
     generic map (
        operation_mode => "sp_mult_add",
            adder_subtract => "false",
            ax_clock => "0",
            ay_clock => "0",
            az_clock => "0",
            adder_input_clock => "0",
            mult_pipeline_clock => "0",
            ax_chainin_pl_clock => "0",
            output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e,  ena(1) => '0', ena(2) => '0',
       aclr(0) => oPBo2_uid118_fpExpETest_reset, aclr(1) => oPBo2_uid118_fpExpETest_reset,
       ax => oneFP_uid101_fpExpETest_q,
       ay => b_uid116_fpExpETest_r,
       az => cstHalfFP_uid117_fpExpETest_q,
       resulta => oPBo2_uid118_fpExpETest_q);

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor(LOGICAL,468)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_b <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_q <= not (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_a or ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_b);

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_mem_top(CONSTANT,464)
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_mem_top_q <= "010";

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp(LOGICAL,465)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_a <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_mem_top_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_b <= STD_LOGIC_VECTOR("0" & ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q);
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_q <= "1" WHEN ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_a = ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_b ELSE "0";

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg(REG,466)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg_q <= STD_LOGIC_VECTOR(ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena(REG,469)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_nor_q = "1") THEN
                ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q <= STD_LOGIC_VECTOR(ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd(LOGICAL,470)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_a <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_sticky_ena_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_b <= en;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_q <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_a and ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_b;

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt(COUNTER,460)@14
    -- every=1, low=0, high=2, step=1, init=1
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i <= TO_UNSIGNED(1, 2);
            ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_eq <= '1';
                ELSE
                    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_eq = '1') THEN
                    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i - 2;
                ELSE
                    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_i, 2)));

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux(MUX,462)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_s <= en;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux: PROCESS (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_s, ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q, ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_q)
    BEGIN
        CASE (ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_s) IS
            WHEN "0" => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q;
            WHEN "1" => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_q;
            WHEN OTHERS => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg(REG,461)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q <= "00";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem(DUALMEM,459)@14
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ia <= STD_LOGIC_VECTOR(b_uid116_fpExpETest_r);
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_aa <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdreg_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ab <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_rdmux_q;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_reset0 <= areset;
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 32,
        widthad_b => 2,
        numwords_b => 3,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_aa,
        data_a => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_ab,
        q_b => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_iq
    );
    ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_q <= ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_iq(31 downto 0);

    -- eB_uid119_fpExpETest(FLOATMULTADD,118)@18
    eB_uid119_fpExpETest_reset <= areset;
    eB_uid119_fpExpETest_DSP : twentynm_fp_mac
     -- simple clock setup for mult add
     generic map (
        operation_mode => "sp_mult_add",
            adder_subtract => "false",
            ax_clock => "0",
            ay_clock => "0",
            az_clock => "0",
            adder_input_clock => "0",
            mult_pipeline_clock => "0",
            ax_chainin_pl_clock => "0",
            output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e,  ena(1) => '0', ena(2) => '0',
       aclr(0) => eB_uid119_fpExpETest_reset, aclr(1) => eB_uid119_fpExpETest_reset,
       ax => oneFP_uid101_fpExpETest_q,
       ay => ld_b_uid116_fpExpETest_r_to_eB_uid119_fpExpETest_a_replace_mem_q,
       az => oPBo2_uid118_fpExpETest_q,
       resulta => eB_uid119_fpExpETest_q);

    -- ld_signYP_uid88_fpExpETest_b_to_addrEATable_uid95_fpExpETest_b(DELAY,295)@11
    ld_signYP_uid88_fpExpETest_b_to_addrEATable_uid95_fpExpETest_b : dspba_delay
    GENERIC MAP ( width => 1, depth => 8 )
    PORT MAP ( xin => signYP_uid88_fpExpETest_b, xout => ld_signYP_uid88_fpExpETest_b_to_addrEATable_uid95_fpExpETest_b_q, ena => en(0), clk => clk, aclr => areset );

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor(LOGICAL,456)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_b <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_q <= not (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_a or ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_b);

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_mem_top(CONSTANT,452)
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_mem_top_q <= "0101";

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp(LOGICAL,453)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_a <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_mem_top_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_b <= STD_LOGIC_VECTOR("0" & ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q);
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_q <= "1" WHEN ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_a = ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_b ELSE "0";

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg(REG,454)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg_q <= STD_LOGIC_VECTOR(ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena(REG,457)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_nor_q = "1") THEN
                ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q <= STD_LOGIC_VECTOR(ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd(LOGICAL,458)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_a <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_sticky_ena_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_b <= en;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_q <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_a and ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_b;

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt(COUNTER,448)@11
    -- every=1, low=0, high=5, step=1, init=1
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i <= TO_UNSIGNED(1, 3);
            ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_eq <= '1';
                ELSE
                    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_eq = '1') THEN
                    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i - 5;
                ELSE
                    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_i, 3)));

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux(MUX,450)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_s <= en;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux: PROCESS (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_s, ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q, ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_q)
    BEGIN
        CASE (ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_s) IS
            WHEN "0" => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q;
            WHEN "1" => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_q;
            WHEN OTHERS => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1Idx3Pad3_uid202_fxpA_uid94_fpExpETest(CONSTANT,201)
    rightShiftStage1Idx3Pad3_uid202_fxpA_uid94_fpExpETest_q <= "000";

    -- RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest(BITSELECT,200)@11
    RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_in <= rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q;
    RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_b <= RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_in(7 downto 3);

    -- rightShiftStage1Idx3_uid203_fxpA_uid94_fpExpETest(BITJOIN,202)@11
    rightShiftStage1Idx3_uid203_fxpA_uid94_fpExpETest_q <= rightShiftStage1Idx3Pad3_uid202_fxpA_uid94_fpExpETest_q & RightShiftStage07dto3_uid201_fxpA_uid94_fpExpETest_b;

    -- RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest(BITSELECT,197)@11
    RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_in <= rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q;
    RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_b <= RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_in(7 downto 2);

    -- rightShiftStage1Idx2_uid200_fxpA_uid94_fpExpETest(BITJOIN,199)@11
    rightShiftStage1Idx2_uid200_fxpA_uid94_fpExpETest_q <= rightShiftStage0Idx1Pad2_uid169_fxpXRed_uid49_fpExpETest_q & RightShiftStage07dto2_uid198_fxpA_uid94_fpExpETest_b;

    -- RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest(BITSELECT,194)@11
    RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_in <= rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q;
    RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_b <= RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_in(7 downto 1);

    -- rightShiftStage1Idx1_uid197_fxpA_uid94_fpExpETest(BITJOIN,196)@11
    rightShiftStage1Idx1_uid197_fxpA_uid94_fpExpETest_q <= GND_q & RightShiftStage07dto1_uid195_fxpA_uid94_fpExpETest_b;

    -- X7dto4_uid188_fxpA_uid94_fpExpETest(BITSELECT,187)@11
    X7dto4_uid188_fxpA_uid94_fpExpETest_in <= fxpAPreAlign_uid91_fpExpETest_q;
    X7dto4_uid188_fxpA_uid94_fpExpETest_b <= X7dto4_uid188_fxpA_uid94_fpExpETest_in(7 downto 4);

    -- rightShiftStage0Idx1_uid190_fxpA_uid94_fpExpETest(BITJOIN,189)@11
    rightShiftStage0Idx1_uid190_fxpA_uid94_fpExpETest_q <= rightShiftStage0Idx2Pad4_uid172_fxpXRed_uid49_fpExpETest_q & X7dto4_uid188_fxpA_uid94_fpExpETest_b;

    -- fxpAPreAlign_uid91_fpExpETest(BITJOIN,90)@11
    fxpAPreAlign_uid91_fpExpETest_q <= VCC_q & fracYPTop_uid90_fpExpETest_b;

    -- cstBiasM1_uid10_fpExpETest(CONSTANT,9)
    cstBiasM1_uid10_fpExpETest_q <= "01111110";

    -- shiftValFxpA_uid92_fpExpETest(SUB,91)@11
    shiftValFxpA_uid92_fpExpETest_a <= STD_LOGIC_VECTOR("0" & cstBiasM1_uid10_fpExpETest_q);
    shiftValFxpA_uid92_fpExpETest_b <= STD_LOGIC_VECTOR("0" & expYP_uid87_fpExpETest_b);
    shiftValFxpA_uid92_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftValFxpA_uid92_fpExpETest_a) - UNSIGNED(shiftValFxpA_uid92_fpExpETest_b));
    shiftValFxpA_uid92_fpExpETest_q <= shiftValFxpA_uid92_fpExpETest_o(8 downto 0);

    -- shiftValFxpAR_uid93_fpExpETest(BITSELECT,92)@11
    shiftValFxpAR_uid93_fpExpETest_in <= shiftValFxpA_uid92_fpExpETest_q(3 downto 0);
    shiftValFxpAR_uid93_fpExpETest_b <= shiftValFxpAR_uid93_fpExpETest_in(3 downto 0);

    -- rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest(BITSELECT,192)@11
    rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_in <= shiftValFxpAR_uid93_fpExpETest_b;
    rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_b <= rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_in(3 downto 2);

    -- rightShiftStage0_uid194_fxpA_uid94_fpExpETest(MUX,193)@11
    rightShiftStage0_uid194_fxpA_uid94_fpExpETest_s <= rightShiftStageSel3Dto2_uid193_fxpA_uid94_fpExpETest_b;
    rightShiftStage0_uid194_fxpA_uid94_fpExpETest: PROCESS (rightShiftStage0_uid194_fxpA_uid94_fpExpETest_s, en, fxpAPreAlign_uid91_fpExpETest_q, rightShiftStage0Idx1_uid190_fxpA_uid94_fpExpETest_q, cstZeroWE_uid14_fpExpETest_q)
    BEGIN
        CASE (rightShiftStage0_uid194_fxpA_uid94_fpExpETest_s) IS
            WHEN "00" => rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q <= fxpAPreAlign_uid91_fpExpETest_q;
            WHEN "01" => rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q <= rightShiftStage0Idx1_uid190_fxpA_uid94_fpExpETest_q;
            WHEN "10" => rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q <= cstZeroWE_uid14_fpExpETest_q;
            WHEN "11" => rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q <= cstZeroWE_uid14_fpExpETest_q;
            WHEN OTHERS => rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest(BITSELECT,203)@11
    rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_in <= shiftValFxpAR_uid93_fpExpETest_b(1 downto 0);
    rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_b <= rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_in(1 downto 0);

    -- rightShiftStage1_uid205_fxpA_uid94_fpExpETest(MUX,204)@11
    rightShiftStage1_uid205_fxpA_uid94_fpExpETest_s <= rightShiftStageSel1Dto0_uid204_fxpA_uid94_fpExpETest_b;
    rightShiftStage1_uid205_fxpA_uid94_fpExpETest: PROCESS (rightShiftStage1_uid205_fxpA_uid94_fpExpETest_s, en, rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q, rightShiftStage1Idx1_uid197_fxpA_uid94_fpExpETest_q, rightShiftStage1Idx2_uid200_fxpA_uid94_fpExpETest_q, rightShiftStage1Idx3_uid203_fxpA_uid94_fpExpETest_q)
    BEGIN
        CASE (rightShiftStage1_uid205_fxpA_uid94_fpExpETest_s) IS
            WHEN "00" => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q <= rightShiftStage0_uid194_fxpA_uid94_fpExpETest_q;
            WHEN "01" => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q <= rightShiftStage1Idx1_uid197_fxpA_uid94_fpExpETest_q;
            WHEN "10" => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q <= rightShiftStage1Idx2_uid200_fxpA_uid94_fpExpETest_q;
            WHEN "11" => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q <= rightShiftStage1Idx3_uid203_fxpA_uid94_fpExpETest_q;
            WHEN OTHERS => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_inputreg(DELAY,446)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_inputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1 )
    PORT MAP ( xin => rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q, xout => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_inputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg(REG,449)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q <= "000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem(DUALMEM,447)@11
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ia <= STD_LOGIC_VECTOR(ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_inputreg_q);
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_aa <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdreg_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ab <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_rdmux_q;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_reset0 <= areset;
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 6,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_aa,
        data_a => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_ab,
        q_b => ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_iq
    );
    ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_q <= ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_iq(7 downto 0);

    -- addrEATable_uid95_fpExpETest(BITJOIN,94)@19
    addrEATable_uid95_fpExpETest_q <= ld_signYP_uid88_fpExpETest_b_to_addrEATable_uid95_fpExpETest_b_q & ld_rightShiftStage1_uid205_fxpA_uid94_fpExpETest_q_to_addrEATable_uid95_fpExpETest_a_replace_mem_q;

    -- reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0(REG,212)@19
    reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0_q <= "000000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0_q <= STD_LOGIC_VECTOR(addrEATable_uid95_fpExpETest_q);
            END IF;
        END IF;
    END PROCESS;

    -- floatTable_eA_uid96_fpExpETest_lutmem(DUALMEM,206)@20
    floatTable_eA_uid96_fpExpETest_lutmem_aa <= reg_addrEATable_uid95_fpExpETest_0_to_floatTable_eA_uid96_fpExpETest_lutmem_0_q;
    floatTable_eA_uid96_fpExpETest_lutmem_reset0 <= areset;
    floatTable_eA_uid96_fpExpETest_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 32,
        widthad_a => 9,
        numwords_a => 512,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_aclr_a => "CLEAR0",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => "acl_fp_exp_a10_floatTable_eA_uid96_fpExpETest_lutmem.hex",
        init_file_layout => "PORT_A",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken0 => en(0),
        aclr0 => floatTable_eA_uid96_fpExpETest_lutmem_reset0,
        clock0 => clk,
        address_a => floatTable_eA_uid96_fpExpETest_lutmem_aa,
        q_a => floatTable_eA_uid96_fpExpETest_lutmem_iq
    );
    floatTable_eA_uid96_fpExpETest_lutmem_q <= floatTable_eA_uid96_fpExpETest_lutmem_iq(31 downto 0);

    -- ld_udfA_uid100_fpExpETest_n_to_eAPostUdfA_uid102_fpExpETest_s(DELAY,297)@11
    ld_udfA_uid100_fpExpETest_n_to_eAPostUdfA_uid102_fpExpETest_s : dspba_delay
    GENERIC MAP ( width => 1, depth => 11 )
    PORT MAP ( xin => udfA_uid100_fpExpETest_n, xout => ld_udfA_uid100_fpExpETest_n_to_eAPostUdfA_uid102_fpExpETest_s_q, ena => en(0), clk => clk, aclr => areset );

    -- eAPostUdfA_uid102_fpExpETest(MUX,101)@22
    eAPostUdfA_uid102_fpExpETest_s <= ld_udfA_uid100_fpExpETest_n_to_eAPostUdfA_uid102_fpExpETest_s_q;
    eAPostUdfA_uid102_fpExpETest: PROCESS (eAPostUdfA_uid102_fpExpETest_s, en, floatTable_eA_uid96_fpExpETest_lutmem_q, oneFP_uid101_fpExpETest_q)
    BEGIN
        CASE (eAPostUdfA_uid102_fpExpETest_s) IS
            WHEN "0" => eAPostUdfA_uid102_fpExpETest_q <= floatTable_eA_uid96_fpExpETest_lutmem_q;
            WHEN "1" => eAPostUdfA_uid102_fpExpETest_q <= oneFP_uid101_fpExpETest_q;
            WHEN OTHERS => eAPostUdfA_uid102_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- eY_uid120_fpExpETest(FLOATMULT,119)@22
    eY_uid120_fpExpETest_reset <= areset;
    eY_uid120_fpExpETest_DSP : twentynm_fp_mac
    -- simple clock setup for mult
    generic map (
        operation_mode => "sp_mult",
        ax_clock => "none",
        ay_clock => "0",
        az_clock => "0", 
        mult_pipeline_clock => "0",
        output_clock => "0")
    port map (
       clk(0) => clk, clk(1) => '0', clk(2) => '0',
       ena(0) => e, ena(1) => '0', ena(2) => '0',
       aclr(0) => eY_uid120_fpExpETest_reset, aclr(1) => eY_uid120_fpExpETest_reset,
       ay => eAPostUdfA_uid102_fpExpETest_q,
       az => eB_uid119_fpExpETest_q,
       resulta => eY_uid120_fpExpETest_q);

    -- signEY_uid147_fpExpETest(BITSELECT,146)@25
    signEY_uid147_fpExpETest_in <= STD_LOGIC_VECTOR(eY_uid120_fpExpETest_q);
    signEY_uid147_fpExpETest_b <= signEY_uid147_fpExpETest_in(31 downto 31);

    -- cstAllOWE_uid17_fpExpETest(CONSTANT,16)
    cstAllOWE_uid17_fpExpETest_q <= "11111111";

    -- cstBias_uid9_fpExpETest(CONSTANT,8)
    cstBias_uid9_fpExpETest_q <= "01111111";

    -- biasM2_uid124_fpExpETest(CONSTANT,123)
    biasM2_uid124_fpExpETest_q <= "01111101";

    -- biasP1_uid125_fpExpETest(CONSTANT,124)
    biasP1_uid125_fpExpETest_q <= "10000000";

    -- expEY_uid121_fpExpETest(BITSELECT,120)@25
    expEY_uid121_fpExpETest_in <= eY_uid120_fpExpETest_q;
    expEY_uid121_fpExpETest_b <= expEY_uid121_fpExpETest_in(30 downto 23);

    -- lowerBitOfeY_uid122_fpExpETest(BITSELECT,121)@25
    lowerBitOfeY_uid122_fpExpETest_in <= expEY_uid121_fpExpETest_b(1 downto 0);
    lowerBitOfeY_uid122_fpExpETest_b <= lowerBitOfeY_uid122_fpExpETest_in(1 downto 0);

    -- expUpdateVal_uid126_fpExpETest(MUX,125)@25
    expUpdateVal_uid126_fpExpETest_s <= lowerBitOfeY_uid122_fpExpETest_b;
    expUpdateVal_uid126_fpExpETest: PROCESS (expUpdateVal_uid126_fpExpETest_s, en, biasP1_uid125_fpExpETest_q, biasM2_uid124_fpExpETest_q, cstBiasM1_uid10_fpExpETest_q, cstBias_uid9_fpExpETest_q)
    BEGIN
        CASE (expUpdateVal_uid126_fpExpETest_s) IS
            WHEN "00" => expUpdateVal_uid126_fpExpETest_q <= biasP1_uid125_fpExpETest_q;
            WHEN "01" => expUpdateVal_uid126_fpExpETest_q <= biasM2_uid124_fpExpETest_q;
            WHEN "10" => expUpdateVal_uid126_fpExpETest_q <= cstBiasM1_uid10_fpExpETest_q;
            WHEN "11" => expUpdateVal_uid126_fpExpETest_q <= cstBias_uid9_fpExpETest_q;
            WHEN OTHERS => expUpdateVal_uid126_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor(LOGICAL,482)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_b <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_q <= not (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_a or ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_b);

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_mem_top(CONSTANT,478)
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_mem_top_q <= "010011";

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp(LOGICAL,479)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_a <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_mem_top_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_b <= STD_LOGIC_VECTOR("0" & ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q);
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_q <= "1" WHEN ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_a = ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_b ELSE "0";

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg(REG,480)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg_q <= STD_LOGIC_VECTOR(ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena(REG,483)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_nor_q = "1") THEN
                ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q <= STD_LOGIC_VECTOR(ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd(LOGICAL,484)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_a <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_sticky_ena_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_b <= en;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_q <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_a and ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_b;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt(COUNTER,474)@2
    -- every=1, low=0, high=19, step=1, init=1
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i <= TO_UNSIGNED(1, 5);
            ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i = TO_UNSIGNED(18, 5)) THEN
                    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_eq <= '1';
                ELSE
                    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_eq = '1') THEN
                    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i - 19;
                ELSE
                    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_i, 5)));

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux(MUX,476)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_s <= en;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux: PROCESS (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_s, ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q, ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_q)
    BEGIN
        CASE (ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_s) IS
            WHEN "0" => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q;
            WHEN "1" => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_q;
            WHEN OTHERS => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_inputreg(DELAY,471)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_inputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1 )
    PORT MAP ( xin => expTmp_uid57_fpExpETest_b, xout => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_inputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg(REG,475)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q <= "00000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem(DUALMEM,473)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ia <= STD_LOGIC_VECTOR(ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_inputreg_q);
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_aa <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdreg_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ab <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_rdmux_q;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_reset0 <= areset;
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 20,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 20,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_aa,
        data_a => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_ab,
        q_b => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_iq
    );
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_q <= ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_iq(7 downto 0);

    -- ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg(DELAY,472)@2
    ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1 )
    PORT MAP ( xin => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_replace_mem_q, xout => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- updatedExponent_uid127_fpExpETest(ADD,126)@25
    updatedExponent_uid127_fpExpETest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 8 => ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg_q(7)) & ld_expTmp_uid57_fpExpETest_b_to_updatedExponent_uid127_fpExpETest_a_outputreg_q));
    updatedExponent_uid127_fpExpETest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & "00" & expUpdateVal_uid126_fpExpETest_q));
    updatedExponent_uid127_fpExpETest_o <= STD_LOGIC_VECTOR(SIGNED(updatedExponent_uid127_fpExpETest_a) + SIGNED(updatedExponent_uid127_fpExpETest_b));
    updatedExponent_uid127_fpExpETest_q <= updatedExponent_uid127_fpExpETest_o(9 downto 0);

    -- expR_uid128_fpExpETest(BITSELECT,127)@25
    expR_uid128_fpExpETest_in <= updatedExponent_uid127_fpExpETest_q(7 downto 0);
    expR_uid128_fpExpETest_b <= expR_uid128_fpExpETest_in(7 downto 0);

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor(LOGICAL,494)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_b <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_q <= not (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_a or ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_b);

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_mem_top(CONSTANT,490)
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_mem_top_q <= "010101";

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp(LOGICAL,491)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_a <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_mem_top_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_b <= STD_LOGIC_VECTOR("0" & ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q);
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_q <= "1" WHEN ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_a = ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_b ELSE "0";

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg(REG,492)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg_q <= STD_LOGIC_VECTOR(ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena(REG,495)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_nor_q = "1") THEN
                ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q <= STD_LOGIC_VECTOR(ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd(LOGICAL,496)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_a <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_sticky_ena_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_b <= en;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_q <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_a and ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_b;

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt(COUNTER,486)@1
    -- every=1, low=0, high=21, step=1, init=1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i <= TO_UNSIGNED(1, 5);
            ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i = TO_UNSIGNED(20, 5)) THEN
                    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_eq <= '1';
                ELSE
                    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_eq = '1') THEN
                    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i - 21;
                ELSE
                    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_i, 5)));

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux(MUX,488)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_s <= en;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux: PROCESS (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_s, ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q, ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_q)
    BEGIN
        CASE (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_s) IS
            WHEN "0" => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q;
            WHEN "1" => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_q;
            WHEN OTHERS => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- cstOneWF_uid18_fpExpETest(CONSTANT,17)
    cstOneWF_uid18_fpExpETest_q <= "00000000000000000000001";

    -- fracXIsNotZero_uid25_fpExpETest(COMPARE,24)@0
    fracXIsNotZero_uid25_fpExpETest_cin <= GND_q;
    fracXIsNotZero_uid25_fpExpETest_a <= STD_LOGIC_VECTOR("00" & fracX_uid8_fpExpETest_b) & '0';
    fracXIsNotZero_uid25_fpExpETest_b <= STD_LOGIC_VECTOR("00" & cstOneWF_uid18_fpExpETest_q) & fracXIsNotZero_uid25_fpExpETest_cin(0);
    fracXIsNotZero_uid25_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(fracXIsNotZero_uid25_fpExpETest_a) - UNSIGNED(fracXIsNotZero_uid25_fpExpETest_b));
    fracXIsNotZero_uid25_fpExpETest_n(0) <= not (fracXIsNotZero_uid25_fpExpETest_o(25));

    -- fracXIsZero_uid26_fpExpETest(LOGICAL,25)@0
    fracXIsZero_uid26_fpExpETest_a <= fracXIsNotZero_uid25_fpExpETest_n;
    fracXIsZero_uid26_fpExpETest_q <= not (fracXIsZero_uid26_fpExpETest_a);

    -- InvFracXIsZero_uid28_fpExpETest(LOGICAL,27)@0
    InvFracXIsZero_uid28_fpExpETest_a <= fracXIsZero_uid26_fpExpETest_q;
    InvFracXIsZero_uid28_fpExpETest_q <= not (InvFracXIsZero_uid28_fpExpETest_a);

    -- expXIsMax_uid23_fpExpETest(LOGICAL,22)@0
    expXIsMax_uid23_fpExpETest_a <= expX_uid6_fpExpETest_b;
    expXIsMax_uid23_fpExpETest_b <= cstAllOWE_uid17_fpExpETest_q;
    expXIsMax_uid23_fpExpETest_q <= "1" WHEN expXIsMax_uid23_fpExpETest_a = expXIsMax_uid23_fpExpETest_b ELSE "0";

    -- exc_N_uid29_fpExpETest(LOGICAL,28)@0
    exc_N_uid29_fpExpETest_a <= expXIsMax_uid23_fpExpETest_q;
    exc_N_uid29_fpExpETest_b <= InvFracXIsZero_uid28_fpExpETest_q;
    exc_N_uid29_fpExpETest_q <= exc_N_uid29_fpExpETest_a and exc_N_uid29_fpExpETest_b;

    -- expFracX_uid34_fpExpETest(BITJOIN,33)@0
    expFracX_uid34_fpExpETest_q <= expX_uid6_fpExpETest_b & fracX_uid8_fpExpETest_b;

    -- maxInput_uid35_fpExpETest(CONSTANT,34)
    maxInput_uid35_fpExpETest_q <= "1000010101100010111001000010111";

    -- expMaxInput_uid36_fpExpETest(COMPARE,35)@0
    expMaxInput_uid36_fpExpETest_cin <= GND_q;
    expMaxInput_uid36_fpExpETest_a <= STD_LOGIC_VECTOR("00" & maxInput_uid35_fpExpETest_q) & '0';
    expMaxInput_uid36_fpExpETest_b <= STD_LOGIC_VECTOR("00" & expFracX_uid34_fpExpETest_q) & expMaxInput_uid36_fpExpETest_cin(0);
    expMaxInput_uid36_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(expMaxInput_uid36_fpExpETest_a) - UNSIGNED(expMaxInput_uid36_fpExpETest_b));
    expMaxInput_uid36_fpExpETest_c(0) <= expMaxInput_uid36_fpExpETest_o(33);

    -- InvSignX_uid37_fpExpETest(LOGICAL,36)@0
    InvSignX_uid37_fpExpETest_a <= signX_uid7_fpExpETest_b;
    InvSignX_uid37_fpExpETest_q <= not (InvSignX_uid37_fpExpETest_a);

    -- inputOveflow_uid38_fpExpETest(LOGICAL,37)@0
    inputOveflow_uid38_fpExpETest_a <= InvSignX_uid37_fpExpETest_q;
    inputOveflow_uid38_fpExpETest_b <= expMaxInput_uid36_fpExpETest_c;
    inputOveflow_uid38_fpExpETest_q <= inputOveflow_uid38_fpExpETest_a and inputOveflow_uid38_fpExpETest_b;

    -- InvExc_N_uid30_fpExpETest(LOGICAL,29)@0
    InvExc_N_uid30_fpExpETest_a <= exc_N_uid29_fpExpETest_q;
    InvExc_N_uid30_fpExpETest_q <= not (InvExc_N_uid30_fpExpETest_a);

    -- exc_I_uid27_fpExpETest(LOGICAL,26)@0
    exc_I_uid27_fpExpETest_a <= expXIsMax_uid23_fpExpETest_q;
    exc_I_uid27_fpExpETest_b <= fracXIsZero_uid26_fpExpETest_q;
    exc_I_uid27_fpExpETest_q <= exc_I_uid27_fpExpETest_a and exc_I_uid27_fpExpETest_b;

    -- InvExc_I_uid31_fpExpETest(LOGICAL,30)@0
    InvExc_I_uid31_fpExpETest_a <= exc_I_uid27_fpExpETest_q;
    InvExc_I_uid31_fpExpETest_q <= not (InvExc_I_uid31_fpExpETest_a);

    -- expXIsZero_uid21_fpExpETest(LOGICAL,20)@0
    expXIsZero_uid21_fpExpETest_a <= expX_uid6_fpExpETest_b;
    expXIsZero_uid21_fpExpETest_b <= cstZeroWE_uid14_fpExpETest_q;
    expXIsZero_uid21_fpExpETest_q <= "1" WHEN expXIsZero_uid21_fpExpETest_a = expXIsZero_uid21_fpExpETest_b ELSE "0";

    -- InvExpXIsZero_uid32_fpExpETest(LOGICAL,31)@0
    InvExpXIsZero_uid32_fpExpETest_a <= expXIsZero_uid21_fpExpETest_q;
    InvExpXIsZero_uid32_fpExpETest_q <= not (InvExpXIsZero_uid32_fpExpETest_a);

    -- exc_R_uid33_fpExpETest(LOGICAL,32)@0
    exc_R_uid33_fpExpETest_a <= InvExpXIsZero_uid32_fpExpETest_q;
    exc_R_uid33_fpExpETest_b <= InvExc_I_uid31_fpExpETest_q;
    exc_R_uid33_fpExpETest_c <= InvExc_N_uid30_fpExpETest_q;
    exc_R_uid33_fpExpETest_q <= exc_R_uid33_fpExpETest_a and exc_R_uid33_fpExpETest_b and exc_R_uid33_fpExpETest_c;

    -- regXAndExpOverflowAndPos_uid132_fpExpETest(LOGICAL,131)@0
    regXAndExpOverflowAndPos_uid132_fpExpETest_a <= exc_R_uid33_fpExpETest_q;
    regXAndExpOverflowAndPos_uid132_fpExpETest_b <= inputOveflow_uid38_fpExpETest_q;
    regXAndExpOverflowAndPos_uid132_fpExpETest_q <= regXAndExpOverflowAndPos_uid132_fpExpETest_a and regXAndExpOverflowAndPos_uid132_fpExpETest_b;

    -- posInf_uid134_fpExpETest(LOGICAL,133)@0
    posInf_uid134_fpExpETest_a <= exc_I_uid27_fpExpETest_q;
    posInf_uid134_fpExpETest_b <= InvSignX_uid37_fpExpETest_q;
    posInf_uid134_fpExpETest_q <= posInf_uid134_fpExpETest_a and posInf_uid134_fpExpETest_b;

    -- excRInf_uid135_fpExpETest(LOGICAL,134)@0
    excRInf_uid135_fpExpETest_a <= posInf_uid134_fpExpETest_q;
    excRInf_uid135_fpExpETest_b <= regXAndExpOverflowAndPos_uid132_fpExpETest_q;
    excRInf_uid135_fpExpETest_q <= excRInf_uid135_fpExpETest_a or excRInf_uid135_fpExpETest_b;

    -- negInf_uid129_fpExpETest(LOGICAL,128)@0
    negInf_uid129_fpExpETest_a <= exc_I_uid27_fpExpETest_q;
    negInf_uid129_fpExpETest_b <= signX_uid7_fpExpETest_b;
    negInf_uid129_fpExpETest_q <= negInf_uid129_fpExpETest_a and negInf_uid129_fpExpETest_b;

    -- minInput_uid39_fpExpETest(CONSTANT,38)
    minInput_uid39_fpExpETest_q <= "1000010101100000000111100110011";

    -- expMinInput_uid40_fpExpETest(COMPARE,39)@0
    expMinInput_uid40_fpExpETest_cin <= GND_q;
    expMinInput_uid40_fpExpETest_a <= STD_LOGIC_VECTOR("00" & minInput_uid39_fpExpETest_q) & '0';
    expMinInput_uid40_fpExpETest_b <= STD_LOGIC_VECTOR("00" & expFracX_uid34_fpExpETest_q) & expMinInput_uid40_fpExpETest_cin(0);
    expMinInput_uid40_fpExpETest_o <= STD_LOGIC_VECTOR(UNSIGNED(expMinInput_uid40_fpExpETest_a) - UNSIGNED(expMinInput_uid40_fpExpETest_b));
    expMinInput_uid40_fpExpETest_c(0) <= expMinInput_uid40_fpExpETest_o(33);

    -- inputUndeflow_uid41_fpExpETest(LOGICAL,40)@0
    inputUndeflow_uid41_fpExpETest_a <= signX_uid7_fpExpETest_b;
    inputUndeflow_uid41_fpExpETest_b <= expMinInput_uid40_fpExpETest_c;
    inputUndeflow_uid41_fpExpETest_q <= inputUndeflow_uid41_fpExpETest_a and inputUndeflow_uid41_fpExpETest_b;

    -- regXAndExpOverflowAndNeg_uid130_fpExpETest(LOGICAL,129)@0
    regXAndExpOverflowAndNeg_uid130_fpExpETest_a <= exc_R_uid33_fpExpETest_q;
    regXAndExpOverflowAndNeg_uid130_fpExpETest_b <= inputUndeflow_uid41_fpExpETest_q;
    regXAndExpOverflowAndNeg_uid130_fpExpETest_q <= regXAndExpOverflowAndNeg_uid130_fpExpETest_a and regXAndExpOverflowAndNeg_uid130_fpExpETest_b;

    -- excRZero_uid131_fpExpETest(LOGICAL,130)@0
    excRZero_uid131_fpExpETest_a <= regXAndExpOverflowAndNeg_uid130_fpExpETest_q;
    excRZero_uid131_fpExpETest_b <= negInf_uid129_fpExpETest_q;
    excRZero_uid131_fpExpETest_q <= excRZero_uid131_fpExpETest_a or excRZero_uid131_fpExpETest_b;

    -- concExc_uid136_fpExpETest(BITJOIN,135)@0
    concExc_uid136_fpExpETest_q <= exc_N_uid29_fpExpETest_q & excRInf_uid135_fpExpETest_q & excRZero_uid131_fpExpETest_q;

    -- reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0(REG,207)@0
    reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q <= "000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q <= STD_LOGIC_VECTOR(concExc_uid136_fpExpETest_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg(REG,487)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q <= "00000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem(DUALMEM,485)@1
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ia <= STD_LOGIC_VECTOR(reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q);
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_aa <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdreg_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ab <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_rdmux_q;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_reset0 <= areset;
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 3,
        widthad_a => 5,
        numwords_a => 22,
        width_b => 3,
        widthad_b => 5,
        numwords_b => 22,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_aa,
        data_a => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_ab,
        q_b => ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_iq
    );
    ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_q <= ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_iq(2 downto 0);

    -- excREnc_uid137_fpExpETest(LOOKUP,136)@24
    excREnc_uid137_fpExpETest: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            excREnc_uid137_fpExpETest_q <= "01";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (ld_reg_concExc_uid136_fpExpETest_0_to_excREnc_uid137_fpExpETest_0_q_to_excREnc_uid137_fpExpETest_a_replace_mem_q) IS
                    WHEN "000" => excREnc_uid137_fpExpETest_q <= "01";
                    WHEN "001" => excREnc_uid137_fpExpETest_q <= "00";
                    WHEN "010" => excREnc_uid137_fpExpETest_q <= "10";
                    WHEN "011" => excREnc_uid137_fpExpETest_q <= "00";
                    WHEN "100" => excREnc_uid137_fpExpETest_q <= "11";
                    WHEN "101" => excREnc_uid137_fpExpETest_q <= "00";
                    WHEN "110" => excREnc_uid137_fpExpETest_q <= "00";
                    WHEN "111" => excREnc_uid137_fpExpETest_q <= "00";
                    WHEN OTHERS => excREnc_uid137_fpExpETest_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- expRPostExc_uid146_fpExpETest(MUX,145)@25
    expRPostExc_uid146_fpExpETest_s <= excREnc_uid137_fpExpETest_q;
    expRPostExc_uid146_fpExpETest: PROCESS (expRPostExc_uid146_fpExpETest_s, en, cstZeroWE_uid14_fpExpETest_q, expR_uid128_fpExpETest_b, cstAllOWE_uid17_fpExpETest_q)
    BEGIN
        CASE (expRPostExc_uid146_fpExpETest_s) IS
            WHEN "00" => expRPostExc_uid146_fpExpETest_q <= cstZeroWE_uid14_fpExpETest_q;
            WHEN "01" => expRPostExc_uid146_fpExpETest_q <= expR_uid128_fpExpETest_b;
            WHEN "10" => expRPostExc_uid146_fpExpETest_q <= cstAllOWE_uid17_fpExpETest_q;
            WHEN "11" => expRPostExc_uid146_fpExpETest_q <= cstAllOWE_uid17_fpExpETest_q;
            WHEN OTHERS => expRPostExc_uid146_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracEY_uid140_fpExpETest(BITSELECT,139)@25
    fracEY_uid140_fpExpETest_in <= eY_uid120_fpExpETest_q;
    fracEY_uid140_fpExpETest_b <= fracEY_uid140_fpExpETest_in(22 downto 0);

    -- zeroFracRPostExc_uid139_fpExpETest(CONSTANT,138)
    zeroFracRPostExc_uid139_fpExpETest_q <= "00000000000000000000000";

    -- fracRPostExc_uid142_fpExpETest(MUX,141)@25
    fracRPostExc_uid142_fpExpETest_s <= excREnc_uid137_fpExpETest_q;
    fracRPostExc_uid142_fpExpETest: PROCESS (fracRPostExc_uid142_fpExpETest_s, en, zeroFracRPostExc_uid139_fpExpETest_q, fracEY_uid140_fpExpETest_b, cstOneWF_uid18_fpExpETest_q)
    BEGIN
        CASE (fracRPostExc_uid142_fpExpETest_s) IS
            WHEN "00" => fracRPostExc_uid142_fpExpETest_q <= zeroFracRPostExc_uid139_fpExpETest_q;
            WHEN "01" => fracRPostExc_uid142_fpExpETest_q <= fracEY_uid140_fpExpETest_b;
            WHEN "10" => fracRPostExc_uid142_fpExpETest_q <= zeroFracRPostExc_uid139_fpExpETest_q;
            WHEN "11" => fracRPostExc_uid142_fpExpETest_q <= cstOneWF_uid18_fpExpETest_q;
            WHEN OTHERS => fracRPostExc_uid142_fpExpETest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- finalResult_uid148_fpExpETest(BITJOIN,147)@25
    finalResult_uid148_fpExpETest_q <= signEY_uid147_fpExpETest_b & expRPostExc_uid146_fpExpETest_q & fracRPostExc_uid142_fpExpETest_q;

    -- expER_uid150_fpExpETest(BITSELECT,149)@25
    expER_uid150_fpExpETest_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => finalResult_uid148_fpExpETest_q(31)) & finalResult_uid148_fpExpETest_q));
    expER_uid150_fpExpETest_b <= expER_uid150_fpExpETest_in(31 downto 0);

    -- ld_xIn_c_to_xOut_c_nor(LOGICAL,431)@0
    ld_xIn_c_to_xOut_c_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_xIn_c_to_xOut_c_nor_b <= ld_xIn_c_to_xOut_c_sticky_ena_q;
    ld_xIn_c_to_xOut_c_nor_q <= not (ld_xIn_c_to_xOut_c_nor_a or ld_xIn_c_to_xOut_c_nor_b);

    -- ld_xIn_v_to_xOut_v_mem_top(CONSTANT,415)
    ld_xIn_v_to_xOut_v_mem_top_q <= "010111";

    -- ld_xIn_v_to_xOut_v_cmp(LOGICAL,416)@0
    ld_xIn_v_to_xOut_v_cmp_a <= ld_xIn_v_to_xOut_v_mem_top_q;
    ld_xIn_v_to_xOut_v_cmp_b <= STD_LOGIC_VECTOR("0" & ld_xIn_v_to_xOut_v_replace_rdmux_q);
    ld_xIn_v_to_xOut_v_cmp_q <= "1" WHEN ld_xIn_v_to_xOut_v_cmp_a = ld_xIn_v_to_xOut_v_cmp_b ELSE "0";

    -- ld_xIn_v_to_xOut_v_cmpReg(REG,417)@0
    ld_xIn_v_to_xOut_v_cmpReg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_v_to_xOut_v_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_xIn_v_to_xOut_v_cmpReg_q <= STD_LOGIC_VECTOR(ld_xIn_v_to_xOut_v_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_c_to_xOut_c_sticky_ena(REG,432)@0
    ld_xIn_c_to_xOut_c_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_c_to_xOut_c_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_xIn_c_to_xOut_c_nor_q = "1") THEN
                ld_xIn_c_to_xOut_c_sticky_ena_q <= STD_LOGIC_VECTOR(ld_xIn_v_to_xOut_v_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_c_to_xOut_c_enaAnd(LOGICAL,433)@0
    ld_xIn_c_to_xOut_c_enaAnd_a <= ld_xIn_c_to_xOut_c_sticky_ena_q;
    ld_xIn_c_to_xOut_c_enaAnd_b <= en;
    ld_xIn_c_to_xOut_c_enaAnd_q <= ld_xIn_c_to_xOut_c_enaAnd_a and ld_xIn_c_to_xOut_c_enaAnd_b;

    -- ld_xIn_v_to_xOut_v_replace_rdcnt(COUNTER,411)@0
    -- every=1, low=0, high=23, step=1, init=1
    ld_xIn_v_to_xOut_v_replace_rdcnt: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_v_to_xOut_v_replace_rdcnt_i <= TO_UNSIGNED(1, 5);
            ld_xIn_v_to_xOut_v_replace_rdcnt_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (ld_xIn_v_to_xOut_v_replace_rdcnt_i = TO_UNSIGNED(22, 5)) THEN
                    ld_xIn_v_to_xOut_v_replace_rdcnt_eq <= '1';
                ELSE
                    ld_xIn_v_to_xOut_v_replace_rdcnt_eq <= '0';
                END IF;
                IF (ld_xIn_v_to_xOut_v_replace_rdcnt_eq = '1') THEN
                    ld_xIn_v_to_xOut_v_replace_rdcnt_i <= ld_xIn_v_to_xOut_v_replace_rdcnt_i - 23;
                ELSE
                    ld_xIn_v_to_xOut_v_replace_rdcnt_i <= ld_xIn_v_to_xOut_v_replace_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    ld_xIn_v_to_xOut_v_replace_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(ld_xIn_v_to_xOut_v_replace_rdcnt_i, 5)));

    -- ld_xIn_v_to_xOut_v_replace_rdmux(MUX,413)@0
    ld_xIn_v_to_xOut_v_replace_rdmux_s <= en;
    ld_xIn_v_to_xOut_v_replace_rdmux: PROCESS (ld_xIn_v_to_xOut_v_replace_rdmux_s, ld_xIn_v_to_xOut_v_replace_rdreg_q, ld_xIn_v_to_xOut_v_replace_rdcnt_q)
    BEGIN
        CASE (ld_xIn_v_to_xOut_v_replace_rdmux_s) IS
            WHEN "0" => ld_xIn_v_to_xOut_v_replace_rdmux_q <= ld_xIn_v_to_xOut_v_replace_rdreg_q;
            WHEN "1" => ld_xIn_v_to_xOut_v_replace_rdmux_q <= ld_xIn_v_to_xOut_v_replace_rdcnt_q;
            WHEN OTHERS => ld_xIn_v_to_xOut_v_replace_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- ld_xIn_v_to_xOut_v_replace_rdreg(REG,412)@0
    ld_xIn_v_to_xOut_v_replace_rdreg: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_v_to_xOut_v_replace_rdreg_q <= "00000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                ld_xIn_v_to_xOut_v_replace_rdreg_q <= STD_LOGIC_VECTOR(ld_xIn_v_to_xOut_v_replace_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_c_to_xOut_c_replace_mem(DUALMEM,422)@0
    ld_xIn_c_to_xOut_c_replace_mem_ia <= STD_LOGIC_VECTOR(xIn_c);
    ld_xIn_c_to_xOut_c_replace_mem_aa <= ld_xIn_v_to_xOut_v_replace_rdreg_q;
    ld_xIn_c_to_xOut_c_replace_mem_ab <= ld_xIn_v_to_xOut_v_replace_rdmux_q;
    ld_xIn_c_to_xOut_c_replace_mem_reset0 <= areset;
    ld_xIn_c_to_xOut_c_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 24,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 24,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_xIn_c_to_xOut_c_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_xIn_c_to_xOut_c_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_xIn_c_to_xOut_c_replace_mem_aa,
        data_a => ld_xIn_c_to_xOut_c_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_xIn_c_to_xOut_c_replace_mem_ab,
        q_b => ld_xIn_c_to_xOut_c_replace_mem_iq
    );
    ld_xIn_c_to_xOut_c_replace_mem_q <= ld_xIn_c_to_xOut_c_replace_mem_iq(7 downto 0);

    -- ld_xIn_v_to_xOut_v_nor(LOGICAL,419)@0
    ld_xIn_v_to_xOut_v_nor_a <= ld_xIn_v_to_xOut_v_notEnable_q;
    ld_xIn_v_to_xOut_v_nor_b <= ld_xIn_v_to_xOut_v_sticky_ena_q;
    ld_xIn_v_to_xOut_v_nor_q <= not (ld_xIn_v_to_xOut_v_nor_a or ld_xIn_v_to_xOut_v_nor_b);

    -- ld_xIn_v_to_xOut_v_sticky_ena(REG,420)@0
    ld_xIn_v_to_xOut_v_sticky_ena: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            ld_xIn_v_to_xOut_v_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ld_xIn_v_to_xOut_v_nor_q = "1") THEN
                ld_xIn_v_to_xOut_v_sticky_ena_q <= STD_LOGIC_VECTOR(ld_xIn_v_to_xOut_v_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- ld_xIn_v_to_xOut_v_enaAnd(LOGICAL,421)@0
    ld_xIn_v_to_xOut_v_enaAnd_a <= ld_xIn_v_to_xOut_v_sticky_ena_q;
    ld_xIn_v_to_xOut_v_enaAnd_b <= en;
    ld_xIn_v_to_xOut_v_enaAnd_q <= ld_xIn_v_to_xOut_v_enaAnd_a and ld_xIn_v_to_xOut_v_enaAnd_b;

    -- ld_xIn_v_to_xOut_v_replace_mem(DUALMEM,410)@0
    ld_xIn_v_to_xOut_v_replace_mem_ia <= STD_LOGIC_VECTOR(xIn_v);
    ld_xIn_v_to_xOut_v_replace_mem_aa <= ld_xIn_v_to_xOut_v_replace_rdreg_q;
    ld_xIn_v_to_xOut_v_replace_mem_ab <= ld_xIn_v_to_xOut_v_replace_rdmux_q;
    ld_xIn_v_to_xOut_v_replace_mem_reset0 <= areset;
    ld_xIn_v_to_xOut_v_replace_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 1,
        widthad_a => 5,
        numwords_a => 24,
        width_b => 1,
        widthad_b => 5,
        numwords_b => 24,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Arria 10"
    )
    PORT MAP (
        clocken1 => ld_xIn_v_to_xOut_v_enaAnd_q(0),
        clocken0 => '1',
        clock0 => clk,
        aclr1 => ld_xIn_v_to_xOut_v_replace_mem_reset0,
        clock1 => clk,
        address_a => ld_xIn_v_to_xOut_v_replace_mem_aa,
        data_a => ld_xIn_v_to_xOut_v_replace_mem_ia,
        wren_a => en(0),
        address_b => ld_xIn_v_to_xOut_v_replace_mem_ab,
        q_b => ld_xIn_v_to_xOut_v_replace_mem_iq
    );
    ld_xIn_v_to_xOut_v_replace_mem_q <= ld_xIn_v_to_xOut_v_replace_mem_iq(0 downto 0);

    -- xOut(PORTOUT,4)@25
    xOut_v <= ld_xIn_v_to_xOut_v_replace_mem_q;
    xOut_c <= ld_xIn_c_to_xOut_c_replace_mem_q;
    q <= expER_uid150_fpExpETest_b;

END normal;
