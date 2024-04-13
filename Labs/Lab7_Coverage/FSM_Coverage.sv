module FSM_TB;

  // Inputs
  reg in, clk, reset;

  // Outputs
  wire [2:0] out;

  // Instantiate the FSM module
  FSM dut (
    .in(in),
    .clk(clk),
    .reset(reset),
    .out(out)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    reset = 1'b1;
    #10 reset = 1'b0;
  end

  // Test scenarios
  initial begin
    // Scenario 1: Test transition S0 -> S1
    in = 1'b1;
    #20;
    // Check output and cover transition S0 -> S1
    assert(current_state == S1) else $error("Test scenario 1 failed: Incorrect state transition from S0 to S1");
    covergroup_transition_S0_S1.sample();
    // Cover output 3'b001
    assert(out === 3'b001) else $error("Test scenario 1 failed: Incorrect output value for state S1");
    covergroup_output_001.sample();


    // Scenario 2: Test transition S1 -> S2
    in = 1'b0;
    #20;
    // Check output and cover transition S1 -> S2
    assert(current_state == S2) else $error("Test scenario 2 failed: Incorrect state transition from S1 to S2");
    covergroup_transition_S1_S2.sample();
    // Cover output 3'b011
    assert(out === 3'b011) else $error("Test scenario 2 failed: Incorrect output value for state S2");
    covergroup_output_011.sample();

    // Scenario 3: Test transition S2 -> S3
    in = 1'b1;
    #20;
    // Check output and cover transition S2 -> S3
    assert(current_state == S3) else $error("Test scenario 3 failed: Incorrect state transition from S2 to S3");
    covergroup_transition_S2_S3.sample();
    // Cover output 3'b111
    assert(out === 3'b111) else $error("Test scenario 3 failed: Incorrect output value for state S3");
    covergroup_output_111.sample();

    // Scenario 4: Test transition S3 -> S0
    in = 1'b0;
    #20;
    // Check output and cover transition S3 -> S0
    assert(current_state == S0) else $error("Test scenario 4 failed: Incorrect state transition from S3 to S0");
    covergroup_transition_S3_S0.sample();
    // Cover output 3'b000
    assert(out === 3'b000) else $error("Test scenario 4 failed: Incorrect output value for state S0");
    covergroup_output_000.sample();


    // End simulation
    $finish;
  end

  // Cover groups
  covergroup fsm_states @(posedge clk);
    // Cover states S0, S1, S2, S3
    S0: coverpoint out[0] iff (current_state == S0);
    S1: coverpoint out[1] iff (current_state == S1);
    S2: coverpoint out[2] iff (current_state == S2);
    S3: coverpoint out[3] iff (current_state == S3);
  endgroup

  covergroup fsm_transitions @(posedge clk);
    // Cover state transitions
    transition_S0_S1: coverpoint {current_state, next_state} {
      bins S0_to_S1 = {S0 -> S1};
    }
    transition_S1_S2: coverpoint {current_state, next_state} {
      bins S1_to_S2 = {S1 -> S2};
    }
    transition_S2_S3: coverpoint {current_state, next_state} {
      bins S2_to_S3 = {S2 -> S3};
    }
    transition_S3_S0: coverpoint {current_state, next_state} {
      bins S3_to_S0 = {S3 -> S0};
    }
  endgroup

  covergroup fsm_outputs @(posedge clk);
    // Cover output signals
    output_000: coverpoint out[0:2] iff (out == 3'b000);
    output_001: coverpoint out[0:2] iff (out == 3'b001);
    output_011: coverpoint out[0:2] iff (out == 3'b011);
    output_111: coverpoint out[0:2] iff (out == 3'b111);
  endgroup

  // Finalize cover groups
  fsm_states.option.auto_bin_max = 3;
  fsm_transitions.option.auto_bin_max = 4;
  fsm_outputs.option.auto_bin_max = 4;
  fsm_states.option.per_instance = 1;
  fsm_transitions.option.per_instance = 1;
  fsm_outputs.option.per_instance = 1;
  fsm_states.endgroup;
  fsm_transitions.endgroup;
  fsm_outputs.endgroup;

endmodule
