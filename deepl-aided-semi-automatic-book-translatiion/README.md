# 用 Python 脚本调用 DeepL API Pro 进电子书的行自动翻译

## 1. 概述

脚本跑起来的效果大致如下：

![](images/deepl-api-python.gif)

一本书中文译文大约 **39 万字**的书，差不多用 **1.5 小时**就可以处理完毕（包括基本的格式编辑）。

## 2. 使用 jupyterlab 运行脚本进行前期工作

如何安装使用 Jupyterlab，请参照[这篇文章](../jupyterlab.md)

Python 脚本，`ipynb`  文件请参照[这篇文章](deepl-automatic-html-translation.ipynb)（ipynb 文件）

## 3. 后期使用 VSCode 进行校对

请参照[这篇文章](translation-workflow.md)。

## 4. 示例文件

`John Law` 文件夹里是一本书，包含 `epub`、`htmlz` 以及随后工作过程中生成的若干个 `html` 文件和最终修改过的 `style.css` 文件

