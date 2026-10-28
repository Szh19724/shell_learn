---
title: "git diff 命令"
source: "https://www.runoob.com/git/git-diff.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 16
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git diff 命令

> 来源：[菜鸟教程 · git diff 命令](https://www.runoob.com/git/git-diff.html)　·　系列第 16 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

git diff 命令比较文件的不同，即比较文件在暂存区和工作区的差异。

git diff 命令显示已写入暂存区和已经被修改但尚未写入暂存区文件的区别。

git diff 有两个主要的应用场景。

- 尚未缓存的改动：**git diff**
- 查看已缓存的改动： **git diff --cached**
- 查看已缓存的与未缓存的所有改动：**git diff HEAD**
- 显示摘要而非整个 diff：**git diff --stat**

显示暂存区和工作区的差异:

```bash
$ git diff [file]
```

显示暂存区和上一次提交(commit)的差异:

```bash
$ git diff --cached [file]
或
$ git diff --staged [file]
```

显示两次提交之间的差异:

核心区别只有一个：**比较的两端不一样。**

| 命令                         | 比较对象                     | 回答的问题                         |
| -------------------------- | ------------------------ | ----------------------------- |
| `git diff [file]`          | **工作区** ↔ **暂存区（index）** | 我改了但**还没 `git add`** 的内容有哪些？  |
| `git diff --cached [file]` | **暂存区** ↔ **上次提交（HEAD）** | 我**已经 `git add`、准备提交**的内容有哪些？ |

`--cached` 也可以写成 `--staged`，两者完全等价。

```bash
$ git diff [first-branch]...[second-branch]
```

在 hello.php 文件中输入以下内容：

```bash
<?php
echo '菜鸟教程：www.runoob.com';
?>
```

使用 git status 查看状态：

**示例**

```bash
$ git status -s
A  README
AM hello.php
$ git diff
diff --git a/hello.php b/hello.php
index e69de29..69b5711 100644
--- a/hello.php
+++ b/hello.php
@@ -0,0 +1,3 @@
+<?php
+echo '菜鸟教程：www.runoob.com';
+?>
```

git status 显示你上次提交更新后的更改或者写入缓存的改动， 而 git diff 一行一行地显示这些改动具体是啥。

接下来我们来查看下 `git diff --cached` 的执行效果：

**示例**

```bash
$ git add hello.php
$ git status -s
A  README
A  hello.php
$ git diff --cached
diff --git a/README b/README
new file mode 100644
index 0000000..8f87495
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+# Runoob Git 测试
diff --git a/hello.php b/hello.php
new file mode 100644
index 0000000..69b5711
--- /dev/null
+++ b/hello.php
@@ -0,0 +1,3 @@
+<?php
+echo '菜鸟教程：www.runoob.com';
+?>
```

---

**系列导航：** [← git status 命令](15-git-status.md)　·　[目录](00-Git教程目录.md)　·　[git commit 命令 →](17-git-commit.md)
