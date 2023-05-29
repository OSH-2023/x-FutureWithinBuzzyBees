#本地测试文件
import cgi
import os
import http.server
import socketserver

# 定义上传文件保存目录
UPLOAD_DIR = "D:/code/disgraFS/upload"

# 定义一个请求处理类，用于处理文件上传请求
class MyRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        http.server.SimpleHTTPRequestHandler.end_headers(self)

    def do_POST(self):
        content_length = int(self.headers["Content-Length"])
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={"REQUEST_METHOD": "POST", "CONTENT_TYPE": self.headers["Content-Type"]}
        )

        for field in form.keys():
            field_item = form[field]
            if field_item.filename:
                # 获取上传的文件名和文件内容
                filename = os.path.basename(field_item.filename)
                filecontent = field_item.file.read()

                # 将文件保存到指定目录中
                filepath = os.path.join(UPLOAD_DIR, filename)
                with open(filepath, "wb") as f:
                    f.write(filecontent)

                # 输出调试信息
                print("文件已保存到:", filepath)

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"File uploaded successfully!")

# 启动服务器
with socketserver.TCPServer(("", 8000), MyRequestHandler) as httpd:
    print("Server started at port 8000")
    httpd.serve_forever()