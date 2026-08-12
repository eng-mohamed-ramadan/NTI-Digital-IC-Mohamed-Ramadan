module disable_loop_block;

  initial begin
    find_first_one(8'b0100_0000);
  end

  task find_first_one(input [7:0] data);
    integer i;
    begin
      begin : search_block 
        for (i = 0; i < 8; i = i + 1) 
		  begin : loop_block
            if (data[i] == 1'b1) 
		      begin
                $display("First '1' found at bit position %0d", i);
                // disable search_block;
                // disable ;
                // disable find_first_one;
                disable loop_block;
              end
          end
        $display("No '1' found in the data."); 
      end 
      
      $display("Task continuing after the search block...");
    end
  endtask

endmodule