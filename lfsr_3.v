
`timescale 1ns/10ps
module lfsr_3(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [84 - 1:0] data_load;                             
output[84 - 1:0] data_out;                             
input [14 - 1:0]      serial_in;                             

reg [84 - 1:0] p3 [0:14];

integer i;
assign data_out = p3[14];

always @(*) begin
p3[0] = data_load;

for(i=0;i<14;i=i+1) begin
 
 
 p3[i+1] = scrambler(p3[i],serial_in[i]);
  //$display("i:%h  p3[i+1]=%h ",i,p3[i+1]);
 end 
end  

function [84 - 1:0] scrambler;
input [84 - 1:0] poly;
input datain;
 
reg [84 - 1:0] msb;
integer i;
msb = poly[84 - 1];
 for (i=0;i<84;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 45:scrambler[i]=msb ^ poly[i-1];
			 51:scrambler[i]=msb ^ poly[i-1];
			 59:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
