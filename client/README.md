# Client Introduction

DisGraFS Client由web UI调用，主要完成以下任务:

-自动挂载JuiceFS
-通过Websockets接收和执行来自web UI的命令
—删除JuiceFS中的某个文件
——退出
-监视任何文件操作在JuiceFS与看门狗和报告它通过Websockets的web UI
-文件创建
—文件修改
-删除文件

DisGraFS为两个平台提供客户端:Windows 10和Ubuntu(可能也适用于其他linux发行版，未测试)。由于一些平台差异，这两个版本的主要逻辑' DisGraFS-Client.py '是相似的，但并不完全相同。JuiceFS客户端可执行文件(由' DisGraFS-Client.py '调用)在两个平台上也有所不同。

要安装客户端，请将文件夹放在一个安全的地方，(windows先安装WinFsp，)并运行' setup.bat ' (windows)或' setup.sh ' (linux)。

要了解更多关于客户端文件夹中的其他文件，请参阅DevNotes。客户端的调试版本。

> 本组仅测试Ubuntu版本，使用时注意修改client.py中对应的一些用户名、路径、redis等，win版本为两年前DisGraFS版本，juicefs二进制文件需要官网下载最新版
