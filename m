Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77F66459259
	for <lists+kvmarm@lfdr.de>; Mon, 22 Nov 2021 16:57:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EACFE4B132;
	Mon, 22 Nov 2021 10:57:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipeDBlEc8GCW; Mon, 22 Nov 2021 10:57:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FF224B104;
	Mon, 22 Nov 2021 10:57:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5BF5D4B0B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 10:57:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id chMnGzxaw6iD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Nov 2021 10:57:43 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 087C74B086
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 10:57:42 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0498D60D07;
 Mon, 22 Nov 2021 15:57:42 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mpBhL-0075am-OG; Mon, 22 Nov 2021 15:57:39 +0000
Date: Mon, 22 Nov 2021 15:57:32 +0000
Message-ID: <871r38dvyr.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 2/5] KVM: arm64: Get rid of host SVE tracking/saving
In-Reply-To: <5ab3836f-2b39-2ff5-3286-8258addd01e4@huawei.com>
References: <20211028111640.3663631-1-maz@kernel.org>
 <20211028111640.3663631-3-maz@kernel.org>
 <5ab3836f-2b39-2ff5-3286-8258addd01e4@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, qperret@google.com,
 will@kernel.org, broonie@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 broonie@kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Zenghui,

On Wed, 10 Nov 2021 13:19:23 +0000,
Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> Hi Marc,
> 
> On 2021/10/28 19:16, Marc Zyngier wrote:
> > The SVE host tracking in KVM is pretty involved. It relies on a
> > set of flags tracking the ownership of the SVE register, as well
> > as that of the EL0 access.
> > 
> > It is also pretty scary: __hyp_sve_save_host() computes
> > a thread_struct pointer and obtains a sve_state which gets directly
> > accessed without further ado, even on nVHE. How can this even work?
> > 
> > The answer to that is that it doesn't, and that this is mostly dead
> > code. Closer examination shows that on executing a syscall, userspace
> > loses its SVE state entirely. This is part of the ABI. Another
> > thing to notice is that although the kernel provides helpers such as
> > kernel_neon_begin()/end(), they only deal with the FP/NEON state,
> > and not SVE.
> > 
> > Given that you can only execute a guest as the result of a syscall,
> > and that the kernel cannot use SVE by itself, it becomes pretty
> > obvious that there is never any host SVE state to save, and that
> > this code is only there to increase confusion.
> > 
> > Get rid of the TIF_SVE tracking and host save infrastructure altogether.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > index 5621020b28de..38ca332c10fe 100644
> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -73,15 +73,11 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
> >  void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
> >  {
> >  	BUG_ON(!current->mm);
> > +	BUG_ON(test_thread_flag(TIF_SVE));
> >  -	vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
> > -			      KVM_ARM64_HOST_SVE_IN_USE |
> > -			      KVM_ARM64_HOST_SVE_ENABLED);
> > +	vcpu->arch.flags &= ~KVM_ARM64_FP_ENABLED;
> >  	vcpu->arch.flags |= KVM_ARM64_FP_HOST;
> >  -	if (test_thread_flag(TIF_SVE))
> > -		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_IN_USE;
> 
> The comment about TIF_SVE on top of kvm_arch_vcpu_load_fp() becomes
> obsolete now. Maybe worth removing it?
> 
> | *
> | * TIF_SVE is backed up here, since it may get clobbered with guest state.
> | * This flag is restored by kvm_arch_vcpu_put_fp(vcpu).

Indeed. Now gone.

> 
> > diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > index a0e78a6027be..722dfde7f1aa 100644
> > --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> > +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> > @@ -207,16 +207,6 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
> >  	return __get_fault_info(esr, &vcpu->arch.fault);
> >  }
> >  -static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
> > -{
> > -	struct thread_struct *thread;
> > -
> > -	thread = container_of(vcpu->arch.host_fpsimd_state, struct thread_struct,
> > -			      uw.fpsimd_state);
> > -
> > -	__sve_save_state(sve_pffr(thread), &vcpu->arch.host_fpsimd_state->fpsr);
> > -}
> 
> Nit: This removes the only user of __sve_save_state() helper. Should we
> still keep it in fpsimd.S?

I was in two minds about that, as I'd like to eventually be able to
use SVE for protected guests, where the hypervisor itself has to be in
charge of the FP/SVE save-restore.

But that's probably several months away, and I can always revert a
deletion patch if I need to, so let's get rid of it now.

Thanks for the suggestions.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
