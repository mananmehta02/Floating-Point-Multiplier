`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2021 23:06:19
// Design Name: 
// Module Name: normalization
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


module FPMult_NormalizeModule(
		NormM,
		NormE,
		RoundE,
		RoundEP,
		RoundM,
		RoundMP
    );

	// Input Ports
	input [22:0] NormM ;									// Normalized mantissa
	input [8:0] NormE ;									// Normalized exponent

	// Output Ports
	output [8:0] RoundE ;
	output [8:0] RoundEP ;
	output [23:0] RoundM ;
	output [23:0] RoundMP ; 
	
	assign RoundE = NormE - 127 ;
	assign RoundEP = NormE - 126 ;
	assign RoundM = NormM ;
	assign RoundMP = NormM + 1 ;

endmodule