Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37857CC3A
	for <lists+kvmarm@lfdr.de>; Thu, 21 Jul 2022 15:44:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 106E64C3D7;
	Thu, 21 Jul 2022 09:44:00 -0400 (EDT)
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
	with ESMTP id y0KcRf7qSLkL; Thu, 21 Jul 2022 09:43:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B08C34C397;
	Thu, 21 Jul 2022 09:43:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 752134C375
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jul 2022 09:43:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5fw+esr5+uT for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Jul 2022 09:43:56 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 08AA14C360
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jul 2022 09:43:55 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BBF72B82470;
 Thu, 21 Jul 2022 13:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5973DC341C0;
 Thu, 21 Jul 2022 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658411034;
 bh=zolXVvw7AUB3a/fOSg4H/0PyzLm5+4/cEagmQ13GdgA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cGRU+epYiW7RdR6QwlcTzBtkykN4sgAhn64EEUAdCOqTGgwKDjg9lHHe832aJ6KWz
 AAIuRuQbeBnBJNS+LjZZujK4d8a7ugArxNDt5DE8YSFBRu+AjoYMXudjgEHrUQIbzI
 AT7CNfCV5Mw25LADXP/YjXxaFT9kdicGIif8FCM3KFVdUULfUKjhRdUuLBAa1oOMAr
 z3fh823CsmnSebIZN3Q21GttKZJQr+nArKoTgagZNF4Tc/JOmIVHC8SFZH5IvsUsJJ
 J9d2Fd8+ou7sUi8DpI4u3VJ3okfcHWiApWQ7ry0Kp/8FEdYcog5XpEXL3NmmdZTCkb
 N6IgxdBSAXDAg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oEWT0-0095gK-GZ;
 Thu, 21 Jul 2022 14:43:51 +0100
Date: Thu, 21 Jul 2022 14:43:50 +0100
Message-ID: <871quezill.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [kvm-unit-tests PATCH 3/3] arm: pmu: Remove checks for !overflow
 in chained counters tests
In-Reply-To: <Ythy8XXN2rFytXdr@google.com>
References: <20220718154910.3923412-1-ricarkol@google.com>
 <20220718154910.3923412-4-ricarkol@google.com>
 <87edyhz68i.wl-maz@kernel.org> <Yte/YXWYSikyQcqh@google.com>
 <875yjsyv67.wl-maz@kernel.org> <Ythw1UT1wFHbY/jN@google.com>
 <Ythy8XXN2rFytXdr@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ricarkol@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com, alexandru.elisei@arm.com,
 eric.auger@redhat.com, oliver.upton@linux.dev, reijiw@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: drjones@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On Wed, 20 Jul 2022 22:26:09 +0100,
Ricardo Koller <ricarkol@google.com> wrote:
> 
> On Wed, Jul 20, 2022 at 02:17:09PM -0700, Ricardo Koller wrote:
> > On Wed, Jul 20, 2022 at 10:45:20AM +0100, Marc Zyngier wrote:
> > > On Wed, 20 Jul 2022 09:40:01 +0100,
> > > Ricardo Koller <ricarkol@google.com> wrote:
> > > > 
> > > > On Tue, Jul 19, 2022 at 12:34:05PM +0100, Marc Zyngier wrote:
> > > > > On Mon, 18 Jul 2022 16:49:10 +0100,
> > > > > Ricardo Koller <ricarkol@google.com> wrote:
> > > > > > 
> > > > > > A chained event overflowing on the low counter can set the overflow flag
> > > > > > in PMOVS.  KVM does not set it, but real HW and the fast-model seem to.
> > > > > > Moreover, the AArch64.IncrementEventCounter() pseudocode in the ARM ARM
> > > > > > (DDI 0487H.a, J1.1.1 "aarch64/debug") also sets the PMOVS bit on
> > > > > > overflow.
> > > > > 
> > > > > Isn't this indicative of a bug in the KVM emulation? To be honest, the
> > > > > pseudocode looks odd. It says:
> > > > > 
> > > > > <quote>
> > > > > 	if old_value<64:ovflw> != new_value<64:ovflw> then
> > > > > 	    PMOVSSET_EL0<idx> = '1';
> > > > > 	    PMOVSCLR_EL0<idx> = '1';
> > > > > </quote>
> > > > > 
> > > > > which I find remarkably ambiguous. Is this setting and clearing the
> > > > > overflow bit? Or setting it in the single register that backs the two
> > > > > accessors in whatever way it can?
> > > > > 
> > > > > If it is the second interpretation that is correct, then KVM
> > > > > definitely needs fixing
> > > > 
> > > > I think it's the second, as those two "= '1'" apply to the non-chained
> > > > counters case as well, which should definitely set the bit in PMOVSSET.
> > > > 
> > > > > (though this looks pretty involved for
> > > > > anything that isn't a SWINC event).
> > > > 
> > > > Ah, I see, there's a pretty convenient kvm_pmu_software_increment() for
> > > > SWINC, but a non-SWINC event is implemented as a single 64-bit perf
> > > > event.
> > > 
> > > Indeed. Which means we need to de-optimise chained counters to being
> > > 32bit events, which is pretty annoying (for rapidly firing events, the
> > > interrupt rate is going to be significantly higher).
> > > 
> > > I guess we should also investigate the support for FEAT_PMUv3p5 and
> > > native 64bit counters. Someone is bound to build it at some point.
> > 
> > The kernel perf event is implementing 64-bit counters using chained
> > counters. I assume this is already firing an interrupt for the low
> > counter overflow; we might need to just hook into that, investigating...

We probably only enable the overflow interrupt on the odd counter, and
not the even one (which is why you request chained counters the first
place).

And perf wouldn't call us back anyway, as we described the counter as
64bit.

> Additionally, given that the kernel is already emulating 64-bit
> counters, can KVM just expose FEAT_PMUv3p5? Assuming all the other new
> features can be emulated.

This is what I suggested above. Although it can only happen on a
system that already supports FEAT_PMU3p4, as PMMIR_EL1 is not defined
before that (and FEAT_PMU3p5 implies 3p4).

It also remains that we need to *properly* emulate chained counters,
which means not handling them as 64bit counters in perf, but as a
32bit counter and a carry (exactly like the pseudocode does).

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
