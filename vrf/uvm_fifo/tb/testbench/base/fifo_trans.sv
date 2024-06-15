
class fifo_trans extends uvm_sequence_item;
  //import fifo_para_pkg::*;

  //vars
`ifdef FIFO_TEST
  rand bit [31:0] wd;
  bit [31:0]      rd;
  bit             we;
  bit             re;
`else
  localparam ADD_B = 10;
  rand bit [ADD_B-1:0]      i_a;
  rand bit [ADD_B-1:0]      i_b;
  bit [ADD_B:0]             o_c;
`endif // !`ifdef FIFO_TEST

  `uvm_object_utils(fifo_trans)

  function new(string name = "fifo_trans");
    super.new(name);
  endfunction

endclass // fifo_trans
