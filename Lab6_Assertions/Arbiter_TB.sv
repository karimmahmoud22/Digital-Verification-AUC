// Testbench
program automatic Arbiter_TB(Arb_TB_Int.tb_port tb_port);
  
  initial begin
    tb_port.rst = 1'b1;    
    @(tb_port.cb); tb_port.rst = 1'b0;

    // Test scenario 1
    tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b00) else $error("Test scenario 1 failed: Incorrect grant signal for request 00");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);

    @(tb_port.cb); tb_port.cb.request <= 2'b01;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b01) else $error("Test scenario 1 failed: Incorrect grant signal for request 01");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b00;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b00) else $error("Test scenario 1 failed: Incorrect grant signal for request 00");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    // Test scenario 2
    @(tb_port.cb); tb_port.cb.request <= 2'b00;
    @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b00) else $error("Test scenario 2 failed: Incorrect grant signal for request 00");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b10;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b10) else $error("Test scenario 2 failed: Incorrect grant signal for request 10");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b00;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b00) else $error("Test scenario 2 failed: Incorrect grant signal for request 00");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    // Test scenario 3
    @(tb_port.cb); tb_port.cb.request <= 2'b11;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b01) else $error("Test scenario 3 failed: Incorrect grant signal for request 11");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b00;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b00) else $error("Test scenario 3 failed: Incorrect grant signal for request 00");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b01;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b01) else $error("Test scenario 3 failed: Incorrect grant signal for request 01");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);

    @(tb_port.cb); tb_port.cb.request <= 2'b10;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b10) else $error("Test scenario 3 failed: Incorrect grant signal for request 10");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    // Additional test scenario 4
    @(tb_port.cb); tb_port.cb.request <= 2'b01;
    @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b01) else $error("Test scenario 4 failed: Incorrect grant signal for request 01");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
    @(tb_port.cb); tb_port.cb.request <= 2'b11;
    repeat (2) @(tb_port.cb);
    assert (tb_port.cb.grant == 2'b11) else $error("Test scenario 4 failed: Incorrect grant signal for request 11");
    $display("At time %0t, grant = %b", $time, tb_port.cb.grant);
    
  end

    // show the waveforms
    initial begin
        $dumpfile("arbiter_tb.vcd");
        $dumpvars();
        #1500 $finish;
    end

endprogram