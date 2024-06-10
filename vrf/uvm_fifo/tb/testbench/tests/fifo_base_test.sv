`include "fifo_env.sv"

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

  function void report_phase(uvm_phase phase);
    uvm_report_server svr;
    super.report_phase(phase);

    svr = uvm_report_server::get_server();
    if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
    else begin
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
      `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    end
  endfunction

endclass // fifo_base_test
