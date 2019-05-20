-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Fri May 10 16:58:31 2019
-- Host        : Fokappa running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/Francisco/Desktop/LAB
--               ANALOGICO/Exp3/EXP3_TECLADO/EXP3_TECLADO.srcs/sources_1/ip/MEM_SINE/MEM_SINE_stub.vhdl}
-- Design      : MEM_SINE
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_SINE is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );

end MEM_SINE;

architecture stub of MEM_SINE is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[6:0],spo[6:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2018.3";
begin
end;
