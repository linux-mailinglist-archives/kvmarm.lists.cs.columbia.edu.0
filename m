Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A43D23D8AF2
	for <lists+kvmarm@lfdr.de>; Wed, 28 Jul 2021 11:41:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D8294B086;
	Wed, 28 Jul 2021 05:41:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4JL5QzgkZ+Qs; Wed, 28 Jul 2021 05:41:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D91634A5A0;
	Wed, 28 Jul 2021 05:41:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 944174A98B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 05:41:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m15zylCCtomu for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 05:41:04 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6B05440CF9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 05:41:04 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50B6260F9C;
 Wed, 28 Jul 2021 09:41:03 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m8g3h-001Uxw-D0; Wed, 28 Jul 2021 10:41:01 +0100
Date: Wed, 28 Jul 2021 10:41:00 +0100
Message-ID: <875ywuepxv.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/16] KVM: arm64: Generalise VM features into a set of
 flags
In-Reply-To: <20210727181026.GA19173@willie-the-truck>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-2-maz@kernel.org>
 <20210727181026.GA19173@willie-the-truck>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qperret@google.com, dbrazdil@google.com,
 vatsa@codeaurora.org, sdonthineni@nvidia.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, linux-kernel@vger.kernel.org,
 Shanker R Donthineni <sdonthineni@nvidia.com>, kvmarm@lists.cs.columbia.edu,
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

On Tue, 27 Jul 2021 19:10:27 +0100,
Will Deacon <will@kernel.org> wrote:
> 
> On Thu, Jul 15, 2021 at 05:31:44PM +0100, Marc Zyngier wrote:
> > We currently deal with a set of booleans for VM features,
> > while they could be better represented as set of flags
> > contained in an unsigned long, similarily to what we are
> > doing on the CPU side.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 12 +++++++-----
> >  arch/arm64/kvm/arm.c              |  5 +++--
> >  arch/arm64/kvm/mmio.c             |  3 ++-
> >  3 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 41911585ae0c..4add6c27251f 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -122,7 +122,10 @@ struct kvm_arch {
> >  	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
> >  	 * supported.
> >  	 */
> > -	bool return_nisv_io_abort_to_user;
> > +#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
> > +	/* Memory Tagging Extension enabled for the guest */
> > +#define KVM_ARCH_FLAG_MTE_ENABLED			1
> > +	unsigned long flags;
> 
> One downside of packing all these together is that updating 'flags' now
> requires an atomic rmw sequence (i.e. set_bit()). Then again, that's
> probably for the best anyway given that kvm_vm_ioctl_enable_cap() looks
> like it doesn't hold any locks.

That, and these operations are supposed to be extremely rare anyway.

> 
> >  	/*
> >  	 * VM-wide PMU filter, implemented as a bitmap and big enough for
> > @@ -133,9 +136,6 @@ struct kvm_arch {
> >  
> >  	u8 pfr0_csv2;
> >  	u8 pfr0_csv3;
> > -
> > -	/* Memory Tagging Extension enabled for the guest */
> > -	bool mte_enabled;
> >  };
> >  
> >  struct kvm_vcpu_fault_info {
> > @@ -777,7 +777,9 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
> >  #define kvm_arm_vcpu_sve_finalized(vcpu) \
> >  	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
> >  
> > -#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
> > +#define kvm_has_mte(kvm)					\
> > +	(system_supports_mte() &&				\
> > +	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
> 
> Not an issue with this patch, but I just noticed that the
> system_supports_mte() check is redundant here as we only allow the flag to
> be set if that's already the case.

It allows us to save a memory access if system_supports_mte() is false
(it is eventually implemented as a static key). On the other hand,
there is so much inlining due to it being a non-final cap that we
probably lose on that too...

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
