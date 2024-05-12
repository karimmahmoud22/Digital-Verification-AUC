`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "base_test.sv"

module tb_top;

    // Intialized to 0 by default as they are declared as bit
    bit clk;
    bit reset;

    // Clock generation
    always #2 clk = ~clk;

    initial begin
        reset = 1;
        #5; 
        reset = 0;
    end

    // Virtual interface
    add_if vif(clk, reset);

    // Instantiate the DUT
    adder DUT(.clk(vif.clk),.reset(vif.reset),.in1(vif.ip1),.in2(vif.ip2),.out(vif.out));

    initial begin
        // set interface in config_db
        uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
        // Dump waves
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
    
    initial begin
        run_test("base_test");
    end

endmodule