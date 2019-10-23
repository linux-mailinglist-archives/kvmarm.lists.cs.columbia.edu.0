Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1CE1A55
	for <lists+kvmarm@lfdr.de>; Wed, 23 Oct 2019 14:32:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB5F64A618;
	Wed, 23 Oct 2019 08:32:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 1.592
X-Spam-Level: *
X-Spam-Status: No, score=1.592 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RDNS_NONE=0.793] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I5CMueIXKeea; Wed, 23 Oct 2019 08:32:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0D5C4A963;
	Wed, 23 Oct 2019 08:32:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8467A4A902
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Oct 2019 08:32:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 791gOtp0moof for <kvmarm@lists.cs.columbia.edu>;
 Wed, 23 Oct 2019 08:32:38 -0400 (EDT)
Received: from foss.arm.com (unknown [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5165A4A618
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Oct 2019 08:32:38 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC3BC497;
 Wed, 23 Oct 2019 05:32:17 -0700 (PDT)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CC263F6C4;
 Wed, 23 Oct 2019 05:32:16 -0700 (PDT)
Date: Wed, 23 Oct 2019 13:32:10 +0100
From: Steven Price <steven.price@arm.com>
To: Mao Wenan <maowenan@huawei.com>
Subject: Re: [PATCH] KVM: arm64: Select SCHED_INFO before SCHEDSTATS
Message-ID: <20191023123210.GA40238@arm.com>
References: <20191023032254.159510-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191023032254.159510-1-maowenan@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "maz@kernel.org" <maz@kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On Wed, Oct 23, 2019 at 04:22:54AM +0100, Mao Wenan wrote:
> If KVM=y, it will select SCHEDSTATS, below erros can
> be seen:
> kernel/sched/stats.h: In function rq_sched_info_arrive:
> kernel/sched/stats.h:12:20: error: struct sched_info
> has no member named run_delay
>    rq->rq_sched_info.run_delay += delta;
>                     ^
> kernel/sched/stats.h:13:20: error: struct sched_info
> has no member named pcount
>    rq->rq_sched_info.pcount++;
>                     ^
> kernel/sched/stats.h: In function rq_sched_info_dequeued:
> kernel/sched/stats.h:31:20: error: struct sched_info has
> no member named run_delay
>    rq->rq_sched_info.run_delay += delta;
> 
> These are because CONFIG_SCHED_INFO is not set, This patch 
> is to select SCHED_INFO before SCHEDSTATS.

It looks like I didn't spot this because when DEBUG_KERNEL is enabled
then KVM selects SCHEDSTATS, which selects SCHED_INFO. Thanks for
spotting this.

> 
> Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  arch/arm64/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index d8b88e4..3c46eac 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -39,6 +39,7 @@ config KVM
>  	select IRQ_BYPASS_MANAGER
>  	select HAVE_KVM_IRQ_BYPASS
>  	select HAVE_KVM_VCPU_RUN_PID_CHANGE
> +	select SCHED_INFO
>  	select SCHEDSTATS
>  	---help---
>  	  Support hosting virtualized guest machines.
> -- 
> 2.7.4
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
