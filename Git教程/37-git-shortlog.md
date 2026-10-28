---
title: "git shortlog 命令"
source: "https://www.runoob.com/git/git-shortlog.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 37
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git shortlog 命令

> 来源：[菜鸟教程 · git shortlog 命令](https://www.runoob.com/git/git-shortlog.html)　·　系列第 37 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git shortlog` 命令用于生成简洁的提交日志摘要，按作者和提交消息进行归类。

`git shortlog` 命令主要用于总结 Git 仓库的提交历史，提供对每位作者的提交计数以及每个提交类别的概览。

## 基本语法

```bash
git shortlog [<options>] [<revision-range>]
```

- **`<revision-range>`**：指定要生成摘要的提交范围，默认为当前分支的全部提交。
- **`<options>`**：用于定制输出格式或行为的选项。

**常用选项和用法：**

| **选项** | **说明** | **用法示例** |
| --- | --- | --- |
| `-n` 或 `--numbered` | 按提交数量对作者进行排序，显示每个作者的提交数量。 | `git shortlog -n` |
| `-s` 或 `--summary` | 仅显示作者及其提交数量，不显示提交信息。 | `git shortlog -s` |
| `-e` 或 `--email` | 显示作者的电子邮件地址。 | `git shortlog -e` |
| `-c` 或 `--committer` | 按提交者（committer）统计提交数量，而不是作者（author）。 | `git shortlog -c` |
| `-a` 或 `--all` | 包括所有作者（包括那些没有任何提交的作者）。 | `git shortlog -a` |
| `--no-merges` | 排除合并提交，只显示非合并提交的摘要。 | `git shortlog --no-merges` |
| `--pretty` | 自定义输出格式。 | `git shortlog --pretty=format:"%h %s"` |
| `--since` | 仅显示指定时间范围内的提交。 | `git shortlog --since="2023-01-01"` |
| `--until` | 仅显示指定时间之前的提交。 | `git shortlog --until="2023-01-01"` |
| `--reverse` | 逆序显示提交摘要，按作者提交数量的升序排列。 | `git shortlog --reverse` |

## 常见用法

**1、显示提交作者和提交数量**

按提交数量对作者进行排序，显示每个作者的提交数量及其提交消息的前缀：

```bash
git shortlog -n
```

**2、显示每个作者的提交数量**

仅显示作者及其提交数量，不显示提交信息：

```bash
git shortlog -s
```

**3、显示包括电子邮件的作者摘要**

显示作者及其电子邮件地址：

```bash
git shortlog -e
```

**4、排除合并提交**

排除合并提交，仅显示非合并提交的摘要：

```bash
git shortlog --no-merges
```

**5、按提交者统计**

按提交者（committer）统计提交数量，而不是作者（author）：

```bash
git shortlog -c
```

**6、显示特定时间范围内的提交**

仅显示指定时间范围内的提交摘要：

```bash
git shortlog --since="2023-01-01" --until="2023-06-30"
```

**7、自定义输出格式**

自定义输出格式，以显示提交哈希和提交信息：

```bash
git shortlog --pretty=format:"%h %s"
```

---

**系列导航：** [← git range-diff 命令](36-git-range-diff.md)　·　[目录](00-Git教程目录.md)　·　[git describe 命令 →](38-git-describe.md)
