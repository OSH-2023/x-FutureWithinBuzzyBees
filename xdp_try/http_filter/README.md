该eBPF应用程序实现功能:解析HTTP数据包并提取（并打印）GET/POST请求中包含的URL。

基于bcc工具链中的http_filter对http请求进行拦截并解析http Header(相当于创建一个BPF虚拟机使用套接字接受http请求),注意到linux内核提供了`BPF.SOCKET_FILTER`接口，接受到packet后计算`payload_offset = ETH_HLEN + ip_header_length + tcp_header_length;`,然后通过`load_byte()`,按字节读入header.

complete版本:增加了一定鲁棒性,与所有其他具有相同（src_ip、dst_ip、src_port、dst_port）的数据包进行AND运算，这意味着属于相同的“session”。如果url太长，则此额外检查可避免url截断。用户空间脚本（如有必要）会重新组装拆分为2个或多个数据包的url。注意BPF的数据结构`BPF_map<Key, Leaf>`
    


```c
//相关eBPF接口参考https://man7.org/linux/man-pages/man2/bpf.2.html
/*eBPF program.
Filter IP and TCP packets, having payload not empty
and containing "HTTP", "GET", "POST" ... as first bytes of payload
if the program is loaded as PROG_TYPE_SOCKET_FILTER
and attached to a socket
return 0 -> DROP the packet
return -1 -> KEEP the packet and return it to user space (userspace can read it from the socket_fd*/
int http_filter(struct __sk_buff *skb) ;
//eBPF读入packet方法
int load_byte();
//BPF_map<Key, Leaf>
BPF_TABLE(map_type, key_type, leaf_type, table_name, num_entry)
```

