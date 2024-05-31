//                              -*- Mode: Verilog -*-
// Filename        : sync_fifo.sv
// Description     : Sync FIFO
// Author          : CaBao
// Created On      : Fri May 31 15:56:36 2024
// Last Modified By: CaBao
// Last Modified On: Fri May 31 15:56:36 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

module sync_fifo
  #(
    parameter FIFO_D   = 12,
    parameter FIFO_W   = 32,
    parameter FIFO_DLY = 0, //FIFO output delay
    parameter FIFO_ADR = $clog2(FIFO_D)//do not override
    )
  (
   input                     clk,
   input                     rstn,

   //Push
   input                     fifo_we,
   input [FIFO_W-1:0]        fifo_wd,
   output logic              fifo_full,
   output logic              fifo_ovf,

   //Pop
   input                     fifo_re,
   output [FIFO_W-1:0]       fifo_rd,
   output logic              fifo_empt,
   output logic              fifo_udf,

   output logic [FIFO_ADR:0] fifo_len,
   //Flush
   input                     fifo_fsh
   );

  /************************************************************************************************************** 
   * Declare variables
   **************************************************************************************************************/
  typedef enum        logic {FULL_ADR = 0, NFULL_ADR} fifo_type_e;
  
  localparam fifo_type_e FIFO_MOD = (2**FIFO_ADR == FIFO_D) ? FULL_ADR : NFULL_ADR;
  
  logic [FIFO_D-1:0][FIFO_W-1:0] fifo_reg;
  logic [FIFO_ADR-1:0]           fifo_rpointer;
  logic [FIFO_ADR-1:0]           fifo_wpointer;
  logic [FIFO_ADR:0]             fifo_count;
  logic                          fifo_wvld;
  logic                          fifo_rvld;
  
  /************************************************************************************************************** 
   * logic
   **************************************************************************************************************/
  assign fifo_wvld = fifo_we & (~fifo_full);
  assign fifo_rvld = fifo_re & (~fifo_empt);
  
  generate 
    if(FIFO_MOD == FULL_ADR) begin:SFIFO_FADR
      always_ff @(posedge clk or negedge rstn) begin
        if(~rstn) fifo_rpointer <= '0;
        else if(fifo_fsh) fifo_rpointer <= '0;
        else if(fifo_rvld) fifo_rpointer <= FIFO_ADR'(fifo_rpointer + 1'b1);
      end

      always_ff @(posedge clk or negedge rstn) begin
        if(~rstn) fifo_wpointer <= '0;
        else if(fifo_fsh) fifo_wpointer <= '0;
        else if(fifo_wvld) fifo_wpointer <= FIFO_ADR'(fifo_wpointer + 1'b1);
      end
    end
    else begin:SFIFO_NFADR
      always_ff @(posedge clk or negedge rstn) begin
        if(~rstn) fifo_rpointer <= '0;
        else if(fifo_fsh) fifo_rpointer <= '0;
        else if(fifo_rvld) fifo_rpointer <= (fifo_rpointer==(FIFO_D-1)) ? '0 : FIFO_ADR'(fifo_rpointer + 1'b1);
      end

      always_ff @(posedge clk or negedge rstn) begin
        if(~rstn) fifo_wpointer <= '0;
        else if(fifo_fsh) fifo_wpointer <= '0;
        else if(fifo_wvld) fifo_wpointer <= (fifo_wpointer==(FIFO_D-1)) ? '0 : FIFO_ADR'(fifo_wpointer + 1'b1);
      end
    end
  endgenerate

  //Number of entries
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) fifo_count <= '0;
    else if(fifo_fsh) fifo_count <= '0;
    else begin
      case({fifo_wvld,fifo_rvld})
        2'b10: fifo_count <= fifo_count + 1'b1;
        2'b01: fifo_count <= fifo_count - 1'b1;
        2'b11: fifo_count <= fifo_count;
        default: fifo_count <= fifo_count;
      endcase
    end
  end
  
  //Write data into memory
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) fifo_reg <= '0;
    else if(fifo_fsh) fifo_reg <= '0;
    else if(fifo_wvld) fifo_reg[fifo_wpointer] <= fifo_wd;
  end

  generate
    if(FIFO_DLY == 0) begin: RD_NDLY
      assign fifo_rd = fifo_reg[fifo_rpointer];
    end
    else begin: RD_DLY
      always_ff @(posedge clk or negedge rstn) begin
        if(~rstn) fifo_rd <= '0;
        else fifo_rd <= fifo_reg[fifo_rpointer];
      end
    end
  endgenerate
  
  /************************************************************************************************************** 
   * Output
   **************************************************************************************************************/
  assign fifo_ovf = fifo_we & fifo_full;
  assign fifo_udf = fifo_re & fifo_empt;
  
  assign fifo_full = (fifo_count == FIFO_D);
  assign fifo_empt = (fifo_count == '0);
  
  assign fifo_len = fifo_count;
  
endmodule // sync_fifo
