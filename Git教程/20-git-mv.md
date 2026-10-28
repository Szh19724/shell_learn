---
title: "git mv 命令"
source: "https://www.runoob.com/git/git-mv.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 20
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git mv 命令

> 来源：[菜鸟教程 · git mv 命令](https://www.runoob.com/git/git-mv.html)　·　系列第 20 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

git mv 命令用于移动或重命名一个文件、目录或软连接。

```bash
git mv [file] [newfile]
```

如果新文件名已经存在，但还是要重命名它，可以使用 `-f` 参数：

```bash
git mv -f [file] [newfile]
```

我们可以添加一个 README 文件（如果没有的话）：

```bash
$ git add README
```

然后对其重命名:

```bash
$ git mv README  README.md
$ ls
README.md
```

---

**系列导航：** [← git rm 命令](19-git-rm.md)　·　[目录](00-Git教程目录.md)　·　[git remote 命令 →](21-git-remote.md)
