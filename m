Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5412F3F0D48
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 23:24:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A62974B0C6;
	Wed, 18 Aug 2021 17:24:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBWCWeVGCe5K; Wed, 18 Aug 2021 17:24:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BC844B0CC;
	Wed, 18 Aug 2021 17:24:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 505CE4B0AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 17:24:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tz2GFZJc8ESP for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 17:24:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D222F402A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 17:24:41 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C04DF610CD;
 Wed, 18 Aug 2021 21:24:40 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mGT38-005qM1-Jb; Wed, 18 Aug 2021 22:24:38 +0100
Date: Wed, 18 Aug 2021 22:24:38 +0100
Message-ID: <87o89uzbs9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] KVM: arm64: vgic: Resample HW pending state on
 deactivation
In-Reply-To: <CAOQ_QsgGiGSfEq1QGfePiRF-=spCuR6XZ2QXfUsZ1zWds0ftag@mail.gmail.com>
References: <20210818181432.432256-1-maz@kernel.org>
 <CAJHc60zUZS3K4q88QYwP2CkGn7ywt-_fedjk7OK_W7cdQRJvxA@mail.gmail.com>
 <CAOQ_QsgGiGSfEq1QGfePiRF-=spCuR6XZ2QXfUsZ1zWds0ftag@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, rananta@google.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 Alexandru.Elisei@arm.com, andre.przywara@arm.com, eric.auger@redhat.com,
 ricarkol@google.com, kernel-team@android.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, stable@vger.kernel.org,
 Raghavendra Rao Ananta <rananta@google.com>, kvmarm@lists.cs.columbia.edu,
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

On Wed, 18 Aug 2021 20:40:42 +0100,
Oliver Upton <oupton@google.com> wrote:
> 
> Hey Marc,
> 
> On Wed, Aug 18, 2021 at 12:05 PM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > On Wed, Aug 18, 2021 at 11:14 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > When a mapped level interrupt (a timer, for example) is deactivated
> > > by the guest, the corresponding host interrupt is equally deactivated.
> > > However, the fate of the pending state still needs to be dealt
> > > with in SW.
> > >
> > > This is specially true when the interrupt was in the active+pending
> > > state in the virtual distributor at the point where the guest
> > > was entered. On exit, the pending state is potentially stale
> > > (the guest may have put the interrupt in a non-pending state).
> > >
> > > If we don't do anything, the interrupt will be spuriously injected
> > > in the guest. Although this shouldn't have any ill effect (spurious
> > > interrupts are always possible), we can improve the emulation by
> > > detecting the deactivation-while-pending case and resample the
> > > interrupt.
> > >
> > > Fixes: e40cc57bac79 ("KVM: arm/arm64: vgic: Support level-triggered mapped interrupts")
> > > Reported-by: Raghavendra Rao Ananta <rananta@google.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/arm64/kvm/vgic/vgic-v2.c | 25 ++++++++++++++++++-------
> > >  arch/arm64/kvm/vgic/vgic-v3.c | 25 ++++++++++++++++++-------
> > >  2 files changed, 36 insertions(+), 14 deletions(-)
> > >
> > Tested-by: Raghavendra Rao Ananta <rananta@google.com>
> >
> > Thanks,
> > Raghavendra
> > > diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
> > > index 2c580204f1dc..3e52ea86a87f 100644
> > > --- a/arch/arm64/kvm/vgic/vgic-v2.c
> > > +++ b/arch/arm64/kvm/vgic/vgic-v2.c
> > > @@ -60,6 +60,7 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                 u32 val = cpuif->vgic_lr[lr];
> > >                 u32 cpuid, intid = val & GICH_LR_VIRTUALID;
> > >                 struct vgic_irq *irq;
> > > +               bool deactivated;
> > >
> > >                 /* Extract the source vCPU id from the LR */
> > >                 cpuid = val & GICH_LR_PHYSID_CPUID;
> > > @@ -75,7 +76,8 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
> > >
> > >                 raw_spin_lock(&irq->irq_lock);
> > >
> > > -               /* Always preserve the active bit */
> > > +               /* Always preserve the active bit, note deactivation */
> > > +               deactivated = irq->active && !(val & GICH_LR_ACTIVE_BIT);
> > >                 irq->active = !!(val & GICH_LR_ACTIVE_BIT);
> > >
> > >                 if (irq->active && vgic_irq_is_sgi(intid))
> > > @@ -105,6 +107,12 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                  * device state could have changed or we simply need to
> > >                  * process the still pending interrupt later.
> > >                  *
> > > +                * We could also have entered the guest with the interrupt
> > > +                * active+pending. On the next exit, we need to re-evaluate
> > > +                * the pending state, as it could otherwise result in a
> > > +                * spurious interrupt by injecting a now potentially stale
> > > +                * pending state.
> > > +                *
> > >                  * If this causes us to lower the level, we have to also clear
> > >                  * the physical active state, since we will otherwise never be
> > >                  * told when the interrupt becomes asserted again.
> > > @@ -115,12 +123,15 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                 if (vgic_irq_is_mapped_level(irq)) {
> > >                         bool resample = false;
> > >
> > > -                       if (val & GICH_LR_PENDING_BIT) {
> > > -                               irq->line_level = vgic_get_phys_line_level(irq);
> > > -                               resample = !irq->line_level;
> > > -                       } else if (vgic_irq_needs_resampling(irq) &&
> > > -                                  !(irq->active || irq->pending_latch)) {
> > > -                               resample = true;
> > > +                       if (unlikely(vgic_irq_needs_resampling(irq))) {
> > > +                               if (!(irq->active || irq->pending_latch))
> > > +                                       resample = true;
> > > +                       } else {
> > > +                               if ((val & GICH_LR_PENDING_BIT) ||
> > > +                                   (deactivated && irq->line_level)) {
> > > +                                       irq->line_level = vgic_get_phys_line_level(irq);
> > > +                                       resample = !irq->line_level;
> > > +                               }
> > >                         }
> > >
> > >                         if (resample)
> > > diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> > > index 66004f61cd83..74f9aefffd5e 100644
> > > --- a/arch/arm64/kvm/vgic/vgic-v3.c
> > > +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> > > @@ -46,6 +46,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                 u32 intid, cpuid;
> > >                 struct vgic_irq *irq;
> > >                 bool is_v2_sgi = false;
> > > +               bool deactivated;
> > >
> > >                 cpuid = val & GICH_LR_PHYSID_CPUID;
> > >                 cpuid >>= GICH_LR_PHYSID_CPUID_SHIFT;
> > > @@ -68,7 +69,8 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> > >
> > >                 raw_spin_lock(&irq->irq_lock);
> > >
> > > -               /* Always preserve the active bit */
> > > +               /* Always preserve the active bit, note deactivation */
> > > +               deactivated = irq->active && !(val & ICH_LR_ACTIVE_BIT);
> > >                 irq->active = !!(val & ICH_LR_ACTIVE_BIT);
> > >
> > >                 if (irq->active && is_v2_sgi)
> > > @@ -98,6 +100,12 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                  * device state could have changed or we simply need to
> > >                  * process the still pending interrupt later.
> > >                  *
> > > +                * We could also have entered the guest with the interrupt
> > > +                * active+pending. On the next exit, we need to re-evaluate
> > > +                * the pending state, as it could otherwise result in a
> > > +                * spurious interrupt by injecting a now potentially stale
> > > +                * pending state.
> > > +                *
> > >                  * If this causes us to lower the level, we have to also clear
> > >                  * the physical active state, since we will otherwise never be
> > >                  * told when the interrupt becomes asserted again.
> > > @@ -108,12 +116,15 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
> > >                 if (vgic_irq_is_mapped_level(irq)) {
> > >                         bool resample = false;
> > >
> > > -                       if (val & ICH_LR_PENDING_BIT) {
> > > -                               irq->line_level = vgic_get_phys_line_level(irq);
> > > -                               resample = !irq->line_level;
> > > -                       } else if (vgic_irq_needs_resampling(irq) &&
> > > -                                  !(irq->active || irq->pending_latch)) {
> > > -                               resample = true;
> > > +                       if (unlikely(vgic_irq_needs_resampling(irq))) {
> > > +                               if (!(irq->active || irq->pending_latch))
> > > +                                       resample = true;
> > > +                       } else {
> > > +                               if ((val & ICH_LR_PENDING_BIT) ||
> > > +                                   (deactivated && irq->line_level)) {
> > > +                                       irq->line_level = vgic_get_phys_line_level(irq);
> > > +                                       resample = !irq->line_level;
> > > +                               }
> 
> The vGICv3 and vGICv2 implementations look identical here, should we
> have a helper that keeps the code common between the two?

Probably. This code used to be much simpler, but it has grown a bit
unwieldy since I added the M1 support hack. This change doesn't make
look any better so it is probably time for a minor refactor.

I've pushed out an updated patch, but I'll wait a bit more for
additional feedback before posting it again.

> 
> Otherwise, the functional change LGTM, so:
> 
> Reviewed-by: Oliver Upton <oupton@google.com>

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
