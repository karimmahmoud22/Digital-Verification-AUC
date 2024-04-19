
program automatic FIFO_DIRECTED_TB( fifo_interface tb_port );

    //Reset the FIFO
    initial begin
        tb_port.reset <= 1'b1;
        tb_port.cb.Write_enable <= 1'b0;
        tb_port.cb.Read_enable <= 1'b0;
        @(tb_port.cb);
        tb_port.reset <= 1'b0;
        @(tb_port.cb);
    end

    // Test scenario 1
    initial begin
        tb_port.cb.Write_enable <= 1'b1;
        tb_port.cb.data_in <= 32'h12345678;
        @(tb_port.cb);
        $display("At time %0t, full = %b", $time, tb_port.cb.full);
    end

    // Test scenario 1
    initial begin
        tb_port.cb.Write_enable <= 1'b1;
      for (int i = 0; i < 32; ++i) begin
            tb_port.cb.data_in <= 32'h1 + i;
            @(tb_port.cb);
            $display("At time %0t, full = %b", $time, tb_port.cb.full);
        end
    end

            // show the waveforms
    initial begin
        $dumpfile("arbiter_tb.vcd");
        $dumpvars();
        #1000 $finish;
    end

endprogram