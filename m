Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD703914A6
	for <lists+kvmarm@lfdr.de>; Wed, 26 May 2021 12:15:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FE3F49E50;
	Wed, 26 May 2021 06:15:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xYPjfw48tve; Wed, 26 May 2021 06:15:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3604A49C;
	Wed, 26 May 2021 06:15:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 94A474A3BF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 May 2021 06:15:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hNeADEeKTzes for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 May 2021 06:15:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 66AF749E72
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 May 2021 06:15:05 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7574F613AB;
 Wed, 26 May 2021 10:15:04 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1llqZ4-003hsm-C0; Wed, 26 May 2021 11:15:02 +0100
Date: Wed, 26 May 2021 11:15:01 +0100
Message-ID: <87y2c1vm1m.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v2 5/5] KVM: arm64: selftests: get-reg-list: Split base
 and pmu registers
In-Reply-To: <20210526093211.loppoo42twel6inw@gator.home>
References: <20210519140726.892632-1-drjones@redhat.com>
 <20210519140726.892632-6-drjones@redhat.com>
 <YK1ZcqgyLFSDH14+@google.com> <87zgwhvq7r.wl-maz@kernel.org>
 <20210526093211.loppoo42twel6inw@gator.home>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, ricarkol@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com, alexandru.elisei@arm.com,
 pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On Wed, 26 May 2021 10:32:11 +0100,
Andrew Jones <drjones@redhat.com> wrote:
> 
> On Wed, May 26, 2021 at 09:44:56AM +0100, Marc Zyngier wrote:
> > On Tue, 25 May 2021 21:09:22 +0100,
> > Ricardo Koller <ricarkol@google.com> wrote:
> > > 
> > > On Wed, May 19, 2021 at 04:07:26PM +0200, Andrew Jones wrote:
> > > > Since KVM commit 11663111cd49 ("KVM: arm64: Hide PMU registers from
> > > > userspace when not available") the get-reg-list* tests have been
> > > > failing with
> > > > 
> > > >   ...
> > > >   ... There are 74 missing registers.
> > > >   The following lines are missing registers:
> > > >   ...
> > > > 
> > > > where the 74 missing registers are all PMU registers. This isn't a
> > > > bug in KVM that the selftest found, even though it's true that a
> > > > KVM userspace that wasn't setting the KVM_ARM_VCPU_PMU_V3 VCPU
> > > > flag, but still expecting the PMU registers to be in the reg-list,
> > > > would suddenly no longer have their expectations met. In that case,
> > > > the expectations were wrong, though, so that KVM userspace needs to
> > > > be fixed, and so does this selftest. The fix for this selftest is to
> > > > pull the PMU registers out of the base register sublist into their
> > > > own sublist and then create new, pmu-enabled vcpu configs which can
> > > > be tested.
> > > > 
> > > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > > ---
> > > >  .../selftests/kvm/aarch64/get-reg-list.c      | 46 +++++++++++++++----
> > > >  1 file changed, 38 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > > index dc06a28bfb74..78d8949bddbd 100644
> > > > --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > > +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > > > @@ -47,6 +47,7 @@ struct reg_sublist {
> > > >  struct vcpu_config {
> > > >  	const char *name;
> > > >  	bool sve;
> > > > +	bool pmu;
> > > >  	struct reg_sublist sublists[];
> > > >  };
> > > 
> > > I think it's possible that the number of sublists keeps increasing: it
> > > would be very nice/useful if KVM allowed enabling/disabling more
> > > features from userspace (besides SVE, PMU etc).
> > 
> > [tangential semi-rant]
> > 
> > While this is a very noble goal, it also doubles the validation space
> > each time you add an option. Given how little testing gets done
> > relative to the diversity of features and implementations, that's a
> > *big* problem.
> 
> It's my hope that this test, especially now after its refactoring, will
> allow us to test all configurations easily and therefore frequently.
> 
> > 
> > I'm not against it for big ticket items that result in a substantial
> > amount of state to be context-switched (SVE, NV). However, doing that
> > for more discrete features would require a radical change in the way
> > we develop, review and test KVM/arm64.
> >
> 
> I'm not sure I understand how we should change the development and
> review processes.

I'm worried that the current ratio of development vs review vs testing
is simply not right. We have a huge reviewing deficit, and we end-up
merging buggy code. Some of the features we simply cannot test. It was
OK up to 3 years ago, but I'm not sure it is sustainable anymore.

So making more and more things optional seems to go further in the
direction of an uncontrolled bitrot.

> As for testing, with simple tests like this one,
> we can actually achieve exhaustive configuration testing fast, at
> least with respect to checking for expected registers and checking
> that we can get/set_one_reg on them. If we were to try and setup
> QEMU migration tests for all the possible configurations, then it
> would take way too long.

I'm not worried about this get/set thing. I'm worried about the full
end-to-end migration, which hardly anyone tests in anger, with all the
variability of the architecture and options.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
