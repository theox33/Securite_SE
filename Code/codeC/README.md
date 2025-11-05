# Code C 

Code C pour les deux machines : 

```c
#include <stdio.h>

int main(void){
	printf("Hello world");
	return 0;
}
```

Compiled with gcc :

```bash
gcc -o hello hello.c
``` 

## Linux x86_64 (amd64)


## Linux (VM sur Mac) aarch64 (arm64)

Resultat du readelf pour l'exécutable C :

```bash
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Position-Independent Executable file)
  Machine:                           AArch64
  Version:                           0x1
  Entry point address:               0x680
  Start of program headers:          64 (bytes into file)
  Start of section headers:          68584 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         10
  Size of section headers:           64 (bytes)
  Number of section headers:         29
  Section header string table index: 28

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.bu[...] NOTE             0000000000000270  00000270
       0000000000000024  0000000000000000   A       0     0     4
  [ 2] .interp           PROGBITS         0000000000000294  00000294
       000000000000001b  0000000000000000   A       0     0     1
  [ 3] .gnu.hash         GNU_HASH         00000000000002b0  000002b0
       000000000000001c  0000000000000000   A       4     0     8
  [ 4] .dynsym           DYNSYM           00000000000002d0  000002d0
       00000000000000f0  0000000000000018   A       5     3     8
  [ 5] .dynstr           STRTAB           00000000000003c0  000003c0
       0000000000000094  0000000000000000   A       0     0     1
  [ 6] .gnu.version      VERSYM           0000000000000454  00000454
       0000000000000014  0000000000000002   A       4     0     2
  [ 7] .gnu.version_r    VERNEED          0000000000000468  00000468
       0000000000000030  0000000000000000   A       5     1     8
  [ 8] .rela.dyn         RELA             0000000000000498  00000498
       00000000000000c0  0000000000000018   A       4     0     8
  [ 9] .rela.plt         RELA             0000000000000558  00000558
       0000000000000078  0000000000000018  AI       4    22     8
  [10] .init             PROGBITS         00000000000005d0  000005d0
       000000000000001c  0000000000000000  AX       0     0     4
  [11] .plt              PROGBITS         00000000000005f0  000005f0
       0000000000000070  0000000000000000  AX       0     0     16
  [12] .text             PROGBITS         0000000000000680  00000680
       0000000000000148  0000000000000000  AX       0     0     64
  [13] .fini             PROGBITS         00000000000007c8  000007c8
       0000000000000018  0000000000000000  AX       0     0     4
  [14] .rodata           PROGBITS         00000000000007e0  000007e0
       0000000000000014  0000000000000000   A       0     0     8
  [15] .eh_frame_hdr     PROGBITS         00000000000007f4  000007f4
       000000000000003c  0000000000000000   A       0     0     4
  [16] .eh_frame         PROGBITS         0000000000000830  00000830
       00000000000000b4  0000000000000000   A       0     0     8
  [17] .note.ABI-tag     NOTE             00000000000008e4  000008e4
       0000000000000020  0000000000000000   A       0     0     4
  [18] .init_array       INIT_ARRAY       000000000001fdc8  0000fdc8
       0000000000000008  0000000000000008  WA       0     0     8
  [19] .fini_array       FINI_ARRAY       000000000001fdd0  0000fdd0
       0000000000000008  0000000000000008  WA       0     0     8
  [20] .dynamic          DYNAMIC          000000000001fdd8  0000fdd8
       00000000000001e0  0000000000000010  WA       5     0     8
  [21] .got              PROGBITS         000000000001ffb8  0000ffb8
       0000000000000030  0000000000000008  WA       0     0     8
  [22] .got.plt          PROGBITS         000000000001ffe8  0000ffe8
       0000000000000040  0000000000000008  WA       0     0     8
  [23] .data             PROGBITS         0000000000020028  00010028
       0000000000000010  0000000000000000  WA       0     0     8
  [24] .bss              NOBITS           0000000000020038  00010038
       0000000000000008  0000000000000000  WA       0     0     1
  [25] .comment          PROGBITS         0000000000000000  00010038
       000000000000001e  0000000000000001  MS       0     0     1
  [26] .symtab           SYMTAB           0000000000000000  00010058
       0000000000000858  0000000000000018          27    66     8
  [27] .strtab           STRTAB           0000000000000000  000108b0
       000000000000022f  0000000000000000           0     0     1
  [28] .shstrtab         STRTAB           0000000000000000  00010adf
       0000000000000103  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), p (processor specific)

There are no section groups in this file.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                 0x0000000000000230 0x0000000000000230  R      0x8
  INTERP         0x0000000000000294 0x0000000000000294 0x0000000000000294
                 0x000000000000001b 0x000000000000001b  R      0x1
      [Requesting program interpreter: /lib/ld-linux-aarch64.so.1]
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000904 0x0000000000000904  R E    0x10000
  LOAD           0x000000000000fdc8 0x000000000001fdc8 0x000000000001fdc8
                 0x0000000000000270 0x0000000000000278  RW     0x10000
  DYNAMIC        0x000000000000fdd8 0x000000000001fdd8 0x000000000001fdd8
                 0x00000000000001e0 0x00000000000001e0  RW     0x8
  NOTE           0x0000000000000270 0x0000000000000270 0x0000000000000270
                 0x0000000000000024 0x0000000000000024  R      0x4
  NOTE           0x00000000000008e4 0x00000000000008e4 0x00000000000008e4
                 0x0000000000000020 0x0000000000000020  R      0x4
  GNU_EH_FRAME   0x00000000000007f4 0x00000000000007f4 0x00000000000007f4
                 0x000000000000003c 0x000000000000003c  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x000000000000fdc8 0x000000000001fdc8 0x000000000001fdc8
                 0x0000000000000238 0x0000000000000238  R      0x1

 Section to Segment mapping:
  Segment Sections...
   00     
   01     .interp 
   02     .note.gnu.build-id .interp .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt .text .fini .rodata .eh_frame_hdr .eh_frame .note.ABI-tag 
   03     .init_array .fini_array .dynamic .got .got.plt .data .bss 
   04     .dynamic 
   05     .note.gnu.build-id 
   06     .note.ABI-tag 
   07     .eh_frame_hdr 
   08     
   09     .init_array .fini_array .dynamic .got 

Dynamic section at offset 0xfdd8 contains 26 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x000000000000000c (INIT)               0x5d0
 0x000000000000000d (FINI)               0x7c8
 0x0000000000000019 (INIT_ARRAY)         0x1fdc8
 0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
 0x000000000000001a (FINI_ARRAY)         0x1fdd0
 0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
 0x000000006ffffef5 (GNU_HASH)           0x2b0
 0x0000000000000005 (STRTAB)             0x3c0
 0x0000000000000006 (SYMTAB)             0x2d0
 0x000000000000000a (STRSZ)              148 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000000000015 (DEBUG)              0x0
 0x0000000000000003 (PLTGOT)             0x1ffe8
 0x0000000000000002 (PLTRELSZ)           120 (bytes)
 0x0000000000000014 (PLTREL)             RELA
 0x0000000000000017 (JMPREL)             0x558
 0x0000000000000007 (RELA)               0x498
 0x0000000000000008 (RELASZ)             192 (bytes)
 0x0000000000000009 (RELAENT)            24 (bytes)
 0x000000006ffffffb (FLAGS_1)            Flags: PIE
 0x000000006ffffffe (VERNEED)            0x468
 0x000000006fffffff (VERNEEDNUM)         1
 0x000000006ffffff0 (VERSYM)             0x454
 0x000000006ffffff9 (RELACOUNT)          4
 0x0000000000000000 (NULL)               0x0

Relocation section '.rela.dyn' at offset 0x498 contains 8 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000001fdc8  000000000403 R_AARCH64_RELATIV                    7a0
00000001fdd0  000000000403 R_AARCH64_RELATIV                    74c
00000001ffd8  000000000403 R_AARCH64_RELATIV                    7a8
000000020030  000000000403 R_AARCH64_RELATIV                    20030
00000001ffc0  000400000401 R_AARCH64_GLOB_DA 0000000000000000 _ITM_deregisterTM[...] + 0
00000001ffc8  000500000401 R_AARCH64_GLOB_DA 0000000000000000 __cxa_finalize@GLIBC_2.17 + 0
00000001ffd0  000600000401 R_AARCH64_GLOB_DA 0000000000000000 __gmon_start__ + 0
00000001ffe0  000800000401 R_AARCH64_GLOB_DA 0000000000000000 _ITM_registerTMCl[...] + 0

Relocation section '.rela.plt' at offset 0x558 contains 5 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000020000  000300000402 R_AARCH64_JUMP_SL 0000000000000000 __libc_start_main@GLIBC_2.34 + 0
000000020008  000500000402 R_AARCH64_JUMP_SL 0000000000000000 __cxa_finalize@GLIBC_2.17 + 0
000000020010  000600000402 R_AARCH64_JUMP_SL 0000000000000000 __gmon_start__ + 0
000000020018  000700000402 R_AARCH64_JUMP_SL 0000000000000000 abort@GLIBC_2.17 + 0
000000020020  000900000402 R_AARCH64_JUMP_SL 0000000000000000 printf@GLIBC_2.17 + 0

The decoding of unwind sections for machine type AArch64 is not currently supported.

Symbol table '.dynsym' contains 10 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 00000000000005d0     0 SECTION LOCAL  DEFAULT   10 .init
     2: 0000000000020028     0 SECTION LOCAL  DEFAULT   23 .data
     3: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND _[...]@GLIBC_2.34 (2)
     4: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_deregisterT[...]
     5: 0000000000000000     0 FUNC    WEAK   DEFAULT  UND _[...]@GLIBC_2.17 (3)
     6: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
     7: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND abort@GLIBC_2.17 (3)
     8: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_registerTMC[...]
     9: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND printf@GLIBC_2.17 (3)

Symbol table '.symtab' contains 89 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 0000000000000270     0 SECTION LOCAL  DEFAULT    1 .note.gnu.build-id
     2: 0000000000000294     0 SECTION LOCAL  DEFAULT    2 .interp
     3: 00000000000002b0     0 SECTION LOCAL  DEFAULT    3 .gnu.hash
     4: 00000000000002d0     0 SECTION LOCAL  DEFAULT    4 .dynsym
     5: 00000000000003c0     0 SECTION LOCAL  DEFAULT    5 .dynstr
     6: 0000000000000454     0 SECTION LOCAL  DEFAULT    6 .gnu.version
     7: 0000000000000468     0 SECTION LOCAL  DEFAULT    7 .gnu.version_r
     8: 0000000000000498     0 SECTION LOCAL  DEFAULT    8 .rela.dyn
     9: 0000000000000558     0 SECTION LOCAL  DEFAULT    9 .rela.plt
    10: 00000000000005d0     0 SECTION LOCAL  DEFAULT   10 .init
    11: 00000000000005f0     0 SECTION LOCAL  DEFAULT   11 .plt
    12: 0000000000000680     0 SECTION LOCAL  DEFAULT   12 .text
    13: 00000000000007c8     0 SECTION LOCAL  DEFAULT   13 .fini
    14: 00000000000007e0     0 SECTION LOCAL  DEFAULT   14 .rodata
    15: 00000000000007f4     0 SECTION LOCAL  DEFAULT   15 .eh_frame_hdr
    16: 0000000000000830     0 SECTION LOCAL  DEFAULT   16 .eh_frame
    17: 00000000000008e4     0 SECTION LOCAL  DEFAULT   17 .note.ABI-tag
    18: 000000000001fdc8     0 SECTION LOCAL  DEFAULT   18 .init_array
    19: 000000000001fdd0     0 SECTION LOCAL  DEFAULT   19 .fini_array
    20: 000000000001fdd8     0 SECTION LOCAL  DEFAULT   20 .dynamic
    21: 000000000001ffb8     0 SECTION LOCAL  DEFAULT   21 .got
    22: 000000000001ffe8     0 SECTION LOCAL  DEFAULT   22 .got.plt
    23: 0000000000020028     0 SECTION LOCAL  DEFAULT   23 .data
    24: 0000000000020038     0 SECTION LOCAL  DEFAULT   24 .bss
    25: 0000000000000000     0 SECTION LOCAL  DEFAULT   25 .comment
    26: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS Scrt1.o
    27: 0000000000000680     0 NOTYPE  LOCAL  DEFAULT   12 $x
    28: 0000000000000844     0 NOTYPE  LOCAL  DEFAULT   16 $d
    29: 00000000000008e4     0 NOTYPE  LOCAL  DEFAULT   17 $d
    30: 00000000000008e4    32 OBJECT  LOCAL  DEFAULT   17 __abi_tag
    31: 00000000000007e0     0 NOTYPE  LOCAL  DEFAULT   14 $d
    32: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crti.o
    33: 00000000000006b4     0 NOTYPE  LOCAL  DEFAULT   12 $x
    34: 00000000000006b4    20 FUNC    LOCAL  DEFAULT   12 call_weak_fn
    35: 00000000000005d0     0 NOTYPE  LOCAL  DEFAULT   10 $x
    36: 00000000000007c8     0 NOTYPE  LOCAL  DEFAULT   13 $x
    37: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtn.o
    38: 00000000000005e0     0 NOTYPE  LOCAL  DEFAULT   10 $x
    39: 00000000000007d4     0 NOTYPE  LOCAL  DEFAULT   13 $x
    40: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
    41: 00000000000006e0     0 NOTYPE  LOCAL  DEFAULT   12 $x
    42: 00000000000006e0     0 FUNC    LOCAL  DEFAULT   12 deregister_tm_clones
    43: 0000000000000710     0 FUNC    LOCAL  DEFAULT   12 register_tm_clones
    44: 0000000000020030     0 NOTYPE  LOCAL  DEFAULT   23 $d
    45: 000000000000074c     0 FUNC    LOCAL  DEFAULT   12 __do_global_dtors_aux
    46: 0000000000020038     1 OBJECT  LOCAL  DEFAULT   24 completed.0
    47: 000000000001fdd0     0 NOTYPE  LOCAL  DEFAULT   19 $d
    48: 000000000001fdd0     0 OBJECT  LOCAL  DEFAULT   19 __do_global_dtor[...]
    49: 00000000000007a0     0 FUNC    LOCAL  DEFAULT   12 frame_dummy
    50: 000000000001fdc8     0 NOTYPE  LOCAL  DEFAULT   18 $d
    51: 000000000001fdc8     0 OBJECT  LOCAL  DEFAULT   18 __frame_dummy_in[...]
    52: 0000000000000858     0 NOTYPE  LOCAL  DEFAULT   16 $d
    53: 0000000000020038     0 NOTYPE  LOCAL  DEFAULT   24 $d
    54: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS hello.c
    55: 00000000000007e8     0 NOTYPE  LOCAL  DEFAULT   14 $d
    56: 00000000000007a8     0 NOTYPE  LOCAL  DEFAULT   12 $x
    57: 00000000000008c0     0 NOTYPE  LOCAL  DEFAULT   16 $d
    58: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS crtstuff.c
    59: 00000000000008e0     0 NOTYPE  LOCAL  DEFAULT   16 $d
    60: 00000000000008e0     0 OBJECT  LOCAL  DEFAULT   16 __FRAME_END__
    61: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS 
    62: 000000000001fdd8     0 OBJECT  LOCAL  DEFAULT  ABS _DYNAMIC
    63: 00000000000007f4     0 NOTYPE  LOCAL  DEFAULT   15 __GNU_EH_FRAME_HDR
    64: 000000000001ffb8     0 OBJECT  LOCAL  DEFAULT  ABS _GLOBAL_OFFSET_TABLE_
    65: 00000000000005f0     0 NOTYPE  LOCAL  DEFAULT   11 $x
    66: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_mai[...]
    67: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_deregisterT[...]
    68: 0000000000020028     0 NOTYPE  WEAK   DEFAULT   23 data_start
    69: 0000000000020038     0 NOTYPE  GLOBAL DEFAULT   24 __bss_start__
    70: 0000000000000000     0 FUNC    WEAK   DEFAULT  UND __cxa_finalize@G[...]
    71: 0000000000020040     0 NOTYPE  GLOBAL DEFAULT   24 _bss_end__
    72: 0000000000020038     0 NOTYPE  GLOBAL DEFAULT   23 _edata
    73: 00000000000007c8     0 FUNC    GLOBAL HIDDEN    13 _fini
    74: 0000000000020040     0 NOTYPE  GLOBAL DEFAULT   24 __bss_end__
    75: 0000000000020028     0 NOTYPE  GLOBAL DEFAULT   23 __data_start
    76: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
    77: 0000000000020030     0 OBJECT  GLOBAL HIDDEN    23 __dso_handle
    78: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND abort@GLIBC_2.17
    79: 00000000000007e0     4 OBJECT  GLOBAL DEFAULT   14 _IO_stdin_used
    80: 0000000000020040     0 NOTYPE  GLOBAL DEFAULT   24 _end
    81: 0000000000000680    52 FUNC    GLOBAL DEFAULT   12 _start
    82: 0000000000020040     0 NOTYPE  GLOBAL DEFAULT   24 __end__
    83: 0000000000020038     0 NOTYPE  GLOBAL DEFAULT   24 __bss_start
    84: 00000000000007a8    32 FUNC    GLOBAL DEFAULT   12 main
    85: 0000000000020038     0 OBJECT  GLOBAL HIDDEN    23 __TMC_END__
    86: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND _ITM_registerTMC[...]
    87: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND printf@GLIBC_2.17
    88: 00000000000005d0     0 FUNC    GLOBAL HIDDEN    10 _init

Version symbols section '.gnu.version' contains 10 entries:
 Addr: 0x0000000000000454  Offset: 0x00000454  Link: 4 (.dynsym)
  000:   0 (*local*)       0 (*local*)       0 (*local*)       2 (GLIBC_2.34) 
  004:   1 (*global*)      3 (GLIBC_2.17)    1 (*global*)      3 (GLIBC_2.17) 
  008:   1 (*global*)      3 (GLIBC_2.17) 

Version needs section '.gnu.version_r' contains 1 entry:
 Addr: 0x0000000000000468  Offset: 0x00000468  Link: 5 (.dynstr)
  000000: Version: 1  File: libc.so.6  Cnt: 2
  0x0010:   Name: GLIBC_2.17  Flags: none  Version: 3
  0x0020:   Name: GLIBC_2.34  Flags: none  Version: 2

Displaying notes found in: .note.gnu.build-id
  Owner                Data size 	Description
  GNU                  0x00000014	NT_GNU_BUILD_ID (unique build ID bitstring)
    Build ID: 2f1eebd4c3007074dbce5124423e9641fd9cedbc

Displaying notes found in: .note.ABI-tag
  Owner                Data size 	Description
  GNU                  0x00000010	NT_GNU_ABI_TAG (ABI version tag)
    OS: Linux, ABI: 3.7.0
          
```
