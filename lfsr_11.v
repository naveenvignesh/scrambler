
`timescale 1ns/10ps
module lfsr_11(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [86 - 1:0] data_load;                             
output[86 - 1:0] data_out;                             
input [15 - 1:0]      serial_in;                             

reg [86 - 1:0] p11 [0:15];

integer i;
assign data_out = p11[15];

always @(*) begin
p11[0] = data_load;

for(i=0;i<15;i=i+1) begin
 
 
 p11[i+1] = scrambler(p11[i],serial_in[i]);
  //$display("i:%h  p11[i+1]=%h ",i,p11[i+1]);
 end 
end  

function [86 - 1:0] scrambler;
input [86 - 1:0] poly;
input datain;
 
reg [86 - 1:0] msb;
integer i;
msb = poly[86 - 1];
 for (i=0;i<86;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 32:scrambler[i]=msb ^ poly[i-1];
			 47:scrambler[i]=msb ^ poly[i-1];
			 56:scrambler[i]=msb ^ poly[i-1];
			 65:scrambler[i]=msb ^ poly[i-1];
			 78:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
