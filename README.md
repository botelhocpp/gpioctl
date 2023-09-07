# CPIO Control

A Linux command line interface to control the GPIO Header pins of the Raspberry Pi, using sysfs.

# How to use

The command takes a action and the pin the action takes place.

```bash
gpioctl [action] [pin]
```

The current supported actions are:

- **set**: Set the GPIO pin to high.
- **clr**: Clear the GPIO pin (set to low).
- **tgl**: Toggle the GPIO level.

The pins range from 0 to 57.

To set the pin 21 of the GPIO Header, use:

```bash
gpioctl set 21
```

To clear it:

```bash
gpioctl clr 21
```

The --help command can be used to get the list of available commands. 

# The Software

The code was entirely implemented in Assembly language, for the Linux OS (more specifcally, the 64-bit version of the Raspberry Pi OS, or Raspbian). This programm has the purpose of being a tool to control the GPIO via command line.

# The Hardware

The Raspberry Pi 4B, with 64-bit Raspberry Pi OS, was used to test and deploy the code.
