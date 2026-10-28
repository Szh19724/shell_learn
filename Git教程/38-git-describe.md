---
title: "git describe 命令"
source: "https://www.runoob.com/git/git-describe.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 38
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git describe 命令

> 来源：[菜鸟教程 · git describe 命令](https://www.runoob.com/git/git-describe.html)　·　系列第 38 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

`git describe` 命令用于生成一个可读的字符串，该字符串基于 Git 的标签系统来描述当前的提交。

`git describe` 命令命令通常用于生成版本号，帮助识别特定的提交，并能够在构建、发布或追踪特定版本时使用。

## 基本语法

```bash
git describe [<options>] [<commit>]
```

- **`<commit>`**：指定要描述的提交。默认为当前提交。
- **`<options>`**：用于定制输出格式或行为的选项。

**常用选项和用法：**

| **选项** | **说明** | **用法示例** |
| --- | --- | --- |
| `--tags` | 使用所有标签（包括轻量标签）来生成描述。默认情况下，`git describe` 只考虑注释标签。 | `git describe --tags` |
| `--abbrev=<n>` | 设定要显示的提交哈希的最小长度为 `<n>` 个字符。 | `git describe --abbrev=8` |
| `--long` | 强制显示长格式的描述，包括提交的哈希和距离标签的提交数。 | `git describe --long` |
| `--exact-match` | 仅在当前提交与标签完全匹配时返回标签名称。 | `git describe --exact-match` |
| `--dirty` | 如果工作目录有更改（未提交的更改），则在描述中添加 `-dirty` 后缀。 | `git describe --dirty` |
| `--match=<pattern>` | 仅使用符合指定模式的标签进行描述。 | `git describe --match "v1.*"` |
| `--candidates=<n>` | 限制描述所考虑的标签数量，默认为 10 个。 | `git describe --candidates=5` |
| `--always` | 即使没有找到标签，也会显示提交的哈希。 | `git describe --always` |

## 常见用法

**1、描述当前提交**

生成基于最近标签的描述字符串：

```bash
git describe
```

示例输出：

```
v1.2-15-g2414721
```

这里的输出表示当前提交距离最近的标签 v1.2 有 15 次提交，并且当前提交的哈希是 2414721。

**2、使用所有标签进行描述**

包括所有标签（轻量标签和注释标签）来生成描述：

```bash
git describe --tags
```

**3、显示长格式的描述**

显示长格式的描述，包括哈希和距离标签的提交数：

```bash
git describe --long
```

**4、仅在提交完全匹配标签时返回标签名称**

如果当前提交与某个标签完全匹配，则仅返回标签名称：

```bash
git describe --exact-match
```

**5、添加 -dirty 后缀**

如果工作目录有未提交的更改，则在描述中添加 -dirty 后缀：

```bash
git describe --dirty
```

**6、仅使用符合模式的标签**

使用符合指定模式的标签进行描述：

```bash
git describe --match "v1.*"
```

**7、显示提交哈希，即使没有找到标签**

显示当前提交的哈希，甚至在没有标签时：

```bash
git describe --always
```

---

**系列导航：** [← git shortlog 命令](37-git-shortlog.md)　·　[目录](00-Git教程目录.md)　·　[GitCode 使用教程 →](39-GitCode使用教程.md)
