module SequenceDetector (
  input logic clk,        // Clock input
  input logic reset_n,    // Active low asynchronous reset input
  input logic data_in,    // Input data signal

  output logic sequence_detected // Output indicating sequence detected
);

  // Define states
  typedef enum logic [1:0] {
    IDLE,
    STATE_0,
    STATE_01,
    STATE_011
  } State_t;

  // Define state register and next state
  State_t state, next_state;

  // Sequential logic: state transition
  always_ff @(posedge clk or negedge reset_n)
  begin
    if (!reset_n)
      state <= IDLE;
    else
      state <= next_state;
  end

  // Combinational logic: next state
  always_comb begin
    case (state)
      IDLE: begin
        if (data_in == 0)
          next_state = STATE_0;
        else
          next_state = IDLE;
      end
      STATE_0: begin
        if (data_in == 1)
          next_state = STATE_01;
        else
          next_state = IDLE;
      end
      STATE_01: begin
        if (data_in == 1)
          next_state = STATE_011;
        else
          next_state = IDLE;
      end
      STATE_011: begin
        if (data_in == 0)
          next_state = STATE_0;
        else
          next_state = IDLE;
      end
      default: next_state = IDLE;
    endcase
  end

  always@(*) begin
    case(state)
      IDLE:begin
        sequence_detected=1'b0;
      end
      STATE_0:begin
        sequence_detected=1'b0;
      end
      STATE_01:begin
        sequence_detected=1'b0;
      end
      STATE_011:begin
        sequence_detected=1'b1;
      end  
    endcase
  end

endmodule
