# 第4章 标准IO二

> 本章整理自 `3.标准IO二.pdf` 第 25–30 页（内容对应原始 `3.标准IO二.pdf`）。返回 [[00-文件IO目录|📑 文件IO目录]]。

## 本章要点

- `fflush` 强制把用户空间缓冲区数据同步到硬件；多线程编程中缓冲会影响程序结果。
- 缓冲策略三宏：`_IONBF`（无缓冲）、`_IOLBF`（行缓冲）、`_IOFBF`（全缓冲）；`setvbuf` 自备缓冲区时，其空间必须活到文件流关闭/程序结束。
- 每个打开的文件流有自己的"文件偏移量"：`fseek` 按 SEEK_SET/SEEK_CUR/SEEK_END 定位，`rewind` 等价 `fseek(fp, 0, SEEK_SET)`。
- `EOF` 是文件结束标志（读到末尾时缓冲区填入）；`feof` 测试、`ferror` 测试出错、`clearerr` 清除两标志。
- 格式化 IO：输入 `scanf / sscanf / fscanf`，输出 `printf / fprintf / sprintf`；格式化字符串与参数的类型、数量必须一一对应，输入时需传地址。

作业：

- 继续去完成目录拷贝作业

## 冲洗一个文件流

**冲洗流**： `fflush` 主要作用就是同步文件。（把缓冲区中的内容同步中硬件中）

标准 IO 带缓冲的 IO ，读写时候针对与缓冲区，并不是每次都是操作硬件

有的时候多线程编程的时候会影响到程序结果。

```c
FFLUSH (3)                                                                Linux
Programmer 's Manual
FFLUSH(3)

NAME
        fflush - flush a stream

SYNOPSIS
        #include <stdio.h>

        int fflush (FILE *stream );
        /*
         @ 描述：
             强制给所在的输出流或是更新流 (stream) 上，写入在用户空间缓冲的所有数据，使用底层写
功能函数
             流的打开状态是不受影响的。
             如果 stream 是 NULL ， fflush 刷新所有打开的流。
         @stream
             需要刷新的文件流指针
         @return ：
             成功返回 0
             失败返回 EOF ，同时 errno 被设置
        */
```

## 设置缓冲区

**标准 IO 缓冲区有三种类型：**

- **行缓冲**：缓冲区数据只要达到一行了就会同步到外设（硬盘）上面。假设一行最多 80 字节，当一行满了 80 字节或者遇到`\n` 的时候就会把缓冲区的数据同步到外设上。
  - `printf` : 行缓冲
  - 当一行数据满了就同步。
  - 一行没满，但是遇到换行符也同步。
  - 当一行没满，也没有换行符，程序在正常退出的时候也会同步。
- **全缓冲**：只有当缓冲区的数据满了之后，才会同步到外设上面。
- **无缓冲：**只要缓冲区有一个字节，就会同步到外设上。

```c
SETBUF (3)         Linux Programmer 's Manual
                       SETBUF(3)

NAME
        setbuf , setbuffer , setlinebuf , setvbuf - stream buffering operations

SYNOPSIS
        #include <stdio.h>

        void setbuf (FILE *stream , char *buf );
        void setbuffer (FILE *stream , char *buf , size_t size );
        void setlinebuf (FILE *stream );

         //  上面三个函数的功能它都有
        int setvbuf (FILE *stream , char *buf , int mode , size_t size );
        /*
             @ 描述：
                  设置缓冲策略的。
                  有三种类型的缓冲策略，它们是无缓冲，块缓冲和行缓冲。当输出流无缓冲时，信息在写
的同时出现于目标文件或终端 上；当是块缓冲时，字符被暂存，然后一起写入；当是行缓
冲时，字符被暂存，直到要输出一个新行符，或者从任何与终 端设备连接的流中  ( 典型的
是  stdin)  读取输入时才输出。函数   fflush(3)  可以用来强制提前输出。 ( 参见
fclose(3))   通常所有文件都是块缓冲的。当文件  I/O 操作在文件上发生时，将调用  malloc(3) ，获
得一个缓冲。 如果流指向一个终端  ( 通常  stdout 都是这样 ) ，那么它是行缓冲的。标准
错误流  stderr  默认总是无缓冲的。
             @stream
                  需要设置缓冲区策略的文件流指针
             @buf
                  缓冲区指针
                  注意！！！！！！！！！！！！！！！！！！！！！！
                  buf 必须要是在文件流关闭之前，以及程序结束之前它的空间都应该要有效（也就是从文
件流开始到程序结束该段空间都不能被释放）
             @mode
                  缓冲策略
                      参数 mode 必须是以下宏值
                        _IONBF  无缓冲
                        _IOLBF  行缓冲
                        _IOFBF  全缓冲
             @size
                  缓冲区的大小
             @return
                  成功返回 0
                  失败可能返回任意值
        */
```

## 定位文件流

### 设置光标位置

上面有提到 `fread` 和`fwrite` .... 只是说明要从哪个文件读写，读写多少个，并没有指明，从哪个位置开始。标准 IO 会为每一个打开的文件流，保存一个 “**文件偏移量**”

一般来说，每次读写之前，先确定光标（定位流）。

`fseek` 就是用来定位文件流的光标的。

```c
#include <stdio.h>

int fseek (FILE *stream , long offset , int whence );
/*
    作用：
         fseek 就是用来定位文件流的光标的。
    stream ：
         需要进行定位流的，文件流指针
    offset ：
         偏移量，结合第三个参数。
             负：表示向前偏移
             正：表示向后偏移
    whence ：
         SEEK_SET 基于文件开头定位 新光标的位置 = 文件开头 +offset(>=0)
         SEEK_CUR 基于当前位置定位 新光标的位置 = 当前位置 +offset( 可正可负 )
         SEEK_END     基于文件末尾定位 新光标的位置 = 文件末尾 +offset( 可正可负 )
    返回值：
         成功返回 0 ，失败返回 -1 ，同时 errno 被设置
*/
```

### 重置光标位置

```c
#include <stdio.h>

void rewind (FILE *stream );
/*
    作用：
         将光标定位到文件头
    stream ：
         需要将光标定位到文件头，文件流指针

    使用该函数等价 fseek(stream,0,SEEK_SET) 一样
*/
```

## 文件出错 / 文件结束标志

`EOF` ：`End Of File` 文件结束的标志

清除文件结束标志

```c
FERROR (3)                                                                Linux
Programmer 's Manual
FERROR(3)
NAME
        clearerr , feof , ferror , fileno - check and reset stream status

SYNOPSIS
        #include <stdio.h>

        void clearerr (FILE *stream );
        /*
             @ 描述：
                  清除 stream 指向的流中文件结束标志和出错标志的
             @stream ：
                  需要清除文件结束标志和出错标志的 stream 流
        */

        int feof (FILE *stream );
        /*
             @ 描述：
                  测试指向流中的文件结束标志，如果已设置就返回
             @stream
                  需要测试文件结束标志的流
             @return ：
                  如果已设置就返回非 0
        */

        int ferror (FILE *stream );

        int fileno (FILE *stream );
```

标准 IO 库中，在读文件内容时候，如果读取到了末尾，会往缓冲区填入一个`EOF` （二进制： 1111 1111 ）

## 格式化的输入输出

### 格式化输入

`scanf/sscanf/fscanf...`

**格式化：**按照特点格式进行输入 / 输出

分为两类参数：

- 格式化字符串
  - 告知用户按照哪种格式进行输入 / 输出，怎么输入 / 输出。
  - 格式化字符串中字符分为三类：
    - 非转义字符 / 普通字符
    - `A B C ... 1 2 3... ! ? , ...` 必须要按格式化中的样子输入。精准输入格式化字符
    - `%d %s %c %f %o ...` 占位符，表示接收一个指定类型的数据
    - `%d` ：表示接收一个整型数据
    - `%s` ：表示接收一个字符串数据
    - `%c` ：表示接收一个字符数据
    - `%f` ：表示接收一个浮点数
    - `%o` ：表示接收一个整型并以八进制形式打印
    - 转义字符
    - `\n \t \a \x89 \0777 ...` 通过反斜杠转义的不是原含义的字符
    - 空白字符： `\n \t \a \r ...`
    - 非空白字符： `\x89 \0777 ...`
- 参数
  - 要与格式化字符串中占位字符的类型和数量要一致

**注意：格式化字符串中的每一个格式化字符，就对应一个地址，所以在输入的时候，参数要与格式化字符的类型和数量相匹配，然后需要提供地址。**

`scanf` 什么时候结束输入？

- `scanf` 从`stdin` 的缓冲区中获取输入
  - 当该输入的都输入完了。
    - `scanf("abcd%d %cbcd",&a,&c) ;`
    - `abcd123Abcd`
  - 用户输入失败
    - `scanf(abcd%d %cbcd",&a,&c) ;`
    - `ABCD     // scanf 就会停止匹配，结束`

scanf 返回成功匹配到的变量个数。

#### fscanf

```c
#include <stdio.h>

int fscanf (FILE *stream , const char *format , ...);
/*
    作用：
         从指定的来源，接受输入数据
    stream ：
         输入源，文件流指针
    format ：
         格式化字符串
    ... ：
         可变参数
*/
eg ：
    FILE *fp = fopen ("1.txt" ."r" );
    int r a;char c;
    fscanf (fp,"%d%d%c" ,&r,&a,&c);
```

#### sscanf

```c
#include <stdio.h>

int sscanf (const char *str , const char *format , ...);
/*
    作用：
         从指定的来源，接受输入数据
    str ：
         输入源
    format ：
         格式化字符串
    ... ：
         参数
*/
eg ：
    const char *str = "123456asdsa4564asd" ;
    int r a;char c;
    sscanf (str ,"%d%d%c" ,&r,&a,&c);
```

### 格式化输出

#### fprintf

```c
#include <stdio.h>

int fprintf (FILE *stream , const char *format , ...);
/*
    stream:
         需要输出到的文件流指针
    format ：
         输出格式字符串
    ... ：
         参数
*/
eg ：
    FIEL *fp = open ("1.txt" ,"r+" );
    int a = 1,char c = 'a' ;
    fprintf (fp,"abc%d123%c\n" ,a,c):
```

#### sprintf

```c
#include <stdio.h>

int sprintf (char *str , const char *format , ...);
/*
    str:
         需要输出到的字符指针。
    format ：
         输出格式字符串
    ...:
         参数
*/
    char buf [256 ]={0};
    int a = 1;char c = 'a' ;
    sprintf (buf ,"%d-----%c" ,a,c);
```
