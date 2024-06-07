
class fifo_monitor extends uvm_monitor;

  `uvm_component_utils(fifo_monitor)

  virtual sfifo_dut_if vif;
  uvm_analysis_port #(fifo_trans) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap",this);
  endfunction // new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual sfifo_dut_if)::get(this,"","vif",vif))
      `uvm_fatal("MON","Could not get vif")
  endfunction // build_phase

  virtual task run_phase(uvm_phase phase);
    fifo_trans tr;
    forever begin
      @(posedge vif.clk);
      tr = fifo_trans::type_id::create("tr");
      if(vif.fifo_re) begin
        tr.rd = vif.fifo_rd;
        ap.write(tr);
      end
    end
  endtask // run_phase

endclass // fifo_monitor