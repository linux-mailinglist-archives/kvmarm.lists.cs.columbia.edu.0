Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0336496BF5
	for <lists+kvmarm@lfdr.de>; Sat, 22 Jan 2022 12:14:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D2EC49B08;
	Sat, 22 Jan 2022 06:14:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rrwk9jbLnw52; Sat, 22 Jan 2022 06:14:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE50141174;
	Sat, 22 Jan 2022 06:14:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A522340C1F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 06:14:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iqjjWKO9aX1L for <kvmarm@lists.cs.columbia.edu>;
 Sat, 22 Jan 2022 06:14:23 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7014340B91
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 06:14:23 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5309C60B85
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 11:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB055C340E5
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642850061;
 bh=dikOTUKGGj4j8zqQpWcygEiwWqA8JvaotxjHs5GZn4Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GnvOoVevpUrVm1pbxdgVVKjrad6kWlVYpZeFQuppE5kd10e4n5KDooXXYb4fTJtaz
 AtQ/ZCV4Zr1JiHnN68EjcUbfkM/MTC3VinhusATeZkvuenMLN0nvQHClyvSc+774Js
 FA62oq4HxjcYB2mXK9z83BWesdci9BdjTRJyECodLIoSNSJ5+OfCtl9bAg3IrA1kzn
 2pX+PMtzw3hch56sZmY4qPAivmNi0oEM4UaHSG8UAN0kEOQT2TpI20C6738A7GpXXN
 p23k646PB/9f37iTyNFGw7H6QEm9jWT2/4x+xfpKo5vTG2enj6hORo6mTl7damaq6l
 DFDCwCrTBo9Jg==
Received: by mail-wr1-f43.google.com with SMTP id r14so4454731wrp.2
 for <kvmarm@lists.cs.columbia.edu>; Sat, 22 Jan 2022 03:14:21 -0800 (PST)
X-Gm-Message-State: AOAM533Rjy2y4+7lAihr+ocqfqg7lBouV2kTPZqE8tC0F3R5Q8ovwPWF
 42o9p/doOT31kOG+J71HiptLSiRqw8zdKZSccMU=
X-Google-Smtp-Source: ABdhPJzyBFyif7w+EIZOfNZ/jx+IazO5AtERm3pyZnyB747+mnCUC45C6riTOAm//7XXndr2aJkcIMM+Hqk0weVDkIk=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr7299630wrm.417.1642850060047; 
 Sat, 22 Jan 2022 03:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20220122103912.795026-1-maz@kernel.org>
In-Reply-To: <20220122103912.795026-1-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 22 Jan 2022 12:14:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEmNpTGtZU=ZkOTpYpG7bdaubUx3-Zzpf-D1unjk43AYQ@mail.gmail.com>
Message-ID: <CAMj1kXEmNpTGtZU=ZkOTpYpG7bdaubUx3-Zzpf-D1unjk43AYQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Restrict SEIS workaround to known
 broken systems
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Sat, 22 Jan 2022 at 11:39, Marc Zyngier <maz@kernel.org> wrote:
>
> Contrary to what df652bcf1136 ("KVM: arm64: vgic-v3: Work around GICv3
> locally generated SErrors") was asserting, there is at least one other
> system out there (Cavium ThunderX2) implementing SEIS, and not in
> an obviously broken way.
>
> So instead of imposing the M1 workaround on an innocent bystander,
> let's limit it to the two known broken Apple implementations.
>
> Fixes: df652bcf1136 ("KVM: arm64: vgic-v3: Work around GICv3 locally generated SErrors")
> Reported-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Thanks for the fix.

Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>

One nit below.

> ---
>  arch/arm64/kvm/hyp/vgic-v3-sr.c |  3 +++
>  arch/arm64/kvm/vgic/vgic-v3.c   | 17 +++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/vgic-v3-sr.c b/arch/arm64/kvm/hyp/vgic-v3-sr.c
> index 20db2f281cf2..4fb419f7b8b6 100644
> --- a/arch/arm64/kvm/hyp/vgic-v3-sr.c
> +++ b/arch/arm64/kvm/hyp/vgic-v3-sr.c
> @@ -983,6 +983,9 @@ static void __vgic_v3_read_ctlr(struct kvm_vcpu *vcpu, u32 vmcr, int rt)
>         val = ((vtr >> 29) & 7) << ICC_CTLR_EL1_PRI_BITS_SHIFT;
>         /* IDbits */
>         val |= ((vtr >> 23) & 7) << ICC_CTLR_EL1_ID_BITS_SHIFT;
> +       /* SEIS */
> +       if (kvm_vgic_global_state.ich_vtr_el2 & ICH_VTR_SEIS_MASK)
> +               val |= BIT(ICC_CTLR_EL1_SEIS_SHIFT);
>         /* A3V */
>         val |= ((vtr >> 21) & 1) << ICC_CTLR_EL1_A3V_SHIFT;
>         /* EOImode */
> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> index 78cf674c1230..d34a795f730c 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> @@ -609,6 +609,18 @@ static int __init early_gicv4_enable(char *buf)
>  }
>  early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
>
> +static struct midr_range broken_seis[] = {

Can this be const?

> +       MIDR_ALL_VERSIONS(MIDR_APPLE_M1_ICESTORM),
> +       MIDR_ALL_VERSIONS(MIDR_APPLE_M1_FIRESTORM),
> +       {},
> +};
> +
> +static bool vgic_v3_broken_seis(void)
> +{
> +       return ((kvm_vgic_global_state.ich_vtr_el2 & ICH_VTR_SEIS_MASK) &&
> +               is_midr_in_range_list(read_cpuid_id(), broken_seis));
> +}
> +
>  /**
>   * vgic_v3_probe - probe for a VGICv3 compatible interrupt controller
>   * @info:      pointer to the GIC description
> @@ -676,9 +688,10 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
>                 group1_trap = true;
>         }
>
> -       if (kvm_vgic_global_state.ich_vtr_el2 & ICH_VTR_SEIS_MASK) {
> -               kvm_info("GICv3 with locally generated SEI\n");
> +       if (vgic_v3_broken_seis()) {
> +               kvm_info("GICv3 with broken locally generated SEI\n");
>
> +               kvm_vgic_global_state.ich_vtr_el2 &= ~ICH_VTR_SEIS_MASK;
>                 group0_trap = true;
>                 group1_trap = true;
>                 if (ich_vtr_el2 & ICH_VTR_TDS_MASK)
> --
> 2.34.1
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
