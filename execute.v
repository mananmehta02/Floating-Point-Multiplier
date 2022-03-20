`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2021 22:15:21
// Design Name: 
// Module Name: execute
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FPMult_ExecuteModule(clk,
		a,
		b,
		Sa,
		Sb,
		Ea,
		Eb,
		MpC,
		Sp,
		NormE,
		NormM,
		GRS
    );

	// Input ports
	input clk;
	input [22:0] a ;
	input [16:0] b ;
	input [47:0] MpC ;
	input [7:0] Ea ;						// A's exponent
	input [7:0] Eb ;						// B's exponent
	input Sa ;								// A's sign
	input Sb ;								// B's sign
	
	// Output ports
	output Sp ;								// Product sign
	output [8:0] NormE ;													// Normalized exponent
	output [22:0] NormM ;												// Normalized mantissa
	output GRS ;
	
	wire [47:0] Mp ;
	
	assign Sp = (Sa ^ Sb) ;												// Equal signs give a positive product
	xbip_dsp48_macro_0 your_instance_name (
  .CLK(clk),  // input wire CLK
  .A({2'b01,a[22:0]}),      // input wire [24 : 0] A
  .B({1'b0,b[16:0]}),      // input wire [17 : 0] B
  .C(MpC<<17),      // input wire [47 : 0] C
  .P(Mp)      // output wire [47 : 0] P
);

	//assign Mp = (MpC<<17) + ({7'b0000001, a[22:0]}*{1'b0, b[16:0]}) ;
	
	assign NormM = (Mp[47] ? Mp[46:24] : Mp[45:23]); // Check for overflow
	assign NormE = (Ea + Eb + Mp[47]);								// If so, increment exponent
	
	assign GRS = ((Mp[23]&(Mp[24]))|(|Mp[22:0])) ;
	
endmodule