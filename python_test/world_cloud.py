from bs4 import BeautifulSoup as soup
from urllib.request import urlopen
from newspaper import Article, Config
from wordcloud import WordCloud, STOPWORDS
import matplotlib.pyplot as plt

user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'
config = Config()
config.browser_user_agent = user_agent
config.request_timeout = 10

news_url="https://news.google.com/rss/search?q=Russia+when:30d&hl=en-US&gl=US&ceid=US:en"
Client=urlopen(news_url)
xml_page=Client.read()
Client.close()

soup_page=soup(xml_page,"xml")
news_list=soup_page.findAll("item")

newArtics = ""
for news in news_list:
    newArtics +=  news.link.text + "\n"

links = newArtics.splitlines( )

text = ''
for link in links:
    a = Article(url=link, language='en', config=config)
    try:
        a.download()
        a.parse()
    except :
        pass
    text += a.text

cloud = WordCloud().generate(text)
plt.figure(figsize=(8, 8), facecolor=None)
plt.imshow(cloud, interpolation="bilinear")
plt.axis("off")
plt.tight_layout(pad=0)
plt.show()