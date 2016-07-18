
`timescale 1ns/10ps
module lfsr_10(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [43 - 1:0] data_load;                             
output[43 - 1:0] data_out;                             
input [12 - 1:0]      serial_in;                             

reg [43 - 1:0] p10 [0:12];

integer i;
assign data_out = p10[12];

always @(*) begin
p10[0] = data_load;

for(i=0;i<12;i=i+1) begin
 
 
 p10[i+1] = scrambler(p10[i],serial_in[i]);
  //$display("i:%h  p10[i+1]=%h ",i,p10[i+1]);
 end 
end  

function [43 - 1:0] scrambler;
input [43 - 1:0] poly;
input datain;
 
reg [43 - 1:0] msb;
integer i;
msb = poly[43 - 1];
 for (i=0;i<43;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 5:scrambler[i]=msb ^ poly[i-1];
			 22:scrambler[i]=msb ^ poly[i-1];
			 27:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
