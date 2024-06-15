
class fifo_scoreboard extends uvm_scoreboard;

  //import fifo_para_pkg::*;

  fifo_trans pkt_qu[$];
  logic [32-1:0] ffmem [$:16];

  uvm_analysis_imp #(fifo_trans, fifo_scoreboard) ap;

  `uvm_component_utils(fifo_scoreboard);
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction // new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap = new("ap",this);
    foreach(ffmem[i]) ffmem[i] = '0;
  endfunction // build_phase

  virtual function void write(fifo_trans tr);
    tr.print();
    pkt_qu.push_back(tr);
  endfunction // write

`ifdef FIFO_TEST
  virtual task run_phase(uvm_phase phase);
    fifo_trans ff_item;

    forever begin
      wait(pkt_qu.size() > 0);
      ff_item = pkt_qu.pop_front();

      if(ff_item.we) begin
        str.wd = tr.wd;
      end
    else if(tr.re) begin
      if(str.rd == tr.rd) `uvm_info(get_type_name(), $sformatf("PASS"),UVM_LOW)
      else `uvm_error(get_type_name(), "FAIL")
    end
  endtask // write
`else // !`ifdef FIFO_TEST

  virtual task run_phase(uvm_phase phase);
    fifo_trans ff_item;

    forever begin
      wait(pkt_qu.size() > 0);
      ff_item = pkt_qu.pop_front();

      if((ff_item.i_a + ff_item.i_b) == ff_item.o_c) begin
        `uvm_info(get_type_name(), $sformatf("PASS a=%0d b=%0d c=%0d",ff_item.i_a,ff_item.i_b,ff_item.o_c),UVM_LOW)
      end else begin
        `uvm_error(get_type_name(),  $sformatf("FAIL a=%0d b=%0d c=%0d",ff_item.i_a,ff_item.i_b,ff_item.o_c))
      end
    end

  endtask // write
`endif // !`ifdef FIFO_TEST

endclass // fifo_scoreboard
