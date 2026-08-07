set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#####               create clock              #####
#set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVDS_25 } [get_ports { CLK200MHZ_p }]; 
#set_property -dict { PACKAGE_PIN T4    IOSTANDARD LVDS_25 } [get_ports { CLK200MHZ_n }]; 
set_property -dict { PACKAGE_PIN W19    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; 
set_property -dict { PACKAGE_PIN Y18    IOSTANDARD LVCMOS33 } [get_ports { CLK32768HZ }]; 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];
create_clock -add -name sys_clk_pin -period 30517.58 -waveform {0 15258.79} [get_ports {CLK32768HZ}];
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets dut_io_pads_jtag_TCK_i_ival]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets IOBUF_jtag_TCK/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets dut/u_n600_subsys_top/u_n600_subsys_main/u_axi_ethernetlite_wrapper/U0/o]
set sys_mmcm [get_cells -hier -filter {NAME =~ */ip_mmcm/* && REF_NAME == MMCME2_ADV}]
set ddr_mmcm [get_cells -hier -filter {NAME =~ */u_ddr3_wrapper/* && REF_NAME == MMCME2_ADV}]
if {[llength $sys_mmcm] != 1 || [llength $ddr_mmcm] != 1} {
  error "Expected exactly one system MMCM and one DDR MMCM"
}
set sys_clk [get_clocks -of_objects [get_pins -of_objects $sys_mmcm -filter {REF_PIN_NAME == CLKOUT1}]]
set ddr_clk [get_clocks -of_objects [get_pins -of_objects $ddr_mmcm -filter {REF_PIN_NAME == CLKFBOUT}]]
set_false_path -from $sys_clk -to $ddr_clk
set_false_path -from $ddr_clk -to $sys_clk
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets dut/u_n600_subsys_top/u_n600_subsys_main/u_n600_subsys_temac/u_axi_ethernetlite_wrapper/U0/o]


#####            rst define           #####
set_property PACKAGE_PIN T6  [get_ports fpga_rst  ]
set_property PACKAGE_PIN P20 [get_ports mcu_rst   ]

#####                spi define               #####
set_property PACKAGE_PIN W16 [get_ports  qspi0_cs    ]
set_property PACKAGE_PIN W15 [get_ports  qspi0_sck   ]
set_property PACKAGE_PIN U16 [get_ports {qspi0_dq[3]}]
set_property PACKAGE_PIN T16 [get_ports {qspi0_dq[2]}]
set_property PACKAGE_PIN T14 [get_ports {qspi0_dq[1]}]
set_property PACKAGE_PIN T15 [get_ports {qspi0_dq[0]}]

#####                spi1 define               #####
set_property PACKAGE_PIN AA21 [get_ports  qspi1_cs0    ]
set_property PACKAGE_PIN W21 [get_ports  qspi1_cs1    ]
set_property PACKAGE_PIN T20 [get_ports  qspi1_cs2    ]
set_property PACKAGE_PIN N13 [get_ports  qspi1_cs3    ]
set_property PACKAGE_PIN AB21 [get_ports  qspi1_sck   ]
set_property PACKAGE_PIN U20 [get_ports {qspi1_dq[3]}]
set_property PACKAGE_PIN AB22 [get_ports {qspi1_dq[2]}]
set_property PACKAGE_PIN Y22 [get_ports {qspi1_dq[1]}]
set_property PACKAGE_PIN Y21 [get_ports {qspi1_dq[0]}]

#####                spi2 define               #####
set_property PACKAGE_PIN AB15 [get_ports  qspi2_cs    ]
set_property PACKAGE_PIN W14 [get_ports  qspi2_sck   ]
set_property PACKAGE_PIN W17 [get_ports {qspi2_dq[3]}]
set_property PACKAGE_PIN AA18 [get_ports {qspi2_dq[2]}]
set_property PACKAGE_PIN Y16 [get_ports {qspi2_dq[1]}]
set_property PACKAGE_PIN Y14 [get_ports {qspi2_dq[0]}]

#####                uart0 define               #####
set_property PACKAGE_PIN R17  [get_ports uart0_txd]
set_property PACKAGE_PIN P16  [get_ports uart0_rxd]
#####                uart1 define               #####
set_property PACKAGE_PIN R14  [get_ports uart1_txd]
set_property PACKAGE_PIN R18  [get_ports uart1_rxd]


#####               MCU JTAG define           #####
set_property PACKAGE_PIN N17 [get_ports mcu_TDO]
set_property PACKAGE_PIN P15 [get_ports mcu_TCK]
set_property PACKAGE_PIN T18 [get_ports mcu_TDI]
set_property PACKAGE_PIN P17 [get_ports mcu_TMS]
set_property KEEPER true [get_ports mcu_TMS]

create_clock -name mcu_jtag_tck -period 500 [get_ports mcu_TCK]
####                nex etrace                ####
#set_property PACKAGE_PIN AJ10 [get_ports {nex_o_clk}]
#set_property PACKAGE_PIN AJ11 [get_ports {nex_o_data[0]}]
#set_property PACKAGE_PIN AG9  [get_ports {nex_o_data[1]}]
#set_property PACKAGE_PIN AG10 [get_ports {nex_o_data[2]}]
#set_property PACKAGE_PIN AF9  [get_ports {nex_o_data[3]}]

#####                gpio define              #####
#set_property PACKAGE_PIN W17  [get_ports {gpio[31]}]
#set_property PACKAGE_PIN AA18 [get_ports {gpio[30]}]
## sck -> sd_clk
#set_property PACKAGE_PIN W14 [get_ports {gpio[29]}]
## dq1 -> sd_dat0
#set_property PACKAGE_PIN Y16  [get_ports {gpio[28]}]
## dq0 -> sd_cmd
#set_property PACKAGE_PIN Y14  [get_ports {gpio[27]}]
## cs -> SD_DATA3
#set_property PACKAGE_PIN AB15  [get_ports {gpio[26]}]
#
#set_property PACKAGE_PIN R14  [get_ports {gpio[25]}]
#set_property PACKAGE_PIN R18  [get_ports {gpio[24]}]
#set_property PACKAGE_PIN V20  [get_ports {gpio[23]}]
#set_property PACKAGE_PIN W20  [get_ports {gpio[22]}]
#set_property PACKAGE_PIN Y19  [get_ports {gpio[21]}]
#set_property PACKAGE_PIN V18  [get_ports {gpio[20]}]
#set_property PACKAGE_PIN V19  [get_ports {gpio[19]}]
#set_property PACKAGE_PIN AA19 [get_ports {gpio[18]}]
#set_property PACKAGE_PIN R17  [get_ports {gpio[17]}]
#set_property PACKAGE_PIN P16  [get_ports {gpio[16]}]
#set_property PACKAGE_PIN V22  [get_ports {gpio[15]}]
#set_property PACKAGE_PIN T21  [get_ports {gpio[14]}]
#set_property PACKAGE_PIN U21  [get_ports {gpio[13]}]
#set_property PACKAGE_PIN P19  [get_ports {gpio[12]}]
#set_property PACKAGE_PIN R19  [get_ports {gpio[11]}]
#set_property PACKAGE_PIN N13  [get_ports {gpio[10]}]
#set_property PACKAGE_PIN T20  [get_ports {gpio[9]}]
#set_property PACKAGE_PIN W21  [get_ports {gpio[8]}]
#set_property PACKAGE_PIN U20  [get_ports {gpio[7]}]
#set_property PACKAGE_PIN AB22 [get_ports {gpio[6]}]
#set_property PACKAGE_PIN AB21 [get_ports {gpio[5]}]
#set_property PACKAGE_PIN Y22  [get_ports {gpio[4]}]
#set_property PACKAGE_PIN Y21  [get_ports {gpio[3]}]
#set_property PACKAGE_PIN AA21 [get_ports {gpio[2]}]
#set_property PACKAGE_PIN AA20 [get_ports {gpio[1]}]
#set_property PACKAGE_PIN W22  [get_ports {gpio[0]}]

#####                wfi define              #####
set_property PACKAGE_PIN Y6   [get_ports {evt_bar}]
set_property PACKAGE_PIN AA6  [get_ports {nmi_bar}]
set_property PACKAGE_PIN J16  [get_ports {core_wfi_mode}]
set_property PACKAGE_PIN E22  [get_ports {core_sleep_value}]

#####                wfi define              #####
set_property IOSTANDARD LVCMOS15 [get_ports  evt_bar    ]
#set_property PULLUP true [get_ports  evt_bar    ]

set_property IOSTANDARD LVCMOS15 [get_ports  nmi_bar   ]
#set_property PULLUP true [get_ports  nmi_bar    ]

set_property IOSTANDARD LVCMOS33 [get_ports  core_wfi_mode   ]
set_property IOSTANDARD LVCMOS33 [get_ports  core_sleep_value  ]




#####            clock & rst define           #####
set_property IOSTANDARD LVCMOS15 [get_ports fpga_rst  ]
set_property IOSTANDARD LVCMOS33 [get_ports mcu_rst   ]


#####                spi define               #####
set_property IOSTANDARD LVCMOS33 [get_ports  qspi0_cs    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi0_sck   ]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi0_dq[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi0_dq[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi0_dq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi0_dq[0]}]

#####                spi define               #####
set_property IOSTANDARD LVCMOS33 [get_ports  qspi1_cs0    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi1_cs1    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi1_cs2    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi1_cs3    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi1_sck   ]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi1_dq[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi1_dq[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi1_dq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi1_dq[0]}]

#####                spi define               #####
set_property IOSTANDARD LVCMOS33 [get_ports  qspi2_cs    ]
set_property IOSTANDARD LVCMOS33 [get_ports  qspi2_sck   ]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi2_dq[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi2_dq[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi2_dq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {qspi2_dq[0]}]

#####                uart0 define               #####
set_property IOSTANDARD LVCMOS33  [get_ports uart0_txd]
set_property IOSTANDARD LVCMOS33  [get_ports uart0_rxd]
#####                uart1 define               #####
set_property IOSTANDARD LVCMOS33  [get_ports uart1_txd]
set_property IOSTANDARD LVCMOS33  [get_ports uart1_rxd]


#####               MCU JTAG define           #####
set_property IOSTANDARD LVCMOS33 [get_ports mcu_TDO]
set_property IOSTANDARD LVCMOS33 [get_ports mcu_TCK]
set_property IOSTANDARD LVCMOS33 [get_ports mcu_TDI]
set_property IOSTANDARD LVCMOS33 [get_ports mcu_TMS]

####                nex etrace define               ####
#set_property IOSTANDARD LVCMOS33 [get_ports {nex_o_clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {nex_o_data[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {nex_o_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {nex_o_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {nex_o_data[3]}]

#####                gpio define              #####
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[31]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[30]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[29]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[28]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[27]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[26]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[25]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[24]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[23]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[22]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[21]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[20]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[19]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[18]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[17]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[16]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {gpio[0]}]

#init_ddr
set_property PACKAGE_PIN C17  [get_ports {init_calib_complete}]

set_property IOSTANDARD LVCMOS33 [get_ports {init_calib_complete} ]


#SDIO
set_property PACKAGE_PIN Y16  [get_ports {sdio_dq[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_dq[0]}]

set_property PACKAGE_PIN AB17  [get_ports {sdio_dq[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_dq[1]}]

set_property PACKAGE_PIN AA15  [get_ports {sdio_dq[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_dq[2]}]

set_property PACKAGE_PIN AB15  [get_ports {sdio_dq[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_dq[3]}]


set_property PACKAGE_PIN Y14  [get_ports {sdio_cmd}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_cmd}]


set_property PACKAGE_PIN W14  [get_ports {sdio_sck}]
set_property IOSTANDARD LVCMOS33 [get_ports {sdio_sck}]


#####         SPI Configurate Setting        #######
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design] 
set_property CONFIG_MODE SPIx4 [current_design] 
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]




