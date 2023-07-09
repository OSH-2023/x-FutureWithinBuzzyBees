/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include "../headers/bpf_helpers.h"

SEC("xdp")
int  xdp_prog(struct xdp_md *ctx)
{
	return XDP_PASS;
}
