`include "fifo_agent.sv"
`include "fifo_scoreboard.sv"

class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  function new(string name="fifo_env", uvm_component parent);
    super.new(name,parent);
  endfunction // new

  fifo_agent agnt;
  fifo_scoreboard scb;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = fifo_agent::type_id::create("agnt",this);
    scb = fifo_scoreboard::type_id::create("scb",this);
  endfunction // build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.mon.ap.connect(scb.ap);
  endfunction // connect_phase

endclass // fifo_env
