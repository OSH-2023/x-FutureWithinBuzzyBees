#处理mainserver接收到网页端对文件的操作指令

import os
import sys
import socket
import json
import time
import asyncio
import websockets
import pytoneo

#解析并执行指令
def parse_exec(recv_text):
     # 将字符串转换为字典对象
    try:
        signal = eval(recv_text)
    except SyntaxError:
        print("Invalid input format")
        return

    command = signal.get("command")
    parameter = signal.get("parameter", [])

    if command == "delete":
        server_delete(*parameter)
    elif command == "download":
        server_download(*parameter)
    elif command == "exit":
        print("server_exit...")
    else:
        print("Invalid command: ", command)


def server_delete(filename):
    # 删除文件的操作
    print("Deleting file: ", filename)

def server_download(filename):
    # 下载文件的操作
    print("Downloading file: ", filename)

