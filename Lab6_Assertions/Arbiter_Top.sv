module arb_top;
  bit clk;
  always #20 clk = ~clk;
  
  Arb_TB_Int intf(clk);
  arb_with_port arbiter(intf);
  Arbiter_TB arbiter_tb (intf);
  
endmodule