
program automatic FIFO_CRV_TB( fifo_interface tb_port );

    class CRV;
        
        rand bit [7:0] first_eight_bits_data_in;
        rand bit [15:8] second_eight_bits_data_in;
        rand bit [23:16] third_eight_bits_data_in;
        rand bit [31:24] last_eight_bits_data_in;
        rand bit Write_enable, Read_enable;

        int third_eight_bits_data_in_first_range_weight = 3;
        int third_eight_bits_data_in_second_range_weight = 6;
        int third_eight_bits_data_in_third_range_weight = 1;
        int write_weight_75 = 3, read_weight_25 = 1;
        int write_weight_25 = 1, read_weight_75 = 3;

        constraint data_in_1_range { first_eight_bits_data_in inside {[100:230]}; }
        constraint data_in_2_range { second_eight_bits_data_in inside {[200:255]}; }
        constraint data_in_3_range { 
            third_eight_bits_data_in dist
            { 
                [0:100] := third_eight_bits_data_in_first_range_weight,
                [100:200] := third_eight_bits_data_in_second_range_weight,
                [200:255] := third_eight_bits_data_in_third_range_weight
            };
        }
        constraint data_in_4_range { 
            if (first_eight_bits_data_in > 150) 
                last_eight_bits_data_in inside {[0:50]};
            else
                last_eight_bits_data_in inside {[0:255]};
        }

        constraint write_read_weight { 
            Write_enable dist {[0:1] := write_weight_75};
            Read_enable dist {[0:1] := read_weight_25};
        }        
        constraint write_read_weight_2 { 
            Write_enable dist {[0:1] := write_weight_25};
            Read_enable dist {[0:1] := read_weight_75};
        }

        
    endclass

    //Reset the FIFO
    initial begin
        tb_port.reset <= 1'b1;
        tb_port.cb.Write_enable <= 1'b0;
        tb_port.cb.Read_enable <= 1'b0;
        @(tb_port.cb);
        tb_port.reset <= 1'b0;
        @(tb_port.cb);
    end

    CRV crv;
    // Test scenario 1
    initial begin
        crv = new();
        crv.write_read_weight_2.constraint_mode(0);
        for (int i = 0; i < 64; ++i) begin
            assert(crv.randomize());
            tb_port.cb.Write_enable <= crv.Write_enable;
            $display("tb_port.cb.Write_enable = %0h", crv.Write_enable);
            tb_port.cb.data_in <= {crv.last_eight_bits_data_in, crv.third_eight_bits_data_in, crv.second_eight_bits_data_in, crv.first_eight_bits_data_in};
            $display("tb_port.cb.data_in = %0h", {crv.last_eight_bits_data_in, crv.third_eight_bits_data_in, crv.second_eight_bits_data_in, crv.first_eight_bits_data_in});
            @(tb_port.cb);
            tb_port.cb.Read_enable <= crv.Read_enable;
            $display("tb_port.cb.Read_enable = %0h", crv.Read_enable);
            $display("tb_port.cb.data_out = %0h", tb_port.cb.data_out);
            $display("At time %0t, full = %b", $time, tb_port.cb.full);
            $display("At time %0t, empty = %b", $time, tb_port.cb.empty);
            $display("=====================================");
            @(tb_port.cb);
        end
    end

    // show the waveforms
    initial begin
        $dumpfile("arbiter_tb.vcd");
        $dumpvars();
        #1000 $finish;
    end

endprogram

/*

        assert(crv.randomize());
        tb_port.cb.Write_enable <= crv.Write_enable;
        tb_port.cb.data_in <= {crv.last_eight_bits_data_in, crv.third_eight_bits_data_in, crv.second_eight_bits_data_in, crv.first_eight_bits_data_in};
        @(tb_port.cb);
        $display("At time %0t, full = %b", $time, tb_port.cb.full);


        for (int i = 0; i < 32; ++i) begin
            $display("crv.first_eight_bits_data_in = %0h", crv.first_eight_bits_data_in);
            $display("crv.second_eight_bits_data_in = %0h", crv.second_eight_bits_data_in);
            $display("crv.third_eight_bits_data_in = %0h", crv.third_eight_bits_data_in);
            $display("crv.last_eight_bits_data_in = %0h", crv.last_eight_bits_data_in);
            $display("crv.Write_enable = %0h", crv.Write_enable);
            $display("crv.Read_enable = %0h", crv.Read_enable);
        end
*/