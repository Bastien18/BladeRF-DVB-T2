
## Hardware design

### Commsonic

Need to specify how to feed data through Transport Stream interface. Commsonic IP core clock schould be minimum 69MHz since we're in 4k/8k max fft size and internal fft RAM config. See p.14 of s00080 datasheet. Raspberry pi SPI clock frequency could go up to 50MHz but it wouldn't keep up with the IP core.

### Copy Analog Device ADALM PLUTO

Using an SoC ARM cortex A9.

Comparison to a raspberry pi 4b:
	- Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.8GHz
	- Single-core ARM® Cortex™-A9 MPCore™ 667 MHz
#### Other analog device related stuff

Install adalm pluto drivers : [https://wiki.analog.com/university/tools/pluto/drivers/linux](https://wiki.analog.com/university/tools/pluto/drivers/linux)

Made some performance test from host to ADALM PLUTO

## Synthesize bladeRF

BladeRF can be synthetize using the script and the README.md file. Howeverr to synthetize for a bladeRF-micro you need to do the following:

- Make sure the repo has been cloned recursively.
- Go to [bladeRF/thirdparty/analogdevicesinc/no-OS]() and checkout to 0bba46e commit.
- Transform the following in [bladeRF/hdl/fpga/ip/analogdevicesinc/no_OS/CMakeLists.txt]()

```
        COMMAND ${Patcher_EXECUTABLE} -p3
to:
        COMMAND ${Patcher_EXECUTABLE} -p3 --binary -l
```

### Adapt to cyclone 10

The system_pll and fx3_pll needs to be regenerated for cyclone 10. Choose the altpll ip core for both.

Settings are:
system_pll => 38.4MHz input, 1 output 80MHz with a locked output
fx3_pll => 100MHz input, 1 output 100MHz with a locked output

Change both pll in the top design => entity work.<pll_name>

Add both .qip pll to the projects files.

Then change the .qsf file since fitter accept to compile the project (just comment out lines making error).

### Implement Commsonic DVB-T2 IP core inside BladeRF FPGA logic

Installing the commsonic folder to C:\intelFPGA\17.1\ip

For the license specify the floating license of the school with '<'port>@'<'hostname> and the commsonic file local location separated with a ";" character. The commsonic file must only contain the FEATURE paragraphe. Next time be aware to give the host NIC ID in the license setup window => the first number appearing in the Network interface Card field.

Include all the vhd submodule and top level vhd files.

To install the usb blaster driver letting dev program the cyclone V with a time_limited .sof file. The dev needs to turn off memory integrity feature located under core isolation in device security parameter. The he can install the driver located under the intelFPGA/17.1/quartus/driver/

In order to flash the board correctly. You need to get the rbf bitstream on this website https://www.nuand.com/fpga_images/ and load it first into the fpga using the ```bladeRF-cli -L path_to_rbf_file```commande. This command will load the bitstream into the fpga flash memory once and allow us to use quartus programmer to flash our custom .sof file. User need to launch the bladeRF-cli in interactive mode to have the fpga logic running.

### Trouble having output using only TS interface
Sending data through fx3 USB doesn't give anything on the output baseband_i and q of the T2 core. 

Then I try using the vhdl code given in the documentation. This code start the packet with the starting byte and then pads it with null byte in order to complete the 188byte packet. Still get 0 on output.

Tried measuring the tx_clock used for the ts_data_clock => get ~61MHz and signal seems OK (I was measuring wrong on the signal tap because the sample frequency wasn't high enough => Nyquist).

In the IP core component editor, we can configure clock frequency of the T2 core. By default, the frequency is 100MHz. I tried to change the core clock freq to fx3_pclk_clk instead of tx_clock since tx_clock is 60MHz. But I didn't get anything on the output.

#### SOLUTION
Commsonic gaves us a config file p_cms0041_config.vhd which contains the commands to init the core properly and outputing data. Which means the TS interface don't need to be wired to anything. We must set "Enable register-bank initialisation engine" in the T2 core component editor GUI.

They also gaves us a blockRAM VHDL implementation which will be wired to the TITL DDR RAM interface. This RAM is working at the same clocking frequency than the core which is 100MHz.The blockRAM VHDL component is described here [blockRAM.vhd](../hdl/quartus/work/bladerf-micro-A9-dvbt2/blockRAM/blockRAM.vhd)

Since we don't use external RAM for the OSG interface (in charge of the fft), we need to set the "Internal OSG memory" option in the T2 core component editor GUI. This means we need to had a secondary clock to the T2 component (clock_x2) that has twice the frequency of the main clock frequency of the core.

![](./picture/photo_2025-03-12_16-30-17.jpg)

### Project follow up (No more relevant)

For now on I'm experimenting on the ADALM PLUTO to see how we can interact with it. I need to check:

If we have sufficient bandwith in input
If the cortex A9 is as powerfull as a raspberry 4

ADALM pluto SoC FPGA isn't resource sufficient so we switch to the bladeRF dev kit board with a cyclone V fpga




