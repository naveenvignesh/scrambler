
`timescale 1ns/10ps
module lfsr_1(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [347 - 1:0] data_load;                             
output[347 - 1:0] data_out;                             
input [11 - 1:0]      serial_in;                             

reg [347 - 1:0] p1 [0:11];

integer i;
assign data_out = p1[11];

always @(*) begin
p1[0] = data_load;

for(i=0;i<11;i=i+1) begin
 
 
 p1[i+1] = scrambler(p1[i],serial_in[i]);
  //$display("i:%h  p1[i+1]=%h ",i,p1[i+1]);
 end 
end  

function [347 - 1:0] scrambler;
input [347 - 1:0] poly;
input datain;
 
reg [347 - 1:0] msb;
integer i;
msb = poly[347 - 1];
 for (i=0;i<347;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 31:scrambler[i]=msb ^ poly[i-1];
			 64:scrambler[i]=msb ^ poly[i-1];
			 162:scrambler[i]=msb ^ poly[i-1];
			 209:scrambler[i]=msb ^ poly[i-1];
			 236:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
