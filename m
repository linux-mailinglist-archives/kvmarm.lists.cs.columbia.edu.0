Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2336361961B
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 13:21:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9822841294;
	Fri,  4 Nov 2022 08:21:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elyIWNeVbc6D; Fri,  4 Nov 2022 08:21:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4038241066;
	Fri,  4 Nov 2022 08:21:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80F5E40162
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 08:21:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BbF7dYk6VvHv for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 08:21:04 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1D6C240158
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 08:21:04 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E0FF46217B;
 Fri,  4 Nov 2022 12:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E7EC433C1;
 Fri,  4 Nov 2022 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667564462;
 bh=13hGB5OrTrlv34yHV4xBUhzbdI6gDem825pl88PDw0A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q5YsjFOaszIVpzfcMBQl1F6a3KIbY/HXvm3hUhZTnFjKgigFRUOcHGXDlTrPbvJQz
 +s7iKUjMXnXbgXBkOgEVTuAXkmYRjYNUfrTy4Vuz1hKvwwUCfYRez0JekQo64TwUXc
 nZeCNoNFViT5Roid6QitT7DmPGSycHcB9TBK7X/qKtPKGrrGFEPdYJgF1M6fIklogx
 uCz8taVQ5KVc71ian5FUiPQc6UiAokrn1vMGiDEpXUEjJ9tYwr/wOlbulgG87osXNH
 nOyOjyo5YgaYGhsUcTudq5JrOUEn3d4RjNPWAP70zsG935YTiLdoWrB3J0vkxRlpi1
 M3oEC3IFP7+Kw==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oqvgy-003l7d-C9;
 Fri, 04 Nov 2022 12:21:00 +0000
Date: Fri, 04 Nov 2022 12:20:59 +0000
Message-ID: <86bkpmrjv8.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH v2 11/14] KVM: arm64: PMU: Allow ID_AA64DFR0_EL1.PMUver to
 be set from userspace
In-Reply-To: <CAAeT=FwViQRmyJjf3jxcWnLFQAYob8uvvx7QNhWyj6OmaYDKyg@mail.gmail.com>
References: <20221028105402.2030192-1-maz@kernel.org>
 <20221028105402.2030192-12-maz@kernel.org>
 <CAAeT=FyiNeRun7oRL83AUkVabUSb9pxL2SS9yZwi1rjFnbhH6g@mail.gmail.com>
 <87tu3gfi8u.wl-maz@kernel.org>
 <CAAeT=FwViQRmyJjf3jxcWnLFQAYob8uvvx7QNhWyj6OmaYDKyg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
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

Hi Reiji,

On Fri, 04 Nov 2022 07:00:22 +0000,
Reiji Watanabe <reijiw@google.com> wrote:
>
> On Thu, Nov 3, 2022 at 3:25 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 03 Nov 2022 05:31:56 +0000,
> > Reiji Watanabe <reijiw@google.com> wrote:
> > >
> > > It appears the patch allows userspace to set IMPDEF even
> > > when host_pmuver == 0.  Shouldn't it be allowed only when
> > > host_pmuver == IMPDEF (as before)?
> > > Probably, it may not cause any real problems though.
> >
> > Given that we don't treat the two cases any differently, I thought it
> > would be reasonable to relax this particular case, and I can't see any
> > reason why we shouldn't tolerate this sort of migration.
>
> That's true. I assume it won't cause any functional issues.
> 
> I have another comment related to this.
> KVM allows userspace to create a guest with a mix of vCPUs with and
> without PMU.  For such a guest, if the register for the vCPU without
> PMU is set last, I think the PMUVER value for vCPUs with PMU could
> become no PMU (0) or IMPDEF (0xf).
> Also, with the current patch, userspace can set PMUv3 support value
> (non-zero or non-IMPDEF) for vCPUs without the PMU.
> IMHO, KVM shouldn't allow userspace to set PMUVER to the value that
> is inconsistent with PMU configuration for the vCPU.
> What do you think ?

Yes, this seems sensible, and we only do it one way at the moment.

> I'm thinking of the following code (not tested).
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 4fa14b4ae2a6..ddd849027cc3 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1265,10 +1265,17 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>         if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
>                 return -EINVAL;
> 
> -       /* We already have a PMU, don't try to disable it... */
> -       if (kvm_vcpu_has_pmu(vcpu) &&
> -           (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
> -               return -EINVAL;
> +       if (kvm_vcpu_has_pmu(vcpu)) {
> +               /* We already have a PMU, don't try to disable it... */
> +               if (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF) {
> +                       return -EINVAL;
> +               }
> +       } else {
> +               /* We don't have a PMU, don't try to enable it... */
> +               if (pmuver > 0 && pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF) {
> +                       return -EINVAL;
> +               }
> +       }

This is a bit ugly. I came up with this instead:

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3b28ef48a525..e104fde1a0ee 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1273,6 +1273,7 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 			       u64 val)
 {
 	u8 pmuver, host_pmuver;
+	bool valid_pmu;
 
 	host_pmuver = kvm_arm_pmu_get_pmuver_limit();
 
@@ -1286,9 +1287,10 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 	if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
 		return -EINVAL;
 
-	/* We already have a PMU, don't try to disable it... */
-	if (kvm_vcpu_has_pmu(vcpu) &&
-	    (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
+	valid_pmu = (pmuver != 0 && pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF);
+
+	/* Make sure view register and PMU support do match */
+	if (kvm_vcpu_has_pmu(vcpu) != valid_pmu)
 		return -EINVAL;
 
 	/* We can only differ with PMUver, and anything else is an error */

and the similar check for the 32bit counterpart.

> 
>         /* We can only differ with PMUver, and anything else is an error */
>         val ^= read_id_reg(vcpu, rd);
> @@ -1276,7 +1283,8 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
>         if (val)
>                 return -EINVAL;
> 
> -       vcpu->kvm->arch.dfr0_pmuver = pmuver;
> +       if (kvm_vcpu_has_pmu(vcpu))
> +               vcpu->kvm->arch.dfr0_pmuver = pmuver;

We need to update this unconditionally if we want to be able to
restore an IMPDEF PMU view to the guest.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
