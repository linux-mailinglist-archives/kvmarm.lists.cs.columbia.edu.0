Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DE61E340
	for <lists+kvmarm@lfdr.de>; Sun,  6 Nov 2022 16:51:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6BD4B7E9;
	Sun,  6 Nov 2022 10:51:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPhGomISb0R9; Sun,  6 Nov 2022 10:51:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 796864B78C;
	Sun,  6 Nov 2022 10:51:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF26D4B654
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 10:51:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NP9yzobxSfSF for <kvmarm@lists.cs.columbia.edu>;
 Sun,  6 Nov 2022 10:51:20 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8594D4B643
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 10:51:20 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 38F4EB80BFE;
 Sun,  6 Nov 2022 15:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0EAC433D6;
 Sun,  6 Nov 2022 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667749877;
 bh=V+jRW3DTjGuWCrSGuNtqChV2ZVbAmdSc6ZhgYGl2HFA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XDmZGuBJ7wbj/ggFkuEq+2HCYrxs2mojStiFRwnRkD7JZtAQP/TIMhw6Ka+AWwvI0
 W4xqQCIN8wfmiTqPFnCZI+5APf2TdN4taCdxNI50CB36yt6K6j/mwZC3k+0Cgagfns
 9BPaC9fwHWplFS45UyahKOuSMi09IfiaaJClSRudsdB6cVFi4b6tsjCF5RF1gKLoi4
 fsIIsoGvVMU5Fv78Fdvpv925PXhfNwpfsf31piDXlq3Mw+0Bq+tbvPLdir1f2DDk2z
 eNXNE28FsEVXV1SevZs3jIdurca232UmczbUk0zFJN5R0VaB7YnZS8zb4ceOP4uAE8
 XxRrFnuDQdfMQ==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1orhvX-004DOW-BQ;
 Sun, 06 Nov 2022 15:51:15 +0000
Date: Sun, 06 Nov 2022 15:50:48 +0000
Message-ID: <87mt94f5ev.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v8 4/7] KVM: arm64: Enable ring-based dirty memory tracking
In-Reply-To: <20221104234049.25103-5-gshan@redhat.com>
References: <20221104234049.25103-1-gshan@redhat.com>
 <20221104234049.25103-5-gshan@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gshan@redhat.com, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, shuah@kernel.org,
 catalin.marinas@arm.com, andrew.jones@linux.dev, ajones@ventanamicro.com,
 bgardon@google.com, dmatlack@google.com, will@kernel.org,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, pbonzini@redhat.com,
 peterx@redhat.com, seanjc@google.com, oliver.upton@linux.dev,
 zhenyzha@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com, bgardon@google.com,
 kvmarm@lists.linux.dev, pbonzini@redhat.com, zhenyzha@redhat.com,
 shuah@kernel.org, kvmarm@lists.cs.columbia.edu, ajones@ventanamicro.com
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

On Fri, 04 Nov 2022 23:40:46 +0000,
Gavin Shan <gshan@redhat.com> wrote:
> 
> Enable ring-based dirty memory tracking on arm64 by selecting
> CONFIG_HAVE_KVM_DIRTY_{RING_ACQ_REL, RING_WITH_BITMAP} and providing
> the ring buffer's physical page offset (KVM_DIRTY_LOG_PAGE_OFFSET).
> 
> Besides, helper kvm_vgic_save_its_tables_in_progress() is added to
> indicate if vgic/its tables are being saved or not. The helper is used
> in ARM64's kvm_arch_allow_write_without_running_vcpu() to keep the
> site of saving vgic/its tables out of no-running-vcpu radar.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst     |  2 +-
>  arch/arm64/include/uapi/asm/kvm.h  |  1 +
>  arch/arm64/kvm/Kconfig             |  2 ++
>  arch/arm64/kvm/arm.c               |  3 +++
>  arch/arm64/kvm/mmu.c               | 15 +++++++++++++++
>  arch/arm64/kvm/vgic/vgic-its.c     |  3 +++
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c |  7 +++++++
>  include/kvm/arm_vgic.h             |  2 ++
>  8 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 2ec32bd41792..2fc68f684ad8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7921,7 +7921,7 @@ regardless of what has actually been exposed through the CPUID leaf.
>  8.29 KVM_CAP_DIRTY_LOG_RING/KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>  ----------------------------------------------------------
>  
> -:Architectures: x86
> +:Architectures: x86, arm64
>  :Parameters: args[0] - size of the dirty log ring
>  
>  KVM is capable of tracking dirty memory using ring buffers that are
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 316917b98707..a7a857f1784d 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -43,6 +43,7 @@
>  #define __KVM_HAVE_VCPU_EVENTS
>  
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
>  
>  #define KVM_REG_SIZE(id)						\
>  	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 815cc118c675..066b053e9eb9 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -32,6 +32,8 @@ menuconfig KVM
>  	select KVM_VFIO
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_IRQFD
> +	select HAVE_KVM_DIRTY_RING_ACQ_REL
> +	select HAVE_KVM_DIRTY_RING_WITH_BITMAP
>  	select HAVE_KVM_MSI
>  	select HAVE_KVM_IRQCHIP
>  	select HAVE_KVM_IRQ_ROUTING
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 94d33e296e10..6b097605e38c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -746,6 +746,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>  
>  		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>  			return kvm_vcpu_suspend(vcpu);
> +
> +		if (kvm_dirty_ring_check_request(vcpu))
> +			return 0;
>  	}
>  
>  	return 1;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 60ee3d9f01f8..fbeb55e45f53 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -932,6 +932,21 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>  	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
>  }
>  
> +/*
> + * kvm_arch_allow_write_without_running_vcpu - allow writing guest memory
> + * without the running VCPU when dirty ring is enabled.
> + *
> + * The running VCPU is required to track dirty guest pages when dirty ring
> + * is enabled. Otherwise, the backup bitmap should be used to track the
> + * dirty guest pages. When vgic/its tables are being saved, the backup
> + * bitmap is used to track the dirty guest pages due to the missed running
> + * VCPU in the period.
> + */
> +bool kvm_arch_allow_write_without_running_vcpu(struct kvm *kvm)
> +{
> +	return kvm_vgic_save_its_tables_in_progress(kvm);

I don't think we need the extra level of abstraction here. Just return
kvm->arch.vgic.save_its_tables_in_progress and be done with it.

You can also move the helper to the vgic-its code since they are
closely related for now.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
