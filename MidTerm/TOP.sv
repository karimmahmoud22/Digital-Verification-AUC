module TOP;

    bit clk;
    always #10 clk = ~clk;

  	fifo_interface #(5, 32, 2**5) fifo_int1(clk);
  	FIFO #(5, 32, 2**5) fifo1(fifo_int1);
    FIFO_CRV_TB tb1 (fifo_int1);
  	FIFO_ASSERTIONS assert1 (fifo_int1, fifo1.write_ptr, fifo1.read_ptr);  
  
endmodule