# See LICENSE for license details.

# Required variables:
# - PROJECT
# - CONFIG_PROJECT
# - CONFIG
# - INSTALL_DIR

# Install RTLs


.PHONY: install
install:
	# remove the old directory
	rm -rf ${INSTALL_RTL}
	mkdir -p ${INSTALL_RTL}
	cp -rf ${DESIGN_ROOT}/* ${INSTALL_RTL}
	rm -rf ${INSTALL_RTL}/asic
	rm -rf ${INSTALL_RTL}/mems/ddr3
	rm -rf ${INSTALL_RTL}/mems/ddr4
	rm -rf ${INSTALL_RTL}/mems/ku060_ddr4
	rm -rf ${INSTALL_RTL}/mems/vcu118_ddr4
	rm -rf ${INSTALL_RTL}/perips/temac
	# generate the fpga top verilog file
	cp ${BOARD_DIR}/src/${CORE}_system.v ${INSTALL_RTL}/system.v
ifeq ($(XEC_EN),1)	
	cp ${BOARD_DIR}/src/xec_gen2_top_with_sram.dcp ${INSTALL_RTL}/xec_gen2_top_with_sram.dcp
endif
	echo '// This is the global header file to include some global macros' > ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	echo '' >> ${INSTALL_RTL}/core/global.v
	sed -i '2i\`define FPGA_SOURCE\'  ${INSTALL_RTL}/core/global.v
ifeq ($(ETH_EN),1)
	sed -i '3i\`define TEMAC_CONTROLLER\'  ${INSTALL_RTL}/core/global.v
endif
ifeq ($(DDR3_EN),1)
	sed -i '4i\`define DDR_CONTROLLER\'  ${INSTALL_RTL}/core/global.v
	sed -i '5i\`define DDR3_CONTROLLER\'  ${INSTALL_RTL}/core/global.v
endif
ifeq ($(DDR4_EN),1)
	sed -i '4i\`define DDR_CONTROLLER\'  ${INSTALL_RTL}/core/global.v
	sed -i '5i\`define DDR4_CONTROLLER\'  ${INSTALL_RTL}/core/global.v
endif
ifeq ($(BOARD_KU060), 1)
	sed -i '6i\`define BOARD_KU060\'  ${INSTALL_RTL}/core/global.v
else

ifeq ($(BOARD_VU440_S2C), 1)
	sed -i '6i\`define BOARD_VU440_S2C\'  ${INSTALL_RTL}/core/global.v
	sed -i '7i\`define FPGA_RTC_DCLK\'  ${INSTALL_RTL}/core/global.v
else ifeq ($(BOARD_VU19P_PHINE), 1)
	sed -i '6i\`define BOARD_VU19P_PHINE\'  ${INSTALL_RTL}/core/global.v
	sed -i '7i\`define RTC_CLK_FROM_INTERNAL\'  ${INSTALL_RTL}/core/global.v
else ifeq ($(BOARD_VU19P_S2C_DUAL), 1)
	sed -i '6i\`define BOARD_VU440_S2C\'  ${INSTALL_RTL}/core/global.v
	sed -i '7i\`define FPGA_RTC_DCLK\'  ${INSTALL_RTL}/core/global.v
else ifeq ($(BOARD_VCU118), 1)
	sed -i '6i\`define BOARD_VCU118\'  ${INSTALL_RTL}/core/global.v
	sed -i '7i\`define RTC_CLK_FROM_INTERNAL\'  ${INSTALL_RTL}/core/global.v
endif

endif

	# generate
	cp -rf ${PWD}/boards/Makefile ${INSTALL_DIR}
	mkdir -p ${INSTALL_DIR}/constrs  ${INSTALL_DIR}/script
	cp -rf ${BOARD_DIR}/script/* ${INSTALL_DIR}/script/
	cp -rf ${BOARD_DIR}/xdc/* ${INSTALL_DIR}/constrs/
	cp -rf ${BOARD_DIR}/nuclei-master.xdc ${INSTALL_DIR}/constrs/
	find ${INSTALL_RTL} -name "*.v" > ${INSTALL_RTLVF}

# Build .mcs
.PHONY: mcs
mcs: install
	time env RTLVF=${INSTALL_RTLVF} make -C $(INSTALL_DIR) mcs
	echo "mcsfile: $(INSTALL_DIR)/obj/$(MCSFILE_NAME)"

only_mcs:
	time env RTLVF=${INSTALL_RTLVF} make -C $(INSTALL_DIR) only_mcs


rgs_mcs: $(RGS_MCS_CFG_LIST)

mcs_%:
	make mcs CFG=$(subst mcs_,,$@)

# Build .bit
.PHONY: bit
bit : install
	time env RTLVF=${INSTALL_RTLVF} FPGA_CHIP_NAME=${FPGA_CHIP_NAME} make -C $(INSTALL_DIR) bit
	@echo "bitfile: $(INSTALL_DIR)/obj/$(BITFILE_NAME)"


rgs_bit: $(RGS_BIT_CFG_LIST)

bit_%:
	time make bit CFG=$(subst bit_,,$@)



.PHONY: setup
setup:
	RTLVF=${INSTALL_RTLVF} make -C $(INSTALL_DIR) setup

.PHONY: ela
ela : install
	time env RTLVF=${INSTALL_RTLVF} FPGA_CHIP_NAME=${FPGA_CHIP_NAME} make -C $(INSTALL_DIR) ela

.PHONY: syn
syn : install
	time env RTLVF=${INSTALL_RTLVF} FPGA_CHIP_NAME=${FPGA_CHIP_NAME} make -C $(INSTALL_DIR) syn

# Clean
.PHONY: clean
clean:
	rm $(INSTALL_DIR) -rf

.PHONY: clean_all
clean_all:
	rm gen -rf
