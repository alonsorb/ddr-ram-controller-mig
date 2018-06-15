//ddr_ram_controller_mig instantiation template

// The following must be inserted into your Verilog file for this core to be instantiated. Change the instance name and port connections (in parentheses) to your own signal names.

ddr_ram_control_mig #(
    .BOARD("NEXYS_VIDEO")) your_inst_name(
    // user interface signals
    .ui_clk             (ui_clk),
    .ui_clk_sync_rst    (ui_clk_sync_rst),
    .wr_addr            (wr_addr),
    .wr_data            (wr_data),
    .rd_addr            (rd_addr),
    .rd_data            (rd_data),
    .wr_en              (wr_en),
    .rd_en              (rd_en),
    .wr_busy            (wr_busy),
    .rd_busy            (rd_busy),
    .rd_data_valid      (rd_data_valid),
    // phy signals
    .clk                (clk),
    .clk_ref            (clk_ref),
    .rst                (cpu_resetn),
    .ddr3_addr          (ddr3_addr), 
    .ddr3_ba            (ddr3_ba),
    .ddr3_cas_n         (ddr3_cas_n),
    .ddr3_ck_n          (ddr3_ck_n), 
    .ddr3_ck_p          (ddr3_ck_p), 
    .ddr3_cke           (ddr3_cke),  
    .ddr3_ras_n         (ddr3_ras_n),
    .ddr3_reset_n       (ddr3_reset_n),
    .ddr3_we_n          (ddr3_we_n), 
    .ddr3_dq            (ddr3_dq),
    .ddr3_dqs_n         (ddr3_dqs_n),
    .ddr3_dqs_p         (ddr3_dqs_p),
    .ddr3_dm            (ddr3_dm),
    .ddr3_odt           (ddr3_odt)
);
