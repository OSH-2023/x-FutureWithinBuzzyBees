# 关于eBPF

## Why eBPF?

1. eBPF 的可编程特性

    Linux 内核的主要目的是抽象硬件或虚拟硬件，并提供一致的 API（系统调用），允许应用程序运行和共享资源。为了实现这一目标，需要维护一组广泛的子系统和层来分配这些职责。每个子系统通常允许进行某种级别的配置，以满足用户的不同需求。如果无法配置所需的行为，则需要更改内核，从历史上看，留下两个选项：

![](https://ebpf.io/static/560d57883f7df9beafb47eee1d790247/01295/kernel-arch.png)
 图1. 传统内核功能

- 原生支持
   - 更改内核源代码并说服 Linux 内核社区需要更改。
   - 等待几年，让新的内核版本成为一种商品。
   - 内核模块
- 编写内核模块
   - 定期修复它，因为每个内核版本都可能破坏它
   - 由于缺乏安全边界而导致的 Linux 内核损坏的风险

使用 eBPF，可以使用一个新选项，允许**重新编程 Linux 内核的行为，而无需更改内核源代码或加载内核模块**。

2. 映射Map
    
    eBPF 程序的一个重要方面是共享收集的信息和存储状态的能力。为此，eBPF程序可以利用eBPF映射的概念在广泛的数据结构中存储和检索数据。eBPF 映射可以从 eBPF 程序访问，也可以通过系统调用从用户空间中的应用程序访问。

     以下是支持的映射类型的不完整列表，以便了解数据结构的多样性。对于各种映射类型，共享和每 CPU 变体都可用。

   - 哈希表、数组
   - LRU（最近最少使用）
   - 环形缓冲器
   - 堆栈跟踪
   - LPM（最长前缀匹配）
   - ...

3. 相对丰富的开发工具链
   
   1. bcc  [github仓库](https://github.com/iovisor/bcc)  ,BCC使BPF程序更易于编写，使用C语言进行内核插入（并包括LLVM的C包装器），前端使用Python和lua。它适用于许多任务，包括性能分析和网络流量控制。
   2. bpftrace [github仓库](https://github.com/iovisor/bpftrace)
   3. eBPF Go Library
   4. libbpf C/C++ Library

4. 其他优点
    
    - 帮助程序调用
        
        eBPF 程序不能调用任意内核函数。允许这样做会将 eBPF 程序绑定到特定的内核版本，并使程序的兼容性复杂化。相反，eBPF 程序可以将函数调用到帮助程序函数中，这是内核提供的众所周知且稳定的 API。 
        - 生成随机数
        - 获取当前时间和日期
        - eBPF 地图访问
        - 获取进程/c组上下文
        - 操作网络数据包和转发逻辑...
    - 尾部和函数调用
    - **安全性**
    - 准时编译 ,即时 （JIT） 编译步骤将程序的通用字节码转换为特定于机器的指令集，以优化程序的执行速度。

### 小结
| 维度                | Linux 内核模块                       | eBPF                                           |
| :------------------ | :----------------------------------- | :--------------------------------------------- |
| kprobes/tracepoints | 支持                                 | 支持                                           |
| 安全性              | 可能引入安全漏洞或导致内核 Panic     | 通过验证器进行检查，可以保障内核安全           |
| 内核函数            | 可以调用内核函数                     | 只能通过 BPF Helper 函数调用                   |
| 编译性              | 需要编译内核                         | 不需要编译内核，引入头文件即可                 |
| 运行                | 基于相同内核运行                     | 基于稳定 ABI 的 BPF 程序可以编译一次，各处运行 |
| 与应用程序交互      | 打印日志或文件                       | 通过 perf_event 或 map 结构                    |
| 数据结构丰富性      | 一般                                 | 丰富                                           |                                             |
| 升级                | 需要卸载和加载，可能导致处理流程中断 | 原子替换升级，不会造成处理流程中断             |
| 内核内置            | 视情况而定                           | 内核内置支持                                   |

## 论文阅读

 关于3.18调研的[XRP--一种新的高效存储架构](https://www.usenix.org/conference/osdi22/presentation/zhong), 基本思路是减少多次在用户层到硬件间的访问时间

传统降低数据通路长度的方式是绕过内核直接访问storage device(即硬件)(与之相对的常见data path 为user->system call->file sys->NVme driver-> storage device)从而减少软件部分的开销.但是这样也有很多问题(比如需要禁用中断而需要很多次轮询,进程在等待I/O时无法进入CPU导致
I/O利用率低时会浪费CPU周期且CPU无法在多个进程之间有效共享)

对于用户的请求，发出相关的读取请求以执行查找,从而需要多次从用户空间查找B+树索引,传递请求并沿着layer一直向下，导致多次时间开销.
(相当于从A背100本书到B,一次背一本,而论文的想法是设法一口气把100本书一次性背完).
<a href="https://imgse.com/i/ppaiN6O"><img src="https://s1.ax1x.com/2023/03/21/ppaiN6O.png" alt="ppaiN6O.png" border="0" /></a>
             图2. origin data path

这篇论文的方法是在编写一个存储引擎框架与相应的Custom Function，使得信息流在底层获取完所有索引需要的信息再回到User Space.(custum程序中建立了一个dat buffer[包含要解析的索引B+树的节点]和一个scratch buffer 存储程序)

如何确保用户编写的程序不会破环内核的安全性?

**Answer: eBPF 强大的安全检测能力**

$$
XRP = \begin{cases}BPF-KV\\
WilderTiger-LVM\ Tree
\end{cases}
$$
- BPF-KV : A simple B+ tree key-value store
- WilderTiger(LSM Tree): 基于mongoDB  是一个流行的 production key-value store
  

<a href="https://imgse.com/i/ppaiINn"><img src="https://s1.ax1x.com/2023/03/21/ppaiINn.png" alt="ppaiINn.png" border="0" /></a>
图3. designed data path

### Conclusion

- XRP 是第一个使用BPF来加速通用存储功能的系统

- XRP 在不牺牲CPU利用率和访问控制的情况下，获得了内核旁路的大部分性能优势.

- (测评详见[osdi论文-XRP](https://www.usenix.org/system/files/osdi22-zhong_1.pdf))

- [官方github库](https://github.com/xrp-project/XRP)