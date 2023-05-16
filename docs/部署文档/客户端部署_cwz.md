# Client 部署过程

主要参考WowKiddy组和DisGraFS组的部署文档，记录我自己的部署流程

> DisGraFS为两个平台提供客户端:Windows 10和Ubuntu(可能也适用于其他linux发行版，未测试)。由于一些平台差异，这两个版本的主要逻辑' DisGraFS-Client.py '是相似的，但并不完全相同。JuiceFS客户端可执行文件(由' DisGraFS-Client.py '调用)在两个平台上也有所不同。
>
> 要安装客户端，请将文件夹放在一个安全的地方，(windows先安装WinFsp，)并运行' setup.bat ' (windows)或' setup.sh ' (linux)。

首先下载DisGraFS组的Zip，我这里提供了[三个DisGraFS相关组的zip整合](https://rec.ustc.edu.cn/share/a07bfd30-f314-11ed-b7cc-cb99922f14e0)

在\x-DisGraFS-main\Client\release中根据客户端想要部署的系统选择对应的文件夹

![image-20230515193819302](./%E5%AE%A2%E6%88%B7%E7%AB%AF%E9%83%A8%E7%BD%B2_cwz.assets/image-20230515193819302.png)

> 注意是release, debug我感觉可能是不稳定的版本

我选择了Ubuntu版本，将整个文件夹拖入虚拟机中

直接运行setup.sh

在桌面上新建一个文件夹，用作未来DisGraFS的文件夹

/home/yiran/Desktop/DisgraFS

> 在 JuiceFS 中使用 Redis 数据库的格式如下：
>
> ```text
> redis://<username>:<password>@<Database-IP-or-URL>:6379/1
> ```

运行DisGraFS-Client.py后面参数有格式要求：

disgrafs://[redisUrl] [mountPoint] [wsUrl] [wsAuth]

> 参数解释：
>
> - `[redisUrl]`：Redis的URL地址，用于连接到Redis数据库。在示例中，使用了`redis://:disgrafs@juicefs.disgrafs.tech`表示连接到名为"juicefs.disgrafs.tech"的Redis数据库。请根据实际情况提供正确的Redis URL。
> - `[mountPoint]`：挂载点路径，指定将DisGraFS文件系统挂载到本地文件系统的目录。在示例中，使用了`Z:`表示将DisGraFS文件系统挂载到本地的Z盘。请根据您的需求提供合适的挂载点路径。
> - `[wsUrl]`：WebSocket服务器的URL地址，用于与DisGraFS服务器建立WebSocket连接。在示例中，使用了`ws://localhost:9090`表示连接到本地的WebSocket服务器。请根据实际情况提供正确的WebSocket URL。
> - `[wsAuth]`：WebSocket服务器的认证信息，用于身份验证。在示例中，使用了`admin:123456`表示用户名为"admin"，密码为"123456"的认证信息。请根据您的实际设置提供正确的认证信息。

摆烂了，直接看我在群里提供的文件替换一下，记得自己更改自己要挂载JuiceFS的路径，这个是我的路径！！！

![image-20230516144358116](./%E5%AE%A2%E6%88%B7%E7%AB%AF%E9%83%A8%E7%BD%B2_cwz.assets/image-20230516144358116.png)

然后直接运行

```bash
sudo ./DisGraFS-Client.py
```

