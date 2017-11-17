# Timer

Count down timer with ability set timer count down time.
Digital LED and Keys used for I/O.

### I/O
* Inputs: clk, rst

### Useful commands
* `make` - run with Icarus Verilog
* `make compile` - compile with  quartus_map 
* `make build` - build all project 
* `make programmer` - proggramming FPGA device

### Troubleshooting
* `quartus_pgm -c usb-blaster` - if device as `usb-blaster` not found, you can chekd device via: `quartus_pgm -l` and set for example `quartus_pgm -c "USB-Blaster [2-1.3.2]"`
* `jtagconfig` - will show is **USB-Blaster** recognized. If **USB-Blaster** not found you should restart `jtagd`.
* How to restart `jtagd`. ps aux | grep jtagd. And kill `jtagd` process: kill -9 <pid> and start `jtagd` again.
* If `jtagconfig` still can't recognize **USB-Blaster**, it's possbile that `jtagd` started under root. How to fix: http://www.fpga-dev.com/altera-usb-blaster-with-ubuntu/
* Most useful to create `jtagd` service: `/etc/init.d/jtagd`. And it containt script:
```
#! /bin/sh
### BEGIN INIT INFO
# Provides: Looker
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Looker
# Description: Looker
### END INIT INFO

QUARTUS_DIR=/mnt/c77cae9b-b5d9-4bc7-a7bd-4bf8e9ffa096/home/evgeny/dev/quartus

case "$1" in
 start)
   $QUARTUS_DIR/bin/jtagd
   ;;
 stop)
   killall -9 jtagd
   sleep 10
   ;;
 restart)
   killall -9 jtagd
   sleep 20
   $QUARTUS_DIR/bin/jtagd
   ;;
 *)
   log_failure_msg "Usage: $0 {start|stop|restart"
   exit 3
   ;;
esac
```
