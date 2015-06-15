import re
import sys
import json
import newspaper
from newspaper import Article
from urlparse import urlparse
from colorama import *

def extract():
  url = sys.argv[1:].pop()

  a = Article(url, keep_article_html=True)
  a.download()
  a.parse()
  a.nlp()

  parsed_uri = urlparse(a.source_url)
  domain = '{uri.netloc}'.format(uri=parsed_uri)

  try:
    publish_date = a.publish_date.strftime('%Y-%m-%d %H:%M')
  except AttributeError:
    publish_date = ""

  try:
    authors = ", ".join(a.authors)
  except AttributeError:
    authors = ""

  result = {}
  result['html'] = a.html
  result['body'] = a.text
  result['title'] = a.title
  result['top_image'] = a.top_image
  result['author'] = authors
  result['html_body'] = a.article_html
  result['favicon'] = a.meta_favicon
  result['description'] = a.summary
  result['publish_date'] = publish_date
  result['keywords'] = a.keywords
  result['sitename'] = re.sub(r"^www.", "", domain)

  return json.dumps(result).encode('utf-8')

res = extract()
sys.stdout.write(res)
sys.stdout.flush()
sys.exit(0)
