# Bash configuration

A simple configuration file for Bash, compatible with Linux, macOS and BSD.

## Prerequisites

- Bash
- Git

## Installation

```
$ cp bash/.bashrc ~
$ cd
$ ln -s .bashrc .profile
$ . ~/.bashrc
```

## Usage

Aliases:

- `ls` - list directories with hidden files, file types, colorized output, and
  SI (binary) units for file size
- `ll` - lists in long format
- `le` - lists with extended attributes (useful on macOS)
- `mkdir` - creates missing subdirectories
- `df` - shows free space on storage devices in SI (binary) units
- `grep` - colorized output
- `grp` - grep recursively, show line number, ignore case (useful for code)
- `reload` - source the .bashrc again and reconfigure Bash
- `myip` - shows the IP address as seen from outside NAT
- `lsn` - shows which program is listening on which port
- `weather` - shows weather for the current location (according to IP address)

Functions:

- `calc` - uses `bc` for quick calculations, including square root: `sqrt()`
- `man` - shows manual pages in color
