Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 137F1543718
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jun 2022 17:16:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D83194B2D6;
	Wed,  8 Jun 2022 11:16:57 -0400 (EDT)
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
	with ESMTP id rYsrnj2hbYZw; Wed,  8 Jun 2022 11:16:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 38E454B2A0;
	Wed,  8 Jun 2022 11:16:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 284B34A500
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jun 2022 11:16:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVxm0FlnandE for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jun 2022 11:16:53 -0400 (EDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AB1A949F5D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jun 2022 11:16:53 -0400 (EDT)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-fdfe64231dso5140924fac.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Jun 2022 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7eph9ISNVbOH+7M9+xCwZej8ecmXDpKdEMD48L3HRRU=;
 b=Hii+O0SnvwnVnN01MZGRfBUb2LDVJ8b1xgySmMfmfX2eGefm0bEgvGVOdukb+eX9Zy
 dzWJg6GLdUfIMxanAnK79MUFjOhnhkLUnFbxELez0IoDOMYkLUIkeXLnVhsuXbWPMC0W
 3nGYqFTCs9wv/adwz2CnbPcbP7QVDBJtkOT0BSnO9+HC4pOcy1JaflXv/PD+vcLO95oq
 hV+LNzb9ZfPIw5fh7K/MidTfszB0lUviOgs836QOaHsBe8vHKksxV5UT32JVIQv19G0m
 Ze/latCesMAvCgLONpHOx9loO+/754lFTAnxUIPEzh+/hQmkbAsh2k7DfgTe1+KdWHlL
 Wdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7eph9ISNVbOH+7M9+xCwZej8ecmXDpKdEMD48L3HRRU=;
 b=k9YH5GLyTRY/v7++S2uFLFbQlROjjFf/gsDQ/Ed/zRBuzmrK0daQaimGfg++5lXY3u
 yMKodDIjPfW0xGQ7kVzmREUeLVd6k5XNvHfCvpxuFF6k+TVjlRYvyhFd6FK4t09ig0cN
 ZlEcLYi37gjcjfDlPMl1gKJKJOYsIERQ1/JcWTKhz2pD3I4P+Mf6CLRiDPVdu90tji7G
 A9++VJRMSJHX7RM99C6CnrPG6LEosgOKiQ745Yk8xs+7wQvLf3SXeeg/BbmEDWHN+NmE
 Bpp/LJFmrYlCkA/WrOHbOyFdQLkxvkawuAn1ORq2/BMIjvPsLkHMTqx1oAnACBpeejGn
 aMwg==
X-Gm-Message-State: AOAM5314fdcrxRv12EGl9LHXiGBVVML6cCAtiglcsUlrrU2l43wUUP0v
 ei8gXlQm02Bx6Q+ydgjiU2otdPHE/9Kg+isCWiAUsA==
X-Google-Smtp-Source: ABdhPJyTySSlS9VDf53Y+N1acBqc81e6nN7WA2lwTOuUAv8eU8SsCrtE8kM4z3qsIW5RiTOj67AzeqZERK1nXv1Gs/Y=
X-Received: by 2002:a05:6870:828d:b0:f3:4dd7:5ceb with SMTP id
 q13-20020a056870828d00b000f34dd75cebmr2737497oae.294.1654701412707; Wed, 08
 Jun 2022 08:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220528113829.1043361-1-maz@kernel.org>
 <20220528113829.1043361-10-maz@kernel.org>
In-Reply-To: <20220528113829.1043361-10-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 8 Jun 2022 16:16:16 +0100
Message-ID: <CA+EHjTzy99Waj8P48pbzbR2+KfgUzbZX5oj_J+JKo70VOq6yiQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] KVM: arm64: Move vcpu debug/SPE/TRBE flags to the
 input flag set
To: Marc Zyngier <maz@kernel.org>
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Sat, May 28, 2022 at 12:38 PM Marc Zyngier <maz@kernel.org> wrote:
>
> The three debug flags (which deal with the debug registers, SPE and
> TRBE) all are input flags to the hypervisor code.
>
> Move them into the input set and convert them to the new accessors.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          |  9 ++++++---
>  arch/arm64/kvm/debug.c                     | 22 +++++++++++-----------
>  arch/arm64/kvm/hyp/include/hyp/debug-sr.h  |  6 +++---
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |  4 ++--
>  arch/arm64/kvm/hyp/nvhe/debug-sr.c         |  8 ++++----
>  arch/arm64/kvm/sys_regs.c                  |  8 ++++----
>  6 files changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 078567f5709c..a426cd3aaa74 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -500,6 +500,12 @@ struct kvm_vcpu_arch {
>  #define EXCEPT_AA64_EL2_IRQ    __vcpu_except_flags(5)
>  #define EXCEPT_AA64_EL2_FIQ    __vcpu_except_flags(6)
>  #define EXCEPT_AA64_EL2_SERR   __vcpu_except_flags(7)
> +/* Guest debug is live */
> +#define DEBUG_DIRTY            __vcpu_single_flag(iflags, BIT(4))
> +/* Save SPE context if active  */
> +#define DEBUG_STATE_SAVE_SPE   __vcpu_single_flag(iflags, BIT(5))
> +/* Save TRBE context if active  */
> +#define DEBUG_STATE_SAVE_TRBE  __vcpu_single_flag(iflags, BIT(6))
>
>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
>  #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +     \
> @@ -522,10 +528,7 @@ struct kvm_vcpu_arch {
>  })
>
>  /* vcpu_arch flags field values: */
> -#define KVM_ARM64_DEBUG_DIRTY          (1 << 0)
>  #define KVM_ARM64_HOST_SVE_ENABLED     (1 << 4) /* SVE enabled for EL0 */
> -#define KVM_ARM64_DEBUG_STATE_SAVE_SPE (1 << 12) /* Save SPE context if active  */
> -#define KVM_ARM64_DEBUG_STATE_SAVE_TRBE        (1 << 13) /* Save TRBE context if active  */
>  #define KVM_ARM64_ON_UNSUPPORTED_CPU   (1 << 15) /* Physical CPU not in supported_cpus */
>  #define KVM_ARM64_HOST_SME_ENABLED     (1 << 16) /* SME enabled for EL0 */
>  #define KVM_ARM64_WFIT                 (1 << 17) /* WFIT instruction trapped */
> diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
> index 4fd5c216c4bb..c5c4c1837bf3 100644
> --- a/arch/arm64/kvm/debug.c
> +++ b/arch/arm64/kvm/debug.c
> @@ -104,11 +104,11 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
>          * Trap debug register access when one of the following is true:
>          *  - Userspace is using the hardware to debug the guest
>          *  (KVM_GUESTDBG_USE_HW is set).
> -        *  - The guest is not using debug (KVM_ARM64_DEBUG_DIRTY is clear).
> +        *  - The guest is not using debug (DEBUG_DIRTY clear).
>          *  - The guest has enabled the OS Lock (debug exceptions are blocked).
>          */
>         if ((vcpu->guest_debug & KVM_GUESTDBG_USE_HW) ||
> -           !(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY) ||
> +           !vcpu_get_flag(vcpu, DEBUG_DIRTY) ||
>             kvm_vcpu_os_lock_enabled(vcpu))
>                 vcpu->arch.mdcr_el2 |= MDCR_EL2_TDA;
>
> @@ -147,8 +147,8 @@ void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu)
>   * debug related registers.
>   *
>   * Additionally, KVM only traps guest accesses to the debug registers if
> - * the guest is not actively using them (see the KVM_ARM64_DEBUG_DIRTY
> - * flag on vcpu->arch.flags).  Since the guest must not interfere
> + * the guest is not actively using them (see the DEBUG_DIRTY
> + * flag on vcpu->arch.iflags).  Since the guest must not interfere
>   * with the hardware state when debugging the guest, we must ensure that
>   * trapping is enabled whenever we are debugging the guest using the
>   * debug registers.
> @@ -205,7 +205,7 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>                  *
>                  * We simply switch the debug_ptr to point to our new
>                  * external_debug_state which has been populated by the
> -                * debug ioctl. The existing KVM_ARM64_DEBUG_DIRTY
> +                * debug ioctl. The existing KVM_ARM64_IFLAG_DEBUG_DIRTY

This should be DEBUG_DIRTY.

Cheers,
/fuad


>                  * mechanism ensures the registers are updated on the
>                  * world switch.
>                  */
> @@ -216,7 +216,7 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>                         vcpu_write_sys_reg(vcpu, mdscr, MDSCR_EL1);
>
>                         vcpu->arch.debug_ptr = &vcpu->arch.external_debug_state;
> -                       vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
> +                       vcpu_set_flag(vcpu, DEBUG_DIRTY);
>
>                         trace_kvm_arm_set_regset("BKPTS", get_num_brps(),
>                                                 &vcpu->arch.debug_ptr->dbg_bcr[0],
> @@ -246,7 +246,7 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu)
>
>         /* If KDE or MDE are set, perform a full save/restore cycle. */
>         if (vcpu_read_sys_reg(vcpu, MDSCR_EL1) & (DBG_MDSCR_KDE | DBG_MDSCR_MDE))
> -               vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
> +               vcpu_set_flag(vcpu, DEBUG_DIRTY);
>
>         /* Write mdcr_el2 changes since vcpu_load on VHE systems */
>         if (has_vhe() && orig_mdcr_el2 != vcpu->arch.mdcr_el2)
> @@ -298,16 +298,16 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
>          */
>         if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_PMSVER_SHIFT) &&
>             !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(SYS_PMBIDR_EL1_P_SHIFT)))
> -               vcpu->arch.flags |= KVM_ARM64_DEBUG_STATE_SAVE_SPE;
> +               vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
>
>         /* Check if we have TRBE implemented and available at the host */
>         if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRBE_SHIFT) &&
>             !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
> -               vcpu->arch.flags |= KVM_ARM64_DEBUG_STATE_SAVE_TRBE;
> +               vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  }
>
>  void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
>  {
> -       vcpu->arch.flags &= ~(KVM_ARM64_DEBUG_STATE_SAVE_SPE |
> -                             KVM_ARM64_DEBUG_STATE_SAVE_TRBE);
> +       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
> +       vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
>  }
> diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> index 4ebe9f558f3a..961bbef104a6 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
> @@ -132,7 +132,7 @@ static inline void __debug_switch_to_guest_common(struct kvm_vcpu *vcpu)
>         struct kvm_guest_debug_arch *host_dbg;
>         struct kvm_guest_debug_arch *guest_dbg;
>
> -       if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
> +       if (!vcpu_get_flag(vcpu, DEBUG_DIRTY))
>                 return;
>
>         host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
> @@ -151,7 +151,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
>         struct kvm_guest_debug_arch *host_dbg;
>         struct kvm_guest_debug_arch *guest_dbg;
>
> -       if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
> +       if (!vcpu_get_flag(vcpu, DEBUG_DIRTY))
>                 return;
>
>         host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
> @@ -162,7 +162,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
>         __debug_save_state(guest_dbg, guest_ctxt);
>         __debug_restore_state(host_dbg, host_ctxt);
>
> -       vcpu->arch.flags &= ~KVM_ARM64_DEBUG_DIRTY;
> +       vcpu_clear_flag(vcpu, DEBUG_DIRTY);
>  }
>
>  #endif /* __ARM64_KVM_HYP_DEBUG_SR_H__ */
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index 7ecca8b07851..baa5b9b3dde5 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -195,7 +195,7 @@ static inline void __sysreg32_save_state(struct kvm_vcpu *vcpu)
>         __vcpu_sys_reg(vcpu, DACR32_EL2) = read_sysreg(dacr32_el2);
>         __vcpu_sys_reg(vcpu, IFSR32_EL2) = read_sysreg(ifsr32_el2);
>
> -       if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
> +       if (has_vhe() || vcpu_get_flag(vcpu, DEBUG_DIRTY))
>                 __vcpu_sys_reg(vcpu, DBGVCR32_EL2) = read_sysreg(dbgvcr32_el2);
>  }
>
> @@ -212,7 +212,7 @@ static inline void __sysreg32_restore_state(struct kvm_vcpu *vcpu)
>         write_sysreg(__vcpu_sys_reg(vcpu, DACR32_EL2), dacr32_el2);
>         write_sysreg(__vcpu_sys_reg(vcpu, IFSR32_EL2), ifsr32_el2);
>
> -       if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
> +       if (has_vhe() || vcpu_get_flag(vcpu, DEBUG_DIRTY))
>                 write_sysreg(__vcpu_sys_reg(vcpu, DBGVCR32_EL2), dbgvcr32_el2);
>  }
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> index df361d839902..e17455773b98 100644
> --- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
> @@ -84,10 +84,10 @@ static void __debug_restore_trace(u64 trfcr_el1)
>  void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>  {
>         /* Disable and flush SPE data generation */
> -       if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
> +       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>                 __debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
>         /* Disable and flush Self-Hosted Trace generation */
> -       if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_TRBE)
> +       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
>                 __debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
>  }
>
> @@ -98,9 +98,9 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
>
>  void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
>  {
> -       if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_SPE)
> +       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
>                 __debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
> -       if (vcpu->arch.flags & KVM_ARM64_DEBUG_STATE_SAVE_TRBE)
> +       if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
>                 __debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
>  }
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index d77be152cbd5..d6a55ed9ff10 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -387,7 +387,7 @@ static bool trap_debug_regs(struct kvm_vcpu *vcpu,
>  {
>         if (p->is_write) {
>                 vcpu_write_sys_reg(vcpu, p->regval, r->reg);
> -               vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
> +               vcpu_set_flag(vcpu, DEBUG_DIRTY);
>         } else {
>                 p->regval = vcpu_read_sys_reg(vcpu, r->reg);
>         }
> @@ -403,8 +403,8 @@ static bool trap_debug_regs(struct kvm_vcpu *vcpu,
>   * A 32 bit write to a debug register leave top bits alone
>   * A 32 bit read from a debug register only returns the bottom bits
>   *
> - * All writes will set the KVM_ARM64_DEBUG_DIRTY flag to ensure the
> - * hyp.S code switches between host and guest values in future.
> + * All writes will set the DEBUG_DIRTY flag to ensure the hyp code
> + * switches between host and guest values in future.
>   */
>  static void reg_to_dbg(struct kvm_vcpu *vcpu,
>                        struct sys_reg_params *p,
> @@ -420,7 +420,7 @@ static void reg_to_dbg(struct kvm_vcpu *vcpu,
>         val |= (p->regval & (mask >> shift)) << shift;
>         *dbg_reg = val;
>
> -       vcpu->arch.flags |= KVM_ARM64_DEBUG_DIRTY;
> +       vcpu_set_flag(vcpu, DEBUG_DIRTY);
>  }
>
>  static void dbg_to_reg(struct kvm_vcpu *vcpu,
> --
> 2.34.1
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
