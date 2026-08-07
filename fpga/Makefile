# See LICENSE for license details.

board_list = ddr200t mcu200t ku060 vcu118 vu440_s2c
ddr3_list = ddr200t 
ddr4_list = ku060 vcu118 vu440_s2c
eth_list = ku060 vcu118

export
base_dir := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
BOARD_NAME := ddr200t

ifneq ($(findstring $(BOARD_NAME), $(board_list)), $(BOARD_NAME))
$(error ${BOARD_NAME} don't support)
endif

FPGA_DIR := $(base_dir)/${BOARD_NAME}

CORE            := n600
DESIGN_ROOT     = $(abspath ../design)

INSTALL_DIR = ${PWD}/gen/${BOARD_NAME}
INSTALL_RTL = ${INSTALL_DIR}/src
INSTALL_RTLVF = ${INSTALL_RTL}/rtl.vf
SCRIPTS_DIR = ${PWD}/scripts
BOARD_DIR = ${PWD}/boards/${BOARD_NAME}

ifeq ($(BOARD_NAME),ku060)
FPGA_CHIP_NAME := xcku060-ffva1156-1-c
BOARD_KU060 := 1
else ifeq ($(BOARD_NAME),vcu118)
FPGA_CHIP_NAME := xcvu9p-flga2104-2L-e
BOARD_VCU118 := 1
else ifeq ($(BOARD_NAME),vu440_s2c)
FPGA_CHIP_NAME := xcvu440-flga2892-2-e
BOARD_VU440_S2C := 1
else
FPGA_CHIP_NAME := xc7a200tfbg484-2
endif

DDR_FREQ := 200
CORE_FREQ ?= 50
ETH_FREQ := 200

BITFILE_NAME = ${CORE}_${CORE_FREQ}M.bit
MCSFILE_NAME = ${CORE}_${CORE_FREQ}M.mcs

ifeq ($(findstring $(BOARD_NAME), $(ddr3_list)), $(BOARD_NAME))
DDR3_EN := 1
else
DDR3_EN := 0
endif

ifeq ($(findstring $(BOARD_NAME), $(ddr4_list)), $(BOARD_NAME))
DDR4_EN := 1
else
DDR4_EN := 0
endif

XEC_EN := 0
ETH_EN := 0
ifeq ($(EVALSOC_HAS_ETHERNET),1)
ifeq ($(findstring $(BOARD_NAME), $(eth_list)), $(BOARD_NAME))
XEC_EN := 1
endif
endif


include common.mk
