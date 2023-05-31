import asyncio
import json
import websockets
import os


UPLOAD_DIR = 'D:/code/disgraFS/upload/'
async def upload(websocket, path):
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

start_server = websockets.serve(upload, 'localhost', 9998)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
