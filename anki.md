# Anki（暗记）Deck 制作（Python）

[Anki](https://apps.ankiweb.net/) 是一个开源免费的 “速记卡（Flashcard）工具”。Anki 这个名称是日文 “暗記”（あんき）的英文拼写 —— 意思相当于中文的 “熟记”。

## 1. Python Library for Generting Anki Decks: genanki

> https://github.com/kerrickstaley/genanki

本地安装： `pip install genanki`

## 2. 从文本中截取例句

最好的记忆方式，并不是直接记忆一个单词列表 —— 无论那个列表制作多么精良…… 不要错过或者跳过制作单词列表之前的一步：

> **认真阅读**或者**反复阅读**文本。

任何时候都一样：

> 真正有意义的完整文本（而不是只言片语）是词汇生根发芽的土壤。

```python
from nltk.tokenize import sent_tokenize

def find_sentences_with_word(text, target_word, case_sensitive=False):
    """
    Find sentences containing a specific word/phrase.
    
    Args:
        text: Input text (string)
        target_word: Word/phrase to search for
        case_sensitive: Whether to match case (default: False)
    
    Returns:
        List of matching sentences
    """
    sentences = []

    for line in text.split('\n\n'):
        for sent in sent_tokenize(line):
            sentences.extend(sent.split('.” '))
    matches = []
    
    for sentence in sentences:
        if not case_sensitive:
            # Case-insensitive search
            if target_word.lower() in sentence.lower():
                matches.append(sentence)
        else:
            # Case-sensitive search
            if target_word in sentence:
                matches.append(sentence)
    
    # Ensure the exact sentence is returned
    exact_matches = [match for match in matches if target_word in match]
    
    return exact_matches

# example usage

# full_text_file = "The Knowledge Illusio.txt"
# with open(full_text_file, 'r', encoding='utf-8') as file:
#     full_text = file.read()

# search_word = 'detonation'

# first_instance = find_sentences_with_word(full_text, search_word)[0]

```

英文单词有 “一辈子背不完” 的感觉 —— 没办法，英文的词汇库实在是过于丰富。但，这并不是压力，其实是很有趣的大脑体操，反正，经常动脑会防止老年痴呆……

Kindle 上读书的时候，用特定的颜色（比如黄色）标记生词，随后，可以将其导出。（参见：[与 Kindle/Audible 有关的话题](kindle.md)）。

可以用以下命令，将 epub 电子书转换成 txt 文件：

```bash
pandoc example.epub -t plain --strip-comments --no-highlight -o example.txt
```

## 3. 获取词汇原形

从文本里拷贝粘贴后整理词汇列表，往往需要一定的处理：

> * 去掉所属格（`’s` 或者 `'s`'）
> * 名词或动词的复数转换为单数
> * 动词的现在分词、过去式、过去分词转换为动词原形

这些可以用 `nltk.stem` 里的 `WordNetLemmatizer` 做

```python
# Ensure the necessary NLTK data packages are downloaded
# nltk.download('wordnet')
from nltk.stem import WordNetLemmatizer

def get_base_form(word, pos):
    lemmatizer = WordNetLemmatizer()
    if word.endswith("’s") or word.endswith("'s"):
        word = word[:-2]
    if pos == 'v.':
        return lemmatizer.lemmatize(word, 'v')
    elif pos == 'n.':
        return lemmatizer.lemmatize(word, 'n')
    else:
        return lemmatizer.lemmatize(word)
```

## 4. 用免费或付费的 AI 获取词汇词性以及词汇在例句中的释义

```python

# lmstudio could be downloaded from https://lmstudio.ai/

# Configuration
API_URL = "http://localhost:1234/v1/chat/completions"
HEADERS = {
    "Content-Type": "application/json",
    "Authorization": "Bearer lm-studio"  # Authorization may not be required
}

def generate_response_lmstudio(prompt, max_tokens=5000, temperature=0.2):
    # Once used: Llama-3.3-70B-Instruct-Q4_K_M.gguf
    payload = {
        "model": "local-model",  # Model name shown in LM Studio (arbitrary)
        "messages": [
            {"role": "user", "content": prompt + '\n Provide answer directly and with no further explaination.'}
        ],
        "temperature": temperature,
        "max_tokens": max_tokens,
        "stream": False  # Set to True for streaming responses
    }

    try:
        response = requests.post(API_URL, json=payload, headers=HEADERS)
        response.raise_for_status()
        return response.json()['choices'][0]['message']['content']
    except Exception as e:
        return f"Error: {str(e)}"


def generate_response_openai(prompt, max_tokens=5000, temperature=0.15):
    from openai import OpenAI
    from dotenv import load_dotenv
    load_dotenv()
    client = OpenAI(
    )
    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",  # You can choose the engine you want to use
            messages=[
                {
                    "role": "system", 
                    "content": "You're a helpful assistant. You answer user's prompt directly, with no futher explanations."
                },
                {
                    "role": "user", 
                    "content": prompt
                }
            ],
            max_tokens=max_tokens,
            temperature=temperature
        )
        return response.choices[0].message.content
    except Exception as e:
        return f"Error: {str(e)}"


```
