#
# Makefile
# @author Evgeny Ukhanov <mrlsd@ya.ru>
#

run:
	@iverilog -otimer_test timer_test.sv && ./timer_test

compile:
	@quartus_map --read_settings_files=on --write_settings_files=off timer -c timer

build:
	@quartus_map --read_settings_files=on --write_settings_files=off timer -c timer
	@quartus_fit --read_settings_files=off --write_settings_files=off timer -c timer
	@quartus_asm --read_settings_files=off --write_settings_files=off timer -c timer
	@quartus_sta timer -c timer


programmer:
	@quartus_pgm -c usb-blaster -m jtag -o "p;output_files/timer.sof"
