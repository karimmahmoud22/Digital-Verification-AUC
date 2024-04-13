program automatic Arbiter_TB(Arb_TB_Int.tb_port tb_port);
  
  initial begin
    tb_port.rst = 1'b0;
    
    #10 tb_port.rst = 1'b1;
    #10 tb_port.rst = 1'b0;

    // Test scenario 1
    #20 tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b01;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    // Test scenario 2
    #20 tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b10;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    // Test scenario 3
    #20 tb_port.cb.request <= 2'b11;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b01;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    #5 tb_port.cb.request <= 2'b10;
    @(tb_port.cb);
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);

  end

    // show the waveforms
    initial begin
        $dumpfile("arbiter_tb.vcd");
        $dumpvars();
        #500 $finish;
    end

endprogram
