Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3302EE75F7
	for <lists+kvmarm@lfdr.de>; Mon, 28 Oct 2019 17:20:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E314A4AC68;
	Mon, 28 Oct 2019 12:20:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WR-H4bRzATUI; Mon, 28 Oct 2019 12:20:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F25A4A4DF;
	Mon, 28 Oct 2019 12:20:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 40DB54A4DF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 12:20:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CoSbuOgVX2c0 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Oct 2019 12:19:58 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5581B4A4A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 12:19:58 -0400 (EDT)
Received: from [91.217.168.176] (helo=big-swifty.misterjones.org)
 by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
 (Exim 4.80) (envelope-from <maz@kernel.org>)
 id 1iP7kK-0008FT-2F; Mon, 28 Oct 2019 17:19:56 +0100
Date: Mon, 28 Oct 2019 16:19:55 +0000
Message-ID: <86pnigyh90.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2] KVM: arm64: Don't set HCR_EL2.TVM when S2FWB is
 supported
In-Reply-To: <0c3291a7-18dc-1ae5-e706-8b04c9ab8a9e@arm.com>
References: <20191028130541.30536-1-christoffer.dall@arm.com>
 <0c3291a7-18dc-1ae5-e706-8b04c9ab8a9e@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 91.217.168.176
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, christoffer.dall@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Mon, 28 Oct 2019 15:12:39 +0000,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> Hi,
> 
> Resending this email, because I replied only to the kvmarm list by accident,
> instead of replying to everyone involved.
> 
> On 10/28/19 1:05 PM, Christoffer Dall wrote:
> > On CPUs that support S2FWB (Armv8.4+), KVM configures the stage 2 page
> > tables to override the memory attributes of memory accesses, regardless
> > of the stage 1 page table configurations, and also when the stage 1 MMU
> > is turned off.  This results in all memory accesses to RAM being
> > cacheable, including during early boot of the guest.
> >
> > On CPUs without this feature, memory accesses were non-cacheable during
> > boot until the guest turned on the stage 1 MMU, and we had to detect
> > when the guest turned on the MMU, such that we could invalidate all cache
> > entries and ensure a consistent view of memory with the MMU turned on.
> > When the guest turned on the caches, we would call stage2_flush_vm()
> > from kvm_toggle_cache().
> >
> > However, stage2_flush_vm() walks all the stage 2 tables, and calls
> > __kvm_flush-dcache_pte, which on a system with S2FWD does ... absolutely
> > nothing.
> >
> > We can avoid that whole song and dance, and simply not set TVM when
> > creating a VM on a system that has S2FWB.
> >
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> > I was only able to test this on the model with cache modeling enabled,
> > but even removing TVM from HCR_EL2 without having FWB also worked with
> > that setup, so the testing of this has been light.  It seems like it
> > should obviously work, but it would be good if someone with access to
> > appropriate hardware could give this a spin.
> >
> >  arch/arm64/include/asm/kvm_arm.h     |  3 +--
> >  arch/arm64/include/asm/kvm_emulate.h | 12 +++++++++++-
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> > index ddf9d762ac62..6e5d839f42b5 100644
> > --- a/arch/arm64/include/asm/kvm_arm.h
> > +++ b/arch/arm64/include/asm/kvm_arm.h
> > @@ -61,7 +61,6 @@
> >   * RW:		64bit by default, can be overridden for 32bit VMs
> >   * TAC:		Trap ACTLR
> >   * TSC:		Trap SMC
> > - * TVM:		Trap VM ops (until M+C set in SCTLR_EL1)
> >   * TSW:		Trap cache operations by set/way
> >   * TWE:		Trap WFE
> >   * TWI:		Trap WFI
> > @@ -74,7 +73,7 @@
> >   * SWIO:	Turn set/way invalidates into set/way clean+invalidate
> >   */
> >  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
> > -			 HCR_TVM | HCR_BSU_IS | HCR_FB | HCR_TAC | \
> > +			 HCR_BSU_IS | HCR_FB | HCR_TAC | \
> >  			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> >  			 HCR_FMO | HCR_IMO)
> >  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index d69c1efc63e7..70509799a2a9 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -53,8 +53,18 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
> >  		/* trap error record accesses */
> >  		vcpu->arch.hcr_el2 |= HCR_TERR;
> >  	}
> > -	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> > +
> > +	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB)) {
> >  		vcpu->arch.hcr_el2 |= HCR_FWB;
> > +	} else {
> > +		/*
> > +		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
> > +		 * get set in SCTLR_EL1 such that we can detect when the guest
> > +		 * MMU gets turned off and do the necessary cache maintenance
> > +		 * then.
> > +		 */
> > +		vcpu->arch.hcr_el2 &= ~HCR_TVM;
> 
> Don't we want to set the bit here, so we're consistent with the
> previous behaviour and the comment? Because with this patch, we
> never set HCR_EL2.TVM...

Of course you're right. This is how I plan to fix it:

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 47c774c2d18b..7b835337f78b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -63,7 +63,7 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 		 * MMU gets turned on and do the necessary cache maintenance
 		 * then.
 		 */
-		vcpu->arch.hcr_el2 &= ~HCR_TVM;
+		vcpu->arch.hcr_el2 |= HCR_TVM;
 	}
 
 	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))


Christoffer, please shout if you disagree.

	M.

-- 
Jazz is not dead, it just smells funny.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
