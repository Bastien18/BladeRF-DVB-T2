-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 17.1 (Release Build #590)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from aaf_fir_rtl_core
-- VHDL created on Fri Sep 26 10:36:37 2025


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

entity aaf_fir_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(13 downto 0);  -- sfix14
        enable_i : in std_logic_vector(0 downto 0);  -- sfix1
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(39 downto 0);  -- sfix40
        clk : in std_logic;
        areset : in std_logic
    );
end aaf_fir_rtl_core;

architecture normal of aaf_fir_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_in0_m0_wi0_wo0_assign_id1_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_run_preEnaQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enableQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_i : UNSIGNED (2 downto 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra18_count0_lutreg_q : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_ra18_count0_q : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_ra18_count0_i : UNSIGNED (3 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra18_count0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_wa0_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_i : UNSIGNED (2 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_wa18_1_q : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr0_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_memr18_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr18_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_memr18_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_memr18_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_memr18_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_memr18_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_ca17_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_ca17_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_ca17_i : signal is true;
    signal u0_m0_wo0_symSuppress_17_seq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_symSuppress_17_seq_eq : std_logic;
    signal u0_m0_wo0_cma0_reset : std_logic;
    type u0_m0_wo0_cma0_a0type is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal u0_m0_wo0_cma0_a0 : u0_m0_wo0_cma0_a0type(0 to 17);
    attribute preserve of u0_m0_wo0_cma0_a0 : signal is true;
    signal u0_m0_wo0_cma0_b0 : u0_m0_wo0_cma0_a0type(0 to 17);
    attribute preserve of u0_m0_wo0_cma0_b0 : signal is true;
    type u0_m0_wo0_cma0_c0type is array(NATURAL range <>) of UNSIGNED(2 downto 0);
    signal u0_m0_wo0_cma0_c0 : u0_m0_wo0_cma0_c0type(0 to 17);
    attribute preserve of u0_m0_wo0_cma0_c0 : signal is true;
    type u0_m0_wo0_cma0_ltype is array(NATURAL range <>) of SIGNED(14 downto 0);
    signal u0_m0_wo0_cma0_l : u0_m0_wo0_cma0_ltype(0 to 17);
    type u0_m0_wo0_cma0_rtype is array(NATURAL range <>) of SIGNED(17 downto 0);
    signal u0_m0_wo0_cma0_r : u0_m0_wo0_cma0_rtype(0 to 17);
    type u0_m0_wo0_cma0_ptype is array(NATURAL range <>) of SIGNED(32 downto 0);
    signal u0_m0_wo0_cma0_p : u0_m0_wo0_cma0_ptype(0 to 17);
    type u0_m0_wo0_cma0_utype is array(NATURAL range <>) of SIGNED(43 downto 0);
    signal u0_m0_wo0_cma0_u : u0_m0_wo0_cma0_utype(0 to 17);
    signal u0_m0_wo0_cma0_w : u0_m0_wo0_cma0_utype(0 to 17);
    signal u0_m0_wo0_cma0_x : u0_m0_wo0_cma0_utype(0 to 17);
    signal u0_m0_wo0_cma0_y : u0_m0_wo0_cma0_utype(0 to 17);
    signal u0_m0_wo0_cma0_k0 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(69,18),
        1 => TO_SIGNED(311,18),
        2 => TO_SIGNED(250,18),
        3 => TO_SIGNED(172,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k1 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-264,18),
        1 => TO_SIGNED(-98,18),
        2 => TO_SIGNED(113,18),
        3 => TO_SIGNED(255,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k2 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(97,18),
        1 => TO_SIGNED(-165,18),
        2 => TO_SIGNED(-306,18),
        3 => TO_SIGNED(355,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k3 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(284,18),
        1 => TO_SIGNED(445,18),
        2 => TO_SIGNED(-466,18),
        3 => TO_SIGNED(-81,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k4 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-640,18),
        1 => TO_SIGNED(595,18),
        2 => TO_SIGNED(36,18),
        3 => TO_SIGNED(-456,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k5 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-737,18),
        1 => TO_SIGNED(44,18),
        2 => TO_SIGNED(693,18),
        3 => TO_SIGNED(889,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k6 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-172,18),
        1 => TO_SIGNED(-1004,18),
        2 => TO_SIGNED(-1197,18),
        3 => TO_SIGNED(890,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k7 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(1406,18),
        1 => TO_SIGNED(1573,18),
        2 => TO_SIGNED(-1050,18),
        3 => TO_SIGNED(362,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k8 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-2029,18),
        1 => TO_SIGNED(1214,18),
        2 => TO_SIGNED(-632,18),
        3 => TO_SIGNED(-1919,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k9 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-1378,18),
        1 => TO_SIGNED(1005,18),
        2 => TO_SIGNED(2571,18),
        3 => TO_SIGNED(2580,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k10 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-1518,18),
        1 => TO_SIGNED(-3402,18),
        2 => TO_SIGNED(-3248,18),
        3 => TO_SIGNED(1537,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k11 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(4478,18),
        1 => TO_SIGNED(4071,18),
        2 => TO_SIGNED(-1686,18),
        3 => TO_SIGNED(2224,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k12 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-5112,18),
        1 => TO_SIGNED(1822,18),
        2 => TO_SIGNED(-3217,18),
        3 => TO_SIGNED(-5907,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k13 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-1940,18),
        1 => TO_SIGNED(4675,18),
        2 => TO_SIGNED(7897,18),
        3 => TO_SIGNED(6493,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k14 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-6996,18),
        1 => TO_SIGNED(-10896,18),
        2 => TO_SIGNED(-8468,18),
        3 => TO_SIGNED(2036,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k15 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(16073,18),
        1 => TO_SIGNED(11669,18),
        2 => TO_SIGNED(-2106,18),
        3 => TO_SIGNED(11280,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k16 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(-18190,18),
        1 => TO_SIGNED(2150,18),
        2 => TO_SIGNED(-22156,18),
        3 => TO_SIGNED(-27731,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_k17 : u0_m0_wo0_cma0_rtype(0 to 7) := (
        0 => TO_SIGNED(131071,18),
        1 => TO_SIGNED(118359,18),
        2 => TO_SIGNED(84638,18),
        3 => TO_SIGNED(41317,18),
        others => (others => '0'));
    signal u0_m0_wo0_cma0_z : u0_m0_wo0_cma0_utype(0 to 0);
    signal u0_m0_wo0_cma0_s : u0_m0_wo0_cma0_utype(0 to 17);
    signal u0_m0_wo0_cma0_anl : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cma0_qq : STD_LOGIC_VECTOR (39 downto 0);
    signal u0_m0_wo0_cma0_q : STD_LOGIC_VECTOR (39 downto 0);
    signal u0_m0_wo0_cma0_ena0 : std_logic;
    signal u0_m0_wo0_cma0_ena1 : std_logic;
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr1_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr1_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr5_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr5_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr5_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr5_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr9_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr9_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr9_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr9_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr13_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr13_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr13_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr13_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr17_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr17_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr17_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr17_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr19_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr19_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr19_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr19_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr23_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr23_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr23_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr23_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr27_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr27_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr27_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr27_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr31_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr31_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr31_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr31_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr35_mem_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_delayr35_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_delayr35_rdcnt_i : signal is true;
    signal u0_m0_wo0_wi0_r0_delayr35_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q : signal is true;
    signal d_xIn_0_13_mem_reset0 : std_logic;
    signal d_xIn_0_13_mem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal d_xIn_0_13_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_mem_iq : STD_LOGIC_VECTOR (13 downto 0);
    signal d_xIn_0_13_mem_q : STD_LOGIC_VECTOR (13 downto 0);
    signal d_xIn_0_13_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of d_xIn_0_13_rdcnt_i : signal is true;
    signal d_xIn_0_13_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of d_xIn_0_13_sticky_ena_q : signal is true;
    signal u0_m0_wo0_cma0_mux_17_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_cma0_mux_17_q : STD_LOGIC_VECTOR (13 downto 0);
    signal input_valid_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_rdmux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_rdmux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_rdmux_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra18_count0_lut_q : STD_LOGIC_VECTOR (3 downto 0);
    signal u0_m0_wo0_wi0_r0_wa18_1_lut_q : STD_LOGIC_VECTOR (3 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split1_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split5_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split5_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split5_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split5_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split9_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split9_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split9_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split9_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split13_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split13_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split13_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split13_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split19_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split19_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split19_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split19_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split23_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split23_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split23_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split23_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split27_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split27_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split27_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split27_e : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split31_b : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split31_c : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split31_d : STD_LOGIC_VECTOR (13 downto 0);
    signal u0_m0_wo0_wi0_r0_split31_e : STD_LOGIC_VECTOR (13 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_join1_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join5_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join9_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join13_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join19_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join23_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join27_q : STD_LOGIC_VECTOR (55 downto 0);
    signal u0_m0_wo0_wi0_r0_join31_q : STD_LOGIC_VECTOR (55 downto 0);

begin


    -- u0_m0_wo0_wi0_r0_delayr17_notEnable(LOGICAL,155)@13
    u0_m0_wo0_wi0_r0_delayr17_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr17_nor(LOGICAL,156)@13
    u0_m0_wo0_wi0_r0_delayr17_nor_q <= not (u0_m0_wo0_wi0_r0_delayr17_notEnable_q or u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr17_cmpReg(REG,154)@13 + 1
    u0_m0_wo0_wi0_r0_delayr17_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr17_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr17_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr17_sticky_ena(REG,157)@13 + 1
    u0_m0_wo0_wi0_r0_delayr17_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr17_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr17_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr17_enaAnd(LOGICAL,158)@13
    u0_m0_wo0_wi0_r0_delayr17_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr17_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr17_rdcnt(COUNTER,151)@13 + 1
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr17_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr17_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr17_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr17_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr17_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr17_rdcnt_i, 1)));

    -- u0_m0_wo0_wi0_r0_delayr17_rdmux(MUX,152)@13
    u0_m0_wo0_wi0_r0_delayr17_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr17_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr17_rdmux_s, u0_m0_wo0_wi0_r0_delayr17_wraddr_q, u0_m0_wo0_wi0_r0_delayr17_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr17_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr17_rdmux_q <= u0_m0_wo0_wi0_r0_delayr17_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr17_rdmux_q <= u0_m0_wo0_wi0_r0_delayr17_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr17_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- u0_m0_wo0_wi0_r0_delayr17_wraddr(REG,153)@13 + 1
    u0_m0_wo0_wi0_r0_delayr17_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr17_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr17_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr17_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr17_mem(DUALMEM,150)@13 + 2
    u0_m0_wo0_wi0_r0_delayr17_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split13_e);
    u0_m0_wo0_wi0_r0_delayr17_mem_aa <= u0_m0_wo0_wi0_r0_delayr17_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr17_mem_ab <= u0_m0_wo0_wi0_r0_delayr17_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr17_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr17_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 14,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr17_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr17_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr17_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr17_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr17_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr17_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr17_mem_q <= u0_m0_wo0_wi0_r0_delayr17_mem_iq(13 downto 0);

    -- input_valid(LOGICAL,3)@10
    input_valid_q <= xIn_v and enable_i;

    -- u0_m0_wo0_run(ENABLEGENERATOR,14)@10 + 2
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & input_valid_q & u0_m0_wo0_run_enableQ;
    u0_m0_wo0_run_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(2 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(3 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(2, 3);
            u0_m0_wo0_run_enableQ <= "0";
            u0_m0_wo0_run_count <= "0000";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(2) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-3);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enableQ <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(2 downto 2));
            ELSE
                u0_m0_wo0_run_enableQ <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "0000";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "1111";
                WHEN "100" => u0_m0_wo0_run_inc := "0000";
                WHEN "101" => u0_m0_wo0_run_inc := "0100";
                WHEN "110" => u0_m0_wo0_run_inc := "1111";
                WHEN "111" => u0_m0_wo0_run_inc := "0011";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_preEnaQ <= u0_m0_wo0_run_count(3 downto 3);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_preEnaQ and VCC_q;

    -- u0_m0_wo0_memread(DELAY,15)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_memread_q_13(DELAY,111)@12 + 1
    d_u0_m0_wo0_memread_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => d_u0_m0_wo0_memread_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_ra18_count0(COUNTER,23)@13
    -- low=0, high=15, step=1, init=1
    u0_m0_wo0_wi0_r0_ra18_count0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra18_count0_i <= TO_UNSIGNED(1, 4);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra18_count0_i <= u0_m0_wo0_wi0_r0_ra18_count0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra18_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra18_count0_i, 4)));

    -- u0_m0_wo0_wi0_r0_ra18_count0_lut(LOOKUP,21)@13
    u0_m0_wo0_wi0_r0_ra18_count0_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_ra18_count0_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_ra18_count0_q) IS
            WHEN "0000" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0100";
            WHEN "0001" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0011";
            WHEN "0010" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0010";
            WHEN "0011" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1001";
            WHEN "0100" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1000";
            WHEN "0101" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0111";
            WHEN "0110" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0110";
            WHEN "0111" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1101";
            WHEN "1000" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1100";
            WHEN "1001" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1011";
            WHEN "1010" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1010";
            WHEN "1011" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0001";
            WHEN "1100" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0000";
            WHEN "1101" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1111";
            WHEN "1110" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "1110";
            WHEN "1111" => u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= "0101";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_ra18_count0_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra18_count0_lutreg(REG,22)@13
    u0_m0_wo0_wi0_r0_ra18_count0_lutreg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra18_count0_lutreg_q <= "0100";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra18_count0_lutreg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra18_count0_lut_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_wa18_1_lut(LOOKUP,25)@13
    u0_m0_wo0_wi0_r0_wa18_1_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_wa18_1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_wa18_1_q) IS
            WHEN "0000" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0001";
            WHEN "0001" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0010";
            WHEN "0010" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0011";
            WHEN "0011" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0100";
            WHEN "0100" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0101";
            WHEN "0101" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0110";
            WHEN "0110" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0111";
            WHEN "0111" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1000";
            WHEN "1000" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1001";
            WHEN "1001" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1010";
            WHEN "1010" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1011";
            WHEN "1011" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1100";
            WHEN "1100" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1101";
            WHEN "1101" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1110";
            WHEN "1110" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "1111";
            WHEN "1111" => u0_m0_wo0_wi0_r0_wa18_1_lut_q <= "0000";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_wa18_1_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_wa18_1(REG,26)@13
    u0_m0_wo0_wi0_r0_wa18_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa18_1_q <= "1001";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa18_1_q <= u0_m0_wo0_wi0_r0_wa18_1_lut_q;
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_memr18(DUALMEM,28)@13
    u0_m0_wo0_wi0_r0_memr18_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split13_e);
    u0_m0_wo0_wi0_r0_memr18_aa <= u0_m0_wo0_wi0_r0_wa18_1_q;
    u0_m0_wo0_wi0_r0_memr18_ab <= u0_m0_wo0_wi0_r0_ra18_count0_lutreg_q;
    u0_m0_wo0_wi0_r0_memr18_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 14,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr18_aa,
        data_a => u0_m0_wo0_wi0_r0_memr18_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr18_ab,
        q_b => u0_m0_wo0_wi0_r0_memr18_iq
    );
    u0_m0_wo0_wi0_r0_memr18_q <= u0_m0_wo0_wi0_r0_memr18_iq(13 downto 0);

    -- u0_m0_wo0_compute(DELAY,17)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_symSuppress_17_seq(SEQUENCE,94)@12 + 1
    u0_m0_wo0_symSuppress_17_seq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_symSuppress_17_seq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_symSuppress_17_seq_c := "11111";
            u0_m0_wo0_symSuppress_17_seq_q <= "0";
            u0_m0_wo0_symSuppress_17_seq_eq <= '1';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_symSuppress_17_seq_c = "00000") THEN
                    u0_m0_wo0_symSuppress_17_seq_eq <= '1';
                ELSE
                    u0_m0_wo0_symSuppress_17_seq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_symSuppress_17_seq_eq = '1') THEN
                    u0_m0_wo0_symSuppress_17_seq_c := u0_m0_wo0_symSuppress_17_seq_c + 3;
                ELSE
                    u0_m0_wo0_symSuppress_17_seq_c := u0_m0_wo0_symSuppress_17_seq_c - 1;
                END IF;
                u0_m0_wo0_symSuppress_17_seq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_symSuppress_17_seq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_cma0_mux_17(MUX,107)@13
    u0_m0_wo0_cma0_mux_17_s <= u0_m0_wo0_symSuppress_17_seq_q;
    u0_m0_wo0_cma0_mux_17_combproc: PROCESS (u0_m0_wo0_cma0_mux_17_s, u0_m0_wo0_wi0_r0_memr18_q, GND_q)
    BEGIN
        CASE (u0_m0_wo0_cma0_mux_17_s) IS
            WHEN "0" => u0_m0_wo0_cma0_mux_17_q <= u0_m0_wo0_wi0_r0_memr18_q;
            WHEN "1" => u0_m0_wo0_cma0_mux_17_q <= STD_LOGIC_VECTOR((13 downto 1 => GND_q(0)) & GND_q);
            WHEN OTHERS => u0_m0_wo0_cma0_mux_17_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr13_notEnable(LOGICAL,146)@13
    u0_m0_wo0_wi0_r0_delayr13_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr13_nor(LOGICAL,147)@13
    u0_m0_wo0_wi0_r0_delayr13_nor_q <= not (u0_m0_wo0_wi0_r0_delayr13_notEnable_q or u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr13_cmpReg(REG,145)@13 + 1
    u0_m0_wo0_wi0_r0_delayr13_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr13_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr13_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr13_sticky_ena(REG,148)@13 + 1
    u0_m0_wo0_wi0_r0_delayr13_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr13_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr13_enaAnd(LOGICAL,149)@13
    u0_m0_wo0_wi0_r0_delayr13_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr13_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr13_rdcnt(COUNTER,142)@13 + 1
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr13_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr13_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr13_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr13_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr13_rdcnt_i, 1)));

    -- u0_m0_wo0_wi0_r0_delayr13_rdmux(MUX,143)@13
    u0_m0_wo0_wi0_r0_delayr13_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr13_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr13_rdmux_s, u0_m0_wo0_wi0_r0_delayr13_wraddr_q, u0_m0_wo0_wi0_r0_delayr13_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr13_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr13_rdmux_q <= u0_m0_wo0_wi0_r0_delayr13_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr13_rdmux_q <= u0_m0_wo0_wi0_r0_delayr13_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr13_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join13(BITJOIN,38)@13
    u0_m0_wo0_wi0_r0_join13_q <= u0_m0_wo0_wi0_r0_split13_d & u0_m0_wo0_wi0_r0_split13_c & u0_m0_wo0_wi0_r0_split13_b & u0_m0_wo0_wi0_r0_split9_e;

    -- u0_m0_wo0_wi0_r0_delayr13_wraddr(REG,144)@13 + 1
    u0_m0_wo0_wi0_r0_delayr13_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr13_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr13_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr13_mem(DUALMEM,141)@13 + 2
    u0_m0_wo0_wi0_r0_delayr13_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join13_q);
    u0_m0_wo0_wi0_r0_delayr13_mem_aa <= u0_m0_wo0_wi0_r0_delayr13_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr13_mem_ab <= u0_m0_wo0_wi0_r0_delayr13_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr13_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 56,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr13_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr13_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr13_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr13_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr13_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr13_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr13_mem_q <= u0_m0_wo0_wi0_r0_delayr13_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split13(BITSELECT,39)@13
    u0_m0_wo0_wi0_r0_split13_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split13_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split13_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split13_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr13_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr19_notEnable(LOGICAL,166)@13
    u0_m0_wo0_wi0_r0_delayr19_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr19_nor(LOGICAL,167)@13
    u0_m0_wo0_wi0_r0_delayr19_nor_q <= not (u0_m0_wo0_wi0_r0_delayr19_notEnable_q or u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr19_mem_last(CONSTANT,163)
    u0_m0_wo0_wi0_r0_delayr19_mem_last_q <= "010";

    -- u0_m0_wo0_wi0_r0_delayr19_cmp(LOGICAL,164)@13
    u0_m0_wo0_wi0_r0_delayr19_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr19_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr19_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr19_mem_last_q = u0_m0_wo0_wi0_r0_delayr19_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr19_cmpReg(REG,165)@13 + 1
    u0_m0_wo0_wi0_r0_delayr19_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr19_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr19_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr19_sticky_ena(REG,168)@13 + 1
    u0_m0_wo0_wi0_r0_delayr19_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr19_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr19_enaAnd(LOGICAL,169)@13
    u0_m0_wo0_wi0_r0_delayr19_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr19_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr19_rdcnt(COUNTER,160)@13 + 1
    -- low=0, high=3, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr19_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr19_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr19_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr19_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr19_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr19_rdcnt_i, 2)));

    -- u0_m0_wo0_wi0_r0_delayr19_rdmux(MUX,161)@13
    u0_m0_wo0_wi0_r0_delayr19_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr19_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr19_rdmux_s, u0_m0_wo0_wi0_r0_delayr19_wraddr_q, u0_m0_wo0_wi0_r0_delayr19_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr19_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr19_rdmux_q <= u0_m0_wo0_wi0_r0_delayr19_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr19_rdmux_q <= u0_m0_wo0_wi0_r0_delayr19_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr19_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join19(BITJOIN,42)@13
    u0_m0_wo0_wi0_r0_join19_q <= u0_m0_wo0_wi0_r0_split19_d & u0_m0_wo0_wi0_r0_split19_c & u0_m0_wo0_wi0_r0_split19_b & u0_m0_wo0_wi0_r0_memr18_q;

    -- u0_m0_wo0_wi0_r0_delayr19_wraddr(REG,162)@13 + 1
    u0_m0_wo0_wi0_r0_delayr19_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr19_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr19_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr19_mem(DUALMEM,159)@13 + 2
    u0_m0_wo0_wi0_r0_delayr19_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join19_q);
    u0_m0_wo0_wi0_r0_delayr19_mem_aa <= u0_m0_wo0_wi0_r0_delayr19_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr19_mem_ab <= u0_m0_wo0_wi0_r0_delayr19_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr19_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr19_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 56,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr19_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr19_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr19_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr19_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr19_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr19_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr19_mem_q <= u0_m0_wo0_wi0_r0_delayr19_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split19(BITSELECT,43)@13
    u0_m0_wo0_wi0_r0_split19_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split19_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split19_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split19_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr19_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr9_notEnable(LOGICAL,137)@13
    u0_m0_wo0_wi0_r0_delayr9_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr9_nor(LOGICAL,138)@13
    u0_m0_wo0_wi0_r0_delayr9_nor_q <= not (u0_m0_wo0_wi0_r0_delayr9_notEnable_q or u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr9_cmpReg(REG,136)@13 + 1
    u0_m0_wo0_wi0_r0_delayr9_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr9_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr9_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr9_sticky_ena(REG,139)@13 + 1
    u0_m0_wo0_wi0_r0_delayr9_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr9_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr9_enaAnd(LOGICAL,140)@13
    u0_m0_wo0_wi0_r0_delayr9_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr9_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr9_rdcnt(COUNTER,133)@13 + 1
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr9_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr9_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr9_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr9_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr9_rdcnt_i, 1)));

    -- u0_m0_wo0_wi0_r0_delayr9_rdmux(MUX,134)@13
    u0_m0_wo0_wi0_r0_delayr9_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr9_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr9_rdmux_s, u0_m0_wo0_wi0_r0_delayr9_wraddr_q, u0_m0_wo0_wi0_r0_delayr9_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr9_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr9_rdmux_q <= u0_m0_wo0_wi0_r0_delayr9_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr9_rdmux_q <= u0_m0_wo0_wi0_r0_delayr9_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr9_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join9(BITJOIN,35)@13
    u0_m0_wo0_wi0_r0_join9_q <= u0_m0_wo0_wi0_r0_split9_d & u0_m0_wo0_wi0_r0_split9_c & u0_m0_wo0_wi0_r0_split9_b & u0_m0_wo0_wi0_r0_split5_e;

    -- u0_m0_wo0_wi0_r0_delayr9_wraddr(REG,135)@13 + 1
    u0_m0_wo0_wi0_r0_delayr9_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr9_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr9_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr9_mem(DUALMEM,132)@13 + 2
    u0_m0_wo0_wi0_r0_delayr9_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join9_q);
    u0_m0_wo0_wi0_r0_delayr9_mem_aa <= u0_m0_wo0_wi0_r0_delayr9_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr9_mem_ab <= u0_m0_wo0_wi0_r0_delayr9_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr9_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 56,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr9_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr9_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr9_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr9_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr9_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr9_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr9_mem_q <= u0_m0_wo0_wi0_r0_delayr9_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split9(BITSELECT,36)@13
    u0_m0_wo0_wi0_r0_split9_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split9_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split9_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split9_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr9_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr23_notEnable(LOGICAL,177)@13
    u0_m0_wo0_wi0_r0_delayr23_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr23_nor(LOGICAL,178)@13
    u0_m0_wo0_wi0_r0_delayr23_nor_q <= not (u0_m0_wo0_wi0_r0_delayr23_notEnable_q or u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr23_mem_last(CONSTANT,174)
    u0_m0_wo0_wi0_r0_delayr23_mem_last_q <= "010";

    -- u0_m0_wo0_wi0_r0_delayr23_cmp(LOGICAL,175)@13
    u0_m0_wo0_wi0_r0_delayr23_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr23_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr23_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr23_mem_last_q = u0_m0_wo0_wi0_r0_delayr23_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr23_cmpReg(REG,176)@13 + 1
    u0_m0_wo0_wi0_r0_delayr23_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr23_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr23_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr23_sticky_ena(REG,179)@13 + 1
    u0_m0_wo0_wi0_r0_delayr23_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr23_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr23_enaAnd(LOGICAL,180)@13
    u0_m0_wo0_wi0_r0_delayr23_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr23_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr23_rdcnt(COUNTER,171)@13 + 1
    -- low=0, high=3, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr23_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr23_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr23_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr23_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr23_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr23_rdcnt_i, 2)));

    -- u0_m0_wo0_wi0_r0_delayr23_rdmux(MUX,172)@13
    u0_m0_wo0_wi0_r0_delayr23_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr23_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr23_rdmux_s, u0_m0_wo0_wi0_r0_delayr23_wraddr_q, u0_m0_wo0_wi0_r0_delayr23_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr23_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr23_rdmux_q <= u0_m0_wo0_wi0_r0_delayr23_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr23_rdmux_q <= u0_m0_wo0_wi0_r0_delayr23_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr23_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join23(BITJOIN,45)@13
    u0_m0_wo0_wi0_r0_join23_q <= u0_m0_wo0_wi0_r0_split23_d & u0_m0_wo0_wi0_r0_split23_c & u0_m0_wo0_wi0_r0_split23_b & u0_m0_wo0_wi0_r0_split19_e;

    -- u0_m0_wo0_wi0_r0_delayr23_wraddr(REG,173)@13 + 1
    u0_m0_wo0_wi0_r0_delayr23_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr23_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr23_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr23_mem(DUALMEM,170)@13 + 2
    u0_m0_wo0_wi0_r0_delayr23_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join23_q);
    u0_m0_wo0_wi0_r0_delayr23_mem_aa <= u0_m0_wo0_wi0_r0_delayr23_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr23_mem_ab <= u0_m0_wo0_wi0_r0_delayr23_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr23_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr23_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 56,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr23_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr23_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr23_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr23_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr23_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr23_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr23_mem_q <= u0_m0_wo0_wi0_r0_delayr23_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split23(BITSELECT,46)@13
    u0_m0_wo0_wi0_r0_split23_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split23_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split23_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split23_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr23_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr5_notEnable(LOGICAL,128)@13
    u0_m0_wo0_wi0_r0_delayr5_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr5_nor(LOGICAL,129)@13
    u0_m0_wo0_wi0_r0_delayr5_nor_q <= not (u0_m0_wo0_wi0_r0_delayr5_notEnable_q or u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr5_cmpReg(REG,127)@13 + 1
    u0_m0_wo0_wi0_r0_delayr5_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr5_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr5_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr5_sticky_ena(REG,130)@13 + 1
    u0_m0_wo0_wi0_r0_delayr5_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr5_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr5_enaAnd(LOGICAL,131)@13
    u0_m0_wo0_wi0_r0_delayr5_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr5_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr5_rdcnt(COUNTER,124)@13 + 1
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr5_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr5_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr5_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr5_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr5_rdcnt_i, 1)));

    -- u0_m0_wo0_wi0_r0_delayr5_rdmux(MUX,125)@13
    u0_m0_wo0_wi0_r0_delayr5_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr5_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr5_rdmux_s, u0_m0_wo0_wi0_r0_delayr5_wraddr_q, u0_m0_wo0_wi0_r0_delayr5_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr5_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr5_rdmux_q <= u0_m0_wo0_wi0_r0_delayr5_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr5_rdmux_q <= u0_m0_wo0_wi0_r0_delayr5_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr5_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join5(BITJOIN,32)@13
    u0_m0_wo0_wi0_r0_join5_q <= u0_m0_wo0_wi0_r0_split5_d & u0_m0_wo0_wi0_r0_split5_c & u0_m0_wo0_wi0_r0_split5_b & u0_m0_wo0_wi0_r0_split1_e;

    -- u0_m0_wo0_wi0_r0_delayr5_wraddr(REG,126)@13 + 1
    u0_m0_wo0_wi0_r0_delayr5_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr5_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr5_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr5_mem(DUALMEM,123)@13 + 2
    u0_m0_wo0_wi0_r0_delayr5_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join5_q);
    u0_m0_wo0_wi0_r0_delayr5_mem_aa <= u0_m0_wo0_wi0_r0_delayr5_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr5_mem_ab <= u0_m0_wo0_wi0_r0_delayr5_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr5_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 56,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr5_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr5_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr5_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr5_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr5_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr5_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr5_mem_q <= u0_m0_wo0_wi0_r0_delayr5_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split5(BITSELECT,33)@13
    u0_m0_wo0_wi0_r0_split5_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split5_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split5_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split5_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr5_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr27_notEnable(LOGICAL,188)@13
    u0_m0_wo0_wi0_r0_delayr27_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr27_nor(LOGICAL,189)@13
    u0_m0_wo0_wi0_r0_delayr27_nor_q <= not (u0_m0_wo0_wi0_r0_delayr27_notEnable_q or u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr27_mem_last(CONSTANT,185)
    u0_m0_wo0_wi0_r0_delayr27_mem_last_q <= "010";

    -- u0_m0_wo0_wi0_r0_delayr27_cmp(LOGICAL,186)@13
    u0_m0_wo0_wi0_r0_delayr27_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr27_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr27_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr27_mem_last_q = u0_m0_wo0_wi0_r0_delayr27_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr27_cmpReg(REG,187)@13 + 1
    u0_m0_wo0_wi0_r0_delayr27_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr27_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr27_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr27_sticky_ena(REG,190)@13 + 1
    u0_m0_wo0_wi0_r0_delayr27_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr27_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr27_enaAnd(LOGICAL,191)@13
    u0_m0_wo0_wi0_r0_delayr27_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr27_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr27_rdcnt(COUNTER,182)@13 + 1
    -- low=0, high=3, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr27_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr27_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr27_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr27_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr27_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr27_rdcnt_i, 2)));

    -- u0_m0_wo0_wi0_r0_delayr27_rdmux(MUX,183)@13
    u0_m0_wo0_wi0_r0_delayr27_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr27_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr27_rdmux_s, u0_m0_wo0_wi0_r0_delayr27_wraddr_q, u0_m0_wo0_wi0_r0_delayr27_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr27_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr27_rdmux_q <= u0_m0_wo0_wi0_r0_delayr27_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr27_rdmux_q <= u0_m0_wo0_wi0_r0_delayr27_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr27_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join27(BITJOIN,48)@13
    u0_m0_wo0_wi0_r0_join27_q <= u0_m0_wo0_wi0_r0_split27_d & u0_m0_wo0_wi0_r0_split27_c & u0_m0_wo0_wi0_r0_split27_b & u0_m0_wo0_wi0_r0_split23_e;

    -- u0_m0_wo0_wi0_r0_delayr27_wraddr(REG,184)@13 + 1
    u0_m0_wo0_wi0_r0_delayr27_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr27_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr27_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr27_mem(DUALMEM,181)@13 + 2
    u0_m0_wo0_wi0_r0_delayr27_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join27_q);
    u0_m0_wo0_wi0_r0_delayr27_mem_aa <= u0_m0_wo0_wi0_r0_delayr27_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr27_mem_ab <= u0_m0_wo0_wi0_r0_delayr27_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr27_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr27_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 56,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr27_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr27_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr27_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr27_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr27_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr27_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr27_mem_q <= u0_m0_wo0_wi0_r0_delayr27_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split27(BITSELECT,49)@13
    u0_m0_wo0_wi0_r0_split27_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split27_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split27_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split27_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr27_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr1_notEnable(LOGICAL,119)@13
    u0_m0_wo0_wi0_r0_delayr1_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr1_nor(LOGICAL,120)@13
    u0_m0_wo0_wi0_r0_delayr1_nor_q <= not (u0_m0_wo0_wi0_r0_delayr1_notEnable_q or u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr1_cmpReg(REG,118)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_sticky_ena(REG,121)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr1_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_enaAnd(LOGICAL,122)@13
    u0_m0_wo0_wi0_r0_delayr1_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr1_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr1_rdcnt(COUNTER,115)@13 + 1
    -- low=0, high=1, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr1_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr1_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr1_rdcnt_i, 1)));

    -- u0_m0_wo0_wi0_r0_delayr1_rdmux(MUX,116)@13
    u0_m0_wo0_wi0_r0_delayr1_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr1_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr1_rdmux_s, u0_m0_wo0_wi0_r0_delayr1_wraddr_q, u0_m0_wo0_wi0_r0_delayr1_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr1_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= u0_m0_wo0_wi0_r0_delayr1_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= u0_m0_wo0_wi0_r0_delayr1_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr1_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join1(BITJOIN,29)@13
    u0_m0_wo0_wi0_r0_join1_q <= u0_m0_wo0_wi0_r0_split1_d & u0_m0_wo0_wi0_r0_split1_c & u0_m0_wo0_wi0_r0_split1_b & u0_m0_wo0_wi0_r0_memr0_q;

    -- u0_m0_wo0_wi0_r0_delayr1_wraddr(REG,117)@13 + 1
    u0_m0_wo0_wi0_r0_delayr1_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr1_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr1_mem(DUALMEM,114)@13 + 2
    u0_m0_wo0_wi0_r0_delayr1_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join1_q);
    u0_m0_wo0_wi0_r0_delayr1_mem_aa <= u0_m0_wo0_wi0_r0_delayr1_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_ab <= u0_m0_wo0_wi0_r0_delayr1_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr1_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr1_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 56,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr1_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr1_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr1_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr1_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr1_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr1_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr1_mem_q <= u0_m0_wo0_wi0_r0_delayr1_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split1(BITSELECT,30)@13
    u0_m0_wo0_wi0_r0_split1_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split1_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split1_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split1_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr1_mem_q(55 downto 42));

    -- u0_m0_wo0_wi0_r0_delayr31_notEnable(LOGICAL,199)@13
    u0_m0_wo0_wi0_r0_delayr31_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr31_nor(LOGICAL,200)@13
    u0_m0_wo0_wi0_r0_delayr31_nor_q <= not (u0_m0_wo0_wi0_r0_delayr31_notEnable_q or u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr31_mem_last(CONSTANT,196)
    u0_m0_wo0_wi0_r0_delayr31_mem_last_q <= "010";

    -- u0_m0_wo0_wi0_r0_delayr31_cmp(LOGICAL,197)@13
    u0_m0_wo0_wi0_r0_delayr31_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr31_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr31_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr31_mem_last_q = u0_m0_wo0_wi0_r0_delayr31_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr31_cmpReg(REG,198)@13 + 1
    u0_m0_wo0_wi0_r0_delayr31_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr31_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr31_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr31_sticky_ena(REG,201)@13 + 1
    u0_m0_wo0_wi0_r0_delayr31_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr31_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr31_enaAnd(LOGICAL,202)@13
    u0_m0_wo0_wi0_r0_delayr31_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr31_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr31_rdcnt(COUNTER,193)@13 + 1
    -- low=0, high=3, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr31_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr31_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr31_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr31_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr31_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr31_rdcnt_i, 2)));

    -- u0_m0_wo0_wi0_r0_delayr31_rdmux(MUX,194)@13
    u0_m0_wo0_wi0_r0_delayr31_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr31_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr31_rdmux_s, u0_m0_wo0_wi0_r0_delayr31_wraddr_q, u0_m0_wo0_wi0_r0_delayr31_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr31_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr31_rdmux_q <= u0_m0_wo0_wi0_r0_delayr31_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr31_rdmux_q <= u0_m0_wo0_wi0_r0_delayr31_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr31_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_join31(BITJOIN,51)@13
    u0_m0_wo0_wi0_r0_join31_q <= u0_m0_wo0_wi0_r0_split31_d & u0_m0_wo0_wi0_r0_split31_c & u0_m0_wo0_wi0_r0_split31_b & u0_m0_wo0_wi0_r0_split27_e;

    -- u0_m0_wo0_wi0_r0_delayr31_wraddr(REG,195)@13 + 1
    u0_m0_wo0_wi0_r0_delayr31_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr31_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr31_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr31_mem(DUALMEM,192)@13 + 2
    u0_m0_wo0_wi0_r0_delayr31_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_join31_q);
    u0_m0_wo0_wi0_r0_delayr31_mem_aa <= u0_m0_wo0_wi0_r0_delayr31_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr31_mem_ab <= u0_m0_wo0_wi0_r0_delayr31_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr31_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr31_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 56,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr31_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr31_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr31_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr31_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr31_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr31_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr31_mem_q <= u0_m0_wo0_wi0_r0_delayr31_mem_iq(55 downto 0);

    -- u0_m0_wo0_wi0_r0_split31(BITSELECT,52)@13
    u0_m0_wo0_wi0_r0_split31_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_mem_q(13 downto 0));
    u0_m0_wo0_wi0_r0_split31_c <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_mem_q(27 downto 14));
    u0_m0_wo0_wi0_r0_split31_d <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_mem_q(41 downto 28));
    u0_m0_wo0_wi0_r0_split31_e <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr31_mem_q(55 downto 42));

    -- u0_m0_wo0_ca17(COUNTER,55)@13
    -- low=0, high=3, step=1, init=1
    u0_m0_wo0_ca17_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca17_i <= TO_UNSIGNED(1, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_ca17_i <= u0_m0_wo0_ca17_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca17_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca17_i, 2)));

    -- u0_m0_wo0_wi0_r0_ra0_count0(COUNTER,20)@13
    -- low=0, high=7, step=1, init=1
    u0_m0_wo0_wi0_r0_ra0_count0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_i <= TO_UNSIGNED(1, 3);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_memread_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count0_i <= u0_m0_wo0_wi0_r0_ra0_count0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_i, 3)));

    -- d_xIn_0_13_notEnable(LOGICAL,218)@10
    d_xIn_0_13_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- d_xIn_0_13_nor(LOGICAL,219)@10
    d_xIn_0_13_nor_q <= not (d_xIn_0_13_notEnable_q or d_xIn_0_13_sticky_ena_q);

    -- d_xIn_0_13_cmpReg(REG,217)@10 + 1
    d_xIn_0_13_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_13_sticky_ena(REG,220)@10 + 1
    d_xIn_0_13_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_xIn_0_13_nor_q = "1") THEN
                d_xIn_0_13_sticky_ena_q <= STD_LOGIC_VECTOR(d_xIn_0_13_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- d_xIn_0_13_enaAnd(LOGICAL,221)@10
    d_xIn_0_13_enaAnd_q <= d_xIn_0_13_sticky_ena_q and VCC_q;

    -- d_xIn_0_13_rdcnt(COUNTER,215)@10 + 1
    -- low=0, high=1, step=1, init=0
    d_xIn_0_13_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_rdcnt_i <= d_xIn_0_13_rdcnt_i + 1;
        END IF;
    END PROCESS;
    d_xIn_0_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(d_xIn_0_13_rdcnt_i, 1)));

    -- d_xIn_0_13_wraddr(REG,216)@10 + 1
    d_xIn_0_13_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_wraddr_q <= STD_LOGIC_VECTOR(d_xIn_0_13_rdcnt_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_13_mem(DUALMEM,214)@10 + 2
    d_xIn_0_13_mem_ia <= STD_LOGIC_VECTOR(xIn_0);
    d_xIn_0_13_mem_aa <= d_xIn_0_13_wraddr_q;
    d_xIn_0_13_mem_ab <= d_xIn_0_13_rdcnt_q;
    d_xIn_0_13_mem_reset0 <= areset;
    d_xIn_0_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 14,
        widthad_b => 1,
        numwords_b => 2,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => d_xIn_0_13_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => d_xIn_0_13_mem_reset0,
        clock1 => clk,
        address_a => d_xIn_0_13_mem_aa,
        data_a => d_xIn_0_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => d_xIn_0_13_mem_ab,
        q_b => d_xIn_0_13_mem_iq
    );
    d_xIn_0_13_mem_q <= d_xIn_0_13_mem_iq(13 downto 0);

    -- d_in0_m0_wi0_wo0_assign_id1_q_13(DELAY,110)@10 + 3
    d_in0_m0_wi0_wo0_assign_id1_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => input_valid_q, xout => d_in0_m0_wi0_wo0_assign_id1_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_wa0(COUNTER,24)@13
    -- low=0, high=7, step=1, init=4
    u0_m0_wo0_wi0_r0_wa0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa0_i <= TO_UNSIGNED(4, 3);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_id1_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa0_i <= u0_m0_wo0_wi0_r0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa0_i, 3)));

    -- u0_m0_wo0_wi0_r0_memr0(DUALMEM,27)@13
    u0_m0_wo0_wi0_r0_memr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_13_mem_q);
    u0_m0_wo0_wi0_r0_memr0_aa <= u0_m0_wo0_wi0_r0_wa0_q;
    u0_m0_wo0_wi0_r0_memr0_ab <= u0_m0_wo0_wi0_r0_ra0_count0_q;
    u0_m0_wo0_wi0_r0_memr0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 14,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr0_aa,
        data_a => u0_m0_wo0_wi0_r0_memr0_ia,
        wren_a => d_in0_m0_wi0_wo0_assign_id1_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr0_ab,
        q_b => u0_m0_wo0_wi0_r0_memr0_iq
    );
    u0_m0_wo0_wi0_r0_memr0_q <= u0_m0_wo0_wi0_r0_memr0_iq(13 downto 0);

    -- u0_m0_wo0_wi0_r0_delayr35_notEnable(LOGICAL,210)@13
    u0_m0_wo0_wi0_r0_delayr35_notEnable_q <= STD_LOGIC_VECTOR(not (d_u0_m0_wo0_compute_q_13_q));

    -- u0_m0_wo0_wi0_r0_delayr35_nor(LOGICAL,211)@13
    u0_m0_wo0_wi0_r0_delayr35_nor_q <= not (u0_m0_wo0_wi0_r0_delayr35_notEnable_q or u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q);

    -- u0_m0_wo0_wi0_r0_delayr35_mem_last(CONSTANT,207)
    u0_m0_wo0_wi0_r0_delayr35_mem_last_q <= "010";

    -- u0_m0_wo0_wi0_r0_delayr35_cmp(LOGICAL,208)@13
    u0_m0_wo0_wi0_r0_delayr35_cmp_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_delayr35_rdmux_q);
    u0_m0_wo0_wi0_r0_delayr35_cmp_q <= "1" WHEN u0_m0_wo0_wi0_r0_delayr35_mem_last_q = u0_m0_wo0_wi0_r0_delayr35_cmp_b ELSE "0";

    -- u0_m0_wo0_wi0_r0_delayr35_cmpReg(REG,209)@13 + 1
    u0_m0_wo0_wi0_r0_delayr35_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr35_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr35_cmpReg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr35_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr35_sticky_ena(REG,212)@13 + 1
    u0_m0_wo0_wi0_r0_delayr35_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_wi0_r0_delayr35_nor_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr35_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr35_enaAnd(LOGICAL,213)@13
    u0_m0_wo0_wi0_r0_delayr35_enaAnd_q <= u0_m0_wo0_wi0_r0_delayr35_sticky_ena_q and d_u0_m0_wo0_compute_q_13_q;

    -- u0_m0_wo0_wi0_r0_delayr35_rdcnt(COUNTER,204)@13 + 1
    -- low=0, high=3, step=1, init=0
    u0_m0_wo0_wi0_r0_delayr35_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr35_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_delayr35_rdcnt_i <= u0_m0_wo0_wi0_r0_delayr35_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_delayr35_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_delayr35_rdcnt_i, 2)));

    -- u0_m0_wo0_wi0_r0_delayr35_rdmux(MUX,205)@13
    u0_m0_wo0_wi0_r0_delayr35_rdmux_s <= d_u0_m0_wo0_compute_q_13_q;
    u0_m0_wo0_wi0_r0_delayr35_rdmux_combproc: PROCESS (u0_m0_wo0_wi0_r0_delayr35_rdmux_s, u0_m0_wo0_wi0_r0_delayr35_wraddr_q, u0_m0_wo0_wi0_r0_delayr35_rdcnt_q)
    BEGIN
        CASE (u0_m0_wo0_wi0_r0_delayr35_rdmux_s) IS
            WHEN "0" => u0_m0_wo0_wi0_r0_delayr35_rdmux_q <= u0_m0_wo0_wi0_r0_delayr35_wraddr_q;
            WHEN "1" => u0_m0_wo0_wi0_r0_delayr35_rdmux_q <= u0_m0_wo0_wi0_r0_delayr35_rdcnt_q;
            WHEN OTHERS => u0_m0_wo0_wi0_r0_delayr35_rdmux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr35_wraddr(REG,206)@13 + 1
    u0_m0_wo0_wi0_r0_delayr35_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_delayr35_wraddr_q <= "11";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_delayr35_wraddr_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_delayr35_rdmux_q);
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_delayr35_mem(DUALMEM,203)@13 + 2
    u0_m0_wo0_wi0_r0_delayr35_mem_ia <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_split31_e);
    u0_m0_wo0_wi0_r0_delayr35_mem_aa <= u0_m0_wo0_wi0_r0_delayr35_wraddr_q;
    u0_m0_wo0_wi0_r0_delayr35_mem_ab <= u0_m0_wo0_wi0_r0_delayr35_rdmux_q;
    u0_m0_wo0_wi0_r0_delayr35_mem_reset0 <= areset;
    u0_m0_wo0_wi0_r0_delayr35_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 14,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 14,
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
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => u0_m0_wo0_wi0_r0_delayr35_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => u0_m0_wo0_wi0_r0_delayr35_mem_reset0,
        clock1 => clk,
        address_a => u0_m0_wo0_wi0_r0_delayr35_mem_aa,
        data_a => u0_m0_wo0_wi0_r0_delayr35_mem_ia,
        wren_a => d_u0_m0_wo0_compute_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_delayr35_mem_ab,
        q_b => u0_m0_wo0_wi0_r0_delayr35_mem_iq
    );
    u0_m0_wo0_wi0_r0_delayr35_mem_q <= u0_m0_wo0_wi0_r0_delayr35_mem_iq(13 downto 0);

    -- u0_m0_wo0_aseq(SEQUENCE,97)@12 + 1
    u0_m0_wo0_aseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "00000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "00000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 3;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_14(DELAY,113)@13 + 1
    d_u0_m0_wo0_compute_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_13_q, xout => d_u0_m0_wo0_compute_q_14_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_13(DELAY,112)@12 + 1
    d_u0_m0_wo0_compute_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_cma0(CHAINMULTADD,96)@13 + 2
    u0_m0_wo0_cma0_reset <= areset;
    u0_m0_wo0_cma0_ena0 <= d_u0_m0_wo0_compute_q_13_q(0);
    u0_m0_wo0_cma0_ena1 <= d_u0_m0_wo0_compute_q_14_q(0);
    u0_m0_wo0_cma0_l(0) <= RESIZE(u0_m0_wo0_cma0_a0(0),15) + RESIZE(u0_m0_wo0_cma0_b0(0),15);
    u0_m0_wo0_cma0_l(1) <= RESIZE(u0_m0_wo0_cma0_a0(1),15) + RESIZE(u0_m0_wo0_cma0_b0(1),15);
    u0_m0_wo0_cma0_l(2) <= RESIZE(u0_m0_wo0_cma0_a0(2),15) + RESIZE(u0_m0_wo0_cma0_b0(2),15);
    u0_m0_wo0_cma0_l(3) <= RESIZE(u0_m0_wo0_cma0_a0(3),15) + RESIZE(u0_m0_wo0_cma0_b0(3),15);
    u0_m0_wo0_cma0_l(4) <= RESIZE(u0_m0_wo0_cma0_a0(4),15) + RESIZE(u0_m0_wo0_cma0_b0(4),15);
    u0_m0_wo0_cma0_l(5) <= RESIZE(u0_m0_wo0_cma0_a0(5),15) + RESIZE(u0_m0_wo0_cma0_b0(5),15);
    u0_m0_wo0_cma0_l(6) <= RESIZE(u0_m0_wo0_cma0_a0(6),15) + RESIZE(u0_m0_wo0_cma0_b0(6),15);
    u0_m0_wo0_cma0_l(7) <= RESIZE(u0_m0_wo0_cma0_a0(7),15) + RESIZE(u0_m0_wo0_cma0_b0(7),15);
    u0_m0_wo0_cma0_l(8) <= RESIZE(u0_m0_wo0_cma0_a0(8),15) + RESIZE(u0_m0_wo0_cma0_b0(8),15);
    u0_m0_wo0_cma0_l(9) <= RESIZE(u0_m0_wo0_cma0_a0(9),15) + RESIZE(u0_m0_wo0_cma0_b0(9),15);
    u0_m0_wo0_cma0_l(10) <= RESIZE(u0_m0_wo0_cma0_a0(10),15) + RESIZE(u0_m0_wo0_cma0_b0(10),15);
    u0_m0_wo0_cma0_l(11) <= RESIZE(u0_m0_wo0_cma0_a0(11),15) + RESIZE(u0_m0_wo0_cma0_b0(11),15);
    u0_m0_wo0_cma0_l(12) <= RESIZE(u0_m0_wo0_cma0_a0(12),15) + RESIZE(u0_m0_wo0_cma0_b0(12),15);
    u0_m0_wo0_cma0_l(13) <= RESIZE(u0_m0_wo0_cma0_a0(13),15) + RESIZE(u0_m0_wo0_cma0_b0(13),15);
    u0_m0_wo0_cma0_l(14) <= RESIZE(u0_m0_wo0_cma0_a0(14),15) + RESIZE(u0_m0_wo0_cma0_b0(14),15);
    u0_m0_wo0_cma0_l(15) <= RESIZE(u0_m0_wo0_cma0_a0(15),15) + RESIZE(u0_m0_wo0_cma0_b0(15),15);
    u0_m0_wo0_cma0_l(16) <= RESIZE(u0_m0_wo0_cma0_a0(16),15) + RESIZE(u0_m0_wo0_cma0_b0(16),15);
    u0_m0_wo0_cma0_l(17) <= RESIZE(u0_m0_wo0_cma0_a0(17),15) + RESIZE(u0_m0_wo0_cma0_b0(17),15);
    -- altera synthesis_off
    u0_m0_wo0_cma0_k0 <= (
        0 => TO_SIGNED(69,18),
        1 => TO_SIGNED(311,18),
        2 => TO_SIGNED(250,18),
        3 => TO_SIGNED(172,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k1 <= (
        0 => TO_SIGNED(-264,18),
        1 => TO_SIGNED(-98,18),
        2 => TO_SIGNED(113,18),
        3 => TO_SIGNED(255,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k2 <= (
        0 => TO_SIGNED(97,18),
        1 => TO_SIGNED(-165,18),
        2 => TO_SIGNED(-306,18),
        3 => TO_SIGNED(355,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k3 <= (
        0 => TO_SIGNED(284,18),
        1 => TO_SIGNED(445,18),
        2 => TO_SIGNED(-466,18),
        3 => TO_SIGNED(-81,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k4 <= (
        0 => TO_SIGNED(-640,18),
        1 => TO_SIGNED(595,18),
        2 => TO_SIGNED(36,18),
        3 => TO_SIGNED(-456,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k5 <= (
        0 => TO_SIGNED(-737,18),
        1 => TO_SIGNED(44,18),
        2 => TO_SIGNED(693,18),
        3 => TO_SIGNED(889,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k6 <= (
        0 => TO_SIGNED(-172,18),
        1 => TO_SIGNED(-1004,18),
        2 => TO_SIGNED(-1197,18),
        3 => TO_SIGNED(890,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k7 <= (
        0 => TO_SIGNED(1406,18),
        1 => TO_SIGNED(1573,18),
        2 => TO_SIGNED(-1050,18),
        3 => TO_SIGNED(362,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k8 <= (
        0 => TO_SIGNED(-2029,18),
        1 => TO_SIGNED(1214,18),
        2 => TO_SIGNED(-632,18),
        3 => TO_SIGNED(-1919,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k9 <= (
        0 => TO_SIGNED(-1378,18),
        1 => TO_SIGNED(1005,18),
        2 => TO_SIGNED(2571,18),
        3 => TO_SIGNED(2580,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k10 <= (
        0 => TO_SIGNED(-1518,18),
        1 => TO_SIGNED(-3402,18),
        2 => TO_SIGNED(-3248,18),
        3 => TO_SIGNED(1537,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k11 <= (
        0 => TO_SIGNED(4478,18),
        1 => TO_SIGNED(4071,18),
        2 => TO_SIGNED(-1686,18),
        3 => TO_SIGNED(2224,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k12 <= (
        0 => TO_SIGNED(-5112,18),
        1 => TO_SIGNED(1822,18),
        2 => TO_SIGNED(-3217,18),
        3 => TO_SIGNED(-5907,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k13 <= (
        0 => TO_SIGNED(-1940,18),
        1 => TO_SIGNED(4675,18),
        2 => TO_SIGNED(7897,18),
        3 => TO_SIGNED(6493,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k14 <= (
        0 => TO_SIGNED(-6996,18),
        1 => TO_SIGNED(-10896,18),
        2 => TO_SIGNED(-8468,18),
        3 => TO_SIGNED(2036,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k15 <= (
        0 => TO_SIGNED(16073,18),
        1 => TO_SIGNED(11669,18),
        2 => TO_SIGNED(-2106,18),
        3 => TO_SIGNED(11280,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k16 <= (
        0 => TO_SIGNED(-18190,18),
        1 => TO_SIGNED(2150,18),
        2 => TO_SIGNED(-22156,18),
        3 => TO_SIGNED(-27731,18),
        others => (others => '0'));
    u0_m0_wo0_cma0_k17 <= (
        0 => TO_SIGNED(131071,18),
        1 => TO_SIGNED(118359,18),
        2 => TO_SIGNED(84638,18),
        3 => TO_SIGNED(41317,18),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_cma0_r(0) <= u0_m0_wo0_cma0_k0(TO_INTEGER(u0_m0_wo0_cma0_c0(0)));
    u0_m0_wo0_cma0_r(1) <= u0_m0_wo0_cma0_k1(TO_INTEGER(u0_m0_wo0_cma0_c0(1)));
    u0_m0_wo0_cma0_r(2) <= u0_m0_wo0_cma0_k2(TO_INTEGER(u0_m0_wo0_cma0_c0(2)));
    u0_m0_wo0_cma0_r(3) <= u0_m0_wo0_cma0_k3(TO_INTEGER(u0_m0_wo0_cma0_c0(3)));
    u0_m0_wo0_cma0_r(4) <= u0_m0_wo0_cma0_k4(TO_INTEGER(u0_m0_wo0_cma0_c0(4)));
    u0_m0_wo0_cma0_r(5) <= u0_m0_wo0_cma0_k5(TO_INTEGER(u0_m0_wo0_cma0_c0(5)));
    u0_m0_wo0_cma0_r(6) <= u0_m0_wo0_cma0_k6(TO_INTEGER(u0_m0_wo0_cma0_c0(6)));
    u0_m0_wo0_cma0_r(7) <= u0_m0_wo0_cma0_k7(TO_INTEGER(u0_m0_wo0_cma0_c0(7)));
    u0_m0_wo0_cma0_r(8) <= u0_m0_wo0_cma0_k8(TO_INTEGER(u0_m0_wo0_cma0_c0(8)));
    u0_m0_wo0_cma0_r(9) <= u0_m0_wo0_cma0_k9(TO_INTEGER(u0_m0_wo0_cma0_c0(9)));
    u0_m0_wo0_cma0_r(10) <= u0_m0_wo0_cma0_k10(TO_INTEGER(u0_m0_wo0_cma0_c0(10)));
    u0_m0_wo0_cma0_r(11) <= u0_m0_wo0_cma0_k11(TO_INTEGER(u0_m0_wo0_cma0_c0(11)));
    u0_m0_wo0_cma0_r(12) <= u0_m0_wo0_cma0_k12(TO_INTEGER(u0_m0_wo0_cma0_c0(12)));
    u0_m0_wo0_cma0_r(13) <= u0_m0_wo0_cma0_k13(TO_INTEGER(u0_m0_wo0_cma0_c0(13)));
    u0_m0_wo0_cma0_r(14) <= u0_m0_wo0_cma0_k14(TO_INTEGER(u0_m0_wo0_cma0_c0(14)));
    u0_m0_wo0_cma0_r(15) <= u0_m0_wo0_cma0_k15(TO_INTEGER(u0_m0_wo0_cma0_c0(15)));
    u0_m0_wo0_cma0_r(16) <= u0_m0_wo0_cma0_k16(TO_INTEGER(u0_m0_wo0_cma0_c0(16)));
    u0_m0_wo0_cma0_r(17) <= u0_m0_wo0_cma0_k17(TO_INTEGER(u0_m0_wo0_cma0_c0(17)));
    u0_m0_wo0_cma0_p(0) <= u0_m0_wo0_cma0_l(0) * u0_m0_wo0_cma0_r(0);
    u0_m0_wo0_cma0_p(1) <= u0_m0_wo0_cma0_l(1) * u0_m0_wo0_cma0_r(1);
    u0_m0_wo0_cma0_p(2) <= u0_m0_wo0_cma0_l(2) * u0_m0_wo0_cma0_r(2);
    u0_m0_wo0_cma0_p(3) <= u0_m0_wo0_cma0_l(3) * u0_m0_wo0_cma0_r(3);
    u0_m0_wo0_cma0_p(4) <= u0_m0_wo0_cma0_l(4) * u0_m0_wo0_cma0_r(4);
    u0_m0_wo0_cma0_p(5) <= u0_m0_wo0_cma0_l(5) * u0_m0_wo0_cma0_r(5);
    u0_m0_wo0_cma0_p(6) <= u0_m0_wo0_cma0_l(6) * u0_m0_wo0_cma0_r(6);
    u0_m0_wo0_cma0_p(7) <= u0_m0_wo0_cma0_l(7) * u0_m0_wo0_cma0_r(7);
    u0_m0_wo0_cma0_p(8) <= u0_m0_wo0_cma0_l(8) * u0_m0_wo0_cma0_r(8);
    u0_m0_wo0_cma0_p(9) <= u0_m0_wo0_cma0_l(9) * u0_m0_wo0_cma0_r(9);
    u0_m0_wo0_cma0_p(10) <= u0_m0_wo0_cma0_l(10) * u0_m0_wo0_cma0_r(10);
    u0_m0_wo0_cma0_p(11) <= u0_m0_wo0_cma0_l(11) * u0_m0_wo0_cma0_r(11);
    u0_m0_wo0_cma0_p(12) <= u0_m0_wo0_cma0_l(12) * u0_m0_wo0_cma0_r(12);
    u0_m0_wo0_cma0_p(13) <= u0_m0_wo0_cma0_l(13) * u0_m0_wo0_cma0_r(13);
    u0_m0_wo0_cma0_p(14) <= u0_m0_wo0_cma0_l(14) * u0_m0_wo0_cma0_r(14);
    u0_m0_wo0_cma0_p(15) <= u0_m0_wo0_cma0_l(15) * u0_m0_wo0_cma0_r(15);
    u0_m0_wo0_cma0_p(16) <= u0_m0_wo0_cma0_l(16) * u0_m0_wo0_cma0_r(16);
    u0_m0_wo0_cma0_p(17) <= u0_m0_wo0_cma0_l(17) * u0_m0_wo0_cma0_r(17);
    u0_m0_wo0_cma0_u(0) <= RESIZE(u0_m0_wo0_cma0_p(0),44);
    u0_m0_wo0_cma0_u(1) <= RESIZE(u0_m0_wo0_cma0_p(1),44);
    u0_m0_wo0_cma0_u(2) <= RESIZE(u0_m0_wo0_cma0_p(2),44);
    u0_m0_wo0_cma0_u(3) <= RESIZE(u0_m0_wo0_cma0_p(3),44);
    u0_m0_wo0_cma0_u(4) <= RESIZE(u0_m0_wo0_cma0_p(4),44);
    u0_m0_wo0_cma0_u(5) <= RESIZE(u0_m0_wo0_cma0_p(5),44);
    u0_m0_wo0_cma0_u(6) <= RESIZE(u0_m0_wo0_cma0_p(6),44);
    u0_m0_wo0_cma0_u(7) <= RESIZE(u0_m0_wo0_cma0_p(7),44);
    u0_m0_wo0_cma0_u(8) <= RESIZE(u0_m0_wo0_cma0_p(8),44);
    u0_m0_wo0_cma0_u(9) <= RESIZE(u0_m0_wo0_cma0_p(9),44);
    u0_m0_wo0_cma0_u(10) <= RESIZE(u0_m0_wo0_cma0_p(10),44);
    u0_m0_wo0_cma0_u(11) <= RESIZE(u0_m0_wo0_cma0_p(11),44);
    u0_m0_wo0_cma0_u(12) <= RESIZE(u0_m0_wo0_cma0_p(12),44);
    u0_m0_wo0_cma0_u(13) <= RESIZE(u0_m0_wo0_cma0_p(13),44);
    u0_m0_wo0_cma0_u(14) <= RESIZE(u0_m0_wo0_cma0_p(14),44);
    u0_m0_wo0_cma0_u(15) <= RESIZE(u0_m0_wo0_cma0_p(15),44);
    u0_m0_wo0_cma0_u(16) <= RESIZE(u0_m0_wo0_cma0_p(16),44);
    u0_m0_wo0_cma0_u(17) <= RESIZE(u0_m0_wo0_cma0_p(17),44);
    u0_m0_wo0_cma0_w(0) <= u0_m0_wo0_cma0_u(0);
    u0_m0_wo0_cma0_w(1) <= u0_m0_wo0_cma0_u(1);
    u0_m0_wo0_cma0_w(2) <= u0_m0_wo0_cma0_u(2);
    u0_m0_wo0_cma0_w(3) <= u0_m0_wo0_cma0_u(3);
    u0_m0_wo0_cma0_w(4) <= u0_m0_wo0_cma0_u(4);
    u0_m0_wo0_cma0_w(5) <= u0_m0_wo0_cma0_u(5);
    u0_m0_wo0_cma0_w(6) <= u0_m0_wo0_cma0_u(6);
    u0_m0_wo0_cma0_w(7) <= u0_m0_wo0_cma0_u(7);
    u0_m0_wo0_cma0_w(8) <= u0_m0_wo0_cma0_u(8);
    u0_m0_wo0_cma0_w(9) <= u0_m0_wo0_cma0_u(9);
    u0_m0_wo0_cma0_w(10) <= u0_m0_wo0_cma0_u(10);
    u0_m0_wo0_cma0_w(11) <= u0_m0_wo0_cma0_u(11);
    u0_m0_wo0_cma0_w(12) <= u0_m0_wo0_cma0_u(12);
    u0_m0_wo0_cma0_w(13) <= u0_m0_wo0_cma0_u(13);
    u0_m0_wo0_cma0_w(14) <= u0_m0_wo0_cma0_u(14);
    u0_m0_wo0_cma0_w(15) <= u0_m0_wo0_cma0_u(15);
    u0_m0_wo0_cma0_w(16) <= u0_m0_wo0_cma0_u(16);
    u0_m0_wo0_cma0_w(17) <= u0_m0_wo0_cma0_u(17);
    u0_m0_wo0_cma0_x(0) <= u0_m0_wo0_cma0_w(0);
    u0_m0_wo0_cma0_x(1) <= u0_m0_wo0_cma0_w(1);
    u0_m0_wo0_cma0_x(2) <= u0_m0_wo0_cma0_w(2);
    u0_m0_wo0_cma0_x(3) <= u0_m0_wo0_cma0_w(3);
    u0_m0_wo0_cma0_x(4) <= u0_m0_wo0_cma0_w(4);
    u0_m0_wo0_cma0_x(5) <= u0_m0_wo0_cma0_w(5);
    u0_m0_wo0_cma0_x(6) <= u0_m0_wo0_cma0_w(6);
    u0_m0_wo0_cma0_x(7) <= u0_m0_wo0_cma0_w(7);
    u0_m0_wo0_cma0_x(8) <= u0_m0_wo0_cma0_w(8);
    u0_m0_wo0_cma0_x(9) <= u0_m0_wo0_cma0_w(9);
    u0_m0_wo0_cma0_x(10) <= u0_m0_wo0_cma0_w(10);
    u0_m0_wo0_cma0_x(11) <= u0_m0_wo0_cma0_w(11);
    u0_m0_wo0_cma0_x(12) <= u0_m0_wo0_cma0_w(12);
    u0_m0_wo0_cma0_x(13) <= u0_m0_wo0_cma0_w(13);
    u0_m0_wo0_cma0_x(14) <= u0_m0_wo0_cma0_w(14);
    u0_m0_wo0_cma0_x(15) <= u0_m0_wo0_cma0_w(15);
    u0_m0_wo0_cma0_x(16) <= u0_m0_wo0_cma0_w(16);
    u0_m0_wo0_cma0_x(17) <= u0_m0_wo0_cma0_w(17);
    u0_m0_wo0_cma0_y(0) <= u0_m0_wo0_cma0_s(1) + u0_m0_wo0_cma0_x(0);
    u0_m0_wo0_cma0_y(1) <= u0_m0_wo0_cma0_s(2) + u0_m0_wo0_cma0_x(1);
    u0_m0_wo0_cma0_y(2) <= u0_m0_wo0_cma0_s(3) + u0_m0_wo0_cma0_x(2);
    u0_m0_wo0_cma0_y(3) <= u0_m0_wo0_cma0_s(4) + u0_m0_wo0_cma0_x(3);
    u0_m0_wo0_cma0_y(4) <= u0_m0_wo0_cma0_s(5) + u0_m0_wo0_cma0_x(4);
    u0_m0_wo0_cma0_y(5) <= u0_m0_wo0_cma0_s(6) + u0_m0_wo0_cma0_x(5);
    u0_m0_wo0_cma0_y(6) <= u0_m0_wo0_cma0_s(7) + u0_m0_wo0_cma0_x(6);
    u0_m0_wo0_cma0_y(7) <= u0_m0_wo0_cma0_s(8) + u0_m0_wo0_cma0_x(7);
    u0_m0_wo0_cma0_y(8) <= u0_m0_wo0_cma0_s(9) + u0_m0_wo0_cma0_x(8);
    u0_m0_wo0_cma0_y(9) <= u0_m0_wo0_cma0_s(10) + u0_m0_wo0_cma0_x(9);
    u0_m0_wo0_cma0_y(10) <= u0_m0_wo0_cma0_s(11) + u0_m0_wo0_cma0_x(10);
    u0_m0_wo0_cma0_y(11) <= u0_m0_wo0_cma0_s(12) + u0_m0_wo0_cma0_x(11);
    u0_m0_wo0_cma0_y(12) <= u0_m0_wo0_cma0_s(13) + u0_m0_wo0_cma0_x(12);
    u0_m0_wo0_cma0_y(13) <= u0_m0_wo0_cma0_s(14) + u0_m0_wo0_cma0_x(13);
    u0_m0_wo0_cma0_y(14) <= u0_m0_wo0_cma0_s(15) + u0_m0_wo0_cma0_x(14);
    u0_m0_wo0_cma0_y(15) <= u0_m0_wo0_cma0_s(16) + u0_m0_wo0_cma0_x(15);
    u0_m0_wo0_cma0_y(16) <= u0_m0_wo0_cma0_s(17) + u0_m0_wo0_cma0_x(16);
    u0_m0_wo0_cma0_y(17) <= u0_m0_wo0_cma0_x(17);
    u0_m0_wo0_cma0_z(0) <= u0_m0_wo0_cma0_s(0) WHEN u0_m0_wo0_cma0_anl(0) = '1' ELSE "00000000000000000000000000000000000000000000";
    u0_m0_wo0_cma0_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_a0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_b0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_c0 <= (others => (others => '0'));
            u0_m0_wo0_cma0_anl(0) <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena0 = '1') THEN
                u0_m0_wo0_cma0_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr35_mem_q),14);
                u0_m0_wo0_cma0_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split31_e),14);
                u0_m0_wo0_cma0_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split31_d),14);
                u0_m0_wo0_cma0_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split31_c),14);
                u0_m0_wo0_cma0_a0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split31_b),14);
                u0_m0_wo0_cma0_a0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split27_e),14);
                u0_m0_wo0_cma0_a0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split27_d),14);
                u0_m0_wo0_cma0_a0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split27_c),14);
                u0_m0_wo0_cma0_a0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split27_b),14);
                u0_m0_wo0_cma0_a0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split23_e),14);
                u0_m0_wo0_cma0_a0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split23_d),14);
                u0_m0_wo0_cma0_a0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split23_c),14);
                u0_m0_wo0_cma0_a0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split23_b),14);
                u0_m0_wo0_cma0_a0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split19_e),14);
                u0_m0_wo0_cma0_a0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split19_d),14);
                u0_m0_wo0_cma0_a0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split19_c),14);
                u0_m0_wo0_cma0_a0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split19_b),14);
                u0_m0_wo0_cma0_a0(17) <= RESIZE(SIGNED(u0_m0_wo0_cma0_mux_17_q),14);
                u0_m0_wo0_cma0_b0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr0_q),14);
                u0_m0_wo0_cma0_b0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_b),14);
                u0_m0_wo0_cma0_b0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_c),14);
                u0_m0_wo0_cma0_b0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_d),14);
                u0_m0_wo0_cma0_b0(4) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split1_e),14);
                u0_m0_wo0_cma0_b0(5) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split5_b),14);
                u0_m0_wo0_cma0_b0(6) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split5_c),14);
                u0_m0_wo0_cma0_b0(7) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split5_d),14);
                u0_m0_wo0_cma0_b0(8) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split5_e),14);
                u0_m0_wo0_cma0_b0(9) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split9_b),14);
                u0_m0_wo0_cma0_b0(10) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split9_c),14);
                u0_m0_wo0_cma0_b0(11) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split9_d),14);
                u0_m0_wo0_cma0_b0(12) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split9_e),14);
                u0_m0_wo0_cma0_b0(13) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split13_b),14);
                u0_m0_wo0_cma0_b0(14) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split13_c),14);
                u0_m0_wo0_cma0_b0(15) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split13_d),14);
                u0_m0_wo0_cma0_b0(16) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_split13_e),14);
                u0_m0_wo0_cma0_b0(17) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr17_mem_q),14);
                u0_m0_wo0_cma0_c0(0) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(1) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(2) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(3) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(4) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(5) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(6) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(7) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(8) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(9) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(10) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(11) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(12) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(13) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(14) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(15) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(16) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_c0(17) <= RESIZE(UNSIGNED(u0_m0_wo0_ca17_q),3);
                u0_m0_wo0_cma0_anl(0) <= not(u0_m0_wo0_aseq_q(0));
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cma0_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_cma0_ena1 = '1') THEN
                u0_m0_wo0_cma0_s(0) <= u0_m0_wo0_cma0_z(0) + u0_m0_wo0_cma0_y(0);
                u0_m0_wo0_cma0_s(1) <= u0_m0_wo0_cma0_y(1);
                u0_m0_wo0_cma0_s(2) <= u0_m0_wo0_cma0_y(2);
                u0_m0_wo0_cma0_s(3) <= u0_m0_wo0_cma0_y(3);
                u0_m0_wo0_cma0_s(4) <= u0_m0_wo0_cma0_y(4);
                u0_m0_wo0_cma0_s(5) <= u0_m0_wo0_cma0_y(5);
                u0_m0_wo0_cma0_s(6) <= u0_m0_wo0_cma0_y(6);
                u0_m0_wo0_cma0_s(7) <= u0_m0_wo0_cma0_y(7);
                u0_m0_wo0_cma0_s(8) <= u0_m0_wo0_cma0_y(8);
                u0_m0_wo0_cma0_s(9) <= u0_m0_wo0_cma0_y(9);
                u0_m0_wo0_cma0_s(10) <= u0_m0_wo0_cma0_y(10);
                u0_m0_wo0_cma0_s(11) <= u0_m0_wo0_cma0_y(11);
                u0_m0_wo0_cma0_s(12) <= u0_m0_wo0_cma0_y(12);
                u0_m0_wo0_cma0_s(13) <= u0_m0_wo0_cma0_y(13);
                u0_m0_wo0_cma0_s(14) <= u0_m0_wo0_cma0_y(14);
                u0_m0_wo0_cma0_s(15) <= u0_m0_wo0_cma0_y(15);
                u0_m0_wo0_cma0_s(16) <= u0_m0_wo0_cma0_y(16);
                u0_m0_wo0_cma0_s(17) <= u0_m0_wo0_cma0_y(17);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_cma0_delay : dspba_delay
    GENERIC MAP ( width => 40, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_cma0_s(0)(39 downto 0)), xout => u0_m0_wo0_cma0_qq, clk => clk, aclr => areset );
    u0_m0_wo0_cma0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_cma0_qq(39 downto 0));

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,99)@13 + 1
    u0_m0_wo0_oseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(4 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "00011";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_13_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "00000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 3;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(4 downto 4));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,100)@14
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_q and d_u0_m0_wo0_compute_q_14_q;

    -- u0_m0_wo0_oseq_gated_reg(REG,101)@14 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,103)@15
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,105)@15
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,106)@15 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_cma0_q;

END normal;
