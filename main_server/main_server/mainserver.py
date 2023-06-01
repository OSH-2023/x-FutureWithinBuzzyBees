import asyncio
import websockets
import time
import os
import pytoneo
from server_action import parse_exec
import json,os
# from flask import Flask, request, send_file

# app = Flask(__name__)

# @app.route('/download', methods=['GET'])
# def download():
#     file_path = request.args.get('file', '')
    
#     # 构建完整的文件系统路径
#     full_path = file_path

#     # 检查文件是否存在
#     if os.path.isfile(full_path):
#         # 返回文件给客户端
#         return send_file(full_path, as_attachment=True)

#     # 文件不存在
#     return 'File not found', 404

class client_struct:
    username            = 0
    index_client        = 0
    web_websocket       = 0
    client_websocket    = 0

#用户数组和用户人数
client_array = []
client_num = 0

#标签服务器数组
tag_array = []
tag_num = 0

Neo4jServer = 0

# 服务器端主逻辑
# websocket和path是该函数被回调时自动传过来的，不需要自己传
async def main_logic(websocket, path):
    #引用全局变量
    global tag_num
    global client_num
    global Neo4jServer
    #Neo4jServer.delete_node("hijk.pdf".lower())
    if path == '/':
        try:
            #记录日志
            localtime = time.asctime( time.localtime(time.time()))
            print(localtime,":",end='')
            
            recv_text = await websocket.recv()
            
            print(recv_text)
            
            print("websocket: ",websocket.port)
            
            #主页面链接上时，返回确认信息
            if recv_text == "mainWeb":
                await websocket.send("Close:A Good Connection, please close it")
                await websocket.close_connection()
                return
            
            #分解接收到的信息
            tag_split = recv_text.split('_')
            print(tag_split)
            
            #网页端连接逻辑
            if tag_split[1] == "web":
                
                client_item = client_struct()
                client_item.username        = tag_split[0]
                client_item.web_websocket   = websocket
                
                client_array.append(client_item)
                
                client_index = client_num
                client_num = client_num + 1
                
                print(tag_split,"：",recv_text)
                
                while True:
                    recv_text = await websocket.recv()
                    print(tag_split,"：",recv_text)

                    #解析网页端发来的命令 
                    cmd_dict = eval(recv_text)
                    # e.g cmd_dict = {'command': 'download', 'parameter': [7, '1_实验报告模板.md']}
                    # cmd_dict['parameter'][0] = 7 代表节点id
                    
                    # 处理下载命令
                    if cmd_dict['command'] == 'download':
                        # 从数据库中找到对应文件
                        file = Neo4jServer.find_file(cmd_dict['parameter'][1])
                        file_path = file['path']
                        # /root/jfs -> /var/www/html/jfs
                        file_path = file_path.replace('/root/jfs', '/var/www/html/jfs')
                        if os.path.isfile(file_path):
                            # 构建下载链接/var/www/html/jfs -> /jfs
                            download_link =file_path.replace('/var/www/html', '')
                            # 发送下载链接给客户端
                            await websocket.send(download_link)
                        else:
                            await websocket.send('file not found')

                    # 处理删除命令
                    elif cmd_dict['command'] == 'delete':
                        # 从数据库中找到对应文件
                        file = Neo4jServer.find_file(cmd_dict['parameter'][1])
                        file_path = file['path']
                        # /root/jfs -> /var/www/html/jfs
                        file_path = file_path.replace('/root/jfs', '/var/www/html/jfs')
                        if os.path.isfile(file_path):
                            os.remove(file_path)
                            # 删除数据库中的文件
                            Neo4jServer.delete_node(file['name'])
                            await websocket.send('delete success')
                        else:
                            # 删除数据库中的文件
                            Neo4jServer.delete_node(file['name'])
                            await websocket.send('file not found')

                    # 检查客户端是否在线
                    if client_index < client_num:
                        if client_array[client_index].index_client == 1: 
                            await client_array[client_index].client_websocket.send(recv_text)
                    # else:
                    #     await websocket.send("no_client")
            
            #客户端连接逻辑            
            elif tag_split[1] == "client":
                
                #更改信号量，添加用户端的通信地址
                client_index = -1
                for client_item in client_array:
                    client_index = client_index + 1
                    if client_item.username == tag_split[0]:
                        client_item.index_client    = 1 
                        client_item.client_websocket= websocket
                        break
                
                print(tag_split,"：",recv_text)
                
                while True:
                        recv_text = await websocket.recv()
                        print(tag_split,"：",recv_text)

                        if tag_num == 0:
                            print("no tag server")

                        else:
                            #选择一个tag服务器作为打标服务器，之后可改为随机取打标服务器
                            tag_index = 0
                            await tag_array[tag_index].send(recv_text)
                        
            #标签端连接逻辑
            elif tag_split[1] == "tag":
                
                tag_array.append(websocket)
                tag_num = tag_num + 1
                
                #debug
                tag_index = 0
                
                while True:
                    recv_text = await websocket.recv()
                    print(tag_split,"：",recv_text)
                    
                    recv_list = eval(recv_text)
                    
                    #尝试解码从tag服务器中读出的数据，然后进行增删改的操作，所有跟数据库交互的操作在这边完成
                    if recv_list[0] == "create":
                        print("创建指令")
                        print(recv_list[1])
                        Neo4jServer.create_newnode(recv_list[1])
                        
                    elif recv_list[0] == "move":
                        print("修改指令")
                        # print(recv_list[2])
                        # Neo4jServer.delete_node(recv_list[1])
                        # Neo4jServer.create_newnode(recv_list[2])
                        if recv_list[2].startswith(".Trash-1000"):
                            Neo4jServer.delete_node(recv_list[1].lower())
                        
                    elif recv_list[0] == "delete":
                        print("正在删除")
                        print(recv_list[1])
                        Neo4jServer.delete_node(recv_list[1].lower())
                        
                    elif recv_list[0] == "invalid":
                        print("无效，忽略此消息")
                        
                    elif recv_list[0] == "error":
                        print("错误指令")
                        
                    else:
                        print("标签服务器传输有误")
            
            #错误的连接信息        
            else:
                await websocket.send("A wrong user, please check your message.")
                await websocket.close_connection()
                return
            #当前的websocket连接断开        
        except websockets.ConnectionClosed:
            
            client_index = -1
            for client_item in client_array:
                client_index = client_index + 1
                #网页连接断开则弹出整个连接
                if client_item.web_websocket == websocket:
                    #先退出客户端
                    
                    #再弹出整个连接
                    client_array.pop(client_index)
                    client_num = client_num - 1
                    
                    print(client_item.username," web exit")
                    return
                #客户端连接断开则只删除客户端信息
                elif client_item.client_websocket == websocket:
                    client_item.index_client    = 0
                    client_item.client_websocket= 0
                    
                    print(client_item.username," client exit")
                    return
                
            tag_index = -1
            for tag_item in tag_array:
                tag_index = tag_index + 1
                #弹出当前打标连接
                if tag_item == websocket:
                    tag_array.pop(tag_index)
                    tag_num = tag_num - 1
                    
                print("打标服务器[",tag_index,"]已退出")
                return
            
            #未找到这个websocket    
            print("client didn't login")
            
            return
    elif path == '/upload':
        # 处理'/upload'路径下的逻辑
        UPLOAD_DIR ='/var/www/html/jfs/'
        try:
            # 接收元数据
            metadata_str = await websocket.recv()
            metadata = json.loads(metadata_str)

            print(f"已接收到元数据：{metadata}")

                    # 创建文件路径，根据需要修改保存路径
            save_path = f"{UPLOAD_DIR}{metadata['name']}"

            print(f"文件保存路径：{save_path}")

            # 检查文件夹是否存在，如果不存在则创建它
            os.makedirs(os.path.dirname(save_path), exist_ok=True)

            # 检查文件名是否正确
            if not os.path.basename(save_path) == metadata['name']:
                raise Exception("文件名不正确")

            # 检查文件权限
            if not os.access(os.path.dirname(save_path), os.W_OK):
                raise Exception("没有写入权限")
            # 创建文件并写入内容
            with open(save_path, 'wb') as file:
                while True:
                    # 接收文件内容
                    data = await websocket.recv()
                    if not data:
                        break
                    file.write(data)

            print(f"已成功上传文件：{metadata['name']}")
            print(f"文件类型：{metadata['type']}")
            print(f"文件大小：{metadata['size']} bytes")

        except websockets.exceptions.ConnectionClosedError:
            print("连接已关闭")
        except json.JSONDecodeError:
            print("无效的元数据格式")
        except Exception as e:
            print(f"上传文件时出现错误：{e}")
    else:  
        pass
    
    # #其他的异常情况
    # except:
    #     print("错误的连接信息")
    

if __name__ == "__main__":
    #端口名、用户名、密码根据需要改动
    #create_newnode(node)用于创建结点（包括检测标签、创建标签节点、添加相应的边等功能）
    #delete_node(node.name)用于删去名为node.name的结点
    
    #连接数据库 
    scheme = "neo4j"  # Connecting to Aura, use the "neo4j+s" URI scheme
    host_name = "localhost"
    port = 7474
    url = "bolt://121.41.165.179:7687".format(scheme=scheme, host_name=host_name, port=port)
    user = "neo4j"
    password = "DCchengding2003"
    
    Neo4jServer = pytoneo.App(url, user, password)
    print("Neo4j服务器连接成功...")
    
    #启动webserver服务器
    start_server = websockets.serve(main_logic, '0.0.0.0', 9090)
    print("主服务器初始化成功，等待连接...")

    # app.run(host='0.0.0.0', port=8080, debug=True)
    # print("下载服务器初始化成功，等待连接...")
    
    asyncio.get_event_loop().run_until_complete(start_server)
    asyncio.get_event_loop().run_forever()