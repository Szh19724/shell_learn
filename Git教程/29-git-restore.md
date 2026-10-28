---
title: "git restore 命令"
source: "https://www.runoob.com/git/git-restore.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 29
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git restore 命令

> 来源：[菜鸟教程 · git restore 命令](https://www.runoob.com/git/git-restore.html)　·　系列第 29 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git restore**  命令用于恢复或撤销文件的更改。

`git restore` 命令是 Git 2.23 版本引入的，用于简化和改进文件恢复操作，相比于旧的命令（如 `git checkout` 和 `git reset`），它更专注于恢复文件内容和工作区状态。

`git restore` 可以恢复工作区和暂存区中的文件，也可以用于丢弃未提交的更改。

## 基本语法

```bash
git restore [<options>] [<pathspec>...]
```

- **`<pathspec>`**：要恢复的文件或目录路径。
- **`<options>`**：用于定制恢复行为的选项。

**常用选项和用法**

| **选项** | **说明** | **用法示例** |
| --- | --- | --- |
| `--source=<commit>` | 从指定的提交中恢复文件内容。默认为 HEAD，即当前提交。 | `git restore --source=HEAD~1 file.txt` |
| `--staged` | 恢复暂存区中的文件内容到工作区，而不是恢复工作区中的内容。 | `git restore --staged file.txt` |
| `--worktree` | 恢复工作区中的文件内容到当前工作区状态。 | `git restore --worktree file.txt` |
| `--ours` | 在合并冲突时，恢复为当前分支的版本（即"我们"的版本）。 | `git restore --ours file.txt` |
| `--theirs` | 在合并冲突时，恢复为另一个分支的版本（即"他们"的版本）。 | `git restore --theirs file.txt` |
| `--conflict=<style>` | 指定合并冲突的样式，例如 `merge` 或 `diff3`。 | `git restore --conflict=diff3 file.txt` |
| `--dry-run` | 显示将要恢复的文件和路径，而不实际进行恢复。 | `git restore --dry-run` |
| `-s`, `--source` | 与 `--source` 相同，用于从指定提交中恢复文件。 | `git restore -s HEAD~1 file.txt` |
| `-W`, `--worktree` | 恢复工作区中的文件内容到当前工作区状态（与 `--worktree` 相同）。 | `git restore -W file.txt` |
| `-S`, `--staged` | 恢复暂存区中的文件内容到工作区，而不是恢复工作区中的内容（与 `--staged` 相同）。 | `git restore -S file.txt` |

---

## 实例

### 恢复工作区中的文件

恢复工作区中的文件到最近的提交状态（即丢弃对文件的所有未提交更改）：

```bash
git restore file.txt
```

### 恢复暂存区中的文件

将暂存区中的文件恢复到工作区，实际上是将文件从暂存区移除（不提交）：

```bash
git restore --staged file.txt
```

### 从指定提交恢复文件

从某个提交（例如 HEAD~1）中恢复文件：

```bash
git restore --source=HEAD~1 file.txt
```

### 恢复文件的"我们"版本

在合并冲突时，恢复为当前分支的版本（即"我们"的版本）：

```bash
git restore --ours file.txt
```

### 恢复文件的"他们"版本

在合并冲突时，恢复为另一个分支的版本（即"他们"的版本）：

```bash
git restore --theirs file.txt
```

### 显示将要恢复的文件和路径

显示将要恢复的文件和路径，而不实际进行恢复：

```bash
git restore --dry-run
```

### 恢复多个文件

恢复工作区中的多个文件：

```bash
git restore file1.txt file2.txt
```

---

**系列导航：** [← git switch 命令](28-git-switch.md)　·　[目录](00-Git教程目录.md)　·　[Git 进阶操作 →](30-Git进阶操作.md)
