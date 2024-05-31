SVLIB_P =$(shell pwd)
init:
	@echo "Initaling sv-lib"
	@export SVLIB=$(SVLIB_P)
	@echo "SVLIB="$(value SVLIB)

