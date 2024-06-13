`include "fifo_base_test.sv"

class fifo_test extends fifo_base_test;
  import fifo_para_pkg::*;

  `uvm_component_utils(fifo_test)
  fifo_base_sequence seq;
  virtual sfifo_dut_if vif;

  function new(string name = "fifo_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction // new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(virtual sfifo_dut_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Could not get vif")
    //create seq
    seq = fifo_base_sequence::type_id::create("seq");
  endfunction // build_phase


  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);
    do_rst();
    seq.start(env.agnt.sqr);
    phase.drop_objection(this);

  endtask // run_phase

  virtual task do_rst();
    repeat(RST_TIME/CK_PER) @(posedge vif.clk);
  endtask // do_rst

endclass // fifo_test
