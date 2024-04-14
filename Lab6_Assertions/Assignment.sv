// 1. Write a SystemVerilog assertion to check if a signal valid is high whenever a signal ready is high
assert property ( @(posedge clk) disable iff (rst_n) (ready |-> valid) ); 

// -----------------------------------------------------------------------------------------------

// 2. Write a SystemVerilog assertion to check if a sequence of events a, b, and c occurs in the given order 
// with a onecycle gap between each event. Ensure that the sequence does not trigger if the reset signal is 
// active
assert property ( @(posedge clk) disable iff (rst_n) (a ##1 b ##1 c) );

// -----------------------------------------------------------------------------------------------

// 3. Write a SystemVerilog cover directive to measure the coverage of a signal data being greater than zero.
cover property (data > 0);

// -----------------------------------------------------------------------------------------------

// 4. Write a SystemVerilog sequence that checks if a signal a is high for at least two clock cycles, followed 
// by a sequence of events b and c, and assert it.
sequence seq;
    @(posedge clk) a;
    @(posedge clk) a;
    @(posedge clk) b;
    @(posedge clk) c;
endsequence

assert property (seq);

// -----------------------------------------------------------------------------------------------

// 5. Write a SystemVerilog sequence, s1, that checks for the following pattern in a signal sequence:
// _The sequence should start with a rising edge of a signal called data_valid.
// _The sequence should then wait for a delay of 7 clock cycles.
// _After the delay, the signal data_out should be equal to the value stored in data_in before the delay.

sequence s1;
    @(posedge clk) data_valid;
    ##7;
    data_out == data_in;
endsequence

assert property (s1);

// -----------------------------------------------------------------------------------------------

// 6. Consider the following SystemVerilog sequence: S1 ##2 S2[=1:2] ##1 S3 ##1 S4[->1:3] ##1 S5.
// Your task is to analyze the given sequence and identify the conditions that will result in the sequence 
// succeeding or failing.
// Write a comprehensive explanation that includes:
// _The conditions under which the sequence will succeed.
// _The conditions that will cause the sequence to fail.
// _Provide specific examples for both success and failure cases to demonstrate your 
// understanding.

/*
S1 ##2 S2[=1:2] ##1 S3 ##1 S4[->1:3] ##1 S5

Here's what each part of the sequence means:

- `S1`: This represents event or condition S1.
- `##2`: This is the repetition operator, which specifies that the preceding event or condition must occur exactly two times.
- `S2[=1:2]`: This represents a range for event or condition S2, where it must occur between 1 and 2 times, inclusive.
- `##1`: This is another repetition operator, specifying that the preceding event or condition must occur exactly once.
- `S3`: This represents event or condition S3.
- `##1`: Another repetition operator, specifying that the preceding event or condition must occur exactly once.
- `S4[->1:3]`: This represents a range for event or condition S4, where it must occur between 1 and 3 times, inclusive. The arrow (`->`) indicates that the occurrences of S4 should be strictly increasing.
- `##1`: Another repetition operator, specifying that the preceding event or condition must occur exactly once.
- `S5`: This represents event or condition S5.

Conditions for Success:
1. Sequential Occurrence: The events or conditions must occur sequentially in the specified order.
2. Timing Constraints: Each event or condition must occur within the specified timing constraints (i.e., the time delay specified by `##` operators).
3. Occurrence Count: The events or conditions must occur the specified number of times within the specified ranges.

Conditions for Failure:
1. Violation of Timing Constraints: If any event or condition occurs outside the specified timing constraints, the sequence will fail.
2. Mismatched Occurrence Count: If any event or condition occurs a different number of times than specified by the repetition operators, the sequence will fail.
3. Out-of-Order Occurrence: If events or conditions occur out of order, the sequence will fail.

Examples:
- Success Case: Suppose S1 occurs at time 0, S2 occurs at time 2, S3 occurs at time 3, S4 occurs at time 4, S5 occurs at time 5, and all occurrences adhere to the specified timing constraints and occurrence counts. In this case, the sequence will succeed.
- Failure Case: If S4 occurs before S3 or if any event occurs outside the specified timing constraints, the sequence will fail. For example, if S4 occurs at time 3 before S3 occurs at time 2, the sequence will fail.

In summary, the sequence will succeed if all events occur sequentially, within the specified timing constraints, and adhere to the specified occurrence counts. Conversely, the sequence will fail if any of these conditions are violated.

*/