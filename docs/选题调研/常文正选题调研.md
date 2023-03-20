# 基于初拟题目几个方向的选题调查

## 基于eBPF内核做xx系统/模块的优化

[eBPF是一种能够在内核运行沙箱程序的技术，提供了一种在内核事件和用户程序事件发生时安全注入代码的机制，使得非内核开发人员也可以对内核进行控制。eBPF最初是用于高效网络报文过滤，但现在已经扩展到其他领域，如性能优化、安全、调试等](https://zhuanlan.zhihu.com/p/480811707)[4](https://zhuanlan.zhihu.com/p/480811707)[5](https://zhuanlan.zhihu.com/p/492185920)[6](https://zhuanlan.zhihu.com/p/182344856)。

以下是一些可能的选题/课题：

- 利用eBPF实现动态追踪Linux系统调用和性能分析
- 利用eBPF实现基于角色的访问控制和审计系统
- 利用eBPF实现高效的网络负载均衡和流量监控
- 利用eBPF实现可编程的网络协议栈和虚拟化

### 利用eBPF实现动态追踪Linux系统调用和性能分析

[这个选题的目的是利用eBPF技术来实现动态追踪Linux系统调用和性能分析，从而可以对Linux系统和应用程序进行优化和调试。根据网上的信息](https://zhuanlan.zhihu.com/p/610037717)[1](https://zhuanlan.zhihu.com/p/610037717)[2](https://cloud.tencent.com/developer/article/1770833)[3](https://cloud.tencent.com/developer/article/2049075)[，eBPF可以非常容易地监控和跟踪Linux内核的各种事件，如CPU使用率、网络性能、文件操作、内存分配等，并且对系统性能影响很小。你可以利用eBPF编写自定义的程序来收集你想要的内核数据，并且可以在用户空间进行分析和展示。你还可以利用一些现有的工具，如tracee](https://cloud.tencent.com/developer/article/1770833)[2](https://cloud.tencent.com/developer/article/1770833)，来追踪容器和系统事件。

这个选题可能涉及到以下几个方面：

- eBPF基本原理和编程方法
- Linux系统调用机制和性能指标
- eBPF追踪工具的使用和开发
- eBPF数据分析和可视化

> 一些相关的论文或者项目参考，可以参考：
>
> - [使用 ChatGPT ，通过自然语言编写 eBPF 程序和追踪 Linux 系统](https://zhuanlan.zhihu.com/p/608979269)[1](https://zhuanlan.zhihu.com/p/608979269)[2](https://zhuanlan.zhihu.com/p/612304463)：这是一个使用自然语言处理技术来生成eBPF程序和命令的项目，可以让你用中文或者英文等多种语言来描述你想要追踪的目标和数据，然后自动编译运行eBPF程序，并展示结果。
> - 浅谈：Linux中基于eBPF的恶意利用与检测机制[3](https://www.infoq.cn/article/qlvqdfa3D6RvD3ywHcOx)：这是一篇介绍eBPF在安全领域的应用和挑战的文章，分析了eBPF可能被恶意利用的方式和风险，以及如何使用eBPF来检测和防御这些攻击。

### 利用eBPF实现基于角色的访问控制和审计系统

[这个选题的目的是利用eBPF技术来实现基于角色的访问控制和审计系统，从而可以对Linux系统和应用程序进行安全管理和监督。根据网上的信息](https://zhuanlan.zhihu.com/p/182344856)[1](https://zhuanlan.zhihu.com/p/182344856)[2](https://zhuanlan.zhihu.com/p/114451395)[3](https://cloud.tencent.com/developer/article/1997629)，eBPF可以在Linux内核中运行沙盒程序，而无需更改内核源代码或加载内核模块，这使得它可以用于实现网络、安全性、观测性等各种场景。基于角色的访问控制（RBAC）是一种常见的安全机制，它将权限与角色相关联，用户通过成为适当角色的成员而得到这些角色的权限。你可以利用eBPF编写自定义的程序来实现对系统资源（如文件、网络、进程等）的访问控制和审计，并且可以在用户空间进行配置和报告。

这个选题可能涉及到以下几个方面：

- eBPF基本原理和编程方法
- RBAC基本概念和设计方法
- eBPF访问控制和审计工具的使用和开发
- eBPF数据分析和可视化

> 一些相关的论文或者项目参考，你可以参考一下：
>
> - 使用 eBPF 增强监控和可观测性[1](https://zhuanlan.zhihu.com/p/529240150)：这是一篇介绍 eBPF 在监控和可观测性方面的应用和优势的文章，展示了如何使用 eBPF 来收集系统和应用程序的各种指标和事件，并且如何利用 Grafana 和 Prometheus 等工具来进行数据分析和可视化。
> - eBPF开发指南[2](https://www.cnblogs.com/senberhu/p/15730774.html)：这是一篇详细的 eBPF 开发教程，从基本原理到编程方法，从工具链到调试技巧，涵盖了 eBPF 开发的各个方面，可以帮助你快速入门和提高 eBPF 编程能力。
> - 信息安全中的访问控制[3](https://zhuanlan.zhihu.com/p/151618654)：这是一篇介绍信息安全中四种常见的访问控制机制（DAC、role-BAC、rule-BAC 和 MAC）的文章，比较了它们的特点、优缺点和使用场景，可以帮助你理解访问控制的基本概念和设计方法。

### 利用eBPF实现高效的网络负载均衡和流量监控

这个选题的目的是利用eBPF技术来实现一个高效的网络负载均衡和流量监控系统，从而可以对网络服务进行优化和保障。根据网上的信息 ，eBPF可以在Linux内核中运行沙盒程序，而无需更改内核源代码或加载内核模块，这使得它可以用于实现网络、安全性、观测性等各种场景。网络负载均衡是一种将网络流量分配到多个后端服务器的技术，以提高服务的可用性和性能。流量监控是一种收集和分析网络流量数据的技术，以了解服务的状态和问题。你可以利用eBPF编写自定义的程序来实现对网络包的拦截、修改、转发和统计，并且可以在用户空间进行配置和报告。

这个选题可能涉及到以下几个方面：

- eBPF基本原理和编程方法
- 网络负载均衡基本概念和设计方法
- 流量监控基本概念和设计方法
- eBPF负载均衡和流量监控工具的使用和开发
- eBPF数据分析和可视化

> 一些相关的论文或者项目参考，你可以参考一下：
>
> - eBPF 流量监控[1](https://source.android.google.cn/devices/tech/datausage/ebpf-traffic-monitor?hl=zh-cn)：这是一个介绍 Android 开源项目中使用 eBPF 来实现流量监控的文档，包括了 eBPF 的基本原理、流量监控的设计思路、代码示例和测试方法。
> - [浅谈：Linux中基于eBPF的恶意利用与检测机制](https://www.infoq.cn/article/qlvqdfa3D6RvD3ywHcOx)[2](https://www.infoq.cn/article/qlvqdfa3D6RvD3ywHcOx)：这是一篇分析 eBPF 在安全领域的应用和挑战的文章，讨论了 eBPF 的功能和优势，以及如何利用 eBPF 进行恶意篡改和如何利用 eBPF 进行有效检测。
> - 聊聊最近很火的eBPF[3](https://zhuanlan.zhihu.com/p/182344856)：这是一篇概述 eBPF 的技术特点和应用场景的文章，介绍了 eBPF 在网络、安全性、观测性等方面的优势和案例，以及如何使用 eBPF 工具来进行开发和调试。

### 利用eBPF实现可编程的网络协议栈和虚拟化

[这个选题的目的是利用eBPF技术来实现一个可编程的网络协议栈和虚拟化系统，从而可以对网络服务进行定制化和优化。根据网上的信息](https://zhuanlan.zhihu.com/p/378766217)[1](https://zhuanlan.zhihu.com/p/378766217)[2](https://www.infoq.cn/article/Tc5Bugo5vBAkyaRb5CCU)[3](https://cloud.tencent.com/developer/article/2216617)，eBPF可以在Linux内核中运行沙盒程序，而无需更改内核源代码或加载内核模块，这使得它可以用于实现网络、安全性、观测性等各种场景。eBPF还提供了一种存储类型，叫做eBPF maps，可以保存状态信息，并且可以在内核态和用户态之间进行数据交换。eBPF还支持一种功能，叫做XDP（Express Data Path），可以在网卡驱动层进行数据包处理，从而实现高效的网络负载均衡、过滤、转发等功能。

这个选题可能涉及到以下几个方面：

- eBPF基本原理和编程方法
- 网络协议栈基本概念和设计方法
- 网络虚拟化基本概念和设计方法
- eBPF网络协议栈和虚拟化工具的使用和开发
- eBPF性能测试和优化

> 一些相关的项目参考，你可以参考一下：
>
> - [eBPF技术简介](https://cloud.tencent.com/developer/article/1684491)：这是一个介绍 eBPF 技术基本原理和应用场景的项目，包括了 eBPF 的历史、架构、工具链、示例和未来展望。
> - [eBPF技术实践：高性能ACL](https://www.infoq.cn/article/Tc5Bugo5vBAkyaRb5CCU)：这是一个利用 eBPF 和 XDP 来实现高性能访问控制列表（ACL）的项目，包括了设计思路、代码示例、测试结果和优化方法。
> - [超细节！十年码农讲述eBPF和XDP技术！](https://zhuanlan.zhihu.com/p/558509760)：这是一个深入解析 eBPF 和 XDP 技术原理和实现细节的项目，包括了 eBPF 和 XDP 的概念、特点、优势、工作流程、编程方法和应用案例。

## 利用Ray提高分布式文件索引/计算的速度

Ray是一个通用的集群计算框架，支持机器学习、仿真、模型服务等多种应用场景。Ray的设计目标是提供简单但通用的抽象编程方式，让开发者可以轻松地构建和运行分布式应用。Ray还提供了一些高层次的库，如Tune、RLlib、Serve等，来实现不同领域的优化和学习任务。

基于Ray的特点和优势，我为你推荐以下几个可能感兴趣的选题/课题：

- 利用Ray Tune实现超参数自动调优
- 利用Ray RLlib实现强化学习算法在不同环境中的迁移
- 利用Ray Serve构建可扩展和高性能的模型服务系统
- 利用Ray和PyTorch实现大规模图神经网络的分布式训练
- 探索Ray在边缘计算场景下的应用和挑战

经过调研，主要是关于深度学习和强化学习等相关技术优化，与OS相干性不大。

## 利用Rust改写/移植已有开源OS

已有项目参考：

- [一个项目是uutils/coreutils，它用RUST重写了GNU coreutils的一些常用命令，比如ls、cat、cp等。](https://github.com/uutils/coreutils)[1](https://github.com/uutils/coreutils)
- [另一个项目是Redox OS，它是一个类Unix的操作系统，完全用RUST编写，目标是利用RUST的创新特性来构建一个现代的微内核和一整套应用程序。](https://www.redox-os.org/)[4](https://www.redox-os.org/)
- [还有一个项目是Writing an OS in Rust，它是一个博客系列，教你如何用RUST从零开始编写一个小型的操作系统。](https://os.phil-opp.com/)[5](https://os.phil-opp.com/)