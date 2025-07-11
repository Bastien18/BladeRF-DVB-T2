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

The reading part of the FIFO is similar in both case since we need to ask FIFO for a new word of data at a certain time.

Now, the writing part has to be adapted to feed TS byte correctly to the DVB-T2 core. 

#### TS adaptation explanation 

The DVB-T2 modulator documentation established that TS bytes must be inputed to the core this way:

![](./picture/Screenshot%202025-06-10%20185528.png)

Key points to respect:

1. Each 32bits words needs to be break down into 4bytes data
2. A high level on ts_data_valid input 1byte inside the core
3. The input byte rate is given by the ts_data_clk
4. The ts_data_busy signal indicates that the internal DVB-T2 core TS input FIFO is full and data must be stall

Additional points from documentation:

1. The first byte across TS interface can be any byte (no checking on overall stream sanity)
2. It's possible to set the core in order that it can accepts both 188bytes (standard) or 204bytes packets
3. The maximum ts_data_clk frequency is half the T2 core clock frequency otherway the ts_data_valid must be de-asserted after each clock cycle
4. There are usefull register indicating the status of the TS interface (0x8)

Points discovered from debugging:

1. In order to work correctly, the .ts file needs to be encoded at the bytrate that TS byte are feeded to the core i.e. if the muxrate of the ts file is 10Mbps ts_data_clk will be 1.25MHz. 
2. The ts_data_refclk just indicate the byterate that correspond to the TS output bit rate register. This the maximum rate before getting the ts_busy signal raising (indicating internal fifo is full).
3. The tx_fifo act as a clock separation. Which mean even if the stream doesn't have a stable bitrate we are able to provide the T2 core at a stable bitrate as long as the video stream fills up the fifo faster than the T2 consume the data.

#### Design of fifo2ts component

Inputs:

- 4 TS bytes from the tx_fifo i.e. a 32bits word from the fifo

Outputs:

- 1 byte of the tx_fifo word

Behaviour:

- fifo2ts component asks for a word from the fifo. Each byte from the word are feeded to the T2 core TS interface one after another using a 0 to 3 counter. It takes 4 clock cycle to feed the entire 32bits word. The read request for the next word is done during the third clock cycle in order to not interupt the continuity of the TS stream.



