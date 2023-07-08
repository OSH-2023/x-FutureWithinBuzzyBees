# Socket data redirection using eBPF

> This is BPF code that demonstrates how to bypass TCPIP for socket data without modifying the applications. This code is a companion to this [blog](https://cyral.com/blog/how-to-ebpf-accelerating-cloud-native) post. 

The goal of this project is to show how to setup an eBPF network acceleration using socket data redirection when the communicating apps are on the same host.


## Testing

A simple bash script [load.sh](./load.sh) is included that performs the following tasks:

1. 使用LLVM Clang前端编译sockops BPF代码，该代码更新sockhash映射
2. 使用bpftool将上面编译的代码附加到cgroup，以便为系统中的所有套接字操作（如建立连接等）调用它。
3. 提取由上述程序创建的sockhash映射的id，并将该映射固定到虚拟文件系统，使得第二eBPF程序
4. 可以访问该map.编译tcpip_bypass代码，该代码将绕过tcpip堆栈
5. 执行套接字数据重定向。使用bpftool将上述eBPF代码附加到sockhash映射

运行脚本后，您应该能够验证eBPF程序是否已加载到内核中。

### 验证内核中是否加载了BPF程序

可以列出所有加载的BPF程序及其映射ID：

```bash
#sudo bpftool prog show
99: sock_ops  name bpf_sockops_v4  tag 8fb64d4d0f48a1a4  gpl
	loaded_at 2020-04-08T15:54:36-0700  uid 0
	xlated 688B  jited 399B  memlock 4096B  map_ids 45
103: sk_msg  name bpf_tcpip_bypas  tag 550f6d3cfcae2157  gpl
	loaded_at 2020-04-08T15:54:36-0700  uid 0
	xlated 224B  jited 151B  memlock 4096B  map_ids 45
```

应该能够查看同样固定在文件系统上的SOCKHASH map：

```bash
#sudo tree /sys/fs/bpf/
/sys/fs/bpf/
├── bpf_sockops
├── bpf_tcpip_bypass
└── sock_ops_map

0 directories, 3 files


#sudo bpftool map show id 45 -f
45: sockhash  name sock_ops_map  flags 0x0
	key 24B  value 4B  max_entries 65535  memlock 0B
```

### 验证应用程序是否绕过TCPIP堆栈

#### Turn on tracing logs (if not enabled by default)
```bash
#echo 1 > /sys/kernel/debug/tracing/tracing_on
```
#### 可以将内核实时流跟踪文件trace_pipe放入shell中，以监视通过eBPF的TCP通信的跟踪
```bash
#cat /sys/kernel/debug/tracing/trace_pipe
nc-1935  [000] ....   840.199017: 0: <<< ipv4 op = 4, port 48712 --> 1000
nc-1935  [000] .Ns1   840.199043: 0: <<< ipv4 op = 5, port 1000 --> 48712
```

#### 我们可以使用SOCAT派生的TCP侦听器来模拟echo服务器，并使用netcat来发送TCP连接请求。
```bash
sudo socat TCP4-LISTEN:1000,fork exec:cat
nc localhost 1000 # this should produce the trace in the kernel file trace_pipe
```

## Cleanup

 [unload.sh](./unload.sh) 脚本将eBPF程序从挂钩中分离出来，并从内核中卸载它们。

## Building

可以在任何支持eBPF的Linux内核上进行构建。可能需要你安装bpt-tools等工具
