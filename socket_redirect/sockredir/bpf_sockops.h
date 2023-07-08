#include <swab.h>

#ifndef __section
#define __section(NAME) 	\
	__attribute__((section(NAME), used))
#endif

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
# define __bpf_ntohl(x)                 __builtin_bswap32(x)
# define __bpf_htonl(x)                 __builtin_bswap32(x)
# define __bpf_constant_ntohl(x)        ___constant_swab32(x)
# define __bpf_constant_htonl(x)        ___constant_swab32(x)
#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
# define __bpf_ntohl(x)                 (x)
# define __bpf_htonl(x)                 (x)
# define __bpf_constant_ntohl(x)        (x)
# define __bpf_constant_htonl(x)        (x)
#else
# error "Check the compiler's endian detection."
#endif

#define bpf_htonl(x)                            \
        (__builtin_constant_p(x) ?              \
         __bpf_constant_htonl(x) : __bpf_htonl(x))
#define bpf_ntohl(x)                            \
        (__builtin_constant_p(x) ?              \
         __bpf_constant_ntohl(x) : __bpf_ntohl(x))

#ifndef FORCE_READ
#define FORCE_READ(X) (*(volatile typeof(X)*)&X)
#endif

#ifndef BPF_FUNC
#define BPF_FUNC(NAME, ...) 	\
	(*NAME)(__VA_ARGS__) = (void *) BPF_FUNC_##NAME
#endif

#ifndef printk
# define printk(fmt, ...)                                      \
    ({                                                         \
        char ____fmt[] = fmt;                                  \
        trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__); \
    })
#endif


/* 主要使用到的ebpf helper 函数
 * The generated function is used for parameter verification by the eBPF verifier
 */
static int BPF_FUNC(msg_redirect_hash, struct sk_msg_md *md,
			void *map, void *key, uint64_t flag);
static int BPF_FUNC(sock_hash_update, struct bpf_sock_ops *skops,
			void *map, void *key, uint64_t flags);
static void BPF_FUNC(trace_printk, const char *fmt, int fmt_size, ...);

/*
 * Map definition
 */
struct bpf_map_def {
	uint32_t type;
	uint32_t key_size;
	uint32_t value_size;
	uint32_t max_entries;
	uint32_t map_flags;
};

struct sock_key {
	uint32_t sip4;      //源ip
	uint32_t dip4;      //目标ip
	uint8_t  family;    //协议族
	uint8_t  pad1;
	uint16_t pad2;
	// this padding required for 64bit alignment
	// else ebpf kernel verifier rejects loading
	// of the program
	uint32_t pad3;
	uint32_t sport;   //源端口
	uint32_t dport;    //目标端口
} __attribute__((packed));


struct bpf_map_def __section("maps") sock_ops_map = {    //映射区定义
	.type           = BPF_MAP_TYPE_SOCKHASH,             //哈希映射类型
	.key_size       = sizeof(struct sock_key),   
	.value_size     = sizeof(int),              
	.max_entries    = 65535,
	.map_flags      = 0,
};
