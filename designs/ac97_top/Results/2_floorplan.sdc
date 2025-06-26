###############################################################################
# Created by write_sdc
###############################################################################
current_design ac97_top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 120.0000 [get_ports {clk_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {bit_clk_pad_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {bit_clk_pad_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[0]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[0]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[1]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[1]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[2]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[2]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[3]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[3]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[4]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[4]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[5]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[5]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[6]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[6]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[7]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[7]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_ack_i[8]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_ack_i[8]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {rst_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {rst_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {sdata_pad_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {sdata_pad_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[0]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[0]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[10]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[10]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[11]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[11]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[12]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[12]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[13]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[13]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[14]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[14]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[15]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[15]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[16]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[16]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[17]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[17]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[18]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[18]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[19]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[19]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[1]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[1]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[20]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[20]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[21]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[21]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[22]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[22]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[23]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[23]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[24]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[24]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[25]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[25]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[26]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[26]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[27]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[27]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[28]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[28]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[29]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[29]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[2]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[2]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[30]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[30]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[31]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[31]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[3]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[3]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[4]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[4]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[5]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[5]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[6]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[6]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[7]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[7]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[8]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[8]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_addr_i[9]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_addr_i[9]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_cyc_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_cyc_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[0]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[0]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[10]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[10]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[11]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[11]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[12]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[12]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[13]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[13]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[14]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[14]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[15]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[15]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[16]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[16]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[17]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[17]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[18]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[18]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[19]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[19]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[1]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[1]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[20]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[20]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[21]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[21]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[22]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[22]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[23]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[23]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[24]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[24]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[25]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[25]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[26]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[26]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[27]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[27]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[28]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[28]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[29]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[29]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[2]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[2]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[30]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[30]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[31]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[31]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[3]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[3]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[4]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[4]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[5]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[5]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[6]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[6]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[7]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[7]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[8]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[8]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_i[9]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_i[9]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_sel_i[0]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_sel_i[0]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_sel_i[1]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_sel_i[1]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_sel_i[2]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_sel_i[2]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_sel_i[3]}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_sel_i[3]}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_stb_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_stb_i}]
set_input_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_we_i}]
set_input_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_we_i}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {ac97_reset_pad_o_}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {ac97_reset_pad_o_}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[0]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[0]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[1]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[1]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[2]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[2]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[3]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[3]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[4]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[4]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[5]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[5]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[6]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[6]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[7]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[7]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dma_req_o[8]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dma_req_o[8]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {int_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {int_o}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {sdata_pad_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {sdata_pad_o}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {suspended_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {suspended_o}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {sync_pad_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {sync_pad_o}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_ack_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_ack_o}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[0]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[0]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[10]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[10]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[11]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[11]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[12]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[12]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[13]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[13]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[14]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[14]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[15]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[15]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[16]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[16]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[17]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[17]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[18]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[18]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[19]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[19]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[1]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[1]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[20]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[20]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[21]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[21]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[22]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[22]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[23]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[23]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[24]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[24]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[25]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[25]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[26]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[26]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[27]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[27]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[28]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[28]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[29]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[29]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[2]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[2]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[30]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[30]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[31]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[31]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[3]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[3]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[4]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[4]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[5]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[5]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[6]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[6]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[7]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[7]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[8]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[8]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_data_o[9]}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_data_o[9]}]
set_output_delay 4.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wb_err_o}]
set_output_delay 8.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wb_err_o}]
set_false_path\
    -from [get_ports {rst_i}]
set_false_path\
    -to [list [get_pins {u13_crac_r_reg[0]/RESETN}]\
           [get_pins {u13_crac_r_reg[0]/SETN}]\
           [get_pins {u13_crac_r_reg[1]/RESETN}]\
           [get_pins {u13_crac_r_reg[1]/SETN}]\
           [get_pins {u13_crac_r_reg[2]/RESETN}]\
           [get_pins {u13_crac_r_reg[2]/SETN}]\
           [get_pins {u13_crac_r_reg[3]/RESETN}]\
           [get_pins {u13_crac_r_reg[3]/SETN}]\
           [get_pins {u13_crac_r_reg[4]/RESETN}]\
           [get_pins {u13_crac_r_reg[4]/SETN}]\
           [get_pins {u13_crac_r_reg[5]/RESETN}]\
           [get_pins {u13_crac_r_reg[5]/SETN}]\
           [get_pins {u13_crac_r_reg[6]/RESETN}]\
           [get_pins {u13_crac_r_reg[6]/SETN}]\
           [get_pins {u13_crac_r_reg[7]/RESETN}]\
           [get_pins {u13_crac_r_reg[7]/SETN}]\
           [get_pins {u13_icc_r_reg[0]/RESETN}]\
           [get_pins {u13_icc_r_reg[0]/SETN}]\
           [get_pins {u13_icc_r_reg[10]/RESETN}]\
           [get_pins {u13_icc_r_reg[10]/SETN}]\
           [get_pins {u13_icc_r_reg[11]/RESETN}]\
           [get_pins {u13_icc_r_reg[11]/SETN}]\
           [get_pins {u13_icc_r_reg[12]/RESETN}]\
           [get_pins {u13_icc_r_reg[12]/SETN}]\
           [get_pins {u13_icc_r_reg[13]/RESETN}]\
           [get_pins {u13_icc_r_reg[13]/SETN}]\
           [get_pins {u13_icc_r_reg[14]/RESETN}]\
           [get_pins {u13_icc_r_reg[14]/SETN}]\
           [get_pins {u13_icc_r_reg[15]/RESETN}]\
           [get_pins {u13_icc_r_reg[15]/SETN}]\
           [get_pins {u13_icc_r_reg[16]/RESETN}]\
           [get_pins {u13_icc_r_reg[16]/SETN}]\
           [get_pins {u13_icc_r_reg[17]/RESETN}]\
           [get_pins {u13_icc_r_reg[17]/SETN}]\
           [get_pins {u13_icc_r_reg[18]/RESETN}]\
           [get_pins {u13_icc_r_reg[18]/SETN}]\
           [get_pins {u13_icc_r_reg[19]/RESETN}]\
           [get_pins {u13_icc_r_reg[19]/SETN}]\
           [get_pins {u13_icc_r_reg[1]/RESETN}]\
           [get_pins {u13_icc_r_reg[1]/SETN}]\
           [get_pins {u13_icc_r_reg[20]/RESETN}]\
           [get_pins {u13_icc_r_reg[20]/SETN}]\
           [get_pins {u13_icc_r_reg[21]/RESETN}]\
           [get_pins {u13_icc_r_reg[21]/SETN}]\
           [get_pins {u13_icc_r_reg[22]/RESETN}]\
           [get_pins {u13_icc_r_reg[22]/SETN}]\
           [get_pins {u13_icc_r_reg[23]/RESETN}]\
           [get_pins {u13_icc_r_reg[23]/SETN}]\
           [get_pins {u13_icc_r_reg[2]/RESETN}]\
           [get_pins {u13_icc_r_reg[2]/SETN}]\
           [get_pins {u13_icc_r_reg[3]/RESETN}]\
           [get_pins {u13_icc_r_reg[3]/SETN}]\
           [get_pins {u13_icc_r_reg[4]/RESETN}]\
           [get_pins {u13_icc_r_reg[4]/SETN}]\
           [get_pins {u13_icc_r_reg[5]/RESETN}]\
           [get_pins {u13_icc_r_reg[5]/SETN}]\
           [get_pins {u13_icc_r_reg[6]/RESETN}]\
           [get_pins {u13_icc_r_reg[6]/SETN}]\
           [get_pins {u13_icc_r_reg[7]/RESETN}]\
           [get_pins {u13_icc_r_reg[7]/SETN}]\
           [get_pins {u13_icc_r_reg[8]/RESETN}]\
           [get_pins {u13_icc_r_reg[8]/SETN}]\
           [get_pins {u13_icc_r_reg[9]/RESETN}]\
           [get_pins {u13_icc_r_reg[9]/SETN}]\
           [get_pins {u13_intm_r_reg[0]/RESETN}]\
           [get_pins {u13_intm_r_reg[0]/SETN}]\
           [get_pins {u13_intm_r_reg[10]/RESETN}]\
           [get_pins {u13_intm_r_reg[10]/SETN}]\
           [get_pins {u13_intm_r_reg[11]/RESETN}]\
           [get_pins {u13_intm_r_reg[11]/SETN}]\
           [get_pins {u13_intm_r_reg[12]/RESETN}]\
           [get_pins {u13_intm_r_reg[12]/SETN}]\
           [get_pins {u13_intm_r_reg[13]/RESETN}]\
           [get_pins {u13_intm_r_reg[13]/SETN}]\
           [get_pins {u13_intm_r_reg[14]/RESETN}]\
           [get_pins {u13_intm_r_reg[14]/SETN}]\
           [get_pins {u13_intm_r_reg[15]/RESETN}]\
           [get_pins {u13_intm_r_reg[15]/SETN}]\
           [get_pins {u13_intm_r_reg[16]/RESETN}]\
           [get_pins {u13_intm_r_reg[16]/SETN}]\
           [get_pins {u13_intm_r_reg[17]/RESETN}]\
           [get_pins {u13_intm_r_reg[17]/SETN}]\
           [get_pins {u13_intm_r_reg[18]/RESETN}]\
           [get_pins {u13_intm_r_reg[18]/SETN}]\
           [get_pins {u13_intm_r_reg[19]/RESETN}]\
           [get_pins {u13_intm_r_reg[19]/SETN}]\
           [get_pins {u13_intm_r_reg[1]/RESETN}]\
           [get_pins {u13_intm_r_reg[1]/SETN}]\
           [get_pins {u13_intm_r_reg[20]/RESETN}]\
           [get_pins {u13_intm_r_reg[20]/SETN}]\
           [get_pins {u13_intm_r_reg[21]/RESETN}]\
           [get_pins {u13_intm_r_reg[21]/SETN}]\
           [get_pins {u13_intm_r_reg[22]/RESETN}]\
           [get_pins {u13_intm_r_reg[22]/SETN}]\
           [get_pins {u13_intm_r_reg[23]/RESETN}]\
           [get_pins {u13_intm_r_reg[23]/SETN}]\
           [get_pins {u13_intm_r_reg[24]/RESETN}]\
           [get_pins {u13_intm_r_reg[24]/SETN}]\
           [get_pins {u13_intm_r_reg[25]/RESETN}]\
           [get_pins {u13_intm_r_reg[25]/SETN}]\
           [get_pins {u13_intm_r_reg[26]/RESETN}]\
           [get_pins {u13_intm_r_reg[26]/SETN}]\
           [get_pins {u13_intm_r_reg[27]/RESETN}]\
           [get_pins {u13_intm_r_reg[27]/SETN}]\
           [get_pins {u13_intm_r_reg[28]/RESETN}]\
           [get_pins {u13_intm_r_reg[28]/SETN}]\
           [get_pins {u13_intm_r_reg[2]/RESETN}]\
           [get_pins {u13_intm_r_reg[2]/SETN}]\
           [get_pins {u13_intm_r_reg[3]/RESETN}]\
           [get_pins {u13_intm_r_reg[3]/SETN}]\
           [get_pins {u13_intm_r_reg[4]/RESETN}]\
           [get_pins {u13_intm_r_reg[4]/SETN}]\
           [get_pins {u13_intm_r_reg[5]/RESETN}]\
           [get_pins {u13_intm_r_reg[5]/SETN}]\
           [get_pins {u13_intm_r_reg[6]/RESETN}]\
           [get_pins {u13_intm_r_reg[6]/SETN}]\
           [get_pins {u13_intm_r_reg[7]/RESETN}]\
           [get_pins {u13_intm_r_reg[7]/SETN}]\
           [get_pins {u13_intm_r_reg[8]/RESETN}]\
           [get_pins {u13_intm_r_reg[8]/SETN}]\
           [get_pins {u13_intm_r_reg[9]/RESETN}]\
           [get_pins {u13_intm_r_reg[9]/SETN}]\
           [get_pins {u13_ints_r_reg[0]/RESETN}]\
           [get_pins {u13_ints_r_reg[0]/SETN}]\
           [get_pins {u13_ints_r_reg[10]/RESETN}]\
           [get_pins {u13_ints_r_reg[10]/SETN}]\
           [get_pins {u13_ints_r_reg[11]/RESETN}]\
           [get_pins {u13_ints_r_reg[11]/SETN}]\
           [get_pins {u13_ints_r_reg[12]/RESETN}]\
           [get_pins {u13_ints_r_reg[12]/SETN}]\
           [get_pins {u13_ints_r_reg[13]/RESETN}]\
           [get_pins {u13_ints_r_reg[13]/SETN}]\
           [get_pins {u13_ints_r_reg[14]/RESETN}]\
           [get_pins {u13_ints_r_reg[14]/SETN}]\
           [get_pins {u13_ints_r_reg[15]/RESETN}]\
           [get_pins {u13_ints_r_reg[15]/SETN}]\
           [get_pins {u13_ints_r_reg[16]/RESETN}]\
           [get_pins {u13_ints_r_reg[16]/SETN}]\
           [get_pins {u13_ints_r_reg[17]/RESETN}]\
           [get_pins {u13_ints_r_reg[17]/SETN}]\
           [get_pins {u13_ints_r_reg[18]/RESETN}]\
           [get_pins {u13_ints_r_reg[18]/SETN}]\
           [get_pins {u13_ints_r_reg[19]/RESETN}]\
           [get_pins {u13_ints_r_reg[19]/SETN}]\
           [get_pins {u13_ints_r_reg[1]/RESETN}]\
           [get_pins {u13_ints_r_reg[1]/SETN}]\
           [get_pins {u13_ints_r_reg[20]/RESETN}]\
           [get_pins {u13_ints_r_reg[20]/SETN}]\
           [get_pins {u13_ints_r_reg[21]/RESETN}]\
           [get_pins {u13_ints_r_reg[21]/SETN}]\
           [get_pins {u13_ints_r_reg[22]/RESETN}]\
           [get_pins {u13_ints_r_reg[22]/SETN}]\
           [get_pins {u13_ints_r_reg[23]/RESETN}]\
           [get_pins {u13_ints_r_reg[23]/SETN}]\
           [get_pins {u13_ints_r_reg[24]/RESETN}]\
           [get_pins {u13_ints_r_reg[24]/SETN}]\
           [get_pins {u13_ints_r_reg[25]/RESETN}]\
           [get_pins {u13_ints_r_reg[25]/SETN}]\
           [get_pins {u13_ints_r_reg[26]/RESETN}]\
           [get_pins {u13_ints_r_reg[26]/SETN}]\
           [get_pins {u13_ints_r_reg[27]/RESETN}]\
           [get_pins {u13_ints_r_reg[27]/SETN}]\
           [get_pins {u13_ints_r_reg[28]/RESETN}]\
           [get_pins {u13_ints_r_reg[28]/SETN}]\
           [get_pins {u13_ints_r_reg[2]/RESETN}]\
           [get_pins {u13_ints_r_reg[2]/SETN}]\
           [get_pins {u13_ints_r_reg[3]/RESETN}]\
           [get_pins {u13_ints_r_reg[3]/SETN}]\
           [get_pins {u13_ints_r_reg[4]/RESETN}]\
           [get_pins {u13_ints_r_reg[4]/SETN}]\
           [get_pins {u13_ints_r_reg[5]/RESETN}]\
           [get_pins {u13_ints_r_reg[5]/SETN}]\
           [get_pins {u13_ints_r_reg[6]/RESETN}]\
           [get_pins {u13_ints_r_reg[6]/SETN}]\
           [get_pins {u13_ints_r_reg[7]/RESETN}]\
           [get_pins {u13_ints_r_reg[7]/SETN}]\
           [get_pins {u13_ints_r_reg[8]/RESETN}]\
           [get_pins {u13_ints_r_reg[8]/SETN}]\
           [get_pins {u13_ints_r_reg[9]/RESETN}]\
           [get_pins {u13_ints_r_reg[9]/SETN}]\
           [get_pins {u13_occ0_r_reg[0]/RESETN}]\
           [get_pins {u13_occ0_r_reg[0]/SETN}]\
           [get_pins {u13_occ0_r_reg[10]/RESETN}]\
           [get_pins {u13_occ0_r_reg[10]/SETN}]\
           [get_pins {u13_occ0_r_reg[11]/RESETN}]\
           [get_pins {u13_occ0_r_reg[11]/SETN}]\
           [get_pins {u13_occ0_r_reg[12]/RESETN}]\
           [get_pins {u13_occ0_r_reg[12]/SETN}]\
           [get_pins {u13_occ0_r_reg[13]/RESETN}]\
           [get_pins {u13_occ0_r_reg[13]/SETN}]\
           [get_pins {u13_occ0_r_reg[14]/RESETN}]\
           [get_pins {u13_occ0_r_reg[14]/SETN}]\
           [get_pins {u13_occ0_r_reg[15]/RESETN}]\
           [get_pins {u13_occ0_r_reg[15]/SETN}]\
           [get_pins {u13_occ0_r_reg[16]/RESETN}]\
           [get_pins {u13_occ0_r_reg[16]/SETN}]\
           [get_pins {u13_occ0_r_reg[17]/RESETN}]\
           [get_pins {u13_occ0_r_reg[17]/SETN}]\
           [get_pins {u13_occ0_r_reg[18]/RESETN}]\
           [get_pins {u13_occ0_r_reg[18]/SETN}]\
           [get_pins {u13_occ0_r_reg[19]/RESETN}]\
           [get_pins {u13_occ0_r_reg[19]/SETN}]\
           [get_pins {u13_occ0_r_reg[1]/RESETN}]\
           [get_pins {u13_occ0_r_reg[1]/SETN}]\
           [get_pins {u13_occ0_r_reg[20]/RESETN}]\
           [get_pins {u13_occ0_r_reg[20]/SETN}]\
           [get_pins {u13_occ0_r_reg[21]/RESETN}]\
           [get_pins {u13_occ0_r_reg[21]/SETN}]\
           [get_pins {u13_occ0_r_reg[22]/RESETN}]\
           [get_pins {u13_occ0_r_reg[22]/SETN}]\
           [get_pins {u13_occ0_r_reg[23]/RESETN}]\
           [get_pins {u13_occ0_r_reg[23]/SETN}]\
           [get_pins {u13_occ0_r_reg[24]/RESETN}]\
           [get_pins {u13_occ0_r_reg[24]/SETN}]\
           [get_pins {u13_occ0_r_reg[25]/RESETN}]\
           [get_pins {u13_occ0_r_reg[25]/SETN}]\
           [get_pins {u13_occ0_r_reg[26]/RESETN}]\
           [get_pins {u13_occ0_r_reg[26]/SETN}]\
           [get_pins {u13_occ0_r_reg[27]/RESETN}]\
           [get_pins {u13_occ0_r_reg[27]/SETN}]\
           [get_pins {u13_occ0_r_reg[28]/RESETN}]\
           [get_pins {u13_occ0_r_reg[28]/SETN}]\
           [get_pins {u13_occ0_r_reg[29]/RESETN}]\
           [get_pins {u13_occ0_r_reg[29]/SETN}]\
           [get_pins {u13_occ0_r_reg[2]/RESETN}]\
           [get_pins {u13_occ0_r_reg[2]/SETN}]\
           [get_pins {u13_occ0_r_reg[30]/RESETN}]\
           [get_pins {u13_occ0_r_reg[30]/SETN}]\
           [get_pins {u13_occ0_r_reg[31]/RESETN}]\
           [get_pins {u13_occ0_r_reg[31]/SETN}]\
           [get_pins {u13_occ0_r_reg[3]/RESETN}]\
           [get_pins {u13_occ0_r_reg[3]/SETN}]\
           [get_pins {u13_occ0_r_reg[4]/RESETN}]\
           [get_pins {u13_occ0_r_reg[4]/SETN}]\
           [get_pins {u13_occ0_r_reg[5]/RESETN}]\
           [get_pins {u13_occ0_r_reg[5]/SETN}]\
           [get_pins {u13_occ0_r_reg[6]/RESETN}]\
           [get_pins {u13_occ0_r_reg[6]/SETN}]\
           [get_pins {u13_occ0_r_reg[7]/RESETN}]\
           [get_pins {u13_occ0_r_reg[7]/SETN}]\
           [get_pins {u13_occ0_r_reg[8]/RESETN}]\
           [get_pins {u13_occ0_r_reg[8]/SETN}]\
           [get_pins {u13_occ0_r_reg[9]/RESETN}]\
           [get_pins {u13_occ0_r_reg[9]/SETN}]\
           [get_pins {u13_occ1_r_reg[0]/RESETN}]\
           [get_pins {u13_occ1_r_reg[0]/SETN}]\
           [get_pins {u13_occ1_r_reg[10]/RESETN}]\
           [get_pins {u13_occ1_r_reg[10]/SETN}]\
           [get_pins {u13_occ1_r_reg[11]/RESETN}]\
           [get_pins {u13_occ1_r_reg[11]/SETN}]\
           [get_pins {u13_occ1_r_reg[12]/RESETN}]\
           [get_pins {u13_occ1_r_reg[12]/SETN}]\
           [get_pins {u13_occ1_r_reg[13]/RESETN}]\
           [get_pins {u13_occ1_r_reg[13]/SETN}]\
           [get_pins {u13_occ1_r_reg[14]/RESETN}]\
           [get_pins {u13_occ1_r_reg[14]/SETN}]\
           [get_pins {u13_occ1_r_reg[15]/RESETN}]\
           [get_pins {u13_occ1_r_reg[15]/SETN}]\
           [get_pins {u13_occ1_r_reg[1]/RESETN}]\
           [get_pins {u13_occ1_r_reg[1]/SETN}]\
           [get_pins {u13_occ1_r_reg[2]/RESETN}]\
           [get_pins {u13_occ1_r_reg[2]/SETN}]\
           [get_pins {u13_occ1_r_reg[3]/RESETN}]\
           [get_pins {u13_occ1_r_reg[3]/SETN}]\
           [get_pins {u13_occ1_r_reg[4]/RESETN}]\
           [get_pins {u13_occ1_r_reg[4]/SETN}]\
           [get_pins {u13_occ1_r_reg[5]/RESETN}]\
           [get_pins {u13_occ1_r_reg[5]/SETN}]\
           [get_pins {u13_occ1_r_reg[6]/RESETN}]\
           [get_pins {u13_occ1_r_reg[6]/SETN}]\
           [get_pins {u13_occ1_r_reg[7]/RESETN}]\
           [get_pins {u13_occ1_r_reg[7]/SETN}]\
           [get_pins {u13_occ1_r_reg[8]/RESETN}]\
           [get_pins {u13_occ1_r_reg[8]/SETN}]\
           [get_pins {u13_occ1_r_reg[9]/RESETN}]\
           [get_pins {u13_occ1_r_reg[9]/SETN}]\
           [get_pins {u15_crac_din_reg[0]/RESETN}]\
           [get_pins {u15_crac_din_reg[0]/SETN}]\
           [get_pins {u15_crac_din_reg[10]/RESETN}]\
           [get_pins {u15_crac_din_reg[10]/SETN}]\
           [get_pins {u15_crac_din_reg[11]/RESETN}]\
           [get_pins {u15_crac_din_reg[11]/SETN}]\
           [get_pins {u15_crac_din_reg[12]/RESETN}]\
           [get_pins {u15_crac_din_reg[12]/SETN}]\
           [get_pins {u15_crac_din_reg[13]/RESETN}]\
           [get_pins {u15_crac_din_reg[13]/SETN}]\
           [get_pins {u15_crac_din_reg[14]/RESETN}]\
           [get_pins {u15_crac_din_reg[14]/SETN}]\
           [get_pins {u15_crac_din_reg[15]/RESETN}]\
           [get_pins {u15_crac_din_reg[15]/SETN}]\
           [get_pins {u15_crac_din_reg[1]/RESETN}]\
           [get_pins {u15_crac_din_reg[1]/SETN}]\
           [get_pins {u15_crac_din_reg[2]/RESETN}]\
           [get_pins {u15_crac_din_reg[2]/SETN}]\
           [get_pins {u15_crac_din_reg[3]/RESETN}]\
           [get_pins {u15_crac_din_reg[3]/SETN}]\
           [get_pins {u15_crac_din_reg[4]/RESETN}]\
           [get_pins {u15_crac_din_reg[4]/SETN}]\
           [get_pins {u15_crac_din_reg[5]/RESETN}]\
           [get_pins {u15_crac_din_reg[5]/SETN}]\
           [get_pins {u15_crac_din_reg[6]/RESETN}]\
           [get_pins {u15_crac_din_reg[6]/SETN}]\
           [get_pins {u15_crac_din_reg[7]/RESETN}]\
           [get_pins {u15_crac_din_reg[7]/SETN}]\
           [get_pins {u15_crac_din_reg[8]/RESETN}]\
           [get_pins {u15_crac_din_reg[8]/SETN}]\
           [get_pins {u15_crac_din_reg[9]/RESETN}]\
           [get_pins {u15_crac_din_reg[9]/SETN}]\
           [get_pins {u15_crac_rd_reg/RESETN}]\
           [get_pins {u15_crac_rd_reg/SETN}]\
           [get_pins {u15_crac_wr_reg/RESETN}]\
           [get_pins {u15_crac_wr_reg/SETN}]\
           [get_pins {u15_rdd1_reg/RESETN}]\
           [get_pins {u15_rdd1_reg/SETN}]\
           [get_pins {u15_rdd2_reg/RESETN}]\
           [get_pins {u15_rdd2_reg/SETN}]\
           [get_pins {u15_rdd3_reg/RESETN}]\
           [get_pins {u15_rdd3_reg/SETN}]\
           [get_pins {u16_u0_dma_req_reg/RESETN}]\
           [get_pins {u16_u0_dma_req_reg/SETN}]\
           [get_pins {u16_u1_dma_req_reg/RESETN}]\
           [get_pins {u16_u1_dma_req_reg/SETN}]\
           [get_pins {u16_u2_dma_req_reg/RESETN}]\
           [get_pins {u16_u2_dma_req_reg/SETN}]\
           [get_pins {u16_u3_dma_req_reg/RESETN}]\
           [get_pins {u16_u3_dma_req_reg/SETN}]\
           [get_pins {u16_u4_dma_req_reg/RESETN}]\
           [get_pins {u16_u4_dma_req_reg/SETN}]\
           [get_pins {u16_u5_dma_req_reg/RESETN}]\
           [get_pins {u16_u5_dma_req_reg/SETN}]\
           [get_pins {u16_u6_dma_req_reg/RESETN}]\
           [get_pins {u16_u6_dma_req_reg/SETN}]\
           [get_pins {u16_u7_dma_req_reg/RESETN}]\
           [get_pins {u16_u7_dma_req_reg/SETN}]\
           [get_pins {u16_u8_dma_req_reg/RESETN}]\
           [get_pins {u16_u8_dma_req_reg/SETN}]\
           [get_pins {u17_int_set_reg[0]/RESETN}]\
           [get_pins {u17_int_set_reg[0]/SETN}]\
           [get_pins {u17_int_set_reg[1]/RESETN}]\
           [get_pins {u17_int_set_reg[1]/SETN}]\
           [get_pins {u17_int_set_reg[2]/RESETN}]\
           [get_pins {u17_int_set_reg[2]/SETN}]\
           [get_pins {u18_int_set_reg[0]/RESETN}]\
           [get_pins {u18_int_set_reg[0]/SETN}]\
           [get_pins {u18_int_set_reg[1]/RESETN}]\
           [get_pins {u18_int_set_reg[1]/SETN}]\
           [get_pins {u18_int_set_reg[2]/RESETN}]\
           [get_pins {u18_int_set_reg[2]/SETN}]\
           [get_pins {u19_int_set_reg[0]/RESETN}]\
           [get_pins {u19_int_set_reg[0]/SETN}]\
           [get_pins {u19_int_set_reg[1]/RESETN}]\
           [get_pins {u19_int_set_reg[1]/SETN}]\
           [get_pins {u19_int_set_reg[2]/RESETN}]\
           [get_pins {u19_int_set_reg[2]/SETN}]\
           [get_pins {u20_int_set_reg[0]/RESETN}]\
           [get_pins {u20_int_set_reg[0]/SETN}]\
           [get_pins {u20_int_set_reg[1]/RESETN}]\
           [get_pins {u20_int_set_reg[1]/SETN}]\
           [get_pins {u20_int_set_reg[2]/RESETN}]\
           [get_pins {u20_int_set_reg[2]/SETN}]\
           [get_pins {u21_int_set_reg[0]/RESETN}]\
           [get_pins {u21_int_set_reg[0]/SETN}]\
           [get_pins {u21_int_set_reg[1]/RESETN}]\
           [get_pins {u21_int_set_reg[1]/SETN}]\
           [get_pins {u21_int_set_reg[2]/RESETN}]\
           [get_pins {u21_int_set_reg[2]/SETN}]\
           [get_pins {u22_int_set_reg[0]/RESETN}]\
           [get_pins {u22_int_set_reg[0]/SETN}]\
           [get_pins {u22_int_set_reg[1]/RESETN}]\
           [get_pins {u22_int_set_reg[1]/SETN}]\
           [get_pins {u22_int_set_reg[2]/RESETN}]\
           [get_pins {u22_int_set_reg[2]/SETN}]\
           [get_pins {u23_int_set_reg[0]/RESETN}]\
           [get_pins {u23_int_set_reg[0]/SETN}]\
           [get_pins {u23_int_set_reg[2]/RESETN}]\
           [get_pins {u23_int_set_reg[2]/SETN}]\
           [get_pins {u24_int_set_reg[0]/RESETN}]\
           [get_pins {u24_int_set_reg[0]/SETN}]\
           [get_pins {u24_int_set_reg[2]/RESETN}]\
           [get_pins {u24_int_set_reg[2]/SETN}]\
           [get_pins {u25_int_set_reg[0]/RESETN}]\
           [get_pins {u25_int_set_reg[0]/SETN}]\
           [get_pins {u25_int_set_reg[2]/RESETN}]\
           [get_pins {u25_int_set_reg[2]/SETN}]\
           [get_pins {u26_ac97_rst__reg/RESETN}]\
           [get_pins {u26_ac97_rst__reg/SETN}]\
           [get_pins {u26_cnt_reg[0]/RESETN}]\
           [get_pins {u26_cnt_reg[0]/SETN}]\
           [get_pins {u26_cnt_reg[1]/RESETN}]\
           [get_pins {u26_cnt_reg[1]/SETN}]\
           [get_pins {u26_cnt_reg[2]/RESETN}]\
           [get_pins {u26_cnt_reg[2]/SETN}]\
           [get_pins {u26_ps_cnt_reg[0]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[0]/SETN}]\
           [get_pins {u26_ps_cnt_reg[1]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[1]/SETN}]\
           [get_pins {u26_ps_cnt_reg[2]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[2]/SETN}]\
           [get_pins {u26_ps_cnt_reg[3]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[3]/SETN}]\
           [get_pins {u26_ps_cnt_reg[4]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[4]/SETN}]\
           [get_pins {u26_ps_cnt_reg[5]/RESETN}]\
           [get_pins {u26_ps_cnt_reg[5]/SETN}]\
           [get_pins {u2_cnt_reg[0]/RESETN}]\
           [get_pins {u2_cnt_reg[0]/SETN}]\
           [get_pins {u2_cnt_reg[1]/RESETN}]\
           [get_pins {u2_cnt_reg[1]/SETN}]\
           [get_pins {u2_cnt_reg[2]/RESETN}]\
           [get_pins {u2_cnt_reg[2]/SETN}]\
           [get_pins {u2_cnt_reg[3]/RESETN}]\
           [get_pins {u2_cnt_reg[3]/SETN}]\
           [get_pins {u2_cnt_reg[4]/RESETN}]\
           [get_pins {u2_cnt_reg[4]/SETN}]\
           [get_pins {u2_cnt_reg[5]/RESETN}]\
           [get_pins {u2_cnt_reg[5]/SETN}]\
           [get_pins {u2_cnt_reg[6]/RESETN}]\
           [get_pins {u2_cnt_reg[6]/SETN}]\
           [get_pins {u2_cnt_reg[7]/RESETN}]\
           [get_pins {u2_cnt_reg[7]/SETN}]\
           [get_pins {u2_sync_resume_reg/RESETN}]\
           [get_pins {u2_sync_resume_reg/SETN}]\
           [get_pins {u2_to_cnt_reg[0]/RESETN}]\
           [get_pins {u2_to_cnt_reg[0]/SETN}]\
           [get_pins {u2_to_cnt_reg[1]/RESETN}]\
           [get_pins {u2_to_cnt_reg[1]/SETN}]\
           [get_pins {u2_to_cnt_reg[2]/RESETN}]\
           [get_pins {u2_to_cnt_reg[2]/SETN}]\
           [get_pins {u2_to_cnt_reg[3]/RESETN}]\
           [get_pins {u2_to_cnt_reg[3]/SETN}]\
           [get_pins {u2_to_cnt_reg[4]/RESETN}]\
           [get_pins {u2_to_cnt_reg[4]/SETN}]\
           [get_pins {u2_to_cnt_reg[5]/RESETN}]\
           [get_pins {u2_to_cnt_reg[5]/SETN}]]
###############################################################################
# Environment
###############################################################################
set_input_transition -min 0.8000 [get_ports {bit_clk_pad_i}]
set_input_transition -max 4.0000 [get_ports {bit_clk_pad_i}]
set_input_transition -min 0.8000 [get_ports {clk_i}]
set_input_transition -max 4.0000 [get_ports {clk_i}]
set_input_transition -min 0.8000 [get_ports {rst_i}]
set_input_transition -max 4.0000 [get_ports {rst_i}]
set_input_transition -min 0.8000 [get_ports {sdata_pad_i}]
set_input_transition -max 4.0000 [get_ports {sdata_pad_i}]
set_input_transition -min 0.8000 [get_ports {wb_cyc_i}]
set_input_transition -max 4.0000 [get_ports {wb_cyc_i}]
set_input_transition -min 0.8000 [get_ports {wb_stb_i}]
set_input_transition -max 4.0000 [get_ports {wb_stb_i}]
set_input_transition -min 0.8000 [get_ports {wb_we_i}]
set_input_transition -max 4.0000 [get_ports {wb_we_i}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[8]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[8]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[7]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[7]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[6]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[6]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[5]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[5]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[4]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[4]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[3]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[3]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[2]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[2]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[1]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[1]}]
set_input_transition -min 0.8000 [get_ports {dma_ack_i[0]}]
set_input_transition -max 4.0000 [get_ports {dma_ack_i[0]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[31]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[31]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[30]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[30]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[29]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[29]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[28]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[28]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[27]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[27]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[26]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[26]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[25]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[25]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[24]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[24]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[23]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[23]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[22]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[22]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[21]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[21]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[20]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[20]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[19]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[19]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[18]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[18]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[17]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[17]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[16]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[16]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[15]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[15]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[14]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[14]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[13]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[13]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[12]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[12]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[11]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[11]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[10]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[10]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[9]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[9]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[8]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[8]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[7]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[7]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[6]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[6]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[5]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[5]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[4]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[4]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[3]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[3]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[2]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[2]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[1]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[1]}]
set_input_transition -min 0.8000 [get_ports {wb_addr_i[0]}]
set_input_transition -max 4.0000 [get_ports {wb_addr_i[0]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[31]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[31]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[30]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[30]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[29]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[29]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[28]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[28]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[27]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[27]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[26]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[26]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[25]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[25]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[24]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[24]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[23]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[23]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[22]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[22]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[21]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[21]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[20]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[20]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[19]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[19]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[18]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[18]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[17]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[17]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[16]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[16]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[15]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[15]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[14]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[14]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[13]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[13]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[12]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[12]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[11]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[11]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[10]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[10]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[9]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[9]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[8]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[8]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[7]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[7]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[6]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[6]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[5]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[5]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[4]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[4]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[3]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[3]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[2]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[2]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[1]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[1]}]
set_input_transition -min 0.8000 [get_ports {wb_data_i[0]}]
set_input_transition -max 4.0000 [get_ports {wb_data_i[0]}]
set_input_transition -min 0.8000 [get_ports {wb_sel_i[3]}]
set_input_transition -max 4.0000 [get_ports {wb_sel_i[3]}]
set_input_transition -min 0.8000 [get_ports {wb_sel_i[2]}]
set_input_transition -max 4.0000 [get_ports {wb_sel_i[2]}]
set_input_transition -min 0.8000 [get_ports {wb_sel_i[1]}]
set_input_transition -max 4.0000 [get_ports {wb_sel_i[1]}]
set_input_transition -min 0.8000 [get_ports {wb_sel_i[0]}]
set_input_transition -max 4.0000 [get_ports {wb_sel_i[0]}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.8000 [get_ports {ac97_reset_pad_o_}]
set_max_transition 0.8000 [get_ports {int_o}]
set_max_transition 0.8000 [get_ports {sdata_pad_o}]
set_max_transition 0.8000 [get_ports {suspended_o}]
set_max_transition 0.8000 [get_ports {sync_pad_o}]
set_max_transition 0.8000 [get_ports {wb_ack_o}]
set_max_transition 0.8000 [get_ports {wb_err_o}]
set_max_transition 0.8000 [get_ports {dma_req_o[8]}]
set_max_transition 0.8000 [get_ports {dma_req_o[7]}]
set_max_transition 0.8000 [get_ports {dma_req_o[6]}]
set_max_transition 0.8000 [get_ports {dma_req_o[5]}]
set_max_transition 0.8000 [get_ports {dma_req_o[4]}]
set_max_transition 0.8000 [get_ports {dma_req_o[3]}]
set_max_transition 0.8000 [get_ports {dma_req_o[2]}]
set_max_transition 0.8000 [get_ports {dma_req_o[1]}]
set_max_transition 0.8000 [get_ports {dma_req_o[0]}]
set_max_transition 0.8000 [get_ports {wb_data_o[31]}]
set_max_transition 0.8000 [get_ports {wb_data_o[30]}]
set_max_transition 0.8000 [get_ports {wb_data_o[29]}]
set_max_transition 0.8000 [get_ports {wb_data_o[28]}]
set_max_transition 0.8000 [get_ports {wb_data_o[27]}]
set_max_transition 0.8000 [get_ports {wb_data_o[26]}]
set_max_transition 0.8000 [get_ports {wb_data_o[25]}]
set_max_transition 0.8000 [get_ports {wb_data_o[24]}]
set_max_transition 0.8000 [get_ports {wb_data_o[23]}]
set_max_transition 0.8000 [get_ports {wb_data_o[22]}]
set_max_transition 0.8000 [get_ports {wb_data_o[21]}]
set_max_transition 0.8000 [get_ports {wb_data_o[20]}]
set_max_transition 0.8000 [get_ports {wb_data_o[19]}]
set_max_transition 0.8000 [get_ports {wb_data_o[18]}]
set_max_transition 0.8000 [get_ports {wb_data_o[17]}]
set_max_transition 0.8000 [get_ports {wb_data_o[16]}]
set_max_transition 0.8000 [get_ports {wb_data_o[15]}]
set_max_transition 0.8000 [get_ports {wb_data_o[14]}]
set_max_transition 0.8000 [get_ports {wb_data_o[13]}]
set_max_transition 0.8000 [get_ports {wb_data_o[12]}]
set_max_transition 0.8000 [get_ports {wb_data_o[11]}]
set_max_transition 0.8000 [get_ports {wb_data_o[10]}]
set_max_transition 0.8000 [get_ports {wb_data_o[9]}]
set_max_transition 0.8000 [get_ports {wb_data_o[8]}]
set_max_transition 0.8000 [get_ports {wb_data_o[7]}]
set_max_transition 0.8000 [get_ports {wb_data_o[6]}]
set_max_transition 0.8000 [get_ports {wb_data_o[5]}]
set_max_transition 0.8000 [get_ports {wb_data_o[4]}]
set_max_transition 0.8000 [get_ports {wb_data_o[3]}]
set_max_transition 0.8000 [get_ports {wb_data_o[2]}]
set_max_transition 0.8000 [get_ports {wb_data_o[1]}]
set_max_transition 0.8000 [get_ports {wb_data_o[0]}]
set_max_fanout 16.0000 [current_design]
