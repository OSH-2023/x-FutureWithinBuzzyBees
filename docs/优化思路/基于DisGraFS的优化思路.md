# 基于DisGraFS的优化思路

> **Target:** 减轻DFS对客户端的严重依赖:原来的DisgraFS都需要在客户端部署JuiceFS才能实现文件系统的挂载且不支持网页端任何文件操作, 
> 我们希望通过浏览器实现文件的下载和上传

原来的思路:
![](../部署文档/打标服务器部署_gjm.assets/wowkiddy_structure.png)

希望的思路:
[![p9O3lK1.png](https://s1.ax1x.com/2023/05/28/p9O3lK1.png)](https://imgse.com/i/p9O3lK1)

改动点
- Main server
   
1. 改动Webpage展示部分提供下载上传的api
   (见`/GraphGui2/index.html`)
2. 在Mainserver挂载JuiceFS并且 完成1中的后端实现

- Tag-Server
修复对一般文件打标失败的bug,增强鲁棒性