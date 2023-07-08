#include <uapi/linux/bpf.h>

#include "bpf_sockops.h"


/* extract the key that identifies the destination socket in the sock_ops_map */
static inline
void sk_msg_extract4_key(struct sk_msg_md *msg,
	struct sock_key *key)
{
	key->sip4 = msg->remote_ip4;
	key->dip4 = msg->local_ip4;
	key->family = 1;

	key->dport = (bpf_htonl(msg->local_port) >> 16);
	key->sport = FORCE_READ(msg->remote_port) >> 16;
}

__section("sk_msg")          //hook点：拦截socket的所有sendmsg 系统调用
int bpf_tcpip_bypass(struct sk_msg_md *msg)
{
    struct  sock_key key = {};
    sk_msg_extract4_key(msg, &key);    //从msg中提取key
    msg_redirect_hash(msg, &sock_ops_map, &key, BPF_F_INGRESS);  //在映射表中根据 key查询socket的对端，然后绕过 TCP/IP 协议栈，直接将数据重定向到对端socket的某个 queue
    return SK_PASS;
}

char ____license[] __section("license") = "GPL";
