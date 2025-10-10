export

#miscellaneous setting
START_GUI                        := 0
LINK_ONLY                        := 0


#design setting
TOP                              := e603_core_rams
SYN_ROOT                         := $(PWD)
INC_DIRS                         := ../design/core \
                                    memgen/wrapper \
									../design/soc
RTL_FILELIST                     := ./rtl.vf
SDC_FILE                         := constraints/e603_core_rams_func.sdc
FREQ_SCALE                       := 1.0

#technology setting
ANA_DEFINE_OPTS                  :=  SYNTHESIS \
                                     TECH_NUCLEI_DUMMY_RAM \
                                     TECH_NUCLEI_DUMMY_STD \
                                     TECH_NUCLEI_DUMMY_STD_10T
CORNER                           := slow
LIB_ROOT                         := ./techlib
LIB_PATHS                        := $(LIB_ROOT)/library/std_rvt/db
LIB_NAMES                        := std_rvt_$(CORNER).db
ALL_OTHER_STD_LIB_PATHS          := $(LIB_ROOT)/library/std_lvt/db
ALL_OTHER_STD_LIB_NAMES          := std_lvt_$(CORNER).db
SRAM_MACRO_DBLIB                 := $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_1024X32_MW4_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_128X16_MW16_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_128X27_MW1_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_128X40_MW1_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_2048X64_MW1_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_256X21_MW1_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_256X22_MW1_slow.db \
                                    $(SYN_ROOT)/memgen/dblib/NUCLEI_SPRAM_32X140_MW140_slow.db


#dc setting
SYN_MODE                         := 1
WORK_MODE                        := func
OPER_COND                        := slow
SYN_FLATTEN                      := 1
SYN_FLATTEN_LEVEL                := 1
SYN_WITH_SRAM                    := 1

TOPO_OPTS                        := 


BUF_CELL                         := RVT_BUF_X4
NAND_CELL                        := std_rvt_$(CORNER)/RVT_NAND2_X1



SYN_TAG                          := e603_core_rams_slow
DATE_TAG                         := $(shell date +%h%d_%H%M)
SYN_LOG_FILE                     := ./$(SYN_TAG)/syn_$(DATE_TAG).log
DC_OPEN_LOG                      := ./$(SYN_TAG)/dc_open_$(DATE_TAG).log

REPORT_TIMING_FOR_INIT_COMP      := 1

#dft setting
DFT_EN                           := 0
#verdi setting
VERDI_USE_ALL_LIB                := 1
ORIGIN_FILELIST                  := ./origin_rtl.vf
COMMON_VERDI_OPTS                := -sverilog -top $(TOP)  \
                                    +define+SYNTHESIS +define+SYNTHESIS +define+TECH_NUCLEI_DUMMY_RAM +define+TECH_NUCLEI_DUMMY_STD +define+TECH_NUCLEI_DUMMY_STD_10T \
                                    +incdir+../../design/core+./memgen/wrapper
NOPG_VERDI_OPTS                  := 
ifeq ($(VERDI_USE_ALL_LIB), 1)
    STD_LIB_VMOD                 := $(LIB_ROOT)/library/std_rvt/verilog/std_rvt.v \
                                    $(LIB_ROOT)/library/std_lvt/verilog/std_lvt.v
else
    STD_LIB_VMOD                 := $(LIB_ROOT)/library/std_rvt/verilog/std_rvt.v
endif

.PHONY: pre_syn dc dc_open_rtl rtl_verdi \
        dc_open_net dc_open_comp net_verdi \
        dc_eco dc_mv_eco clean
pre_syn:
	@mkdir -p $(SYN_TAG)
	@mkdir -p $(SYN_TAG)/WORK
	@rm -f ./$(SYN_TAG)/constraints
	@cd ./$(SYN_TAG); ln -s ../constraints ./constraints

dc_current: pre_syn
	@dc_shell-t $(TOPO_OPTS) -64bit -f ./run_tcl/dc.tcl -output_log_file $(SYN_LOG_FILE)
	@rm -rf $(SYN_TAG)/latest_syn.log
	@ln -fs $(SYN_ROOT)/$(SYN_LOG_FILE) $(SYN_TAG)/latest_syn.log
	@rm -f latest_syn
	@ln -fs $(SYN_TAG) latest_syn

dc: pre_syn
	$(MAKE) dc_current

rtl_verdi:
	verdi $(COMMON_VERDI_OPTS) $(NOPG_VERDI_OPTS) -f $(ORIGIN_FILELIST) -f $(SYN_ROOT)/memgen/vmodel/sram.vf $(foreach lvm,$(STD_LIB_VMOD),-v $(lvm)) &

net_verdi: ./$(SYN_TAG)/results/$(TOP).mapped.v
	@verdi $(COMMON_VERDI_OPTS) $(foreach lvm,$(STD_LIB_VMOD),-v $(lvm)) $(NOPG_VERDI_OPTS) ./$(SYN_TAG)/results/$(TOP).mapped.v &

dc_open_rtl: pre_syn
	@dc_shell-t $(TOPO_OPTS) -64bit -f ./run_tcl/dc_open_rtl.tcl -output_log_file $(DC_OPEN_LOG)

dc_open_comp: pre_syn
	@dc_shell-t $(TOPO_OPTS) -64bit -f ./run_tcl/dc_open_comp.tcl -output_log_file $(DC_OPEN_LOG)

dc_open_net: pre_syn
	@dc_shell-t $(TOPO_OPTS) -64bit -f ./run_tcl/dc_open_net.tcl -output_log_file $(DC_OPEN_LOG)

clean:
	@rm -rf $(SYN_TAG) WORK*


include ./makefiles/fm.mk
include ./makefiles/simple_etm.mk
