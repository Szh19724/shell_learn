# 第3章 标准IO

> 本章整理自 `3.标准IO二.pdf` 第 20–24 页；另含第 25 页顶部的续接代码段（内容对应原始 `2.标准IO.pdf`）。返回 [[00-文件IO目录|📑 文件IO目录]]。

## 本章要点

- 系统 IO 接口因平台而异、可移植性差；标准 IO 用 `FILE` 结构体（含读/写缓冲区）统一了文件操作接口。
- 文件分文本文件（按 ASCII 解析）与二进制文件（按特定格式解析）；标准 IO 以缓冲换效率。
- 缓冲三类型：行缓冲（如 `printf`，遇 `\n` 或程序正常退出时同步）、全缓冲（满了才同步）、无缓冲（即到即同步）；默认大小约 1024 / 4096 / 1，可用 `setbuf`、`setvbuf` 设置。
- 标准 IO 自动打开三个标准流：`stdin`（键盘）、`stdout`（终端）、`stderr`（终端，无缓冲）。
- `fopen / fclose` 管理文件流，打开模式 r/w/a 与 `+` 组合决定读写与定位位置。
- 读写三种粒度：字符级 `fgetc/fputc`、行级 `fgets/fputs`、块级 `fread/fwrite`（返回值为实际读写的对象个数）。

## 标准 IO

为什么要使用标准 IO ？

我们是知道系统 IO 是挺好用。因为在不同操作系统下面，对文件一些管理和`API` 接口都是不一样的。

Linux ：`open read write close...`

- `APP ->struct file ->struct inode -> 物理层 inode-> 文件内容`

Window ：`winopen 、 winread...`

同一个文件，在不同的操作系统下面， 操作文件的代码其实不一样的。

C 几乎支持所有的操作系统、操作文件（系统 IO ）可移植性**非常差**

SO ， C/C++ 语言标准委员会，认为自己有责任搞一波操作，来一统江湖。指定 / 统一文件操作的接口 ---->**标准 IO**

### 标准IO ： IO 流 ( 文件 )

主要就是统一了文件以及常用的接口函数

**文件**：普通文件、二进制文件（**不包含设备文件**）

- **文本文件**：无组织、无格式的文件、以字符的 ASCII 来解析文件。
  - `.cpp 、 .c 、 .txt 、 .cs 、 .html 、 .java 、 .py...`
- **二进制文件**：有特定格式的文件
  - 需要按照特定的文件格式解析
  - 某一些字节可能代表特殊含义
  - `.exe 、 .out 、 .apk 、 .jpg 、 .mp4 、 .doc 、 .xls...`

**在标准库中，用结构体 FILE 描述一个文件，然后在这个结构体中创建两个缓冲区：**

- **读缓冲区**
- **写缓冲区**

```c
FILE
{
    char *in;   //  指向读的缓冲区
    char *out ; //  指向写的缓冲区
    ...
};
```

对于文件操作的函数接口：

- `fopen,fclose,fread,fwrite,fseek...`
- `puts,fputs`
- `scanf,...`
- `printf,...`

### APP 通过标准 IO 操作文件流程：

- code( 代码 )--> 标准 IO 库 --> 对应应用平台的操作**系统 IO**--> 操作系统内核 -->Hardware( 硬件 )

*in 读缓冲区 *out 写缓冲区

**标准 IO 带缓冲的 IO ， IO 流（ stream ）它的效率比系统 IO 高原因：**

- **系统 IO ：读一个字节，从硬盘上去取一个下来**
- **标准 IO ：读一个字节，从硬盘上去取一块内容下落，放到标准 IO 的缓冲区**

### 缓冲：同步问题

缓冲区的数据，什么时候才会同步外设（硬件）上面？

**标准 IO 缓冲区有三种类型：**

- **行缓冲**：缓冲区数据只要达到一行了就会同步到外设（硬盘）上面。假设一行最多 80 字节，当一行满了 80 字节或者遇到`\n` 的时候就会把缓冲区的数据同步到外设上。
  - `printf` : 行缓冲
  - 当一行数据满了就同步。
  - 一行没满，但是遇到换行符也同步。
  - 当一行没满，也没有换行符，程序在正常退出的时候也会同步。
- **全缓冲**：只有当缓冲区的数据满了之后，才会同步到外设上面。
- **无缓冲：**只要缓冲区有一个字节，就会同步到外设上。

**缓冲区到底有多大**？

- 默认全缓冲的大小为 4096
- 默认行缓冲是 1024
- 无缓冲的大小为 1

在 `linux` 下缓冲区我们可以自己进行设置：`setbuf` 、`setvbuf`

```c
int setvbuf (FILE *stream , char *buf , int mode , size_t size );
/*
    @ 描述：
         更改缓冲区策略
    @stream ：
         需要更改的输入 / 输出流
    @buf ：
         缓冲区指针
    @mode ：
         缓冲区类型
    @size ：
         缓冲区大小
*/
```

在标准 IO 库下面，系统会为程序自动打开**三个标准 IO 流 ( 文件 )**

- 标准输入流 :`FILE *stdin`
  - `stdin` 是定义在 `stdio` /`cstdio` 里面的一个全局变量，它指向标准输入设备（一般是键盘）`scanf`
- 标准输出流： `FILE *stdout`
  - `stdout` 是定义在`stdio` /`cstdio` 里面的一个全局变量，它指向标准输出设备（一般是终端）`printf`
- 标准出错流： `FILE *stderr`
  - `stderr` 是定义在`stdio` /`cstdio` 里面的一个全局变量，它指向标准出错设备（一般是终端）`perror`

## 标准 IO 的API 接口

### 打开和关闭一个文件流

```c
FILE *fopen (const char * __filename , const char * __modes )
/*
    @ 描述：
         打开一个文件流
    @filename ：
         需要打开的文件名字（可以包含路径）
    @modes ：
         打开文件的方式：
         r      打开文本文件，用于读。流被定位于文件的开始。

         r+     打开文本文件，用于读写。流被定位于文件的开始。

         w      将文件长度截断为零，或者创建文本文件，用于写。流被定位于
               文件的开始。

         w+     打开文件，用于读写。如果文件不存在就创建它，否则将截断
               它。流被定位于文件的开始。

         a      打开文件，用于追加     ( 在文件尾写 ) 。如果文件不存在就创建
               它。流被定位于文件的末尾。

         a+     打开文件，用于追加     ( 在文件尾写 ) 。如果文件不存在就创建
               它。读文件的初始位置是文件的开始，但是输出总是被追加到文
               件的末尾。
    返回值：
         成功返回，打开的文件的指针 FILE*
         失败返回 NULL ，同时 errno 被设置
*/

int fclose (FILE *stream );
/*
    作用：
         关闭一个文件流
    stream ：
         需要关闭的文件流指针
    返回值：
         成功返回 0
         失败返回 EOF ，同时 errno 被设置
*/
```

### 读写操作

- 每次读一个字节
  - `fget getc getchar`

```c
         #include <stdio.h>

         int fgetc (FILE *stream );
         /*
              作用：
                  fgetc 用来从 stream 指定的那个文件流中读取一个字符，并把读取到的字符的 ASCII 码
         返回
              stream ：
                  需要获取字符的文件流指针
              返回值：
                  成功返回字符的 ASCII 码
                  失败返回 EOF ，同时 errno 被设置
         */
```

- 每次写入一个字节
  - `fputc/putc/putchar....`

```c
         #include <stdio.h>

         int fputc (int c, FILE *stream );
         /*
              作用：
                  把 c 指定的字符输出到 stream 指定的那个文件流中
              c ：
                  需要输出到文件流的字符的 ASCII 码
              stream ：
                  指定输出的那个文件流指针
              返回值：
                  成功返回字符的 ASCII 码
                  失败返回 EOF ，同时 errno 被设置
         */
```

- 每次读取一行字符
  - `fgets`

```c
         #include <stdio.h>

         char *fgets (char *s, int size , FILE *stream );
         /*
              作用：
                  从文件流指针对应的那个文件中获取一行字符。
              s ：
                  指向的空间是用来保存从文件流中获取到的字符串的。
              size ：
                  最多获取多少个字节，一般 size 为 s 指向的空间的可用长度
              stream ：
                  表示从哪个文件中获取
              返回值：
                  成功返回 s 的首地址
                  失败返回 NULL ，同时 errno 被设置
         */
```

- `fgets` 输入结束两种情况
- 遇见了 \n 或者文件结束了
- 已经获取到了 size-1 个字符（后面要预留 \0 的位置）
- 每次输出一段字符串
  - `fputs`

```c
         #include <stdio.h>

         int fputs (const char *s, FILE *stream );
         /*
              作用：
                  用来把 s 指向的字符串，输出到标准输出流 (stdout)
              s ：
                  需要输出到标准输出流的字符串指针
              stream ：
                  需要输出字符串的文件流指针
              返回值：
                  成功返回非负数
                  失败返回 EOF ，同时 errno 被设置
         */
```

- `puts 和 fputs 区别`
- `fputs` 可以指定输出到某个 stream 中去， puts 只能输出到`stdout` 中
- `fputs` 没有默认输出 \n ， puts 是有默认 \n 的

### 直接读写

想操作几个字符就操作几个字符

- `fread` 、`fwrite`

`fread` 读取

```c
#include <stdio.h>

size_t fread (void *ptr , size_t size , size_t nmemb , FILE *stream );
/*
    作用：
         从文件流中读取 size 个字节的数据
    ptr ：
         读取到的数据所保存的空间首地址
    size ：
         单个对象（元素的大小）大小
    nmemb ：
         读取对象的个数，次数
    stream ：
         需要读取数据的文件流
    返回值：
         成功返回，实际读取到的对象个数！！！  < === nmemb
         失败返回 EOF ，同时 errno 被设置
*/
```

`fwrite` 写入

```c
#include <stdio.h>

size_t fwrite (const void *ptr , size_t size , size_t nmemb ,FILE *stream );
/*
    作用：
         往文件流中写入数据
    ptr ：
         需要写入文件流的数据空间的首地址
    size ：
         单个对象（元素的大小）大小
    nmemb ：
         读取对象的个数，次数
    stream ：
         需要写入数据的文件流
    返回值：
         成功返回，实际读取到的对象个数！！！  < === nmemb
         失败返回 EOF ，同时 errno 被设置
         EOF ====>  End Of File
*/
```
