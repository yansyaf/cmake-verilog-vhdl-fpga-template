// Synchronous FIFO.  1024 x 32 bit words.
//
module fifo (
   clk, 
   rstp, 
   din, 
   writep, 
   readp, 
   dout, 
   emptyp, 
   fullp);

input             clk;
input             rstp;
input [31:0]      din;
input             readp;
input             writep;
output [31:0]     dout;
output            emptyp;
output            fullp;

// Defines sizes in terms of bits.
//
parameter         DEPTH = 1024;               // 2 bits, e.g. 4 words in the FIFO.
parameter         MAX_COUNT = 10'b1111111111;  // topmost address in FIFO.

reg               emptyp;
reg               fullp;

// Registered output.
reg [31:0]        dout;

// Define the FIFO pointers.  A FIFO is essentially a circular queue.
//
reg [(DEPTH-1):0]        tail;
reg [(DEPTH-1):0]        head;

// Define the FIFO counter.  Counts the number of entries in the FIFO which
// is how we figure out things like Empty and Full.
//
reg [(DEPTH-1):0]        count;

// Define our regsiter bank.  This is actually synthesizable!
//
reg [31:0] fifomem[0:MAX_COUNT];

// Dout is registered and gets the value that tail points to RIGHT NOW.
//
always @(posedge clk) begin
   if (rstp == 1) begin
      dout <= 16'h0000;
   end
   else begin
      dout <= fifomem[tail];
   end
end 
     
// Update FIFO memory.
always @(posedge clk) begin
   if (rstp == 1'b0 && writep == 1'b1 && fullp == 1'b0) begin
      fifomem[head] <= din;
   end
end
                  
// Update the head register.
//
always @(posedge clk) begin
   if (rstp == 1'b1) begin
      head <= 2'b00;
   end
   else begin
      if (writep == 1'b1 && fullp == 1'b0) begin
         // WRITE
         head <= head + 1;
      end
   end
end

// Update the tail register.
//
always @(posedge clk) begin
   if (rstp == 1'b1) begin
      tail <= 2'b00;
   end
   else begin
      if (readp == 1'b1 && emptyp == 1'b0) begin
         // READ               
         tail <= tail + 1;
      end
   end
end

// Update the count regsiter.
//
always @(posedge clk) begin
   if (rstp == 1'b1) begin
      count <= 2'b00;
   end
   else begin
      case ({readp, writep})
         2'b00: count <= count;
         2'b01: 
            // WRITE
            if (count != MAX_COUNT) 
               count <= count + 1;
         2'b10: 
            // READ
            if (count != 2'b00)
               count <= count - 1;
         2'b11:
            // Concurrent read and write.. no change in count
            count <= count;
      endcase
   end
end

         
// *** Update the flags
//
// First, update the empty flag.
//
always @(count) begin
   if (count == 2'b00)
      emptyp <= 1'b1;
   else
      emptyp <= 1'b0;
end


// Update the full flag
//
always @(count) begin
   if (count == MAX_COUNT)
      fullp <= 1'b1;
   else
      fullp <= 1'b0;
end

endmodule