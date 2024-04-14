interface Arb_TB_Int(input bit clk);
  
  logic rst;
  logic [1:0] request;
  logic [1:0] grant;
  
  clocking cb @(posedge clk);
    default input #5 output #5;
    input grant;
    output request;
  endclocking
  
  	modport dut_port(input request, clk, rst,output grant);
  modport tb_port(clocking cb, output rst);
endinterface
