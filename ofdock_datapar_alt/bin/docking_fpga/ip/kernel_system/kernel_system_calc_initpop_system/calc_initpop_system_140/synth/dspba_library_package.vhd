-- (C) 2012 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions and other
-- software and tools, and its AMPP partner logic functions, and any output
-- files any of the foregoing (including device programming or simulation
-- files), and any associated documentation or information are expressly subject
-- to the terms and conditions of the Altera Program License Subscription
-- Agreement, Altera MegaCore Function License Agreement, or other applicable
-- license agreement, including, without limitation, that your use is for the
-- sole purpose of programming logic devices manufactured by Altera and sold by
-- Altera or its authorized distributors.  Please refer to the applicable
-- agreement for further details.

library IEEE;
use IEEE.std_logic_1164.all;

package dspba_library_package is

    component dspba_delay is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1';
            reset_kind : string := "ASYNC" 
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin   : in  std_logic_vector(width-1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;

	component dspba_mux2 is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
			xinsel  : in  std_logic_vector(0 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;

	component dspba_mux3 is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
			xin2  : in  std_logic_vector(width-1 downto 0);
			xinsel  : in  std_logic_vector(1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;
    
	component dspba_mux4 is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
			xin2  : in  std_logic_vector(width-1 downto 0);
			xin3  : in  std_logic_vector(width-1 downto 0);
			xinsel  : in  std_logic_vector(1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;	
	
	component dspba_intadd_u is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;	

	component dspba_intadd_s is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;		

	component dspba_intsub_u is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;	

	component dspba_intsub_s is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;			

	component dspba_intaddsub_u is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
			xins  : in  std_logic_vector(0 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;	

	component dspba_intaddsub_s is
        generic (
            width : natural := 8;
            depth : natural := 1;
            reset_high : std_logic := '1'
        );
        port (
            clk   : in  std_logic;
            aclr  : in  std_logic;
            ena   : in  std_logic := '1';
            xin0  : in  std_logic_vector(width-1 downto 0);
			xin1  : in  std_logic_vector(width-1 downto 0);
			xins  : in  std_logic_vector(0 downto 0);
            xout  : out std_logic_vector(width-1 downto 0)
        );
    end component;		
end dspba_library_package;