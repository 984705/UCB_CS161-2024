## Main Idea

这里利用的是读后写漏洞。函数`read_file`首先会检查文件是否过大，否则直接放弃读写。攻击者一开始先写一个空文件，等到检查通过以后，再向文件中写入payload。

## Magic Numbers

不赘述

## Exploit Structure

不赘述

## Exploit GDB Output

不赘述