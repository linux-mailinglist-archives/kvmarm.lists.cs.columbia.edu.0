Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17C619181
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 08:00:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7829D4B0D0;
	Fri,  4 Nov 2022 03:00:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4eYglPSngCF; Fri,  4 Nov 2022 03:00:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F158749F3F;
	Fri,  4 Nov 2022 03:00:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2AE343479
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 03:00:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWbuuWLYnugr for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 03:00:40 -0400 (EDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 95A6E40BA3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 03:00:40 -0400 (EDT)
Received: by mail-pl1-f176.google.com with SMTP id io19so4075183plb.8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 04 Nov 2022 00:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OkaYBFTkTJOLws8unjECEd5re67/MivC1vGoCWgNdIA=;
 b=FKp6NbI+dU8fh5ZxoU8J2+rCaRu9ZcC1CSDUb+/iuOBdmi10+ZDR0lXKy7YyIBokBa
 hHH0sWInFczWPfNvzFp/C56hOZTbU2C+QY6zH3mN3aXSQ+n044oJ0ggkZB8h61ulJ0wJ
 HbsbkBptoJhgELan0IfRFRGRwB6sEAa/OLWKhTARy3vm4Y6W19RyJ2jnh+f0VGmBsqpu
 niSGI2IkoRU+ctTYkKJ9lYFjIzSYjRY8mWGuTuI8vjtr4ouBQDJqIO0d/L1ismojNUhx
 TDDFfzVWxpDXYPovwbBJYcGimOSXfURipT+2TMsKJmH84+yVug1aDYX0BJXM8wb5rF7e
 aO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OkaYBFTkTJOLws8unjECEd5re67/MivC1vGoCWgNdIA=;
 b=6MkbrqgZ1FCnQa/Wwbql0AFOEGDF6BJGswMHjc4a0elv0ONxOet7woTjLaDfceyZVV
 EhKGGZAZnvEYtPK9CuoBixRHQkGoc8xYmhpGILp8ghgrsDMy/S/q00BVf5uQOP88h+im
 dPdPDOFCq8IaOZG+15iv6zt/7GJJa9n+d1qyGXY+fmNicV712cI24tjsLil0pzpGKThk
 PljcK0F6lGixNKGIcchfLe3q0yrDp7yPp6J2979Qrgrbby7PVTRGIRcgPBrvVM3eDvS2
 LpUjBcy5iSD3szP7lD/FJ0kXQ5dnJt/I2tkFYrknfoDFZ7bLBFjvlkvRazZmLzOKmJZc
 YB7A==
X-Gm-Message-State: ACrzQf0oz2pOahltFBsHabONgPDrij86ziVwJwj3Buns39zD66y48Hoz
 5r8YesYg6womMduHKTgv9FQYjVJmz+JBoAPQ0Okvkw==
X-Google-Smtp-Source: AMsMyM4au6JdSEM3oUwq6uwtgVjKg0ofbyk0NdD0oa6I18qKO8X0z9DSu94dwOgaWrxqawwY5CdkCKG2mxEd+r1/z9I=
X-Received: by 2002:a17:90b:4a02:b0:213:9ba4:206a with SMTP id
 kk2-20020a17090b4a0200b002139ba4206amr37355261pjb.102.1667545239102; Fri, 04
 Nov 2022 00:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221028105402.2030192-1-maz@kernel.org>
 <20221028105402.2030192-12-maz@kernel.org>
 <CAAeT=FyiNeRun7oRL83AUkVabUSb9pxL2SS9yZwi1rjFnbhH6g@mail.gmail.com>
 <87tu3gfi8u.wl-maz@kernel.org>
In-Reply-To: <87tu3gfi8u.wl-maz@kernel.org>
From: Reiji Watanabe <reijiw@google.com>
Date: Fri, 4 Nov 2022 00:00:22 -0700
Message-ID: <CAAeT=FwViQRmyJjf3jxcWnLFQAYob8uvvx7QNhWyj6OmaYDKyg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] KVM: arm64: PMU: Allow ID_AA64DFR0_EL1.PMUver to
 be set from userspace
To: Marc Zyngier <maz@kernel.org>
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

Hi Marc,

On Thu, Nov 3, 2022 at 3:25 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 03 Nov 2022 05:31:56 +0000,
> Reiji Watanabe <reijiw@google.com> wrote:
> >
> > Hi Marc,
> >
> > On Fri, Oct 28, 2022 at 4:16 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Allow userspace to write ID_AA64DFR0_EL1, on the condition that only
> > > the PMUver field can be altered and be at most the one that was
> > > initially computed for the guest.
> > >
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/kvm/sys_regs.c | 37 ++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 36 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > index 7a4cd644b9c0..4fa14b4ae2a6 100644
> > > --- a/arch/arm64/kvm/sys_regs.c
> > > +++ b/arch/arm64/kvm/sys_regs.c
> > > @@ -1247,6 +1247,40 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
> > >         return 0;
> > >  }
> > >
> > > +static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
> > > +                              const struct sys_reg_desc *rd,
> > > +                              u64 val)
> > > +{
> > > +       u8 pmuver, host_pmuver;
> > > +
> > > +       host_pmuver = kvm_arm_pmu_get_pmuver_limit();
> > > +
> > > +       /*
> > > +        * Allow AA64DFR0_EL1.PMUver to be set from userspace as long
> > > +        * as it doesn't promise more than what the HW gives us. We
> > > +        * allow an IMPDEF PMU though, only if no PMU is supported
> > > +        * (KVM backward compatibility handling).
> > > +        */
> >
> > It appears the patch allows userspace to set IMPDEF even
> > when host_pmuver == 0.  Shouldn't it be allowed only when
> > host_pmuver == IMPDEF (as before)?
> > Probably, it may not cause any real problems though.
>
> Given that we don't treat the two cases any differently, I thought it
> would be reasonable to relax this particular case, and I can't see any
> reason why we shouldn't tolerate this sort of migration.

> Given that we don't treat the two cases any differently, I thought it
> would be reasonable to relax this particular case, and I can't see any
> reason why we shouldn't tolerate this sort of migration.

That's true. I assume it won't cause any functional issues.

I have another comment related to this.
KVM allows userspace to create a guest with a mix of vCPUs with and
without PMU.  For such a guest, if the register for the vCPU without
PMU is set last, I think the PMUVER value for vCPUs with PMU could
become no PMU (0) or IMPDEF (0xf).
Also, with the current patch, userspace can set PMUv3 support value
(non-zero or non-IMPDEF) for vCPUs without the PMU.
IMHO, KVM shouldn't allow userspace to set PMUVER to the value that
is inconsistent with PMU configuration for the vCPU.
What do you think ?

I'm thinking of the following code (not tested).

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4fa14b4ae2a6..ddd849027cc3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1265,10 +1265,17 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
        if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
                return -EINVAL;

-       /* We already have a PMU, don't try to disable it... */
-       if (kvm_vcpu_has_pmu(vcpu) &&
-           (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
-               return -EINVAL;
+       if (kvm_vcpu_has_pmu(vcpu)) {
+               /* We already have a PMU, don't try to disable it... */
+               if (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF) {
+                       return -EINVAL;
+               }
+       } else {
+               /* We don't have a PMU, don't try to enable it... */
+               if (pmuver > 0 && pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF) {
+                       return -EINVAL;
+               }
+       }

        /* We can only differ with PMUver, and anything else is an error */
        val ^= read_id_reg(vcpu, rd);
@@ -1276,7 +1283,8 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
        if (val)
                return -EINVAL;

-       vcpu->kvm->arch.dfr0_pmuver = pmuver;
+       if (kvm_vcpu_has_pmu(vcpu))
+               vcpu->kvm->arch.dfr0_pmuver = pmuver;

        return 0;
 }

Thank you,
Reiji



>
> >
> >
> > > +       pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), val);
> > > +       if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
> > > +               return -EINVAL;
> > > +
> > > +       /* We already have a PMU, don't try to disable it... */
> > > +       if (kvm_vcpu_has_pmu(vcpu) &&
> > > +           (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
> > > +               return -EINVAL;
> >
> > Nit: Perhaps it might be useful to return a different error code for the
> > above two (new) error cases (I plan to use -E2BIG and -EPERM
> > respectively for those cases with my ID register series).
>
> My worry in doing so is that we don't have an established practice for
> these cases. I'm fine with introducing new error codes, but I'm not
> sure there is an existing practice in userspace to actually interpret
> them.
>
> Even -EPERM has a slightly different meaning, and although there is
> some language there saying that it is all nonsense, we should be very
> careful.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
