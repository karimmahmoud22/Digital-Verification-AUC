module FIFO_ASSERTIONS( fifo_interface assert_port, input bit write_ptr, read_ptr);

    // Assertion 1:
    // When the Write_enable signal is asserted and the FIFO is not full, the write pointer (write_ptr) should increment.
    assert property ( @(assert_port.cb) disable iff ( assert_port.reset || assert_port.cb.full) 
        assert_port.cb.Write_enable |-> (write_ptr === $past(write_ptr) + 1)
    );

    // Assertion 2 (Bonus)
    // Additional assertion to verify that the Read_enable signal is asserted and the FIFO is not empty,
    // the read pointer (read_ptr) should increment.
    assert property ( @(assert_port.cb) disable iff ( assert_port.reset || assert_port.cb.empty)
        assert_port.cb.Read_enable |-> (read_ptr === $past(read_ptr) + 1)
    );

    // Assertion 3 (Bonus)
    // When the FIFO is reset, the write pointer (write_ptr) and read pointer (read_ptr) should be reset to 0.
    // Also, the empty signal should be 1.
    assert property ( @(assert_port.cb) disable iff ( !assert_port.reset)
        (write_ptr === 0 && read_ptr === 0)
    );

endmodule