# Mdict 词典转换

## 0. Mdict 格式词典下载

[freemdict.com](https://downloads.freemdict.com/) 上有很多 Mdict 格式的词典文件。Mdict 的词典文件，通常由一个 `.mdx` 文件和一个 `.mdd` 文件构成，声音和图片都打包在 `.mdd` 文件之中。需要同时下载两个文件，放到同一个目录中进行处理。

**推荐**

* [Cambridge Advanced Learner's Dictionary 4ed](https://downloads.freemdict.com/Recommend/Collections/_Cambridge/CALD%204th/)
* [Merriam-Webster's Collegiate Dictionary 11ed (Pic&Sound)](https://downloads.freemdict.com/Recommend/Collections/Merriam-Webster/Merriam-Webster/Merriam-Webster/)
* [Longman Dictionary of Contemporary English 5ed](https://downloads.freemdict.com/Recommend/LDOCE5%2B%2B%20V%201-35.zip) 
* [Collins CoBuild Advanced Learner's Dictionary](https://downloads.freemdict.com/Recommend/CollinsCOBUILDAdvancedLearner%E2%80%99sDictionaryOnline2017.zip)
* [American Heritage Dictionary 5ed](https://downloads.freemdict.com/Recommend/AHD5.zip)

事实上，前两个就已经足够了，两个都是有声词典……

## 1. 所需工具与环境

```bash
# Python (python 3.11.5 specified)
conda create -n mdict python=3.11.5
conda activate mdict
pip install pyglossary lxml beautifulsoup4 html5lib

# install Homebrew; if brew already installed, skip this section.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# speex for converting spx to wav
brew install speex

# ffmpeg for converting wav to mp3
brew install ffmpeg
```

另外，还需要下载 `Dictionary Development Kit`

* 下载地址：[Additional Tools for Xcode](http://developer.apple.com/downloads)

* 下载与操作系统中安装的 xcode 匹配的 “Additional Tools for Xcode”
  ```bash
  # check out xcode version
  xcodebuild -version
  ```

* 将其中 `Utilities` 下的 `Dictionary Development Kit` 目录整体拷贝粘贴到本机 `/Applications/Utilities` 下

* 用以下代码替换 `/Applications/Utilities/Dictionary Development Kit/bin/build_dict.sh` 的第 `221` 行：

  ```bash
  rsync -a "$OTHER_RSRC_DIR"/ "$OBJECTS_DIR"/dict.dictionary/"$CONTENTS_DATA_PATH" || error "Error."
  ```

## 3. 转换 mdx

`pyglossary` 使用方法如下：

```bash
pyglossary --write-format=AppleDict <mdx_file> <output_dir>
```

以 `Merriam-Webster\'s_Collegiate_Dictionary_11th\(Pic\&Sound\).mdx` 为例：

```bash
pyglossary --write-format=AppleDict Merriam-Webster\'s_Collegiate_Dictionary_11th\(Pic\&Sound\).mdx "Merriam-Webster's Collegiate Dictionary"
```

## 4. spx 文件的转换

如果 `OtherResources` 目录里的声音文件原本就是 `.mp3` 就可以跳过这一步。但，如果是 `.spx` 的话，就需要将 `.spx` 文件转换为 `.mp3` 文件：

```bash
# long time needed, possibly up to an hour or more...
for file in *.spx; do
    # Decode the SPX to WAV
    speexdec "$file" "${file%.spx}.wav"
    # Encode the WAV to MP3
    ffmpeg -i "${file%.spx}.wav" -f mp3 "${file%.spx}.mp3"
    # Optionally remove the intermediate SPX file    
    rm "$file"
    # Optionally remove the intermediate WAV file
    rm "${file%.spx}.wav"    
done
```

而后，`xml` 文件里的声音文件名也需要转换（可以提前用 vscode 或者 sublime text 打开 xml 查看一下，根据需要批量替换的字符串修改以下命令）

```bash
sed -i '' 's/\.spx/\.mp3/g' file.xml
```

如果需要将 `.wav` 文件批量转换为 `.mp3`：

```bash
for file in *.wav; do
    ffmpeg -i "$file" -f mp3 "${file%.wav}.mp3"
    # Optionally remove the intermediate WAV file    
    rm "$file"
done
```

## 5. 其它定制信息

`pyglossary` 生成的文件中，`.css` 文件，可根据自己需要修改。

macOS 原生词典里面是不支持 `base64` 格式的字体文件的，所以我们需要手动将原先css里面base64格式的字体转换成它原来的样子并放到 `Contents` 文件夹下。

[Base64 Online - base64 decode and encode (motobit.com)](https://www.motobit.com/util/base64-decoder-encoder.asp)

`.plist` 文件中，`CFBundleName` 是词典缩写（显示在词典的标签栏上），`CFBundleDisplayName` 是词典名称的完整名称（显示在 Preference 对话框中），可根据自己需要修改。

## 6. 安装词典

```bash
cd "Merriam-Webster's Collegiate Dictionary"
make
```

生成的词典在 `objects` 目录中。

安装词典到 `~/Library/Dictionaries`：

```bash
make install
```

而后就可以在 Dictionary 里，`cmd+,` 在对话框里选择新安装的词典了。

## 7. 删除词典

在 `~/Library/Dictionaries` 目录中将词典的整个目录删掉即可。
