[TOC]

# why eBPF

## 提高分布式文件系统IO性能的思路

1. 网络IO优化：如使用高性能网络设备、采用分布式存储技术、使用协议优化

2. 存储设备优化：如使用高速SSD设备、用数据分布技术、使用RAID技术

3. 数据访问优化：如采用数据预读技术、进行缓存优化、使用数据分区存储技术

4. 内存管理优化：如优化系统内存参数、整理内存碎片

5. 引入新技术：如eBPF和XDP技术，可以在内核中优化文件系统的IO操作

## 传统linuxIO过程

![](why_assets/传统IO.jpg)

- read() 和 write() 系统调用
- 会产生多次用户态与进程态之间的上下文切换
- 会产生在各个缓冲区之间的多次数据拷贝

## 现有可加速IO的系统调用函数

![](why_assets/mmap.png)

- mmap：建立内核读缓冲区与用户空间缓冲区的虚拟内存映射
  优化读性能，无法优化写性能
  节省一次用户缓冲区与内核缓冲区间CPU拷贝
  内存映射可能导致内存不足或内存浪费

![](why_assets/sendfile.jpg)

- sendfile：数据可以直接在内核空间内部进行 I/O 传输
    避免数据在用户空间和内核空间之间的来回拷贝
    不可避免数据在内核缓冲区与网络缓冲区之间的拷贝
    用户无法对IO数据进行细粒度的文件操作

![](why_assets/splice.jpg)

- splice：在内核缓冲区和网络缓冲区之间建立管道
    避免数据在用户空间和内核空间之间的来回拷贝
    避免内核缓冲区和网络缓冲区之间的 CPU 拷贝操作
    用户程序不能对IO数据进行修改

## 现有可加速网络数据包处理的相关技术

- DPDK：使用了Kernel Bypass的设计思想，用户程序可跨过网络协议栈和操作系统内核直接访问网络适配器的硬件资源
    开发难度高
    系统维护难
    安全性降低

![](why_assets/xdp架构.jpg)

- XDP：在千兆/万兆网卡驱动程序中运行eBPF程序来对网卡数据流量进行优化、过滤和预处理
    没有提供与用户空间的直接交互方式
    仅适用于数据包处理
    只能在网络接口的驱动程序中使用

## 现有可提高存储与传输效率的相关技术

- 缓存技术
- 分布式存储技术
- SPDK技术: 通过一些特定的API使用户程序可绕过内核直接访问存储设备地址空间和DMA引擎
    SPDK 技术开发门槛较高，且绕过操作系统内核会导致管理和维护困难。

![](why_assets/xrp架构.png)

- XRP技术: 借鉴XDP的实现思路，将中间请求直接在 NVMe 驱动层进⾏重提交，避免经过冗长的存储栈路径
  XRP技术是近两年内提出的，技术发展尚未成熟，也并未与分布式文件系统相结合。

## ebpf的优势

![](why_assets/ebpf参与的IO.jpg)

- ebpf map可以减少数据拷贝次数
- ebpf可以减少用户态与内核态之间的上下文切换
- ebpf可以利用各种内核缓冲区
- ebpf的安全检测机制可以提高程序运行的安全性
- ebpf允许在加速文件传输的同时对文件进行细粒度的操作
- eBPF可以实现内存缓存和预读机制
- eBPF程序可以在运行时动态修改
- eBPF数据可跨平台（如Prometheus，Grafana）使用
