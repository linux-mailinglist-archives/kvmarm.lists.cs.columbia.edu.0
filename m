Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 278005E7CBE
	for <lists+kvmarm@lfdr.de>; Fri, 23 Sep 2022 16:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16465410F1;
	Fri, 23 Sep 2022 10:20:12 -0400 (EDT)
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
	with ESMTP id pdhIdUbpOhqY; Fri, 23 Sep 2022 10:20:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BEBEC40BEF;
	Fri, 23 Sep 2022 10:20:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 48EC440B59
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:20:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWvacfLQhM+y for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Sep 2022 10:20:07 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D33D840AFA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Sep 2022 10:20:07 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 14D1D620FA;
 Fri, 23 Sep 2022 14:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D06BC433C1;
 Fri, 23 Sep 2022 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663942806;
 bh=Kq7emLhwvdneoJtvmozd3OskIe6mAMMxre7Z0MxN+rM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iHoB0JQ3Wn3YayXCXt9oZO83b52P+7kufQ1Slo7/Je6Ne/JeorY48wL9gg7iEqfL6
 OHYafCnErG69xotp3dZpZcLYoYpVBKCKusAAsmEBklpnyDAIMYpS+JQm6nQoGCmIph
 6+v/BEgPQO20dwfLMwT6TXJy08ZStnxCRRKurMwRpHHRd3CesCOGSx+kqheLOAPgYz
 9xJuA/kNd9Nb6N6VIuKgUhAibwROS5ozSepzFY8pFHbIJgZ/yZ7e9iR4SIQB37rJyx
 gQObLZw7NRpUzTMJasFeCfc2Fto+MGLGXsiGtsNlJogVG5zyzoJgNCtxJkIOuJk8ta
 gePTQk7N4Pb8A==
Received: from [82.141.251.28] (helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1objXA-00CAht-2K;
 Fri, 23 Sep 2022 15:20:04 +0100
Date: Fri, 23 Sep 2022 15:19:56 +0100
Message-ID: <87edw2jhpv.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/6] KVM: Use acquire/release semantics when accessing
 dirty ring GFN state
In-Reply-To: <YyzV2Q/PZHPFMD6y@xz-m1.local>
References: <20220922170133.2617189-1-maz@kernel.org>
 <20220922170133.2617189-2-maz@kernel.org>
 <YyzV2Q/PZHPFMD6y@xz-m1.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 82.141.251.28
X-SA-Exim-Rcpt-To: peterx@redhat.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, catalin.marinas@arm.com, bgardon@google.com,
 shuah@kernel.org, andrew.jones@linux.dev, will@kernel.org, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shan.gavin@gmail.com,
 gshan@redhat.com, james.morse@arm.com, suzuki.poulose@arm.com,
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

On Thu, 22 Sep 2022 22:38:33 +0100,
Peter Xu <peterx@redhat.com> wrote:
> 
> Marc,
> 
> On Thu, Sep 22, 2022 at 06:01:28PM +0100, Marc Zyngier wrote:
> > The current implementation of the dirty ring has an implicit requirement
> > that stores to the dirty ring from userspace must be:
> > 
> > - be ordered with one another
> > 
> > - visible from another CPU executing a ring reset
> > 
> > While these implicit requirements work well for x86 (and any other
> > TSO-like architecture), they do not work for more relaxed architectures
> > such as arm64 where stores to different addresses can be freely
> > reordered, and loads from these addresses not observing writes from
> > another CPU unless the required barriers (or acquire/release semantics)
> > are used.
> > 
> > In order to start fixing this, upgrade the ring reset accesses:
> > 
> > - the kvm_dirty_gfn_harvested() helper now uses acquire semantics
> >   so it is ordered after all previous writes, including that from
> >   userspace
> > 
> > - the kvm_dirty_gfn_set_invalid() helper now uses release semantics
> >   so that the next_slot and next_offset reads don't drift past
> >   the entry invalidation
> > 
> > This is only a partial fix as the userspace side also need upgrading.
> 
> Paolo has one fix 4802bf910e ("KVM: dirty ring: add missing memory
> barrier", 2022-09-01) which has already landed.

What is this commit? It doesn't exist in the kernel as far as I can see.

> 
> I think the other one to reset it was lost too.  I just posted a patch.
> 
> https://lore.kernel.org/qemu-devel/20220922213522.68861-1-peterx@redhat.com/
> (link still not yet available so far, but should be)

That's a QEMU patch, right?

> 
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  virt/kvm/dirty_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> > index f4c2a6eb1666..784bed80221d 100644
> > --- a/virt/kvm/dirty_ring.c
> > +++ b/virt/kvm/dirty_ring.c
> > @@ -79,12 +79,12 @@ static inline void kvm_dirty_gfn_set_invalid(struct kvm_dirty_gfn *gfn)
> >  
> >  static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
> >  {
> > -	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
> > +	smp_store_release(&gfn->flags, KVM_DIRTY_GFN_F_DIRTY);
> 
> IIUC you meant kvm_dirty_gfn_set_invalid as the comment says?

Gah, you're right, I redid the patch at the last minute and messed it
up....

> kvm_dirty_gfn_set_dirtied() has been guarded by smp_wmb() and AFAICT that's
> already safe.  Otherwise looks good to me.

Indeed. Let me fix this.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
