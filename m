Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC5498668
	for <lists+kvmarm@lfdr.de>; Mon, 24 Jan 2022 18:20:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A500B408F4;
	Mon, 24 Jan 2022 12:20:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxuo2N63qqdx; Mon, 24 Jan 2022 12:20:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DD1A4141A;
	Mon, 24 Jan 2022 12:20:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 75B7340DCB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 12:20:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpJ+0BOZUsir for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Jan 2022 12:20:34 -0500 (EST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 382D749B07
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 12:20:34 -0500 (EST)
Received: by mail-oi1-f181.google.com with SMTP id m9so12079329oia.12
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n6ZSX0OGiLjAj7ZePuzn/e/7hNB5EthGPgk+JtIJg2I=;
 b=k/1vhkL+aQtAKz3YQFBz5OPhZpCJBYi1nWS493oLibLQy8xiq2+NKSFVJrp+FrTbEk
 SYmZqBh7bhkmVXOa/jM28TuVJ9HDT9iAGLg3FErDEAbEFy+BEa91tcM/kgecfKlZVK99
 Fxnu78qzqNye2FLoT0GboS5LhoEM6i/L/oLww9RAk2mTkFiyNNaWrTBZld2R7hJIj4yC
 u2LzPsq6761LxuMEFwd6VrZ+KB0U0pLZ3RtZAtBVqBI8O3ZB7UPckB7PHvw0Ge/VPUpe
 kvHiMwKLT/F8XpIqP2XCPvVhNXeFUPpVrYY5hanWUcVutzC46AsfhY8FuwPRKDvUJRLx
 +u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n6ZSX0OGiLjAj7ZePuzn/e/7hNB5EthGPgk+JtIJg2I=;
 b=m9HQVZiuraIVaAG7Wo/e2IL9Nc3c5bnnhqU5YZ7D3c6NtUx31FMR/cbsfxH2+sJLux
 FMxvsRlCpqC37KiADUkDDwjWPxjtDjKUP4/+QifxrRaJZtOhU29YQBddrOjBgcMk1Qxs
 5xhFpJLhd9O6bqSu01J/bnCwliFiZiZSidSXpmS3qpOcgUp18WSYGt74yClolQ0iGnkb
 Hb67wUlbex12pLk/F844hZOk+HQkaU7iyc6jbbhj94A8I0+CKkWTrtqHKnJkguBGLE1O
 iC8+ddZ3jZAoxgfOKaYYYMHDIH+gHTLqEvCF1DEcV4qyYGEr7LKl4eX+0DnKgKWlBI49
 gfBQ==
X-Gm-Message-State: AOAM531+s72yHZQwRzegpr08Ku32DLeSUKs2ih4e44WIDoOs+hZuyFeg
 k6Gke9b/tpvXV9BcqhxVc45yneKyZHE3aLwgurb3Dg==
X-Google-Smtp-Source: ABdhPJyL4QjGFXgPz8bOY7BIzGA+C5r4lAXfNJPmvzK0kbywEB5UljmnJSozM36IED/hjKZH8iLUQweYxuZt0CD1/7s=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr1837626oie.96.1643044833375; 
 Mon, 24 Jan 2022 09:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20220106042708.2869332-1-reijiw@google.com>
 <20220106042708.2869332-23-reijiw@google.com>
In-Reply-To: <20220106042708.2869332-23-reijiw@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 24 Jan 2022 17:19:57 +0000
Message-ID: <CA+EHjTyimL8nuE0gH8B3V-MzoA9rz+n3KazqFxMtdJKgjefAag@mail.gmail.com>
Subject: Re: [RFC PATCH v4 22/26] KVM: arm64: Trap disabled features of
 ID_AA64DFR0_EL1
To: Reiji Watanabe <reijiw@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

.Hi Reiji,

On Thu, Jan 6, 2022 at 4:29 AM Reiji Watanabe <reijiw@google.com> wrote:
>
> Add feature_config_ctrl for PMUv3, PMS and TraceFilt, which are
> indicated in ID_AA64DFR0_EL1, to program configuration registers
> to trap guest's using those features when they are not exposed to
> the guest.
>
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 72e745c5a9c2..229671ec3abd 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -349,6 +349,22 @@ static void feature_mte_trap_activate(struct kvm_vcpu *vcpu)
>         feature_trap_activate(vcpu, VCPU_HCR_EL2, HCR_TID5, HCR_DCT | HCR_ATA);
>  }
>
> +static void feature_pmuv3_trap_activate(struct kvm_vcpu *vcpu)
> +{
> +       feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TPM, 0);

I think that for full coverage it might be good to include setting
MDCR_EL2_TPMCR, and clearing MDCR_EL2_HPME | MDCR_EL2_MTPME |
MDCR_EL2_HPMN_MASK, even if redundant at this point.

> +}
> +
> +static void feature_pms_trap_activate(struct kvm_vcpu *vcpu)
> +{
> +       feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TPMS,
> +                             MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT);
> +}
> +
> +static void feature_tracefilt_trap_activate(struct kvm_vcpu *vcpu)
> +{
> +       feature_trap_activate(vcpu, VCPU_MDCR_EL2, MDCR_EL2_TTRF, 0);
> +}
> +
>  /* For ID_AA64PFR0_EL1 */
>  static struct feature_config_ctrl ftr_ctrl_ras = {
>         .ftr_reg = SYS_ID_AA64PFR0_EL1,
> @@ -375,6 +391,31 @@ static struct feature_config_ctrl ftr_ctrl_mte = {
>         .trap_activate = feature_mte_trap_activate,
>  };
>
> +/* For ID_AA64DFR0_EL1 */
> +static struct feature_config_ctrl ftr_ctrl_pmuv3 = {
> +       .ftr_reg = SYS_ID_AA64DFR0_EL1,
> +       .ftr_shift = ID_AA64DFR0_PMUVER_SHIFT,
> +       .ftr_min = ID_AA64DFR0_PMUVER_8_0,
> +       .ftr_signed = FTR_UNSIGNED,
> +       .trap_activate = feature_pmuv3_trap_activate,
> +};
> +
> +static struct feature_config_ctrl ftr_ctrl_pms = {
> +       .ftr_reg = SYS_ID_AA64DFR0_EL1,
> +       .ftr_shift = ID_AA64DFR0_PMSVER_SHIFT,
> +       .ftr_min = ID_AA64DFR0_PMSVER_8_2,
> +       .ftr_signed = FTR_UNSIGNED,
> +       .trap_activate = feature_pms_trap_activate,
> +};
> +
> +static struct feature_config_ctrl ftr_ctrl_tracefilt = {
> +       .ftr_reg = SYS_ID_AA64DFR0_EL1,
> +       .ftr_shift = ID_AA64DFR0_TRACE_FILT_SHIFT,
> +       .ftr_min = 1,
> +       .ftr_signed = FTR_UNSIGNED,
> +       .trap_activate = feature_tracefilt_trap_activate,
> +};

I think you might be missing trace, ID_AA64DFR0_TRACEVER -> CPTR_EL2_TTA.

Cheers,
/fuad


> +
>  struct id_reg_info {
>         u32     sys_reg;        /* Register ID */
>         u64     sys_val;        /* Sanitized system value */
> @@ -898,6 +939,12 @@ static struct id_reg_info id_aa64dfr0_el1_info = {
>         .init = init_id_aa64dfr0_el1_info,
>         .validate = validate_id_aa64dfr0_el1,
>         .vcpu_mask = vcpu_mask_id_aa64dfr0_el1,
> +       .trap_features = &(const struct feature_config_ctrl *[]) {
> +               &ftr_ctrl_pmuv3,
> +               &ftr_ctrl_pms,
> +               &ftr_ctrl_tracefilt,
> +               NULL,
> +       },
>  };
>
>  static struct id_reg_info id_dfr0_el1_info = {
> --
> 2.34.1.448.ga2b2bfdf31-goog
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
