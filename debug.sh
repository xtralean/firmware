#!/bin/bash

arm-none-eabi-gdb -ex "target remote localhost:3333" build/target/main/platform-6/main.elf

