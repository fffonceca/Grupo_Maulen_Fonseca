`timescale 1ns/10ps

module Simula();
  parameter c_CLOCK_PERIOD_NS = 40;
  parameter c_CLKS_PER_BIT    = 217;
  parameter c_BIT_PERIOD      = 8600;
  
  reg r_Clock = 0;
  reg r_RX_Serial = 1;
  wire dp;
  wire [3:0] an;
  wire [6:0] seg;

  
  task UART_WRITE_BYTE;
    input [23:0] i_Data;
    integer     ii;
    begin
      
      r_RX_Serial <= 1'b0;
      #(c_BIT_PERIOD);
      #1000;
      
      for (ii=0; ii<8; ii=ii+1)
        begin
          r_RX_Serial <= i_Data[ii];
          #(c_BIT_PERIOD);
        end
      
      r_RX_Serial <= 1'b1;
      #(c_BIT_PERIOD);
     end
  endtask // UART_WRITE_BYTE
  
  
  MAIN  MAIN_INST
    (.clk(r_Clock),
     .data(r_RX_Serial),
     .dp(dp),
     .seg(seg),
     .an(an)
);
  
  always
    #(c_CLOCK_PERIOD_NS/2) r_Clock <= !r_Clock;

  initial
    begin
      // Send a command to the UART (exercise Rx)
      @(posedge r_Clock);
             UART_WRITE_BYTE(8'h1F) ;
      #10000  UART_WRITE_BYTE(8'h10) ; 
      #10000  UART_WRITE_BYTE(8'h08) ;  
      #1000 ;
    end
  
  initial 
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
endmodule
