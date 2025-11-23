# Method to bypass the password on the ESP8266


## Methods :

1. Brute force the password, since the MCU is a ESP8266, the password is likely short du to memory constraints.
2. Dump the firmware of the ESP8266 with offficial tools and look for symbols in the firmware.
3. Look on the other Interface of the ESP8266 (like other serial UART) to see if any are open or if there is a debug interface.


## Application of methods 2

1. Download the firmware of the ESP8266 with esptool.py

```bash
esptool read-flash 0 0x200000 flash_contents.bin 
```

2. Analyze the firmware with esptool to gather more information about the firmware. *(optional)*

```bash
esptool --chip esp8266 image_info ./flash_contents.bin
```

3. Use strings to look for interesting symbols in the firmware. *(We know that the password contain "ZI")*

```bash
strings ./flash_contents.bin | grep "ZI"
```