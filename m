Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 924425A0314
	for <lists+kvmarm@lfdr.de>; Wed, 24 Aug 2022 22:57:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EB254D9F9;
	Wed, 24 Aug 2022 16:57:23 -0400 (EDT)
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
	with ESMTP id KKhIkfjiZUna; Wed, 24 Aug 2022 16:57:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D6584D9D6;
	Wed, 24 Aug 2022 16:57:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A89E64D9C4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 16:57:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id df+0tZ91c-lP for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Aug 2022 16:57:19 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 451B04D9C5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Aug 2022 16:57:19 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C0249B826B7;
 Wed, 24 Aug 2022 20:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E5C433D6;
 Wed, 24 Aug 2022 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661374636;
 bh=qM0hODjskpwb8x7NIPhJ6OvYS94mu8gyRtyJsdL5qbc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WKWbhn9ebHbZ2iDprTkgAxT0HGOGVyijsRF2LE8IUHP7lZK/KRbPBixXcC6IMyQ/o
 IiWahFF8wh+Of+babvKKdHCxBt/nrCu30JKP94TZkTDUprcFCLN1dYa3XtehR+fmHA
 /S4DR1i/6njbLlr/PyQRJ1eiA/dkz6Z808gZSZyGwoMyWwm42hAnE1rhEEl1NP9CIL
 Tnou1IeIhBIzmu3HtFyRuEvTbxEg1PIaM6UzVthy3jp6ROfmJRpTSFQHGS7aDEYA3k
 gEVg14UNCy9692EJv7aPsTsvuPiawl/cUTzj46qSd6xFAT71gXhD8QGNy9tXKAgTJd
 zVlmsMZSUyZwg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oQxR4-005Wpl-4q;
 Wed, 24 Aug 2022 21:57:14 +0100
Date: Wed, 24 Aug 2022 21:57:13 +0100
Message-ID: <877d2xweae.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory tracking
In-Reply-To: <YwZQHqS5DZBloYPZ@xz-m1.local>
References: <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
 <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
 <YwTc++Lz6lh3aR4F@xz-m1.local> <87bksawz0w.wl-maz@kernel.org>
 <YwVEoM1pj2MPCELp@xz-m1.local> <878rnewpaw.wl-maz@kernel.org>
 <YwVgaGp3HOGzC8k2@xz-m1.local> <87y1vdr98o.wl-maz@kernel.org>
 <YwZQHqS5DZBloYPZ@xz-m1.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: peterx@redhat.com, gshan@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 oliver.upton@linux.dev, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, seanjc@google.com, dmatlack@google.com, bgardon@google.com,
 ricarkol@google.com, zhenyzha@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, catalin.marinas@arm.com,
 linux-kselftest@vger.kernel.org, bgardon@google.com, shuah@kernel.org,
 kvmarm@lists.cs.columbia.edu, corbet@lwn.net, will@kernel.org,
 shan.gavin@gmail.com, zhenyzha@redhat.com, dmatlack@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pbonzini@redhat.com
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

On Wed, 24 Aug 2022 17:21:50 +0100,
Peter Xu <peterx@redhat.com> wrote:
> 
> On Wed, Aug 24, 2022 at 03:45:11PM +0100, Marc Zyngier wrote:
> > On Wed, 24 Aug 2022 00:19:04 +0100,
> > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > On Tue, Aug 23, 2022 at 11:47:03PM +0100, Marc Zyngier wrote:
> > > > Atomicity doesn't guarantee ordering, unfortunately.
> > > 
> > > Right, sorry to be misleading.  The "atomicity" part I was trying to say
> > > the kernel will always see consistent update on the fields.
> > >
> > > The ordering should also be guaranteed, because things must happen with
> > > below sequence:
> > > 
> > >   (1) kernel publish dirty GFN data (slot, offset)
> > >   (2) kernel publish dirty GFN flag (set to DIRTY)
> > >   (3) user sees DIRTY, collects (slots, offset)
> > >   (4) user sets it to RESET
> > >   (5) kernel reads RESET
> > 
> > Maybe. Maybe not. The reset could well be sitting in the CPU write
> > buffer for as long as it wants and not be seen by the kernel if the
> > read occurs on another CPU. And that's the crucial bit: single-CPU is
> > fine, but cross CPU isn't. Unfortunately, the userspace API is per-CPU
> > on collection, and global on reset (this seems like a bad decision,
> > but it is too late to fix this).
> 
> Regarding the last statement, that's something I had question too and
> discussed with Paolo, even though at that time it's not a outcome of
> discussing memory ordering issues.
> 
> IIUC the initial design was trying to avoid tlb flush flood when vcpu
> number is large (each RESET per ring even for one page will need all vcpus
> to flush, so O(N^2) flushing needed). With global RESET it's O(N).  So
> it's kind of a trade-off, and indeed until now I'm not sure which one is
> better.  E.g., with per-ring reset, we can have locality too in userspace,
> e.g. the vcpu thread might be able to recycle without holding global locks.

I don't get that. On x86, each CPU must perform the TLB invalidation
(there is an IPI for that). So whether you do a per-CPU scan of the
ring or a global scan is irrelevant: each entry you find in any of the
rings must result in a global invalidation, since you've updated the
PTE to make the page RO.

The same is true on ARM, except that the broadcast is done in HW
instead of being tracked in SW.

Buy anyway, this is all moot. The API is what it is, and it isn't
going to change any time soon. All we can do is add some
clarifications to the API for the more relaxed architectures, and make
sure the kernel behaves accordingly.

[...]

> > It may be safe, but it isn't what the userspace API promises.
> 
> The document says:
> 
>   After processing one or more entries in the ring buffer, userspace calls
>   the VM ioctl KVM_RESET_DIRTY_RINGS to notify the kernel about it, so that
>   the kernel will reprotect those collected GFNs.  Therefore, the ioctl
>   must be called *before* reading the content of the dirty pages.
> 
> I'd say it's not an explicit promise, but I think I agree with you that at
> least it's unclear on the behavior.

This is the least problematic part of the documentation. The bit I
literally choke on is this:

<quote>
It's not necessary for userspace to harvest the all dirty GFNs at once.
However it must collect the dirty GFNs in sequence, i.e., the userspace
program cannot skip one dirty GFN to collect the one next to it.
</quote>

This is the core of the issue. Without ordering rules, the consumer on
the other side cannot observe the updates correctly, even if userspace
follows the above to the letter. Of course, the kernel itself must do
the right thing (I guess it amounts to the kernel doing a
load-acquire, and userspace doing a store-release -- effectively
emulating x86...).

> Since we have a global recycle mechanism, most likely the app (e.g. current
> qemu impl) will use the same thread to collect/reset dirty GFNs, and
> trigger the RESET ioctl().  In that case it's safe, IIUC, because no
> cross-core ops.
> 
> QEMU even guarantees this by checking it (kvm_dirty_ring_reap_locked):
> 
>     if (total) {
>         ret = kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
>         assert(ret == total);
>     }
> 
> I think the assert() should never trigger as mentioned above.  But ideally
> maybe it should just be a loop until cleared gfns match total.

Right. If userspace calls the ioctl on every vcpu, then things should
work correctly. It is only that the overhead is higher than what it
should be if multiple vcpus perform a reset at the same time.

>
> > In other words, without further straightening of the API, this doesn't
> > work as expected on relaxed memory architectures. So before this gets
> > enabled on arm64, this whole ordering issue must be addressed.
> 
> How about adding some more documentation for KVM_RESET_DIRTY_RINGS on the
> possibility of recycling partial of the pages, especially when collection
> and the ioctl() aren't done from the same thread?

I'd rather tell people about the ordering rules. That will come at
zero cost on x86.

> Any suggestions will be greatly welcomed.

I'll write a couple of patch when I get the time, most likely next
week. Gavin will hopefully be able to take them as part of his series.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
