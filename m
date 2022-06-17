Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AD54F2AE
	for <lists+kvmarm@lfdr.de>; Fri, 17 Jun 2022 10:20:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B7564B28C;
	Fri, 17 Jun 2022 04:20:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qaj7a5Q1Xgan; Fri, 17 Jun 2022 04:20:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B96184B28B;
	Fri, 17 Jun 2022 04:20:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CC2B49F0C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 04:20:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fd0tBaWMO0id for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 04:20:02 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0561B499F2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 04:20:01 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 83470B827A5;
 Fri, 17 Jun 2022 08:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FCCC3411B;
 Fri, 17 Jun 2022 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655453999;
 bh=E98ek2nAdjr2+1dOqswVNwmAjmNqZLUSnkA74Yi2Hdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IoAJ8yqUpL4PW8mFre9W/ARVGh+cjwFG7I4N+Uqj4se+L/2W7RuLg82tkg4wVAoW+
 EBPh9scg7wsMU0oGmwRBhqfFYxY0vsvP7+9YYecRMEre/4n1r8DTPuEQXT5mym/nbM
 SHCCOftaMBhC322Lft5RkiqBwdJYswmp0hZrcW298eqjzGMcMe79W1o2qfkq/IkUDU
 HGQkiSic5QyQcRiXS7Y3U/boS13lyVLRhzEnaEL5cSyKdekE3tr6kCa0ZRCFdpkhXn
 imwS9iwiwUirlaqrznkZ0SIVMyz8+GLuW61qkY4LFIgZioH8e5jXS+EmH1zliiw9SX
 JvXkp9UJoVwnQ==
Date: Fri, 17 Jun 2022 11:19:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Message-ID: <Yqw5JRrUJO73mtIy@kernel.org>
References: <20220616161135.3997786-1-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616161135.3997786-1-qperret@google.com>
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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

I'd rather say that memblock_find_in_range() didn't inform kmemleak about
the reserved regions, while memblock_phys_alloc() does.

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
> old behaviour.

This would be wrong because memblock_phys_alloc() does allocate memory and
unless there is a good reason to exclude it from kmemleak.

> But nobody else has complained about this AFAIK, so I'd be inclined to
> keep this local to pKVM. No strong opinion.

Yes, please :)
An alternative to excluding this memory from kmemleak is to allocate it
using 

	memblock_phys_alloc_range(size, align, 0, MEMBLOCK_ALLOC_NOLEAKTRACE)

then it won't be added to kmemleak at the first place.

> ---
>  arch/arm64/kvm/arm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 400bb0fe2745..28765bd22efb 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2110,11 +2110,11 @@ static int finalize_hyp_mode(void)
>  		return 0;
>  
>  	/*
> -	 * Exclude HYP BSS from kmemleak so that it doesn't get peeked
> -	 * at, which would end badly once the section is inaccessible.
> -	 * None of other sections should ever be introspected.
> +	 * Exclude HYP sections from kmemleak so that they don't get peeked
> +	 * at, which would end badly once inaccessible.
>  	 */
>  	kmemleak_free_part(__hyp_bss_start, __hyp_bss_end - __hyp_bss_start);
> +	kmemleak_free_part(__va(hyp_mem_base), hyp_mem_size);
>  	return pkvm_drop_host_privileges();
>  }
>  
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
