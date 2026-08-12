module disable_task_internal;
  
  initial begin
    process_data(3);
    process_data(8); 
    process_data(2);
  end

  task process_data(input [3:0] value);
    begin
      //disable process_data; 
      if (value > 5) begin
        //disable process_data;
        $display("Time %0t: Value %0d is too high! Aborting task.", $time, value);
        disable process_data; 
      end
      
      $display("Time %0t: Processing value: %0d", $time, value);
      #10; 
    end
  endtask

endmodule