
`timescale 1ns/10ps
module lfsr_16(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [32 - 1:0] data_load;                             
output[32 - 1:0] data_out;                             
input [16 - 1:0]      serial_in;                             

reg [32 - 1:0] p16 [0:16];

integer i;
assign data_out = p16[16];

always @(*) begin
p16[0] = data_load;

for(i=0;i<16;i=i+1) begin
 
 
 p16[i+1] = scrambler(p16[i],serial_in[i]);
  //$display("i:%h  p16[i+1]=%h ",i,p16[i+1]);
 end 
end  

function [32 - 1:0] scrambler;
input [32 - 1:0] poly;
input datain;
 
reg [32 - 1:0] msb;
integer i;
msb = poly[32 - 1];
 for (i=0;i<32;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 1:scrambler[i]=msb ^ poly[i-1];
			 2:scrambler[i]=msb ^ poly[i-1];
			 4:scrambler[i]=msb ^ poly[i-1];
			 6:scrambler[i]=msb ^ poly[i-1];
			 7:scrambler[i]=msb ^ poly[i-1];
			 10:scrambler[i]=msb ^ poly[i-1];
			 11:scrambler[i]=msb ^ poly[i-1];
			 15:scrambler[i]=msb ^ poly[i-1];
			 16:scrambler[i]=msb ^ poly[i-1];
			 17:scrambler[i]=msb ^ poly[i-1];
			 19:scrambler[i]=msb ^ poly[i-1];
			 20:scrambler[i]=msb ^ poly[i-1];
			 26:scrambler[i]=msb ^ poly[i-1];
			 28:scrambler[i]=msb ^ poly[i-1];
			 29:scrambler[i]=msb ^ poly[i-1];
			 30:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
