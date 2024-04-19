interface fifo_interface #(parameter  ADDRESS_WIDTH = 5,
                                    DATA_WIDTH = 32,
                                    fifo_size =2**ADDRESS_WIDTH )
    // inputs to interface
    ( input bit clk );
    
    logic reset;
    logic Write_enable, Read_enable;
    logic full, empty;
    logic [DATA_WIDTH-1:0] data_in, data_out;

    // clocking block
    clocking cb @(posedge clk);
        default input #2 output #2;
        input full, empty;
        input data_out;
      	// The recommended approach is using an inout
        inout data_in;
        inout Write_enable, Read_enable;
    endclocking

    // modport for DUT
    modport DUT_port(input clk, reset, Write_enable, Read_enable, data_in, output full, empty, data_out);

    // modport for testbench
    modport TB_port(input clk, output reset, clocking cb);
    

endinterface