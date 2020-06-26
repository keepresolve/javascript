
#!/usr/bin/python
import bs4
import requests
import os
from wsgiref.simple_server import make_server


def application(environ, start_response):
    req = requests.get("https://prewww.yktour.com.cn")
    req.encoding="utf-8"
    bs = bs4.BeautifulSoup(req.text,"html.parser")
    start_response('200 OK', [('Content-Type', 'application/json')])
    a_list = bs.find_all("img")
    li_list = bs.find_all("li")
    n_list = []
    n_style=[]
    # for aa in li_list:
    #     n_style.append(aa)
    for oa in a_list:
        n_list.append(oa['src'].encode('ascii'))
    # n_list.append(n_style)
    body = '"%s"' % (n_list)
    return [body.encode('utf-8')]


httpd = make_server('', 8000, application)
print('Serving HTTP on port 8000...')

httpd.serve_forever()