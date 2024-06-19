`ifndef __FIFO_PKG_SV__
 `define __FIFO_PKG_SV__

 `include "fifo_defines.sv"

package fifo_pkg;
`include "uvm_macros.svh"
  import uvm_pkg::*;

`include "fifo_test.sv"

endpackage // fifo_pkg

`endif //  `ifndef __FIFO_PKG_SV__
