Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 470A7617AC7
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 11:25:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 709564B74F;
	Thu,  3 Nov 2022 06:25:14 -0400 (EDT)
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
	with ESMTP id rnO7JQNfmwER; Thu,  3 Nov 2022 06:25:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51BA94B646;
	Thu,  3 Nov 2022 06:25:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B95194B25A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 06:25:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JKhw1ZrOJyRx for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Nov 2022 06:25:09 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CEB5E4B71F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 06:25:08 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5E30AB826A8;
 Thu,  3 Nov 2022 10:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0722BC433D7;
 Thu,  3 Nov 2022 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667471106;
 bh=1WjLvryUdEjCQvaGHVT4ulj0LOaBupI7N5OU9BiVl5w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MF+ZKTQo493m4vReC6RjdsC4JAi2ZaqHn73bOyvEx+WIcIGg+3Xd3iyEQYzVtzHKy
 oVi6wgoi1cjocgXOlvZe9Nbuk88wrlqofN3qL5qWkmi9ilCzWDiMeRXEbkCRWITxBD
 Wb24a7y/dgLeK34nevpfsa4JfAHkUI0OihIHk1wmu5PZWN3KXGwP2RR46cNka58BDD
 FF2IuFj1rXpsn0Y7ZK576xDKTK86az/4DotWOp5vSeJ4r37RxIk0zjMvCXistMRjnA
 WvGx+bpSvjFpYfO4b5PxV98bnHYGd/vqYpbjo7KT3e3kGkhkZ3xpvGc8pseTv+zER9
 WDCoakY1H7PBg==
Received: from [104.132.45.97] (helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oqXPD-003TRe-JS;
 Thu, 03 Nov 2022 10:25:03 +0000
Date: Thu, 03 Nov 2022 10:24:33 +0000
Message-ID: <87tu3gfi8u.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 11/14] KVM: arm64: PMU: Allow ID_AA64DFR0_EL1.PMUver to
 be set from userspace
In-Reply-To: <CAAeT=FyiNeRun7oRL83AUkVabUSb9pxL2SS9yZwi1rjFnbhH6g@mail.gmail.com>
References: <20221028105402.2030192-1-maz@kernel.org>
 <20221028105402.2030192-12-maz@kernel.org>
 <CAAeT=FyiNeRun7oRL83AUkVabUSb9pxL2SS9yZwi1rjFnbhH6g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 104.132.45.97
X-SA-Exim-Rcpt-To: reijiw@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 oliver.upton@linux.dev, ricarkol@google.com
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

On Thu, 03 Nov 2022 05:31:56 +0000,
Reiji Watanabe <reijiw@google.com> wrote:
> 
> Hi Marc,
> 
> On Fri, Oct 28, 2022 at 4:16 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Allow userspace to write ID_AA64DFR0_EL1, on the condition that only
> > the PMUver field can be altered and be at most the one that was
> > initially computed for the guest.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 37 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 7a4cd644b9c0..4fa14b4ae2a6 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1247,6 +1247,40 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
> >         return 0;
> >  }
> >
> > +static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
> > +                              const struct sys_reg_desc *rd,
> > +                              u64 val)
> > +{
> > +       u8 pmuver, host_pmuver;
> > +
> > +       host_pmuver = kvm_arm_pmu_get_pmuver_limit();
> > +
> > +       /*
> > +        * Allow AA64DFR0_EL1.PMUver to be set from userspace as long
> > +        * as it doesn't promise more than what the HW gives us. We
> > +        * allow an IMPDEF PMU though, only if no PMU is supported
> > +        * (KVM backward compatibility handling).
> > +        */
> 
> It appears the patch allows userspace to set IMPDEF even
> when host_pmuver == 0.  Shouldn't it be allowed only when
> host_pmuver == IMPDEF (as before)?
> Probably, it may not cause any real problems though.

Given that we don't treat the two cases any differently, I thought it
would be reasonable to relax this particular case, and I can't see any
reason why we shouldn't tolerate this sort of migration.

> 
> 
> > +       pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), val);
> > +       if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
> > +               return -EINVAL;
> > +
> > +       /* We already have a PMU, don't try to disable it... */
> > +       if (kvm_vcpu_has_pmu(vcpu) &&
> > +           (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
> > +               return -EINVAL;
> 
> Nit: Perhaps it might be useful to return a different error code for the
> above two (new) error cases (I plan to use -E2BIG and -EPERM
> respectively for those cases with my ID register series).

My worry in doing so is that we don't have an established practice for
these cases. I'm fine with introducing new error codes, but I'm not
sure there is an existing practice in userspace to actually interpret
them.

Even -EPERM has a slightly different meaning, and although there is
some language there saying that it is all nonsense, we should be very
careful.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
