# 开发说明

由HurryPeng

## 核心组件

### setup.bat / setup.sh

- Windows/Ubuntu
-假设python3已安装并添加到' path '
-为python安装' watchdog '模块
为python安装' websockets '模块
-生成' DisGraFS-Client-Register-Generated.reg ' / ' disgrafs.desktop '为当前工作目录，并添加到系统配置
-每次移动文件夹时都应该重新运行

### DisGraFS-Client-Register-Generated.reg / disgrafs.desktop

- Windows/Ubuntu
—由“setup.bat”/“setup.sh”自动生成，使用后可删除
-在注册表中添加' URL:disgrafs Protocol Handler '或在桌面数据库中添加' disgrafs.desktop '，这会将' disgrafs:// '协议重定向到当前工作目录' disgrafs - client .py '

### DisGraFS-Client.py

-本打算独立于平台，但是不同平台之间的一些细微差异(比如“sudo”)让它无法实现
-首先由' disgrafs:// ' URL协议调用，并将一直运行直到被用户或服务器杀死
-格式:' disgrafs://[redisUrl] [mountPoint] [wsUrl] [wsAuth] '
—示例:' disgrafs://redis://:disgrafs@juicefs.disgrafs.tech Z: ws://localhost:9090 admin:123456 '
-安装JuiceFS
—作为客户端启动websocket连接
—监听服务器命令
——命令格式:{“命令”:“commandName”,“参数”:[“param1”、“param2”…]}”
- exit: ' {"command": "exit"， "parameter": []} '
——开放:{“命令”:“开放”,“参数”:[" RollIt.jpg "]}”
-在挂载的驱动器上建立看门狗观察者
监听文件系统事件并通过websocket向服务器报告
-报告格式:
- Create: ' {"type": " Create "， "path1": "folder/newfile.txt"， "path2": "" "， "time": 1619926181000} '
-修改:' {"type": " Modify "， "path1": "folder/modified.txt"， "path2": "" "， "time": 1619926181000} '
- Delete: ' {"type": " Delete "， "path1": "folder/deleted.txt"， "path2": "" "， "time": 1619926181000} '
-移动:' {"type": " Move "， "path1": "oldfolder/oldname.txt"， "path2": "newfolder/newname.txt"， "time": 1619926181000} '

### juicefs.exe / juicefs

-不同平台的二进制文件不同
- JuiceFS提供
-由“DisGraFS-Client.py”自动调用
