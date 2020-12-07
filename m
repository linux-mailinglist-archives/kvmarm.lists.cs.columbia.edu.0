Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C94E12D0E9D
	for <lists+kvmarm@lfdr.de>; Mon,  7 Dec 2020 12:06:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D5204B28E;
	Mon,  7 Dec 2020 06:06:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OahuwyF8ZEhU; Mon,  7 Dec 2020 06:06:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B58C4B285;
	Mon,  7 Dec 2020 06:06:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3785C4B27C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 06:05:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VUlq+RD8om1 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Dec 2020 06:05:58 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDEFD4B21A
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 06:05:57 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 861F21042;
 Mon,  7 Dec 2020 03:05:57 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.106])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A111C3F66B;
 Mon,  7 Dec 2020 03:05:54 -0800 (PST)
Date: Mon, 7 Dec 2020 11:05:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201207110528.GA18365@C02TD0UTHF1T.local>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
 <X8p5kLSIq2MoQZ24@google.com>
 <20201207102002.GA3825@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207102002.GA3825@willie-the-truck>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Android KVM <android-kvm@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
 kernel-team@android.com,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
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

On Mon, Dec 07, 2020 at 10:20:03AM +0000, Will Deacon wrote:
> On Fri, Dec 04, 2020 at 06:01:52PM +0000, Quentin Perret wrote:
> > On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> > <snip>
> > > > +SYM_FUNC_START(__kvm_init_switch_pgd)
> > > > +       /* Turn the MMU off */
> > > > +       pre_disable_mmu_workaround
> > > > +       mrs     x2, sctlr_el2
> > > > +       bic     x3, x2, #SCTLR_ELx_M
> > > > +       msr     sctlr_el2, x3
> > > > +       isb
> > > > +
> > > > +       tlbi    alle2
> > > > +
> > > > +       /* Install the new pgtables */
> > > > +       ldr     x3, [x0, #NVHE_INIT_PGD_PA]
> > > > +       phys_to_ttbr x4, x3
> > > > +alternative_if ARM64_HAS_CNP
> > > > +       orr     x4, x4, #TTBR_CNP_BIT
> > > > +alternative_else_nop_endif
> > > > +       msr     ttbr0_el2, x4
> > > > +
> > > > +       /* Set the new stack pointer */
> > > > +       ldr     x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> > > > +       mov     sp, x0
> > > > +
> > > > +       /* And turn the MMU back on! */
> > > > +       dsb     nsh
> > > > +       isb
> > > > +       msr     sctlr_el2, x2
> > > > +       isb
> > > > +       ret     x1
> > > > +SYM_FUNC_END(__kvm_init_switch_pgd)
> > > > +
> > > 
> > > Should the instruction cache be flushed here (ic iallu), to discard
> > > speculatively fetched instructions?
> > 
> > Hmm, Will? Thoughts?
> 
> The I-cache is physically tagged, so not sure what invalidation would
> achieve here. Fuad -- what do you think could go wrong specifically?

While the MMU is off, instruction fetches can be made from the PoC
rather than the PoU, so where instructions have been modified/copied and
not cleaned to the PoC, it's possible to fetch stale copies into the
I-caches. The physical tag doesn't prevent that.

In the regular CPU boot paths, __enabble_mmu() has an IC IALLU after
enabling the MMU to ensure that we get rid of anything stale (e.g. so
secondaries don't miss ftrace patching, which is only cleaned to the
PoU).

That might not be a problem here, if things are suitably padded and
never dynamically patched, but if so it's probably worth a comment.

Fuad, is that the sort of thing you were considering, or did you have
additional concerns?

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
