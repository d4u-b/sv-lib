
class fifo_driver extends uvm_driver #(fifo_trans);

  `uvm_component_utils(fifo_driver)

  virtual sfifo_dut_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction // new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual sfifo_dut_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Could not get vif")
  endfunction // build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      fifo_trans ff_tr;
      seq_item_port.get_next_item(ff_tr);
      @(posedge vif.clk);
      if(ff_tr.we) begin
        vif.fifo_we = ff_tr.we;
        vif.fifo_wd = ff_tr.wd;
      end
      else if(ff_tr.re) begin
        vif.fifo_re = ff_tr.re;
        ff_tr.rd = vif.fifo_rd;
      end
      seq_item_port.item_done();
    end
  endtask // run_phase


endclass // fifo_driver