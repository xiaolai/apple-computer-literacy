# Jupyterlab-Desktop

[JupyterLab Desktop](https://github.com/jupyterlab/jupyterlab-desktop) 是用 Electron 包装好的独立跨平台 App，免除了用户手动安装环境与各种依赖的麻烦。可以抽空阅读一下[详细的官方用户指南](https://github.com/jupyterlab/jupyterlab-desktop/blob/master/user-guide.md)。

MacOS 上 `jlab` 命令行工具 `实际上并未安装` 这个 [bug](https://github.com/jupyterlab/jupyterlab-desktop/issues/655) 的解决（其实也谈不上是什么 bug，问题出在[MacOS 系统的读写权限默认设置……](https://github.com/jupyterlab/jupyterlab-desktop/blob/master/troubleshoot.md#macos-write-permission-issues)）：

```bash
sudo chmod 755 /Applications/JupyterLab.app/Contents/Resources/app/jlab
sudo ln -s /Applications/JupyterLab.app/Contents/Resources/app/jlab /usr/local/bin/jlab
```

—— 当然，前提是 `.zshrc` 文件里定义过 `/usr/local/bin` 这个系统默认搜寻路径（$PATH）。

