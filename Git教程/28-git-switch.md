---
title: "git switch 命令"
source: "https://www.runoob.com/git/git-switch.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 28
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git switch 命令

> 来源：[菜鸟教程 · git switch 命令](https://www.runoob.com/git/git-switch.html)　·　系列第 28 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git switch** 命令用于更清晰地切换分支。

**git switch** 命令作用与 [git checkout](27-git-checkout.md) 类似，但提供了更清晰的语义和错误检查。

## 切换分支

以下命令允许你从当前分支切换到指定的分支 **<branch-name>**:

```bash
git switch <branch-name>
```

例如将你的工作目录切换到主分支:

```bash
git switch master
```

**创建新分支并切换**

如果你想同时创建一个新分支并切换到该分支，可以在 `git switch` 命令后面加上 **-c** 或 **--create** 选项，然后指定分支名称。

以下命令用于创建一个新分支 **<new-branch-name>** 并立即切换到新创建的分支:

```bash
git switch -c <new-branch-name>
```

例如创建一个名为 feature-branch 的新分支并切换到它:

```bash
git switch -c feature-branch
```

这将创建一个名为 "feature-branch" 的新分支，并将你的工作目录切换到该分支上。

**切换到前一个分支**

以下命令可以让你快速切换回前一个分支，无需记住分支名称:

```bash
git switch -
```

**恢复工作目录到某个特定的提交状态**

```bash
git switch <commit_hash>
```

这会将工作目录切换到指定提交 <commit\_hash> 的状态，处于分离 HEAD 的状态（即不再位于任何分支上，而是直接指向某个提交）。

除了这些基本用法外，git switch 还有其他一些选项和用法，例如：

- 使用 `-d` 或 `--detach` 选项可以使切换到某个提交的操作更明确，即使存在同名分支也不会切换到分支上。
- 使用 `-c` 选项创建新分支并立即切换到该分支，与 `git switch -c <branch_name>` 相同。
- 使用 `-f` 或 `--force` 选项可以强制执行切换操作，即使存在未提交的更改。

**查看可用分支和标签**

以下命令可以让你列出可用的本地分支和标签，以便快速选择要切换的目标：

```bash
git branch
```

与 git checkout 不同，git switch 更容易理解和使用，因为它专注于分支切换的操作，此外，git switch 还提供了更好的错误检查，可以避免一些常见的错误操作。

**注意：**git switch 是 Git 2.23 版本引入的一个新命令，如果你使用的是 Git 的旧版本，可能无法使用 git switch 命令，但你仍然可以使用 [git checkout](27-git-checkout.md) 进行相同的操作。

---

**系列导航：** [← git checkout 命令](27-git-checkout.md)　·　[目录](00-Git教程目录.md)　·　[git restore 命令 →](29-git-restore.md)
