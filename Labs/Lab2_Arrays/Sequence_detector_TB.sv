module SequenceDetector_tb();
  
  parameter clk_period = 5;
  
  logic data_in;
  logic clk;
  logic rst;
  logic sequence_detected;
  
  bit finish,finish_check;
  
  bit input_queue [$]='{0, 0, 1, 1, 0, 0, 0, 1, 1, 0};
  bit detect_design_queue[$];
  bit detect_GoldenModel_queue[$]='{0, 0, 0, 1, 0, 0, 0, 0, 1, 0};
  
  SequenceDetector DUT(.clk(clk),.reset_n(rst),.data_in(data_in),.sequence_detected(sequence_detected));
  
  always #(clk_period) clk=~clk;
  
  initial begin
    clk=1'b0;
    rst=1'b0;
    
    repeat(2)@(posedge clk);
    rst=1'b1;
    
    while(finish==1'b0) begin
      if(input_queue.size==0) begin
        finish=1'b1;
      end
      else begin
        data_in=input_queue.pop_back();
        @(posedge clk);
        detect_design_queue.push_front(sequence_detected);
        $display(detect_design_queue);
      end
    end
    
    while(finish_check==1'b0) begin
      if(detect_GoldenModel_queue.size==0) begin
        finish_check=1'b1;
      end
      else begin
        if(detect_design_queue.pop_back()==detect_GoldenModel_queue.pop_front()) begin
          $display("design test case passed");
        end
        else begin
          $display("design test case failed");
        end
        end
    end
	$dumpfile("SequenceDetector_TB.vcd");
    $dumpvars();
    #300 $finish; // Finish simulation after 300 time units
  end
endmodule
