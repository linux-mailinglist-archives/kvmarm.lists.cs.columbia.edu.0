Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA055B960
	for <lists+kvmarm@lfdr.de>; Mon, 27 Jun 2022 13:43:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AA5A41014;
	Mon, 27 Jun 2022 07:43:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id afnMc2RgyCuS; Mon, 27 Jun 2022 07:43:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BFEFE40BFA;
	Mon, 27 Jun 2022 07:43:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B81640BEE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jun 2022 07:43:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ah3E70edpD6N for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Jun 2022 07:43:15 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2DAEB40B92
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Jun 2022 07:43:15 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1AD61192;
 Mon, 27 Jun 2022 11:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD194C3411D;
 Mon, 27 Jun 2022 11:43:11 +0000 (UTC)
Date: Mon, 27 Jun 2022 12:43:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] KVM: arm64: permit MAP_SHARED mappings with MTE enabled
Message-ID: <YrmXzHXv4babwbNZ@arm.com>
References: <20220623234944.141869-1-pcc@google.com> <YrXu0Uzi73pUDwye@arm.com>
 <CAMn1gO7-qVzZrAt63BJC-M8gKLw4=60iVUo6Eu8T_5y3AZnKcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMn1gO7-qVzZrAt63BJC-M8gKLw4=60iVUo6Eu8T_5y3AZnKcA@mail.gmail.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Evgenii Stepanov <eugenis@google.com>,
 Michael Roth <michael.roth@amd.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jun 24, 2022 at 02:50:53PM -0700, Peter Collingbourne wrote:
> On Fri, Jun 24, 2022 at 10:05 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > + Steven as he added the KVM and swap support for MTE.
> >
> > On Thu, Jun 23, 2022 at 04:49:44PM -0700, Peter Collingbourne wrote:
> > > Certain VMMs such as crosvm have features (e.g. sandboxing, pmem) that
> > > depend on being able to map guest memory as MAP_SHARED. The current
> > > restriction on sharing MAP_SHARED pages with the guest is preventing
> > > the use of those features with MTE. Therefore, remove this restriction.
> >
> > We already have some corner cases where the PG_mte_tagged logic fails
> > even for MAP_PRIVATE (but page shared with CoW). Adding this on top for
> > KVM MAP_SHARED will potentially make things worse (or hard to reason
> > about; for example the VMM sets PROT_MTE as well). I'm more inclined to
> > get rid of PG_mte_tagged altogether, always zero (or restore) the tags
> > on user page allocation, copy them on write. For swap we can scan and if
> > all tags are 0 and just skip saving them.
> 
> A problem with this approach is that it would conflict with any
> potential future changes that we might make that would require the
> kernel to avoid modifying the tags for non-PROT_MTE pages.

Not if in all those cases we check VM_MTE_ALLOWED. We seem to have the
vma available where it matters. We can keep PG_mte_tagged around but
always set it on page allocation (e.g. when zeroing or CoW) and check
VM_MTE_ALLOWED rather than VM_MTE.

I'm not sure how Linux can deal with pages that do not support MTE.
Currently we only handle this at the vm_flags level. Assuming that we
somehow manage to, we can still use PG_mte_tagged to mark the pages that
supported tags on allocation (and they have been zeroed or copied). I
guess if you want to move a page around, you'd need to go through
something like try_to_unmap() (or set all mappings to PROT_NONE like in
NUMA migration). Then you can either check whether the page is PROT_MTE
anywhere and maybe read the tags to see whether all are zero after
unmapping.

Deferring tag zeroing/restoring to set_pte_at() can be racy without a
lock (or your approach with another flag) but I'm not sure it's worth
the extra logic if zeroing or copying the tags doesn't have a
significant overhead for non-PROT_MTE pages.

Another issue with set_pte_at() is that it can write tags on mprotect()
even if the page is mapped read-only. So far I couldn't find a problem
with this but it adds to the complexity.

> Thinking about this some more, another idea that I had was to only
> allow MAP_SHARED mappings in a guest with MTE enabled if the mapping
> is PROT_MTE and there are no non-PROT_MTE aliases. For anonymous
> mappings I don't think it's possible to create a non-PROT_MTE alias in
> another mm (since you can't turn off PROT_MTE with mprotect), and for
> memfd maybe we could introduce a flag that requires PROT_MTE on all
> mappings. That way, we are guaranteed that either the page has been
> tagged prior to fault or we have exclusive access to it so it can be
> tagged on demand without racing. Let me see what effect that has on
> crosvm.

You could still have all initial shared mappings as !PROT_MTE and some
mprotect() afterwards setting PG_mte_tagged and clearing the tags and
this can race. AFAICT, the easiest way to avoid the race is to set
PG_mte_tagged on allocation before it ends up in set_pte_at().

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
