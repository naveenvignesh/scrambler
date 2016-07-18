`timescale 1ns/10ps
module se8(clk,rst,write,addr,lfsrdin,pushin,datain,entrophy,pushout,dataout);
input            clk,rst,write;
input  [12-1:0]  addr;
input  [32-1:0]  lfsrdin;
input            pushin;
input  [8-1 :0]  datain;
input  [32-1:0]  entrophy;
output           pushout;
output [32-1:0]  dataout;

//push signals 
reg pushin_1d,pushin_2d,pushin_3d;
//datain and entrophy
reg [8-1 :0]    datain_mux_in;
reg [32-1:0]    entrophy_mux_in;
// primary and secondary data registers
reg [64 -1:0]    dataselector;
reg [32 -1:0]    scrambler;
reg [220-1:0]    Poly0;
reg [347-1:0]    Poly1;
reg [70 -1:0]    Poly2;
reg [84 -1:0]    Poly3;
reg [61 -1:0]    Poly4;
reg [125-1:0]    Poly5;
reg [56 -1:0]    Poly6;
reg [411-1:0]    Poly7;
reg [96 -1:0]    Poly8;
reg [116-1:0]    Poly9;
reg [43 -1:0]    Poly10;
reg [86 -1:0]    Poly11;
reg [127-1:0]    Poly12;
reg [528-1:0]    Poly13;
reg [301-1:0]    Poly14;
reg [60 -1:0]    Poly15;

//wire [220-1:0]   p0;
//wire [347-1:0]   p1;
//wire [70 -1:0]   p2;
//wire [84 -1:0]   p3;
//wire [61 -1:0]   p4;
//wire [125-1:0]   p5;
//wire [56 -1:0]   p6;
//wire [411-1:0]   p7;
//wire [96 -1:0]   p8;
//wire [116-1:0]   p9;
//wire [43 -1:0]   p10;
//wire [86 -1:0]   p11;
//wire [127-1:0]   p12;
//wire [528-1:0]   p13;
//wire [301-1:0]   p14;
//wire [60 -1:0]   p15;

reg [220-1:0]   p0_mux_in;
reg [347-1:0]   p1_mux_in;
reg [70 -1:0]   p2_mux_in;
reg [84 -1:0]   p3_mux_in;
reg [61 -1:0]   p4_mux_in;
reg [125-1:0]   p5_mux_in;
reg [56 -1:0]   p6_mux_in;
reg [411-1:0]   p7_mux_in;
reg [96 -1:0]   p8_mux_in;
reg [116-1:0]   p9_mux_in;
reg [43 -1:0]   p10_mux_in;
reg [86 -1:0]   p11_mux_in;
reg [127-1:0]   p12_mux_in;
reg [528-1:0]   p13_mux_in;
reg [301-1:0]   p14_mux_in;
reg [60 -1:0]   p15_mux_in;

wire [64 -1:0]    dataselector_line_decoder;
//output regs
wire [64 -1:0]    dataselector_shifted;
wire [32 -1:0]    scrambler_shifted;
wire [220-1:0]    poly0_shifted;
wire [347-1:0]    poly1_shifted;
wire [70 -1:0]    poly2_shifted;
wire [84 -1:0]    poly3_shifted;
wire [61 -1:0]    poly4_shifted;
wire [125-1:0]    poly5_shifted;
wire [56 -1:0]    poly6_shifted;
wire [411-1:0]    poly7_shifted;
wire [96 -1:0]    poly8_shifted;
wire [116-1:0]    poly9_shifted;
wire [43 -1:0]    poly10_shifted;
wire [86 -1:0]    poly11_shifted;
wire [127-1:0]    poly12_shifted;
wire [528-1:0]    poly13_shifted;
wire [301-1:0]    poly14_shifted;
wire [60 -1:0]    poly15_shifted;


reg [16 -1:0]    polydata;
wire[16 -1:0]    polydataout;
reg [32 -1:0]    scramble_load;
reg [5-1  :0]    pd_sel;
reg [5-1  :0]    scramble_sel;

//instantiate primary lfsrs
lfsr_0  shift_0(.clk(clk),.rst(rst),.data_load(Poly0),.data_out(poly0_shifted),.serial_in(18'b0));
lfsr_1  shift_1(.clk(clk),.rst(rst),.data_load(Poly1),.data_out(poly1_shifted),.serial_in(11'b0));
lfsr_2  shift_2(.clk(clk),.rst(rst),.data_load(Poly2),.data_out(poly2_shifted),.serial_in(12'b0));
lfsr_3  shift_3(.clk(clk),.rst(rst),.data_load(Poly3),.data_out(poly3_shifted),.serial_in(14'b0));
lfsr_4  shift_4(.clk(clk),.rst(rst),.data_load(Poly4),.data_out(poly4_shifted),.serial_in(17'b0));
lfsr_5  shift_5(.clk(clk),.rst(rst),.data_load(Poly5),.data_out(poly5_shifted),.serial_in(14'b0));
lfsr_6  shift_6(.clk(clk),.rst(rst),.data_load(Poly6),.data_out(poly6_shifted),.serial_in(10'b0));
lfsr_7  shift_7(.clk(clk),.rst(rst),.data_load(Poly7),.data_out(poly7_shifted),.serial_in(12'b0));
lfsr_8  shift_8(.clk(clk),.rst(rst),.data_load(Poly8),.data_out(poly8_shifted),.serial_in(14'b0));
lfsr_9  shift_9(.clk(clk),.rst(rst),.data_load(Poly9),.data_out(poly9_shifted),.serial_in(11'b0));
lfsr_10 shift_10(.clk(clk),.rst(rst),.data_load(Poly10),.data_out(poly10_shifted),.serial_in(12'b0));
lfsr_11 shift_11(.clk(clk),.rst(rst),.data_load(Poly11),.data_out(poly11_shifted),.serial_in(15'b0));
lfsr_12 shift_12(.clk(clk),.rst(rst),.data_load(Poly12),.data_out(poly12_shifted),.serial_in(16'b0));
lfsr_13 shift_13(.clk(clk),.rst(rst),.data_load(Poly13),.data_out(poly13_shifted),.serial_in(14'b0));
lfsr_14 shift_14(.clk(clk),.rst(rst),.data_load(Poly14),.data_out(poly14_shifted),.serial_in(16'b0));
lfsr_15 shift_15(.clk(clk),.rst(rst),.data_load(Poly15),.data_out(poly15_shifted),.serial_in(15'b0));

// secondary flip flops
lfsr_16    scram_shift   (.clk(clk),.rst(rst),.serial_in(polydata),.data_load(scrambler),.data_out(scrambler_shifted));
lfsr_17    dselect_shift (.clk(clk),.rst(rst),.serial_in(7'h0),.data_load(dataselector),.data_out(dataselector_shifted),.data_load_p7(Poly7));

//linedecoder 
//line_decoder  decoder(.clk(clk),.rst(rst),.addr(addr),.lfsrdin(lfsrdin),.dataselector(dataselector_line_decoder),.p0(p0),.p1(p1),.p2(p2),.p3(p3),.p4(p4),.p5(p5),.p6(p6),.p7(p7),.p8(p8),.p9(p9),.p10(p10),.p11(p11),.p12(p12),.p13(p13),.p14(p14),.p15(p15));

//scrambler initial load mux
scrambler_initial_load initial_load(.clk(clk),.rst(rst),.datain(datain_mux_in),.entrophy(entrophy_mux_in),.scramble_sel(scramble_sel),.scramble_load(scramble_load));

//scrambler serialin mux 
scrambler_serialin_mux serial_in_mux(.clk(clk),.rst(rst),.pd_sel(pd_sel),.p0(p0_mux_in),.p1(p1_mux_in),.p2(p2_mux_in),.p3(p3_mux_in),.p4(p4_mux_in),.p5(p5_mux_in),.p6(p6_mux_in),.p7(p7_mux_in),.p8(p8_mux_in),.p9(p9_mux_in),.p10(p10_mux_in),.p11(p11_mux_in),.p12(p12_mux_in),.p13(p13_mux_in),.p14(p14_mux_in),.p15(p15_mux_in),.polydataout(polydataout));

//poly select and scramble select signal 
always@(*) begin

pd_sel       = 5'h0;
scramble_sel = 5'h0;

//enable select  line on pushin 
if(pushin) begin 
pd_sel       = {dataselector[53],dataselector[31],dataselector[5] ,dataselector[57],dataselector[1] };
scramble_sel = {dataselector[47],dataselector[8] ,dataselector[25],dataselector[14],dataselector[21]};
end

end 

//primary registers always block
always@(posedge clk or posedge rst) begin

   if(rst) begin
         // resetting primary and dataselector lfsr registers 
         Poly0   <= #0 220'b0;    
         Poly1   <= #0 347'b0;   
         Poly2   <= #0  70'b0; 
         Poly3   <= #0  84'b0; 
         Poly4   <= #0  61'b0; 
         Poly5   <= #0 125'b0; 
         Poly6   <= #0  56'b0; 
         Poly7   <= #0 411'b0; 
         Poly8   <= #0  96'b0; 
         Poly9   <= #0 116'b0; 
         Poly10  <= #0  43'b0;
         Poly11  <= #0  86'b0;
         Poly12  <= #0 127'b0;
         Poly13  <= #0 528'b0;
         Poly14  <= #0 301'b0;
         Poly15  <= #0  60'b0;

   end else begin
         // if write assign from lfsrdin input
         if(write) begin 

            case(addr)

            12'h044  :	Poly0[31:0]               <= #1 lfsrdin;  
            12'h045  :	Poly0[63:32]              <= #1 lfsrdin;  
            12'h046  :	Poly0[95:64]              <= #1 lfsrdin;   
            12'h047  :	Poly0[127:96]             <= #1 lfsrdin;    
            12'h048  :	Poly0[159:128]            <= #1 lfsrdin;  
            12'h049  :	Poly0[191:160]            <= #1 lfsrdin;   
            12'h04a  :	Poly0[219:192]            <= #1 lfsrdin;    
            12'h04f  :	Poly1[31:0]               <= #1 lfsrdin;          
            12'h050  :	Poly1[63:32]              <= #1 lfsrdin;     
            12'h051  :	Poly1[95:64]              <= #1 lfsrdin;     
            12'h052  :	Poly1[127:96]             <= #1 lfsrdin;    
            12'h053  :	Poly1[159:128]            <= #1 lfsrdin;    
            12'h054  :	Poly1[191:160]            <= #1 lfsrdin;       
            12'h055  :	Poly1[223:192]            <= #1 lfsrdin;         
            12'h056  :	Poly1[255:224]            <= #1 lfsrdin;       
            12'h057  :	Poly1[287:256]            <= #1 lfsrdin;      
            12'h058  :	Poly1[319:288]            <= #1 lfsrdin;       
            12'h059  :	Poly1[346:320]            <= #1 lfsrdin;         
            12'h05b  :	Poly2[31:0]               <= #1 lfsrdin;       
            12'h05c  :	Poly2[63:32]              <= #1 lfsrdin;      
            12'h05d  :	Poly2[69:64]              <= #1 lfsrdin;     
            12'h062  :	Poly3[31:0]               <= #1 lfsrdin;      
            12'h063  :	Poly3[63:32]              <= #1 lfsrdin;        
            12'h064  :	Poly3[83:64]              <= #1 lfsrdin;   
            12'h068  :	Poly4[31:0]               <= #1 lfsrdin;         
            12'h069  :	Poly4[60:32]              <= #1 lfsrdin;       
            12'h070  :	Poly5[31:0]               <= #1 lfsrdin;          
            12'h071  :	Poly5[63:32]              <= #1 lfsrdin;             
            12'h072  :	Poly5[95:64]              <= #1 lfsrdin;           
            12'h073  :	Poly5[124:96]             <= #1 lfsrdin;            
            12'h078  :	Poly6[31:0]               <= #1 lfsrdin;          
            12'h079  :	Poly6[55:32]              <= #1 lfsrdin;         
            12'h07f  :	Poly7[31:0]               <= #1 lfsrdin;           
            12'h080  :	Poly7[63:32]              <= #1 lfsrdin;          
            12'h081  :	Poly7[95:64]              <= #1 lfsrdin;         
            12'h082  :	Poly7[127:96]             <= #1 lfsrdin;         
            12'h083  :	Poly7[159:128]            <= #1 lfsrdin;          
            12'h084  :	Poly7[191:160]            <= #1 lfsrdin;            
            12'h085  :	Poly7[223:192]            <= #1 lfsrdin;         
            12'h086  :	Poly7[255:224]            <= #1 lfsrdin;             
            12'h087  :	Poly7[287:256]            <= #1 lfsrdin;         
            12'h088  :	Poly7[319:288]            <= #1 lfsrdin;            
            12'h089  :	Poly7[351:320]            <= #1 lfsrdin;            
            12'h08a  :	Poly7[383:352]            <= #1 lfsrdin;             
            12'h08b  :	Poly7[410:384]            <= #1 lfsrdin;            
            12'h08f  :	Poly8[31:0]               <= #1 lfsrdin;              
            12'h090  :	Poly8[63:32]              <= #1 lfsrdin;              
            12'h091  :	Poly8[95:64]              <= #1 lfsrdin;               
            12'h097  :	Poly9[31:0]               <= #1 lfsrdin;           
            12'h098  :	Poly9[63:32]              <= #1 lfsrdin;             
            12'h099  :	Poly9[95:64]              <= #1 lfsrdin;            
            12'h09a  :	Poly9[115:96]             <= #1 lfsrdin;                  
            12'h0a1  :	Poly10[31:0]              <= #1 lfsrdin;                
            12'h0a2  :	Poly10[42:32]             <= #1 lfsrdin;               
            12'h0aa  :	Poly11[31:0]              <= #1 lfsrdin;          
            12'h0ab  :	Poly11[63:32]             <= #1 lfsrdin;               
            12'h0ac  :	Poly11[85:64]             <= #1 lfsrdin;                 
            12'h0b4  :	Poly12[31:0]              <= #1 lfsrdin;              
            12'h0b5  :	Poly12[63:32]             <= #1 lfsrdin;              
            12'h0b6  :	Poly12[95:64]             <= #1 lfsrdin;           
            12'h0b7  :	Poly12[126:96]            <= #1 lfsrdin;               
            12'h0be  :	Poly13[31:0]              <= #1 lfsrdin;             
            12'h0bf  :	Poly13[63:32]             <= #1 lfsrdin;         
            12'h0c0  :	Poly13[95:64]             <= #1 lfsrdin;              
            12'h0c1  :	Poly13[127:96]            <= #1 lfsrdin;               
            12'h0c2  :	Poly13[159:128]           <= #1 lfsrdin;             
            12'h0c3  :	Poly13[191:160]           <= #1 lfsrdin;                
            12'h0c4  :	Poly13[223:192]           <= #1 lfsrdin;               
            12'h0c5  :	Poly13[255:224]           <= #1 lfsrdin;           
            12'h0c6  :	Poly13[287:256]           <= #1 lfsrdin;              
            12'h0c7  :	Poly13[319:288]           <= #1 lfsrdin;               
            12'h0c8  :	Poly13[351:320]           <= #1 lfsrdin;            
            12'h0c9  :	Poly13[383:352]           <= #1 lfsrdin;                
            12'h0ca  :	Poly13[415:384]           <= #1 lfsrdin;                 
            12'h0cb  :	Poly13[447:416]           <= #1 lfsrdin;               
            12'h0cc  :	Poly13[479:448]           <= #1 lfsrdin;                     
            12'h0cd  :	Poly13[511:480]           <= #1 lfsrdin;               
            12'h0ce  :	Poly13[527:512]           <= #1 lfsrdin;                     
            12'h0cf  :	Poly14[31:0]              <= #1 lfsrdin;              
            12'h0d0  :	Poly14[63:32]             <= #1 lfsrdin;                
            12'h0d1  :	Poly14[95:64]             <= #1 lfsrdin;             
            12'h0d2  :	Poly14[127:96]            <= #1 lfsrdin;             
            12'h0d3  :	Poly14[159:128]           <= #1 lfsrdin;             
            12'h0d4  :	Poly14[191:160]           <= #1 lfsrdin;              
            12'h0d5  :	Poly14[223:192]           <= #1 lfsrdin;              
            12'h0d6  :	Poly14[255:224]           <= #1 lfsrdin;               
            12'h0d7  :	Poly14[287:256]           <= #1 lfsrdin;        
            12'h0d8  :	Poly14[300:288]           <= #1 lfsrdin;            
            12'h0dd  :	Poly15[31:0]              <= #1 lfsrdin;         
            12'h0de  :	Poly15[59:32]             <= #1 lfsrdin;          

           endcase

         end  
       
      // primary registers shifted  
//        if(pushin_1d) begin
        if(pushin) begin // keep shifted value ready and assign it when pushincomes
 
            Poly0  <= #1 poly0_shifted; 
            Poly1  <= #1 poly1_shifted; 
            Poly2  <= #1 poly2_shifted; 
            Poly3  <= #1 poly3_shifted; 
            Poly4  <= #1 poly4_shifted; 
            Poly5  <= #1 poly5_shifted; 
            Poly6  <= #1 poly6_shifted; 
            Poly7  <= #1 poly7_shifted; 
            Poly8  <= #1 poly8_shifted; 
            Poly9  <= #1 poly9_shifted; 
            Poly10 <= #1 poly10_shifted;
            Poly11 <= #1 poly11_shifted;
            Poly12 <= #1 poly12_shifted;
            Poly13 <= #1 poly13_shifted;
            Poly14 <= #1 poly14_shifted;
            Poly15 <= #1 poly15_shifted;

        end


  end 
 
end


//dataselector registers always block
always @(posedge clk or posedge rst) begin 
  if(rst) begin

    dataselector <= #0 0;
   
  end else begin
    
    if(write) begin

           case(addr) 
            12'h042  :	dataselector[31:0]     <= #1 lfsrdin; 
            12'h043  :	dataselector[63:32]    <= #1 lfsrdin; 
           endcase
    end 

    // write shifted value into dataselctor reg  
//    if(pushin_1d) begin 
    if(pushin) begin 
    dataselector <= #1 dataselector_shifted;
    end 

  end 
end 

//scrambler registers always block
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    polydata     <= #0 0;
    scrambler    <= #0 0;
    //scrambler_serial_in <= #0 0; 
  end else begin

    // load scrambler register as soon as pushin comes in    
    if(pushin) begin
    scrambler    <= #1 scramble_load;
    polydata     <= #1 polydataout;
    end
   
    // pipe for 2 clk cycles dont flop the output .... potential hold
    // violations ..... output as combinational logic with proper control
    // signal 
    //if(pushin_2d) begin 
    //scrambler    <= #1 scrambler_shifted;
    //end 
 
  end 
end 


//serialin data to polyselector mux
always@(*) begin

   p0_mux_in  = 220'b0;
   p1_mux_in  = 347'b0;
   p2_mux_in  =  70'b0;
   p3_mux_in  =  84'b0;
   p4_mux_in  =  61'b0;
   p5_mux_in  = 125'b0;
   p6_mux_in  =  56'b0;
   p7_mux_in  = 411'b0;
   p8_mux_in  =  96'b0;
   p9_mux_in  = 116'b0;
   p10_mux_in =  43'b0;
   p11_mux_in =  86'b0;
   p12_mux_in = 127'b0;
   p13_mux_in = 528'b0;
   p14_mux_in = 301'b0;
   p15_mux_in =  60'b0;

 // if pushin comes send data for shifting logic 
  if(pushin) begin  
   p0_mux_in  = Poly0  ;
   p1_mux_in  = Poly1  ;
   p2_mux_in  = Poly2  ;
   p3_mux_in  = Poly3  ;
   p4_mux_in  = Poly4  ;
   p5_mux_in  = Poly5  ;
   p6_mux_in  = Poly6  ;
   p7_mux_in  = Poly7  ;
   p8_mux_in  = Poly8  ;
   p9_mux_in  = Poly9  ;
   p10_mux_in = Poly10 ;
   p11_mux_in = Poly11 ;
   p12_mux_in = Poly12 ;
   p13_mux_in = Poly13 ;
   p14_mux_in = Poly14 ;
   p15_mux_in = Poly15 ;
  end 

end 
// input to entrphy and datain mux
always @(*) begin
 // mux input is zero if no pushin
 datain_mux_in = 8'h00;
 entrophy_mux_in = 32'h00000000;

 // mux input is vaild if pushin comes
 if(pushin) begin 
 datain_mux_in   = datain; 
 entrophy_mux_in = entrophy;
 end
end 

//input scrambler shift block 
//always @(*) begin
// 
// polydata_wire  = polydataout;
// scrambler_wire = scramble_load; 
//  
//end 

always@(posedge clk or posedge rst) begin
  if(rst) begin 
    pushin_1d <= #0 0;
    //pushin_2d <= #0 0;
  end else begin 
    pushin_1d <= #1 pushin;
    //pushin_2d <= #1 pushin_1d;
  end  
end 

assign dataout = scrambler_shifted; 
assign pushout = pushin_1d;

endmodule 

