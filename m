Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC92482C0
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 12:16:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D5C6C4C228;
	Tue, 18 Aug 2020 06:16:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lXPR-1gtDEz; Tue, 18 Aug 2020 06:16:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A9C7D4C17A;
	Tue, 18 Aug 2020 06:16:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 705A74C12F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 06:16:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CsmzbBeuJmvU for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 06:16:21 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 523CE4C129
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 06:16:21 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 185FC204EA;
 Tue, 18 Aug 2020 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597745780;
 bh=/aXS48k4VVLZyj2g5TUou/JZYLhZKuGKqZ8NqRnAOyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JojE114Kb5kG8vrbEC/yvbgjUvmlLw6k++Aj5ukEgQaW2NPOOEuytrVnV8O5LzF7u
 OjTuSYe3SSHPG/lCcR3TNypH3uRdLu7KPpkcaKzvgEnyWccuY3qkCgZUffBnDWMR/+
 umN6SkDaPuBgwpJa7FzwinLn9B7yVNVdEMcydLBE=
Date: Tue, 18 Aug 2020 11:16:08 +0100
From: Will Deacon <will@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] KVM: arm64: Fix sleeping while atomic BUG() on OOM
Message-ID: <20200818101607.GB15543@willie-the-truck>
References: <20200811102725.7121-1-will@kernel.org>
 <ff1d4de2-f3f8-eafa-6ba5-3e5bb715ae05@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff1d4de2-f3f8-eafa-6ba5-3e5bb715ae05@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, kvmarm@lists.cs.columbia.edu
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

On Tue, Aug 18, 2020 at 08:31:08AM +0200, Paolo Bonzini wrote:
> On 11/08/20 12:27, Will Deacon wrote:
> > Will Deacon (2):
> >   KVM: Pass MMU notifier range flags to kvm_unmap_hva_range()
> >   KVM: arm64: Only reschedule if MMU_NOTIFIER_RANGE_BLOCKABLE is not set
> > 
> >  arch/arm64/include/asm/kvm_host.h   |  2 +-
> >  arch/arm64/kvm/mmu.c                | 19 ++++++++++++++-----
> >  arch/mips/include/asm/kvm_host.h    |  2 +-
> >  arch/mips/kvm/mmu.c                 |  3 ++-
> >  arch/powerpc/include/asm/kvm_host.h |  3 ++-
> >  arch/powerpc/kvm/book3s.c           |  3 ++-
> >  arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
> >  arch/x86/include/asm/kvm_host.h     |  3 ++-
> >  arch/x86/kvm/mmu/mmu.c              |  3 ++-
> >  virt/kvm/kvm_main.c                 |  3 ++-
> >  10 files changed, 30 insertions(+), 14 deletions(-)
> > 
> 
> These would be okay for 5.9 too, so I plan to queue them myself before
> we fork for 5.10.

Thanks, Paolo. Let me know if you want me to rebase/repost.

Please note that I'm planning on rewriting most of the arm64 KVM page-table
code for 5.10, so if you can get this series in early (e.g. for -rc2), then
it would _really_ help with managing the kvm/arm64 queue for the next merge
window.

Otherwise, could you and Marc please set up a shared branch with just these,
so I can use it as a base?

Please let me know.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
