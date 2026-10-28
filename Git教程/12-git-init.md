---
title: "git init 命令"
source: "https://www.runoob.com/git/git-init.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 12
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git init 命令

> 来源：[菜鸟教程 · git init 命令](https://www.runoob.com/git/git-init.html)　·　系列第 12 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git init** 命令用于在目录中创建新的 Git 仓库。

在目录中执行 `git init` 就可以创建一个 Git 仓库了。

执行 git init 后，Git 会在当前目录下创建一个名为 .git 的隐藏文件夹，这个文件夹用于存储版本控制所需的所有元数据和对象。

## 基本用法

```bash
git init
```

例如我们在当前目录下创建一个名为 runoob 的项目：

**示例**

```bash
$ mkdir runoob
$ cd runoob/
$ git init
Initialized empty Git repository in /Users/xxx/www/runoob/.git/
# 初始化空 Git 仓库完毕。
```

现在你可以看到在你的项目中生成了 `.git` 这个子目录，这就是你的 Git 仓库了，所有有关你的此项目的所有内容和元数据都存放在这里。

执行完上述步骤后，你就创建了一个新的 Git 仓库，你可以使用其他 Git 命令（如 git add、git commit 等）来管理和跟踪你的代码变更，并与远程仓库进行交互。

**注意**：git init 命令只用于在一个空目录中创建新仓库，如果你想要克隆（clone）一个已存在的远程仓库到本地，请使用 [git clone](13-git-clone.md) 命令。

`.git` 默认是隐藏的，可以用 ls -a 命令查看：

```bash
ls -a
.    ..    .git
```

---

**系列导航：** [← Git 服务器搭建](11-Git服务器搭建.md)　·　[目录](00-Git教程目录.md)　·　[git clone 命令 →](13-git-clone.md)
