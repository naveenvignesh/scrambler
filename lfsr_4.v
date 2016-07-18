
`timescale 1ns/10ps
module lfsr_4(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [61 - 1:0] data_load;                             
output[61 - 1:0] data_out;                             
input [17 - 1:0]      serial_in;                             

reg [61 - 1:0] p4 [0:17];

integer i;
assign data_out = p4[17];

always @(*) begin
p4[0] = data_load;

for(i=0;i<17;i=i+1) begin
 
 
 p4[i+1] = scrambler(p4[i],serial_in[i]);
  //$display("i:%h  p4[i+1]=%h ",i,p4[i+1]);
 end 
end  

function [61 - 1:0] scrambler;
input [61 - 1:0] poly;
input datain;
 
reg [61 - 1:0] msb;
integer i;
msb = poly[61 - 1];
 for (i=0;i<61;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 33:scrambler[i]=msb ^ poly[i-1];
			 38:scrambler[i]=msb ^ poly[i-1];
			 47:scrambler[i]=msb ^ poly[i-1];
			 52:scrambler[i]=msb ^ poly[i-1];
			 59:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
