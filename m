Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 163573F7C17
	for <lists+kvmarm@lfdr.de>; Wed, 25 Aug 2021 20:15:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F0E74B1B3;
	Wed, 25 Aug 2021 14:15:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3fwgySmhv8f; Wed, 25 Aug 2021 14:15:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A17684B1AC;
	Wed, 25 Aug 2021 14:15:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 66BBB4B15E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 14:15:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGkMwZ2hd1Px for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Aug 2021 14:15:13 -0400 (EDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D52444B09F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 14:15:12 -0400 (EDT)
Received: by mail-lf1-f42.google.com with SMTP id y34so773922lfa.8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Aug 2021 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1QhcI1IjXPKa7HYJu5yUeiCjoFqDIsZs1IlqeQNR1lY=;
 b=VHozpR4Wlvty/jole+2KSgwfwJqt1fe7dBwxqGumFynobcOVl5gcedIGXUmMYUx70b
 BSwZtOGFxM6+2T93t1wxtbje9ffq9cL3PTMdmNWLBt5c6/X6/wymTulSsvuHenl/KbBC
 takhBP3OYv0/cqFf8tAIQYw3un/xxNhpWn4wbhe8FS/rL3RGHyvoIlzchlkZ2C8nn9Mp
 ZhDhUkeqg6MdFFyyDwIyP1qQeFJG1A5vYAIvXvFN7ey1iId7EZua+bLUNqc2S+tLa1FJ
 0PYrwKklLGw8EuFjPmUDPWiyUregqV+qYd8Gcl3y/zrMTY6ESjjUJhruCvw7zDemrVpg
 G1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1QhcI1IjXPKa7HYJu5yUeiCjoFqDIsZs1IlqeQNR1lY=;
 b=N8DdFe7/rnj0eSVstBZov7vqICsdT+XRpJGDmkVFqFb6EfD+LSILzOt4BXADT01wdr
 jOttx7ok2fsDzlo82Ru6VRGLrAQb7WMRmK6cFfsNFXpi4xbfQp3d8u8udShHymt5U2Ht
 7uXfInQQ4ouA2RBI+2BXUy6oFP2CueiTYIsNc9ObiYtZ3WTlZtmxg/GQ2qbsCQv0h6Xn
 XSn52H4Nc/W7dchxTaVNbWIgHs4tv2ew72LV8Bo66zy5We75LIeS0CZPmmvaLbmQGKl/
 5NSzR3yotE9IEVfg7fqGKM/pEwOMDlaDRS9UmPe/Ke+yQ5zvUzkymg63dz255Qbz0wjx
 H9Pw==
X-Gm-Message-State: AOAM530wTT+dgRP8/MUkoIVW4soVvePYemCYlvG3zibYabW+qf1KUA4i
 1r75uv8D0UXMxrc0UsRxpRnyF0NIVBBrhGg3ta5tZg==
X-Google-Smtp-Source: ABdhPJzjaChjPX6dvqV/GQwrjrZ4/dwEB+a0xuKcQ+jo5ni1J1XiNEgEDTiTxiLtHMNW8vL3J4U8VZqo1i55vhk+UGM=
X-Received: by 2002:a05:6512:3ba4:: with SMTP id
 g36mr34272950lfv.80.1629915311065; 
 Wed, 25 Aug 2021 11:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <YSVhV+UIMY12u2PW@google.com> <87mtp5q3gx.wl-maz@kernel.org>
 <CAOQ_QshSaEm_cMYQfRTaXJwnVqeoN29rMLBej-snWd6_0HsgGw@mail.gmail.com>
 <87fsuxq049.wl-maz@kernel.org> <20210825150713.5rpwzm4grfn7akcw@gator.home>
In-Reply-To: <20210825150713.5rpwzm4grfn7akcw@gator.home>
From: Oliver Upton <oupton@google.com>
Date: Wed, 25 Aug 2021 11:14:59 -0700
Message-ID: <CAOQ_QsgWiw9-BuGTUFpHqBw3simUaM4Tweb9y5_oz1UHdr4ELg@mail.gmail.com>
Subject: Re: KVM/arm64: Guest ABI changes do not appear rollback-safe
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, pshier@google.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 25, 2021 at 8:07 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Aug 25, 2021 at 11:39:34AM +0100, Marc Zyngier wrote:
> > On Wed, 25 Aug 2021 11:02:28 +0100,
> > Oliver Upton <oupton@google.com> wrote:
> > >
> > > On Wed, Aug 25, 2021 at 2:27 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > Exposing new hypercalls to guests in this manner seems very unsafe to
> > > > > me. Suppose an operator is trying to upgrade from kernel N to kernel
> > > > > N+1, which brings in the new 'widget' hypercall. Guests are live
> > > > > migrated onto the N+1 kernel, but the operator finds a defect that
> > > > > warrants a kernel rollback. VMs are then migrated from kernel N+1 -> N.
> > > > > Any guests that discovered the 'widget' hypercall are likely going to
> > > > > get fussy _very_ quickly on the old kernel.
> > > >
> > > > This goes against what we decided to support for the *only* publicly
> > > > available VMM that cares about save/restore, which is that we only
> > > > move forward and don't rollback.
> > >
> > > Ah, I was definitely missing this context. Current behavior makes much
> > > more sense then.
> > >
> > > > Hypercalls are the least of your
> > > > worries, and there is a whole range of other architectural features
> > > > that will have also appeared/disappeared (your own CNTPOFF series is a
> > > > glaring example of this).
> > >
> > > Isn't that a tad bit different though? I'll admit, I'm just as guilty
> > > with my own series forgetting to add a KVM_CAP (oops), but it is in my
> > > queue to kick out with the fix for nVHE/ptimer. Nonetheless, if a user
> > > takes up a new KVM UAPI, it is up to the user to run on a new kernel.
> >
> > The two are linked. Exposing a new register to userspace and/or guest
> > result in the same thing: you can't rollback. That's specially true in
> > the QEMU case, which *learns* from the kernel what registers are
> > available, and doesn't maintain a fixed list.
> >
> > > My concerns are explicitly with the 'under the nose' changes, where
> > > KVM modifies the guest feature set without userspace opting in. Based
> > > on your comment, though, it would appear that other parts of KVM are
> > > affected too.
> >
> > Any new system register that is exposed by a new kernel feature breaks
> > rollback. And so far, we only consider it a bug if the set of exposed
> > registers reduces. Anything can be added safely (as checked by one of
> > the selftests added by Drew).
> >
> > < It doesn't have to be rollback safety, either. There may
> > > simply be a hypercall which an operator doesn't want to give its
> > > guests, and it needs a way to tell KVM to hide it.
> >
> > Fair enough. But this has to be done in a scalable way, which
> > individual capability cannot provide.
> >
> > > > > Have I missed something blatantly obvious, or do others see this as an
> > > > > issue as well? I'll reply with an example of adding opt-out for PTP.
> > > > > I'm sure other hypercalls could be handled similarly.
> > > >
> > > > Why do we need this? For future hypercalls, we could have some buy-in
> > > > capabilities. For existing ones, it is too late, and negative features
> > > > are just too horrible.
> > >
> > > Oh, agreed on the nastiness. Lazy hack to realize the intended
> > > functional change..
> >
> > Well, you definitely achieved your goal of attracting my attention :).
> >
> > > > For KVM-specific hypercalls, we could get the VMM to save/restore the
> > > > bitmap of supported functions. That would be "less horrible". This
> > > > could be implemented using extra "firmware pseudo-registers" such as
> > > > the ones described in Documentation/virt/kvm/arm/psci.rst.
> > >
> > > This seems more reasonable, especially since we do this for migrating
> > > the guest's PSCI version.
> > >
> > > Alternatively, I had thought about using a VM attribute, given the
> > > fact that it is non-architectural information and we avoid ABI issues
> > > in KVM_GET_REG_LIST without buy-in through a KVM_CAP.
> >
> > The whole point is that these settings get exposed by
> > KVM_GET_REG_LIST, as this is QEMU's way to dump a VM state. Given that
> > we already have this for things like the spectre management state, we
> > can just as well expose the bitmaps that deal with the KVM-specific
> > hypercalls. After all, this falls into the realm of "KVM as VM
> > firmware".
> >
> > For ARM-architected hypercalls (TRNG, stolen time), we may need a
> > similar extension.
> >
>
> Thanks for including me Marc. I think you've mentioned all the examples
> of why we don't generally expect N+1 -> N migrations to work that I
> can think of. While some of the examples like get-reg-list could
> eventually be eliminated if we had CPU models to tighten our machine type
> state, I think N+1 -> N migrations will always be best effort at most.
>
> I agree with giving userspace control over the exposer of the hypercalls
> though. Using pseudo-registers for that purpose rather than a pile of
> CAPs also seems reasonable to me.
>
> And, while I don't think this patch is going to proceed, I thought I'd
> point out that the opt-out approach doesn't help much with expanding
> our migration support unless we require the VMM to be upgraded first.
>
> And, even then, the (N_kern, N+1_vmm) -> (N+1_kern, N_vmm) case won't
> work as expected, since the source enforce opt-out, but the destination
> won't.

Right, there's going to need to be a fence in both kernel and VMM
versions. Before the fence, you can't rollback with either component.
Once on the other side of the fence, the user may freely migrate
between kernel + VMM combinations.

> Also, since the VMM doesn't key off the kernel version, for the
> most part N+1 VMMs won't know when they're supposed to opt-out or not,
> leaving it to the user to ensure they consider everything. opt-in
> usually only needs the user to consider what machine type they want to
> launch.

Going the register route will implicitly require opt-out for all old
hypercalls. We exposed them unconditionally to the guest before, and
we must uphold that behavior. The default value for the bitmap will
have those features set. Any hypercalls added after that register
interface will then require explicit opt-in from userspace.

With regards to the pseudoregister interface, how would a VMM discover
new bits? From my perspective, you need to have two bitmaps that the
VMM can get at: the set of supported feature bits and the active
bitmap of features for a running guest.

> Thanks,
> drew
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
