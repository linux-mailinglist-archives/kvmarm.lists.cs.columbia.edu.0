Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 06D856427FB
	for <lists+kvmarm@lfdr.de>; Mon,  5 Dec 2022 13:05:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 246714B2A1;
	Mon,  5 Dec 2022 07:05:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eEN-475hRFKw; Mon,  5 Dec 2022 07:05:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F74F4A0D6;
	Mon,  5 Dec 2022 07:05:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 87355404FD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Dec 2022 07:05:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vlVUxIBv0ja0 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  5 Dec 2022 07:05:38 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 32355403AD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Dec 2022 07:05:38 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9D70E61010;
 Mon,  5 Dec 2022 12:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE59C433C1;
 Mon,  5 Dec 2022 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670241936;
 bh=1fHArnZdHtBDYttToSuRg+u55hOMMtxuZQLQ3ikbPio=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qhpUXPMEEIJYEcXaromx2gKrxznuRTOJlurRkMrHHa44MTPNLIVBWFx95T8S9l7bK
 1v0+8PmCqmxGVJSOnQyia3TjYIGBUMp1wFL3NRodYHDYUj6+eWIyZHCijCXREHdvcb
 0tJo7lnd2vM+X/x5yQi5LeW72G10n4heMf2SSioSSEzWUUbLlEsI7B8puY6rOVYOCd
 LT9M7MGEMMbakuPIS6sKhn6FaEt22625wpkjXAcqvHIlecFrqTfTnGFH9D/SrY9cK/
 m/xYhXhGdWXOxBvmDjCHIcfaMW0J2fYIMWa0bu0wJLGRH/3KDhxaL49EtZTSA1IvQQ
 TFACfFdGkrhmA==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p2AE1-00AYvK-4k;
 Mon, 05 Dec 2022 12:05:33 +0000
Date: Mon, 05 Dec 2022 12:05:32 +0000
Message-ID: <86zgc2kqcz.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v4 04/16] KVM: arm64: PMU: Distinguish between 64bit
 counter and 64bit overflow
In-Reply-To: <Y4jbosgHbUDI0WF4@google.com>
References: <20221113163832.3154370-1-maz@kernel.org>
 <20221113163832.3154370-5-maz@kernel.org>
 <Y4jasyxvFRNvvmox@google.com> <Y4jbosgHbUDI0WF4@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ricarkol@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 oliver.upton@linux.dev, reijiw@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 01 Dec 2022 16:51:46 +0000,
Ricardo Koller <ricarkol@google.com> wrote:
> 
> On Thu, Dec 01, 2022 at 08:47:47AM -0800, Ricardo Koller wrote:
> > On Sun, Nov 13, 2022 at 04:38:20PM +0000, Marc Zyngier wrote:
> > > The PMU architecture makes a subtle difference between a 64bit
> > > counter and a counter that has a 64bit overflow. This is for example
> > > the case of the cycle counter, which can generate an overflow on
> > > a 32bit boundary if PMCR_EL0.LC==0 despite the accumulation being
> > > done on 64 bits.
> > > 
> > > Use this distinction in the few cases where it matters in the code,
> > > as we will reuse this with PMUv3p5 long counters.
> > > 
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/kvm/pmu-emul.c | 43 ++++++++++++++++++++++++++++-----------
> > >  1 file changed, 31 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> > > index 69b67ab3c4bf..d050143326b5 100644
> > > --- a/arch/arm64/kvm/pmu-emul.c
> > > +++ b/arch/arm64/kvm/pmu-emul.c
> > > @@ -50,6 +50,11 @@ static u32 kvm_pmu_event_mask(struct kvm *kvm)
> > >   * @select_idx: The counter index
> > >   */
> > >  static bool kvm_pmu_idx_is_64bit(struct kvm_vcpu *vcpu, u64 select_idx)
> > > +{
> > > +	return (select_idx == ARMV8_PMU_CYCLE_IDX);
> > > +}
> > > +
> > > +static bool kvm_pmu_idx_has_64bit_overflow(struct kvm_vcpu *vcpu, u64 select_idx)
> > >  {
> > >  	return (select_idx == ARMV8_PMU_CYCLE_IDX &&
> > >  		__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_LC);
> > > @@ -57,7 +62,8 @@ static bool kvm_pmu_idx_is_64bit(struct kvm_vcpu *vcpu, u64 select_idx)
> > >  
> > >  static bool kvm_pmu_counter_can_chain(struct kvm_vcpu *vcpu, u64 idx)
> > >  {
> > > -	return (!(idx & 1) && (idx + 1) < ARMV8_PMU_CYCLE_IDX);
> > > +	return (!(idx & 1) && (idx + 1) < ARMV8_PMU_CYCLE_IDX &&
> > > +		!kvm_pmu_idx_has_64bit_overflow(vcpu, idx));
> > >  }
> > >  
> > >  static struct kvm_vcpu *kvm_pmc_to_vcpu(struct kvm_pmc *pmc)
> > > @@ -97,7 +103,7 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> > >  		counter += perf_event_read_value(pmc->perf_event, &enabled,
> > >  						 &running);
> > >  
> > > -	if (select_idx != ARMV8_PMU_CYCLE_IDX)
> > > +	if (!kvm_pmu_idx_is_64bit(vcpu, select_idx))
> > >  		counter = lower_32_bits(counter);
> > >  
> > >  	return counter;
> > > @@ -423,6 +429,23 @@ static void kvm_pmu_counter_increment(struct kvm_vcpu *vcpu,
> > >  	}
> > >  }
> > >  
> > > +/* Compute the sample period for a given counter value */
> > > +static u64 compute_period(struct kvm_vcpu *vcpu, u64 select_idx, u64 counter)
> > > +{
> > > +	u64 val;
> > > +
> > > +	if (kvm_pmu_idx_is_64bit(vcpu, select_idx)) {
> > > +		if (!kvm_pmu_idx_has_64bit_overflow(vcpu, select_idx))
> > > +			val = -(counter & GENMASK(31, 0));
> > 
> > If I understand things correctly, this might be missing another mask:
> > 
> > +		if (!kvm_pmu_idx_has_64bit_overflow(vcpu, select_idx)) {
> > +			val = -(counter & GENMASK(31, 0));
> > +			val &= GENMASK(31, 0);
> > +		} else {
> > 
> > For example, if the counter is 64-bits wide, it overflows at 32-bits,
> > and it is _one_ sample away from overflowing at 32-bits:
> > 
> > 	0x01010101_ffffffff
> > 
> > Then "val = (-counter) & GENMASK(63, 0)" would return 0xffffffff_00000001.
> 
> Sorry, this should be:
> 
> 	Then "val = -(counter & GENMASK(31, 0))" would return 0xffffffff_00000001.
> 
> > But the right period is 0x00000000_00000001 (it's one sample away from
> > overflowing).

Yup, this is a bit bogus. But this can be simplified by falling back
to the normal 32bit handling (on top of the pmu-unchained branch):

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index d8ea39943086..24908400e190 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -461,14 +461,10 @@ static u64 compute_period(struct kvm_pmc *pmc, u64 counter)
 {
 	u64 val;
 
-	if (kvm_pmc_is_64bit(pmc)) {
-		if (!kvm_pmc_has_64bit_overflow(pmc))
-			val = -(counter & GENMASK(31, 0));
-		else
-			val = (-counter) & GENMASK(63, 0);
-	} else {
+	if (kvm_pmc_is_64bit(pmc) && kvm_pmc_has_64bit_overflow(pmc))
+		val = (-counter) & GENMASK(63, 0);
+	else
 		val = (-counter) & GENMASK(31, 0);
-	}
 
 	return val;
 }

which satisfies the requirement without any extra masking, and makes
it plain that only a 64bit counter with 64bit overflow gets its period
computed on the full 64bit, and that anyone else gets the 32bit
truncation.

I'll stash yet another patch on top and push it onto -next.

Thanks!

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
