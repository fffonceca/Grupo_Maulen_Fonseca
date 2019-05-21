// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri May 10 16:58:31 2019
// Host        : Fokappa running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Francisco/Desktop/LAB
//               ANALOGICO/Exp3/EXP3_TECLADO/EXP3_TECLADO.srcs/sources_1/ip/MEM_SINE/MEM_SINE_stub.v}
// Design      : MEM_SINE
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.3" *)
module MEM_SINE(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],spo[6:0]" */;
  input [6:0]a;
  output [6:0]spo;
endmodule
