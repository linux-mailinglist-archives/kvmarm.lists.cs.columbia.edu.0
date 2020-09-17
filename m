Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD026D76B
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 11:13:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D33B04B7A6;
	Thu, 17 Sep 2020 05:13:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MkpbVQdYeRnl; Thu, 17 Sep 2020 05:13:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF08C4B78E;
	Thu, 17 Sep 2020 05:13:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D21F14B777
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 05:13:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gk4sc92h7dge for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Sep 2020 05:13:19 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ACE534B724
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 05:13:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD6B101E;
 Thu, 17 Sep 2020 02:13:19 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 536663F718;
 Thu, 17 Sep 2020 02:13:18 -0700 (PDT)
Subject: Re: [PATCH] arm64: paravirt: Initialize steal time when cpu is online
To: Andrew Jones <drjones@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20200916154530.40809-1-drjones@redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <fec66297-cda2-4c94-9d51-71340719c594@arm.com>
Date: Thu, 17 Sep 2020 10:13:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916154530.40809-1-drjones@redhat.com>
Content-Language: en-GB
Cc: maz@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 16/09/2020 16:45, Andrew Jones wrote:
> Steal time initialization requires mapping a memory region which
> invokes a memory allocation. Doing this at CPU starting time results
> in the following trace when CONFIG_DEBUG_ATOMIC_SLEEP is enabled:
> 
> BUG: sleeping function called from invalid context at mm/slab.h:498
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #1
> Call trace:
>   dump_backtrace+0x0/0x208
>   show_stack+0x1c/0x28
>   dump_stack+0xc4/0x11c
>   ___might_sleep+0xf8/0x130
>   __might_sleep+0x58/0x90
>   slab_pre_alloc_hook.constprop.101+0xd0/0x118
>   kmem_cache_alloc_node_trace+0x84/0x270
>   __get_vm_area_node+0x88/0x210
>   get_vm_area_caller+0x38/0x40
>   __ioremap_caller+0x70/0xf8
>   ioremap_cache+0x78/0xb0
>   memremap+0x9c/0x1a8
>   init_stolen_time_cpu+0x54/0xf0
>   cpuhp_invoke_callback+0xa8/0x720
>   notify_cpu_starting+0xc8/0xd8
>   secondary_start_kernel+0x114/0x180
> CPU1: Booted secondary processor 0x0000000001 [0x431f0a11]
> 
> However we don't need to initialize steal time at CPU starting time.
> We can simply wait until CPU online time, just sacrificing a bit of
> accuracy by returning zero for steal time until we know better.
> 
> While at it, add __init to the functions that are only called by
> pv_time_init() which is __init.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

The changes look good to me - it simplifies things delaying the startup 
of stolen time and I doubt anyone will notice the accuracy loss.

Reviewed-by: Steven Price <steven.price@arm.com>

Do we need a CC: stable (or Fixes:)?

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
