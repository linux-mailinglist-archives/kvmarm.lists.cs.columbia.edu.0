Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 638235E882
	for <lists+kvmarm@lfdr.de>; Wed,  3 Jul 2019 18:14:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC3F04A51F;
	Wed,  3 Jul 2019 12:13:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b2Skag9An91i; Wed,  3 Jul 2019 12:13:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6FA14A4CD;
	Wed,  3 Jul 2019 12:13:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C95444A4CD
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 12:13:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttIng-A9dXnW for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Jul 2019 12:13:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 847384A4A4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 12:13:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB5B344;
 Wed,  3 Jul 2019 09:13:56 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FEE63F718;
 Wed,  3 Jul 2019 09:13:55 -0700 (PDT)
Date: Wed, 3 Jul 2019 17:13:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 02/59] KVM: arm64: Move __load_guest_stage2 to kvm_mmu.h
Message-ID: <20190703161353.GT2790@e103592.cambridge.arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-3-marc.zyngier@arm.com>
 <20190624111924.GK2790@e103592.cambridge.arm.com>
 <bf4e43db-a0ea-9489-1a8c-280a72950cad@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf4e43db-a0ea-9489-1a8c-280a72950cad@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: linux-arm-kernel@lists.infradead.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Wed, Jul 03, 2019 at 10:30:03AM +0100, Marc Zyngier wrote:
> On 24/06/2019 12:19, Dave Martin wrote:
> > On Fri, Jun 21, 2019 at 10:37:46AM +0100, Marc Zyngier wrote:
> >> Having __load_guest_stage2 in kvm_hyp.h is quickly going to trigger
> >> a circular include problem. In order to avoid this, let's move
> >> it to kvm_mmu.h, where it will be a better fit anyway.
> >>
> >> In the process, drop the __hyp_text annotation, which doesn't help
> >> as the function is marked as __always_inline.
> > 
> > Does GCC always inline things marked __always_inline?
> > 
> > I seem to remember some gotchas in this area, but I may be being
> > paranoid.
> 
> Yes, this is a strong guarantee. Things like static keys rely on that,
> for example.
> 
> > 
> > If this still only called from hyp, I'd be tempted to heep the
> > __hyp_text annotation just to be on the safe side.
> 
> The trouble with that is that re-introduces the circular dependency with
> kvm_hyp.h that this patch is trying to break...

Ah, right.

I guess it's easier to put up with this, then.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
