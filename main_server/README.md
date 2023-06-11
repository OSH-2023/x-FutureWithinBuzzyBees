# main-server
- 环境:Ubuntu 20.04

## 网页端和服务器端部署指南

基于[DisGraFS原文档参考](https://github.com/OSH-2021/x-DisGraFS/blob/main/web%26server/README.md),框架基本没有改动

### Webpage

该服务器部署的网页端,部署在云服务器上一般地址为/var/www/html/.直接将网页文件直接部署到服务器上即可，其中有形如**47.119.121.73**的部分，均改为你自己的服务器的公网IP即可。

### main server

建议单开一个用户(如果你按照实际部署应该也是)存储main server相关文件,python依赖模块见/main_server/requirements.txt,建议使用py虚拟环境或者docker容器


服务器需部署neo4j图数据库，neo4j图数据库的端口请使用7474和7687（也即默认的两个端口），如果修改了部署的端口，请同步修改网页部分文件和服务器部分文件的对应端口描述。运行服务器端时使用
```python
python3 serverWeb.py
```

### 3、关于本文件夹里面一些文件的说明

本文件夹路径下共有main_server和webpage两个文件夹。

main_server中所存放的为服务器端所需的3个文件：pytoneo.py,server_action.py和serverWeb.py。

- pytoneo.py为工具型程序，用来和neo4j数据库进行交互，serverWeb.py将调用pytoneo.py的函数以实现创建结点，删除结点等功能。(关于neo4j 你可以去[neo4j官网](https://neo4j.com/)获得帮助)
- server_action.py为文件交互程序(待完善)
- serverWeb.py为服务器主程序，请先启动本程序再进行之后的所有连接操作，此程序必须在访问网页端，连接打标服务器，启动客户端之前启动。此程序主要作用为分发各类消息给“客户端”，“打标服务器”，“pytoneo”进行处理。

web中存放的为网页主体。

​	fonts，js，css，sass，index.html组成第一层网页，用于登陆和检测服务器是否已连接的目的。

​	GraphGui为一个废弃的图数据库交互页面，以免后来人用的上，故暂且放置于文件夹中

​	GraphGui2为当前的图数据库交互页面，有搜索，打开，删除文件的功能，从第一层登陆网页登陆后将进入此页面。其中action.js，ui.js，login.js是用于服务于交互页面的js文, login.js用于刚刚进入网页时连接上上面所述的服务器主程序 
serverWeb.py , action.js用于进行一些事件的反馈相应，如点击“打开文件”后向服务器发生消息等，ui.js处理一些诸如鼠标点击等事件的相应。其他文件为网页框架文件，值得一提的是node_modules文件夹里面是一个较好的使用js和neo4j进行交互的一个js框架，名字叫做pototo，如果需要修改底层交互的方式，请修改pototo文件。d3是一个较好的使用js显示图形的框架，详细的使用说明可以查阅其官网的文档。如需修改此页面较上层的一些交互逻辑，可修改GraphGui2/js/main.js。如需修改搜索的部分，可修改GraphGui2/js/auto-complete.js，这两个文件都是已经被修改过的，若需要原始文件可在pototo的github上获得。

​	Download为下载客户端的页面，DownloadFile文件夹内用来存放客户端，如需更改存放的客户端的名字请同步更改Download下index.html中a标签的href值。其他文件夹中的文件均为网页框架，对网页主逻辑不构成影响。