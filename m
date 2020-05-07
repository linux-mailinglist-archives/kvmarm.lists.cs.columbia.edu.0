Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8B1C8762
	for <lists+kvmarm@lfdr.de>; Thu,  7 May 2020 12:56:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E95D34B2B9;
	Thu,  7 May 2020 06:56:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Of4wz2Xa2JhG; Thu,  7 May 2020 06:56:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB79B4B2A9;
	Thu,  7 May 2020 06:56:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 164F94B2A4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 06:56:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id soHK2WmvAtJU for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 06:56:32 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5C874B2A2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 06:56:32 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7ED1FB;
 Thu,  7 May 2020 03:56:32 -0700 (PDT)
Received: from [10.37.12.117] (unknown [10.37.12.117])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C723F68F;
 Thu,  7 May 2020 03:56:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: release kvm->mmu_lock in loop to prevent
 starvation
To: giangyi@amazon.com, maz@kernel.org
References: <20200415084229.29992-1-giangyi@amazon.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0e448ae0-af4c-3f0a-2dd5-6ab86c0d60c0@arm.com>
Date: Thu, 7 May 2020 12:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415084229.29992-1-giangyi@amazon.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

On 04/15/2020 09:42 AM, Jiang Yi wrote:
> Do cond_resched_lock() in stage2_flush_memslot() like what is done in
> unmap_stage2_range() and other places holding mmu_lock while processing
> a possibly large range of memory.
> 
> Signed-off-by: Jiang Yi <giangyi@amazon.com>
> ---
>   virt/kvm/arm/mmu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e3b9ee268823..7315af2c52f8 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -417,16 +417,19 @@ static void stage2_flush_memslot(struct kvm *kvm,
>   	phys_addr_t next;
>   	pgd_t *pgd;
>   
>   	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>   	do {
>   		next = stage2_pgd_addr_end(kvm, addr, end);
>   		if (!stage2_pgd_none(kvm, *pgd))
>   			stage2_flush_puds(kvm, pgd, addr, next);
> +
> +		if (next != end)
> +			cond_resched_lock(&kvm->mmu_lock);
>   	} while (pgd++, addr = next, addr != end);
>   }

Given that this is called under the srcu_lock this looks
good to me:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>   
>   /**
>    * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
>    * @kvm: The struct kvm pointer
>    *
>    * Go through the stage 2 page tables and invalidate any cache lines
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
