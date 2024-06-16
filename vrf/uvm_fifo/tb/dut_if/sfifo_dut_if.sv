//                              -*- Mode: Verilog -*-
// Filename        : sfifo_dut_if.sv
// Description     : FIFO Interface
// Author          : CaBao
// Created On      : Wed Jun  5 15:18:55 2024
// Last Modified By: CaBao
// Last Modified On: Wed Jun  5 15:18:55 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

`ifdef FIFO_TEST
interface sfifo_dut_if #(
                         parameter FIFO_D   = 12,
                         parameter FIFO_W   = 32,
                         parameter FIFO_DLY = 0, //FIFO output delay
                         parameter FIFO_ADR = $clog2(FIFO_D)//do not override
                         )
  (
   input clk,
   input rstn
   );

   //Push
  logic              fifo_we ;
  logic [FIFO_W-1:0] fifo_wd ;
  logic              fifo_full ;
  logic              fifo_ovf ;

  //Pop
  logic              fifo_re ;
  logic [FIFO_W-1:0] fifo_rd ;
  logic              fifo_empt ;
  logic              fifo_udf ;

  logic [FIFO_ADR:0] fifo_len ;

  //Flush
  logic              fifo_fsh ;

  modport tb (input fifo_full,fifo_ovf,fifo_rd,fifo_empt,fifo_udf,fifo_len,
              output fifo_we,fifo_wd,fifo_re,fifo_fsh);


endinterface // sfifo_dut_if

`else // !`ifdef FIFO_TEST

interface sfifo_dut_if #(parameter ADD_B=10)
  (
   input clk,
   input rstn
   );

  logic [ADD_B-1:0]  i_a;
  logic [ADD_B-1:0]  i_b;
  logic [ADD_B:0]    o_c;

  clocking cb_drv @(posedge clk);
    default input #1 output #1;
    output            i_a,i_b;
    input             o_c;
  endclocking // drv

  clocking cb_mon @(posedge clk);
    default input #1 output #1;
    input            i_a,i_b;
    input            o_c;
  endclocking // cb_mon

  modport drv (clocking cb_drv, input clk,rstn);
  modport mon (clocking cb_mon, input clk,rstn);

endinterface // cnt_if
`endif // !`ifdef FIFO_TEST
