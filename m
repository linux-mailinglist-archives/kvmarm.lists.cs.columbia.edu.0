Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5A497AD4
	for <lists+kvmarm@lfdr.de>; Mon, 24 Jan 2022 09:57:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E674E411BD;
	Mon, 24 Jan 2022 03:57:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DoSLdaKqNV3q; Mon, 24 Jan 2022 03:57:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A433549E36;
	Mon, 24 Jan 2022 03:57:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7584949E08
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 03:57:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pi2YiwexDcWR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 24 Jan 2022 03:57:20 -0500 (EST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6F1FA411BD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 03:57:20 -0500 (EST)
Received: by mail-oi1-f180.google.com with SMTP id m9so10002966oia.12
 for <kvmarm@lists.cs.columbia.edu>; Mon, 24 Jan 2022 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7LOYL+rXbKkBxwKnxxUJRI+JYuYrzmRIZD8R7ss33Fo=;
 b=mOOM32JvhyWHxDNT1yl3o3ilV91m8p0sbxYBFE2MaJPRhEDNPFjsP2l/9YgR1e4n/j
 /+Ki5Wm3HUJjPfHmtoyeLbLIo740NpCjaxlELrLzkpxjvTtLVLgFWh8GpXYSEC2vg8xw
 iALRbAuJMSsqq2pRpY9vxpEREZ4RJi0zTV/KM0ihwHpDnu4BVD/4YzgHzVTpsoFaN6M/
 fUNijqYnsFrEFtdDqrP8v+9Q5RTA3dsVOlW+tn4g5RcNPn2AzUI2B4k2Th2N4rlXs+NR
 YVgFC+bMIftycOG+A/gPsTHZFp/9Ps/r6PvQpOeBiH4RaPhbQKDlyKSAj7xOc1Q1HQYY
 XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7LOYL+rXbKkBxwKnxxUJRI+JYuYrzmRIZD8R7ss33Fo=;
 b=oujumkFkD03uxPqhGnDlVdplG4KvQaOu7vUWUxMDVSMf8W/QUIo0pYmU041/MnINmp
 98Di4JLxqJD10AyDseHUrULCLFEYK3MrW5KIlA7K1rLgh6Lbquc3rA2grXknHjxd9eT7
 FkR4zES/biPsEKxq/fjvSfIUJu6+znwgBepkj0ZfweWzLh7fX0Mb7a+QiCMPKwU240OO
 X5XPUjQfmBlKoajXF0/uEt48jYvlQPIcP0Kpn92TAGgINL6L1tNDWuJ82HjTJ1K44iHF
 cSBm3Gg7gh3tAtlrYs+lBPwjuEOiUH3yNF+MmwqUXisl1kU/quwD8ernrvI0+hNc9w2A
 Ev3g==
X-Gm-Message-State: AOAM531bsafThV1MalfW3aOoaSSZh6o/PhdUnL7dUqJC4+YM1kI1KvwF
 IMzieaUIFonwyHkN1kO4KK4AQqCF9mZ5ufQAJf8QQg==
X-Google-Smtp-Source: ABdhPJxyYrXLQdtFig50Jm9MpWiRAsg7rBHxdCaoci5ZAoy/TpI9NboFii/+p4yqn/MGRoXXtldKiGH6LOsbJbsLU20=
X-Received: by 2002:aca:1e14:: with SMTP id m20mr640396oic.14.1643014639400;
 Mon, 24 Jan 2022 00:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220121184207.423426-1-maz@kernel.org>
In-Reply-To: <20220121184207.423426-1-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 24 Jan 2022 08:56:43 +0000
Message-ID: <CA+EHjTzks6CpViFPc=xCq4SGpdiEPy_88L3MTjikmNA-9bC0Tg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Use shadow SPSR_EL1 when injecting exceptions
 on !VHE
To: Marc Zyngier <maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, Jan 21, 2022 at 6:42 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Injecting an exception into a guest with non-VHE is risky business.
> Instead of writing in the shadow register for the switch code to
> restore it, we override the CPU register instead. Which gets
> overriden a few instructions later by said restore code.

I see that in __sysreg_restore_el1_state(), which as you said is
called after __vcpu_write_spsr().

> The result is that although the guest correctly gets the exception,
> it will return to the original context in some random state,
> depending on what was there the first place... Boo.
>
> Fix the issue by writing to the shadow register. The original code
> is absolutely fine on VHE, as the state is already loaded, and writing
> to the shadow register in that case would actually be a bug.

Which happens via kvm_vcpu_load_sysregs_vhe() calling
__sysreg_restore_el1_state() before __vcpu_write_spsr() in this case.

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> Fixes: bb666c472ca2 ("KVM: arm64: Inject AArch64 exceptions from HYP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/exception.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> index 0418399e0a20..c5d009715402 100644
> --- a/arch/arm64/kvm/hyp/exception.c
> +++ b/arch/arm64/kvm/hyp/exception.c
> @@ -38,7 +38,10 @@ static inline void __vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>
>  static void __vcpu_write_spsr(struct kvm_vcpu *vcpu, u64 val)
>  {
> -       write_sysreg_el1(val, SYS_SPSR);
> +       if (has_vhe())
> +               write_sysreg_el1(val, SYS_SPSR);
> +       else
> +               __vcpu_sys_reg(vcpu, SPSR_EL1) = val;
>  }
>
>  static void __vcpu_write_spsr_abt(struct kvm_vcpu *vcpu, u64 val)
> --
> 2.34.1
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
