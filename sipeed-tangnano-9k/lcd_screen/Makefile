BOARD=tangnano9k
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5

all: clean app.fs

# Synthesis
app.json: top.v lcd_ctrl.v lcd_data.v gowin_rpll/gowin_rpll.v
	yosys -p "read_verilog lcd_ctrl.v lcd_data.v top.v gowin_rpll/gowin_rpll.v; synth_gowin -top top -json app.json"

# Place and Route
app_pnr.json: app.json
	nextpnr-gowin --json app.json --write app_pnr.json --freq 27 --device ${DEVICE} --family ${FAMILY} --cst ${BOARD}.cst

# Generate Bitstream
app.fs: app_pnr.json
	gowin_pack -d ${FAMILY} -o app.fs app_pnr.json

# Program Board
load: app.fs
	openFPGALoader -b ${BOARD} app.fs -f

# Generate Simulation
screen_test.o: app.v app_tb.v
	iverilog -o app_test.o -s test app.v app_tb.v

# Run Simulation
test: app_test.o
	vvp app_test.o

# Cleanup build artifacts
clean:
	@rm app.json app.fs app_test.o app.vcd ]] true

.PHONY: load clean test
.INTERMEDIATE: app_pnr.json app.json app_test.o
