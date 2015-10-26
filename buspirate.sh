#!/bin/bash

openocd -f /usr/local/share/openocd/scripts/interface/buspirate.cfg -f /usr/local/share/openocd/scripts/target/stm32f2x.cfg -c "gdb_port 3333" 