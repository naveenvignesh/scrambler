
`timescale 1ns/10ps
module lfsr_8(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [96 - 1:0] data_load;                             
output[96 - 1:0] data_out;                             
input [14 - 1:0]      serial_in;                             

reg [96 - 1:0] p8 [0:14];

integer i;
assign data_out = p8[14];

always @(*) begin
p8[0] = data_load;

for(i=0;i<14;i=i+1) begin
 
 
 p8[i+1] = scrambler(p8[i],serial_in[i]);
  //$display("i:%h  p8[i+1]=%h ",i,p8[i+1]);
 end 
end  

function [96 - 1:0] scrambler;
input [96 - 1:0] poly;
input datain;
 
reg [96 - 1:0] msb;
integer i;
msb = poly[96 - 1];
 for (i=0;i<96;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 15:scrambler[i]=msb ^ poly[i-1];
			 17:scrambler[i]=msb ^ poly[i-1];
			 81:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
