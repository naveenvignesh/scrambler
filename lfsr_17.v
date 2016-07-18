`timescale 1ns/10ps

module lfsr_17(clk,rst,serial_in,data_load,data_out,data_load_p7);    
input clk,rst;                              
input [64 - 1:0] data_load;                             
output[64 - 1:0] data_out;                             
input [7 - 1:0]      serial_in;                             

reg [64 - 1:0] p17 [0:7];

input [411 - 1:0] data_load_p7;                             
reg [411 - 1:0] p7 [0:7];

integer i;
assign data_out = p17[7];

always @(*) begin
p17[0] = data_load;
p7[0] = data_load_p7;

for(i=0;i<7;i=i+1) begin
 
 p17[i+1] = scrambler(p17[i],p7[i][410]);
 p7[i+1]  = scrambler_p7(p7[i],serial_in[i]);
 // taking msb of p7 
 // $display("i:%h  p17[i+1]=%h ",i,p17[i+1]);
 end 
end  

function [64 - 1:0] scrambler;
input [64 - 1:0] poly;
input datain;
 
reg [64 - 1:0] msb;
integer i;
msb = poly[64 - 1];
 for (i=0;i<64;i=i+1) begin
   case(i) 
 			 1:scrambler[i]=msb ^ poly[i-1];
			 6:scrambler[i]=msb ^ poly[i-1];
			 8:scrambler[i]=msb ^ poly[i-1];
			 9:scrambler[i]=msb ^ poly[i-1];
			 10:scrambler[i]=msb ^ poly[i-1];
			 11:scrambler[i]=msb ^ poly[i-1];
			 16:scrambler[i]=msb ^ poly[i-1];
			 17:scrambler[i]=msb ^ poly[i-1];
			 18:scrambler[i]=msb ^ poly[i-1];
			 23:scrambler[i]=msb ^ poly[i-1];
			 24:scrambler[i]=msb ^ poly[i-1];
			 25:scrambler[i]=msb ^ poly[i-1];
			 26:scrambler[i]=msb ^ poly[i-1];
			 28:scrambler[i]=msb ^ poly[i-1];
			 30:scrambler[i]=msb ^ poly[i-1];
			 31:scrambler[i]=msb ^ poly[i-1];
			 32:scrambler[i]=msb ^ poly[i-1];
			 34:scrambler[i]=msb ^ poly[i-1];
			 36:scrambler[i]=msb ^ poly[i-1];
			 39:scrambler[i]=msb ^ poly[i-1];
			 40:scrambler[i]=msb ^ poly[i-1];
			 41:scrambler[i]=msb ^ poly[i-1];
			 42:scrambler[i]=msb ^ poly[i-1];
			 44:scrambler[i]=msb ^ poly[i-1];
			 46:scrambler[i]=msb ^ poly[i-1];
			 50:scrambler[i]=msb ^ poly[i-1];
			 51:scrambler[i]=msb ^ poly[i-1];
			 53:scrambler[i]=msb ^ poly[i-1];
			 54:scrambler[i]=msb ^ poly[i-1];
			 56:scrambler[i]=msb ^ poly[i-1];
			 59:scrambler[i]=msb ^ poly[i-1];
			 62:scrambler[i]=msb ^ poly[i-1];
			 63:scrambler[i]=msb ^ poly[i-1];
			     0:scrambler[i]= datain;
	
			default: scrambler[i] = poly[i-1];   
endcase
end 
endfunction

function [411 - 1:0] scrambler_p7;
input [411 - 1:0] poly;
input datain;
 
reg [411 - 1:0] msb;
integer i;
msb = poly[411 - 1];
 for (i=0;i<411;i=i+1) begin
   case(i) 
 			 0:scrambler_p7[i]=msb ^ datain;
			 31:scrambler_p7[i]=msb ^ poly[i-1];
			 60:scrambler_p7[i]=msb ^ poly[i-1];
			 190:scrambler_p7[i]=msb ^ poly[i-1];
			 195:scrambler_p7[i]=msb ^ poly[i-1];
			 245:scrambler_p7[i]=msb ^ poly[i-1];
	
			default: scrambler_p7[i] = poly[i-1];   
endcase
end 
endfunction

endmodule 
