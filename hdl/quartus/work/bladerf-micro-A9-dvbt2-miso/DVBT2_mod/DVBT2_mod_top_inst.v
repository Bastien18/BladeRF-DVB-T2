	DVBT2_mod_top u0 (
		.baseband_i       (<connected-to-baseband_i>),       //         Baseband.i
		.baseband_q       (<connected-to-baseband_q>),       //                 .q
		.baseband_valid   (<connected-to-baseband_valid>),   //                 .valid
		.ram_cs           (<connected-to-ram_cs>),           //              RAM.cs
		.ram_burst_access (<connected-to-ram_burst_access>), //                 .burst_access
		.ram_burst_size   (<connected-to-ram_burst_size>),   //                 .burst_size
		.ram_address      (<connected-to-ram_address>),      //                 .address
		.ram_wr_en        (<connected-to-ram_wr_en>),        //                 .wr_en
		.ram_wrdata       (<connected-to-ram_wrdata>),       //                 .wrdata
		.ram_rd_en        (<connected-to-ram_rd_en>),        //                 .rd_en
		.ram_rddata       (<connected-to-ram_rddata>),       //                 .rddata
		.ram_rddata_valid (<connected-to-ram_rddata_valid>), //                 .rddata_valid
		.ram_busy         (<connected-to-ram_busy>),         //                 .busy
		.ram_available    (<connected-to-ram_available>),    //                 .available
		.ram_empty        (<connected-to-ram_empty>),        //                 .empty
		.ts_data_valid    (<connected-to-ts_data_valid>),    //               TS.data_valid
		.ts_data          (<connected-to-ts_data>),          //                 .data
		.ts_data_refclk   (<connected-to-ts_data_refclk>),   //                 .data_refclk
		.ts_data_busy     (<connected-to-ts_data_busy>),     //                 .data_busy
		.ts_data_clk      (<connected-to-ts_data_clk>),      //           TS_Clk.clk
		.reg_address      (<connected-to-reg_address>),      //     avalon_slave.address
		.reg_wr_data      (<connected-to-reg_wr_data>),      //                 .writedata
		.reg_wr_en        (<connected-to-reg_wr_en>),        //                 .write
		.reg_chip_en      (<connected-to-reg_chip_en>),      //                 .chipselect
		.reg_rd_data      (<connected-to-reg_rd_data>),      //                 .readdata
		.reg_cmd_ack      (<connected-to-reg_cmd_ack>),      //                 .waitrequest_n
		.clock            (<connected-to-clock>),            //    cms0041_clock.clk
		.clock_x2         (<connected-to-clock_x2>),         // cms0041_clock_x2.clk
		.reg_irq          (<connected-to-reg_irq>),          //              irq.irq
		.reset_n          (<connected-to-reset_n>)           //          reset_n.reset_n
	);

