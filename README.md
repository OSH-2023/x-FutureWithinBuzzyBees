# 基于eBPF的高性能分布式文件系统存储访问优化

## 🐝小组名称：FutureWithinBuzzyBees

勤劳的小蜜蜂创造未来~🐝

<img src="https://s1.ax1x.com/2023/03/30/pp26vXn.md.jpg" alt="pp26vXn.jpg" border="0" />

## :champagne:小组成员

- PB21111706 常文正
- PB21111707 赵浩怡
- PB21111682 龚劲铭
- PB21061373 刘兆宸
- PB21111725 于硕

## :calendar:项目进度

| 时间 | 主题           | 内容                                                         | 备注         |
| ---- | -------------- | ------------------------------------------------------------ | ------------ |
| 3.18 | 初步选题       | 广泛地讨论了一些可能的选题方向并排除了一些，确定了几个大方向。 |              |
| 3.26 | 具体选题       | 在确定的几个大方向中跟老师交流意见最终确定项目具体选题       | 老师参与讨论 |
| 4.3  | 选题调研       | 在确定了具体选题的基础上，围绕选题进行相关项目的调查和文档的阅读，完成了调研报告初步的汇总 |              |
| 4.8  | 调研文档       | 讨论每个人的调研结果，修改完善了主题调研报告，并就未来可行性分析的报告进行了分工讨论 |              |
| 4.13 | 技术理论方向   | 小组讨论了项目相关的理论依据和技术依据，通过一些目前的技术确定了项目实现的路线雏形，并就雏形展开进一步调研 |              |
| 4.16 | 文件系统IO讨论 | 讨论文件IO的具体实现方向、进行可行性分析报告的小组分工，继续进行相关项目和论文的查阅调研 |              |
| 4.20 | 可行性分析讨论 | 讨论了可能的理论依据和技术依据，确定了较为准确的技术路线，开启了可行性分析的文档资料整理工作 |              |
| 4.22 | 可行性分析汇总 | 可行性分析讨论、文献资料汇总，进一步探讨技术路线和理论技术依据。 |              |
| 4.27 | 中期报告讨论   | 讨论中期报告分工事宜。                                       |              |
| 5.4  | 中期报告汇总   | 分享各自项目进度，汇总中期报告。                             |              |
| 5.11 | 例行会议       | 讨论关于老师对中期报告的反馈结果，并对接下来一周的工作进行了分工：初步部署DFS（DisGraFS）与找到DFS中hook的位置。 |              |

## :soon:项目选题初步讨论结果

小组讨论了往届项目选题和目前顶会涉及到的部分选题，通过排除了一些不感兴趣、难度过大的选题，最后初步确定以下几个方向
1. 基于eBPF内核做xx系统/模块的优化
2. 基于FastDFS/Ceph做分布式文件存储系统的优化/拓展
3. 利用Ray提高分布式文件索引/计算的速度
4. 利用Rust改写/移植已有开源OS

### 经过项目调研后确定具体方向：

经过多个方面的项目调研，小组将注意力主要集中在eBPF和DFS上，并由此确定了多个选题：

- 利用eBPF实现动态追踪Linux系统调用和性能分析

- 利用eBPF实现基于角色的访问控制和审计系统

- 利用eBPF实现高效的网络负载均衡和流量监控

- 利用eBPF实现可编程的网络协议栈和虚拟化

- 利用eBPF实现一个高性能的存储数据路径

**与DFS的结合：**

- 利用eBPF实现分布式文件系统的性能监控和优化
- 利用eBPF提高分布式文件系统中程序的性能和可靠性
- ......

## :telescope:项目选题最终讨论结果

集中讨论了经过调研后的几个方向，结合老师的意见，小组最终确定项目选题为

==基于eBPF的高性能分布式文件系统存储访问优化==

## :computer:项目概述

我们的项目选题是基于eBPF的高性能分布式文件系统存储访问优化，目的是利用eBPF技术提高分布式文件系统的IO性能，减少用户态与内核态之间的数据拷贝次数。

我们的项目基于往届已有的分布式图文件系统DisGraFS展开，参考了2022年OSH的TOBEDONE小组和WowKiddy小组对DisGraFS进行的优化方案，结合我们自己的创新思路，旨在设计并实现一个基于eBPF的分布式文件系统存储访问优化方案。

>  项目调研报告见[research](./docs/research.md)

## :man_technologist:技术理论依据

To be continued...
