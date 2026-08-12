module static_demo;
  task buggy_task;
    input  [3:0] delay;
    reg    [3:0] local_delay;   // SHARED
    begin
      local_delay = delay;
      #(local_delay);
      $display("delay=%0d @t=%0t",
                local_delay, $time);
    end
  endtask

  initial buggy_task(5);   // call A
  initial buggy_task(2);   // call B
endmodule


/*
module static_demo;
  task buggy_task;
    input  [3:0] delay;
    reg    [3:0] local_delay;   // SHARED
    begin
      local_delay = delay;
     // local_delay <= delay;
     // #1;
      #(local_delay);
      $display("D: delay=%0d @t=%0t",
                local_delay, $time);
      /*
      $monitor("M: delay=%0d @t=%0t",
                local_delay, $time);
    end
  endtask

  initial buggy_task(5);   // call A
  initial buggy_task(2);   // call B
endmodule
*/