`timescale 1ns/10ps
module lfsr_7(clk,rst,serial_in,data_load,data_out);    
input clk,rst;                              
input [411 - 1:0] data_load;                             
output[411 - 1:0] data_out;                             
input [12 - 1:0]      serial_in;

reg [411 - 1:0] p7 [0:12];

integer i;
assign data_out = p7[12];

always @(*) begin
p7[0] = data_load;

for(i=0;i<12;i=i+1) begin
 
 p7[i+1] = scrambler(p7[i],serial_in[i]);
  //$display("i:%h  p7[i+1]=%h ",i,p7[i+1]);
 end 
end  

function [411 - 1:0] scrambler;
input [411 - 1:0] poly;
input datain;
 
reg [411 - 1:0] msb;
integer i;
msb = poly[411 - 1];
 for (i=0;i<411;i=i+1) begin
   case(i) 
 			 0:scrambler[i]=msb ^ datain;
			 31:scrambler[i]=msb ^ poly[i-1];
			 60:scrambler[i]=msb ^ poly[i-1];
			 190:scrambler[i]=msb ^ poly[i-1];
			 195:scrambler[i]=msb ^ poly[i-1];
			 245:scrambler[i]=msb ^ poly[i-1];
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction
endmodule 
