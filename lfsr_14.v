
`timescale 1ns/10ps
module lfsr_14(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [301 - 1:0] data_load;                             
output[301 - 1:0] data_out;                             
input [16 - 1:0]      serial_in;                             

reg [301 - 1:0] p14 [0:16];

integer i;
assign data_out = p14[16];

always @(*) begin
p14[0] = data_load;

for(i=0;i<16;i=i+1) begin
 
 
 p14[i+1] = scrambler(p14[i],serial_in[i]);
  //$display("i:%h  p14[i+1]=%h ",i,p14[i+1]);
 end 
end  

function [301 - 1:0] scrambler;
input [301 - 1:0] poly;
input datain;
 
reg [301 - 1:0] msb;
integer i;
msb = poly[301 - 1];
 for (i=0;i<301;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 181:scrambler[i]=msb ^ poly[i-1];
			 209:scrambler[i]=msb ^ poly[i-1];
			 215:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
