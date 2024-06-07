
class fifo_scoreboard extends uvm_scoreboard;

  import fifo_para_pkg::*;

  `uvm_component_utils(fifo_scoreboard);
  function new(string name="fifo_scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction // new

  uvm_analysis_imp #(fifo_trans, fifo_scoreboard) ap;
  fifo_trans str;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap",this);
  endfunction // build_phase

  virtual function void write(fifo_trans tr);
    if(tr.we) begin
      str.wd = tr.wd;
    end
    else if(tr.re) begin
      if(str.rd == tr.rd) `uvm_info(get_type_name(), $sformatf("PASS"),UVM_LOW)
      else `uvm_error(get_type_name(), "FAIL")
    end
  endfunction // write

endclass // fifo_scoreboard
