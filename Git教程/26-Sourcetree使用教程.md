---
title: "Sourcetree 使用教程"
source: "https://www.runoob.com/git/source-tree-intro.html"
series: "菜鸟教程 Git 教程"
kind: "教程"
order: 26
tags:
  - Git
  - 菜鸟教程
---

# Sourcetree 使用教程

> 来源：[菜鸟教程 · Sourcetree 使用教程](https://www.runoob.com/git/source-tree-intro.html)　·　系列第 26 / 40 篇

> 说明：原站左侧目录标题为“Git Gitee”，正文标题为“Sourcetree 使用教程”。

![Sourcetree 使用教程 配图 1](assets/26-Sourcetree@2x-icon-blue.png)

Git 有很多图形界面工具 ( GUI )，比如 SourceTree、Github Desktop、TortoiseGit 等。

SourceTree 是一个 Git 客户端管理工具，适用于 Windows 和 Mac 系统。

SourceTree 简化了开发者与代码仓库之间的 Git 操作方式，我们可以通过界面菜单很方便的处理 Git 操作，而不需要通过命令。

通过 SourceTree，我们可以管理所有的 Git 库，无论是远程还是本地的。SourceTree 支持 Bitbucket、GitHub 以及 Gitlab 等远程仓库。

---

## Sourcetree 安装

我们可以在 Sourcetree 官网 <https://www.sourcetreeapp.com/> 直接点击下载按钮来下载：

![Sourcetree 使用教程 配图 2](assets/26-sourcetree-1.jpeg)

其他版本可以查看：<https://www.sourcetreeapp.com/download-archives>

下载完成后，解压 ZIP 文件，双击应用程序文件（Windows 为 EXE 或 Mac 为 DMG）进行安装。

安装过程中，我们只需要同意 Atlassian 客户协议并点击 Continue 即可。

![Sourcetree 使用教程 配图 3](assets/26-sourcetree_aa.png)

创建 Bitbucket 账户可跳过初始设置，加载 SSH 密钥，如果有会默认加载进来，也可以后面再设置。

![Sourcetree 使用教程 配图 4](assets/26-sourcetree_account.png)

按照提示操作，直到您完成设置。如果您还没有准备好克隆存储库，请单击 Skip Setup。

---

## 连接 Github 账户

如果你还没有 Github 账户需要创建一个，可以参考 [Git 远程仓库(Github)](10-Git远程仓库-Github.md)。

接下来我们将介绍使用 Sourcetree 管理我们的 Github 账户。

我们可以将多个帐户添加到 Sourcetree。

单击右上角的按钮并选择**帐户**。

![Sourcetree 使用教程 配图 5](assets/26-sourcetree-2.jpeg)

接下来我们通过添加账户按钮添加 Github 账户。

![Sourcetree 使用教程 配图 6](assets/26-sourcetree-3.jpeg)

Github 账户添加完成后，就可以直接克隆我们自己的账户：

![Sourcetree 使用教程 配图 7](assets/26-sourcetree-4.jpeg)

也可以克隆其他远程仓库：

![Sourcetree 使用教程 配图 8](assets/26-sourcetree-5.jpeg)

克隆完成后，我们就可以进行提交、拉取、合并等操作：

![Sourcetree 使用教程 配图 9](assets/26-sourcetree-6.jpeg)

---

## 创建本地仓库

单击**新建**，然后选择**创建本地仓库**。

![Sourcetree 使用教程 配图 10](assets/26-sourcetree-7.jpeg)

输入您的目标路径和存储库名称，然后点击**创建**。

![Sourcetree 使用教程 配图 11](assets/26-sourcetree-8.jpeg)

创建完成后就会显示在本地的列表中：

![Sourcetree 使用教程 配图 12](assets/26-sourcetree-9.jpeg)

如果我们本地已经存在一个仓库，可以直接添加它。

点击**新建**，然后 点击**添加已经存在的本地仓库**：

![Sourcetree 使用教程 配图 13](assets/26-sourcetree-10.jpeg)

---

**系列导航：** [← Git 测验](25-Git测验.md)　·　[目录](00-Git教程目录.md)　·　[git checkout 命令 →](27-git-checkout.md)
