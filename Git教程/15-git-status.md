---
title: "git status 命令"
source: "https://www.runoob.com/git/git-status.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 15
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git status 命令

> 来源：[菜鸟教程 · git status 命令](https://www.runoob.com/git/git-status.html)　·　系列第 15 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git status** 是一个用于查看 Git 仓库当前状态的命令。

**git status** 命令可以查看在你上次提交之后是否有对文件进行再次修改。

```bash
$ git status
On branch master
Initial commit
Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
    new file:   README
    new file:   hello.php
```

git status 命令会显示以下信息：

- 当前分支的名称。
- 当前分支与远程分支的关系（例如，是否是最新的）。
- 未暂存的修改：显示已修改但尚未使用 `git add` 添加到暂存区的文件列表。
- 未跟踪的文件：显示尚未纳入版本控制的新文件列表。

根据 git status 的输出，你可以判断当前工作目录中的文件状态，并采取适当的操作。

通常我们使用 `-s` 参数来获得简短的输出结果：

```bash
$ git status -s
AM README
A  hello.php
```

![git status 命令 配图 1](assets/15-F3B705BE-7D52-46E7-BF64-EA0EFCC52373.jpg)

`AM` 状态的意思是这个文件在我们将它添加到缓存之后又有改动。

---

**系列导航：** [← git add 命令](14-git-add.md)　·　[目录](00-Git教程目录.md)　·　[git diff 命令 →](16-git-diff.md)
