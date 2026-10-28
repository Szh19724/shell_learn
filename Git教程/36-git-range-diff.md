---
title: "git range-diff 命令"
source: "https://www.runoob.com/git/git-range-diff.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 36
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git range-diff 命令

> 来源：[菜鸟教程 · git range-diff 命令](https://www.runoob.com/git/git-range-diff.html)　·　系列第 36 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git range-diff` 命令用于比较两个提交范围之间的差异。

`git range-diff` 命令与 git diff 类似，但允许你同时比较两个不同的提交范围，通常用于查看一系列提交在不同分支或不同版本之间的变化。这对于代码审查和变更比较特别有用。

## 基本语法

```bash
git range-diff <old-range> <new-range>
```

- **`<old-range>`**：旧的提交范围或分支。
- **`<new-range>`**：新的提交范围或分支。

## 常见用法

**1、比较两个提交范围**

比较 branch1 的提交范围与 branch2 的提交范围之间的差异：

```bash
git range-diff branch1 branch2
```

示例：

```bash
git range-diff feature/old-branch feature/new-branch
```

**2、比较两个提交系列**

比较两个提交系列的差异，查看在特定时间段内的变更：

```bash
git range-diff <start-old>..<end-old> <start-new>..<end-new>
```

示例：

```bash
git range-diff HEAD~10..HEAD~5 HEAD~5..HEAD
```

这里，HEAD~10..HEAD~5 表示旧的提交范围，HEAD~5..HEAD 表示新的提交范围。

---

**系列导航：** [← git difftool 命令](35-git-difftool.md)　·　[目录](00-Git教程目录.md)　·　[git shortlog 命令 →](37-git-shortlog.md)
