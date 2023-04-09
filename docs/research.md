# 调研报告

[调研报告](#调研报告)

- [项目概述](#项目概述)
- [项目背景](#项目背景)
  - [分布式文件系统(DFS)](#分布式文件系统dfs)
    - [概念](#概念)
    - [优缺点](#优缺点)
    - [发展必要性](#发展必要性)
  - [历届项目对DFS的实现与优化](#历届项目对dfs的实现与优化)
    - [OSH-2017/DFS](#osh-2017dfs)
    - [OSH-2020/dontpanic](#osh-2020dontpanic)
  - [分布式图文件系统（DisGraFS)：](#分布式图文件系统disgrafs)
    - [图数据库](#图数据库)
    - [DisGraFS](#disgrafs)
      - [基本概念](#基本概念)
      - [整体架构](#整体架构)
      - [结构](#结构)
      - [功能与操作](#功能与操作)
        - [新增文件](#新增文件)
        - [文件搜索](#文件搜索)
        - [文件获取](#文件获取)
        - [删除文件](#删除文件)
  - [历届项目对DisGraFS的优化](#历届项目对disgrafs的优化)
    - [OSH-2022/WowKiddy](#osh-2022wowkiddy)
    - [OSH-2022/TOBEDONE](#osh-2022tobedone)
    - [对历届项目的思考](#对历届项目的思考)
  - [eBPF](#ebpf)
    - [简介](#简介)
    - [工作原理](#工作原理)
    - [使用场景](#使用场景)
  - [DMA与零拷贝技术](#dma与零拷贝技术)
    - [传统I/O数据传输过程：](#传统io数据传输过程)
    - [零拷贝技术](#零拷贝技术)
    - [eBPF在DFS中的应用前景](#ebpf在dfs中的应用前景)
- [立项依据](#立项依据)
- [前瞻性/重要性分析](#前瞻性重要性分析)
- [相关工作](#相关工作)
  - [参考历届项目](#参考历届项目)
  - [目前技术参考](#目前技术参考)
  - [参考文献](#参考文献)

## 项目概述

我们的项目选题是基于eBPF的高性能分布式文件系统存储访问优化，目的是利用eBPF技术提高分布式文件系统的IO性能，减少用户态与内核态之间的数据拷贝次数。

我们的项目基于往届已有的分布式图文件系统DisGraFS展开，参考了2022年OSH的TOBEDONE小组和WowKiddy小组对DisGraFS进行的优化方案，结合我们自己的创新思路，旨在设计并实现一个基于eBPF的分布式文件系统存储访问优化方案。

## 项目背景

随着云计算和大数据的不断发展，分布式文件系统在数据存储和处理方面扮演着越来越重要的角色。

往届项目中，dontpanic实现了可用性高的基于互联网网页的小型分布式文件系统，DiaGraphs利用图结构和图数据库管理的方式实现了一个对用户友好的、高可扩展性的分布式图文件系统，WowKiddy在 DisGraFS 的基础上完善了分布式文件系统的缓存机制，在索引和写入读取上进行优化，TOBEDONE在 DisGraFS 的基础上安装了监控系统，实现对计算节点和存储节点之间通信的实时监控。

然而，在分布式文件系统中，IO 性能一直是一个关键的瓶颈。传统的 IO 处理方式，需要在用户态和内核态之间频繁地进行数据拷贝，导致 IO 性能受到限制。为了解决这个问题，可以借助 eBPF 技术进行优化。

### 分布式文件系统(DFS)

#### 概念

分布式文件系统（Distributed File System）管理的物理存储资源不直接连接在本地节点上，而是通过计算机网络与离散分布的不同节点相连。分布式文件系统的设计同样基于Client/Server模式：一个典型的网络可以包括多个供用户访问的服务器，也允许存在同时扮演客户机和服务器的双重角色，用户可以公开一个允许其他客户机访问的公共目录，而且访问这个目录对其他客户机来说就像使用本地驱动器一样方便。

#### 优缺点

**分布式文件系统的优点主要有以下几个方面：**

- 容量：分布式文件系统可以利用多个节点的存储空间，实现PB级甚至EB级的数据规模，满足海量数据的存储需求。
- 可用性：分布式文件系统可以通过数据冗余、负载均衡、故障检测和恢复等机制，提高数据的可用性，避免单点故障导致的数据丢失或不可访问。
- 性能：分布式文件系统可以通过并行读写、缓存、压缩、预取等技术，提高数据的访问性能，支持多个客户端同时访问同一个文件或不同的文件。
- 可扩展性：分布式文件系统可以通过动态添加或删除节点、负载迁移、元数据分布等方法，实现水平扩展或垂直扩展，适应不断变化的数据量和访问负载。

**分布式文件系统的缺点主要有以下几个方面：**

- 一致性：分布式文件系统由于涉及多个节点之间的通信和协调，难以保证强一致性，可能出现数据不同步、更新丢失、读写冲突等问题，需要采用一些复杂的算法或协议来解决。
- 复杂性：分布式文件系统由于涉及多个层次的设计和实现，比如网络、存储、元数据、缓存、锁等，比单机文件系统更加复杂，需要更多的资源和技术来开发和维护。
- 安全性：分布式文件系统由于涉及多个节点之间的数据传输和共享，可能面临更多的安全威胁，比如窃听、篡改、拒绝服务等，需要采用一些加密、认证、授权等措施来保护数据的安全。

#### 发展必要性

1. 目前各大商业网盘传输速度受限、空间收费等特点不能很好地满足我们对存储的需求。

2. 分布式的意义：

   - 解决大规模运算，存储，管理中，单个计算机算力不足，存储空间不足，连接过慢，负载过高的问题

   - 将数据存储在多个节点上，可以调高数据的可靠性和可用性

### 历届项目对DFS的实现与优化

#### OSH-2017/DFS

<img src="./research.assets/image-20230401174545902.png" alt="image-20230401174545902" style="zoom:80%;" />

特点：

- 面向小型文件系统
- 使用Erasure Code编码
- 利用MySQL数据库存储所有的元数据
- WEB服务
- 数据传输中心化，所有文件都要经过中央服务器的中转

#### OSH-2020/dontpanic

基于2017年DFS项目优化。

<img src="./research.assets/image-20230401174423148.png" alt="image-20230401174423148" style="zoom:80%;" />

优化内容：

- 容器化服务器端-采用 Docker 容器化技术，实现服务器端的方便部署，降低使用门槛

  > 容器（Container）是极轻量级的操作系统虚拟化，它封装了所有运行应用程序所必需的相关细节比如应用依赖以及操作系统，这些组件被打包成一个镜像（Images）并可以在不同环境下复用。容器之间的进程是相互隔离的，其中一个容器的升级或者变化不会影响其他容器。由此可见，容器具有高可移植性、高兼容性和高可扩展性。

- 多用户权限支持

- 保留目录节点

- 目录节点验证用户身份，提高数据安全性

- P2P思想，实现点对点数据传输，减轻中央服务器负担

- 纠删码——Reed-Solomon算法

  > 目前，纠删码技术在分布式存储系统中的应用主要有三类，阵列纠删码 （Array Code）、里德-所罗门类纠删码 RS（Reed-Solomon）和低密度奇偶校验纠删码 LDPC（LowDensity Parity Check Code）。

- WebSocket协议实现浏览器和客户端直连以直接传输数据

- 碎片分配策略——提高下载成功率

### 分布式图文件系统（DisGraFS)：

#### 图数据库

图数据库是一个使用图结构对数据进行存储和管理的非关系型数据库，它使用节点、边和属性来表示和存储数据。其最大特点有3个：高维、高性能、高效率。相比于传统的关系型数据库中的关系表（二维表），图数据库采用的是可描述复杂关联关系的高维拓扑结构，在十亿级别的数据量时，仍能保持较好的性能。图数据库可以高效进行关联查询、数据插入，并且提供了针对图查询的语言。

- 不依赖于用户对文件进行的自命名和归类，其查询关键词仅仅取决于文件的内容，非常适用于多用户情境。
- 文件/数据库的维护、关键词提取、查询过程中的计算等任务可以不再集中于一台机器，实现算力、存储和网络资源的合理的分配。
- 客户端无需在本地安装任何软件即可通过网页访问系统，服务端不依赖于特定平台，高可扩展性可以使更多边缘资源易于整合入系统，也确保了系统对各种平台用户的可用性。

#### DisGraFS

DisGraFS——分布式图文件系统

<img src="./research.assets/structure.png" alt="structure" style="zoom:80%;" />

[DisGraFS](https://github.com/OSH-2021/x-DisGraFS.git)为改善传统分布式文件系统的上述问题，提出了分布式图文件系统的概念，统一了单机图文件系统和分布式文件系统的优点。将图结构与思想应用于分布式文件系统上面，使得分布式图文件系统兼具图文件系统方便用户快速搜索，模糊搜索，查找相关文件的特点以及分布式文件系统的海量文件存储，云存储的特点。同时吸取前人的经验，整个项目开发过程均使用便于跨平台的语言和属性，以满足当今以及未来社会对于多设备，多平台的大容量，快搜索的文件系统的需求。

##### 基本概念

- 图文件系统：逻辑上抛弃树状结构，文件之间用“关系”连接。基于语义的局部性：有共同特征的文件相连
- 分布式图文件系统：底层存储采用分布式存储，语义识别采用分布式计算，用图结构描述文件之间的关系

##### 整体架构

DisGraFS分为5个部分：索引服务器、分布式存储集群、分布式计算集群、网页端和客户端。

- 索引服务器：与分布式计算集群的通信、网页端部署的位置，目前也负责构建与维护图数据库（但若有需要，也可将图数据库的部分分离出去）；
- 分布式存储集群：基于 Juicefs 的分布式储存系统，管理、存储和调度分布式存储系统中的所有文件；
- 分布式计算集群：基于 Ray 的分布式计算系统，将文本语义识别、图像识别、语音识别以及元数据提取等任务分散给计算集群中的多个计算机；

- 网页端：直观显示文件所构成的图，并将用户在图上的操作以友好方式展示；
- 客户端：客户端负责直接接收用户对文件系统的操作，并针对不同的平台对其进行实现。

##### 结构

- 中央索引服务器负责调度、维护图数据库、提供用户接口

- 分布式存储集群：JuiceFS + 阿里云 OSS
- 图数据库：Neo4j
- 网页前端：Neo4j 官方提供的 ds.js 和 pototo.js 框架
- 文件语义识别：文本（python库pke）、图像（imagga）、语音（speech_recognition）、视频（tingTag）
- 分布式计算集群：RAY + VLAB

##### 功能与操作

###### 新增文件

1. 用户在网页端启动客户端，将分布式存储集群挂载在本地电脑上；
2. 用户将需要上传的文件拖入JuiceFS对应的盘，此时分布式存储系统对文件进行切分并通过合理的调度将文件分布式的存储在存储集群中；
3. 分布式存储集群发信息给索引服务器，索引服务器将信息转发给分布式计算集群，开始对文件进行内容识别并且打出标签；
4. 打标完成后，分布式计算集群将标签以及文件其他信息一起发送返回给索引服务器，索引服务器根据收到的标签以及文件信息更新图数据库。

###### 文件搜索

1. 用户在网页端提出文件搜索请求，网页端将搜索关键字（可以是标签，也可以是文件名）上传至索引服务器；
2. 索引服务器根据关键字创建搜索语句，在图数据库中搜索，将具有相关标签的所有文件通过图和列表两种方式返回至网页端；

3. 用户可以根据网页端返回的图，直接通过点击获得某一文件的标签与信息，或者获得具有某一标签的所有文件，实现根据文件内容进行搜索以及在图上直接搜索邻顶的目标。

###### 文件获取

1. 用户在关键词搜索返回的文件中找到自己需要的文件，点击打开文件的按键，服务器将消息传给 JuiceFS 分布式存储集群；

2. 分布式存储集群找到需要打开的文件，将其下载到用户本地存储空间并将其打开。

###### 删除文件

1. 用户在客户端提出删除文件的请求，客户端将目标文件名上传至索引服务器；
2. 索引服务器将信息传递给分布式存储集群，分布式存储集群将文件删除；
3. 索引服务器根据文件名删除图数据库中对应的节点，更新图数据库。

### 历届项目对DisGraFS的优化

#### OSH-2022/WowKiddy

基于2021年DisGraFS项目，根据文件自然属性的逻辑关联，完善分布式文件系统的缓存机制；加入监控部件。

- 主动缓存逻辑cache，加速相同逻辑关联的文件的访问
- 前端支持图片视频预览

- 监控部件检测各类运行指标

#### OSH-2022/TOBEDONE

基于DisGraFS，参考2020年dontpanic项目，添加监控运维模块。

- 实现真正的的远程存储集群，用户所有操作在网页端进行
- 完善网页端操作，简化用户操作
- 引入监控模块，监控数据图形可视化
- 运维工作者可以远程唤醒或关闭存储节点

#### 对历届项目的思考

以上的往届项目均涉及分布式文件系统，2022年的两个项目在DisGraFS基础上进行优化，但当前的分布式文件系统的IO性能仍有优化空间。

传统的分布式文件系统通常采用客户端-服务器模式，每个客户端与服务器之间需要进行频繁的IO操作，而用户态和内核态之间频繁的数据拷贝使得IO效率降低。

### eBPF

#### 简介

eBPF是一种可编程的内核技术，可以在不修改内核源代码的情况下，动态地改变内核的行为。eBPF的全称是扩展的Berkeley Packet Filter，最初是用于网络数据包过滤和分析的。现在，eBPF已经发展成为一种通用的内核执行引擎，可以在内核中运行用户定义的程序，实现各种功能，如性能监控、安全审计、故障排除、跟踪分析等。eBPF的优点是它可以提供高效、灵活、安全的内核编程能力，而不需要重新编译或重启内核。

#### 工作原理

1. BPF Program 通过 LLVM/Clang 编译成 eBPF 定义的字节码 prog.bpf
2. 通过系统调用 bpf() 将 bpf 字节码指令传入内核中
3. 经过 verifier 检验字节码的安全性、合规性
4. 在确认字节码安全后将其加载对应的内核模块执行，通过 Helper/hook 机制，eBPF 与内核可以交换数据/逻辑。BPF 观测技术相关的程序程序类型可能是kprobes/uprobes/tracepoint/perf_events 中的一个或多个，其中：
   - kprobes：实现内核中动态跟踪。 kprobes 可以跟踪到 Linux 内核中的函数入口或返回点，但是不是稳定 ABI 接口，可能会因为内核版本变化导致跟踪失效。理论上可以跟踪到所有导出的符号 /proc/kallsyms 。
   - uprobes：用户级别的动态跟踪。与 kprobes 类似，只是跟踪的函数为用户程序中的函数。
   - tracepoints：内核中静态跟踪。tracepoints 是内核开发人员维护的跟踪点，能够提供稳定的 ABI 接口，但是由于是研发人员维护，数量和场景可能受限。
   - perf_events：定时采样和 PMC 。

5. 用户空间通过 BPF map 与内核通信。

#### 使用场景

![img](./research.assets/90e32d200bad7a69e65cf57f12a08424.png)

**网络场景**

依赖eBPF的网络加速方案——XDP（eXpress Data Path）

<img src="./research.assets/image-20230401222246060.png" alt="image-20230401222246060" style="zoom:70%;" />

此前的kernel bypass实现方式是：将网络硬件完全交由某个专门的用户空间应用（userspace application）接管，从而避免内核和用户态上下文切换的昂贵性能开销。但是，操作系统被旁路（绕过）之后，它的应用隔离（application isolation） 和安全机制（security mechanisms）就都失效了；一起失效的还有各种经过已经 充分测试的配置、部署和管理工具。

基于这个问题，XDP被提出。XDP与内核网络栈协同工作，将硬件的控制权完全留在内核范围内，带来以下优点:

- 保持了内核的安全边界
- 无需对网络配置或管理工具做任何修改，可以选择性地复用内核网络栈中的现有功能，例如路由表或 TCP/IP 协议栈，在保持配置接口不变的前提下，加速关键性能路径（critical performance paths）
- 保证 eBPF 指令集和 XDP 相关的编程接口（API）的稳定性
- 与常规 socket 层交互时，没有从用户态将包重新注入内核的昂贵开销

XDP 程序能将数据包重定向到用户空间应用（userspace application）打开的特殊类型 socket。这可以用于加速客户端和服务端在同一台机器的网络密集型应用（network-heavy applications running on the local machine）。而拷贝数据包会使该方式的性能降低，进而产生了对基于eBPF的零拷贝的讨论，即：在内核空间中实现零拷贝技术，避免数据在用户空间和内核空间之间拷贝，从而提高IO效率。

### DMA与零拷贝技术

**DMA**是一种内存访问技术。DMA（Direct Memory Access，直接存储器访问）可以在不需要 CPU 参与的情况下实现内存的读取或写入，因为不依赖 CPU 的大量中断负载，因而可以实现数据的快速传送，提高系统的并发性能。

DMA 的传输过程必须经过 DMA 请求，DMA 响应，DMA 传输，DMA 结束 4 个步骤：

- DMA 请求：CPU 对 DMA 芯片进行设置，说明需要传送的字节数，有关的设备和内存地址，然后启动 DMA；
- DMA 响应：DMA 向 CPU 请求总线控制权，CPU 处理完当前总线数据后就让出总线；
- DMA 传输：DMA 控制器直接控制内存与 I/O 接口进行数据传输；
- DMA 结束：DMA 传输结束后，把总线控制权交还给 CPU，并向 I/O 接口发送结束信号。

**零拷贝**指计算机不需要先将数据从一个内存区域复制到另外一个内存区域，从而减少系统调用切换、减少拷贝次数，从而减少 CPU 的执行时间和负载。

#### 传统I/O数据传输过程：

在没有 DMA 技术前，I/O 的过程是这样的：

- CPU 发出对应的指令给磁盘控制器，然后返回；
- 磁盘控制器收到指令后，于是就开始准备数据，会把数据放入到磁盘控制器的内部缓冲区中，然后产生一个**中断**；
- CPU 收到中断信号后，停下手头的工作，接着把磁盘控制器的缓冲区的数据一次一个字节地读进自己的寄存器，然后再把寄存器里的数据写入到内存，而在数据传输的期间 CPU 是无法执行其他任务的。

![img](./research.assets/I_O%20%E4%B8%AD%E6%96%AD.png)



传统的 I/O 方式需要经过**四次**拷贝才能把磁盘上的数据输出到网络端口：

1. 执行 read 系统调用，从用户态切换到内核态，CPU 向 DMA 控制器芯片下发指令，将磁盘数据通过直接内存访问的方式拷贝到内核缓冲区中；
2. CPU 接收到 DMA 结束拷贝的信号，将内核缓冲区的数据拷贝到用户缓冲区中，read 调用结束，返回到用户态；
3. 用户程序执行 write 系统调用，从用户态切换到内核态，CPU 将数据从用户缓冲区中拷贝到Socket 发送缓冲区中；
4. CPU 下发指令，让 DMA 控制器来处理数据，将 Socket 发送缓冲区的数据拷贝到网卡进行网络传输，write 调用结束。

![img](./research.assets/%E4%BC%A0%E7%BB%9F%E6%96%87%E4%BB%B6%E4%BC%A0%E8%BE%93.png)

由此可以看出传统的文件传输开销很大，期间共**发生了 4 次用户态与内核态的上下文切换**，还**发生了 4 次数据拷贝**，其中两次是 DMA 的拷贝，另外两次则是通过 CPU 拷贝的，过多的数据拷贝无疑会消耗 CPU 资源，大大降低了系统性能。

#### 零拷贝技术

零拷贝有几种实现方式，如下：

- **mmap + write**：mmap 是一个系统调用，主要作用就是将用户缓冲区与内核中的读缓冲区进行映射，映射后这一步就不需要进行数据拷贝了，而 write 操作实际上是从内核读缓冲区中把数据拷贝到 Socket 发送缓冲区，整个过程减少了一次拷贝操作，但是系统调用切换没有减少。

![img](./research.assets/mmap%20+%20write%20%E9%9B%B6%E6%8B%B7%E8%B4%9D.png)

- **sendfile**：sendfile 同样省去了将数据在内核和用户空间中拷贝，与 mmap 不同的是，sendfile 不需要借助 write 调用，而是一次完整的内核拷贝过程，减少了两次 CPU 上下文切换。
- ![img](./research.assets/senfile-3%E6%AC%A1%E6%8B%B7%E8%B4%9D.png)
- **sendfile + DMA gather copy**：对 sendfile 系统调用做了修改，引入了 gather 操作，不需要将内核缓冲区的数据拷贝到 Socket 中，而是将它对于的数据描述信息（内存地址、文件描述符，文件长度等）记录到 Socket 缓冲区中，最后由 DMA 根据这些文件描述信息从内核读缓冲区中找到数据，直接拷贝到网卡设备中。
- **splice**：splice 系统调用可以在内核空间的读缓冲区和网络缓冲区之间建立管道（pipeline），从而避免了两者之间的 CPU 拷贝操作。

#### eBPF在DFS中的应用前景

传统IO数据传输需要进行四次数据拷贝，大大降低了数据传输的效率，利用eBPF的kernel bypass特性，实现零拷贝技术，避免了用户态和内核态之间的多次拷贝，从而实现高性能分布式文件系统文件存储与读取接口。这是一种基于eBPF的FUSE模块的设计思路，通过在内核中运行eBPF程序，可以在不修改内核代码的情况下，实现对execve等系统调用的hook，并将用户态文件系统的数据直接传递给内核态的eBPF虚拟机，从而减少上下文切换和内存拷贝的开销。这种方式可以提高分布式文件系统的性能和灵活性，同时也保证了安全性和兼容性。

## 立项依据

前人之工作备矣，然当今大数据时代对文件的访存需求急剧增加，高性能存储设备虽已层出不穷，但数据交互速度提升的瓶颈在于用户态与内核态之间IO的繁琐协议栈。通过某些方法绕开内核（Bypass Kernel）从而简短数据传输的路径是自然能想到的办法。与此同时，eBPF技术的横空问世使得在不危及内核安全的前提下，加速内核对数据包的处理流程成为可能：

1. 传统的分布式文件系统通常采用客户端-服务器模式，每个客户端与服务器之间需要频繁进行 IO 操作，包括读取和写入数据。然而，由于数据需要在用户态和内核态之间频繁地进行数据拷贝，传统的 IO 处理方式很难满足大规模数据存储和处理的需求。因此，如何提高分布式文件系统的 IO 性能成为了亟待解决的问题。
2. eBPF 技术在解决 IO 性能问题方面具有独特的优势。eBPF 技术可以将一些 IO 操作从内核态移动到用户态，避免了数据在内核态和用户态之间频繁地进行数据拷贝，从而可以大大提高 IO 性能。此外，eBPF 还可以对 IO 操作进行监控和控制，提高系统的可靠性和安全性。

面对前述现状，我们希望在前辈已有项目的基础上，基于eBPF实现具有高性能IO的分布式文件系统，并向用户提供网页端接口。

本项目旨在借助 eBPF 技术，实现分布式文件系统的 IO 性能优化，提高系统的数据处理能力和可靠性。

## 前瞻性/重要性分析

分布式文件系统是当前数据爆炸时代文件系统的主流方式，但目前DFS的优异性能还没有被完全开发、普通个体更无法接触到许多优质可用的DFS，为此ustc的osh项目组历经多年努力，一脉相承优化，终于使一个优质的分布式文件系统初见雏形。然而在使用DFS时，用户对更高效率的文件传输的朴素需求还并没有得到很好的满足。基于此，我们利用时兴的eBPF技术对linux内核态与用户态之间的数据通信进行速度上的提升优化，以期在保证内核安全的同时极大地提升效率，将是对分布式文件系统及内核性能的再一次深度挖掘开发。

本项目的前瞻性和重要性在于：

1. IO 性能优化是分布式文件系统的关键问题之一，传统I/O 操作，内存与磁盘的数据传输的工作都是由 CPU 完成的，而此时 CPU 不能执行其他任务，会特别浪费 CPU 资源。并且，传统的文件系统存在冗余的上文切换和数据拷贝，在高并发系统里是非常糟糕的，多了很多不必要的开销，会严重影响系统性能。
2. eBPF 技术在解决 IO 性能问题方面具有独特的优势， 利用eBPF 技术进行优化，减少用户态和内核态的上下文切换，减少拷贝次数，可以提高CPU利用率，减少时间开销，同时由于内核eBPF校验器的存在，使得文件访问传输的可靠性和安全性也有一定的保证。

当今时代，随着数据量的不断增加，文件系统I/O性能的提高变得越来越重要。这是因为文件系统I/O性能的提高可以带来更快的读写速度，从而提高系统的整体性能。因此，本项目的研究具有重要的前瞻性和应用价值。通过本项目的研究，可以深入探索eBPF技术在分布式文件系统中的应用，为提高系统的IO性能提供有效的解决方案，为未来的分布式系统的发展做出贡献。

## 相关工作

### 参考历届项目

OSH2017实现一个基于Erasure Code技术的,可以使用网页快速访问的小型分布式文件系统：[IngramWang/DFS_OSH2017_USTC ](https://github.com/IngramWang/DFS_OSH2017_USTC)

OSH2020在17年已有的项目的基础上，实现容器化服务器端、多用户权限支持、更高效的文件传输、减轻中央服务器负担、提高文件安全性和可用性等优化：[OSH-2020/x-dontpanic: team dontpanic in ustc-osh-2020 (github.com)](https://github.com/OSH-2020/x-dontpanic)

OSH2021基于JuiceFS构建分布式图文件系统（DisGraFS, Distributed Graph Filesystem），来实现图文件系统在更大规模上的应用。通过主机（Master）对从机（Slave）的存储空间以及算力的合理调度以及在主机的指导下用户与从机之间的直接对接：<https://github.com/OSH-2021/x-DisGraFS>

OSH2022在2021年OSH项目[x-DisGraFS](https://github.com/OSH-2021/x-DisGraFS) 的基础上，根据文件自然属性的逻辑关联，完善分布式文件系统的缓存机制，同时在索引和写入读取上进行优化，并且保证部署的稳定性和便捷性，以期望提高分布式文件系统的性能：<https://github.com/OSH-2022/x-WowKiddy>

OSH2022在DisGraFS实现的优化——监测功能：该致力于在 DisGraFS 上安装分布式监控系统，实现对计算节点和存储节点之间通信的实时监控，从内部的运行细节出发，自内而外掌握系统的状态，保证系统和服务的正常运行。<https://github.com/OSH-2022/x-TOBEDONE>

### 目前技术参考

**XRP: In-Kernel Storage Functions with eBPF:**

([XRP: In-Kernel Storage Functions with eBPF](https://github.com/xrp-project/XRP)) 论文和slides见[research_lzc.md](3.19 完成组队，初拟题目/research_lzc.md)

其中提到XRP是首个使用eBPF来降低内核存储软件开销的系统 XRP允许应用程序从NVMe驱动程序中的eBPF钩子执行用户定义的存储函数，可以安全地绕过大部分内核的存储栈。有巨大的借鉴意义

**基于RDMA技术的分布式文件系统方案**

[基于RDMA高速网络的高性能分布式系统 - 腾讯云开发者社区-腾讯云 (tencent.com)](https://cloud.tencent.com/developer/news/330802)

可以通过减少数据在内核和用户空间之间的拷贝次数来提高系统的IO性能。RDMA（Remote Direct Memory Access）是一种高性能网络传输技术，它有以下几个特点

- 零拷贝(Zero-copy) - 应用程序能够直接执行数据传输，在不涉及到网络软件栈的情况下。数据能够被直接发送到缓冲区或者能够直接从缓冲区里接收，而不需要被复制到网络层。
- 内核旁路(Kernel bypass) - 应用程序可以直接在用户态执行数据传输，不需要在内核态与用户态之间做上下文切换。
- 不需要CPU干预(No CPU involvement) - 应用程序可以访问远程主机内存而不消耗远程主机中的任何CPU。远程主机内存能够被读取而不需要远程主机上的进程（或CPU)参与。远程主机的CPU的缓存(cache)不会被访问的内存内容所填充。
- 消息基于事务(Message based transactions) - 数据被处理为离散消息而不是流，消除了应用程序将流切割为不同消息/事务的需求。
- 支持分散/聚合条目(Scatter/gather entries support) - RDMA原生态支持分散/聚合。也就是说，读取多个内存缓冲区然后作为一个流发出去或者接收一个流然后写入到多个内存缓冲区里去。

将RDMA和eBPF结合使用可以实现更高效的网络传输和更灵活的网络过滤。通过使用eBPF，可以在RDMA传输过程中对数据进行更细粒度的过滤和处理。例如，可以使用eBPF程序对传输的数据进行监控和分析，以便更好地了解网络瓶颈和性能问题。

同时，RDMA和eBPF的结合还可以实现更高级的网络应用，例如远程内存访问和远程文件系统访问。这些应用程序可以利用RDMA和eBPF的高性能和灵活性，实现更快速和可靠的数据传输和处理。

**eBPF在高性能IO接口方向的探索**

| 高性能IO相关技术实现对比 |         针对领域         |                             优点                             |                             缺点                             |
| :----------------------: | :----------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|           XRP            | 本地存储设备接口（NVMe） |                 在IO密集型应用下表现相对稳定                 | 应用场景相对局限<br>对文件系统有一定侵入性<br>表现与所使用的数据结构有关<br> |
|           RDMA           | 高性能云计算平台（HPC）  |    零拷贝<br>低延时<br>有效减轻服务器的CPU和内存负担<br>     | 要求网络不丢包<br>对网络规模有限制<br>对硬件的使用和管理较为复杂<br> |
|        本项目eBPF        |      通用网络数据流      | 高灵活性<br>高安全性<br>接口工具链丰富<br>可单机部署<br>对硬件要求低<br> |                         技术门槛较高                         |

### 参考文献

<https://juicefs.com/docs/zh/community/cache_management/>
<https://tech.ipalfish.com/blog/2020/07/21/tidb_monitor/>
<https://zhuanlan.zhihu.com/p/558509760?utm_id=0>
<https://istio.io/latest/zh/blog/2022/merbridge/>
<https://heapdump.cn/article/4385115?>
<https://dl.acm.org/doi/10.1145/3281411.3281443>


