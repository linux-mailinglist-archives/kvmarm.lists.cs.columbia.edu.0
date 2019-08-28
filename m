Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 18C42A0566
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 16:55:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 983264A3A3;
	Wed, 28 Aug 2019 10:55:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGQ1qoOFd816; Wed, 28 Aug 2019 10:55:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D1B24A551;
	Wed, 28 Aug 2019 10:55:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 834794A533
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 10:55:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uykpLXiu8o-F for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 10:55:31 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 857784A3A3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 10:55:31 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD05218C426B;
 Wed, 28 Aug 2019 14:55:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02ABB600CD;
 Wed, 28 Aug 2019 14:55:28 +0000 (UTC)
Date: Wed, 28 Aug 2019 16:55:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests RFC PATCH 08/16] lib: arm/arm64: Refuse to
 disable the MMU with non-identity stack pointer
Message-ID: <20190828145526.g6xlotkhial5tv57@kamzik.brq.redhat.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
 <1566999511-24916-9-git-send-email-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566999511-24916-9-git-send-email-alexandru.elisei@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 28 Aug 2019 14:55:30 +0000 (UTC)
Cc: kvm@vger.kernel.org, maz@kernel.org, andre.przywara@arm.com,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Aug 28, 2019 at 02:38:23PM +0100, Alexandru Elisei wrote:
> When the MMU is off, all addresses are physical addresses. If the stack
> pointer is not an identity mapped address (the virtual address is not the
> same as the physical address), then we end up trying to access an invalid
> memory region. This can happen if we call mmu_disable from a secondary CPU,
> which has its stack allocated from the vmalloc region.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  lib/arm/mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/arm/mmu.c b/lib/arm/mmu.c
> index 3d38c8397f5a..161f7a8e607c 100644
> --- a/lib/arm/mmu.c
> +++ b/lib/arm/mmu.c
> @@ -66,8 +66,12 @@ void mmu_enable(pgd_t *pgtable)
>  extern void asm_mmu_disable(void);
>  void mmu_disable(void)
>  {
> +	unsigned long sp = current_stack_pointer;
>  	int cpu = current_thread_info()->cpu;
>  
> +	assert_msg(__virt_to_phys(sp) == sp,
> +			"Attempting to disable MMU with non-identity mapped stack");
> +
>  	mmu_mark_disabled(cpu);
>  
>  	asm_mmu_disable();
> -- 
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
