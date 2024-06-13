
class fifo_base_sequence extends uvm_sequence #(fifo_trans);
  `uvm_object_utils(fifo_base_sequence)

  function new(string name="fifo_base_sequence");
    super.new(name);
  endfunction // new

  `uvm_declare_p_sequencer(fifo_sequencer)

`ifdef FIFO_TEST
  virtual task body();
    fifo_trans tr;
    tr = fifo_trans::type_id::create("tr");
    for(int i=0;i<2;i++) begin
      assert(tr.randomize());
      tr.we = 1;
      tr.re = 0;
      start_item(tr);
      finish_item(tr);
    end
  endtask // body

`else // !`ifdef FIFO_TEST
  virtual task body();
    //fifo_trans tr;
    for(int i=0;i<10;i++) begin
      `uvm_do(req)
      //tr = fifo_trans::type_id::create("tr");
      //start_item(tr);
      //tr.randomize();
      //finish_item(tr);
    end
  endtask // body
`endif // !`ifdef FIFO_TEST

endclass // fifo_base_sequence
