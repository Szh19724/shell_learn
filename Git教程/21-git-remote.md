---
title: "git remote 命令"
source: "https://www.runoob.com/git/git-remote.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 21
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git remote 命令

> 来源：[菜鸟教程 · git remote 命令](https://www.runoob.com/git/git-remote.html)　·　系列第 21 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git remote** 命令用于用于管理 Git 仓库中的远程仓库。

**git remote** 命令提供了一些用于查看、添加、重命名和删除远程仓库的功能。

以下是 git remote 命令的常见用法：

- `git remote`：列出当前仓库中已配置的远程仓库。
- `git remote -v`：列出当前仓库中已配置的远程仓库，并显示它们的 URL。
- `git remote add <remote_name> <remote_url>`：添加一个新的远程仓库。指定一个远程仓库的名称和 URL，将其添加到当前仓库中。
- `git remote rename <old_name> <new_name>`：将已配置的远程仓库重命名。
- `git remote remove <remote_name>`：从当前仓库中删除指定的远程仓库。
- `git remote set-url <remote_name> <new_url>`：修改指定远程仓库的 URL。
- `git remote show <remote_name>`：显示指定远程仓库的详细信息，包括 URL 和跟踪分支。

以下列出了远程仓库、添加远程仓库、重命名远程仓库、删除远程仓库、修改远程仓库 URL 和查看远程仓库信息的用法：

```bash
git remote
git remote -v
git remote add origin https://github.com/user/repo.git
git remote rename origin new-origin
git remote remove new-origin
git remote set-url origin https://github.com/user/new-repo.git
git remote show origin
```

## 应用实例

本章节内容我们将以 Github 作为远程仓库来操作，所以阅读本章节前需要先阅读关于 Github 的相关内容：[Git 远程仓库(Github)](10-Git远程仓库-Github.md)。

显示所有远程仓库：

```bash
git remote -v
```

`git remote -v` 可以查看当前仓库中配置的远程仓库列表以及它们的 URL。

以下我们先载入远程仓库，然后查看信息：

**示例**

```bash
$ git clone https://github.com/tianqixin/runoob-git-test
$ cd runoob-git-test
$ git remote -v
origin  https://github.com/tianqixin/runoob-git-test (fetch)
origin  https://github.com/tianqixin/runoob-git-test (push)
```

**origin** 为远程地址的别名。

显示某个远程仓库的信息：

```bash
git remote show [remote]
```

例如：

```bash
$ git remote show https://github.com/tianqixin/runoob-git-test
* remote https://github.com/tianqixin/runoob-git-test
  Fetch URL: https://github.com/tianqixin/runoob-git-test
  Push  URL: https://github.com/tianqixin/runoob-git-test
  HEAD branch: master
  Local ref configured for 'git push':
    master pushes to master (local out of date)
```

添加远程版本库：

```bash
git remote add <remote_name> <remote_url>
```

- `<remote_name>`：要添加的远程仓库的名称。通常，远程仓库的名称为 `origin`，但你也可以自定义一个名称。
- `<remote_url>`：远程仓库的 URL。它可以是一个指向远程 Git 仓库的 HTTPS、SSH 或 Git 协议链接。

以下命令将向当前 Git 仓库添加一个名为 origin 的远程仓库，它的 URL 是 https://github.com/user/repo.git。

```bash
git remote add origin https://github.com/user/repo.git
```

实例用法：

```bash
# 提交到 Github
$ git remote add origin git@github.com:tianqixin/runoob-git-test.git
$ git push -u origin master
```

添加远程仓库后，你就可以使用其他 Git 命令与远程仓库进行交互，例如推送本地代码到远程仓库、拉取远程仓库的代码等。

其他相关命令：

```bash
git remote rm name  # 删除远程仓库
git remote rename old_name new_name  # 修改仓库名
```

更多内容可以查看：[Git 远程仓库(Github)](10-Git远程仓库-Github.md)。

---

**系列导航：** [← git mv 命令](20-git-mv.md)　·　[目录](00-Git教程目录.md)　·　[git fetch 命令 →](22-git-fetch.md)
