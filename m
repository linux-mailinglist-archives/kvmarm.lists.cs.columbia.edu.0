Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 162583B0A0B
	for <lists+kvmarm@lfdr.de>; Tue, 22 Jun 2021 18:12:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 988284A17F;
	Tue, 22 Jun 2021 12:12:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7m8yEIscL1cc; Tue, 22 Jun 2021 12:12:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4061449FE6;
	Tue, 22 Jun 2021 12:12:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 79E3749F82
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 12:12:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXHxcoIFTWfz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Jun 2021 12:12:11 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 43CA340CF9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 12:12:11 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F6D561075;
 Tue, 22 Jun 2021 16:12:10 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lvj0S-009DCo-Bg; Tue, 22 Jun 2021 17:12:08 +0100
Date: Tue, 22 Jun 2021 17:12:07 +0100
Message-ID: <87y2b1c208.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 6/9] KVM: arm64: vgic: Implement SW-driven deactivation
In-Reply-To: <b87fb2e9-a3f9-accc-86d9-64dc2ee90dea@arm.com>
References: <20210601104005.81332-1-maz@kernel.org>
 <20210601104005.81332-7-maz@kernel.org>
 <b87fb2e9-a3f9-accc-86d9-64dc2ee90dea@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 eric.auger@redhat.com, marcan@marcan.st, mark.rutland@arm.com,
 yuzenghui@huawei.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Hector Martin <marcan@marcan.st>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Thu, 17 Jun 2021 15:58:31 +0100,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> Hi Marc,
> 
> On 6/1/21 11:40 AM, Marc Zyngier wrote:
> > In order to deal with these systems that do not offer HW-based
> > deactivation of interrupts, let implement a SW-based approach:
> 
> Nitpick, but shouldn't that be "let's"?

"Let it be...". ;-) Yup.

> 
> >
> > - When the irq is queued into a LR, treat it as a pure virtual
> >   interrupt and set the EOI flag in the LR.
> >
> > - When the interrupt state is read back from the LR, force a
> >   deactivation when the state is invalid (neither active nor
> >   pending)
> >
> > Interrupts requiring such treatment get the VGIC_SW_RESAMPLE flag.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/vgic/vgic-v2.c | 19 +++++++++++++++----
> >  arch/arm64/kvm/vgic/vgic-v3.c | 19 +++++++++++++++----
> >  include/kvm/arm_vgic.h        | 10 ++++++++++
> >  3 files changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
> > index 11934c2af2f4..2c580204f1dc 100644
> > --- a/arch/arm64/kvm/vgic/vgic-v2.c
> > +++ b/arch/arm64/kvm/vgic/vgic-v2.c
> > @@ -108,11 +108,22 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
> >  		 * If this causes us to lower the level, we have to also clear
> >  		 * the physical active state, since we will otherwise never be
> >  		 * told when the interrupt becomes asserted again.
> > +		 *
> > +		 * Another case is when the interrupt requires a helping hand
> > +		 * on deactivation (no HW deactivation, for example).
> >  		 */
> > -		if (vgic_irq_is_mapped_level(irq) && (val & GICH_LR_PENDING_BIT)) {
> > -			irq->line_level = vgic_get_phys_line_level(irq);
> > +		if (vgic_irq_is_mapped_level(irq)) {
> > +			bool resample = false;
> > +
> > +			if (val & GICH_LR_PENDING_BIT) {
> > +				irq->line_level = vgic_get_phys_line_level(irq);
> > +				resample = !irq->line_level;
> > +			} else if (vgic_irq_needs_resampling(irq) &&
> > +				   !(irq->active || irq->pending_latch)) {
> 
> I'm having a hard time figuring out when and why a level sensitive
> can have pending_latch = true.
> 
> I looked kvm_vgic_inject_irq(), and that function sets pending_latch
> only for edge triggered interrupts (it sets line_level for level
> sensitive ones). But irq_is_pending() looks at **both**
> pending_latch and line_level for level sensitive interrupts.

Yes, and that's what an implementation requires.

> The only place that I've found that sets pending_latch regardless of
> the  interrupt type  is in  vgic_mmio_write_spending() (called  on a
> trapped  write  to   GICD_ISENABLER).

Are you sure? It really should be GICD_ISPENDR. I'll assume that this
is what you mean below.

> vgic_v2_populate_lr()  clears
> pending_latch  only for  edge triggered  interrupts, so  that leaves
> vgic_v2_fold_lr_state()  as  the   only  function  pending_latch  is
> cleared for level sensitive interrupts,  when the interrupt has been
> handled by the guest.  Are we doing all of this  to emulate the fact
> that level sensitive interrupts (either purely virtual or hw mapped)
> made pending by a write  to GICD_ISENABLER remain pending until they
> are handled by the guest?

Yes, or cleared by a write to GICD_ICPENDR. You really need to think
of the input into the GIC as some sort of OR gate combining both the
line level and the PEND register. With a latch for edge interrupts.

Have a look at Figure 4-10 ("Logic of the pending status of a
level-sensitive interrupt") in the GICv2 arch spec (ARM IHI 0048B.b)
to see what I actually mean.

> If that is the case, then I think this is what the code is doing:
> 
> - There's no functional change when the irqchip has HW deactivation
> 
> - For level sensitive, hw mapped interrupts made pending by a write
> to GICD_ISENABLER and not yet handled by the guest (pending_latch ==
> true) we don't clear the pending state of the interrupt.
> 
> - For level sensitive, hw mapped interrupts we clear the pending
> state in the GIC and the device will assert the interrupt again if
> it's still pending at the device 1level. I have a question about
> this. Why don't we sample the interrupt state by calling
> vgic_get_phys_line_level()? Because that would be slower than the
> alternative that you are proposing here?

Yes. It is *much* faster to read the timer status register (for
example) than going via an MMIO access to read the (re)distributor
that will return the same value.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
