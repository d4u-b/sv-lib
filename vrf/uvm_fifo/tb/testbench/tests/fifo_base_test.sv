
class fifo_base_test extends uvm_test;

  `uvm_component_utils(fifo_base_test)

  //Env inst
  fifo_env env;

  //Constructor
  function new(string name = "fifo_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction // new

  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = fifo_env::type_id::create("env",this);
  endfunction // build_phase

  virtual function void end_of_elaboration();
    print();
  endfunction // end_of_elaboration

endclass // fifo_base_test
