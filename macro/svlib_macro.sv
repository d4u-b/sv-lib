//                              -*- Mode: Verilog -*-
// Filename        : svlib_macro.sv
// Description     : SV macro for customizing parameters of modules
// Author          : CaBao
// Created On      : Fri May 31 17:07:36 2024
// Last Modified By: CaBao
// Last Modified On: Fri May 31 17:07:36 2024
// Update Count    : 0
// Status          : Unknown, Use with caution!

`ifndef _SVLIB_MACRO_
 `define _SVLIB_MACRO_

/************************************************************************************************************** 
 * Sync FIFO
 **************************************************************************************************************/
 `define sfifo_inst(INST_N,FF_D,FF_W,FF_DLY,CK,RST_N) \
typedef struct packed { \
  logic                fifo_we; \
  logic [``FF_W-1:0] fifo_wd; \
  logic                fifo_full; \
  logic                fifo_ovf; \
  logic                fifo_re; \
  logic [``FF_W-1:0] fifo_rd; \
  logic                fifo_empt; \
  logic                fifo_udf; \
  logic [$clog2(``FF_D):0] fifo_len; \
  logic                      fifo_fsh; \
} ``INST_N``_t; \
``INST_N``_t ``INST_N; \
sync_fifo #(\
            .FIFO_D(``FF_D), \
            .FIFO_W(``FF_W), \
            .FIFO_DLY(``FF_DLY) \
            ) u_``INST_N \
(\
 .clk       (``CK), \
 .rstn      (``RST_N), \
 .fifo_we   (``INST_N.fifo_we  ), \
 .fifo_wd   (``INST_N.fifo_wd  ), \
 .fifo_full (``INST_N.fifo_full), \
 .fifo_ovf  (``INST_N.fifo_ovf ), \
 .fifo_re   (``INST_N.fifo_re  ), \
 .fifo_rd   (``INST_N.fifo_rd  ), \
 .fifo_empt (``INST_N.fifo_empt), \
 .fifo_udf  (``INST_N.fifo_udf ), \
 .fifo_len  (``INST_N.fifo_len ), \
 .fifo_fsh  (``INST_N.fifo_fsh )  \
 );






`endif
