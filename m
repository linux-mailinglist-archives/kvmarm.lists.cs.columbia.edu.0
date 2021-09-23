Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B9415F23
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 15:02:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8345D4B135;
	Thu, 23 Sep 2021 09:02:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71YHlGL81ULP; Thu, 23 Sep 2021 09:02:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B6DF4B121;
	Thu, 23 Sep 2021 09:02:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D95674B0D6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 09:02:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X3va9wfxekE1 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 09:02:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 71D264A3A5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 09:02:17 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2252560F0F;
 Thu, 23 Sep 2021 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632402136;
 bh=Zkh2489hCo6Fofm1UetCFN/RtntSEUCNZ4fEl6U6ues=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eQMEP8bc4WCVUmN1L9mTrYo4BJreRtNnXdQXrW7pStqyn7p7q3i1+VTML4eyOFVuK
 F1dO7AXm6UEoNaXldIAm6TJwk2x8MM4CWn4dBXvHu7Qz9YAL20R+v3//hAUXOnrz2y
 JgBZ6BUJ7GkBIElz00avFPLWSQtS+U/Cr9EATwa6bNCgUgubpl0DoH/mcpqsZ05GaV
 +pSk6tdppBv5XwzjHGqSjQrGMe5+TFhTAaUiV3Q9hpDiq1CbN6ouHAVARV8L9uUK7O
 T9DAj8GS1FznhXjGmLhQcYwq8ubb6ibLXRLkDLWl6b1vp4voVD9FGU4lwAQrQ9QvTb
 jg0AAFiREdVYQ==
Date: Thu, 23 Sep 2021 14:02:11 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5/5] KVM: arm64: Disable privileged hypercalls after pKVM
 finalisation
Message-ID: <20210923130211.GB15934@willie-the-truck>
References: <20210923112256.15767-1-will@kernel.org>
 <20210923112256.15767-6-will@kernel.org>
 <87zgs3tpqi.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zgs3tpqi.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, Sep 23, 2021 at 01:56:21PM +0100, Marc Zyngier wrote:
> On Thu, 23 Sep 2021 12:22:56 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > After pKVM has been 'finalised' using the __pkvm_prot_finalize hypercall,
> > the calling CPU will have a Stage-2 translation enabled to prevent access
> > to memory pages owned by EL2.
> > 
> > Although this forms a significant part of the process to deprivilege the
> > host kernel, we also need to ensure that the hypercall interface is
> > reduced so that the EL2 code cannot, for example, be re-initialised using
> > a new set of vectors.
> > 
> > Re-order the hypercalls so that only a suffix remains available after
> > finalisation of pKVM.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Quentin Perret <qperret@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h   | 43 ++++++++++++++++--------------
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 26 +++++++++++-------
> >  2 files changed, 39 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index e86045ac43ba..68630fd382c5 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -43,27 +43,30 @@
> >  
> >  #define KVM_HOST_SMCCC_FUNC(name) KVM_HOST_SMCCC_ID(__KVM_HOST_SMCCC_FUNC_##name)
> >  
> > +/* Hypercalls available only prior to pKVM finalisation */
> >  #define __KVM_HOST_SMCCC_FUNC___kvm_hyp_init			0
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run			1
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context		2
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_ipa		3
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid		4
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_flush_cpu_context		5
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_timer_set_cntvoff		6
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_enable_ssbs			7
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_get_gic_config		8
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_read_vmcr		9
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_write_vmcr		10
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_init_lrs		11
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_get_mdcr_el2		12
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs		13
> > -#define __KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs		14
> > -#define __KVM_HOST_SMCCC_FUNC___pkvm_init			15
> > -#define __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp		16
> > -#define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	17
> > -#define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
> > -#define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
> > -#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			20
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_get_mdcr_el2		1
> > +#define __KVM_HOST_SMCCC_FUNC___pkvm_init			2
> > +#define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping	3
> > +#define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		4
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_enable_ssbs			5
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_init_lrs		6
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_get_gic_config		7
> > +#define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		8
> > +
> > +/* Hypercalls available after pKVM finalisation */
> > +#define __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp		9
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			10
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run			11
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context		12
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid_ipa		13
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_tlb_flush_vmid		14
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_flush_cpu_context		15
> > +#define __KVM_HOST_SMCCC_FUNC___kvm_timer_set_cntvoff		16
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_read_vmcr		17
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_write_vmcr		18
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_save_aprs		19
> > +#define __KVM_HOST_SMCCC_FUNC___vgic_v3_restore_aprs		20
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index 2da6aa8da868..4120e34288e1 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -165,36 +165,42 @@ typedef void (*hcall_t)(struct kvm_cpu_context *);
> >  #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
> >  
> >  static const hcall_t host_hcall[] = {
> > -	HANDLE_FUNC(__kvm_vcpu_run),
> > +	/* ___kvm_hyp_init */
> > +	HANDLE_FUNC(__kvm_get_mdcr_el2),
> > +	HANDLE_FUNC(__pkvm_init),
> > +	HANDLE_FUNC(__pkvm_create_private_mapping),
> > +	HANDLE_FUNC(__pkvm_cpu_set_vector),
> > +	HANDLE_FUNC(__kvm_enable_ssbs),
> > +	HANDLE_FUNC(__vgic_v3_init_lrs),
> > +	HANDLE_FUNC(__pkvm_prot_finalize),
> > +
> > +	HANDLE_FUNC(__pkvm_host_share_hyp),
> >  	HANDLE_FUNC(__kvm_adjust_pc),
> > +	HANDLE_FUNC(__kvm_vcpu_run),
> >  	HANDLE_FUNC(__kvm_flush_vm_context),
> >  	HANDLE_FUNC(__kvm_tlb_flush_vmid_ipa),
> >  	HANDLE_FUNC(__kvm_tlb_flush_vmid),
> >  	HANDLE_FUNC(__kvm_flush_cpu_context),
> >  	HANDLE_FUNC(__kvm_timer_set_cntvoff),
> > -	HANDLE_FUNC(__kvm_enable_ssbs),
> >  	HANDLE_FUNC(__vgic_v3_get_gic_config),
> >  	HANDLE_FUNC(__vgic_v3_read_vmcr),
> >  	HANDLE_FUNC(__vgic_v3_write_vmcr),
> > -	HANDLE_FUNC(__vgic_v3_init_lrs),
> > -	HANDLE_FUNC(__kvm_get_mdcr_el2),
> >  	HANDLE_FUNC(__vgic_v3_save_aprs),
> >  	HANDLE_FUNC(__vgic_v3_restore_aprs),
> > -	HANDLE_FUNC(__pkvm_init),
> > -	HANDLE_FUNC(__pkvm_cpu_set_vector),
> > -	HANDLE_FUNC(__pkvm_host_share_hyp),
> > -	HANDLE_FUNC(__pkvm_create_private_mapping),
> > -	HANDLE_FUNC(__pkvm_prot_finalize),
> >  };
> >  
> >  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> >  {
> >  	DECLARE_REG(unsigned long, id, host_ctxt, 0);
> > +	unsigned long hcall_min = 0;
> >  	hcall_t hfn;
> >  
> > +	if (static_branch_unlikely(&kvm_protected_mode_initialized))
> > +		hcall_min = __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize;
> > +
> >  	id -= KVM_HOST_SMCCC_ID(0);
> >  
> > -	if (unlikely(id >= ARRAY_SIZE(host_hcall)))
> > +	if (unlikely(id < hcall_min || id >= ARRAY_SIZE(host_hcall)))
> 
> So I can still issue a pkvm_prot_finalize after finalisation? Seems
> odd. As hcall_min has to be inclusive, you probably want it to be set
> to __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp once protected.

Yeah, I ended up addresing that one in the previous patch. The problem is
that we need to allow pkvm_prot_finalize to be called on each CPU, so I
think we'd end up having an extra "really finalize damnit!" call to be
issued _once_ after each CPU is done with the finalisation if we want
to lock it down.

The approach I took instead is to make pkvm_prot_finalize return -EBUSY
if it's called on a CPU where it's already been called.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
