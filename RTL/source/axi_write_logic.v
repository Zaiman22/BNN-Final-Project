`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/16/2025 10:15:37 AM
// Design Name: 
// Module Name: axi_write_logic
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


module axi_write_logic#(
		parameter number_of_register = 16
	)
	(
	input axi_clk,
	input rstn, //axi is reset low


	//write address channel
	input [$clog2(number_of_register)+2:0] write_addr,
	input write_addr_valid,
	output reg write_addr_ready,


	//write data channel
	input [31:0] write_data ,
	input write_data_valid,
	output reg write_data_ready,

	//write response channel	
	output [1:0] write_resp,
	input write_resp_ready,
	output reg write_resp_valid,


	
	output [31:0] data_out, //data output to external logic
	output [$clog2(number_of_register)+2:0] addr_out, //address output to external logic
	output data_valid		//signal indicating output data and address are valid
);


	reg addr_done;
	reg data_done;


	//flip flops for latching data
	reg [31:0] data_latch;
	reg [$clog2(number_of_register)+2:0] addr_latch;


	assign data_out = data_latch;
	assign addr_out = addr_latch;

	assign data_valid = data_done & addr_done;

	assign write_resp = 2'd0; //always indicate OKAY status for writes

	//write address handshake
	always @(posedge axi_clk)
	begin
		if(~rstn | (write_addr_valid & write_addr_ready) )
			write_addr_ready<=0;
		else if(~write_addr_ready & write_addr_valid)
			write_addr_ready<=1;
	end

	//write data handshake
	always @(posedge axi_clk)
	begin
		if(~rstn | (write_data_valid & write_data_ready) )
			write_data_ready<=0;
		else if(~write_data_ready & write_data_valid)
			write_data_ready<=1;
	end


	//keep track of which handshakes completed
	always @(posedge axi_clk)
	begin
		if(rstn==0 || (addr_done & data_done) ) //reset or both phases done
		begin
			addr_done<=0;
			data_done<=0;
		end
		else
		begin	

			if(write_addr_valid & write_addr_ready) //look for addr handshake
				addr_done<=1;
		
			if(write_data_valid & write_data_ready) //look for data handshake
				data_done<=1;	
		end
	end

	//latching logic
	always @(posedge axi_clk)
	begin
		if(rstn==0)
		begin
			data_latch<=32'd0;
			addr_latch<=6'd0;
		end
		else
		begin
			if(write_data_valid & write_data_ready) //look for data handshake
				data_latch<=write_data;
			
			if(write_addr_valid & write_addr_ready)
				addr_latch<=write_addr;
		end
	end


	//write response logic
	always @(posedge axi_clk)
	begin	
		if( rstn==0 | (write_resp_valid & write_resp_ready) )
			write_resp_valid<=0;
		else if(~write_resp_valid & (data_done & addr_done) )
			write_resp_valid<=1;	
	end



endmodule
