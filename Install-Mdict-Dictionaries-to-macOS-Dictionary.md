# Mdict 词典转换

## 0. Mdict 格式词典下载

[freemdict.com](https://downloads.freemdict.com/)

## 1. 所需工具与环境

```bash
# Python
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

下载 mdx 以及相应的 mdd 文件，之后，在同一目录下执行（以 `Merriam-Webster\'s_Collegiate_Dictionary_11th\(Pic\&Sound\).mdx` 为例）：

```bash
pyglossary --write-format=AppleDict Merriam-Webster\'s_Collegiate_Dictionary_11th\(Pic\&Sound\).mdx "Merriam-Webster's Collegiate Dictionary"
```

后面引号中的 `Merriam-Webster's Collegiate Dictionary` 将成为导入苹果内建词典后的名称。

## 4. spx 文件的转换

将 `.spx` 文件转换为 `.mp3` 文件，需要使用 `speexdec` 和 `ffmpeg`：

```bash
# long time needed, like half an hour or so...
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

而后，`xml` 文件里的声音文件名也需要转换

```bash
sed -i '' 's/\.spx/\.mp3/g' file.xml
```

## 5. 其它定制信息

`pyglossary` 生成的文件中，`.css` 文件，可根据自己需要修改。

[Base64 Online - base64 decode and encode (motobit.com)](https://www.motobit.com/util/base64-decoder-encoder.asp)

`.plist` 文件中，`CFBundleDisplayName` 是词典缩写（显示在词典的标签栏上），`CFBundleName` 是词典名称的完整名称（显示在 Preference 对话框中），可根据自己需要修改。

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
