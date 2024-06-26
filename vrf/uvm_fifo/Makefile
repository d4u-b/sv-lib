all: simulate

NPROC = $$((`nproc`-1))

# -------------------------------------
# Testbench setup
# -------------------------------------
VERILATOR := verilator
ifdef VERILATOR_ROOT
VERILATOR := $(VERILATOR_ROOT)/bin/verilator
endif

TOP := top
UVM_ROOT ?=$$UVM_HOME
UVM_TEST ?= fifo_test

#VERILOG_DEFINE_FILES = ${UVM_ROOT}/src/uvm.sv ./hdl/tbench_top.sv ./hdl/design.sv
#VERILOG_INCLUDE_DIRS = hdl ${UVM_ROOT}/src
VERILOG_DEFINE_FILES = -f ${SVLIB}/vrf/uvm_fifo/top.f

# -------------------------------------
# Compilation/simulation configuration
# -------------------------------------
SIM_NAME ?= fifo_tb
SIM_DIR := $(SIM_NAME)-sim
COMPILE_ARGS += -DUVM_NO_DPI --top-module $(TOP)
COMPILE_ARGS += --prefix $(SIM_NAME) -o $(SIM_NAME)
EXTRA_ARGS += --trace-fst --timescale 1ns/1ps --error-limit 100
#GTK_ARGS := -xml-only -bbox-sys
WARNING_ARGS += -Wno-lint \
	-Wno-style \
	-Wno-fatal \
	-Wno-SYMRSVDWORD \
	-Wno-IGNOREDRETURN \
	-Wno-CONSTRAINTIGN \
	-Wno-ZERODLY

# -------------------------------------
# Make UVM test with Verilator
# -------------------------------------
$(SIM_DIR)/$(SIM_NAME).mk: $(wildcard hdl/*.sv)
	$(VERILATOR) --cc --exe --main --timing -Mdir $(SIM_DIR) \
	${COMPILE_ARGS} ${EXTRA_ARGS} \
	${VERILOG_DEFINE_FILES} \
	${WARNING_ARGS}
#	${GTK_ARGS}

$(SIM_DIR)/$(SIM_NAME): $(SIM_DIR)/$(SIM_NAME).mk
	$(MAKE) -j${NPROC} -C $(SIM_DIR) $(BUILD_ARGS) -f $(SIM_NAME).mk

simulate: $(SIM_DIR)/$(SIM_NAME).mk $(SIM_DIR)/$(SIM_NAME)
	$(SIM_DIR)/$(SIM_NAME) +UVM_TESTNAME=$(UVM_TEST)

wave:
	gtkwave top.vcd &

lint:
	$(VERILATOR) --lint-only -Wall --timing ${VERILOG_DEFINE_FILES}

qrun.sh:
	qrun -f top.f -uvm -top top -debug +UVM_TESTNAME=${UVM_TEST} -script qrun.sh

qsim: qrun.sh
	chmod +x qrun.sh && ./qrun.sh

qwave:
	vsim -view vsim.wlf

clean:
	rm -rf simv*.daidir csrc
	rm -rf csrc* simv*
	rm -rf $(SIM_DIR)
	rm -rf *.vcd *.log
	rm -rf qrun*
	rm -rf transcript
	rm -rf *.wlf
	rm -rf modelsim.ini

.PHONY: simulate clean
