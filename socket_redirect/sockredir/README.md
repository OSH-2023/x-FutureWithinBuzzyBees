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

```shell
 ./load.sh
+ set -e
+ sudo mount -t bpf bpf /sys/fs/bpf/
++ uname -r
+ clang -O2 -g -target bpf -I/usr/include/linux/ -I/usr/src/linux-headers-5.15.0-76-generic/include/ -c bpf_sockops_v4.c -o bpf_sockops_v4.o
+ sudo bpftool prog load bpf_sockops_v4.o /sys/fs/bpf/bpf_sockops
libbpf: elf: skipping unrecognized data section(8) .rodata.str1.1
+ sudo bpftool cgroup attach /sys/fs/cgroup/unified/ sock_ops pinned /sys/fs/bpf/bpf_sockops
++ grep -o -E 'map_ids [0-9]+'
++ sudo bpftool prog show pinned /sys/fs/bpf/bpf_sockops
++ cut -d ' ' -f2-
+ MAP_ID=4
+ sudo bpftool map pin id 4 /sys/fs/bpf/sock_ops_map
++ uname -r
+ clang -O2 -g -Wall -target bpf -I/usr/include/linux/ -I/usr/src/linux-headers-5.15.0-76-generic/include/ -c bpf_tcpip_bypass.c -o bpf_tcpip_bypass.o
+ sudo bpftool prog load bpf_tcpip_bypass.o /sys/fs/bpf/bpf_tcpip_bypass map name sock_ops_map pinned /sys/fs/bpf/sock_ops_map
+ sudo bpftool prog attach pinned /sys/fs/bpf/bpf_tcpip_bypass msg_verdict pinned /sys/fs/bpf/sock_ops_map
```

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
#sudo bpftool map show id 45 -f
```

应该能够查看同样固定在文件系统上的SOCKHASH map，SOCKHASH map 在 /sys/fs/bpf/ 文件系统中提供了对该映射的访问权限，用户可以通过读写相关的文件描述符来插入、删除、查询和更新映射中的键值对，从而控制和管理与 SOCKHASH map 相关的套接字映射。

```bash
#sudo tree /sys/fs/bpf/
/sys/fs/bpf/
├── bpf_sockops
├── bpf_tcpip_bypass
└── sock_ops_map

0 directories, 3 files


# sudo bpftool map list
4: sockhash  name sock_ops_map  flags 0x0
        key 24B  value 4B  max_entries 65535  memlock 2097152B
```

### 验证应用程序是否绕过TCP/IP堆栈

#### Turn on tracing logs (if not enabled by default)
```bash
#echo 1 >sudo /sys/kernel/debug/tracing/tracing_on
```
#### 可以将内核实时流跟踪文件trace_pipe放入shell中，以监视通过eBPF的TCP通信的跟踪
```bash
# sudo cat /sys/kernel/debug/tracing/trace_pipe
  <idle>-0       [000] d.s.1 89797.577008: bpf_trace_printk: <<< ipv4 op = 4, port 38902 --> 80
  <idle>-0       [000] d.s.1 89863.993725: bpf_trace_printk: <<< ipv4 op = 4, port 58380 --> 443
...
```

#### 我们可以使用SOCAT派生的TCP侦听器来模拟echo服务器，并使用netcat来发送TCP连接请求。

```bash
sudo socat TCP4-LISTEN:1000,fork exec:cat
nc localhost 1000 # this should produce the trace in the kernel file trace_pipe
```
可以监测结果
```shell
# sudo cat /sys/kernel/debug/tracing/trace_pipe
        <idle>-0       [000] d.s.1 91597.541404: bpf_trace_printk: <<< ipv4 op = 4, port 40762 --> 80
        node-126065  [000] d.s.1 91598.729170: bpf_trace_printk: <<< ipv4 op = 4, port 38678 --> 443
        nc-132366  [000] d...1 91639.938416: bpf_trace_printk: <<< ipv4 op = 4, port 38838 --> 1000
        nc-132366  [000] d.s11 91639.938514: bpf_trace_printk: <<< ipv4 op = 5, port 1000 --> 38838
```

## Cleanup

 [unload.sh](./unload.sh) 脚本将eBPF程序从挂钩中分离出来，并从内核中卸载它们。

## Test

利用linux自带的网络性能分析工具netperf来进行系统的性能分析，在未使用的端口运行netserver -p ++++ 来创建一个本地TCP服务器，然后运行相关nperf_**.sh脚本文件，即可分析ebpf程序绕过本机tcp/ip栈与未绕过时不同的网络性能，这其中包括在不同请求响应大小下的网络延迟量、吞吐量及事务处理速率等。
