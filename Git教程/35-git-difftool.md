---
title: "git difftool 命令"
source: "https://www.runoob.com/git/git-difftool.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 35
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git difftool 命令

> 来源：[菜鸟教程 · git difftool 命令](https://www.runoob.com/git/git-difftool.html)　·　系列第 35 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git difftool` 命令用于使用外部差异工具查看和比较文件的更改。

`git difftool` 命令是 git diff 命令的一个扩展，提供了更直观的可视化工具来解决文件之间的差异。适用于那些更喜欢使用图形化工具而不是命令行工具来处理文件差异的用户。

## 基本语法

```bash
git difftool [<options>] [<commit> [<path>...]]
```

- **`<commit>`**：指定要比较的提交，默认为当前工作目录的状态。
- **`<path>`**：指定要比较的文件路径。

**常用选项和用法:**

| **选项**                 | **说明**                               | **用法示例**                            |
| ---------------------- | ------------------------------------ | ----------------------------------- |
| `--tool=<tool>`        | 指定使用的外部差异工具。默认情况下，Git 使用配置的默认差异工具。   | `git difftool --tool=meld`          |
| `--tool-help`          | 显示可用的差异工具列表。                         | `git difftool --tool-help`          |
| `--dir-diff`           | 在目录中进行比较，而不是逐个文件。                    | `git difftool --dir-diff`           |
| `--no-prompt`          | 跳过对每个文件的确认提示，自动使用工具查看差异。             | `git difftool --no-prompt`          |
| `--staged`             | 比较已暂存的更改与上一个提交之间的差异。                 | `git difftool --staged`             |
| `--cached`             | 与 `--staged` 相同，用于比较已缓存的更改与上一个提交的差异。 | `git difftool --cached`             |
| `--merge`              | 用于合并工具，处理冲突时查看差异。                    | `git difftool --merge`              |
| `--find-copies`        | 查找文件复制和移动。                           | `git difftool --find-copies`        |
| `--find-copies-harder` | 更加严格地查找文件复制和移动。                      | `git difftool --find-copies-harder` |

## 常见用法

**1、查看工作目录与最近提交之间的差异**

使用默认的差异工具查看当前工作目录中的更改与最近提交之间的差异：

```bash
git difftool
```

**2、查看暂存区与最近提交之间的差异**

使用默认的差异工具查看暂存区中的更改与最近提交之间的差异：

```bash
git difftool --staged
```

**3、查看特定文件的差异**

使用默认的差异工具查看指定文件的更改：

```bash
git difftool <file>
```

示例：

```bash
git difftool index.html
```

**4、使用指定工具查看差异**

使用 meld 工具查看差异（需要在 Git 配置中设置 meld 为差异工具）：

```bash
git difftool --tool=meld
```

**5、在目录中查看差异**

在目录中查看更改，而不是逐个文件：

```bash
git difftool --dir-diff
```

**6、跳过确认提示**

自动打开工具查看所有文件的差异，而不进行确认：

```bash
git difftool --no-prompt
```

## 配置外部差异工具

你可以在 Git 配置中设置外部差异工具。以下是配置 meld 工具的示例：

```bash
git config --global diff.tool meld
git config --global difftool.meld.cmd 'meld "$BASE" "$LOCAL" "$REMOTE" --diff "$MERGED"'
```

你可以根据需要配置其他工具（如 kdiff3, vimdiff, opendiff 等），具体配置方法取决于工具本身的命令行接口。

---

**系列导航：** [← git show 命令](34-git-show.md)　·　[目录](00-Git教程目录.md)　·　[git range-diff 命令 →](36-git-range-diff.md)
