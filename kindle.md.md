# Kindle

这些年我在 Amazon 上买了几近千本的电子书（其中相当一部分配有有声版的 Audiobook）。在 iOS（iPad/iPhone）上体验还算可以，有 Kindle App，也有 Audible App —— 唯一的缺陷是，每次换设备的时候，都得重新下载一遍，并且，Amazon 的开发人员执拗地在这么多年过后也不给加一个「全部下载」的方式…… 我甚至开始不讲道理地怀疑这帮鸟人自己的 Kindle 里都不超过十本书，所以才不把「下载全部」当回事儿。

MacOS 上一直就没有 Audible，得通过 iTunes 转手一遍，非常讨厌；而 Kindle App 就更讨厌了，一直保持着远古时代的 UI 不说，这都好多年了，坚决不给加上「如果有配套有声书的话就可以边朗读边划线阅读」的功能 —— 而这功能恰恰是 iOS 上的 Kindle App 最令人喜欢的，乃至于其它功能差一点都能因此忍受的……

MacOS Big Sur 刚推出的时候，增加了个功能，就是 iOS 的 App 可以直接安装到 MacOS 上 —— 真是太棒了！可惜，没高兴几天，苹果给了开发者一个选择，Amazon 的开发者选择的结果是，在 MacOS 上不能安装 Kindle for iOS，在 MacOS 只能接着用他们那个愚蠢到死的桌面版本 —— Kindle for Desktop 的团队就应该直接解散掉啊！一个常年只能打两颗星的产品，不应该着急一点吗？

现在在 MacOS App Store 里搜索 Kindle（iPhone & iPad Apps）不再显示 Kindle 了，搜出来的都是不相干的玩意……

于是，想到了个办法：

> 在 MacOS 上跑个虚拟机不就行了吗？！

结果，直接就卡在新的 Macbook 的芯片架构上，当下绝大多数流行的安卓虚拟机（emulator）都不支持 M1（Apple Silicon）芯片…… 连那些完整的虚拟机软件，VirtualBox、VMWare、Parellel Desktop 等等都做不到全面支持。

忍了好几个月，终于听说，Android Studio（Bumblebee 版本的预览版）里面的 Emulator 可以在 M1 芯片上跑了…… 于是，赶紧下载，赶紧弄。

> https://developer.android.com/studio/preview/index.html

测试过后，果真是「救命」的好家伙！

现在我可以在 MacOS 上用这样的方式看 Kindle 里的有声电子版了：

![screenshot-running-kindle-apk](https://user-images.githubusercontent.com/152970/128582754-43ac7c41-44a2-4bcb-bf67-a0fc5f21fe2b.png)

## 安装设置过程

下载 Android Studio Preview 并安装好之后，打开它，需要操作的地方在一个「隐藏」的位置，`More Actions > Virtual Device Manager`……

![Virtual Device Manager](https://user-images.githubusercontent.com/152970/128582776-568a858e-7ca8-475f-b386-7fef38479bb3.png)

在随后的窗口中，点击左上角的 Create Device，随后看到的是一个虚拟机设置向导…… 第一步是 `Select Hardware`，我选的是 `Phone > Pixel XL`
![Select Hardware](https://user-images.githubusercontent.com/152970/128582801-33681569-7817-462e-a352-937c9975bb82.png)
然后是 `Select System Image`，随便选一个，关键是要用 `arm64-v8a` 的镜像（第一次安装的时候，可能需要下载）:
![Select System Image](https://user-images.githubusercontent.com/152970/128582820-8e46a00d-45ec-4a42-bc1e-9c12e84c2d21.png)
向导的最后一步是进行设置。点击一下 `Show Advanced Settings` 按钮，里面的设置都要调整一下
![Virtual Device Configuration](https://user-images.githubusercontent.com/152970/128582845-8b15db0b-2043-4636-a15b-1763019ef7d3.png)
这里的设置稍微多一点：

> * AVD Name，最好设置的简单点，比如，我就直接用了 `Pixel` 这么个简单名称（一会儿会知道简单的名称会更方便）；
> * Camera，Front 和 Back，都被我设置成了 `None`，反正就是用来看 Kindle 听 Audible，摄像头肯定用不着；
> * Network，Speed 选择 `Full`，Latency 当然是 `None`；
> * Emulated Performance 里，Graphics，选择 `Hardware - GLES 2.0`；
> * Boot Option，我选了 `Soft boot`；
> * 然后还要注意勾选 Multi-Core CPU；Memory and Storage 里，RAM 设置大一点，`2048 MB`；VM heap 也可以大一些；`1024 MB`、Internal Storage 要更大一些，`16 GB` —— 毕竟要下载很多有声书；SD card，直接选 `No SDCard` 算了；
> * Device Frame，去掉 Enable Device Fram 之前的勾；
> * Keyboard，必须勾选 Enable keyboard input……

然后就可以点击 `Finish` 按钮，完成所有设置了。

现在，Device Manger 里就有了一个虚拟机，随时可以打开……
![Device Manager](https://user-images.githubusercontent.com/152970/128583044-82690418-6e0b-46d6-82f9-b281480eb7fe.png)
最后剩下一个小问题，就是每次想要开虚拟机的时候，要先打开 Android Studio Preview，然后再点击两次鼠标才能打开 Device Manager，然后还要去点那个很小的绿色「播放」按钮……

简洁点的办法是用命令行打开。在 Terminal 里执行以下命令即可：
```bash
$HOME/Library/Android/sdk/emulator/emulator @Pixel
```
当然，还可以在 `.zshrc` 里加上一个 `alias`，我是这么做的：
```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
alias pixel="$ANDROID_SDK_ROOT/emulator/emulator @Pixel"
```
至于如何往 Android 虚拟机里安装程序，我是这么做的，到 apkpure.com 下载即可：

> * https://apkpure.com/amazon-kindle/com.amazon.kindle
> * https://apkpure.com/audible-audiobooks-podcasts-audio-stories/com.audible.application

下载到本地的 apk 文件，直接拖进 Android 虚拟机窗口就自动安装了……

有个细节就是，你得在 Android 的虚拟机设置里把 `Do Not Disturb`（即，勿扰）选项打开，否则叮叮咚咚烦死你……

于是，我的 Android 虚拟机设置过后，打开是这样的：
![Android Emulator](https://user-images.githubusercontent.com/152970/128583103-4fcb2480-b9d2-498c-baac-51ef399f3aeb.png)

后来还是觉得在 Terminal 里使用命令行打开 emulator 的缺点是那个 Terminal 窗口得一直开着，很讨厌…… 

于是，继续折腾，Google 大法从来都不会令人失望的。然后，就找到了个办法，可以将一个 shell command 包装成一个 MacOS 可以运行的 app，用这么个叫做 `appify` 的脚本程序就可以了：

详细操作步骤可参见这篇文章：https://mathiasbynens.be/notes/shell-script-mac-apps

改良过后的 `appify` 脚本在这里：https://gist.github.com/xiaolai/dda9d5715f8ee74f079d3f449ef9b351

我的 pixel.sh 内容：

``` zsh
#!/bin/zsh
$HOME/Library/Android/sdk/emulator/emulator @Pixel
```

> ### 注意：
> * Bigsur 之后，Terminal 默认 shell 是 `zsh` 了，而不是 `bash`；
> * 要使用 emulator 的完整路径，否则，app 无法从 Finder 中打开……

然后你就有了个看起来是独立的 App，可以随时在 Spotlight 里呼出（我是用 Alfred 替代）：

<img width="574" align="center" alt="spotlight-alfred" src="https://user-images.githubusercontent.com/152970/128583248-16d0fed0-6a7e-4d23-b5fd-8ee514817fad.png">

大功告成。

站在工作台前的走步机上，边走边看边听，的确是我要的效果 —— 并且，又由于是在 Mac 上，随时可以打开浏览器 Google 必要的东西……

-----

补充 1：后来找了个更好看一点的 icon，是这个

![Dark-Pixel-Icon-PackNova-Apex](https://user-images.githubusercontent.com/152970/129311439-e7af3051-46ae-442a-8ded-f018c8b4c598.png)

补充 2：

模拟器的时间不知道为什么与系统时间不符，需要在 Terminal 中执行以下命令：

```bash
adb shell su root "date $(date +%m%d%H%M)"
```

补充 3：除了安装 Android 模拟器这个方法之外，还有另外一个办法，用 [Sideloadly](https://sideloadly.io/) —— 官网上的教程已经足够详细。问题在于，到哪里去找 Unsigned IPA。两个办法，1）自己越狱一个 iOS 设备，而后继续折腾；2）用 Tor-Browser 到 https://appdb.to 找；3）直接用这个两个链接（不保证随时更新）Kindle、Audible。