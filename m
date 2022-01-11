Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03A48B1AF
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jan 2022 17:11:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 601324B266;
	Tue, 11 Jan 2022 11:11:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hLFDMRmB7V58; Tue, 11 Jan 2022 11:11:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C79BF4B1A2;
	Tue, 11 Jan 2022 11:11:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CD504B1A2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 11:11:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yn-3C6XuY9t2 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jan 2022 11:11:18 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C9CF94B131
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 11:11:18 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342FB6D;
 Tue, 11 Jan 2022 08:11:18 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B16B3F774;
 Tue, 11 Jan 2022 08:11:15 -0800 (PST)
Date: Tue, 11 Jan 2022 16:11:25 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/2] KVM: arm64: mixed-width check should be skipped for
 uninitialized vCPUs
Message-ID: <Yd2sLbiw/XPCZe7q@monolith.localdoman>
References: <20220110054042.1079932-1-reijiw@google.com>
 <YdwPCcZWD8Uc1eej@monolith.localdoman>
 <CAAeT=Fz1KPbpmcSbukBuGWMJH=V_oXAJoaDHAen_Gy9Qswo_1Q@mail.gmail.com>
 <875yqqtn5q.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875yqqtn5q.wl-maz@kernel.org>
Cc: kvm@vger.kernel.org, Peter Shier <pshier@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Marc,

On Tue, Jan 11, 2022 at 01:30:41PM +0000, Marc Zyngier wrote:
> On Tue, 11 Jan 2022 07:37:57 +0000,
> Reiji Watanabe <reijiw@google.com> wrote:
> > 
> > Hi Alex,
> > 
> > On Mon, Jan 10, 2022 at 2:48 AM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > Hi Reiji,
> > >
> > > On Sun, Jan 09, 2022 at 09:40:41PM -0800, Reiji Watanabe wrote:
> > > > vcpu_allowed_register_width() checks if all the VCPUs are either
> > > > all 32bit or all 64bit.  Since the checking is done even for vCPUs
> > > > that are not initialized (KVM_ARM_VCPU_INIT has not been done) yet,
> > > > the non-initialized vCPUs are erroneously treated as 64bit vCPU,
> > > > which causes the function to incorrectly detect a mixed-width VM.
> > > >
> > > > Fix vcpu_allowed_register_width() to skip the check for vCPUs that
> > > > are not initialized yet.
> > > >
> > > > Fixes: 66e94d5cafd4 ("KVM: arm64: Prevent mixed-width VM creation")
> > > > Signed-off-by: Reiji Watanabe <reijiw@google.com>
> > > > ---
> > > >  arch/arm64/kvm/reset.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > > > index 426bd7fbc3fd..ef78bbc7566a 100644
> > > > --- a/arch/arm64/kvm/reset.c
> > > > +++ b/arch/arm64/kvm/reset.c
> > > > @@ -180,8 +180,19 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
> > > >       if (kvm_has_mte(vcpu->kvm) && is32bit)
> > > >               return false;
> > > >
> > > > +     /*
> > > > +      * Make sure vcpu->arch.target setting is visible from others so
> > > > +      * that the width consistency checking between two vCPUs is done
> > > > +      * by at least one of them at KVM_ARM_VCPU_INIT.
> > > > +      */
> > > > +     smp_mb();
> > >
> > > From ARM DDI 0487G.a, page B2-146 ("Data Memory Barrier (DMB)"):
> > >
> > > "The DMB instruction is a memory barrier instruction that ensures the relative
> > > order of memory accesses before the barrier with memory accesses after the
> > > barrier."
> > >
> > > I'm going to assume from the comment that you are referring to completion of
> > > memory accesses ("Make sure [..] is visible from others"). Please correct me if
> > > I am wrong. In this case, DMB ensures ordering of memory accesses with regards
> > > to writes and reads, not *completion*.  Have a look at
> > > tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus for
> > > the classic message passing example as an example of memory ordering.
> > > Message passing and other patterns are also explained in ARM DDI 0487G.a, page
> > > K11-8363.
> > >
> > > I'm not saying that your approach is incorrect, but the commit message should
> > > explain what memory accesses are being ordered relative to each other and why.
> > 
> > Thank you so much for the review.
> > What I meant with the comment was:
> > ---
> >   DMB is used to make sure that writing @vcpu->arch.target, which is done
> >   by kvm_vcpu_set_target() before getting here, is visible to other PEs
> >   before the following kvm_for_each_vcpu iteration reads the other vCPUs'
> >   target field.
> > ---
> > Did the comment become more clear ?? (Or do I use DMB incorrectly ?)
> > 
> > > > +
> > > >       /* Check that the vcpus are either all 32bit or all 64bit */
> > > >       kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
> > > > +             /* Skip if KVM_ARM_VCPU_INIT is not done for the vcpu yet */
> > > > +             if (tmp->arch.target == -1)
> > > > +                     continue;
> > 
> > I just noticed DMB(ishld) is needed here to assure ordering between
> > reading tmp->arch.target and reading vcpu->arch.features for this fix.
> > Similarly, kvm_vcpu_set_target() needs DMB(ishst) to assure ordering
> > between writing vcpu->arch.features and writing vcpu->arch.target...
> > I am going to fix them in the v2 series.
> 
> Yes, you'd need at least this, and preferably in their smp_rmb/wmb
> variants.
> 
> However, this looks like a pretty fragile construct, as there are
> multiple paths where we can change target (including some error
> paths from the run loop).
> 
> I'd rather all changes to target and the feature bits happen under the
> kvm->lock, and take that lock when checking for consistency in
> vcpu_allowed_register_width(), as this isn't a fast path. I wrote the
> following, which is obviously incomplete and as usual untested.

I think this is the better approach, because we also want to make sure that
a PE observes changes to target and features as soon as they have been
made, to avoid situations where one PE sets the target and the 32bit
feature, and another PE reads the old values and skips the check, in which
case memory ordering is not enough.

Thanks,
Alex

> 
> Thanks,
> 
> 	M.
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e4727dc771bf..42f2ab80646c 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1061,7 +1061,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>  static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  			       const struct kvm_vcpu_init *init)
>  {
> -	unsigned int i, ret;
> +	unsigned int i;
> +	int ret = 0;
>  	u32 phys_target = kvm_target_cpu();
>  
>  	if (init->target != phys_target)
> @@ -1074,32 +1075,46 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
>  	if (vcpu->arch.target != -1 && vcpu->arch.target != init->target)
>  		return -EINVAL;
>  
> +	/* Hazard against a concurent check of the target in kvm_reset_vcpu() */
> +	mutex_lock(&vcpu->kvm->lock);
> +
>  	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
>  	for (i = 0; i < sizeof(init->features) * 8; i++) {
>  		bool set = (init->features[i / 32] & (1 << (i % 32)));
>  
> -		if (set && i >= KVM_VCPU_MAX_FEATURES)
> -			return -ENOENT;
> +		if (set && i >= KVM_VCPU_MAX_FEATURES) {
> +			ret = -ENOENT;
> +			break;
> +		}
>  
>  		/*
>  		 * Secondary and subsequent calls to KVM_ARM_VCPU_INIT must
>  		 * use the same feature set.
>  		 */
>  		if (vcpu->arch.target != -1 && i < KVM_VCPU_MAX_FEATURES &&
> -		    test_bit(i, vcpu->arch.features) != set)
> -			return -EINVAL;
> +		    test_bit(i, vcpu->arch.features) != set) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
>  		if (set)
>  			set_bit(i, vcpu->arch.features);
>  	}
>  
> -	vcpu->arch.target = phys_target;
> +	if (!ret)
> +		vcpu->arch.target = phys_target;
> +
> +	mutex_unlock(&vcpu->kvm->lock);
> +	if (ret)
> +		return ret;
>  
>  	/* Now we know what it is, we can reset it. */
>  	ret = kvm_reset_vcpu(vcpu);
>  	if (ret) {
> +		mutex_lock(&vcpu->kvm->lock);
>  		vcpu->arch.target = -1;
>  		bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
> +		mutex_unlock(&vcpu->kvm->lock);
>  	}
>  
>  	return ret;
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index ef78bbc7566a..fae88a703140 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -180,13 +180,6 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
>  	if (kvm_has_mte(vcpu->kvm) && is32bit)
>  		return false;
>  
> -	/*
> -	 * Make sure vcpu->arch.target setting is visible from others so
> -	 * that the width consistency checking between two vCPUs is done
> -	 * by at least one of them at KVM_ARM_VCPU_INIT.
> -	 */
> -	smp_mb();
> -
>  	/* Check that the vcpus are either all 32bit or all 64bit */
>  	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>  		/* Skip if KVM_ARM_VCPU_INIT is not done for the vcpu yet */
> @@ -222,14 +215,19 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_reset_state reset_state;
> -	int ret;
> +	int ret = -EINVAL;
>  	bool loaded;
>  	u32 pstate;
>  
>  	mutex_lock(&vcpu->kvm->lock);
> -	reset_state = vcpu->arch.reset_state;
> -	WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> +	if (vcpu_allowed_register_width(vcpu)) {
> +		reset_state = vcpu->arch.reset_state;
> +		WRITE_ONCE(vcpu->arch.reset_state.reset, false);
> +		ret = 0;
> +	}
>  	mutex_unlock(&vcpu->kvm->lock);
> +	if (ret)
> +		goto out;
>  
>  	/* Reset PMU outside of the non-preemptible section */
>  	kvm_pmu_vcpu_reset(vcpu);
> @@ -257,11 +255,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> -	if (!vcpu_allowed_register_width(vcpu)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	switch (vcpu->arch.target) {
>  	default:
>  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> 
> -- 
> Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
