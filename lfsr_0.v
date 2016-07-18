
`timescale 1ns/10ps
module lfsr_0(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [220 - 1:0] data_load;                             
output[220 - 1:0] data_out;                             
input [18 - 1:0]      serial_in;                             

reg [220 - 1:0] p0 [0:18];

integer i;
assign data_out = p0[18];

always @(*) begin
p0[0] = data_load;

for(i=0;i<18;i=i+1) begin
 
 
 p0[i+1] = scrambler(p0[i],serial_in[i]);
  //$display("i:%h  p0[i+1]=%h ",i,p0[i+1]);
 end 
end  

function [220 - 1:0] scrambler;
input [220 - 1:0] poly;
input datain;
 
reg [220 - 1:0] msb;
integer i;
msb = poly[220 - 1];
 for (i=0;i<220;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 23:scrambler[i]=msb ^ poly[i-1];
			 121:scrambler[i]=msb ^ poly[i-1];
			 168:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
