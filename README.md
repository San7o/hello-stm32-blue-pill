![](./stm-banner.jpeg)

Example projects for the STM32 "Blue Pill".

You may also be interested in:

- [hello-pico2](https://github.com/San7o/hello-pico2)
- [hello-esp32](https://github.com/San7o/hello-esp32)

## Info

- Model: STM32F030C8T6
- Core: Arm 32-bit Cortex-M0 CPU, 48 MHz
- Memories:
  - 16 to 256 Kbytes of Flash memory
  - 4 to 32 Kbytes of SRAM with HW parity
  -  CRC calculation unit
   -  Reset and power management
- Clock management:
  -  4 to 32 MHz crystal oscillator
  -  32 kHz oscillator for RTC with calibration
  -  Internal 8 MHz RC with x6 PLL option
  -  Internal 40 kHz RC oscillator
- Up to 55 fast I/Os
- 5-channel DMA controller
- One 12-bit, 1.0 μs ADC (up to 16 channels)
- 11 timers
- Communication interfaces:
  -  Up to two I2 C interfaces
  -  Up to six USARTs supporting master synchronous SPI and modem control; one
     with auto baud rate detection
  -  Up to two SPIs (18 Mbit/s) with 4 to 16 programmable bit frames

## Dependencies

```bash
sudo apt install gcc-arm-none-eabi stm32flash
```

## Usage

### st-link

You can run `make` inside each project to build the binary. To load it, you can
either use the st-link with:

```bash
make flash-link
```

### Uart

If you don't have the st-link (or it is broken), you can use UART to flash the
memory. You will need an UART-to-USB connector such as the FT232RL.

What you need to do is to connect the UART-to-USB unit to the UART1 ports in the
STM32 which are A9 (TX) and A10 (RX). Then when you want to load the binary you
will need to perform the following operation:

- remove the cap from the BOOT0 / BOOT1 yellow pins
- click the reset button in the board
- run `make flash-uart`
- click the reset button again
- put the cap back on

If you get `/dev/ttyUSB0: Permission denied` when you are accessing the tty, you
can check if the file is owned by a group and add yourself there:

```bash
sudo usermod -aG dialout $USER
```

You can also power the microcontroller via the UART-to-USB connector, but be
careful to use 3.3V. The setup would look like this:

![flash-uart-setup](./flash-uart-setup.jpg)
