#
# Makefile
# @author Evgeny Ukhanov <mrlsd@ya.ru>
#

compile:
	@quartus_map --read_settings_files=on --write_settings_files=off VGA -c vga

build:
	@quartus_map --read_settings_files=on --write_settings_files=off VGA -c vga
	@quartus_fit --read_settings_files=off --write_settings_files=off VGA -c vga
	@quartus_asm --read_settings_files=off --write_settings_files=off VGA -c vga
	@quartus_sta timer -c vga


programmer:
	@quartus_pgm -c usb-blaster -m jtag -o "p;output_files/vga.sof"
