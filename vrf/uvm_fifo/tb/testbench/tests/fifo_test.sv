`include "fifo_base_test.sv"

class fifo_test extends fifo_base_test;
  `uvm_component_utils(fifo_test)

  function new(string name = "fifo_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction // new

  fifo_base_sequence seq;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //create seq
    seq = fifo_base_sequence::type_id::create("seq");
  endfunction // build_phase


  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);
    seq.start(env.agnt.sqr);
    phase.drop_objection(this);

  endtask // run_phase

endclass // fifo_test
