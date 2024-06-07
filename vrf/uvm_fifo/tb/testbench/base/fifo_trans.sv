
class fifo_trans extends uvm_sequence_item;
  import fifo_para_pkg::*;

  //vars
  rand bit [31:0] wd;
  bit [31:0]      rd;
  bit             we;
  bit             re;

  `uvm_object_utils(fifo_trans)

  function new(string name = "fifo_trans");
    super.new(name);
  endfunction  

endclass // fifo_trans
