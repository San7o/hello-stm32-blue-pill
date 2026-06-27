# bare-metal

I want to write a basic HAL and standard library for the microcontroller just by
reading the datasheets, without using any generated boilerplate code

## Memory Map

Source: Chapter 5 of datasheet.

| Start      | End        | Type                            |
| ---------- | ---------- | ------------------------------- |
| 0x00000000 | 0x00040000 | Depends on BOOT configuration   |
| 0x00040000 | 0x08000000 | Reserved                        |
| 0x08000000 | 0x08040000 | Flash Memory                    |
| 0x08040000 | 0x1FFFEC00 | Reserved                        |
| 0x1FFFEC00 | 0x1FFFF800 | System Memory                   |
| 0x1FFFF800 | 0x1FFFFC00 | Option Bytes                    |
| 0x1FFFFC00 | 0x20000000 | Reserved                        |
| 0x20000000 | X          | SRAM                            |
| 0x40000000 | 0x480017FF | Peripherals                     |
| 0x480017FF | 0xE0000000 | Reserved                        |
| 0xE0000000 | 0xE0100000 | Cortex-M0 Internal peripherals  |
| 0xE0100000 | 0xFFFFFFFF | Reserved                        |

- At startup, the boot pin and boot selector option bit are used to select one
  of three boot options: user flash, system memory and embedded SRAM.
- `X` of SRAM depends on the particular device you have

In the peripherals section, we have:

| Start      | End        | Type     |
| ---------- | ---------- | -------- |
| 0x40000000 | 0x40008000 | APB      |
| 0x40008000 | 0x40010000 | Reserved |
| 0x40010000 | 0x40018000 | APB      |
| 0x40018000 | 0x40020000 | Reserved |
| 0x40020000 | 0x400243FF | AHB1     |
| 0x400143FF | 0x48000000 | Reserved |
| 0x48000000 | 0x480017FF | AHB2     |
