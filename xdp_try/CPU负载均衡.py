#!/usr/bin/python
#
# xdp_redirect_cpu_lb.py Load balance incoming packets across multiple CPUs
#
# Copyright (c) 2018 Gary Lin
# Licensed under the Apache License, Version 2.0 (the "License")

from bcc import BPF
import time
import sys
from multiprocessing import cpu_count
import ctypes as ct

flags = 0
def usage():
    print("Usage: {0} <in ifdev>".format(sys.argv[0]))
    print("e.g.: {0} eth0\n".format(sys.argv[0]))
    exit(1)

if len(sys.argv) != 2:
    usage()

in_if = sys.argv[1]

max_cpu = cpu_count()

# load BPF program
b = BPF(text = """
#include <uapi/linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>

BPF_CPUMAP(cpumap, __MAX_CPU__);
BPF_ARRAY(dest, uint32_t, 1);
BPF_PERCPU_ARRAY(rxcnt, long, 1);

int xdp_redirect_cpu_lb(struct xdp_md *ctx) {
    void* data_end = (void*)(long)ctx->data_end;
    void* data = (void*)(long)ctx->data;
    struct ethhdr *eth = data;
    uint32_t key = 0;
    long *value;
    uint32_t *cpu;
    uint64_t nh_off;

    nh_off = sizeof(*eth);
    if (data + nh_off  > data_end)
        return XDP_DROP;

    cpu = dest.lookup(&key);
    if (!cpu)
        return XDP_PASS;

    value = rxcnt.lookup(&key);
    if (value)
        *value += 1;

    int cpu_index = *cpu;
    cpu_index = (cpu_index + 1) % __MAX_CPU__;
    *cpu = cpu_index;

    return cpumap.redirect_map(cpu_index, 0);
}
""", cflags=["-w", "-D__MAX_CPU__=%u" % max_cpu], debug=0)

dest = b.get_table("dest")
dest[0] = ct.c_uint32(0)  # 初始CPU索引为0

cpumap = b.get_table("cpumap")
for cpu_id in range(max_cpu):
    cpumap[cpu_id] = ct.c_uint32(192)  # 将所有CPU映射到相同的目标

in_fn = b.load_func("xdp_redirect_cpu_lb", BPF.XDP)
b.attach_xdp(in_if, in_fn, flags)

rxcnt = b.get_table("rxcnt")
prev = 0
print("Printing redirected packets, hit CTRL+C to stop")
while 1:
    try:
        val = rxcnt.sum(0).value
        if val:
            delta = val - prev
            prev = val
            print("{} pkt/s".format(delta))
        time.sleep(1)
    except KeyboardInterrupt:
        print("Removing filter from device")
        break

b.remove_xdp(in_if, flags)
