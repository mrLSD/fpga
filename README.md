# FPGA Research & Development

## Supported boards

- Altera devboard Cyclone IV E - `EP4CE10E22C8`
- Sipeed TangNano 9k

## Sipeed TangNano 9k

- Usefull getting started guides:
    - Sipeed [website]()
    - [Lushat Labs articles](https://learn.lushaylabs.com/getting-setup-with-the-tang-nano-9k/#creating-a-new-project)
- github examples:
    - https://github.com/lushaylabs/tangnano9k-series-examples
    - https://github.com/sipeed/TangNano-9K-example
- required: [OSS Cad Suite](https://github.com/YosysHQ/oss-cad-suite-build) or just install [Gowin EDA](https://www.gowinsemi.com/en/support/download_eda/).

### Altera Devboard

- Devboard: `Cyclone IV E EP4CE10E22C8`
- Quartus CAD required
FPGA project mostly base on Verilog or SystemVerilog. And implemented for Altera DevelopmentBoard with Quartus CAD.

#### Altera based projects

* **VGA** - output via VGA interfact to motinors. Can draw multy line text with specific fonts.
* **led4_highreg** - 12 LED circle sequence
* **timer** - onboard digital LED count down timer with ability set timer time. 
Digital LED and Keys used for I/O.

### LICENSE MIT
