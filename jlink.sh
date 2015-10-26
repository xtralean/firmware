#!/bin/bash

openocd -f /usr/local/share/openocd/scripts/interface/jlink.cfg -f /usr/local/share/openocd/scripts/target/stm32f2x.cfg  -c "gdb_port 3333" -c "\$_TARGETNAME configure -rtos FreeRTOS"
