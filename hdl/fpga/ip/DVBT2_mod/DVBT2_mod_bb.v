
module DVBT2_mod (
	clock,
	reset_n,
	reg_address,
	reg_wr_data,
	reg_wr_en,
	reg_chip_en,
	reg_rd_data,
	reg_cmd_ack,
	reg_irq,
	ts_data_clk,
	ts_data_valid,
	ts_data,
	ts_data_refclk,
	ts_data_busy,
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
	fft_wr_addr,
	fft_wr_data,
	fft_wr_ena,
	fft_rd_addr,
	fft_rd_data,
	osg_wr_addr,
	osg_wr_data,
	osg_wr_ena,
	osg_rd_addr,
	osg_rd_data,
	baseband_i,
	baseband_q,
	baseband_valid);	

	input		clock;
	input		reset_n;
	input	[19:0]	reg_address;
	input	[31:0]	reg_wr_data;
	input		reg_wr_en;
	input		reg_chip_en;
	output	[31:0]	reg_rd_data;
	output		reg_cmd_ack;
	output		reg_irq;
	input		ts_data_clk;
	input		ts_data_valid;
	input	[7:0]	ts_data;
	output		ts_data_refclk;
	output		ts_data_busy;
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
	output	[18:0]	fft_wr_addr;
	output	[35:0]	fft_wr_data;
	output		fft_wr_ena;
	output	[18:0]	fft_rd_addr;
	input	[35:0]	fft_rd_data;
	output	[18:0]	osg_wr_addr;
	output	[35:0]	osg_wr_data;
	output		osg_wr_ena;
	output	[18:0]	osg_rd_addr;
	input	[35:0]	osg_rd_data;
	output	[13:0]	baseband_i;
	output	[13:0]	baseband_q;
	output		baseband_valid;
endmodule
