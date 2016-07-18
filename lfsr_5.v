
`timescale 1ns/10ps
module lfsr_5(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [125 - 1:0] data_load;                             
output[125 - 1:0] data_out;                             
input [14 - 1:0]      serial_in;                             

reg [125 - 1:0] p5 [0:14];

integer i;
assign data_out = p5[14];

always @(*) begin
p5[0] = data_load;

for(i=0;i<14;i=i+1) begin
 
 
 p5[i+1] = scrambler(p5[i],serial_in[i]);
  //$display("i:%h  p5[i+1]=%h ",i,p5[i+1]);
 end 
end  

function [125 - 1:0] scrambler;
input [125 - 1:0] poly;
input datain;
 
reg [125 - 1:0] msb;
integer i;
msb = poly[125 - 1];
 for (i=0;i<125;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 5:scrambler[i]=msb ^ poly[i-1];
			 90:scrambler[i]=msb ^ poly[i-1];
			 103:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
