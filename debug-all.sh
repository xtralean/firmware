#!/bin/bash

READELF=arm-none-eabi-readelf
GDB=arm-none-eabi-gdb
COMMON_BUILD=~/Documents/spark/firmware/build
PLATFORM_ID=6
LTO=

function elf {
  echo $COMMON_BUILD/target/$1/platform-$PLATFORM_ID-m$LTO/$1.elf
}

SYSTEM_PART1_ELF=$(elf system-part1)
SYSTEM_PART2_ELF=$(elf system-part2)
USER_PART_ELF=$(elf user-part)

function text_section_address {
  $READELF $1 --headers | grep .text | head -n 1 | sed "s/.*PROGBITS *\\([^ ]*\\).*/0x\\1/"
}

SYSTEM_PART1_ADDRESS=$(text_section_address $SYSTEM_PART1_ELF)
SYSTEM_PART2_ADDRESS=$(text_section_address $SYSTEM_PART2_ELF)
USER_PART_ADDRESS=$(text_section_address $USER_PART_ELF)

$GDB \
  -ex "target remote localhost:3333" \
  -ex "set confirm off" \
  -ex "add-symbol-file $SYSTEM_PART1_ELF $SYSTEM_PART1_ADDRESS" \
  -ex "add-symbol-file $SYSTEM_PART2_ELF $SYSTEM_PART2_ADDRESS" \
  -ex "add-symbol-file $USER_PART_ELF $USER_PART_ADDRESS" \
  -ex "set confirm on"
