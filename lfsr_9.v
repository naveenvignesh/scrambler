
`timescale 1ns/10ps
module lfsr_9(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [116 - 1:0] data_load;                             
output[116 - 1:0] data_out;                             
input [11 - 1:0]      serial_in;                             

reg [116 - 1:0] p9 [0:11];

integer i;
assign data_out = p9[11];

always @(*) begin
p9[0] = data_load;

for(i=0;i<11;i=i+1) begin
 
 
 p9[i+1] = scrambler(p9[i],serial_in[i]);
  //$display("i:%h  p9[i+1]=%h ",i,p9[i+1]);
 end 
end  

function [116 - 1:0] scrambler;
input [116 - 1:0] poly;
input datain;
 
reg [116 - 1:0] msb;
integer i;
msb = poly[116 - 1];
 for (i=0;i<116;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 24:scrambler[i]=msb ^ poly[i-1];
			 27:scrambler[i]=msb ^ poly[i-1];
			 95:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
