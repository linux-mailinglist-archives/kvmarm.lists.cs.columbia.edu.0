Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9E39877C
	for <lists+kvmarm@lfdr.de>; Wed,  2 Jun 2021 12:58:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56B5549F92;
	Wed,  2 Jun 2021 06:58:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5yVOWME-ZFk; Wed,  2 Jun 2021 06:58:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 169494075E;
	Wed,  2 Jun 2021 06:58:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B1EC14019D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 06:58:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3U2uq8E3tB0H for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Jun 2021 06:58:32 -0400 (EDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9562D40152
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 06:58:32 -0400 (EDT)
Received: by mail-wr1-f49.google.com with SMTP id z17so1828974wrq.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Jun 2021 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=O4j3rnMAVVtQuafSexYtSyjSly5WDUnGVtpX8LTwkWk=;
 b=d9OMAA5JQL8jC8IxP/OtQ63ClDX5Ld+AUFGF/BIOaD/SPONLkodo+0jo+RoR5mTEoG
 PgEtpTeFjZuBJL9c8NqbqT4O2UEaEcx8ML3eRmuh0UsgOU9zhHUnaTUwSksBRv50EFc4
 /5c1l39b3D/IhKxRwmtDrUarmu7vHmsK2uTIYSofXXK4E/7OAeHrYCBLWmlw0NiySvuD
 8OQG/6n06I2QQCQrFJvnYGrFmG3Xm6Oa5OvJSwdktqi9f0XB5AWk5Z8d943IYaK4XrOZ
 NIJ+adU/E5fxPEDKhHTWUPvO89BHwHgJ1hxssujS/JX1wQNwa0PwvOnQC6krwwxh+nWU
 q3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O4j3rnMAVVtQuafSexYtSyjSly5WDUnGVtpX8LTwkWk=;
 b=AHHjG1PsgWGgyU4L8QARzVfGQgyyOiTJ/WEJtQkIw8dgIfbzeerN0B7Z0K/7DfoRV3
 OqHS3V626XqS9c7EZCeA9hl8D+YwfsTK13d4PbSjKEw2k1+f/QFfRKUiyU29TnHMv2yy
 zcJwOAdOpohod9oQ3m77JwByXDqYGp+7x5yFNXWGTKKXaXw50tWVK0Vr4AKj0aBGv/hs
 h/nsehCVO/qG4Mb3uYxz5Zgp7c6Zj2fA/oTDU1I8umlfUA+Ai6eKVzFIZDS7EUr3tyS2
 N051EUhqY09yC/NOj3gXJBQwmuh6Wlqz32lquMbNptpPlI84oqRi4bimm2Nf7DHgpFAu
 GOgQ==
X-Gm-Message-State: AOAM532Gqi+TKsng1tL8pJMssqjYA8po3u0QfescG77f5JKfXDfg2WKm
 q/6jfDKc8+vsWQ1sq5n1ILnguA==
X-Google-Smtp-Source: ABdhPJxQ4Mw6GmqjL/VfVeU2WxB50DVhQpumz9XVUbL+idgnhTuIw21b4d+fUny6pxwYk9C9Mijxyw==
X-Received: by 2002:adf:f346:: with SMTP id e6mr5572912wrp.179.1622631511395; 
 Wed, 02 Jun 2021 03:58:31 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com.
 [35.195.168.105])
 by smtp.gmail.com with ESMTPSA id p20sm2282579wmq.10.2021.06.02.03.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 03:58:30 -0700 (PDT)
Date: Wed, 2 Jun 2021 10:58:28 +0000
From: Quentin Perret <qperret@google.com>
To: Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 5/6] KVM: arm64: Move I-cache flush to the fault
 handlers
Message-ID: <YLdkVH0G2Lq9vPc5@google.com>
References: <20210415115032.35760-1-wangyanan55@huawei.com>
 <20210415115032.35760-6-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415115032.35760-6-wangyanan55@huawei.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
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

On Thursday 15 Apr 2021 at 19:50:31 (+0800), Yanan Wang wrote:
> In this patch, we move invalidation of I-cache to the fault handlers to

Nit: please avoid using 'This patch' in commit messages, see
Documentation/process/submitting-patches.rst.

> avoid unnecessary I-cache maintenances. On the map path, invalidate the
> I-cache if we are going to create an executable stage-2 mapping for guest.
> And on the permission path, invalidate the I-cache if we are going to add
> an executable permission to the existing guest stage-2 mapping.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 15 --------------
>  arch/arm64/kvm/hyp/pgtable.c     | 35 +++++++++++++++++++++++++++++++-
>  arch/arm64/kvm/mmu.c             |  9 +-------
>  3 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index e9b163c5f023..155492fe5b15 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -187,21 +187,6 @@ static inline bool vcpu_has_cache_enabled(struct kvm_vcpu *vcpu)
>  	return (vcpu_read_sys_reg(vcpu, SCTLR_EL1) & 0b101) == 0b101;
>  }
>  
> -static inline void __invalidate_icache_guest_page(kvm_pfn_t pfn,
> -						  unsigned long size)
> -{
> -	if (icache_is_aliasing()) {
> -		/* any kind of VIPT cache */
> -		__flush_icache_all();
> -	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {
> -		/* PIPT or VPIPT at EL2 (see comment in __kvm_tlb_flush_vmid_ipa) */
> -		void *va = page_address(pfn_to_page(pfn));
> -
> -		invalidate_icache_range((unsigned long)va,
> -					(unsigned long)va + size);
> -	}
> -}
> -
>  void kvm_set_way_flush(struct kvm_vcpu *vcpu);
>  void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>  
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index b480f6d1171e..9f4429d80df0 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -568,6 +568,26 @@ static bool stage2_pte_cacheable(struct kvm_pgtable *pgt, kvm_pte_t pte)
>  	return memattr == KVM_S2_MEMATTR(pgt, NORMAL);
>  }
>  
> +static bool stage2_pte_executable(kvm_pte_t pte)
> +{
> +	return !(pte & KVM_PTE_LEAF_ATTR_HI_S2_XN);
> +}
> +
> +static void stage2_invalidate_icache(void *addr, u64 size)
> +{
> +	if (icache_is_aliasing()) {
> +		/* Any kind of VIPT cache */
> +		__flush_icache_all();
> +	} else if (is_kernel_in_hyp_mode() || !icache_is_vpipt()) {


> +		/*
> +		 * See comment in __kvm_tlb_flush_vmid_ipa().
> +		 * Invalidate PIPT, or VPIPT at EL2.
> +		 */
> +		invalidate_icache_range((unsigned long)addr,
> +					(unsigned long)addr + size);
> +	}
> +}
> +
>  static void stage2_put_pte(kvm_pte_t *ptep, struct kvm_s2_mmu *mmu, u64 addr,
>  			   u32 level, struct kvm_pgtable_mm_ops *mm_ops)
>  {
> @@ -618,6 +638,10 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  		if (stage2_pte_cacheable(pgt, new) && !stage2_has_fwb(pgt))
>  			__flush_dcache_area(mm_ops->phys_to_virt(phys),
>  					    granule);
> +
> +		if (stage2_pte_executable(new))
> +			stage2_invalidate_icache(mm_ops->phys_to_virt(phys),
> +						 granule);
>  	}
>  
>  	smp_store_release(ptep, new);
> @@ -896,8 +920,17 @@ static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  	 * but worst-case the access flag update gets lost and will be
>  	 * set on the next access instead.
>  	 */
> -	if (data->pte != pte)
> +	if (data->pte != pte) {
> +		/*
> +		 * Invalidate the instruction cache before updating
> +		 * if we are going to add the executable permission
> +		 * for the guest stage-2 PTE.
> +		 */
> +		if (!stage2_pte_executable(*ptep) && stage2_pte_executable(pte))
> +			stage2_invalidate_icache(kvm_pte_follow(pte, data->mm_ops),
> +						 kvm_granule_size(level));
>  		WRITE_ONCE(*ptep, pte);
> +	}

As for the dcache stuff, it seems like this would be best placed in an
optional mm_ops callback, and have the kernel implement it.

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
