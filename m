Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5E61EEAE
	for <lists+kvmarm@lfdr.de>; Mon,  7 Nov 2022 10:21:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA30C4B8A6;
	Mon,  7 Nov 2022 04:21:50 -0500 (EST)
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
	with ESMTP id VDgwI43UrGVq; Mon,  7 Nov 2022 04:21:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EF144B8A4;
	Mon,  7 Nov 2022 04:21:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 940894B868
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 04:21:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2FRuUvTyyc5 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Nov 2022 04:21:46 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A62B34B866
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 04:21:45 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id C942DCE10F9;
 Mon,  7 Nov 2022 09:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D70AC433C1;
 Mon,  7 Nov 2022 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667812898;
 bh=Qg31ejv/r9mPj2NkbcR5VRKWxl4krVjVLbPtDxF3eb4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nrgOMUZbrd5cLsvbvqLVbqO1ZPQff1dS/kTVYGmLfWIdb/qygRHwyGw7ZHYfSAQVr
 515MAnFA1PWwDOPF+hv+KUVaOxKWQHHuW+vpPZBfIKG6uJkiSdPc8cvgaIBnQ2zoi0
 kN+NGRMlhT3fx/M24WHdFvQrbjmlGb0/owtSgFUKN6yG5tssV5b8tAwDzgL5Xway3Y
 pyFdMaZeMNkDp1rkXa2vQDqYj7qbKPfuArOFgs/9PcpT4Q3/QAuU5nywwD6Xb8KMFI
 1yqJI4zwJiUu1GXQ0Uycz23xnDAULPIow3SH7L0JFWuduKdQWLLSR1uC6kJ2E9wvUg
 IBTZCcM6vXufg==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oryK0-004LaN-3M;
 Mon, 07 Nov 2022 09:21:36 +0000
Date: Mon, 07 Nov 2022 09:21:35 +0000
Message-ID: <867d07qfvk.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v8 3/7] KVM: Support dirty ring in conjunction with bitmap
In-Reply-To: <Y2gh4x4MD8BJvogH@x1n>
References: <20221104234049.25103-1-gshan@redhat.com>
 <20221104234049.25103-4-gshan@redhat.com>
 <87o7tkf5re.wl-maz@kernel.org> <Y2ffRYoqlQOxgVtk@x1n>
 <87iljrg7vd.wl-maz@kernel.org> <Y2gh4x4MD8BJvogH@x1n>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: peterx@redhat.com, gshan@redhat.com, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, shuah@kernel.org,
 catalin.marinas@arm.com, andrew.jones@linux.dev, ajones@ventanamicro.com,
 bgardon@google.com, dmatlack@google.com, will@kernel.org,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, pbonzini@redhat.com,
 seanjc@google.com, oliver.upton@linux.dev, zhenyzha@redhat.com,
 shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com, bgardon@google.com,
 kvmarm@lists.linux.dev, pbonzini@redhat.com, zhenyzha@redhat.com,
 shuah@kernel.org, kvmarm@lists.cs.columbia.edu, ajones@ventanamicro.com
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

On Sun, 06 Nov 2022 21:06:43 +0000,
Peter Xu <peterx@redhat.com> wrote:
> 
> On Sun, Nov 06, 2022 at 08:12:22PM +0000, Marc Zyngier wrote:
> > Hi Peter,
> > 
> > On Sun, 06 Nov 2022 16:22:29 +0000,
> > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > Hi, Marc,
> > > 
> > > On Sun, Nov 06, 2022 at 03:43:17PM +0000, Marc Zyngier wrote:
> > > > > +Note that the bitmap here is only a backup of the ring structure, and
> > > > > +normally should only contain a very small amount of dirty pages, which
> > > > 
> > > > I don't think we can claim this. It is whatever amount of memory is
> > > > dirtied outside of a vcpu context, and we shouldn't make any claim
> > > > regarding the number of dirty pages.
> > > 
> > > The thing is the current with-bitmap design assumes that the two logs are
> > > collected in different windows of migration, while the dirty log is only
> > > collected after the VM is stopped.  So collecting dirty bitmap and sending
> > > the dirty pages within the bitmap will be part of the VM downtime.
> > > 
> > > It will stop to make sense if the dirty bitmap can contain a large portion
> > > of the guest memory, because then it'll be simpler to just stop the VM,
> > > transfer pages, and restart on dest node without any tracking mechanism.
> > 
> > Oh, I absolutely agree that the whole vcpu dirty ring makes zero sense
> > in general. It only makes sense if the source of the dirty pages is
> > limited to the vcpus, which is literally a corner case. Look at any
> > real machine, and you'll quickly realise that this isn't the case, and
> > that DMA *is* a huge source of dirty pages.
> > 
> > Here, we're just lucky enough not to have much DMA tracking yet. Once
> > that happens (and I have it from people doing the actual work that it
> > *is* happening), you'll realise that the dirty ring story is of very
> > limited use. So I'd rather drop anything quantitative here, as this is
> > likely to be wrong.
> 
> Is it a must that arm64 needs to track device DMAs using the same dirty
> tracking interface rather than VFIO or any other interface?

What does it change? At the end of the day, you want a list of dirty
pages. How you obtain it is irrelevant.

> It's
> definitely not the case for x86, but if it's true for arm64, then could the
> DMA be spread across all the guest pages?  If it's also true, I really
> don't know how this will work..

Of course, all pages can be the target of DMA. It works the same way
it works for the ITS: you sync the state, you obtain the dirty bits,
you move on.

And mimicking what x86 does is really not my concern (if you still
think that arm64 is just another flavour of x86, stay tuned!  ;-).

> 
> We're only syncing the dirty bitmap once right now with the protocol.  If
> that can cover most of the guest mem, it's same as non-live.  If we sync it
> periodically, then it's the same as enabling dirty-log alone and the rings
> are useless.

I'm glad that you finally accept it: the ring *ARE* useless in the
general sense. Only limited, CPU-only workloads can make any use of
the current design. This probably covers a large proportion of what
the cloud vendors do, but this doesn't work for general situations
where you have a stream of dirty pages originating outside of the
CPUs.

[...]

> > > I wanted to make it clear that we don't need CLEAR_LOG at all in this case,
> > > as fundamentally clear log is about re-protect the guest pages, but if
> > > we're with the restriction of above (having the dirty bmap the last to
> > > collect and once and for all) then it'll make no sense to protect the guest
> > > page at all at this stage since src host shouldn't run after the GET_LOG
> > > then the CLEAR_LOG will be a vain effort.
> > 
> > That's not for you to decide, but userspace. I can perfectly expect
> > userspace saving an ITS, getting the bitmap, saving the pages and then
> > *clearing the log* before processing the next ITS. Or anything else.
> 
> I think I can get your point on why you're not happy with the document, but
> IMHO how we document is one thing, how it'll work is another.  I preferred
> explicit documentation because it'll help the app developer to support the
> interface, also more docs to reference in the future; no strong opinion,
> though.

Here's my beef with the current documentation: it sets quantitative
expectations. This is wrong. It also introduces undefined behaviours
where there should be none. This is even worse, because there
shouldn't be *any* undefined behaviour today, and I cannot see why the
dirty rings would influence this.

> However if there's fundamental statement that was literally wrong, then
> it's another thing, and we may need to rethink.

See above. If the undefined behaviour was just a mistake, let's drop
it and move on. If you have spotted something that is indeed an
undefined behaviour in using CLEAR_LOG when the VM is stopped, then
live migration is already broken on arm64 *today*.

And if that's the case, we should fix it now instead of adding the
dirty ring stuff.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
