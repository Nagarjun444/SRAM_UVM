  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  
 `include "interface.sv"
 `include "design.sv"
 `include "ram_sequence_item.sv"        // transaction class
 `include "ram_sequence.sv"             // sequence class
 `include "ram_sequencer.sv"            // sequencer class
 `include "ram_driver.sv"               // driver class
 `include "ram_monitor.sv"
 `include "ram_agent.sv"                // agent class  
 `include "ram_coverage.sv"             // coverage class
 `include "ram_scoreboard.sv"
 `include "ram_env.sv"                  // environment class

 `include "ram_test.sv"                 // test
//`include "tb_pkg.sv"
module top;
  
  
  bit clk; // external signal declaration
  

  //----------------------------------------------------------------------------
  intf i_intf(clk);
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  RAM DUT(.clk(i_intf.clk),
                    .data_in(i_intf.data_in),
                    .data_out(i_intf.data_out),
                    .rst_p(i_intf.rst_p),
                    .addr(i_intf.addr),
                    .rdn_wr(i_intf.rdn_wr)
                     );
  //----------------------------------------------------------------------------               
  
  always #5 clk=~clk;

  initial begin
    clk=0;
  end
  
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("test_write_read_all0");
  end
  //----------------------------------------------------------------------------
endmodule
     
