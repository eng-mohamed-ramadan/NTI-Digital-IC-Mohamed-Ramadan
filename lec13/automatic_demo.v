module automatic_demo;
  task automatic fixed_task;
    input  [3:0] delay;
    reg    [3:0] local_delay;   // PRIVATE
    begin
      local_delay = delay;
      #(local_delay);
      $display("delay=%0d @t=%0t",
                local_delay, $time);
    end
  endtask

  initial fixed_task(5);   // call A
  initial fixed_task(2);   // call B
endmodule