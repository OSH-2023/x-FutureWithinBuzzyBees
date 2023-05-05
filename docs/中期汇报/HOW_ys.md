# HOW

## 1.内核旁路

使用 eBPF 实现内核旁路的几个步骤：

使用 eBPF 汇编或者 eBPF 特有的 C 语言来编写 eBPF 程序，实现对网络数据包的过滤和处理。

使用 LLVM/Clang 编译器，将 eBPF 程序编译成 eBPF 字节码。

调用 bpf () 系统调用把 eBPF 字节码加载到内核。

将 eBPF 程序挂载到内核的网络层上，如 XDP（Express Data Path）或 TC（Traffic Control）。

eBPF 特有的 C 语言来编写 eBPF 程序

由哪几部分组成：

### 一. 头文件

1. 例如：#include <linux/bpf.h> // 引入 Linux 内核的 BPF 头文件
2. #include <bpf_helpers.h>#include <linux/if_ether.h> // 引入以太网帧的头文件
3. #include <linux/ip.h> // 引入 IP 协议的头文件



### 二. 宏定义来指定 eBPF 程序的节名和属性并指定挂载点

#define SEC(NAME) __attribute__((section(NAME), used)) attribute((section(NAME)))

表示将ebpf函数放入指定的ELF节中，这样ebpf加载器可以根据节名识别ebpf函数的类型和位置。

attribute((used))表示告诉编译器保留ebpf函数，即使它没有被引用，避免链接器删除未使用的节。

每个ebpf函数都应该有一个类似的宏定义，以便ebpf加载器能够正确地加载和附加ebpf函数。

挂载点示例

SEC("xdp") // 指定 eBPF 程序的节名为 xdp，表示该程序将挂载到 XDP 挂载点

SEC(“kprobe/do_sys_open”)表示该程序将挂载到kprobe/do_sys_open挂载点，用于追踪内核函数do_sys_open的调用。

SEC(“tracepoint/syscalls/sys_enter_execve”)表示该程序将挂载到tracepoint/syscalls/sys_enter_execve挂载点，用于追踪系统调用sys_enter_execve的执行。

SEC(“cgroup/skb”)表示该程序将挂载到cgroup/skb挂载点，用于实现cgroup级别的流量控制。SEC(“socket”)表示该程序将挂载到socket挂载点，用于实现基于套接字的过滤和重定向。

### 三. 函数返回值来表明后续操作

例如，当ebpf程序xdp用作NIC驱动层的数据包处理器时，返回值可以是以下之一：

XDP_ABORTED (-5)：表示数据包处理过程中发生了严重错误，需要内核进行统计和清理。

XDP_DROP (-2)：表示丢弃数据包，并增加相应的计数器。

XDP_PASS (0)：表示将数据包传递给网络堆栈进行正常处理。

XDP_TX (2)：表示将数据包重新发送到与接收相同的网络设备，并增加相应的计数器。

XDP_REDIRECT (3)：表示将数据包重定向到另一个网络设备或用户空间，并增加相应的计数器。

### 四. bpf内核辅助函数

这些函数都是只能用在 eBPF 程序里面的，它们是由内核提供的一些特殊的函数，不能在普通的 C 程序中调用。它们的名称都以 bpf_ 开头，是为了区分它们和其他的内核函数或用户空间函数。它们也有一些特殊的约束和限制，例如不能有超过五个参数，不能返回复杂的类型，不能调用其他的内核函数或用户空间函数等。这些约束和限制是为了保证 eBPF 程序的安全性和可验证性。

通用辅助函数：

这些函数可以被任何类型的 eBPF 程序调用，它们提供了一些基本的功能，例如获取当前时间、生成随机数、打印调试信息、执行算术或逻辑运算等。

例如：

bpf_ktime_get_ns() – 获取自系统启动以来的纳秒数

bpf_get_prandom_u32() – 获取一个伪随机数

bpf_trace_printk() – 将格式化字符串输出到 /sys/kernel/debug/tracing/trace_pipe 文件中

映射操作辅助函数：

这些函数可以被任何类型的 eBPF 程序调用，它们提供了一些操作 eBPF 映射的功能，例如查找、更新、删除或遍历键值对等。

例如：

bpf_map_lookup_elem() – 在指定的映射中查找指定键对应的值

bpf_map_update_elem() – 在指定的映射中更新或插入指定键值对

bpf_map_delete_elem() – 在指定的映射中删除指定键对应的键值对

网络相关辅助函数：

这些函数只能被网络相关的 eBPF 程序调用，它们提供了一些操作网络包或套接字的功能，例如获取或修改包头、重定向或丢弃包、获取或设置套接字选项等。

例如：

bpf_skb_load_bytes() – 从网络包中加载指定偏移和长度的字节

bpf_skb_store_bytes() – 向网络包中存储指定偏移和长度的字节

bpf_redirect() – 将网络包重定向到指定的网络设备

跟踪相关辅助函数：

这些函数只能被跟踪相关的 eBPF 程序调用，它们提供了一些获取或修改内核对象或事件的功能，例如获取当前进程或任务的信息、读取或写入内核内存、执行尾调用等。

例如：

bpf_get_current_pid_tgid() – 获取当前进程或任务的 PID 和线程 ID

bpf_probe_read() – 从内核空间安全地读取指定长度的字节

bpf_tail_call() – 执行一个尾调用，即从一个 eBPF 程序跳转到另一个 eBPF 程序



需要 GPL 协议的辅助函数：这些函数通常是为了实现一些内核特有的功能，或者为了保护内核的安全性和稳定性，所以要求 eBPF 程序使用 GPL 协议才能调用它们。如果 eBPF 程序使用了这些函数，但没有使用 GPL 协议，那么内核会拒绝加载或运行它们。

例如：

bpf_trace_printk() – 这个函数用于将格式化字符串输出到 /sys/kernel/debug/tracing/trace_pipe 文件中，它需要 eBPF 程序使用 GPL 协议，因为它可能会泄露内核的敏感信息。

bpf_get_current_task() – 这个函数用于获取当前进程或任务的结构体指针，它需要 eBPF 程序使用 GPL 协议，因为它可能会修改内核的关键数据。



## 2. 共享内存

ebpf 实现共享内存的基本原理是使用 bpf 映射（bpf map）这种数据结构，它可以在用户态和内核态之间共享和查询数据。

ebpf 映射是一种键值存储，可以在内核中创建和管理，也可以在用户态中通过文件描述符访问。不同的 ebpf 程序可以访问同一个内存地址，就实现了映射的共享，最终可以构建更为复杂的 ebpf 程序。ebpf 程序在执行时是直接访问内存的，一般来说我们通过辅助函数（helper function）来访问映射，比如查询映射是通过 bpf_map_lookup_elem 函数。

 ebpf映射可以在用户空间程序和内核空间程序之间共享和查询数据，实现跨进程或跨硬件组件的数据传输bpf系统调用通常不会直接使用，而是通过一些封装库或工具来间接使用，如Cilium, bcc, bpftrace, goebpf, libbpf等

下面是一个利用bcc工具宏定义创建eBPF映射的方式

DEFINE_BPF_MAP 是一个宏，用于定义一个 eBPF 映射，也就是一个用户空间和内核空间共享的数据结构。

它有五个参数：

第一个参数是映射的名称，它必须是一个合法的 C 标识符，不能包含空格或特殊字符。

第二个参数是映射的类型，它必须是一个 eBPF 支持的映射类型，例如 ARRAY、HASH、LRU_HASH、PERCPU_ARRAY 等。

第三个参数是键的类型，它必须是一个 C 的基本类型，例如 int、char、long 等。

第四个参数是值的类型，它可以是一个 C 的基本类型或者一个结构体类型，例如 int、char[16]、struct foo 等。

第五个参数是映射的大小，它必须是一个正整数，表示映射可以存储的键值对的最大数量。这个宏会在内核中创建一个指定类型和大小的映射，并在用户空间中生成一些辅助函数来操作这个映射，例如查找、更新或删除键值对。这些函数的名称都以 bpf_ 开头，并包含映射的名称。

具体例子

```C

// 定义一个映射，类型为 HASH，键为 int，值为 char[16]，大小为 1024

DEFINE_BPF_MAP(pid_name_map, HASH, int, char[16], 1024);

// 这个宏会生成以下函数：

// 查找指定键对应的值char *bpf_pid_name_map_lookup_elem(int *key);

// 更新或插入指定键值对int bpf_pid_name_map_update_elem(int *key, char *value, unsigned long long flags);

// 删除指定键对应的键值对int bpf_pid_name_map_delete_elem(int *key);
```







bpf 映射的局限性主要有以下几点：

bpf 映射的大小是固定的，不能动态扩展或缩减，需要在创建时指定。

bpf 映射的键和值的类型是固定的，不能存储不同类型的数据，需要在创建时指定。

bpf 映射的访问权限是全局的，任何用户态或内核态的程序都可以访问同一个 bpf 映射，这可能会导致数据竞争或安全风险。

解决：

bpf映射大小和类型根据实际类型选择合适参数

利用锁来避免数据竞争