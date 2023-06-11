[eBPF Tracing 入门教程与实例 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/67273340)

[bcc/tutorial.md at master · iovisor/bcc (github.com)](https://github.com/iovisor/bcc/blob/master/docs/tutorial.md) bcc教程



[eBPF 科普第一弹｜ 初识 eBPF，你应该知道的知识_基础软件_Daocloud 道客_InfoQ写作社区](https://xie.infoq.cn/article/a03bff551844957cc79a4c92d#:~:text=eBPF 可以做什么？ 一个 eBPF 程序会附加到指定的内核代码路径中，当执行该代码路径时，会执行对应的 eBPF,程序。 鉴于它的起源， eBPF 特别适合编写网络程序 ，将该网络程序附加到网络 socket，进行流量过滤、流量分类以及执行网络分类器的动作。) 

下面有两个ebpf项目，关于快速处理数据包和优化负载均衡器

1. 快速处理数据包

[facebookincubator/katran: A high performance layer 4 load balancer (github.com)](https://github.com/facebookincubator/katran)

[这个项目是一个用C++和BPF编写的高性能的四层负载均衡转发平面的库和程序。它利用内核的XDP基础设施提供了一个快速处理数据包的内核功能。](https://github.com/facebookincubator/katran)[1](https://github.com/facebookincubator/katran)

这个项目的主要特点是：

- 极快的速度（尤其是在驱动模式下的XDP）。性能随着NIC的RX队列的数量线性增长。
- RSS友好的封装：它使用ipip封装从四层负载均衡器到七层负载均衡器的数据包。但是，为了能够与七层负载均衡器接收端的RSS协同工作，它不是使用相同的源IP地址，而是制作一个特殊的源IP地址，使得不同的流有不同的外部（ipip）源IP，但是同一流中的数据包总是有相同的源IP。
- 固定大小（启动时可配置）的连接跟踪表，使用LRU策略淘汰旧条目。
- 修改过的Maglev哈希算法用于连接：它为我们提供了故障时的良好恢复能力和优秀的负载均衡特性。哈希算法被修改为能够支持后端（七层负载均衡器）服务器的不等权重。
- 不需要在接收路径上忙等：如果没有流量要处理，你的负载均衡器几乎不会消耗任何CPU资源。
- katran（以及XDP通用）允许你在同一台服务器上运行任何应用程序，而不会有任何性能损失（与其他一些“内核绕过”技术相比）。



2. 优化负载均衡器

[利用ebpf优化负载均衡器 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/527819654)

[负载均衡器是一种充当反向代理的设备，可以将网络或应用流量分配于多个服务器，提高应用容量（并发用户）和可靠性](https://www.f5.com.cn/glossary/load-balancer)[1](https://www.f5.com.cn/glossary/load-balancer)[。负载均衡器可以在不同的网络层上工作，如第四层（传输层）或第七层（应用层）](https://learn.microsoft.com/zh-cn/azure/load-balancer/load-balancer-overview)[2](https://learn.microsoft.com/zh-cn/azure/load-balancer/load-balancer-overview)[3](https://zhuanlan.zhihu.com/p/366204416)。负载均衡器可以提高应用的整体性能，可用性和安全性。
