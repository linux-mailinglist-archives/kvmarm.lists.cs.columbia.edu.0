Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73AEF3328BA
	for <lists+kvmarm@lfdr.de>; Tue,  9 Mar 2021 15:38:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 081FE4B477;
	Tue,  9 Mar 2021 09:38:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PY9YD+Fl7OUV; Tue,  9 Mar 2021 09:38:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A6134B46F;
	Tue,  9 Mar 2021 09:38:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5E9E4B45A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 09:38:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m+PkzXETH-g2 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 09:38:49 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 873614B44F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 09:38:49 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90F0464EEE;
 Tue,  9 Mar 2021 14:38:45 +0000 (UTC)
Date: Tue, 9 Mar 2021 14:38:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ensure I-cache isolation between vcpus of a
 same VM
Message-ID: <20210309143841.GA32754@arm.com>
References: <20210303164505.68492-1-maz@kernel.org>
 <20210309132645.GA28297@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309132645.GA28297@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, kernel-team@android.com,
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

On Tue, Mar 09, 2021 at 01:26:46PM +0000, Will Deacon wrote:
> On Wed, Mar 03, 2021 at 04:45:05PM +0000, Marc Zyngier wrote:
> > It recently became apparent that the ARMv8 architecture has interesting
> > rules regarding attributes being used when fetching instructions
> > if the MMU is off at Stage-1.
> > 
> > In this situation, the CPU is allowed to fetch from the PoC and
> > allocate into the I-cache (unless the memory is mapped with
> > the XN attribute at Stage-2).
> > 
> > If we transpose this to vcpus sharing a single physical CPU,
> > it is possible for a vcpu running with its MMU off to influence
> > another vcpu running with its MMU on, as the latter is expected to
> > fetch from the PoU (and self-patching code doesn't flush below that
> > level).
> > 
> > In order to solve this, reuse the vcpu-private TLB invalidation
> > code to apply the same policy to the I-cache, nuking it every time
> > the vcpu runs on a physical CPU that ran another vcpu of the same
> > VM in the past.
> > 
> > This involve renaming __kvm_tlb_flush_local_vmid() to
> > __kvm_flush_cpu_context(), and inserting a local i-cache invalidation
> > there.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h   | 4 ++--
> >  arch/arm64/kvm/arm.c               | 7 ++++++-
> >  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 6 +++---
> >  arch/arm64/kvm/hyp/nvhe/tlb.c      | 3 ++-
> >  arch/arm64/kvm/hyp/vhe/tlb.c       | 3 ++-
> >  5 files changed, 15 insertions(+), 8 deletions(-)
> 
> Since the FWB discussion doesn't affect the correctness of this patch:
> 
> Acked-by: Will Deacon <will@kernel.org>

I agree. We can optimise it later for FWB.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
