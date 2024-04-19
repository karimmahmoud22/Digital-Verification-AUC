module FIFO 
  #(parameter
    ADDR_WIDTH = 5,
    DATA_WIDTH = 32,
    fifo_size =2**ADDR_WIDTH )
  ( fifo_interface dut_port );

  reg  [DATA_WIDTH-1:0] FIFO  [fifo_size-1:0];  //32 locations each is 32 bits wide
  reg [ADDR_WIDTH-1:0] write_ptr,read_ptr;

  assign dut_port.empty   = ( write_ptr == read_ptr ) ? 1'b1 : 1'b0;
  assign dut_port.full    = ( read_ptr == (write_ptr+1) ) ? 1'b1 : 1'b0;
  
  integer i;
  always @ (posedge dut_port.clk , posedge dut_port.reset) begin
    if(dut_port.reset) begin
      for(i=0;i<fifo_size;i=i+1) begin
        FIFO[i]<=0;
      end
      write_ptr <=0;
    end
    else if( dut_port.Write_enable && ~dut_port.full) begin
      FIFO[write_ptr] <= dut_port.data_in;
      write_ptr <= write_ptr + 1;
    end
  end

  always @ (posedge dut_port.clk, posedge dut_port.reset) begin
    if(dut_port.reset) begin
      dut_port.data_out <= 0;
      read_ptr <= 0;
    end

    else if( dut_port.Read_enable && ~dut_port.empty) begin
      dut_port.data_out <= FIFO[read_ptr];
      read_ptr <= read_ptr + 1;
    end

  end

endmodule