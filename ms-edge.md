# Microsof Edge Browser

微软的浏览器，Edge，是基于 Google 的 Chrome 制作的。最近的新版本中，Edge 推出了基于 AI 的「自动朗读文本」…… 这其实并不是一个新鲜功能 —— IBM Voice 推出（1997）到现在都已经 24 年了…… 当时在 Windows 95 上试用这个功能的时候，纯粹是「鸡肋」的感觉。

![1](https://user-images.githubusercontent.com/152970/133545201-a3b90e34-2fcc-4920-a263-ba38f1e95cce.png)

然而，这一次的确不一样，从用户的角度，它不仅实用，而且真的很好 —— 起码，朗读已经基本上听不出「机器口音」了。

试用了一下之后，马上因为这个功能从各种浏览器中直接迁徙到了 Edge 上。想想微软也是很奇葩，弃用 Windows 的我在十年之后，发现手中用的东西，微软的还挺多，比如，github，vscode, 还有现在的这个 edge…

这个文本朗读功能（Read Aloud）在几天之内就彻底改变了我的新闻阅读习惯 —— 从过去「主要看新闻」直接变成了「只听新闻」…… 尤其是我现在整天站在工作台前的走步机上，更使得我喜欢这个文本朗读功能。

> 注意，经过一段时间的推荐和使用才发现，系统的地区设置如果是「中国」的话，朗读功能里的声音列表就没有「Natural」（自然语音）—— 所以，得在系统设置里把 Location 改成其他地方，比如 United States。

于是，干脆用 BetterTouchTool 设置了个快捷键，`Ctrl + R`，用来完成以下几个步骤：

> 1. 进入 Immersive Reading Mode
> 2. 打开 Read Aloud
> 3. 把浏览器窗口大小调整一下，变成一个长条… 文本朗读功能是有「自动翻页」，但，若是窗口小一点，偶尔看一眼文本的时候更方便… 你自己试试就知道了。

BetterTouchTool 现在是收费软件了（有 45 天试用期），但，它和 Alfred（也是收费软件）、Divvy 是我用 Mac 的必需 —— 没它们的电脑我都不敢想象该怎么使用……

1. 先添加一个快捷键，将其设置成 `^R` —— 也就是 `Ctrl + R`；

![2](https://user-images.githubusercontent.com/152970/133545519-55a7f92a-c442-43c1-9ae7-f8b02738e3f5.png)

2. 让 BetterTouchTool 将 `F9` 这个快捷键发送至 Microsoft Edge

![3](https://user-images.githubusercontent.com/152970/133545522-f77894f3-4768-4f45-aef0-fe113b408a40.png)

3. 让 BetterTouchTool 停顿 `2` 秒钟……

![4](https://user-images.githubusercontent.com/152970/133545523-0e933d78-ac0e-434b-b1cd-bd39ff587eb7.png)

4. 让 BetterTouchTool 点击 Microsoft Edge 的菜单，`Tools > Read Aloud > Turn On`，设置的时候，输入的是 `Tools;Read Aloud;Turn On`（注意，这里是区分大小写的！）

![5](https://user-images.githubusercontent.com/152970/133545524-784c8ccb-7840-43ee-b8ba-0f9e1bba7796.png)

5. 让 BetterTouchTool 执行一段 AppleScript，是用来重置窗口位置的：

![6](https://user-images.githubusercontent.com/152970/133545526-c49a6065-e750-4937-b32d-ba1956ab86b6.png)

代码如下：
```applescript
tell application "Microsoft Edge"
    set bounds of front window to {0, 0, 800, 300}
end tell
```
就这样。

## 一些插件插件

Microsoft Edge 是基于 Google Chrome 的，所以，它们的插件是通用的。

有些我常用的插件，罗列在下面：

* [Download All Images](https://microsoftedge.microsoft.com/addons/detail/download-all-images/hpceppbbhmfebdnpaeiififakbogkgfa)
* [EpubReader](https://microsoftedge.microsoft.com/addons/detail/epubreader/gbfdomjljjkagpgdlidoicebkgpienmf?hl=en-US) 用这个插件可以打开 epub 文件，于是，任何电子书，瞬间变成了「有声书」……
* [Alex Traffic Rank](https://chrome.google.com/webstore/detail/alexa-traffic-rank/cknebhggccemgcnbidipinkifmmegdel) 毕竟，很多时候，一个网站的流量和排名，能多少体现出其内容质量。
* [IMDB Ratings for Netflix](https://chrome.google.com/webstore/detail/imdb-ratings-for-netflix/dnbpnlalaijjbogmjbpdkdcohoibjcmp)
* [Markdown Here](https://chrome.google.com/webstore/detail/markdown-here/elifhakcjgalahccnjkneoccemfahfoa)
* [Stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne) 网页样式自定义，有很多网站没有它的话就真的很难看，比如 [HackersNews](https://news.ycombinator.com/)
* [Wikipedia URL Shortener](https://chrome.google.com/webstore/detail/wikipedia-url-shortener/ioekneldioljahdoiddhikknahbbkhan)

还有个 [bypass-paywalls](https://github.com/iamadamdev/bypass-paywalls-chrome) 可以试试。虽然几乎所有的付费网站我都全年订阅了，我还是会使用这个插件，因为有它就省的我每次都要打开 1Password 去登录了…… 安装得稍微麻烦。方法一，是用官网的

1. 选择一个保存目录，而后用 `git` 先下载源码到该目录中：

```bash
git clone git@github.com:iamadamdev/bypass-paywalls-chrome.git
```

2. 在浏览器的地址栏里输入 `edge://extensions` 到达插件管理页面
3. 点开左下角 `Develop mode` 开关
4. 在右侧顶部点 `Load Unpacked` 按钮，弹出的对话框里，先浏览至插件的目录，而后点击 `Select` 按钮，即可完成安装。

注意：插件文件夹得一直留在那里，删除它等于卸载插件。

还有，Bypass-paywalls 最好和 [uBlock Origin](https://microsoftedge.microsoft.com/addons/detail/ublock-origin/odfafepnkmbhccpbejgmiehpchacaeak) 一起配合使用。

另外，[MD Reader](https://github.com/Heroor/md-reader) 是我最近才开始用的插件。以前没有在浏览器里阅读 Markdown 的必要，但，自从开始用 Edge 的朗读功能之后，一个能在 Edge 里跑的 Markdown 阅读器就成了必需。

1. 选择一个保存目录，而后用 `git` 先下载源码到该目录中：

```bash
git clone https://github.com/Heroor/md-reader.git
cd md-reader
npm install
npm run build
```

2. 与上面安装 by-passwalls 一样，`Load Unpacked`（浏览并选择至 `md-reader/extension`目录）
3. 我会修改一下 Markdown 显示的样式，css 文件在 `extension/css/content-script.css`；修改完之后，重新启动 Edge，就可生效。

```css
/* body.md-reader 的 font-family 里，把 "Kaiti SC" 放在最开头*/
font-family: "Kaiti SC", -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;

/* body.md-reader .md-reader__body .md-reader__markdown-content 里同样； */
font-family: "Kaiti SC", -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
/* 加额外加一行：中文排版的一个小秘诀，字符之间有一点点空间，看起来就很舒服 */
letter-spacing: 1px;
/* 楷体字符较小，所以，字号可以放大一点，原本是 15px，改成 18px */
font-size: 18px;

/* 相应地，h1, h2, h3, h4, h5... 字号可能都要调整一下 */
/* h1: 30px; h2: 26px; h3: 22px... */
/* body.md-reader .md-reader__body .md-reader__markdown-content h1 */
```



## 常用新闻网站

> * https://www.ft.com/	Financial Times
> * https://hbr.org/	Harvard Business Review
> * https://sloanreview.mit.edu/	MIT Sloan Management Review
> * https://www.reuters.com/	Reuters
> * https://www.scientificamerican.com/	Scientific American
> * https://time.com/	TIME
> * https://www.economist.com/	The Economist
> * https://www.newyorker.com/	The New Yorker
> * https://www.nytimes.com/	The New York Times
> * https://www.wsj.com/	The Wall Street Journal
> * https://www.washingtonpost.com/	The Washington Post
> * https://www.wired.com/	WIRED
> * https://www.worldpoliticsreview.com/	World Politics Review