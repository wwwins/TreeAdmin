# -*- coding: utf-8 -*-
from bottle import route, run, template, get, post, request
from random import randint
from netcat import netcat
import socket, errno

# 設定 routing
# 這裡是指 http://localhost/ 及 http://localhost/myname
# 都執行 home 這個函式
@route('/')
@route('/<name>')
def home(name='茫茫大海'):
    # Server Title
    SERVER_TITLE = "TreeGateway Daemon v1.0 \r\n"
    # 設定裝置名稱
    # deviceName = ["0號機","1號機","2號機","NANO","4號機"]
    deviceName = ["大會議室","小魚缸","UX","NANO","Edith"]
    # 設定最大距離
    maxDistance = 15.0
    # receive data from TreeGateway
    # nc localhost 8888
    # format: [ID,ADDRESS,ONLINE,DISTANCE]
    # passData.append([0,"00",int("1"),0.0])
    # passData.append([1,"041",int("1"),0.0])
    # passData.append([2,"03",int("1"),0.0])
    # passData.append([4,"01",int("0"),0.0])
    currentDistance = 100
    currentNode = -1
    passData = []
    results = ''
    try:
        # TreeGateway
        results = netcat('192.168.200.102',8888,'INFO')
    except socket.error as e:
        print "Socket Error"

    if len(results)>len(SERVER_TITLE):
        nodes = results[len(SERVER_TITLE):].split('\n')
        for node in nodes:
            if node:
                s = node.split(' ')
                if (float(s[3])<0.1):
                    dist = '???'
                else:
                    if currentDistance > float(s[3]) and int(s[2]) > 0:
                        currentDistance = float(s[3])
                        currentNode = int(s[0])
                    if float(s[3]) > maxDistance:
                        dist = "{:.2f}m!".format(float(s[3]))
                    else:
                        dist = "{:.2f}m".format(float(s[3]))
                passData.append([int(s[0]),s[1],int(s[2]),dist])

    if currentNode < 0:
        name = name
    else:
        name = deviceName[currentNode]

    # 搜尋目錄 ./ 及 ./views 下 gatewap.tpl
    # tpl 檔案裡的 {{變數}} 會被相對應的 變數 取代
    # location=name 是指 tpl 裡的 {{location}} 會被 name 取代
    # 傳入的 name 如果含有 html tag 會被 escape
    # 如果不要 escape 請在前面加上驚嘆號 {{!location}}
    return template('gateway',deviceName=deviceName,location=name,passData=passData)

# http://localhost/admin/login?user=admin&pwd=1234
@route('/admin/login')
def login():
    r = "user:" + request.query.user + " pwd:" +request.query.pwd
    return r

# http://localhost/admin/list?pageId=3&title=testing
@get('/admin/list')
def list():
    r = "pageId:" + request.GET.pageId + " title:" +request.GET.title
    return r

@post('/admin/post')
def post():
    r = "name:" + request.POST.name + " title:" +request.POST.title
    return r

run(host='localhost', port=8000)
