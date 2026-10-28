---
title: "git pull 命令"
source: "https://www.runoob.com/git/git-pull.html"
series: "菜鸟教程 Git 教程"
kind: "命令"
order: 23
parent: "Git 基本操作"
tags:
  - Git
  - 菜鸟教程
---

# git pull 命令

> 来源：[菜鸟教程 · git pull 命令](https://www.runoob.com/git/git-pull.html)　·　系列第 23 / 40 篇

> 所属章节：[Git 基本操作](06-Git基本操作.md)

**git pull** 命令用于从远程获取代码并合并本地的版本。

**git pull** 其实就是 `git fetch` 和 `git merge` 的简写，先从远程仓库获取最新的提交记录，然后将这些提交记录合并到你当前的分支中。

命令格式如下：

```bash
git pull [远程仓库名] [分支名]
```

- `[远程仓库名]` 通常是 `origin`，是默认的远程仓库名。
- `[分支名]` 是你要合并的远程分支，比如 `main` 或 `master`。

## 实例

更新操作：

```bash
$ git pull
$ git pull origin
```

将远程主机 origin 的 master 分支拉取过来，与本地的 brantest 分支合并。

```bash
git pull origin master:brantest
```

如果远程分支是与当前分支合并，则冒号后面的部分可以省略。

```bash
git pull origin master
```

上面命令表示，取回 origin/master 分支，再与本地的 brantest 分支合并。

上面的 pull 操作用 fetch 表示为：

以我的 <https://github.com/tianqixin/runoob-git-test> 为例，远程载入合并本地分支。

```bash
$ git remote -v  # 查看信息
origin    https://github.com/tianqixin/runoob-git-test (fetch)
origin    https://github.com/tianqixin/runoob-git-test (push)

$ git pull origin master
From https://github.com/tianqixin/runoob-git-test
 * branch            master     -> FETCH_HEAD
Already up to date.
```

上面命令表示，取回 origin/master 分支，再与本地的 master 分支合并。

---

**系列导航：** [← git fetch 命令](22-git-fetch.md)　·　[目录](00-Git教程目录.md)　·　[git push 命令 →](24-git-push.md)
