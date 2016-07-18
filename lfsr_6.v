
`timescale 1ns/10ps
module lfsr_6(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [56 - 1:0] data_load;                             
output[56 - 1:0] data_out;                             
input [10 - 1:0]      serial_in;                             

reg [56 - 1:0] p6 [0:10];

integer i;
assign data_out = p6[10];

always @(*) begin
p6[0] = data_load;

for(i=0;i<10;i=i+1) begin
 
 
 p6[i+1] = scrambler(p6[i],serial_in[i]);
  //$display("i:%h  p6[i+1]=%h ",i,p6[i+1]);
 end 
end  

function [56 - 1:0] scrambler;
input [56 - 1:0] poly;
input datain;
 
reg [56 - 1:0] msb;
integer i;
msb = poly[56 - 1];
 for (i=0;i<56;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 5:scrambler[i]=msb ^ poly[i-1];
			 20:scrambler[i]=msb ^ poly[i-1];
			 28:scrambler[i]=msb ^ poly[i-1];
			 38:scrambler[i]=msb ^ poly[i-1];
			 45:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
