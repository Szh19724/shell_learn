---
title: "git show 命令"
source: "https://www.runoob.com/git/git-show.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 34
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git show 命令

> 来源：[菜鸟教程 · git show 命令](https://www.runoob.com/git/git-show.html)　·　系列第 34 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git show` 命令用于显示 Git 对象的详细信息。

`git show` 命令用于查看提交、标签、树对象或其他 Git 对象的内容。这个命令对于审查提交历史、查看提交的具体内容以及调试 Git 对象非常有用。

## 基本语法

```bash
git show [<options>] [<object>]
```

- **`<object>`**：指定要显示的 Git 对象。可以是提交哈希、标签、分支名等。
- **`<options>`**：显示的选项或格式设置。

**常用选项和用法:**

| **选项** | **说明** | **用法示例** |
| --- | --- | --- |
| `--pretty=format:` | 自定义输出格式。使用格式化字符串来显示提交信息。 | `git show --pretty=format:"%h %s" <commit-hash>` |
| `--name-only` | 只显示更改的文件名。 | `git show --name-only <commit-hash>` |
| `--name-status` | 显示更改的文件名和更改状态（新增、修改、删除）。 | `git show --name-status <commit-hash>` |
| `--stat` | 显示提交的统计信息，包括更改的文件、行数和文件的变化。 | `git show --stat <commit-hash>` |
| `--patch` | 显示提交的差异补丁（默认行为）。 | `git show --patch <commit-hash>` |
| `--color` | 显示彩色输出，以提高可读性。 | `git show --color <commit-hash>` |
| `--no-patch` | 不显示补丁，仅显示提交信息。 | `git show --no-patch <commit-hash>` |
| `--abbrev-commit` | 显示缩短的提交哈希。 | `git show --abbrev-commit <commit-hash>` |
| `--pretty=oneline` | 以一行格式显示提交信息。 | `git show --pretty=oneline <commit-hash>` |

## 常见用法

**1、显示提交的详细信息**

显示提交的详细信息，包括提交消息、作者、日期和更改的文件等：

```bash
git show <commit-hash>
```

示例：

```bash
git show 9a0d7b6
```

**2、显示提交的差异**

仅显示提交中包含的差异（补丁）：

```bash
git show --patch <commit-hash>
```

**示例：**

```bash
git show --patch 9a0d7b6
```

**3、显示提交的文件列表**

仅显示提交中更改的文件名：

```bash
git show --name-only <commit-hash>
```

示例：

```bash
git show --name-only 9a0d7b6
```

**4、显示提交的统计信息**

显示提交的统计信息，包括更改的文件和行数：

```bash
git show --stat <commit-hash>
```

示例：

```bash
git show --stat 9a0d7b6
```

**5、使用自定义格式显示提交信息**

使用 --pretty=format: 自定义提交信息的输出格式：

```bash
git show --pretty=format:"%h - %an, %ar : %s" <commit-hash>
```

示例：

```bash
git show --pretty=format:"%h - %an, %ar : %s" 9a0d7b6
```

**6、显示标签的详细信息**

git show 也可以用来查看标签的详细信息：

```bash
git show <tag>
```

示例：

```bash
git show v1.0
```

---

**系列导航：** [← git submodule 命令](33-git-submodule.md)　·　[目录](00-Git教程目录.md)　·　[git difftool 命令 →](35-git-difftool.md)
