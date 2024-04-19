Class FIFO_COVERAGE;

    //  Implement cover points to ensure 100% coverage of the Full Flag and Empty Flag signals.
    covergroup full_emplty_flags @(posedge tb_port.cb.clk);
        full_cp  : coverpoint tb_port.cb.full;
        empty_cp : coverpoint tb_port.cb.empty;
    endgroup

    cov_group = new();
    
endclass