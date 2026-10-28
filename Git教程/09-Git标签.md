---
title: "Git 标签"
source: "https://www.runoob.com/git/git-tag.html"
series: "菜鸟教程 Git 教程"
kind: "教程"
order: 9
tags:
  - Git
  - 菜鸟教程
---

# Git 标签

> 来源：[菜鸟教程 · Git 标签](https://www.runoob.com/git/git-tag.html)　·　系列第 9 / 40 篇

如果你达到一个重要的阶段，并希望永远记住提交的快照，你可以使用 `git tag` 给它打上标签。

Git 标签（Tag）用于给仓库中的特定提交点加上标记，通常用于发布版本（如 v1.0, v2.0）。

比如说，我们想为我们的 runoob 项目发布一个 "1.0" 版本，我们可以用 `git tag -a v1.0` 命令给最新一次提交打上（HEAD） "v1.0" 的标签。

**`-a` 选项意为**"创建一个带注解的标签"，不用 `-a` 选项也可以执行的，但它不会记录这标签是啥时候打的，谁打的，也不会让你添加个标签的注解，我们推荐一直创建带注解的标签。

**标签语法格式：**

```bash
git tag <tagname>
```

例如：

```bash
git tag v1.0
```

`-a` 选项可以添加注解：

```bash
$ git tag -a v1.0
```

当你执行 git tag -a 命令时，Git 会打开你的编辑器，让你写一句标签注解，就像你给提交写注解一样。

现在，注意当我们执行 `git log --decorate` 时，我们可以看到我们的标签了：

```
*   d5e9fc2 (HEAD -> master) Merge branch 'change_site'
|\
| * 7774248 (change_site) changed the runoob.php
* | c68142b 修改代码
|/
* c1501a2 removed test.txt、add runoob.php
* 3e92c19 add test.txt
* 3b58100 第一次版本提交
```

如果我们忘了给某个提交打标签，又将它发布了，我们可以给它追加标签。

例如，假设我们发布了提交 85fc7e7(上面实例最后一行)，但是那时候忘了给它打标签。 我们现在也可以：

```bash
$ git tag -a v0.9 85fc7e7
$ git log --oneline --decorate --graph
*   d5e9fc2 (HEAD -> master) Merge branch 'change_site'
|\
| * 7774248 (change_site) changed the runoob.php
* | c68142b 修改代码
|/
* c1501a2 removed test.txt、add runoob.php
* 3e92c19 add test.txt
* 3b58100 (tag: v0.9) 第一次版本提交
```

如果我们要查看所有标签可以使用以下命令：

```bash
$ git tag
v0.9
v1.0
```

## 推送标签到远程仓库

默认情况下，git push 不会推送标签，你需要显式地推送标签。

```bash
git push origin <tagname>
```

推送所有标签：

```bash
git push origin --tags
```

## 删除轻量标签

本地删除：

```bash
git tag -d <tagname>
```

远程删除：

```bash
git push origin --delete <tagname>
```

## 附注标签

附注标签存储了创建者的名字、电子邮件、日期，并且可以包含标签信息。附注标签更为正式，适用于需要额外元数据的场景。

创建附注标签语法：

```bash
git tag -a <tagname> -m "message"
```

```bash
git tag -a <tagname> -m "runoob.com标签"
```

PGP 签名标签命令：

```bash
git tag -s <tagname> -m "runoob.com标签"
```

查看标签信息：

```bash
git show <tagname>
```

## 实例

以下是一个综合示例，演示如何创建、查看、推送和删除标签。

创建轻量标签和附注标签：

```bash
git tag v1.0
git tag -a v1.1 -m "runoob.com标签"
```

查看标签和标签信息：

```bash
git tag
git show v1.1
```

推送标签到远程仓库：

```bash
git push origin v1.0
git push origin v1.1
git push origin --tags  # 推送所有标签
```

## 删除标签

本地删除：

```bash
git tag -d v1.0
```

远程删除：

```bash
git push origin --delete v1.0
```

---

**系列导航：** [← Git 查看提交历史](08-Git查看提交历史.md)　·　[目录](00-Git教程目录.md)　·　[Git 远程仓库（Github） →](10-Git远程仓库-Github.md)
