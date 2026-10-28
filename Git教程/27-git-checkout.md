---
title: "git checkout 命令"
source: "https://www.runoob.com/git/git-checkout.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 27
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git checkout 命令

> 来源：[菜鸟教程 · git checkout 命令](https://www.runoob.com/git/git-checkout.html)　·　系列第 27 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git checkout** 命令用于在不同的分支之间切换、恢复文件、创建新分支等操作。

> **注意：**git checkout 命令在 Git 2.23 版本后引入了 [git switch](28-git-switch.md) 和 [git restore](29-git-restore.md) 命令，分别用于分支切换和文件恢复，以提供更清晰的语义和错误检查。如果你使用较新的 Git 版本，可以考虑使用这些命令代替 git checkout。

**切换分支：**

以下命令允许你从当前分支切换到指定的分支 **<branch-name>**:

```bash
git checkout <branch-name>
```

例如将你的工作目录切换到主分支:

```bash
git checkout master
```

**创建新分支并切换：**

以下命令用于创建一个新分支 **<new-branch-name>** 并立即切换到新创建的分支:

```bash
git checkout -b <new-branch-name>
```

例如创建一个名为 feature-branch 的新分支并切换到它:

```bash
git checkout -b feature-branch
```

**切换到前一个分支：**

以下命令可以让你快速切换回前一个分支，无需记住分支名称:

```bash
git checkout -
```

**检出文件：**

以下命令可以将工作区指定文件 **<file>** 恢复到最近一次提交时的状态，丢弃所有未提交的更改，这对于撤销不需要的更改非常有用：

```bash
git checkout -- <file>
```

具体来说，这个命令会撤销对文件的所有未提交更改，将文件恢复到当前分支的 HEAD（最新提交）所记录的状态。

**切换到特定提交：**

你可以使用提交的哈希值 **<commit-hash>** 来切换到特定的提交状态。这将使你进入"分离头指针"状态，只能查看历史记录，而不能进行分支操作。通常情况下，不建议在分离头指针状态下工作，因为更改可能会丢失。

```bash
git checkout <commit-hash>
```

**切换到标签：**

如果你有一个标签 **<tag-name>**，你可以使用这个命令来切换到该标签所指向的提交状态。

```bash
git checkout tags/<tag-name>
```

---

**系列导航：** [← Sourcetree 使用教程](26-Sourcetree使用教程.md)　·　[目录](00-Git教程目录.md)　·　[git switch 命令 →](28-git-switch.md)
