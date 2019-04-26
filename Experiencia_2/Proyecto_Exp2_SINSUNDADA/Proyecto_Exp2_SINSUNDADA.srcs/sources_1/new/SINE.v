`timescale 1ns / 1ps

module SINE(
input clk,
input [1:0] sw,
output reg [7:0] salida_temp
);

wire clk_mgmt;


//llamamos el modulo
Divisordeclk  clock_para_SINE(clk,sw,clk_mgmt);


reg [7:0] sine [0:255] ;
reg [7:0] r_index = 0;

initial
begin
sine[0] <=  128;
sine[1] <=  131;
sine[2] <=  134;
sine[3] <=  137;
sine[4] <=  141;
sine[5] <=  144;
sine[6] <=  147;
sine[7] <=  150;
sine[8] <=  153;
sine[9] <=  156;
sine[10] <=  159;
sine[11] <=  162;
sine[12] <=  165;
sine[13] <=  168;
sine[14] <=  171;
sine[15] <=  174;
sine[16] <=  177;
sine[17] <=  180;
sine[18] <=  183;
sine[19] <=  186;
sine[20] <=  189;
sine[21] <=  191;
sine[22] <=  194;
sine[23] <=  197;
sine[24] <=  199;
sine[25] <=  202;
sine[26] =  205;
sine[27] =  207;
sine[28] =  209;
sine[29] =  212;
sine[30] =  214;
sine[31] =  217;
sine[32] =  219;
sine[33] =  221;
sine[34] =  223;
sine[35] =  225;
sine[36] =  227;
sine[37] =  229;
sine[38] =  231;
sine[39] =  233;
sine[40] =  235;
sine[41] =  236;
sine[42] =  238;
sine[43] =  240;
sine[44] =  241;
sine[45] =  243;
sine[46] =  244;
sine[47] =  245;
sine[48] =  246;
sine[49] =  248;
sine[50] =  249;
sine[51] =  250;
sine[52] =  251;
sine[53] =  252;
sine[54] =  252;
sine[55] =  253;
sine[56] =  254;
sine[57] =  254;
sine[58] =  255;
sine[59] =  255;
sine[60] =  255;
sine[61] =  255;
sine[62] =  255;
sine[63] =  255;
sine[64] =  255;
sine[65] =  255;
sine[66] =  255;
sine[67] =  255;
sine[68] =  255;
sine[69] =  255;
sine[70] =  254;
sine[71] =  254;
sine[72] =  253;
sine[73] =  253;
sine[74] =  252;
sine[75] =  251;
sine[76] =  250;
sine[77] =  249;
sine[78] =  248;
sine[79] =  247;
sine[80] =  246;
sine[81] =  245;
sine[82] =  243;
sine[83] =  242;
sine[84] =  240;
sine[85] =  239;
sine[86] =  237;
sine[87] =  236;
sine[88] =  234;
sine[89] =  232;
sine[90] =  230;
sine[91] =  228;
sine[92] =  226;
sine[93] =  224;
sine[94] =  222;
sine[95] =  220;
sine[96] =  218;
sine[97] =  215;
sine[98] =  213;
sine[99] =  211;
sine[100] =  208;
sine[101] =  206;
sine[102] =  203;
sine[103] =  201;
sine[104] =  198;
sine[105] =  195;
sine[106] =  193;
sine[107] =  190;
sine[108] =  187;
sine[109] =  184;
sine[110] =  181;
sine[111] =  179;
sine[112] =  176;
sine[113] =  173;
sine[114] =  170;
sine[115] =  167;
sine[116] =  164;
sine[117] =  161;
sine[118] =  158;
sine[119] =  155;
sine[120] =  152;
sine[121] =  148;
sine[122] =  145;
sine[123] =  142;
sine[124] =  139;
sine[125] =  136;
sine[126] =  133;
sine[127] =  130;
sine[128] =  126;
sine[129] =  123;
sine[130] =  120;
sine[131] =  117;
sine[132] =  114;
sine[133] =  111;
sine[134] =  108;
sine[135] =  104;
sine[136] =  101;
sine[137] =  98;
sine[138] =  95;
sine[139] =  92;
sine[140] =  89;
sine[141] =  86;
sine[142] =  83;
sine[143] =  80;
sine[144] =  77;
sine[145] =  75;
sine[146] =  72;
sine[147] =  69;
sine[148] =  66;
sine[149] =  63;
sine[150] =  61;
sine[151] =  58;
sine[152] =  55;
sine[153] =  53;
sine[154] =  50;
sine[155] =  48;
sine[156] =  45;
sine[157] =  43;
sine[158] =  41;
sine[159] =  38;
sine[160] =  36;
sine[161] =  34;
sine[162] =  32;
sine[163] =  30;
sine[164] =  28;
sine[165] =  26;
sine[166] =  24;
sine[167] =  22;
sine[168] =  20;
sine[169] =  19;
sine[170] =  17;
sine[171] =  16;
sine[172] =  14;
sine[173] =  13;
sine[174] =  11;
sine[175] =  10;
sine[176] =  9;
sine[177] =  8;
sine[178] =  7;
sine[179] =  6;
sine[180] =  5;
sine[181] =  4;
sine[182] =  3;
sine[183] =  3;
sine[184] =  2;
sine[185] =  2;
sine[186] =  1;
sine[187] =  1;
sine[188] =  0;
sine[189] =  0;
sine[190] =  0;
sine[191] =  0;
sine[192] =  0;
sine[193] =  0;
sine[194] =  0;
sine[195] =  1;
sine[196] =  1;
sine[197] =  1;
sine[198] =  2;
sine[199] =  2;
sine[200] =  3;
sine[201] =  4;
sine[202] =  4;
sine[203] =  5;
sine[204] =  6;
sine[205] =  7;
sine[206] =  8;
sine[207] =  10;
sine[208] =  11;
sine[209] =  12;
sine[210] =  13;
sine[211] =  15;
sine[212] =  16;
sine[213] =  18;
sine[214] =  20;
sine[215] =  21;
sine[216] =  23;
sine[217] =  25;
sine[218] =  27;
sine[219] =  29;
sine[220] =  31;
sine[221] =  33;
sine[222] =  35;
sine[223] =  37;
sine[224] =  39;
sine[225] =  42;
sine[226] =  44;
sine[227] =  47;
sine[228] =  49;
sine[229] =  51;
sine[230] =  54;
sine[231] =  57;
sine[232] =  59;
sine[233] =  62;
sine[234] =  65;
sine[235] =  67;
sine[236] =  70;
sine[237] =  73;
sine[238] =  76;
sine[239] =  79;
sine[240] =  82;
sine[241] =  85;
sine[242] =  88;
sine[243] =  91;
sine[244] =  94;
sine[245] =  97;
sine[246] =  100;
sine[247] =  103;
sine[248] =  106;
sine[249] =  109;
sine[250] =  112;
sine[251] =  115;
sine[252] =  119;
sine[253] =  122;
sine[254] =  125;
sine[255] =  128;
end

always @(posedge clk_mgmt)
begin
    r_index <= r_index + 1;
    salida_temp <= sine[r_index];
end

endmodule
