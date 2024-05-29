//                              -*- Mode: Verilog -*-
// Filename        : cdcsync_l2l.sv
// Description     : Lelvel to level synchronizer
// Author          : CaBao
// Created On      : Wed May 29 10:53:27 2024
// Last Modified By: CaBao
// Last Modified On: Wed May 29 10:53:27 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module cdcsync_l2l
  #(
    parameter FLOP_N = 2
    )
  (
   input        des_clk,
   input        des_rstn,
   input        src_lvl, //It should come from a flop
   output logic des_lvl
   );
  
  logic [FLOP_N-1:0] sync_flop;
  always_ff @(posedge des_clk or negedge des_rstn) begin
    if(~des_rstn) sync_flop <= '0;
    else sync_flop <= {sync_flop[FLOP_N-2:0],src_lvl};
  end

  assign des_lvl = sync_flop[FLOP_N-1];
  
endmodule // cdcsync_l2l
