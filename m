Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD841ABB9
	for <lists+kvmarm@lfdr.de>; Tue, 28 Sep 2021 11:24:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A60D44B0EF;
	Tue, 28 Sep 2021 05:24:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPe1PcOrvE-H; Tue, 28 Sep 2021 05:24:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B4DD4B0B8;
	Tue, 28 Sep 2021 05:24:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB0E94A98B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 05:24:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSaQ9WUl8QhP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Sep 2021 05:24:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C81D4031F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 05:24:41 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D894961130;
 Tue, 28 Sep 2021 09:24:37 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mV9Ln-00DSn8-QY; Tue, 28 Sep 2021 10:24:35 +0100
Date: Tue, 28 Sep 2021 10:24:34 +0100
Message-ID: <87o88dt5m5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 07/14] KVM: Don't block+unblock when halt-polling is
 successful
In-Reply-To: <YVH/LjCqk/9PfDHn@google.com>
References: <20210925005528.1145584-1-seanjc@google.com>
 <20210925005528.1145584-8-seanjc@google.com>
 <878rzlass2.wl-maz@kernel.org>
 <80d90ee6-0d43-3735-5c26-be8c3d72d493@redhat.com>
 <877df3btgb.wl-maz@kernel.org> <YVH/LjCqk/9PfDHn@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seanjc@google.com, pbonzini@redhat.com,
 chenhuacai@kernel.org, aleksandar.qemu.devel@gmail.com, paulus@ozlabs.org,
 borntraeger@de.ibm.com, frankja@linux.ibm.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, david@redhat.com,
 cohuck@redhat.com, imbrenda@linux.ibm.com, vkuznets@redhat.com,
 wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-mips@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmatlack@google.com, jingzhangos@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu, Janosch Frank <frankja@linux.ibm.com>,
 Joerg Roedel <joro@8bytes.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Mon, 27 Sep 2021 18:28:14 +0100,
Sean Christopherson <seanjc@google.com> wrote:
> 
> On Sun, Sep 26, 2021, Marc Zyngier wrote:
> > On Sun, 26 Sep 2021 07:27:28 +0100,
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > 
> > > On 25/09/21 11:50, Marc Zyngier wrote:
> > > >> there is no need for arm64 to put/load
> > > >> the vGIC as KVM hasn't relinquished control of the vCPU in any way.
> > > > 
> > > > This doesn't mean that there is no requirement for any state
> > > > change. The put/load on GICv4 is crucial for performance, and the VMCR
> > > > resync is a correctness requirement.
> 
> Ah crud, I didn't blame that code beforehand, I simply assumed
> kvm_arch_vcpu_blocking() was purely for the blocking/schedule()
> sequence.  The comment in arm64's kvm_arch_vcpu_blocking() about
> kvm_arch_vcpu_runnable() makes more sense now too.
> 
> > > I wouldn't even say it's crucial for performance: halt polling cannot
> > > work and is a waste of time without (the current implementation of)
> > > put/load.
> > 
> > Not quite. A non-V{LPI,SGI} could still be used as the a wake-up from
> > WFI (which is the only reason we end-up on this path). Only LPIs (and
> > SGIs on GICv4.1) can be directly injected, meaning that SPIs and PPIs
> > still follow the standard SW injection model.
> > 
> > However, there is still the ICH_VMCR_EL2 requirement (to get the
> > up-to-date priority mask and group enable bits) for SW-injected
> > interrupt wake-up to work correctly, and I really don't want to save
> > that one eagerly on each shallow exit.
> 
> IIUC, VMCR is resident in hardware while the guest is running, and
> KVM needs to retrieve the VMCR when processing interrupts to
> determine if a interrupt is above the priority threshold.  If that's
> the case, then IMO handling the VMCR via an arch hook is
> unnecessarily fragile, e.g. any generic call that leads to
> kvm_arch_vcpu_runnable() needs to know that arm64 lazily retrieves a
> guest register.

Not quite. We only need to retrieve the VMCR if we are in a situation
where we need to trigger a wake-up from WFI at the point where we have
not done a vcpu_put() yet. All the other cases where the interrupt is
injected are managed by the HW. And the only case where
kvm_arch_vcpu_runnable() gets called is when blocking.

I also don't get why a hook would be fragile, as long as it has well
defined semantics.

> A better approach for VMCR would be to retrieve the value from
> hardware on-demand, e.g. via a hook in vgic_get_vmcr(), so that it's all but
> impossible to have bugs where KVM is working with a stale VMCR, e.g.
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
> index 48c6067fc5ec..0784de0c4080 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio.c
> @@ -828,6 +828,13 @@ void vgic_set_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
>  
>  void vgic_get_vmcr(struct kvm_vcpu *vcpu, struct vgic_vmcr *vmcr)
>  {
> +       if (!vcpu->...->vmcr_available) {
> +               preempt_disable();
> +               kvm_vgic_vmcr_sync(vcpu);
> +               preempt_enable();
> +               vcpu->...->vmcr_available = true;
> +       }
> +

But most of the uses of vgic_get_vmcr() are in contexts where the vcpu
isn't running at all (such as save/restore). It really only operates
on the shadow state, and what you have above will only lead to state
corruption.

>         if (kvm_vgic_global_state.type == VGIC_V2)
>                 vgic_v2_get_vmcr(vcpu, vmcr);
>         else
> 
> 
> Regarding vGIC v4, does KVM require it to be resident in hardware
> while the vCPU is loaded?

It is a requirement. Otherwise, we end-up with an inconsistent state
between the delivery of doorbells and the state of the vgic. Also,
reloading the GICv4 state can be pretty expensive (multiple MMIO
accesses), which is why we really don't want to do that on the hot
path (kvm_arch_vcpu_ioctl_run() *is* a hot path).

> If not, then we could do something like
> this, which would eliminate the arch hooks entirely if the VMCR is
> handled as above.
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index fe102cd2e518..efc862c4d802 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -365,31 +365,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
>         return kvm_timer_is_pending(vcpu);
>  }
> 
> -void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
> -{
> -       /*
> -        * If we're about to block (most likely because we've just hit a
> -        * WFI), we need to sync back the state of the GIC CPU interface
> -        * so that we have the latest PMR and group enables. This ensures
> -        * that kvm_arch_vcpu_runnable has up-to-date data to decide
> -        * whether we have pending interrupts.
> -        *
> -        * For the same reason, we want to tell GICv4 that we need
> -        * doorbells to be signalled, should an interrupt become pending.
> -        */
> -       preempt_disable();
> -       kvm_vgic_vmcr_sync(vcpu);
> -       vgic_v4_put(vcpu, true);
> -       preempt_enable();
> -}
> -
> -void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
> -{
> -       preempt_disable();
> -       vgic_v4_load(vcpu);
> -       preempt_enable();
> -}
> -
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
>         struct kvm_s2_mmu *mmu;
> @@ -697,7 +672,6 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>                         /* The distributor enable bits were changed */
>                         preempt_disable();
>                         vgic_v4_put(vcpu, false);
> -                       vgic_v4_load(vcpu);
>                         preempt_enable();
>                 }
> 
> @@ -813,6 +787,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                  */
>                 preempt_disable();
> 
> +               /*
> +                * Reload vGIC v4 if necessary, as it may be put on-demand so
> +                * that KVM can detect directly injected interrupts, e.g. when
> +                * determining if the vCPU is runnable due to a pending event.
> +                */
> +               vgic_v4_load(vcpu);

You'd need to detect that a previous put has been done. But overall,
it puts the complexity at the wrong place. WFI (aka kvm_vcpu_block) is
the place where we want to handle this synchronisation, and not the
run loop.

Instead of having a well defined interface with the blocking code
where we implement the required synchronisation, you spray the vgic
crap all over, and it becomes much harder to reason about it. Guess
what, I'm not keen on it.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
