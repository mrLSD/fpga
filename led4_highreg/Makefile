#
# Makefile
# @author Evgeny Ukhanov <mrlsd@ya.ru>
#

run:
	@iverilog -oled4_reg_test led4_reg_test.v && ./led4_reg_test

compile:
	@quartus_map --read_settings_files=on --write_settings_files=off led4_reg -c led4_reg

