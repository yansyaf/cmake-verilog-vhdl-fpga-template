
module buffer_tb ();

parameter N = 32;

reg             clk;    
reg             rst;    
reg     [N-1:0] in0;   
reg     [N-1:0] in1;
reg             in_en;   
wire    [N-1:0] out;   
reg             out_en;   

// Clock generator
always #1 clk = ~clk;

initial begin
  $dumpfile ("buffer.vcd");
  //$dumpvars();
  clk = 0;
  rst = 1;
  in0 = 0;
  in1 = 0;
  in_en = 0;
  #10 rst = 0;
  repeat (1) @ (posedge clk);
  in0 <= 1;
  repeat (1) @ (posedge clk);
  in0 <= 0;
  repeat (1) @ (posedge clk);
  in0 <= 1;
  in1 <= 1;
  repeat (1) @ (posedge clk);
  in_en <= 1;
  in1 <= 0;
  repeat (1) @ (posedge clk);
  in_en <= 1;
  out_en <= 0;
  repeat (1) @ (posedge clk);
  out_en <= 1;
  repeat (1) @ (posedge clk);
  in0 <= 0;
  repeat (1) @ (posedge clk);
  #10 $finish;
end 

// Connect the DUT
buffer U (
 .clk,    
 .rst,    
 .in0,   
 .in1,   
 .in_en,   
 .out,   
 .out_en 
);

endmodule