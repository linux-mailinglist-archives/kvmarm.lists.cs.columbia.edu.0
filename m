Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB423B3022
	for <lists+kvmarm@lfdr.de>; Thu, 24 Jun 2021 15:35:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FA554B1D3;
	Thu, 24 Jun 2021 09:35:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjfPc8BHvBeQ; Thu, 24 Jun 2021 09:35:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4EA24B1DB;
	Thu, 24 Jun 2021 09:35:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ECC004B1D1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Jun 2021 09:35:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQwOwQAULRPA for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Jun 2021 09:35:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 42FF54B1AE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Jun 2021 09:35:36 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 12AF061002;
 Thu, 24 Jun 2021 13:35:35 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lwPW0-009bmk-MA; Thu, 24 Jun 2021 14:35:32 +0100
Date: Thu, 24 Jun 2021 14:35:32 +0100
Message-ID: <87k0mjidwb.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v17 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
In-Reply-To: <20210621111716.37157-6-steven.price@arm.com>
References: <20210621111716.37157-1-steven.price@arm.com>
 <20210621111716.37157-6-steven.price@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com,
 will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dave.Martin@arm.com, mark.rutland@arm.com, tglx@linutronix.de,
 qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Catalin Marinas <catalin.marinas@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Steven,

On Mon, 21 Jun 2021 12:17:15 +0100,
Steven Price <steven.price@arm.com> wrote:
> 
> The VMM may not wish to have it's own mapping of guest memory mapped
> with PROT_MTE because this causes problems if the VMM has tag checking
> enabled (the guest controls the tags in physical RAM and it's unlikely
> the tags are correct for the VMM).
> 
> Instead add a new ioctl which allows the VMM to easily read/write the
> tags from guest memory, allowing the VMM's mapping to be non-PROT_MTE
> while the VMM can still read/write the tags for the purpose of
> migration.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  3 ++
>  arch/arm64/include/asm/mte-def.h  |  1 +
>  arch/arm64/include/uapi/asm/kvm.h | 11 +++++
>  arch/arm64/kvm/arm.c              |  7 +++
>  arch/arm64/kvm/guest.c            | 82 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h          |  1 +
>  6 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 309e36cc1b42..6a2ac4636d42 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -729,6 +729,9 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
>  int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
>  
> +long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> +				struct kvm_arm_copy_mte_tags *copy_tags);
> +
>  /* Guest/host FPSIMD coordination helpers */
>  int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
>  void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
> index cf241b0f0a42..626d359b396e 100644
> --- a/arch/arm64/include/asm/mte-def.h
> +++ b/arch/arm64/include/asm/mte-def.h
> @@ -7,6 +7,7 @@
>  
>  #define MTE_GRANULE_SIZE	UL(16)
>  #define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> +#define MTE_GRANULES_PER_PAGE	(PAGE_SIZE / MTE_GRANULE_SIZE)
>  #define MTE_TAG_SHIFT		56
>  #define MTE_TAG_SIZE		4
>  #define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 24223adae150..b3edde68bc3e 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -184,6 +184,17 @@ struct kvm_vcpu_events {
>  	__u32 reserved[12];
>  };
>  
> +struct kvm_arm_copy_mte_tags {
> +	__u64 guest_ipa;
> +	__u64 length;
> +	void __user *addr;
> +	__u64 flags;
> +	__u64 reserved[2];
> +};
> +
> +#define KVM_ARM_TAGS_TO_GUEST		0
> +#define KVM_ARM_TAGS_FROM_GUEST		1
> +
>  /* If you need to interpret the index values, here is the key: */
>  #define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
>  #define KVM_REG_ARM_COPROC_SHIFT	16
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 28ce26a68f09..511f3716fe33 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1359,6 +1359,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  
>  		return 0;
>  	}
> +	case KVM_ARM_MTE_COPY_TAGS: {
> +		struct kvm_arm_copy_mte_tags copy_tags;
> +
> +		if (copy_from_user(&copy_tags, argp, sizeof(copy_tags)))
> +			return -EFAULT;
> +		return kvm_vm_ioctl_mte_copy_tags(kvm, &copy_tags);
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5cb4a1cd5603..4ddb20017b2f 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -995,3 +995,85 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  
>  	return ret;
>  }
> +
> +long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> +				struct kvm_arm_copy_mte_tags *copy_tags)
> +{
> +	gpa_t guest_ipa = copy_tags->guest_ipa;
> +	size_t length = copy_tags->length;
> +	void __user *tags = copy_tags->addr;
> +	gpa_t gfn;
> +	bool write = !(copy_tags->flags & KVM_ARM_TAGS_FROM_GUEST);
> +	int ret = 0;
> +
> +	if (!kvm_has_mte(kvm))
> +		return -EINVAL;
> +
> +	if (copy_tags->reserved[0] || copy_tags->reserved[1])
> +		return -EINVAL;
> +
> +	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
> +		return -EINVAL;
> +
> +	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	gfn = gpa_to_gfn(guest_ipa);
> +
> +	mutex_lock(&kvm->slots_lock);
> +
> +	while (length > 0) {
> +		kvm_pfn_t pfn = gfn_to_pfn_prot(kvm, gfn, write, NULL);
> +		void *maddr;
> +		unsigned long num_tags;
> +		struct page *page;
> +
> +		if (is_error_noslot_pfn(pfn)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		page = pfn_to_online_page(pfn);
> +		if (!page) {
> +			/* Reject ZONE_DEVICE memory */
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		maddr = page_address(page);
> +
> +		if (!write) {
> +			if (test_bit(PG_mte_tagged, &page->flags))
> +				num_tags = mte_copy_tags_to_user(tags, maddr,
> +							MTE_GRANULES_PER_PAGE);
> +			else
> +				/* No tags in memory, so write zeros */
> +				num_tags = MTE_GRANULES_PER_PAGE -
> +					clear_user(tags, MTE_GRANULES_PER_PAGE);
> +			kvm_release_pfn_clean(pfn);
> +		} else {
> +			num_tags = mte_copy_tags_from_user(maddr, tags,
> +							MTE_GRANULES_PER_PAGE);
> +			kvm_release_pfn_dirty(pfn);
> +		}
> +
> +		if (num_tags != MTE_GRANULES_PER_PAGE) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		/* Set the flag after checking the write completed fully */
> +		if (write)
> +			set_bit(PG_mte_tagged, &page->flags);

This ended up catching my eye as I was merging some other patches.

This set_bit() occurs *after* the page has been released, meaning it
could have been evicted and reused in the interval. I plan to fix it
as below. Please let me know if that works for you.

Thanks,

	M.

From a78d3206378a7101659fbc2a4bf01cb9376c4793 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 24 Jun 2021 14:21:05 +0100
Subject: [PATCH] KVM: arm64: Set the MTE tag bit before releasing the page

Setting a page flag without holding a reference to the page
is living dangerously. In the tag-writing path, we drop the
reference to the page by calling kvm_release_pfn_dirty(),
and only then set the PG_mte_tagged bit.

It would be safer to do it the other way round.

Fixes: f0376edb1ddca ("KVM: arm64: Add ioctl to fetch/store tags in a guest")
Cc: Steven Price <steven.price@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/guest.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 4ddb20017b2f..60815ae477cf 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1053,6 +1053,14 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 		} else {
 			num_tags = mte_copy_tags_from_user(maddr, tags,
 							MTE_GRANULES_PER_PAGE);
+
+			/*
+			 * Set the flag after checking the write
+			 * completed fully
+			 */
+			if (num_tags == MTE_GRANULES_PER_PAGE)
+				set_bit(PG_mte_tagged, &page->flags);
+
 			kvm_release_pfn_dirty(pfn);
 		}
 
@@ -1061,10 +1069,6 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			goto out;
 		}
 
-		/* Set the flag after checking the write completed fully */
-		if (write)
-			set_bit(PG_mte_tagged, &page->flags);
-
 		gfn++;
 		tags += num_tags;
 		length -= PAGE_SIZE;
-- 
2.30.2


-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
