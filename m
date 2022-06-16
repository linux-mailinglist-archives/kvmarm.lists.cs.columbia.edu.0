Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB42454E8E5
	for <lists+kvmarm@lfdr.de>; Thu, 16 Jun 2022 19:51:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F22854B0B4;
	Thu, 16 Jun 2022 13:51:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X5-mhEvbaZdT; Thu, 16 Jun 2022 13:51:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9667240C1F;
	Thu, 16 Jun 2022 13:51:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2236E40B75
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jun 2022 13:51:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RRA95tdMcPO for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Jun 2022 13:51:09 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D1A9C408A7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jun 2022 13:51:09 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AA78761B76;
 Thu, 16 Jun 2022 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684AC34114;
 Thu, 16 Jun 2022 17:51:05 +0000 (UTC)
Date: Thu, 16 Jun 2022 18:51:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Message-ID: <YqtthvVxgQ6K0nEt@arm.com>
References: <20220616161135.3997786-1-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616161135.3997786-1-qperret@google.com>
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Jun 16, 2022 at 04:11:34PM +0000, Quentin Perret wrote:
> Commit a7259df76702 ("memblock: make memblock_find_in_range method
> private") changed the API using which memory is reserved for the pKVM
> hypervisor. However, it seems that memblock_phys_alloc() differs
> from the original API in terms of kmemleak semantics -- the old one
> excluded the reserved regions from kmemleak scans when the new one
> doesn't seem to. Unfortunately, when protected KVM is enabled, all
> kernel accesses to pKVM-private memory result in a fatal exception,
> which can now happen because of kmemleak scans:
> 
> $ echo scan > /sys/kernel/debug/kmemleak
> [   34.991354] kvm [304]: nVHE hyp BUG at: [<ffff800008fa3750>] __kvm_nvhe_handle_host_mem_abort+0x270/0x290!
> [   34.991580] kvm [304]: Hyp Offset: 0xfffe8be807e00000
> [   34.991813] Kernel panic - not syncing: HYP panic:
> [   34.991813] PS:600003c9 PC:0000f418011a3750 ESR:00000000f2000800
> [   34.991813] FAR:ffff000439200000 HPFAR:0000000004792000 PAR:0000000000000000
> [   34.991813] VCPU:0000000000000000
> [   34.993660] CPU: 0 PID: 304 Comm: bash Not tainted 5.19.0-rc2 #102
> [   34.994059] Hardware name: linux,dummy-virt (DT)
> [   34.994452] Call trace:
> [   34.994641]  dump_backtrace.part.0+0xcc/0xe0
> [   34.994932]  show_stack+0x18/0x6c
> [   34.995094]  dump_stack_lvl+0x68/0x84
> [   34.995276]  dump_stack+0x18/0x34
> [   34.995484]  panic+0x16c/0x354
> [   34.995673]  __hyp_pgtable_total_pages+0x0/0x60
> [   34.995933]  scan_block+0x74/0x12c
> [   34.996129]  scan_gray_list+0xd8/0x19c
> [   34.996332]  kmemleak_scan+0x2c8/0x580
> [   34.996535]  kmemleak_write+0x340/0x4a0
> [   34.996744]  full_proxy_write+0x60/0xbc
> [   34.996967]  vfs_write+0xc4/0x2b0
> [   34.997136]  ksys_write+0x68/0xf4
> [   34.997311]  __arm64_sys_write+0x20/0x2c
> [   34.997532]  invoke_syscall+0x48/0x114
> [   34.997779]  el0_svc_common.constprop.0+0x44/0xec
> [   34.998029]  do_el0_svc+0x2c/0xc0
> [   34.998205]  el0_svc+0x2c/0x84
> [   34.998421]  el0t_64_sync_handler+0xf4/0x100
> [   34.998653]  el0t_64_sync+0x18c/0x190
> [   34.999252] SMP: stopping secondary CPUs
> [   35.000034] Kernel Offset: disabled
> [   35.000261] CPU features: 0x800,00007831,00001086
> [   35.000642] Memory Limit: none
> [   35.001329] ---[ end Kernel panic - not syncing: HYP panic:
> [   35.001329] PS:600003c9 PC:0000f418011a3750 ESR:00000000f2000800
> [   35.001329] FAR:ffff000439200000 HPFAR:0000000004792000 PAR:0000000000000000
> [   35.001329] VCPU:0000000000000000 ]---
> 
> Fix this by explicitly excluding the hypervisor's memory pool from
> kmemleak like we already do for the hyp BSS.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> An alternative could be to actually exclude memory allocated using
> memblock_phys_alloc_range() from kmemleak scans to revert back to the
> old behaviour. But nobody else has complained about this AFAIK, so I'd
> be inclined to keep this local to pKVM. No strong opinion.

This works for me, I haven't heard anyone else complaining.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
