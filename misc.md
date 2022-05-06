# Miscellaneous

## 1. 鼠标点击任何位置移动窗口

从 MacOS High Sierra 开始，可以将窗口移动动作设置为 “用鼠标点击窗口任意位置进行拖动”（而非 “必须通过点击并拖动窗口标题栏”）—— 就好像是在 Linux 操作系统那样……

![](images/moving-windows.gif)

在 Terminal 中输入：

```bash
defaults write -g NSWindowShouldDragOnGesture -bool true
```

而后重新登录系统。

取消以上操作的方式是，在 Terminal 中输入：

```bash
defaults delete -g NSWindowShouldDragOnGesture
```