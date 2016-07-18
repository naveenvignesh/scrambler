
`timescale 1ns/10ps
module lfsr_12(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [127 - 1:0] data_load;                             
output[127 - 1:0] data_out;                             
input [16 - 1:0]      serial_in;                             

reg [127 - 1:0] p12 [0:16];

integer i;
assign data_out = p12[16];

always @(*) begin
p12[0] = data_load;

for(i=0;i<16;i=i+1) begin
 
 
 p12[i+1] = scrambler(p12[i],serial_in[i]);
  //$display("i:%h  p12[i+1]=%h ",i,p12[i+1]);
 end 
end  

function [127 - 1:0] scrambler;
input [127 - 1:0] poly;
input datain;
 
reg [127 - 1:0] msb;
integer i;
msb = poly[127 - 1];
 for (i=0;i<127;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 31:scrambler[i]=msb ^ poly[i-1];
			 38:scrambler[i]=msb ^ poly[i-1];
			 67:scrambler[i]=msb ^ poly[i-1];
			 68:scrambler[i]=msb ^ poly[i-1];
			 97:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
