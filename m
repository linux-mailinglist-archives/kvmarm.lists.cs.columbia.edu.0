Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 054E8610040
	for <lists+kvmarm@lfdr.de>; Thu, 27 Oct 2022 20:32:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 289BE49EED;
	Thu, 27 Oct 2022 14:32:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96Hr6J9-TLUQ; Thu, 27 Oct 2022 14:32:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B072740DE6;
	Thu, 27 Oct 2022 14:32:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ABC640B75
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 14:32:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ef3mFHYr6Fp6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Oct 2022 14:32:53 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 676AB401A2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Oct 2022 14:32:53 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 23A21B8271A;
 Thu, 27 Oct 2022 18:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A239BC433C1;
 Thu, 27 Oct 2022 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666895570;
 bh=GyavJEWFCP+S+nuZTi6xWSt2F7dNo4qEJljaBpVcJMg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=t8S81Lc3o4eVtQSzqenASNJj5JvbF4TQbctOtBAEyNPtLmhFf2yCfOuhPZR+WFyDe
 /Kb2be3PgWCGMg3ZFVy6fELC59bgofx3bFnD5dxZyUoFOEaWLqaT/6i9KsxsD7Lsja
 AzMwznaVnrUqK1nsWUoZUHcFuQa9AU4GYwn6wMRMuQfn3xn224dqybIp6Y14Ingqo6
 e90X3BtKalLb9J5NzMHvtWLOtFibjtEK/8vDAVq54PlOnn+oFO1uF4qOMK8r8eBtqs
 cu9TQj33QTIw1PNJHPHh5cCqCZcZdykNU+TkTF10fQumP4o1tadqUtjxuvFTPheY80
 SWHnn1k8ZdANA==
Received: from ip-185-104-136-29.ptr.icomera.net ([185.104.136.29]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oo7gK-0024Al-PL;
 Thu, 27 Oct 2022 19:32:48 +0100
Date: Thu, 27 Oct 2022 19:30:23 +0100
Message-ID: <875yg5glvk.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v6 3/8] KVM: Add support for using dirty ring in
 conjunction with bitmap
In-Reply-To: <Y1rDkz6q8+ZgYFWW@google.com>
References: <20221011061447.131531-4-gshan@redhat.com>
 <Y1Hdc/UVta3A5kHM@google.com> <8635bhfvnh.wl-maz@kernel.org>
 <Y1LDRkrzPeQXUHTR@google.com> <87edv0gnb3.wl-maz@kernel.org>
 <Y1ckxYst3tc0LCqb@google.com> <Y1css8k0gtFkVwFQ@google.com>
 <878rl4gxzx.wl-maz@kernel.org> <Y1ghIKrAsRFwSFsO@google.com>
 <877d0lhdo9.wl-maz@kernel.org> <Y1rDkz6q8+ZgYFWW@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.104.136.29
X-SA-Exim-Rcpt-To: seanjc@google.com, oliver.upton@linux.dev, gshan@redhat.com,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 peterx@redhat.com, will@kernel.org, catalin.marinas@arm.com,
 bgardon@google.com, shuah@kernel.org, andrew.jones@linux.dev,
 dmatlack@google.com, pbonzini@redhat.com, zhenyzha@redhat.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: shuah@kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com,
 andrew.jones@linux.dev, dmatlack@google.com, shan.gavin@gmail.com,
 bgardon@google.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Thu, 27 Oct 2022 18:44:51 +0100,
Sean Christopherson <seanjc@google.com> wrote:
> 
> On Thu, Oct 27, 2022, Marc Zyngier wrote:
> > On Tue, 25 Oct 2022 18:47:12 +0100, Sean Christopherson <seanjc@google.com> wrote:
> > > Call us incompetent, but I have zero confidence that KVM will never
> > > unintentionally add a path that invokes mark_page_dirty_in_slot()
> > > without a running vCPU.
> > 
> > Well, maybe it is time that KVM acknowledges there is a purpose to
> > dirtying memory outside of a vcpu context, and that if a write happens
> > in a vcpu context, this vcpu must be explicitly passed down rather
> > than obtained from kvm_get_running_vcpu(). Yes, this requires some
> > heavy surgery.
> 
> Heh, preaching to the choir on this one.
> 
>   On Mon, Dec 02, 2019 at 12:10:36PM -0800, Sean Christopherson wrote:
>   > IMO, adding kvm_get_running_vcpu() is a hack that is just asking for future
>   > abuse and the vcpu/vm/as_id interactions in mark_page_dirty_in_ring() look
>   > extremely fragile.
> 
> I'm all in favor of not using kvm_get_running_vcpu() in this path.
> 
> That said, it's somewhat of an orthogonal issue, as I would still
> want a sanity check in mark_page_dirty_in_slot() that a vCPU is
> provided when there is no dirty bitmap.

If we have a separate context and/or API, then all these checks become
a lot less controversial, and we can start reasoning about these
things. At the moment, this is just a mess.

> 
> > > By completely dropping the rule that KVM must have an active vCPU on
> > > architectures that support ring+bitmap, those types of bugs will go
> > > silently unnoticed, and will manifest as guest data corruption after
> > > live migration.
> > 
> > The elephant in the room is still userspace writing to its view of the
> > guest memory for device emulation. Do they get it right? I doubt it.
> 
> I don't see what that has to do with KVM though.  There are many
> things userspace needs to get right, that doesn't mean that KVM
> shouldn't strive to provide safeguards for the functionality that
> KVM provides.

I guess we have different expectations of what KVM should provide. My
take is that userspace doesn't need a nanny, and that a decent level
of documentation should make it obvious what feature captures which
state.

But we've argued for a while now, and I don't see that we're getting
any closer to a resolution. So let's at least make some forward
progress with the opt-out mechanism you mentioned, and arm64 will buy
into it when snapshoting the ITS.

> 
> > > And ideally such bugs would detected without relying on userspace to
> > > enabling dirty logging, e.g. the Hyper-V bug lurked for quite some
> > > time and was only found when mark_page_dirty_in_slot() started
> > > WARNing.
> > > 
> > > I'm ok if arm64 wants to let userspace shoot itself in the foot with
> > > the ITS, but I'm not ok dropping the protections in the common
> > > mark_page_dirty_in_slot().
> > > 
> > > One somewhat gross idea would be to let architectures override the
> > > "there must be a running vCPU" rule, e.g. arm64 could toggle a flag
> > > in kvm->arch in its kvm_write_guest_lock() to note that an expected
> > > write without a vCPU is in-progress:
> > > 
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 8c5c69ba47a7..d1da8914f749 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -3297,7 +3297,10 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
> > >         struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> > >  
> > >  #ifdef CONFIG_HAVE_KVM_DIRTY_RING
> > > -       if (WARN_ON_ONCE(!vcpu) || WARN_ON_ONCE(vcpu->kvm != kvm))
> > > +       if (!kvm_arch_allow_write_without_running_vcpu(kvm) && WARN_ON_ONCE(!vcpu))
> > > +               return;
> > > +
> > > +       if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
> > >                 return;
> > >  #endif
> > >  
> > > @@ -3305,10 +3308,10 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
> > >                 unsigned long rel_gfn = gfn - memslot->base_gfn;
> > >                 u32 slot = (memslot->as_id << 16) | memslot->id;
> > >  
> > > -               if (kvm->dirty_ring_size)
> > > +               if (kvm->dirty_ring_size && vcpu)
> > >                         kvm_dirty_ring_push(&vcpu->dirty_ring,
> > >                                             slot, rel_gfn);
> > > -               else
> > > +               else if (memslot->dirty_bitmap)
> > >                         set_bit_le(rel_gfn, memslot->dirty_bitmap);
> > >         }
> > >  }
> > 
> > I think this is equally wrong. Writes occur from both CPUs and devices
> > *concurrently*, and I don't see why KVM should keep ignoring this
> > pretty obvious fact.
> >
> > Yes, your patch papers over the problem, and it can probably work if
> > the kvm->arch flag only gets set in the ITS saving code, which is
> > already exclusive of vcpus running.
> > 
> > But in the long run, with dirty bits being collected from the IOMMU
> > page tables or directly from devices, we will need a way to reconcile
> > the dirty tracking. The above doesn't quite cut it, unfortunately.
> 
> Oooh, are you referring to IOMMU page tables and devices _in the
> guest_?  E.g. if KVM itself were to emulate a vIOMMU, then KVM would
> be responsible for updating dirty bits in the vIOMMU page tables.

No. I'm talking about the *physical* IOMMU, which is (with the correct
architecture revision and feature set) capable of providing its own
set of dirty bits, on a per-device, per-PTE basis. Once we enable
that, we'll need to be able to sink these bits into the bitmap and
provide a unified view of the dirty state to userspace.

> Not that it really matters, but do we actually expect KVM to ever
> emulate a vIOMMU?  On x86 at least, in-kernel acceleration of vIOMMU
> emulation seems more like VFIO territory.

I don't expect KVM/arm64 to fully emulate an IOMMU, but at least to
eventually provide the required filtering to enable a stage-1 SMMU to
be passed to a guest. This is the sort of things pKVM needs to
implement for the host anyway, and going the extra mile to support
arbitrary guests outside of the pKVM context isn't much more work.

> Regardless, I don't think the above idea makes it any more difficult
> to support in-KVM emulation of non-CPU stuff, which IIUC is the ITS
> case.  I 100% agree that the above is a hack, but that's largely due
> to the use of kvm_get_running_vcpu().

That I agree.

> A slightly different alternative would be have a completely separate
> API for writing guest memory without an associated vCPU.  I.e. start
> building up proper device emulation support.  Then the vCPU-based
> APIs could yell if a vCPU isn't provided (or there is no running
> vCPU in the current mess).  And the deviced-based API could be
> provided if and only if the architecture actually supports emulating
> writes from devices, i.e. x86 would not opt-in and so would even
> have access to the API.

Which is what I was putting under the "major surgery" label in my
previous email.

Anyhow, for the purpose of unblocking Gavin's series, I suggest to
adopt your per-arch opt-out suggestion as a stop gap measure, and we
will then be able to bike-shed for weeks on what the shape of the
device-originated memory dirtying API should be.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
