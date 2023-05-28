
#解析并执行指令
def parse_exec(recv_text):
     # 将字符串转换为字典对象
    try:
        signal = eval(recv_text)
    except SyntaxError:
        print("Invalid input format")
        return

    # 获取command和parameter参数
    command = signal.get("command")
    parameter = signal.get("parameter", [])

    # 根据command参数调用相应的函数执行操作
    if command == "open":
        server_open(*parameter)
    elif command == "delete":
        server_delete(*parameter)
    elif command == "download":
        server_download(*parameter)
    elif command == "exit":
        print("server_exit...")
    else:
        print("Invalid command: ", command)

def server_open(filename):
    # 打开文件的操作
    print("Opening file: ", filename)

def server_delete(filename):
    # 删除文件的操作
    print("Deleting file: ", filename)

def server_download(filename):
    # 下载文件的操作
    print("Downloading file")