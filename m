Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36E21F70D
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jul 2020 18:18:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 322504B1F7;
	Tue, 14 Jul 2020 12:18:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Sp8JwH6OoOH; Tue, 14 Jul 2020 12:18:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E3D44B1D5;
	Tue, 14 Jul 2020 12:18:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB2F84B1B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 12:17:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qerq+Fn8cjjq for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jul 2020 12:17:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B7CF4B16A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jul 2020 12:17:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA75E30E;
 Tue, 14 Jul 2020 09:17:57 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 174A63F7BB;
 Tue, 14 Jul 2020 09:17:56 -0700 (PDT)
Date: Tue, 14 Jul 2020 17:17:50 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Leave vcpu FPSIMD synchronization in host
Message-ID: <20200714161743.GA30452@arm.com>
References: <20200710095754.3641976-1-ascull@google.com>
 <20200710095754.3641976-3-ascull@google.com>
 <20200713160421.GS10992@arm.com>
 <20200713204204.GA2680114@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713204204.GA2680114@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: maz@kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Mon, Jul 13, 2020 at 09:42:04PM +0100, Andrew Scull wrote:
> On Mon, Jul 13, 2020 at 05:04:21PM +0100, Dave Martin wrote:
> > On Fri, Jul 10, 2020 at 10:57:54AM +0100, Andrew Scull wrote:
> > > The task state can be checked by the host and the vcpu flags updated
> > > before calling into hyp. This more neatly separates the concerns and
> > > removes the need to map the task flags to EL2.
> > > 
> > > Hyp acts on the state provided to it by the host and updates it when
> > > switching to the vcpu state.
> > 
> > Can this patch be split up?  We have a few overlapping changes here.
> > 
> > i.e., renaming and refactoring of hooks; moving some code around; and a
> > couple of other changes that are not directly related (noted below).
> 
> Indeed it can, into at least 3.
> 
> > Overall this looks like a decent cleanup however.  It was always a bit
> > nasty to have to map the thread flags into Hyp.
> 
> Glad to hear, I'll have to get it in a better shape.
> 
> > Side question: currently we do fpsimd_save_and_flush_cpu_state() in
> > kvm_arch_vcpu_put_fp().  Can we remove the flush so that the vcpu state
> > lingers in the CPU regs and can be reclaimed when switching back to the
> > KVM thread?
> > 
> > This could remove some overhead when the KVM run loop is preempted by a
> > kernel thread and subsequently resumed without passing through userspace.
> > 
> > We would need to flush this state when anything else tries to change the
> > vcpu FP regs, which is one reason I skipped this previously: it would
> > require a bit of refactoring of fpsimd_flush_task_state() so that a non-
> > task context can also be flushed.
> > 
> > (This isn't directly related to this series.)
> 
> I don't plan to address this at the moment but I do believe there are
> chances to reduce the need for saves and restores. If the flush is
> removed a similar check to that done for tasks could also apply to vCPUs
> i.e. if the last FPSIMD state this CPU had was the vCPU and the vCPU
> last ran on this CPU then the vCPU's FPSIMD state is already loaded.

Sounds reasonable.

As you observe, this is mostly a case of refactoring the code a bit and
making the vcpu context slightly less of a special case.

(And if you don't do it, no worries -- I just couldn't resist getting it
done "for free" ;)

> 
> > Additional minor comments below.
> > 
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Andrew Scull <ascull@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h       |  5 +--
> > >  arch/arm64/kvm/arm.c                    |  4 +-
> > >  arch/arm64/kvm/fpsimd.c                 | 57 ++++++++++++++++++-------
> > >  arch/arm64/kvm/hyp/include/hyp/switch.h | 19 ---------
> > >  arch/arm64/kvm/hyp/nvhe/switch.c        |  3 +-
> > >  arch/arm64/kvm/hyp/vhe/switch.c         |  3 +-
> > >  6 files changed, 48 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > > index b06f24b5f443..ca1621eeb9d9 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -24,7 +24,6 @@
> > >  #include <asm/fpsimd.h>
> > >  #include <asm/kvm.h>
> > >  #include <asm/kvm_asm.h>
> > > -#include <asm/thread_info.h>
> > >  
> > >  #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> > >  
> > > @@ -320,7 +319,6 @@ struct kvm_vcpu_arch {
> > >  	struct kvm_guest_debug_arch vcpu_debug_state;
> > >  	struct kvm_guest_debug_arch external_debug_state;
> > >  
> > > -	struct thread_info *host_thread_info;	/* hyp VA */
> > >  	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
> > >  
> > >  	struct {
> > > @@ -616,7 +614,8 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
> > >  /* Guest/host FPSIMD coordination helpers */
> > >  int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
> > >  void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
> > > -void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
> > > +void kvm_arch_vcpu_enter_ctxsync_fp(struct kvm_vcpu *vcpu);
> > > +void kvm_arch_vcpu_exit_ctxsync_fp(struct kvm_vcpu *vcpu);
> > 
> > I find these names a bit confusing.
> > 
> > Maybe
> > 
> > 	kvm_arch_vcpu_ctxsync_fp_before_guest_enter()
> > 	kvm_arch_vcpu_ctxsync_fp_after_guest_exit()
> > 
> > (we could probably drop the "ctx" to make these slightly shorter).
> 
> Changed to kvm_arch_vcpu_sync_fp_{before,after}_run()

Fair enough.

> > >  void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
> > >  
> > >  static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > index 98f05bdac3c1..c7a711ca840e 100644
> > > --- a/arch/arm64/kvm/arm.c
> > > +++ b/arch/arm64/kvm/arm.c
> > > @@ -682,6 +682,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > >  
> > >  		local_irq_disable();
> > >  
> > > +		kvm_arch_vcpu_enter_ctxsync_fp(vcpu);
> > > +
> > >  		kvm_vgic_flush_hwstate(vcpu);
> > >  
> > >  		/*
> > > @@ -769,7 +771,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > >  		if (static_branch_unlikely(&userspace_irqchip_in_use))
> > >  			kvm_timer_sync_user(vcpu);
> > >  
> > > -		kvm_arch_vcpu_ctxsync_fp(vcpu);
> > > +		kvm_arch_vcpu_exit_ctxsync_fp(vcpu);
> > >  
> > >  		/*
> > >  		 * We may have taken a host interrupt in HYP mode (ie
> > > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > > index 3e081d556e81..aec91f43df62 100644
> > > --- a/arch/arm64/kvm/fpsimd.c
> > > +++ b/arch/arm64/kvm/fpsimd.c
> > > @@ -27,22 +27,13 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
> > >  {
> > >  	int ret;
> > >  
> > > -	struct thread_info *ti = &current->thread_info;
> > >  	struct user_fpsimd_state *fpsimd = &current->thread.uw.fpsimd_state;
> > >  
> > > -	/*
> > > -	 * Make sure the host task thread flags and fpsimd state are
> > > -	 * visible to hyp:
> > > -	 */
> > > -	ret = create_hyp_mappings(ti, ti + 1, PAGE_HYP);
> > > -	if (ret)
> > > -		goto error;
> > > -
> > > +	/* Make sure the host task fpsimd state is visible to hyp: */
> > >  	ret = create_hyp_mappings(fpsimd, fpsimd + 1, PAGE_HYP);
> > >  	if (ret)
> > >  		goto error;
> > >  
> > > -	vcpu->arch.host_thread_info = kern_hyp_va(ti);
> > >  	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
> > >  error:
> > >  	return ret;
> > > @@ -52,7 +43,7 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
> > >   * Prepare vcpu for saving the host's FPSIMD state and loading the guest's.
> > >   * The actual loading is done by the FPSIMD access trap taken to hyp.
> > >   *
> > > - * Here, we just set the correct metadata to indicate that the FPSIMD
> > > + * Here, we just set the correct metadata to indicate whether the FPSIMD
> > >   * state in the cpu regs (if any) belongs to current on the host.
> > >   *
> > >   * TIF_SVE is backed up here, since it may get clobbered with guest state.
> > > @@ -63,15 +54,46 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
> > >  	BUG_ON(!current->mm);
> > >  
> > >  	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
> > > +			      KVM_ARM64_FP_HOST |
> > >  			      KVM_ARM64_HOST_SVE_IN_USE |
> > >  			      KVM_ARM64_HOST_SVE_ENABLED);
> > > +
> > > +	if (!system_supports_fpsimd())
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Having just come from the user task, if any FP state is loaded it
> > > +	 * will be that of the task. Make a note of this but, just before
> > > +	 * entering the vcpu, it will be double checked that the loaded FP
> > > +	 * state isn't transient because things could change between now and
> > > +	 * then.
> > > +	 */
> > >  	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
> > >  
> > > -	if (test_thread_flag(TIF_SVE))
> > > -		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
> > > +	if (system_supports_sve()) {
> > 
> > This is a change and should be noted.
>  
> Ack
> 
> > Looks reasonable, though.
> > 
> > To ensure that we aren't breaking assumptions here, double-check that we
> > also have system_supports_sve() in the appropriate places in the Hyp
> > code.   We almost certainly do, but it doesn't hurt to review it.
> 
> Yes, hyp gates the fp trap handling on system_supports_fpsimd() and
> further gates SVE on system_supports_sve().

OK, that's reassuring.

> > > +		if (test_thread_flag(TIF_SVE))
> > > +			vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
> > >  
> > > -	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
> > > -		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
> > > +		if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
> > > +			vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
> > > +	}
> > > +}
> > > +
> > > +void kvm_arch_vcpu_enter_ctxsync_fp(struct kvm_vcpu *vcpu)
> > > +{
> > > +	WARN_ON_ONCE(!irqs_disabled());
> > > +
> > > +	if (!system_supports_fpsimd())
> > > +		return;
> > > +
> > > +	/*
> > > +	 * If the CPU's FP state is transient, there is no need to save the
> > > +	 * current state. Without further information, it must also be assumed
> > > +	 * that the vcpu's state is not loaded.
> > > +	 */
> > > +	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
> > > +		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
> > > +				      KVM_ARM64_FP_HOST);
> > >  }
> > >  
> > >  /*
> > > @@ -80,7 +102,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
> > >   * so that they will be written back if the kernel clobbers them due to
> > >   * kernel-mode NEON before re-entry into the guest.
> > >   */
> > > -void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
> > > +void kvm_arch_vcpu_exit_ctxsync_fp(struct kvm_vcpu *vcpu)
> > >  {
> > >  	WARN_ON_ONCE(!irqs_disabled());
> > >  
> > > @@ -106,6 +128,9 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
> > >  	bool host_has_sve = system_supports_sve();
> > >  	bool guest_has_sve = vcpu_has_sve(vcpu);
> > >  
> > > +	if (!system_supports_fpsimd())
> > > +		return;
> > > +
> > 
> > Is this a bugfix, an optimisation, or what?
> 
> This was concern over the comment in the hyp switching code that said
> something along the lines of some flags can't be truested if FPSIMD
> isn't supported. However, I'm convinced that FP_ENABLED will not be set
> if !system_supports_fpsimd() so you're right to question this.

If we can satisfy ourselves that the important flags never get set, it
might be better to drop it.

If there's significant doubt, then I wonder whether it would be worth
adding a WARN() instead.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
