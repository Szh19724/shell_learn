---
title: "git clone 命令"
source: "https://www.runoob.com/git/git-clone.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 13
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git clone 命令

> 来源：[菜鸟教程 · git clone 命令](https://www.runoob.com/git/git-clone.html)　·　系列第 13 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git clone** 是一个用于克隆（clone）远程 Git 仓库到本地的命令。

**git clone** 可以将一个远程 Git 仓库拷贝到本地，让自己能够查看该项目，或者进行修改。

**git clone** 命令，你可以复制远程仓库的所有代码和历史记录，并在本地创建一个与远程仓库相同的仓库副本。

拷贝项目命令格式如下：

```bash
git clone [url]
```

`[url]` 是你要拷贝的项目。

例如我们拷贝 Github 上的项目：

**示例**

```bash
$ git clone https://github.com/tianqixin/runoob-git-test
Cloning into 'runoob-git-test'...
remote: Enumerating objects: 12, done.
remote: Total 12 (delta 0), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (12/12), done.
```

执行完上述步骤后，Git 会克隆远程仓库到本地，并在当前目录下创建一个与远程仓库同名的文件夹（例如上面示例中的 runoob-git-test 文件夹）。

以上命令执行完成后，在当前目录下会生成一个 runoob-git-test 目录：

```bash
$ cd simplegit/
$ ls
README.md    runoob-test.txt    test.txt
```

上述操作将复制该项目的全部记录。

```bash
$ ls -a
.        ..        .git        README.md    runoob-test.txt    test.txt
$ cd .git
$ ls
HEAD        description    index        logs        packed-refs
config        hooks        info        objects        refs
```

**git clone** 命令会自动将远程仓库的所有分支和历史记录复制到本地，你可以使用其他 Git 命令（如 git checkout、git pull 等）在本地仓库进行操作。

默认情况下，Git 会按照你提供的 URL 所指向的项目的名称创建你的本地项目目录。 通常就是该 URL 最后一个 / 之后的项目名称。如果你想要一个不一样的名字， 你可以在该命令后加上你想要的名称。

例如，以下实例拷贝远程 git 项目，本地项目名为 **another-runoob-name**：

**示例**

```bash
$ git clone https://github.com/tianqixin/runoob-git-test another-runoob-name
Cloning into 'another-runoob-name'...
remote: Enumerating objects: 12, done.
remote: Total 12 (delta 0), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (12/12), done.
```

---

**系列导航：** [← git init 命令](12-git-init.md)　·　[目录](00-Git教程目录.md)　·　[git add 命令 →](14-git-add.md)
