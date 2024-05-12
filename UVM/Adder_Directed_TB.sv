module design_tb;
  
    reg clk, reset;
    reg [7:0] ip1, ip2;
    wire [8:0]out;
  
    // instantiate the DUT
    adder dut(.clk(clk), .reset(reset), .in1(ip1), .in2(ip2), .out(out));
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Dump waves
        $dumpfile("dump.vcd");
        $dumpvars(1);

        clk = 0;
        ip1= 0;
        ip2= 0;
        reset = 0;

        #2ns;
        reset = 1;

        #2ns;
        reset = 0;

        #10;
        ip1= 5;
        ip2= 2;

        #5;
        $display("End.");
        $finish;
    end 

endmodule