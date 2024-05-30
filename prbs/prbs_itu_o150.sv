//                              -*- Mode: Verilog -*-
// Filename        : prbs_itu_o150.sv
// Description     : Generating PRBS relies on ITU O.150
// Author          : CaBao
// Created On      : Thu May 30 17:26:33 2024
// Last Modified By: CaBao
// Last Modified On: Thu May 30 17:26:33 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module prbs_itu_o150
  #(
    parameter DATW = 64,
    parameter STA0 = 9,//9 11 15 20 20 23 29 31
    parameter STA1 = 5 //5  9 14  3 17 18 27 28
    )
  (
   input logic [STA0-1:0]  iprbs_cur,
   output logic [STA0-1:0] oprbs_nxt,
   output logic [DATW-1:0] oprbs_dat
   );

  logic [DATW-1:0]         prbs_dat;
  logic [STA0-1:0]         prbs_shf;

  //Many to one
  always_comb begin
    for(int unsigned i=0;i<DATW;i++) begin
      if(i==0) begin
        prbs_dat[DATW-1] = iprbs_cur[STA0-1]^iprbs_cur[STA1-1];
        prbs_shf         = {iprbs_cur[STA0-2:0],(iprbs_cur[STA0-1]^iprbs_cur[STA1-1])};
      end
      else begin
        prbs_dat[DATW-1-i]  = prbs_shf[STA0-1]^prbs_shf[STA1-1];
        prbs_shf            = {prbs_shf[STA0-2:0],(prbs_shf[STA0-1]^prbs_shf[STA1-1])};
      end
    end
  end
  
  //Output
  assign oprbs_dat    = prbs_dat;
  assign oprbs_nxt    = prbs_shf;

endmodule // prbs
