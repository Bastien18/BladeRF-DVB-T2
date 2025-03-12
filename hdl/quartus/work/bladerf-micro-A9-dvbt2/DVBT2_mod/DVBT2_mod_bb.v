
module DVBT2_mod (
	baseband_i,
	baseband_q,
	baseband_valid,
	ram_cs,
	ram_burst_access,
	ram_burst_size,
	ram_address,
	ram_wr_en,
	ram_wrdata,
	ram_rd_en,
	ram_rddata,
	ram_rddata_valid,
	ram_busy,
	ram_available,
	ram_empty,
	ts_data_valid,
	ts_data,
	ts_data_refclk,
	ts_data_busy,
	ts_data_clk,
	reg_address,
	reg_wr_data,
	reg_wr_en,
	reg_chip_en,
	reg_rd_data,
	reg_cmd_ack,
	clock,
	clock_x2,
	reg_irq,
	reset_n);	

	output	[13:0]	baseband_i;
	output	[13:0]	baseband_q;
	output		baseband_valid;
	output		ram_cs;
	output		ram_burst_access;
	output	[3:0]	ram_burst_size;
	output	[23:0]	ram_address;
	output		ram_wr_en;
	output	[31:0]	ram_wrdata;
	output		ram_rd_en;
	input	[31:0]	ram_rddata;
	input		ram_rddata_valid;
	input		ram_busy;
	input		ram_available;
	input		ram_empty;
	input		ts_data_valid;
	input	[7:0]	ts_data;
	output		ts_data_refclk;
	output		ts_data_busy;
	input		ts_data_clk;
	input	[19:0]	reg_address;
	input	[31:0]	reg_wr_data;
	input		reg_wr_en;
	input		reg_chip_en;
	output	[31:0]	reg_rd_data;
	output		reg_cmd_ack;
	input		clock;
	input		clock_x2;
	output		reg_irq;
	input		reset_n;
endmodule
