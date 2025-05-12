//----------------------------------------------------
// A crazy buffer, it's add two input into single output
// and store on a buffer
//----------------------------------------------------
module buffer (
  clk,    
  rst,    
  in0,   
  in1,
  in_en,   
  out,
  out_en
);
// --------------Port Declaration-----------------------
parameter N = 32;

input             clk;    
input             rst;    
input     [N-1:0] in0;   
input     [N-1:0] in1;   
input             in_en;
input             out_en;
output    [N-1:0] out;   

//--------------Internal Registers----------------------
wire      [N-1:0] sum;
wire      [N-1:0] out;
wire              empty;
wire              full;

//--------------Code Starts Here----------------------- 
ADDER iadder (
  .A      (in0),
  .B      (in1),
  .carry  (carry),
  .sum    (sum)
  );

`ifdef TARGET_XILINX
  fifo I_FIFO (
      .clk    (clk),
      .srst   (rst),
      .din    (sum),
      .wr_en  (in_en),
      .rd_en  (out_en),
      .dout   (out),
      .full   (full),
      .empty  (empty)
    );
`else
  `ifdef TARGET_ALTERA
    fifo I_FIFO (
      .clock  (clk),
      .data   (sum),
      .wrreq  (in_en),
      .rdreq  (out_en),
      .q      (out),
      .full   (full),
      .empty  (empty)
    );
  `else
    `ifdef TARGET_MODEL
      fifo I_FIFO(
        .clk     (clk), 
        .rstp    (!rst), 
        .din     (sum), 
        .writep  (in_en), 
        .readp   (out_en), 
        .dout    (out), 
        .emptyp  (empty), 
        .fullp   (full)
      );
    `endif
  `endif
`endif

endmodule