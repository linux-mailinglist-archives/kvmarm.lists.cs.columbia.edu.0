Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA365FABB
	for <lists+kvmarm@lfdr.de>; Fri,  6 Jan 2023 05:29:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7767A4B3DE;
	Thu,  5 Jan 2023 23:29:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.788
X-Spam-Level: 
X-Spam-Status: No, score=-6.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8B2d9gV09Qms; Thu,  5 Jan 2023 23:29:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F7D54B3CA;
	Thu,  5 Jan 2023 23:29:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 59A674B269
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 23:29:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNoPeBWqeqWZ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  5 Jan 2023 23:29:48 -0500 (EST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0F2C040C1B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  5 Jan 2023 23:29:48 -0500 (EST)
Received: by mail-pl1-f169.google.com with SMTP id g16so522915plq.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 05 Jan 2023 20:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fcURZiYLo00tcWs3+wszW6Bvd/4zu4Ab0Se45w2cFpM=;
 b=PzZLX9u+0gK6QDlBGSiiQ+OemnGC69bLORrQ+GjSLLjlWg+dEpIA+ZGZNlGjKgg7sw
 IW0PE1FNfVG6VZVQidaDc2WZSr+yisyFL2+5nOfdFlqMrtQT4NOxnVmLeNz9A/UWM4Mz
 Y38AxjqDaC0Ef0iUtTDIinulbT4SNFVEv7qd7TGeRbqFLLRdAKuIRk3jJ6WX3LPZ8vOo
 pCOsM1lXSEcUVZt2vPlB1HQYpnfJ7I0YCUc4UpEUeI2ajO/KGfr2y4yk8jtws65wrWVo
 5wKxgogUt+nwVw+ZRKXFaCvoWdSwQZ8k9f5HqD83Jw4qcCnpOz+s7rY4ARvJ+Ii/jPem
 JLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcURZiYLo00tcWs3+wszW6Bvd/4zu4Ab0Se45w2cFpM=;
 b=A22mOOCKUeDAAqSjoPH05bFR3kP8p/PZ9AH+0Hfo2SRyhwy8jAPgunZSRS+kjdKdov
 L/xFcwprSo9D+L7FfPK/SZ3PvmoaV1yUUrmlbwMBC0cpcnX6YRUEXe3mBlk0t4n5r1CX
 IFxK1xrNUwldsLzr1Dyhj3ALVHTbo7vMWrW/cj6M5LfTTXlhUz/6gmEAmsR5kMByNpB/
 CKS57TsFU0nj8fG9qgmDraIeDKbXkfR38R7HEdmP97RCuyXrw2TIvsuumRNO7ErM2N9P
 Fzla4FPpA+bUDCQ7f1F1u5bluXICUllmsAzKf4dGXFahRPezv6AAh5zNk6BFYNCVA49O
 sImw==
X-Gm-Message-State: AFqh2kpjCGHuN89pYkfvX2iOdzeTKEwCL7xZZ5ltUovNDr+sBixDk6c5
 G0Ibte/v/vj93M5t1TRnuC88jWTA/XnR7pUJ6Svygg==
X-Google-Smtp-Source: AMrXdXsy8aDnv6lrfzqqhK3ITxVFNw7u/CFK+OKUcDXNWDmM7yXqif0Zgd7I4s86POJfZVsaf6QzD1xgDsGxm54lXyY=
X-Received: by 2002:a17:90a:488a:b0:226:b5f4:d420 with SMTP id
 b10-20020a17090a488a00b00226b5f4d420mr837152pjh.102.1672979386260; Thu, 05
 Jan 2023 20:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
 <20221230095452.181764-6-akihiko.odaki@daynix.com>
In-Reply-To: <20221230095452.181764-6-akihiko.odaki@daynix.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Thu, 5 Jan 2023 20:29:28 -0800
Message-ID: <CAAeT=Fx4_gms9ds5xOLXQ0oBgVXcZzE2E9OMaNP7tw7sY9DyuQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] KVM: arm64: Always set HCR_TID2
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Sven Peter <sven@svenpeter.dev>,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

On Fri, Dec 30, 2022 at 1:55 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Always set HCR_TID2 to trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and
> CSSELR_EL1. This saves a few lines of code and allows to employ their
> access trap handlers for more purposes anticipated by the old
> condition for setting HCR_TID2.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h           | 3 ++-
>  arch/arm64/include/asm/kvm_emulate.h       | 4 ----
>  arch/arm64/include/asm/kvm_host.h          | 2 --
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 2 --
>  4 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 8aa8492dafc0..44be46c280c1 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -81,11 +81,12 @@
>   * SWIO:       Turn set/way invalidates into set/way clean+invalidate
>   * PTW:                Take a stage2 fault if a stage1 walk steps in device memory
>   * TID3:       Trap EL1 reads of group 3 ID registers
> + * TID2:       Trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and CSSELR_EL1
>   */
>  #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
>                          HCR_BSU_IS | HCR_FB | HCR_TACR | \
>                          HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
> -                        HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 )
> +                        HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 | HCR_TID2)
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
>  #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
>  #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 9bdba47f7e14..30c4598d643b 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -88,10 +88,6 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>         if (vcpu_el1_is_32bit(vcpu))
>                 vcpu->arch.hcr_el2 &= ~HCR_RW;
>
> -       if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
> -           vcpu_el1_is_32bit(vcpu))
> -               vcpu->arch.hcr_el2 |= HCR_TID2;
> -
>         if (kvm_has_mte(vcpu->kvm))
>                 vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 45e2136322ba..cc2ede0eaed4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -621,7 +621,6 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
>                 return false;
>
>         switch (reg) {
> -       case CSSELR_EL1:        *val = read_sysreg_s(SYS_CSSELR_EL1);   break;
>         case SCTLR_EL1:         *val = read_sysreg_s(SYS_SCTLR_EL12);   break;
>         case CPACR_EL1:         *val = read_sysreg_s(SYS_CPACR_EL12);   break;
>         case TTBR0_EL1:         *val = read_sysreg_s(SYS_TTBR0_EL12);   break;
> @@ -666,7 +665,6 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
>                 return false;
>
>         switch (reg) {
> -       case CSSELR_EL1:        write_sysreg_s(val, SYS_CSSELR_EL1);    break;
>         case SCTLR_EL1:         write_sysreg_s(val, SYS_SCTLR_EL12);    break;
>         case CPACR_EL1:         write_sysreg_s(val, SYS_CPACR_EL12);    break;
>         case TTBR0_EL1:         write_sysreg_s(val, SYS_TTBR0_EL12);    break;
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index baa5b9b3dde5..147cb4c846c6 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -39,7 +39,6 @@ static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
>
>  static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  {
> -       ctxt_sys_reg(ctxt, CSSELR_EL1)  = read_sysreg(csselr_el1);
>         ctxt_sys_reg(ctxt, SCTLR_EL1)   = read_sysreg_el1(SYS_SCTLR);
>         ctxt_sys_reg(ctxt, CPACR_EL1)   = read_sysreg_el1(SYS_CPACR);
>         ctxt_sys_reg(ctxt, TTBR0_EL1)   = read_sysreg_el1(SYS_TTBR0);
> @@ -95,7 +94,6 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  {
>         write_sysreg(ctxt_sys_reg(ctxt, MPIDR_EL1),     vmpidr_el2);
> -       write_sysreg(ctxt_sys_reg(ctxt, CSSELR_EL1),    csselr_el1);
>
>         if (has_vhe() ||
>             !cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
> --

Reviewed-by: Reiji Watanabe <reijiw@google.com>

Nit: access_csselr() can now directly use __vcpu_sys_reg() (instead
of using it through via vcpu_{write,read}_sys_reg()), as most codes
do when there is no need to use vcpu_{write,read}_sys_reg().
The same comment is applied to access_ccsidr(), which uses
vcpu_read_sys_reg() to get CSSELR_EL1 value for the vCPU.

Thank you,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
