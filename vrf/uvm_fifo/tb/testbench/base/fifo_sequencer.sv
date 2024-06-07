

`ifdef VERILATOR
class fifo_sequencer extends uvm_sequencer#(fifo_trans,fifo_trans);
`else
class fifo_sequencer extends uvm_sequencer#(fifo_trans);
`endif

  `uvm_component_utils(fifo_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

endclass // fifo_sequencer
