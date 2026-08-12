module disable_from_outside;
  reg reset;

  initial begin
    reset = 0;
    #25 reset = 1; 
  end

  initial begin
    long_operation();
    $display("Time %0t: Thread 1 moving on...", $time);
  end

  always @(posedge reset) begin
    $display("Time %0t: Reset detected! Force-disabling the task.", $time);
    disable long_operation; 
  end

  task long_operation;
    begin
      $display("Time %0t: Starting long operation...", $time);
      #10 $display("Time %0t: Step 1 done...", $time);
      #10 $display("Time %0t: Step 2 done...", $time);
      
      #10 $display("Time %0t: Step 3 done...", $time); 
      $display("Time %0t: Operation complete.", $time);
    end
  endtask

endmodule