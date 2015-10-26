#!/bin/bash

stty -f /dev/tty.usbmodemFD111 14400

cd main
make all program-dfu PARTICLE_DEVELOP=1 PLATFORM=photon USE_SWD_JTAG=y MODULAR=n
cd ..
