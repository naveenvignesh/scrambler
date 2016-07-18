
`timescale 1ns/10ps
module lfsr_15(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [60 - 1:0] data_load;                             
output[60 - 1:0] data_out;                             
input [15 - 1:0]      serial_in;                             

reg [60 - 1:0] p15 [0:15];

integer i;
assign data_out = p15[15];

always @(*) begin
p15[0] = data_load;

for(i=0;i<15;i=i+1) begin
 
 
 p15[i+1] = scrambler(p15[i],serial_in[i]);
//  $display("i:%h  p15[i+1]=%h ",i,p15[i+1]);
 end 
end  

function [60 - 1:0] scrambler;
input [60 - 1:0] poly;
input datain;
 
reg [60 - 1:0] msb;
integer i;
msb = poly[60 - 1];
 for (i=0;i<60;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 27:scrambler[i]=msb ^ poly[i-1];
			 28:scrambler[i]=msb ^ poly[i-1];
			 34:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
