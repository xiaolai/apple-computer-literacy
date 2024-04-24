# Mechvibes

[Mechvibes](https://mechvibes.com/) 是个看起来挺无聊的小软件，为键盘配置个性化的声音，比如，模拟机械键盘的敲击声…… 有 macOS/Windows/Linux 各种版本。

学日语的时候，我用它为每个键盘对应的日文字母配置了发声文件，用来让自己快速适应日文键盘，超级好用。

日文字母的发声文件，是用 edge_TTS 生成的，Python 代码片段也很简单：

```python
import asyncio
import edge_tts
import pygame
import time

voice = "ja-JP-NanamiNeural"

string = "49,ぬ;50,ふ;51,あ;52,う;53,え;54,お;55,や;56,ゆ;57,よ;48,わ;189,ほ;187,へ;81,た;87,て;69,い;82,す;84,か;89,ん;85,な;73,に;79,ら;80,せ;65,ち;83,と;68,し;70,は;71,き;72,く;74,ま;75,の;76,り;186,れ;186,け;221,む;90,つ;88,さ;67,そ;86,ひ;66,こ;78,み;77,も;188,ね;190,る;191,め;189,ろ;222,ろ"
pairs = string.split(";")

for p in pairs:
    key, value = p.split(",")
    output_file_name = f"{value}.mp3"
    communicate = edge_tts.Communicate(value, voice)
    await communicate.save(output_file_name)
    time.sleep(3)
    # print(f'"{key}": "{value}.mp3",')

```

下载 [japanese-keyboard-sound.zip](files/japanese-keyboard-sound.zip)，解压缩，拷贝到 `~/mechvibes_custom` 文件夹内，重新启动 Mechvibes，即可选择自定义键盘声音包。