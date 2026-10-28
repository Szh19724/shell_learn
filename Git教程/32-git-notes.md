---
title: "git notes 命令"
source: "https://www.runoob.com/git/git-notes.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 32
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git notes 命令

> 来源：[菜鸟教程 · git notes 命令](https://www.runoob.com/git/git-notes.html)　·　系列第 32 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git notes` 命令允许用户将附加注释（notes）添加到提交中。

注释不会修改提交的内容，而是附加到提交的元数据中，便于记录额外的信息，如审查备注、额外说明等。

## 语法

git notes 命令的基本语法如下：

```bash
git notes <subcommand> [options] [arguments]
```

- **`<subcommand>`**：具体的操作子命令（如 `add`, `show`, `list`, `remove`, `edit`, `merge` 等）。
- **`[options]`**：命令的选项或参数。
- **`[arguments]`**：命令的附加参数，如提交哈希值等。

**命令使用说明：**

- **`git notes add`**：将新的注释添加到提交中。

  - **`-m`**：指定注释的内容。
  - **`<commit-hash>`**：指定要添加注释的提交（可选，默认为当前提交）。
- **`git notes show`**：显示提交的注释。

  - **`<commit-hash>`**：指定要显示注释的提交（可选，默认为当前提交）。
- **`git notes list`**：列出当前分支上所有提交的注释。
- **`git notes remove`**：删除提交的注释。

  - **`<commit-hash>`**：指定要删除注释的提交（可选，默认为所有注释）。
- **`git notes edit`**：编辑提交的注释。与 `git notes add` 类似，但在编辑模式下打开默认编辑器进行注释编辑。
- **`git notes merge`**：合并不同的注释记录。这用于解决合并时的注释冲突。
- **`refs/notes/*`**：用于指定注释的引用路径。用于推送和拉取注释。

## 实例

**1、添加注释**

```bash
# 添加注释到当前提交
git notes add -m "This commit fixes the login bug"

# 添加注释到特定提交
git notes add -m "Added new feature X" <commit-hash>
```

**2、查看注释**

```bash
# 查看当前提交的注释
git notes show

# 查看特定提交的注释
git notes show <commit-hash>
```

**3、列出所有注释**

```bash
# 列出当前分支上所有提交的注释
git notes list
```

**4、删除注释**

```bash
# 删除特定提交的注释
git notes remove <commit-hash>
# 删除所有注释（不常用）
git notes remove
```

**5、修改注释**

```bash
# 修改当前提交的注释
git notes edit
```

**6、推送和拉取注释**

```bash
# 推送注释到远程仓库
git push origin refs/notes/*
# 拉取远程注释
git fetch origin refs/notes/*:refs/notes/*
```

---

**系列导航：** [← Git Flow](31-GitFlow.md)　·　[目录](00-Git教程目录.md)　·　[git submodule 命令 →](33-git-submodule.md)
