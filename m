Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 090845E7D5A
	for <lists+kvmarm@lfdr.de>; Fri, 23 Sep 2022 16:40:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40414411D3;
	Fri, 23 Sep 2022 10:40:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SsYouCR9LnKK; Fri, 23 Sep 2022 10:40:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA72A41071;
	Fri, 23 Sep 2022 10:40:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BEF8740C67
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:40:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sji+Dj-cbofQ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Sep 2022 10:40:14 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5177740BED
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:40:14 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 59FE561283;
 Fri, 23 Sep 2022 14:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE4C433C1;
 Fri, 23 Sep 2022 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663944012;
 bh=gOZt6EdKTGQu484brR9cfVMExtN+VmOyzXOZDkQMNsQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YnwKxoPmZiijD8emTiRrYTvk696Pv84HkovY65PXuRYbaDvHuh//YqdwWIV4zzp7+
 c/M0nviKKy8hT6//DhVkuJ8nZRwoSXz8vVPkDRGjgXsxtH1R8GedaovvOcPFzW3Fle
 TvKa9jTRLKHjWU48uLzFwyr9PjosF56CC7ykg2ZZKu61T/iiiWN64SsR3ZhNRSrHAc
 eNavEQhkaZZ5BmWALIY7qK+wSGZz8HhhEWxaLpey9T4vHxf0lLeNPGUUmlu87vpeM6
 Lo5envUt23EhNWM4LrH6tFYOsTP3nZS4a+EXjR5+/1YVgLYLy9EGXuh04ljDl5b1qs
 igelRpKOba3Fg==
Received: from [82.141.251.28] (helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1objqc-00CAwM-HI;
 Fri, 23 Sep 2022 15:40:10 +0100
Date: Fri, 23 Sep 2022 15:40:07 +0100
Message-ID: <87bkr6jgs8.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/6] KVM: Use acquire/release semantics when accessing
 dirty ring GFN state
In-Reply-To: <e8ddf130-c5e1-d872-c7c8-675d40742b1e@redhat.com>
References: <20220922170133.2617189-1-maz@kernel.org>
 <20220922170133.2617189-2-maz@kernel.org>
 <YyzV2Q/PZHPFMD6y@xz-m1.local>
 <e8ddf130-c5e1-d872-c7c8-675d40742b1e@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 82.141.251.28
X-SA-Exim-Rcpt-To: gshan@redhat.com, peterx@redhat.com,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, catalin.marinas@arm.com,
 bgardon@google.com, shuah@kernel.org, andrew.jones@linux.dev, will@kernel.org,
 dmatlack@google.com, pbonzini@redhat.com, zhenyzha@redhat.com,
 shan.gavin@gmail.com, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, oliver.upton@linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 will@kernel.org, shan.gavin@gmail.com, bgardon@google.com, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shuah@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

On Fri, 23 Sep 2022 00:46:58 +0100,
Gavin Shan <gshan@redhat.com> wrote:
> 
> Hi Peter,
> 
> On 9/23/22 7:38 AM, Peter Xu wrote:
> > On Thu, Sep 22, 2022 at 06:01:28PM +0100, Marc Zyngier wrote:
> >> The current implementation of the dirty ring has an implicit requirement
> >> that stores to the dirty ring from userspace must be:
> >> 
> >> - be ordered with one another
> >> 
> >> - visible from another CPU executing a ring reset
> >> 
> >> While these implicit requirements work well for x86 (and any other
> >> TSO-like architecture), they do not work for more relaxed architectures
> >> such as arm64 where stores to different addresses can be freely
> >> reordered, and loads from these addresses not observing writes from
> >> another CPU unless the required barriers (or acquire/release semantics)
> >> are used.
> >> 
> >> In order to start fixing this, upgrade the ring reset accesses:
> >> 
> >> - the kvm_dirty_gfn_harvested() helper now uses acquire semantics
> >>    so it is ordered after all previous writes, including that from
> >>    userspace
> >> 
> >> - the kvm_dirty_gfn_set_invalid() helper now uses release semantics
> >>    so that the next_slot and next_offset reads don't drift past
> >>    the entry invalidation
> >> 
> >> This is only a partial fix as the userspace side also need upgrading.
> > 
> > Paolo has one fix 4802bf910e ("KVM: dirty ring: add missing memory
> > barrier", 2022-09-01) which has already landed.
> > 
> > I think the other one to reset it was lost too.  I just posted a patch.
> > 
> > https://lore.kernel.org/qemu-devel/20220922213522.68861-1-peterx@redhat.com/
> > (link still not yet available so far, but should be)
> > 
> >> 
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> ---
> >>   virt/kvm/dirty_ring.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> >> index f4c2a6eb1666..784bed80221d 100644
> >> --- a/virt/kvm/dirty_ring.c
> >> +++ b/virt/kvm/dirty_ring.c
> >> @@ -79,12 +79,12 @@ static inline void kvm_dirty_gfn_set_invalid(struct kvm_dirty_gfn *gfn)
> >>     static inline void kvm_dirty_gfn_set_dirtied(struct
> >> kvm_dirty_gfn *gfn)
> >>   {
> >> -	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
> >> +	smp_store_release(&gfn->flags, KVM_DIRTY_GFN_F_DIRTY);
> > 
> > IIUC you meant kvm_dirty_gfn_set_invalid as the comment says?
> > 
> > kvm_dirty_gfn_set_dirtied() has been guarded by smp_wmb() and AFAICT that's
> > already safe.  Otherwise looks good to me.
> > 
> 
> If I'm understanding the full context, smp_store_release() also
> enforces guard on 'gfn->flags' itself. It is needed by user space
> for the synchronization.

There are multiple things at play here:

- userspace needs a store-release when making the flags 'harvested',
  so that the kernel using a load-acquire can observe this write (and
  avoid the roach-motel effect of a non-acquire load)

- the kernel needs a store-release when making the flags 'invalid',
  preventing this write from occuring before the next_* fields have
  been sampled

On the ring production side, there is a heavy handed smp_wmb(), which
makes things pretty safe.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
