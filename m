Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDD32FB1B
	for <lists+kvmarm@lfdr.de>; Sat,  6 Mar 2021 15:15:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 620444B4BD;
	Sat,  6 Mar 2021 09:15:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8Fh+rmr-R+5; Sat,  6 Mar 2021 09:15:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1967D4B3DA;
	Sat,  6 Mar 2021 09:15:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CBBA4B3BF
 for <kvmarm@lists.cs.columbia.edu>; Sat,  6 Mar 2021 09:15:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SeTA6G5TYM-f for <kvmarm@lists.cs.columbia.edu>;
 Sat,  6 Mar 2021 09:15:56 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 206EB4B3BB
 for <kvmarm@lists.cs.columbia.edu>; Sat,  6 Mar 2021 09:15:56 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 545426501A;
 Sat,  6 Mar 2021 14:15:51 +0000 (UTC)
Date: Sat, 6 Mar 2021 14:15:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ensure I-cache isolation between vcpus of a
 same VM
Message-ID: <20210306141546.GB2932@arm.com>
References: <20210303164505.68492-1-maz@kernel.org>
 <20210305190708.GL23855@arm.com> <877dmksgaw.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877dmksgaw.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
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

On Sat, Mar 06, 2021 at 10:54:47AM +0000, Marc Zyngier wrote:
> On Fri, 05 Mar 2021 19:07:09 +0000,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Wed, Mar 03, 2021 at 04:45:05PM +0000, Marc Zyngier wrote:
> > > It recently became apparent that the ARMv8 architecture has interesting
> > > rules regarding attributes being used when fetching instructions
> > > if the MMU is off at Stage-1.
> > > 
> > > In this situation, the CPU is allowed to fetch from the PoC and
> > > allocate into the I-cache (unless the memory is mapped with
> > > the XN attribute at Stage-2).
> > 
> > Digging through the ARM ARM is hard. Do we have this behaviour with FWB
> > as well?
> 
> The ARM ARM doesn't seem to mention FWB at all when it comes to
> instruction fetch, which is sort of expected as it only covers the
> D-side. I *think* we could sidestep this when CTR_EL0.DIC is set
> though, as the I-side would then snoop the D-side.

Not sure this helps. CTR_EL0.DIC refers to the need for maintenance to
PoU while the SCTLR_EL1.M == 0 causes the I-cache to fetch from PoC. I
don't think I-cache snooping the D-cache would happen to the PoU when
the S1 MMU is off.

My reading of D4.4.4 is that when SCTLR_EL1.M == 0 both I and D accesses
are Normal Non-cacheable with a note in D4.4.6 that Non-cacheable
accesses may be held in the I-cache.

The FWB rules on combining S1 and S2 says that Normal Non-cacheable at
S1 is "upgraded" to cacheable. This should happen irrespective of
whether the S1 MMU is on or off and should apply to both I and D
accesses (since it does not explicitly says). So I think we could skip
this IC IALLU when FWB is present.

The same logic should apply when the VMM copies the VM text. With FWB,
we probably only need D-cache maintenance to PoU and only if
CTR_EL0.IDC==0. I haven't checked what the code currently does.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
