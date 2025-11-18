# Prise en Main GDB 

## For AMR64

Les Registres principaux sont :
| x86_64 | ARM64 | Role                |
| ------ | ----- | ------------------- |
| `rbp`  | `x29` | Frame pointer       |
| `rsp`  | `sp`  | Stack pointer       |
| `rip`  | `pc`  | Instruction pointer |

## Compile : 

```bash
gcc -g -fno-stack-protector -z execstack -no-pie overflow.c -o overflow
```
`-g` for debug symbols.
`-fno-stack-protector` disables stack canaries (useful for overflow exercises).
`-z execstack` only if your exploit needs an executable stack (be careful).
`-no-pie` produces fixed virtual addresses (makes it easier to inspect sections). If you want to keep PIE, skip -no-pie (addresses will be randomized every run).


## GDB Commands

Start GDB with the binary, then add breakpoints on main and run the program :
```bash
gdb ./overflow
(gdb) break main
(gdb) run
```

To print the memory layout of the binary :
```bash
(gdb) info proc mappings
```

To inspect registers :
```bash
(gdb) info registers
```
To examine memory at a specific address (e.g., rbp -> x29 on ARM64) :
```bash
(gdb) info registers x29
```
