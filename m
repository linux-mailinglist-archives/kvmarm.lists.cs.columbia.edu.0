Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B603F2614C3
	for <lists+kvmarm@lfdr.de>; Tue,  8 Sep 2020 18:36:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36DC44B28F;
	Tue,  8 Sep 2020 12:36:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u61HOMG0DQ83; Tue,  8 Sep 2020 12:36:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E014C4B1DA;
	Tue,  8 Sep 2020 12:36:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1206F4B139
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 12:36:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnx2IIQuiLis for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 12:36:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95F9F4B119
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 12:36:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06F9D31B;
 Tue,  8 Sep 2020 09:36:22 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB243F68F;
 Tue,  8 Sep 2020 09:36:20 -0700 (PDT)
Subject: Re: [PATCH v4 16/21] KVM: arm64: Add support for relaxing stage-2
 perms in generic page-table code
To: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-17-will@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <8f4ac895-361a-77f0-e68d-fc3b62cab385@arm.com>
Date: Tue, 8 Sep 2020 17:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907152344.12978-17-will@kernel.org>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

Hi Will,

Minor nitpick below.

On 9/7/20 4:23 PM, Will Deacon wrote:
> Add support for relaxing the permissions of a stage-2 mapping (i.e.
> adding additional permissions) to the generic page-table code.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 17 +++++++++++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index a776bcf74316..5ab4f852a463 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -218,6 +218,23 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
>   */
>  kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
>  
> +/**
> + * kvm_pgtable_stage2_relax_perms() - Relax the permissions enforced by a
> + *				      page-table entry.
> + * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
> + * @addr:	Intermediate physical address to identify the page-table entry.
> + * @prot:	Additional permissions to grant for the mapping.
> + *
> + * If there is a valid, leaf page-table entry used to translate @addr, then
> + * relax the permissions in that entry according to the read, write and
> + * execute permissions specified by @prot. No permissions are removed, and
> + * TLB invalidation is performed after updating the entry.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
> +				   enum kvm_pgtable_prot prot);
> +
>  /**
>   * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
>   *				   access flag set.
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index ad18ce469041..df705533dc3f 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -782,6 +782,26 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
>  	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
>  }
>  
> +int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
> +				   enum kvm_pgtable_prot prot)
> +{
> +	int ret;
> +	kvm_pte_t set = 0, clr = 0;
> +
> +	if (prot & KVM_PGTABLE_PROT_R)
> +		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
> +
> +	if (prot & KVM_PGTABLE_PROT_W)
> +		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W;
> +
> +	if (prot & KVM_PGTABLE_PROT_X)
> +		clr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
> +
> +	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL);
> +	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, pgt->mmu, addr, 0);

The level 0 argument could be replaced by S2_NO_LEVEL_HINT, which is self
explanatory. However, that means the file needs to include stage2_pgtable.h.

Thanks,
Alex
> +	return ret;
> +}
> +
>  static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  			       enum kvm_pgtable_walk_flags flag,
>  			       void * const arg)
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
