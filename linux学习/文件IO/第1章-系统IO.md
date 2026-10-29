# 第1章 系统IO

> 本章整理自 `3.标准IO二.pdf` 第 1–7 页；另含第 8 页顶部的续接代码段（内容对应原始 `0.系统IO.pdf`）。返回 [[00-文件IO目录|📑 文件IO目录]]。

## 本章要点

- 无操作系统的"裸奔"编程直接操作硬件、单任务；带 OS 编程只关心应用逻辑、支持多任务，Linux 下开发即调用系统 API。
- Linux 一切皆文件：文件 = inode（属性/编号）+ 文件内容；内核经 `struct file → struct inode → 硬件` 完成操作。
- 进程文件表项是 `struct file *` 数组，open 返回的文件描述符即数组下标（0、1、2 依次分配）。
- 系统 IO 六件套：`open`（O_RDONLY/O_WRONLY/O_RDWR/O_CREAT 与 mode）、`read`、`write`、`close`、`lseek`（SEEK_SET/SEEK_CUR/SEEK_END）、`umask`。
- umask 为创建掩码：最终权限 = 指定权限 & ~umask；代码中设置 umask 不影响系统全局设定。
- 作业：实现文件间内容拷贝（read/write 循环，见章末示例）。

## 文件系统

### “ 裸奔 ” 层次：不带操作系统的编程

```c
APP 应用层
-----------------
HardWare 硬件层
```

**特点**：

- 简单，粗暴应用层直接操作硬件 ( 寄存器、 IO 口 ...)

**缺点**：

- 开发应用、要能搞懂原理图
- 了解硬件的细节
- 不能同时运行多个任务：单任务运行

### 带 “OS” 的编程

```c
APP 应用层
-----------------
OS 操作系统
-----------------
Hardware     硬件层
```

**特点**：

- 开发应用、主要实现应用的逻辑实现
- 不需要关心底层硬件的实现细节
- 可以支持多任务运行、并发

**缺点**：

- `API （ application interface ）`太多了
- `API` 的实现（功能）可能不是我们想要的

`OS ： Operating System` 操作系统。是直接运行在 “**裸机**” 的最基本的系统软件，任何软件 / 应用程序都必须要在操作系统的支持下才能正常运行。

操作系统：

- `windows  x86/xp/win8/win10/win11`
- `linux       ubuntu/centos/redhat/kali`
- `mac`
- `IOS`
- `Android`
- 鸿蒙
- `unix`

Linux 操作系统下进行开发应用软件，就是调用 Linux 操作系统为我们提供的系统的`API` 函数接口去操作硬件。或者是说用 Linux 提供的服务来完 Linux 下的一些开发。

## Linux 文件系统

**在 Linux 下面，一切皆文件。**在 Linux 下面操作**任何**东西，其实都是通过操作文件来实现的，通过文件的接口实现。

### 文件系统

用来存储、组织、管理文件的一套方式、方法、协议以及软件的实现 ...

**文件**：

- 文件属性： `inode` （编号），`inode` ----> 文件内容 ...
- 文件内容：文件的实际存储的内容

文件在**Linux** 下的操作过程 :

- 硬链接（找文件名） ---->`inode`
- Linux 内核

```c
         //  是用来描述一个文件的物理的 inode 信息
         //  系统如果识别到了一个文件的存在，就会为它在 linux 内核里面创建一个 struct inode 的一
         个文件对应的 inode 。
         struct inode {};

         /*
              用来描述一个已经打开了的文件信息的。
              文件状态偏移了（类似于文本光标）
              每个打开的文件都会对应一个 struct file
              一个文件是可以被多个不同应用打开
         */
         struct file {}
```

- 操作过程： `sturct file` -->`struct inode` -->`硬件上的 inode` -->`文件内容区域`

Linux 为了屏蔽掉文件操作的一些具体实现细节，它会为进程创建一个 “ **进程文件表项** ”

### 进程文件表项

每一个应用都会有一个**进程文件表项**，保存进程打开的文件的 `sturct file` 结构体指针，相当于是一个 `struct file *` 的数组（集合），打开一个文件，只需要返回一个下标给我使用就可以了

```c
struct file * []
打开一个文件，文件的 struct file 指针被分配到 0 下标，就可以使用 0 下标在进程文件表项中获取文件的
struct file 指针使用了。
```

Linux 提供系统操作函数：`open 、 write 、 read 、 close...` 以上这些函数都是称为： “**系统 IO**”

**系统 IO ：**操作系统所提供的对于文件的**输入 输出**的函数接口

## Linux 系统 IO 的应用

**对于文件的操作大致：**

- 打开文件（获取文件描述符（就是**进程文件表项数组的下标**））
- 对文件写入内容 / 读取文件内容（ Input Output 输入 / 输出的操作）
- 移动文件光标位置（偏移操作）
- 关闭文件（释放打开的文件，并且销毁进程文件表项中对应的文件结构体）

### 打开文件： open

```c
OPEN (2)                            System calls OPEN (2)

NAME
        open , creat - 打开和/或创建一个文件

SYNOPSIS 总览
        #include <sys/types.h>
        #include <sys/stat.h>
        #include <fcntl.h>

        int open (const char *pathname , int flags );
        /*
             @ 描述：
                  打开一个文件

             @pathname ：
                  需要打开的文件的名字（路径 + 文件名 + 扩展名）

             @flags ：标志位
                  打开方式：
                      O_RDONLY 以只读方式打开
                      O_WRONLY 以只写方式打开
                      O_RDWR 以可读可写方式打开

             @return ：
                  成功返回文件的 struct file 指针在进程文件表项中的下标（文件描述符），失败返
回 -1
        */

        int open (const char *pathname , int flags , mode_t mode )
        /*
             @ 描述：
                  打开一个文件

             @pathname ：
                  需要打开的文件的名字（路径 + 文件名 + 扩展名）

             @flags ：标志位
                  打开方式：
                      O_RDONLY 以只读方式打开
                      O_WRONLY 以只写方式打开
                      O_RDWR 以可读可写方式打开

             @mode ：
                  当你使用了 O_CREAT 标志的时候，请你填写此参数
                      mode 用来设定文件的权限的
                      当然最终文件权限取决 umask 和填写权限运算

             @return  成功返回文件的 struct file 指针在进程文件表项中的下标，失败返回 -1
        */
```

### 文件读 / 写： read/write

#### 读取文件的内容： read

```c
READ (2)                      Linux Programmer 's Manual                    READ(2)

NAME
        read - 在文件描述符上执行读操作

概述
        #include <unistd.h>

        ssize_t read (int fd, void *buf , size_t count );
        /*
             @ 描述：
                  从一个指定的文件描述符中（ fd ）读取 count 个字节的数据存储到 buf 所指向的内存空间
中

             @fd ：
                  file id  文件描述符（进程文件表项的下标），一般由 open 函数返回。需要是有效文
件描述符

             @buf ：
                  void *  类指针，用来存储读取到数据内容的内存空间的首地址指针

             @count ：
                  个数，表示需要读取多少个字节

             @return ：
                  成功：实际读取到的字节数量
                  失败：返回 -1
        */
```

#### 写入内容到文件： write

```c
WRITE (2)                     Linux Programmer 's Manual                   WRITE(2)

NAME
        write -在一个文件描述符上执行写操作

概述
        #include <unistd.h>

        ssize_t write (int fd, const void *buf , size_t count );
        /*
             @ 描述：
                  往一个指定的文件描述符中（ fd ）写入 buf 所指向的内存空间中的 count 个字节的数据

             @fd ：
                  file id  文件描述符，一般由 open 函数返回。需要是有效文件描述符

             @buf ：
                  void *  指针，用来存储写入数据的存储内存空间的首地址指针

             @count ：
                  个数，表示需要写入多少个字节

             @return ：
                  成功：实际写入到的字节数量
                  失败：返回 -1
        */
```

### 移动文件光标位置：lseek

有时候咱们想在文件中间某个指定的位置插入内容

```c
#include <sys/types.h>
#include <unistd.h>

off_t lseek (int fd, off_t offset , int whence );
/*
    作用：
         设置一个文件的光标偏移量
    返回值：
         实际偏移字节数量，失败返回 -1
    fd ：
         需要进行光标偏移的文件描述符。
    offset:
         off_t 类型光标需要偏移的字节数量。可以为正也可以为负
         如果为正数，则表示光标向文件末尾的方向偏移
         如果为负数，则表示光标向文件头的方向偏移
    whence ：
         SEEK_SET
               The file offset is set to offset bytes.
               从文件开头的位置进行偏移

         SEEK_CUR
               The  file offset is set to its current location plus off -
               set bytes.
               从当前位置开始进行偏移。

         SEEK_END
               The file offset is set to the size of the file plus  off -
               set bytes.
               从文件末尾开始进行偏移
     @return  成功返回实际偏移的字节数，失败返回 -1
*/
```

### 关闭文件： close

```c
CLOSE (2)                     Linux Programmer 's Manual                   CLOSE(2)

NAME 名字
        close - 关闭一个文件描述符

SYNOPSIS 总览
        #include <unistd.h>

        int close (int fd);
        /*
             @fd :  需要关闭的文件描述符
             @return  成功返回 0 ，失败返回 -1
        */
```

## umask

`umask` ：用来设置一个文件的创建的掩码（掩盖部分功能）的。

`umask` 掩码中为 1 的 bit 位，在文件创建的时候，不能指定这个 bit 位所对应的权限

```c
通过 open 创建一个文件的时候如果指定了文件的权限： 0777 ，但是 umask 值为： 0022 的时候

实际文件被创建之后的权限为： 0777 & ~umask
                          0777 & ~ 0022
                          0777 & 0755
                          0755

UMASK (2)                     Linux Programmer 's Manual                   UMASK(2)

NAME
        umask - set file mode creation mask

SYNOPSIS
        #include <sys/types.h>
        #include <sys/stat.h>

        mode_t umask (mode_t mask );
        /*
             @ 描述：
                  指定 umask 的掩码值
             @mask ：
                  指定文件的掩码
             @return ：
                  返回上一个文件的掩码
        */
```

**注意：** `umask` **在代码中使用不会影响系统的设定，并且**`open` **创建的权限是全部都有。**

```c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
int main ()
{
    // O_RDONLY read only  只读
    // O_RDWR Read and Write  可读可写
    umask (0000 );
    int fd = open ("test1.txt" ,O_RDWR | O_CREAT ,0777 );
    if(fd == -1)
    {
         perror (" 打开失败 !");
         return -1;
    }

    printf (" 打开成功 !\n");

    char writeBuf [1024 ]={" 欢迎大家来到 Linux 的编程世界！！！ "};
    int realWriteCount = write (fd,writeBuf ,47);

    if(realWriteCount == -1)
    {
         perror (" 写入失败了 ");
    }

    printf (" 写入 :%d 个字节的数据 \n",realWriteCount );

    //  把光标移动到文件头进行读取
    int realSeekCount = lseek (fd,-47,SEEK_CUR );
    printf (" 移动了 %d 个字节 \n",realSeekCount );

    char readBuf [1024 ]={0};

    int realReadCount = read (fd,readBuf ,1024 );

    printf (" 读取： %d 个字节的数据，内容为 :%s\n",realReadCount ,readBuf );

    lseek (fd,47,SEEK_CUR );

    close (fd);
    return 0;
}
```

作业：

- 实现一下文件之间的拷贝
  - 相当于把 A 文件的内容拷贝到 B 文件（空内容）中

```c
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

/*
    作用：
         从一个文件中拷贝内容到另一个文件中
         首先需要两个文件（文件名字）
         分别打开两个文件
         从 A 文件中读取内容
         写入到 B 文件中
         关闭两个文件
*/

int main (int argc ,const char *argv [])
{
    if(argc != 3)
    {
         printf ("%s <A filename> <B filename>\n" ,argv [0]);
         return -1;
    }

    //  打开两个文件
    int AfileId = open (argv [1],O_RDONLY );//  被拷贝的文件，需要修改内容吗？ x
    int BfileId = open (argv [2],O_WRONLY );//  拷贝文件，需要读取内容？ x

    char buf [2]={0};
    //  循环
    int realCount = 0;
    do
    {
         realCount = read (AfileId ,buf ,2);
         write (BfileId ,buf ,realCount );
    }
    while (realCount == 2);

    close (AfileId );
    close (BfileId );
    return 0;
}
```
