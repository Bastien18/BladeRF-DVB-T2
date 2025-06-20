# Commsonic DVB-T2 modulator troubleshooting

## Abstract

This documents aims to retrace all actions taken in order to succeed the integration of the DVB-T2 modulator core from Commsonic Ltd inside the bladeRF 2.0 micro Cyclone V FPGA logic.

## Initial architecture of the bladeRF 2.0 micro

Here is the architecture of the bladerf-hosted revision. It's the one that has been used as reference for the integration of the T2 core. This is the official block scheme from [nuand github documentation](https://github.com/Nuand/bladeRF/wiki/FPGA-Development). However, this one is outdated since the bladeRF 2.0 micro has an AD9361 radio transciever instead of the LMS6002D and a softcore takes place at the end of the FPGA towards the AD9361.

![](./picture/Screenshot%202025-06-02%20092145.png)

## DVB-T2 core integration

The TX flow only will be modified. Here is a rough block scheme of the TX data flow:

![](./picture/Screenshot%202025-06-02%20144840.png)

## Architecture description

The whole architecture can be separated into three block which are:

1. Input buffering and TS adaptation
2. DVB-T2 modulation
3. I/Q samples processing for AD9361

## Input buffering and TS adaptation
### FX3 gpif

This block interface the data coming from the Cypress FX3 chip on the board to the FIFO buffering stage that comes next. This block does not require any changement. 

When data are sent in a binary format from the host computer via the bladeRF-cli application, those ones arrives on this first block and then will fill the FIFO buffering stage.

FX3_GPIF is clocked by a 100MHz clock => fx3_pclk_pll.

### TX FIFO

This block serves to buffer data coming from the FX3.

FIFO characteristics:
- 16384 words
- 32bits long word
- Dual clock domain => rclock and wclock

The FIFO can actually separate two different clock domain. For now, the clock domain separation happens in the FIFO READER block. 

Write clock => fx3_pclk_pll running at 100MHz
Read clock => t2_clock_s running at 73.142857MHz

For this part I didn't modify anything except for the writing and reading clock. For now since the video is still pausing it's possible that having those two separate clock can cause issue at the T2 core TS interface.  

### FIFO READER & TS adaptation

The purpose of this block is to read words from the previous FIFO and feed them to the T2 core TS interface at the correct rate.

Initially, the bladeRF FPGA logic was meant to store directly I/Q sample inside the FIFO coming from FX3_GPIF. The modulation happened outside the bladeRF platform and I/Q samples were stored in .sc16q11 file. Then the host was able to start the transmission of the whole .sc16q11 file to the bladeRF platform via the bladeRF-cli application. 

Now the modulation happens inside the bladeRF FPGA logic. We are transmitting TS packet directly to the FX3_GPIF that stores them inside the FIFO.

The reading part of the FIFO is similar in both case since we need to ask FIFO for a new word of data at a certain time. It's how 





