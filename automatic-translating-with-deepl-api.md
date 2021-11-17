# 使用 Python 和 DeepL API 进行电子书的自动化翻译

## 概述

选择 html 格式作为翻译格式的原因主要有：

1. 可以保留书中大量的脚注、尾注及其链接；
2. DeepL 有专门的 API 参数处理 xml tag，`tag_handling="xml"`；
3. 可以通过 css 文件随意设置显示样式，比较灵活；
4. 可以通过插入 javascript 函数指定某种特定语言的显示（比如，只显示中文）；
5. 可以用来作为源文件转换成任意格式的电子书……

另外，在调用 `tag_handling="xml"` 之后，DeepL API 返回的译文非常规整，能够保留所有 html tag；并且，“返回字符串” 与 “原字符串” 相同，可以作为一个判断依据 —— 该行有没有被翻译，如果没有，在生成的译文 html 文件中，该行没必要重复出现……

## 将 Kindle awz 转换为 epub

## 将 epub 转换为 html

## 清理 html



## 自动化翻译的 python 脚本

首先，需要购买 DeepL API Pro，以便有一个可以使用的 `authentication key`，注意 **API** 字样，不是 DeepL Pro，而是 DeepL **API** Pro。

以下，定义了一个函数 `translate()`，用来翻译指定文本到指定语言。

```python
import requests

auth_key = "<your authentication key>"
target_language = "ZH"

def translate(text):
    result = requests.get( 
       "https://api.deepl.com/v2/translate",
       params={ 
         "auth_key": auth_key,
         "target_lang": target_language,
         "text": text,
         "tag_handling": "xml",
       },
    ) 
    return result.json()["translations"][0]["text"]

translate( < text you want to translate...> )

```

## 中文格式处理脚本

在浏览器中显示的中文排版，有很多细节需要调整，以下是我常用的 regex 组合，打包到了一个函数，`zh_format()` 中（其中很多是针对 DeepL 返回的中文翻译文本中存在的需要调整的细节，比如，DeepL 返回的文本中，破折号常常是 `....... 。`）：

```python
def zh_format(html):
    
    # 去掉半角方括号
    pttn = r'\[(.*?)\]'
    rpl = r'\1'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 直双引号转换成弯双引号
    pttn = r'\s*"(.*?)\s*"'
    rpl = r'“\1”'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 直单引号转换成弯单引号
    pttn = r"\s*'(.*?)\s*'"
    rpl = r'‘\1’'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # html tag 中被误伤的直引号
    pttn = r'=[“”"](.*?)[“”"]'
    rpl = r'"\1"'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # html 弯引号之前的空格
    pttn = r'([\u4e00-\u9fa5])([“‘])'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # html 弯引号之后的空格
    pttn = r'([’”])([\u4e00-\u9fa5])'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
           
    # html tag: <i>, <em> 转换成 <strong>
    pttn = r'(<i|<em)'
    rpl = r'<strong'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # html tag: <i>, <em> 转换成 <strong>
    pttn = r'(i>|em>)'
    rpl = r'strong>'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # html tag: strong 内部的 “”、‘’、《》、（）
    pttn = r'([《（“‘]+)<strong (.*?)>'
    rpl = r'<strong \2>\1'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    pttn = r'</strong>([》）”’]+)'
    rpl = r'\1</strong>'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 省略号
    pttn = r'\.{2,}\s*。*\s*'
    rpl = r'…… '
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)   
    
    # 破折号
    pttn = r'&mdash；|&mdash;|--'
    rpl = r' —— '
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 姓名之间的 ·（重复三次）
    pttn = r'([\u4e00-\u9fa5])-([\u4e00-\u9fa5])'
    rpl = r'\1·\2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    pttn = r'([\u4e00-\u9fa5])-([\u4e00-\u9fa5])'
    rpl = r'\1·\2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    pttn = r'([\u4e00-\u9fa5])-([\u4e00-\u9fa5])'
    rpl = r'\1·\2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    pttn = r'([A-Z]{1})\s*\.\s*([A-Z]{1})'
    rpl = r'\1·\2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)    
    
    pttn = r'([A-Z]{1})\s*\.\s*([\u4e00-\u9fa5])'
    rpl = r'\1·\2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)

    # 全角百分号
    pttn = r'％'
    rpl = r'%'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
      
    # 数字前的空格
    pttn = r'([\u4e00-\u9fa5])(\d)'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 数字后的空格，百分比 % 后的空格
    pttn = r'([\d%])([\u4e00-\u9fa5])'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
        
    # 英文字母前的空格
    pttn = r'([\u4e00-\u9fa5])([a-zA-Z])'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
        
    # 英文字母后的空格，百分比 % 后的空格
    pttn = r'([a-zA-Z])([\u4e00-\u9fa5])'
    rpl = r'\1 \2'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
        
    # tag 内的英文字母前的空格
    pttn = r'([\u4e00-\u9fa5])<(strong|i|em|span)>(.[a-zA-Z\d ]*?)<\/(strong|i|em|span)>'
    rpl = r'\1 <\2>\3</\4>'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
        
    # tag 内的英文字母后的空格，百分比 % 后的空格
    pttn = r'<(strong|i|em|span)>(.[a-zA-Z\d ]*?)<\/(strong|i|em|span)>([\u4e00-\u9fa5])'
    rpl = r'<\1>\2</\3> \4'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 弯引号前的逗号
    pttn = r'，([”’])'
    rpl = r'\1，'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
        
    # 中文标点符号之前多余的空格
    pttn = r'([，。！？》〉】]) '
    rpl = r'\1'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 英文句号 . 与汉字之间的空格
    pttn = r'\.([\u4e00-\u9fa5])'
    rpl = r'. \1'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
      
    # 左半角括号
    pttn = r'\s*\('
    rpl = r'（'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    
    # 右半角括号
    pttn = r'\)\s*'
    rpl = r'）'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)  
    
    # # 摄氏温度符号
    # pttn = r'℃'
    # rpl = r'\1·\2'
    # re.findall(pttn, html)
    # html = re.sub(pttn, rpl, html)
    
    return html
```

如果，某句话被翻译了，那么，原文的 tag class 中加上 `en`，相应地，译文的要加上 `cn`…… 如此这般有两个好处：

1. 将来还可以翻译成任何其他语言，并各自加上必要的 tag class；（也可以用 javascript 进一步设定显示哪一种语言）
2. 给中文的排版在 css 中单独设置 `line-spacing: 0.1 em;`

以下分别是给原文加上 `class="en"` 和给中文译文加上 `class="cn"` 的函数：

```python
def add_language_tag_en(html):
    pttn = re.compile(r'^<(.*?) class="(.*?)">', re.M)
    rpl = r'<\1 class="\2 en">'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    return html

def add_language_tag_cn(html):
    pttn = re.compile(r'^<(.*?) class="(.*?)">', re.M)
    rpl = r'<\1 class="\2 cn">'
    re.findall(pttn, html)
    html = re.sub(pttn, rpl, html)
    return html
```