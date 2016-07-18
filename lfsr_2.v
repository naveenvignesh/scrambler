
`timescale 1ns/10ps
module lfsr_2(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [70 - 1:0] data_load;                             
output[70 - 1:0] data_out;                             
input [12 - 1:0]      serial_in;                             

reg [70 - 1:0] p2 [0:12];

integer i;
assign data_out = p2[12];

always @(*) begin
p2[0] = data_load;

for(i=0;i<12;i=i+1) begin
 
 
 p2[i+1] = scrambler(p2[i],serial_in[i]);
  //$display("i:%h  p2[i+1]=%h ",i,p2[i+1]);
 end 
end  

function [70 - 1:0] scrambler;
input [70 - 1:0] poly;
input datain;
 
reg [70 - 1:0] msb;
integer i;
msb = poly[70 - 1];
 for (i=0;i<70;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 30:scrambler[i]=msb ^ poly[i-1];
			 34:scrambler[i]=msb ^ poly[i-1];
			 43:scrambler[i]=msb ^ poly[i-1];
			 58:scrambler[i]=msb ^ poly[i-1];
			 63:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
