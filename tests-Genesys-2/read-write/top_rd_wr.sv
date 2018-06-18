`timescale 1ns / 1ps

module top_rd_wr(
    input sysclk_n,
    input sysclk_p,
    input cpu_resetn,
    output FAN_PWM,
    //memmory signals
    output  [14:0] ddr3_addr,
    output  [2:0] ddr3_ba,
    output  ddr3_cas_n,
    output  ddr3_ck_n,
    output  ddr3_ck_p,
    output  ddr3_cke,
    output  ddr3_ras_n,
    output  ddr3_reset_n,
    output  ddr3_we_n,
    inout   [31:0] ddr3_dq,
    inout   [3:0] ddr3_dqs_n,
    inout   [3:0] ddr3_dqs_p,
    output  ddr3_cs_n,
    output  [3:0] ddr3_dm,
    output  ddr3_odt
    );
    assign FAN_PWM = 1'b1;
    
    wire            ui_clk;
    wire [255:0]    rd_data;
    reg  [255:0]    wr_data, wr_data_next;
    wire            rd_busy;
    wire            wr_busy;
    wire            rd_data_valid;
    reg [24:0]      rd_addr,rd_addr_next;
    reg [24:0]      wr_addr,wr_addr_next;
    reg             rd_en;
    reg             wr_en;
    
    reg [24:0]      rd_count_valid, rd_count_valid_next;
    
    
    ddr_ram_control_mig #(
        .BOARD("GENESYS_2")) _ddr_ram_control_mig(
        // user interface signals
        .ui_clk         (ui_clk),
        //.ui_clk_sync_rst,
        .wr_addr        (wr_addr),
        .wr_data        (wr_data),
        .rd_addr        (rd_addr),
        .rd_data        (rd_data),
        .wr_en          (wr_en),
        .rd_en          (rd_en),
        .wr_busy        (wr_busy),
        .rd_busy        (rd_busy),
        .rd_data_valid  (rd_data_valid),
        // phy signals
        .clk_p          (sysclk_p),
        .clk_n          (sysclk_n),
        .rst            (cpu_resetn),
        .ddr3_addr      (ddr3_addr),  // output [14:0]        ddr3_addr
        .ddr3_ba        (ddr3_ba),  // output [2:0]        ddr3_ba
        .ddr3_cas_n     (ddr3_cas_n),  // output            ddr3_cas_n
        .ddr3_ck_n      (ddr3_ck_n),  // output [0:0]        ddr3_ck_n
        .ddr3_ck_p      (ddr3_ck_p),  // output [0:0]        ddr3_ck_p
        .ddr3_cke       (ddr3_cke),  // output [0:0]        ddr3_cke
        .ddr3_ras_n     (ddr3_ras_n),  // output            ddr3_ras_n
        .ddr3_reset_n   (ddr3_reset_n),  // output            ddr3_reset_n
        .ddr3_we_n      (ddr3_we_n),  // output            ddr3_we_n
        .ddr3_dq        (ddr3_dq),  // inout [31:0]        ddr3_dq
        .ddr3_dqs_n     (ddr3_dqs_n),  // inout [3:0]        ddr3_dqs_n
        .ddr3_dqs_p     (ddr3_dqs_p),  // inout [3:0]        ddr3_dqs_p
        .ddr3_cs_n      (ddr3_cs_n),  // output [0:0]        ddr3_cs_n
        .ddr3_dm        (ddr3_dm),  // output [3:0]        ddr3_dm
        .ddr3_odt       (ddr3_odt)  // output [0:0]        ddr3_odt
    );
        
    always_comb begin
        wr_en           = (wr_busy) ? 'b0 : 'b1;
        wr_addr_next    = (wr_en) ? wr_addr + 'd1 : wr_addr;
        //wr_data_next    = (wr_en) ? ((wr_data == 'd1048575) ? 'd0 : wr_data + 'd1 ): wr_data;
        wr_data         = {231'b0,wr_addr};
        rd_en           = (rd_busy) ? 'b0 : 'b1;
        rd_addr_next    = (rd_en) ? rd_addr + 'd1 : rd_addr;
        rd_count_valid_next  = (rd_data_valid) ? rd_count_valid + 'd1 : rd_count_valid;
        
    end
    
    always_ff @(posedge ui_clk) begin
        rd_addr <= rd_addr_next;
        wr_addr <= wr_addr_next;
        rd_count_valid <= rd_count_valid_next;
        //wr_data <= wr_data_next;
    end
    
    /*
    ila_1 _ila_1 (
        .clk(ui_clk), // input wire clk
        
        .probe0(rd_en), // input wire [0:0]  probe0   
        .probe1(rd_busy), // input wire [0:0]  probe2 
        .probe2(rd_data), // input wire [0:0]  probe3 
        .probe3(rd_addr), // input wire [24:0]  probe4 
        .probe4(rd_data_valid) // input wire [24:0]  probe5 
    );
    */
    ila_0 _ila_0 (
        .clk(ui_clk), // input wire clk
    
        .probe0(rd_en), // input wire [0:0]  probe0  
        .probe1(wr_en), // input wire [0:0]  probe1 
        .probe2(rd_busy), // input wire [0:0]  probe2 
        .probe3(wr_busy), // input wire [0:0]  probe3 
        .probe4(rd_addr), // input wire [24:0]  probe4 
        .probe5(wr_addr), // input wire [24:0]  probe5 
        .probe6(rd_data), // input wire [255:0]  probe6 
        .probe7(wr_data), // input wire [255:0]  probe7 
        .probe8(rd_data_valid), // input wire [0:0]  probe8
        .probe9(rd_count_valid) 
    );
endmodule