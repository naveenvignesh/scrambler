
`timescale 1ns/10ps
module lfsr_13(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [528 - 1:0] data_load;                             
output[528 - 1:0] data_out;                             
input [14 - 1:0]      serial_in;                             

reg [528 - 1:0] p13 [0:14];

integer i;
assign data_out = p13[14];

always @(*) begin
p13[0] = data_load;

for(i=0;i<14;i=i+1) begin
 
 
 p13[i+1] = scrambler(p13[i],serial_in[i]);
  //$display("i:%h  p13[i+1]=%h ",i,p13[i+1]);
 end 
end  

function [528 - 1:0] scrambler;
input [528 - 1:0] poly;
input datain;
 
reg [528 - 1:0] msb;
integer i;
msb = poly[528 - 1];
 for (i=0;i<528;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 169:scrambler[i]=msb ^ poly[i-1];
			 283:scrambler[i]=msb ^ poly[i-1];
			 401:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
