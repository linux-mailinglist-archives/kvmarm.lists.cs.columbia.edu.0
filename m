Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA7617635
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 06:32:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 650BC4B74E;
	Thu,  3 Nov 2022 01:32:17 -0400 (EDT)
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
	with ESMTP id jukMX4hRFCtF; Thu,  3 Nov 2022 01:32:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8FF4B6CF;
	Thu,  3 Nov 2022 01:32:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B1F44B6B2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 01:32:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1ONreOEuZu8 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Nov 2022 01:32:14 -0400 (EDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 297C94B648
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Nov 2022 01:32:14 -0400 (EDT)
Received: by mail-pg1-f175.google.com with SMTP id 128so771533pga.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Nov 2022 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=plrjvAdTS0nKqwkjAzFhlx4V983yw9yOIJecZW8zvnc=;
 b=NcV+yCiuxWOVxIsZo319+y5TyEFngethA6CQP6BOwGlsAkmNTjQraFrrswRtPZlkpD
 SJRUCsZfHhroDFuc1HWmkqwVEVc2RVFlGiP5zvsmzzPynvcbshB4QamTuDtUOEEi6JX4
 BmUNoa7MFmnhIEnLohD39eY/9J7H2XyS5v3+5c2obyaUdJSs75ghA1uFF39Ky7NSG8YJ
 Fs1aAEnOM6YE3UXbpbHYeTtl8vatHs5B63YYsi93lW77Z447BjQnB4MN173r79lfZNfs
 EeCfl2gHHg6Bb2KUGH/aEOT1ThtG05EipcaO2uura2cCTvv3plIIwNol/Hx+i5Ii5y9/
 Z3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plrjvAdTS0nKqwkjAzFhlx4V983yw9yOIJecZW8zvnc=;
 b=yhTvYmbVbquz58UeEeErfuvntC8WUcClEva/esKa+Zo1B6kvPR7RlsdyPCcBse/8mM
 cbw4yAKIAUrNQjiUDSQk1QgWsQ51NjAo7tHGcU9qnw3SAZTBQE2Ok5YNXeCDDGyJnRP6
 F2N2q1jbSi/XXd9YMq15KCuAinLl05QGGn5f9owIZ7wuggwY/RlVkJIvQ3kukfrdFXhP
 4Sr9ci21MUrCluFJ1KIOe4xh+ZeKslN//NwL9XMsumvjEwqB4j2NGauWHhdgYg6GD2bg
 qRGatcXK1fGmaJqHNYVnejw+AYbHd9/dQQwKOZ9bYeu/H0adoqxoOoaZNJkhY7D0BDh0
 XNKw==
X-Gm-Message-State: ACrzQf0tHtLsC7fw7z3maUt06MuVzPXKl0mbKQP4KEmno4S0eQB26xCw
 Vze7/9bRyZwwr9J3+++S5QeSUSxeCzNKi1fFKs889w==
X-Google-Smtp-Source: AMsMyM4AzbIHrwu7GJ3+G6SgGpmo5sXra8QVKVVvusdM6c9LC+09ZHIwSIQNdprt/hyAqQXhcjpMftwwP6uibr705Fk=
X-Received: by 2002:a63:db58:0:b0:443:575e:d1ed with SMTP id
 x24-20020a63db58000000b00443575ed1edmr24344874pgi.468.1667453533101; Wed, 02
 Nov 2022 22:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221028105402.2030192-1-maz@kernel.org>
 <20221028105402.2030192-12-maz@kernel.org>
In-Reply-To: <20221028105402.2030192-12-maz@kernel.org>
From: Reiji Watanabe <reijiw@google.com>
Date: Wed, 2 Nov 2022 22:31:56 -0700
Message-ID: <CAAeT=FyiNeRun7oRL83AUkVabUSb9pxL2SS9yZwi1rjFnbhH6g@mail.gmail.com>
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

On Fri, Oct 28, 2022 at 4:16 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Allow userspace to write ID_AA64DFR0_EL1, on the condition that only
> the PMUver field can be altered and be at most the one that was
> initially computed for the guest.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7a4cd644b9c0..4fa14b4ae2a6 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1247,6 +1247,40 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
>         return 0;
>  }
>
> +static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
> +                              const struct sys_reg_desc *rd,
> +                              u64 val)
> +{
> +       u8 pmuver, host_pmuver;
> +
> +       host_pmuver = kvm_arm_pmu_get_pmuver_limit();
> +
> +       /*
> +        * Allow AA64DFR0_EL1.PMUver to be set from userspace as long
> +        * as it doesn't promise more than what the HW gives us. We
> +        * allow an IMPDEF PMU though, only if no PMU is supported
> +        * (KVM backward compatibility handling).
> +        */

It appears the patch allows userspace to set IMPDEF even
when host_pmuver == 0.  Shouldn't it be allowed only when
host_pmuver == IMPDEF (as before)?
Probably, it may not cause any real problems though.


> +       pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), val);
> +       if (pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF && pmuver > host_pmuver)
> +               return -EINVAL;
> +
> +       /* We already have a PMU, don't try to disable it... */
> +       if (kvm_vcpu_has_pmu(vcpu) &&
> +           (pmuver == 0 || pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF))
> +               return -EINVAL;

Nit: Perhaps it might be useful to return a different error code for the
above two (new) error cases (I plan to use -E2BIG and -EPERM
respectively for those cases with my ID register series).

Thank you,
Reiji

> +
> +       /* We can only differ with PMUver, and anything else is an error */
> +       val ^= read_id_reg(vcpu, rd);
> +       val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer);
> +       if (val)
> +               return -EINVAL;
> +
> +       vcpu->kvm->arch.dfr0_pmuver = pmuver;
> +
> +       return 0;
> +}
> +
>  /*
>   * cpufeature ID register user accessors
>   *
> @@ -1508,7 +1542,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>         ID_UNALLOCATED(4,7),
>
>         /* CRm=5 */
> -       ID_SANITISED(ID_AA64DFR0_EL1),
> +       { SYS_DESC(SYS_ID_AA64DFR0_EL1), .access = access_id_reg,
> +         .get_user = get_id_reg, .set_user = set_id_aa64dfr0_el1, },
>         ID_SANITISED(ID_AA64DFR1_EL1),
>         ID_UNALLOCATED(5,2),
>         ID_UNALLOCATED(5,3),
> --
> 2.34.1
>
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
