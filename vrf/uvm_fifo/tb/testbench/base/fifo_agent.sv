`include "fifo_trans.sv"
`include "fifo_driver.sv"
`include "fifo_monitor.sv"
`include "fifo_sequencer.sv"
`include "fifo_sequence_lib.sv"

class fifo_agent extends uvm_agent;

  fifo_driver drv;
  fifo_monitor mon;
  fifo_sequencer sqr;
  //uvm_sequencer #(fifo_trans) sqr;

  `uvm_component_utils(fifo_agent)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction // new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = fifo_driver::type_id::create("drv",this);
    mon = fifo_monitor::type_id::create("mon",this);
    sqr = fifo_sequencer::type_id::create("sqr",this);
  endfunction // build_phase

  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
    drv.seq_item_port.connect(sqr.seq_item_export);
    end
  endfunction // connect_phase

endclass // fifo_agent
