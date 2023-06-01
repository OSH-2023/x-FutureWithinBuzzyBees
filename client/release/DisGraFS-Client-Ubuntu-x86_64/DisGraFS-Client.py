#!/usr/bin/env python3
import os
import sys
import time
import urllib.parse
import subprocess
import websockets
import asyncio
import time
import webbrowser
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from watchdog.events import PatternMatchingEventHandler
from collections import deque

def extractArgsFromUrl(url):
    args = urllib.parse.unquote(url)
    protocolIndex = args.find("://")
    if protocolIndex == -1:
        print("Error: Wrong url argument format \n")
        input("Press Enter to quit")
        sys.exit(-2)
    args = args[protocolIndex + 3:]
    args = args.split(' ')
    return args

if __name__ == "__main__":

    ########
    # init #
    ########

    print("DisGraFS Client")

    cwd = sys.argv[0]

    cwd = cwd[:len(cwd) - len("DisGraFS-Client.py")]
    redisUrl = "redis://admin:passwd@disgrafs.redis.rds.aliyuncs.com:6379/1"
    mountPointNoSlash = "/home/yiran/Desktop/DisgraFS"
    mountPointSlash = "/home/yiran/Desktop/DisgraFS/"
    wsUrl = "ws://121.41.165.179:9090"
    wsAuth = "neo4j:DCchengding2003_client"

    if os.path.exists(mountPointSlash):
        os.rmdir(mountPointSlash)

    print("Starting juicefs...")
    print([cwd + "juicefs", "-q", "mount", redisUrl, mountPointNoSlash])
    subprocess.Popen("sudo " + cwd + "juicefs mount " + redisUrl + ' ' + mountPointNoSlash, shell=True)
    print("Juicefs started")

    ############
    # watchdog #
    ############

    def createDatapack(type, path1 : str, path2 = ""):
        timeStamp = int(round(time.time() * 1000))
        purePath1 = path1[len(mountPointSlash):]
        purePath1 = purePath1.replace('\\', '/')
        purePath2 = ""
        if path2 != "":
            purePath2 = path2[len(mountPointSlash):]
            purePath2 = purePath2.replace('\\', '/')
        dictObj = { "type": type, "path1": purePath1, "path2": purePath2, "time":timeStamp }
        return repr(dictObj)

    sendTasklist = deque()

    print("Establishing watchdog observer...")

    def should_ignore_file(filepath):
        return filepath.endswith(".tmp") or filepath.endswith(".swp") or filepath.endswith(".swx") or filepath.endswith(".swpx") or filepath.startswith('.goutputstream')

    def on_created(event):
        if not should_ignore_file(event.src_path):
            message = "Watchdog: "
            if not event.is_directory:
                message = "file "
                message += f"{event.src_path} created"
                print(message)
                sendTasklist.append(createDatapack("create", event.src_path))

    def on_deleted(event):
        if not should_ignore_file(event.src_path):
            message = "Watchdog: "
            if not event.is_directory:
                message = "file "
                message += f"{event.src_path} deleted"
                print(message)
                sendTasklist.append(createDatapack("delete", event.src_path))

    def on_modified(event):
        if not should_ignore_file(event.src_path):
            message = "Watchdog: "
            if not event.is_directory:
                message = "file "
                message += f"{event.src_path} modified"
                print(message)
                sendTasklist.append(createDatapack("modify", event.src_path))

    def on_moved(event):
        if not should_ignore_file(event.src_path):
            message = "Watchdog: "
            if not event.is_directory:
                message = "file "
                message += f"{event.src_path} moved to {event.dest_path}"
                print(message)
                sendTasklist.append(createDatapack("move", event.src_path, event.dest_path))

    event_handler = FileSystemEventHandler()
    event_handler.on_created = on_created
    event_handler.on_deleted = on_deleted
    event_handler.on_modified = on_modified
    event_handler.on_moved = on_moved
    my_observer = Observer()
    print("mpslsh", mountPointSlash)
    while not os.path.exists(mountPointSlash):
        time.sleep(0.1)
    time.sleep(1) # must wait for juicefs to finish mounting
    my_observer.schedule(event_handler, mountPointSlash, recursive=True)
    my_observer.start()
    print("Watchdog observer established")

    async def login():
        wsClient = await websockets.connect(wsUrl)
        await wsClient.send(wsAuth)
        return wsClient

    async def wsSender(wsClient):
        while True:
            while len(sendTasklist) == 0:
                await asyncio.sleep(0.1)
            await wsClient.send(sendTasklist.popleft())

    async def wsReceiver(wsClient):
        while True:
            socketRecv = await wsClient.recv()
            try:
                command = eval(socketRecv)
                if command["command"] == "exit":
                    asyncio.get_event_loop().stop()
                    return
                elif command["command"] == "open":
                    webbrowser.open("file://" + mountPointSlash + command["parameter"][0])
                elif command["command"] == "delete":
                    os.remove(mountPointSlash + command["parameter"][0])
                else:
                    print("Error: Failed to resolve command from server:", socketRecv)
            except Exception:
                print("Error: Failed to execute command from server:", socketRecv)

    try:
        loop = asyncio.get_event_loop()
        wsClient = loop.run_until_complete(login())
        loop.run_until_complete(asyncio.wait([wsSender(wsClient), wsReceiver(wsClient)]))

    except KeyboardInterrupt:
        pass

    finally:
        my_observer.stop()
        subprocess.Popen("juicefs umount " + mountPointNoSlash).wait()
        loop.call_soon(wsClient.close())
        input("Press Enter to quit")
        sys.exit(0)
