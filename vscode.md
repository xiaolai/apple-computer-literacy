# Visual Studio Code

## 使用 "SauceCodePro Nerd" 字体

Settings UI 里没有对 Font-Weight 的选项，所以，只能在 `settings.json` 里编辑设置：

```json
    // 在文件最末位 `}` 的上一行添加：
    "editor.fontFamily": "'SauceCodePro Nerd Font Mono'",
    "editor.fontSize": 17,
    // 相当于 ExtraLight：
    "editor.fontWeight": "200",
    // 不要忘记设置 Terminal 窗口的字体
    "terminal.integrated.fontSize": 16,  
    "terminal.integrated.fontWeight": "200",
```

## 使用独立的 User Profile 文件夹

命令行中使用以下命令：

```bash
code --extensions-dir $HOME/.vscode/js/extentions --user-data-dir $HOME/.vscode/js/user"
```

* 在 `~/.vscode/js/extentions/` 里保存扩展插件；
* 在 `~/.vscode/js/user/` 里保存用户设置……


