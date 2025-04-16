// Testbench for 2-Way set Associate cache for MIPS processor
// saiful.islam@tedu.edu.tr, 12 Dec 2024
//------------------------------------------------
//`timescale 1ns/1ps
module tb;
  logic clk, rst;
  logic[31:0] addr;
  logic[31:0] out;
  logic hit;
  int tests = 0, errors = 0;
  
  //cache c1(.addr(addr),
  cache dut(.addr(addr),
           .clk(clk),
           .rst(rst),
           .out(out),
           .hit(hit)
          );
  
  always #5 clk = ~clk;
  
  initial
    begin
      clk = 1'b0;
      rst = 1'b1;
      
      addr = 32'h0; #5 
      tests = tests+1;
      $strobe("Result: hit = %1b, data = 0x%x", hit, out);
      if ( hit === 0 & out === 0 ) 
         $strobe("[Test Successfull... ]");
      else
        begin
        $strobe("[Test failed: Expected hit = %1b, data = 0x%x]", 0, 0);
    	errors = errors+1;
	  end #5
                
      addr = 32'h4; #5
      tests = tests+1;
      $strobe("Result: hit = %1b, data = 0x%x", hit, out);
      if ( hit === 0 & out === 1 ) 
        $strobe("[Test Successfull... ]");
      else
        begin
        $strobe("[Test failed: Expected hit = %1b, data = 0x%x]", 0, 1);
    	errors = errors+1;
	  end #5
                
      addr = 32'h0; #5
      tests = tests+1;
      $strobe("Result: hit = %1b, data = 0x%x", hit, out);
      if ( hit === 1 & out === 0 ) 
        $strobe("[Test Successfull... ]");
      else
        begin
        $strobe("[Test failed: Expected hit = %1b, data = 0x%x]", 1, 0);
    	errors = errors+1;
	  end #5
    
      addr = 32'h40; #5
      tests = tests+1;
      $strobe("Result: hit = %1b, data = 0x%x", hit, out);
      if ( hit === 0 & out === 32'h10 ) 
          $strobe("[Test Successfull... ]");
      else
        begin
          $strobe("[Test failed: Expected hit = %1b, data = 0x%x]", 0, 32'h10);
    	errors = errors+1;
	  end #5

      //Reset the cash          
      rst = 1'b0;
      #10
      rst = 1'b1;
      
                
      addr = 32'h4; #5
      tests = tests+1;
      $strobe("Result: hit = %1b, data = 0x%x", hit, out);
      if ( hit === 0 & out === 1 ) 
        $strobe("[Test Successfull... ]");
      else
        begin
          	$strobe("[Test failed: Expected hit = %1b, data = 0x%x]", 0, 1);
    		errors = errors+1;
	  end #5
 
      $display("=========================================================== ");
      $display("\t Total tests:  %d\n", tests);
      $display("\t Total errors: %d\n", errors);
      $display("==================================================================");

      $finish;
    end
endmodule