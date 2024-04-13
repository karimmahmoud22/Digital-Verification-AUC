module arb_with_port( Arb_TB_Int.dut_port dut );

  always @( posedge dut.clk or posedge dut.rst) begin
    if (dut.rst) begin
            dut.grant <= 2'b00;
        end 
    else if (dut.request[0] == 1'b1) begin
            dut.grant <= 2'b01;
        end 
    else if (dut.request[1] == 1'b1) begin
            dut.grant <= 2'b10;
        end 
        else begin
            dut.grant <= 2'b00;
        end
    end

endmodule
