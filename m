Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 586F825B993
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 06:19:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCEFD4B2AE;
	Thu,  3 Sep 2020 00:19:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y5ATfLPfxuAu; Thu,  3 Sep 2020 00:19:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 919C44B32B;
	Thu,  3 Sep 2020 00:19:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 25BA94B2AE
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 00:19:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rN3OlI3ufVKL for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 00:19:21 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E9704B23F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 00:19:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599106761;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=584XaVrGi+xJM1XGEDcqtq3l41TaAqFE0T9kaltxvvA=;
 b=UfQGsIQI4/jh50vPsLkTD+QWaJqHOd0ZIhn/QDVpXiOlOAA3PQkFqV5+foPzc+eQku6qJo
 oFwfDtDE0H8Ctkzrbq2FKaWzQWsRQVBvhUsknciQ/M5wYQm+xNoGq7U0NhpiYRo0+u/mpP
 QMNLqZ1u42SsAcM0/nK5oia84LLooLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-EZT8GpPAOrWcBqpcSylj_Q-1; Thu, 03 Sep 2020 00:19:17 -0400
X-MC-Unique: EZT8GpPAOrWcBqpcSylj_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90843107464E;
 Thu,  3 Sep 2020 04:19:15 +0000 (UTC)
Received: from [10.64.54.159] (vpn2-54-159.bne.redhat.com [10.64.54.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7810F5C1C4;
 Thu,  3 Sep 2020 04:19:12 +0000 (UTC)
Subject: Re: [PATCH v3 09/21] KVM: arm64: Convert unmap_stage2_range() to
 generic page-table API
To: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200825093953.26493-1-will@kernel.org>
 <20200825093953.26493-10-will@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <e418d30a-3648-5e60-ea55-0017f61c40b3@redhat.com>
Date: Thu, 3 Sep 2020 14:19:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200825093953.26493-10-will@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Will,

On 8/25/20 7:39 PM, Will Deacon wrote:
> Convert unmap_stage2_range() to use kvm_pgtable_stage2_unmap() instead
> of walking the page-table directly.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/kvm/mmu.c | 57 +++++++++++++++++++++++++-------------------
>   1 file changed, 32 insertions(+), 25 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 704b471a48ce..751ce2462765 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -39,6 +39,33 @@ static bool is_iomap(unsigned long flags)
>   	return flags & KVM_S2PTE_FLAG_IS_IOMAP;
>   }
>   
> +/*
> + * Release kvm_mmu_lock periodically if the memory region is large. Otherwise,
> + * we may see kernel panics with CONFIG_DETECT_HUNG_TASK,
> + * CONFIG_LOCKUP_DETECTOR, CONFIG_LOCKDEP. Additionally, holding the lock too
> + * long will also starve other vCPUs. We have to also make sure that the page
> + * tables are not freed while we released the lock.
> + */
> +#define stage2_apply_range(kvm, addr, end, fn, resched)			\
> +({									\
> +	int ret;							\
> +	struct kvm *__kvm = (kvm);					\
> +	bool __resched = (resched);					\
> +	u64 next, __addr = (addr), __end = (end);			\
> +	do {								\
> +		struct kvm_pgtable *pgt = __kvm->arch.mmu.pgt;		\
> +		if (!pgt)						\
> +			break;						\
> +		next = stage2_pgd_addr_end(__kvm, __addr, __end);	\
> +		ret = fn(pgt, __addr, next - __addr);			\
> +		if (ret)						\
> +			break;						\
> +		if (__resched && next != __end)				\
> +			cond_resched_lock(&__kvm->mmu_lock);		\
> +	} while (__addr = next, __addr != __end);			\
> +	ret;								\
> +})
> +
>   static bool memslot_is_logging(struct kvm_memory_slot *memslot)
>   {
>   	return memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
> @@ -220,8 +247,8 @@ static inline void kvm_pgd_populate(pgd_t *pgdp, p4d_t *p4dp)
>    * end up writing old data to disk.
>    *
>    * This is why right after unmapping a page/section and invalidating
> - * the corresponding TLBs, we call kvm_flush_dcache_p*() to make sure
> - * the IO subsystem will never hit in the cache.
> + * the corresponding TLBs, we flush to make sure the IO subsystem will
> + * never hit in the cache.
>    *
>    * This is all avoided on systems that have ARM64_HAS_STAGE2_FWB, as
>    * we then fully enforce cacheability of RAM, no matter what the guest
> @@ -344,32 +371,12 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
>   				 bool may_block)
>   {
>   	struct kvm *kvm = mmu->kvm;
> -	pgd_t *pgd;
> -	phys_addr_t addr = start, end = start + size;
> -	phys_addr_t next;
> +	phys_addr_t end = start + size;
>   
>   	assert_spin_locked(&kvm->mmu_lock);
>   	WARN_ON(size & ~PAGE_MASK);
> -
> -	pgd = mmu->pgd + stage2_pgd_index(kvm, addr);
> -	do {
> -		/*
> -		 * Make sure the page table is still active, as another thread
> -		 * could have possibly freed the page table, while we released
> -		 * the lock.
> -		 */
> -		if (!READ_ONCE(mmu->pgd))
> -			break;
> -		next = stage2_pgd_addr_end(kvm, addr, end);
> -		if (!stage2_pgd_none(kvm, *pgd))
> -			unmap_stage2_p4ds(mmu, pgd, addr, next);
> -		/*
> -		 * If the range is too large, release the kvm->mmu_lock
> -		 * to prevent starvation and lockup detector warnings.
> -		 */
> -		if (may_block && next != end)
> -			cond_resched_lock(&kvm->mmu_lock);
> -	} while (pgd++, addr = next, addr != end);
> +	WARN_ON(stage2_apply_range(kvm, start, end, kvm_pgtable_stage2_unmap,
> +				   may_block));
>   }
>   
>   static void unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64 size)
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
