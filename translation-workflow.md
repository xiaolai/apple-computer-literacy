# 翻译工作环境

## 电子书转换路径

Kindle > ePubor Ultimate > Calibre > htmz > vscode editing.

## 浏览器自动重载（Auto-reload）

参见这篇文章：

https://medium.com/@svinkle/start-a-local-live-reload-web-server-with-one-command-72f99bc6e855

## VS Code 插件

* Chinese Translation
* DeepL for Visual Studio Code
* ssmacro

## 一些代码

`vscode-deepl automation`

```applescript
tell application "Visual Studio Code"
	activate
	delay 2
	tell application "System Events"
		key code 37 using command down
		delay 1
		key code 8 using command down
		key code 8 using command down
	end tell
end tell

delay 5

tell application "Visual Studio Code"
	activate
	delay 2
	tell application "System Events"
		key code 124 using command down
		key code 124 using command down
		key code 36 using command down
	end tell
end tell

tell application "System Events"
	tell process "DeepL" to tell window 1
		activate
		set w_position to its position
		set w_size to its size
	end tell
end tell

set px to item 1 of w_position
set py to item 2 of w_position
set sx to item 1 of w_size
set sy to item 2 of w_size

tell application "System Events"
	click at {px + sx - 190, py + sy - 95} -- Insert to link		
end tell
```

`keybindings.json`

```json
[
  {
    "key": "ctrl+shift+9",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "（$TM_SELECTED_TEXT$0）"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+'",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "“$TM_SELECTED_TEXT$0”"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+'",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "‘$TM_SELECTED_TEXT$0’"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+[Backslash]",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "【$TM_SELECTED_TEXT$0】"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+[Slash]",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "《$TM_SELECTED_TEXT$0》"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+[BracketRight]",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "「$TM_SELECTED_TEXT$0」"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+[BracketLeft]",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "『$TM_SELECTED_TEXT$0』"},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+alt+cmd+-",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": " —— "},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+=",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": " $TM_SELECTED_TEXT$0 "},
    "when": "editorTextFocus&&editorHasSelection"
  },
  {
    "key": "ctrl+shift+-",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<p></p>"},
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+alt+cmd+a",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<a href=\"\" target=\"_blank\">$TM_SELECTED_TEXT$0</a>"},
    "when": "editorTextFocus&&editorHasSelection&&editorLangId==html"
  },  
  {
    "key": "ctrl+alt+cmd+b",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<strong>$TM_SELECTED_TEXT$0</strong>"},
    "when": "editorTextFocus&&editorHasSelection&&editorLangId==html"
  },
  {
    "key": "ctrl+alt+cmd+i",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<em>$TM_SELECTED_TEXT$0</em>"},
    "when": "editorTextFocus&&editorHasSelection&&editorLangId==html"
  },
  {
    "key": "ctrl+alt+cmd+u",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<u>$TM_SELECTED_TEXT$0</u>"},
    "when": "editorTextFocus&&editorHasSelection&&editorLangId==html"
  },
  {
    "key": "ctrl+alt+cmd+d",
    "command": "editor.action.insertSnippet",
    "args": {"snippet": "<del>$TM_SELECTED_TEXT$0</del>"},
    "when": "editorTextFocus&&editorHasSelection&&editorLangId==html"
  },{
    "key": "ctrl+tab",
    "command": "cursorRight",
    "when": "editorTextFocus&&!editorHasSelection"
  },
  {
    "key": "ctrl+alt+cmd+backspace",
    "command": "editor.emmet.action.removeTag"
  },
  {
    "key": "ctrl+shift+right",
    "command": "editor.emmet.action.matchTag",
    "when": "editorTextFocus&&editorLangId==html"
  },
  {
    "key": "ctrl+shift+l",
    "command": "editor.emmet.action.wrapWithAbbreviation"
  },
  {
    "key": "cmd+k b",
    "command": "workbench.action.toggleSidebarVisibility"
  },
  {
    "key": "shift+alt+d",
    "command": "editor.action.duplicateSelection"
  }
  ,{
    "key": "ctrl+alt+cmd+\\",
    "command": "ssmacro.macro",
    "args": {"file": "regex.json"},
    "when": "editorTextFocus"
  }
]
```

`regex.json`

```json
[
  {
    "command": "expandLineSelection"
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "直引号变成弯引号",
        "find": "\\s*\"(.*?)\\s*\"",
        "replace": "“$1”",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "直引号变成弯引号",
        "find": "\\s*'(.*?)\\s*'",
        "replace": "‘$1’",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "上一步误伤的直引号",
        "find": "=“(.*?)”",
        "replace": "=\"$1\"",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "省略号",
        "find": "\\.{2,}\\s*",
        "replace": "…… ",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "破折号",
        "find": "&mdash；|—",
        "replace": " —— ",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "姓名之间的 ·",
        "find": "([\u4e00-\u9fa5])-([\u4e00-\u9fa5])",
        "replace": "$1·$2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "姓名之间的 ·",
        "find": "([\u4e00-\u9fa5])-([\u4e00-\u9fa5])",
        "replace": "$1·$2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "数字前的空格",
        "find": "([\u4e00-\u9fa5])(\\d)",
        "replace": "$1 $2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "数字后的空格 —— 含 %",
        "find": "([\\d%])([\u4e00-\u9fa5])",
        "replace": "$1 $2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "英文字母前的空格",
        "find": "([\u4e00-\u9fa5])(\\w)",
        "replace": "$1 $2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },   
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "英文字母后的空格",
        "find": "(\\w)([\u4e00-\u9fa5])",
        "replace": "$1 $2",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "后：斜体英文与汉字之间的空格",
        "find": "([\u4e00-\u9fa5])<i",
        "replace": "$1 <i",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "前：斜体英文与汉字之间的空格",
        "find": "i>([\u4e00-\u9fa5])",
        "replace": "i> $1",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.replace",
    "args": {
        "info": "双引号前的逗号",
        "find": "，”",
        "replace": "”，",
        "all": false,
        "reg": true,
        "flag": "gm"
    }
  },
  {
    "command": "ssmacro.right"
  }
]
```
