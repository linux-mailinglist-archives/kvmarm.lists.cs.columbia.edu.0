Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8653407DD
	for <lists+kvmarm@lfdr.de>; Thu, 18 Mar 2021 15:32:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0D5A4B74B;
	Thu, 18 Mar 2021 10:32:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O0l+pKhMaRZ3; Thu, 18 Mar 2021 10:32:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B17744B751;
	Thu, 18 Mar 2021 10:32:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99E744B74B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 10:32:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7U8c35Nhxqq for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Mar 2021 10:32:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8FE9B4B746
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Mar 2021 10:32:31 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 720D164EFD;
 Thu, 18 Mar 2021 14:32:30 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lMthM-002Q85-BE; Thu, 18 Mar 2021 14:32:28 +0000
Date: Thu, 18 Mar 2021 14:32:27 +0000
Message-ID: <87zgz0h6ro.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 10/11] KVM: arm64: Save/restore SVE state for nVHE
In-Reply-To: <20210318141358.GF7055@willie-the-truck>
References: <20210318122532.505263-1-maz@kernel.org>
 <20210318122532.505263-11-maz@kernel.org>
 <20210318141358.GF7055@willie-the-truck>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, dave.martin@arm.com,
 daniel.kiss@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, broonie@kernel.org,
 ascull@google.com, qperret@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org, kernel-team@android.com,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, daniel.kiss@arm.com
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

On Thu, 18 Mar 2021 14:13:58 +0000,
Will Deacon <will@kernel.org> wrote:
> 
> On Thu, Mar 18, 2021 at 12:25:31PM +0000, Marc Zyngier wrote:
> > Implement the SVE save/restore for nVHE, following a similar
> > logic to that of the VHE implementation:
> > 
> > - the SVE state is switched on trap from EL1 to EL2
> > 
> > - no further changes to ZCR_EL2 occur as long as the guest isn't
> >   preempted or exit to userspace
> > 
> > - ZCR_EL2 is reset to its default value on the first SVE access from
> >   the host EL1, and ZCR_EL1 restored to the default guest value in
> >   vcpu_put()
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/fpsimd.c                 | 10 +++++--
> >  arch/arm64/kvm/hyp/include/hyp/switch.h | 37 +++++++++----------------
> >  arch/arm64/kvm/hyp/nvhe/switch.c        |  4 +--
> >  3 files changed, 23 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> > index 14ea05c5134a..5621020b28de 100644
> > --- a/arch/arm64/kvm/fpsimd.c
> > +++ b/arch/arm64/kvm/fpsimd.c
> > @@ -121,11 +121,17 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
> >  	local_irq_save(flags);
> >  
> >  	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
> > -		if (guest_has_sve)
> > +		if (guest_has_sve) {
> >  			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
> >  
> > +			/* Restore the VL that was saved when bound to the CPU */
> > +			if (!has_vhe())
> > +				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
> > +						       SYS_ZCR_EL1);
> 
> You end up reading ZCR_EL1 twice here, but it's probably not the end of the
> world.

True, but I'd expect read accesses to ZCR_EL1 to be reasonably fast,
something we can't expect from writes.

> 
> Anyway:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
