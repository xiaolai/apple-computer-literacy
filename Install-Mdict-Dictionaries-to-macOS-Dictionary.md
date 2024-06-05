# Mdict 词典转换

## 0. Mdict 格式词典下载

[freemdict.com](https://downloads.freemdict.com/) 和 [mdict.org](https://mdx.mdict.org/)上有很多 Mdict 格式的词典文件。Mdict 的词典文件，通常由一个 `.mdx` 文件和一个 `.mdd` 文件构成，声音和图片都打包在 `.mdd` 文件之中。需要同时下载两个文件，放到同一个目录中进行处理。

**推荐**

* [Cambridge Advanced Learner's Dictionary 4ed](https://downloads.freemdict.com/Recommend/Collections/_Cambridge/CALD%204th/)
* [Merriam-Webster's Collegiate Dictionary 11ed (Pic&Sound)](https://downloads.freemdict.com/Recommend/Collections/Merriam-Webster/Merriam-Webster/Merriam-Webster/)
* [Longman Dictionary of Contemporary English 6ed](https://downloads.freemdict.com/Recommend/Collections/_Longman/STFU%20LongmanBundle-%E7%BB%AE%E5%8F%A5%E6%85%A8%E9%90%97-By%20Amazon%2020160928/Longman%20Dictionary%20Of%20Contemporary%20English%206th%20EnEn)
* [Longman Language Activator](https://downloads.freemdict.com/Recommend/longman-activator.zip)
* [Collins CoBuild Advanced Learner's Dictionary](https://downloads.freemdict.com/Recommend/CollinsCOBUILDAdvancedLearner%E2%80%99sDictionaryOnline2017.zip)
* [American Heritage Dictionary 5ed](https://downloads.freemdict.com/Recommend/AHD5.zip)
* [Oxford Collocation Dictionary](https://mdx.mdict.org/%E5%85%AD%E5%A4%A7%E7%9F%A5%E5%90%8D%E8%AF%8D%E5%85%B8/%E7%89%9B%E6%B4%A5_Oxford/Oxford%20Collocations%20Dictionary_%2015-10-15/)

事实上，前两个就已经足够了（都是有声词典）……

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

## 8. 捷径

若是懒得折腾，可以在百度网盘下载一个压缩包，解压缩后，把其中六个词典目录挪到 `~/Library/Dictionaries` 目录之下即可，重新启动 Dictionary.app，`cmd+,` 在对话框里选择新安装的词典。

链接: https://pan.baidu.com/s/1TpYyYYdvFGsMLI65i7NBog?pwd=buqn 提取码: buqn

> * Cambridge Advanced Learner's Dictionary.dictionary
> * Collins COBUILD Advanced Learner's Dictionary.dictionary
> * Merriam-Webster's Collegiate Dictionary.dictionary
> * Longman Dictionary of Contemporary English 6ed.dictionary
> * Longman Language Activator.dictionary
> * Oxford Collocation Dictionary.dictionary
以下目录带'会导致声音文件读取不了。 挪到~/Library/Dictionaries目录之下，将这些目录名用驼峰命名法进行如下修改，重新启动 Dictionary.app，`cmd+,` 在对话框里选择新安装的词典。
> * Cambridge Advanced LearnerS Dictionary.dictionary
> * Collins COBUILD Advanced LearnerS Dictionary.dictionary
> * Merriam-WebsterS Collegiate Dictionary.dictionary
