Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E58D44039A2
	for <lists+kvmarm@lfdr.de>; Wed,  8 Sep 2021 14:20:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57FFE4B10D;
	Wed,  8 Sep 2021 08:20:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwtOhh2YZO-R; Wed,  8 Sep 2021 08:20:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 076AD4B106;
	Wed,  8 Sep 2021 08:20:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D69824B0DD
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 08:20:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4QK78SL2nDO for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 08:20:38 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA1E44B0D6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 08:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631103638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TakcI4GHCil+3yqrDCaaCoSFfwp7tnMVil8dL3Kv2dk=;
 b=enJDTGW/i1IqGhtKkPsAvv8Rqy+Ip1gulXonlF7VZmkdRcgx9scKihmR6AFPBnk6dNug2n
 iOwXg7OBcXNQ+6888MgIoqqrEiw+4Em3N4Z+i8XYwHIO9Cn4qJOiOSbzA7Esn93GF27GTw
 iA+c6R6gefymNeFS9gvIPdhQ6SiV0Ns=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-RAHwqPqsPy2wEwNluriYHg-1; Wed, 08 Sep 2021 08:20:37 -0400
X-MC-Unique: RAHwqPqsPy2wEwNluriYHg-1
Received: by mail-ej1-f71.google.com with SMTP id
 o7-20020a170906288700b005bb05cb6e25so881375ejd.23
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 05:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TakcI4GHCil+3yqrDCaaCoSFfwp7tnMVil8dL3Kv2dk=;
 b=PnKPCEyxNQwE/HLM/WB8DmUu1Fw3T/qPKipEmtqaIFbedCs8UfJRmt5ml9BboMUOvT
 D3eaew9jczz0zvuyYvVx+qfYZfXXrycNVbrZBno/8skA693naaGsdzs41XNVBHq9xcbr
 aUCEvfujkUNJTcR9hHo1K0PbBlztHzLaxyMlknEXFyb2L4ymwha3154zaUESNyUZH9mh
 BU4MVrn9BxIxzLg0dEr8DFQLDtwTPIkwjur/pwik/4HgqlLsYAcgS9bQHMluTVLblomP
 dfrXFpJa+REu8LTU4BtDlejqQmjdAETxKAzP5jiJcAVk8/O6C6jC2eEizyvTyoOqrEK9
 aJ7A==
X-Gm-Message-State: AOAM5304PfpCJpUhjAgzhD46RmD9vEsLNtsT+aJVzyG7Hj3YXUendYpC
 cjOsa1xzKJ1YlFdvySEM8VVENxu021JrlpdoDqPraLEHBMDzdcU9JGXtmQE2krAYEVtqXeZdimp
 NHTNmw/DHBl2gW/KZ6Xiklxdj
X-Received: by 2002:a17:906:b0d1:: with SMTP id
 bk17mr3792758ejb.59.1631103635361; 
 Wed, 08 Sep 2021 05:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNtUvrp94zRzClVsuq3PUQ6DmLGX8jNlLF8G1m/0Wa4P956rn9lArXzA0MD0Qzss1XZ5iPkw==
X-Received: by 2002:a17:906:b0d1:: with SMTP id
 bk17mr3792717ejb.59.1631103634773; 
 Wed, 08 Sep 2021 05:20:34 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id p5sm940722eju.30.2021.09.08.05.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 05:20:34 -0700 (PDT)
Date: Wed, 8 Sep 2021 14:20:32 +0200
From: Andrew Jones <drjones@redhat.com>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v5 4/8] KVM: arm64: Add trap handlers for protected VMs
Message-ID: <20210908122032.uhcjzoq3lxn3bv4r@gator>
References: <20210827101609.2808181-1-tabba@google.com>
 <20210827101609.2808181-5-tabba@google.com>
MIME-Version: 1.0
In-Reply-To: <20210827101609.2808181-5-tabba@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, Aug 27, 2021 at 11:16:05AM +0100, Fuad Tabba wrote:
> Add trap handlers for protected VMs. These are mainly for Sys64
> and debug traps.
> 
> No functional change intended as these are not hooked in yet to
> the guest exit handlers introduced earlier. So even when trapping
> is triggered, the exit handlers would let the host handle it, as
> before.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/kvm_fixed_config.h  | 164 +++++++
>  arch/arm64/include/asm/kvm_hyp.h           |   5 +
>  arch/arm64/kvm/arm.c                       |   5 +
>  arch/arm64/kvm/hyp/include/nvhe/sys_regs.h |  29 ++
>  arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
>  arch/arm64/kvm/hyp/nvhe/switch.c           |   1 +
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c         | 523 +++++++++++++++++++++
>  7 files changed, 728 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_fixed_config.h
>  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/sys_regs.c
> 
> diff --git a/arch/arm64/include/asm/kvm_fixed_config.h b/arch/arm64/include/asm/kvm_fixed_config.h
> new file mode 100644
> index 000000000000..9085301d159e
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_fixed_config.h
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Google LLC
> + * Author: Fuad Tabba <tabba@google.com>
> + */
> +
> +#ifndef __ARM64_KVM_FIXED_CONFIG_H__
> +#define __ARM64_KVM_FIXED_CONFIG_H__
> +
> +#include <asm/sysreg.h>
> +
> +/*
> + * This file contains definitions for features to be allowed or restricted for
> + * guest virtual machines, depending on the mode KVM is running in and on the
> + * type of guest that is running.
> + *
> + * The ALLOW masks represent a bitmask of feature fields that are allowed
> + * without any restrictions as long as they are supported by the system.
> + *
> + * The RESTRICT_UNSIGNED masks, if present, represent unsigned fields for
> + * features that are restricted to support at most the specified feature.
> + *
> + * If a feature field is not present in either, than it is not supported.
> + *
> + * The approach taken for protected VMs is to allow features that are:
> + * - Needed by common Linux distributions (e.g., floating point)
> + * - Trivial to support, e.g., supporting the feature does not introduce or
> + * require tracking of additional state in KVM
> + * - Cannot be trapped or prevent the guest from using anyway
> + */
> +
> +/*
> + * Allow for protected VMs:
> + * - Floating-point and Advanced SIMD
> + * - Data Independent Timing
> + */
> +#define PVM_ID_AA64PFR0_ALLOW (\
> +	ARM64_FEATURE_MASK(ID_AA64PFR0_FP) | \
> +	ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD) | \
> +	ARM64_FEATURE_MASK(ID_AA64PFR0_DIT) \
> +	)
> +
> +/*
> + * Restrict to the following *unsigned* features for protected VMs:
> + * - AArch64 guests only (no support for AArch32 guests):
> + *	AArch32 adds complexity in trap handling, emulation, condition codes,
> + *	etc...
> + * - RAS (v1)
> + *	Supported by KVM
> + */
> +#define PVM_ID_AA64PFR0_RESTRICT_UNSIGNED (\
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL0), ID_AA64PFR0_ELx_64BIT_ONLY) | \
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1), ID_AA64PFR0_ELx_64BIT_ONLY) | \
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL2), ID_AA64PFR0_ELx_64BIT_ONLY) | \
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL3), ID_AA64PFR0_ELx_64BIT_ONLY) | \
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_RAS), ID_AA64PFR0_RAS_V1) \
> +	)
> +
> +/*
> + * Allow for protected VMs:
> + * - Branch Target Identification
> + * - Speculative Store Bypassing
> + */
> +#define PVM_ID_AA64PFR1_ALLOW (\
> +	ARM64_FEATURE_MASK(ID_AA64PFR1_BT) | \
> +	ARM64_FEATURE_MASK(ID_AA64PFR1_SSBS) \
> +	)
> +
> +/*
> + * Allow for protected VMs:
> + * - Mixed-endian
> + * - Distinction between Secure and Non-secure Memory
> + * - Mixed-endian at EL0 only
> + * - Non-context synchronizing exception entry and exit
> + */
> +#define PVM_ID_AA64MMFR0_ALLOW (\
> +	ARM64_FEATURE_MASK(ID_AA64MMFR0_BIGENDEL) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR0_SNSMEM) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR0_BIGENDEL0) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR0_EXS) \
> +	)
> +
> +/*
> + * Restrict to the following *unsigned* features for protected VMs:
> + * - 40-bit IPA
> + * - 16-bit ASID
> + */
> +#define PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED (\
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_PARANGE), ID_AA64MMFR0_PARANGE_40) | \
> +	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64MMFR0_ASID), ID_AA64MMFR0_ASID_16) \
> +	)
> +
> +/*
> + * Allow for protected VMs:
> + * - Hardware translation table updates to Access flag and Dirty state
> + * - Number of VMID bits from CPU
> + * - Hierarchical Permission Disables
> + * - Privileged Access Never
> + * - SError interrupt exceptions from speculative reads
> + * - Enhanced Translation Synchronization
> + */
> +#define PVM_ID_AA64MMFR1_ALLOW (\
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_HADBS) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_VMIDBITS) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_HPD) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_PAN) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_SPECSEI) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR1_ETS) \
> +	)
> +
> +/*
> + * Allow for protected VMs:
> + * - Common not Private translations
> + * - User Access Override
> + * - IESB bit in the SCTLR_ELx registers
> + * - Unaligned single-copy atomicity and atomic functions
> + * - ESR_ELx.EC value on an exception by read access to feature ID space
> + * - TTL field in address operations.
> + * - Break-before-make sequences when changing translation block size
> + * - E0PDx mechanism
> + */
> +#define PVM_ID_AA64MMFR2_ALLOW (\
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_CNP) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_UAO) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_IESB) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_AT) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_IDS) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_TTL) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_BBM) | \
> +	ARM64_FEATURE_MASK(ID_AA64MMFR2_E0PD) \
> +	)
> +
> +/*
> + * No support for Scalable Vectors for protected VMs:
> + *	Requires additional support from KVM, e.g., context-switching and
> + *	trapping at EL2
> + */
> +#define PVM_ID_AA64ZFR0_ALLOW (0ULL)
> +
> +/*
> + * No support for debug, including breakpoints, and watchpoints for protected
> + * VMs:
> + *	The Arm architecture mandates support for at least the Armv8 debug
> + *	architecture, which would include at least 2 hardware breakpoints and
> + *	watchpoints. Providing that support to protected guests adds
> + *	considerable state and complexity. Therefore, the reserved value of 0 is
> + *	used for debug-related fields.
> + */
> +#define PVM_ID_AA64DFR0_ALLOW (0ULL)
> +#define PVM_ID_AA64DFR1_ALLOW (0ULL)
> +
> +/*
> + * No support for implementation defined features.
> + */
> +#define PVM_ID_AA64AFR0_ALLOW (0ULL)
> +#define PVM_ID_AA64AFR1_ALLOW (0ULL)
> +
> +/*
> + * No restrictions on instructions implemented in AArch64.
> + */
> +#define PVM_ID_AA64ISAR0_ALLOW (~0ULL)
> +#define PVM_ID_AA64ISAR1_ALLOW (~0ULL)

Hmm, I really like the explicit allow masks, but these are no longer
explicit. Why not set just the safe, supported features like we do
with the other registers? In fact, I feel it's a bit wrong to set the
res0 fields for ID_AA64ISAR0.

> +
> +#endif /* __ARM64_KVM_FIXED_CONFIG_H__ */
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 657d0c94cf82..5afd14ab15b9 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -115,7 +115,12 @@ int __pkvm_init(phys_addr_t phys, unsigned long size, unsigned long nr_cpus,
>  void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
>  #endif
>  
> +extern u64 kvm_nvhe_sym(id_aa64pfr0_el1_sys_val);
> +extern u64 kvm_nvhe_sym(id_aa64pfr1_el1_sys_val);
> +extern u64 kvm_nvhe_sym(id_aa64isar0_el1_sys_val);
> +extern u64 kvm_nvhe_sym(id_aa64isar1_el1_sys_val);
>  extern u64 kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val);
>  extern u64 kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val);
> +extern u64 kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val);
>  
>  #endif /* __ARM64_KVM_HYP_H__ */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index fe102cd2e518..6aa7b0c5bf21 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1802,8 +1802,13 @@ static int kvm_hyp_init_protection(u32 hyp_va_bits)
>  	void *addr = phys_to_virt(hyp_mem_base);
>  	int ret;
>  
> +	kvm_nvhe_sym(id_aa64pfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +	kvm_nvhe_sym(id_aa64pfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
> +	kvm_nvhe_sym(id_aa64isar0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR0_EL1);
> +	kvm_nvhe_sym(id_aa64isar1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
>  	kvm_nvhe_sym(id_aa64mmfr0_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>  	kvm_nvhe_sym(id_aa64mmfr1_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> +	kvm_nvhe_sym(id_aa64mmfr2_el1_sys_val) = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
>  
>  	ret = create_hyp_mappings(addr, addr + hyp_mem_size, PAGE_HYP);
>  	if (ret)
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h b/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
> new file mode 100644
> index 000000000000..f5c94a46bc74
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/include/nvhe/sys_regs.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Google LLC
> + * Author: Fuad Tabba <tabba@google.com>
> + */
> +
> +#ifndef __ARM64_KVM_NVHE_SYS_REGS_H__
> +#define __ARM64_KVM_NVHE_SYS_REGS_H__
> +
> +#include <asm/kvm_host.h>
> +
> +bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code);
> +bool kvm_handle_pvm_sys64(struct kvm_vcpu *vcpu, u64 *exit_code);
> +bool kvm_handle_pvm_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code);
> +
> +u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64isar0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64mmfr1(const struct kvm_vcpu *vcpu);
> +u64 get_pvm_id_aa64mmfr2(const struct kvm_vcpu *vcpu);
> +
> +#endif /* __ARM64_KVM_NVHE_SYS_REGS_H__ */
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 5df6193fc430..a23f417a0c20 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -14,7 +14,7 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
>  
>  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
>  	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
> -	 cache.o setup.o mm.o mem_protect.o
> +	 cache.o setup.o mm.o mem_protect.o sys_regs.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
>  obj-y += $(lib-objs)
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index ebc0a5a4dd6a..41f05bf88f61 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -28,6 +28,7 @@
>  #include <asm/thread_info.h>
>  
>  #include <nvhe/mem_protect.h>
> +#include <nvhe/sys_regs.h>
>  
>  /* Non-VHE specific context */
>  DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
> diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> new file mode 100644
> index 000000000000..a7e836537154
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> @@ -0,0 +1,523 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Google LLC
> + * Author: Fuad Tabba <tabba@google.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_fixed_config.h>
> +#include <asm/kvm_mmu.h>
> +
> +#include <hyp/adjust_pc.h>
> +#include <hyp/switch.h>
> +
> +#include "../../sys_regs.h"
> +
> +/*
> + * Copies of the host's CPU features registers holding sanitized values at hyp.
> + */
> +u64 id_aa64pfr0_el1_sys_val;
> +u64 id_aa64pfr1_el1_sys_val;
> +u64 id_aa64isar0_el1_sys_val;
> +u64 id_aa64isar1_el1_sys_val;
> +u64 id_aa64mmfr2_el1_sys_val;
> +
> +static inline void inject_undef(struct kvm_vcpu *vcpu)
> +{
> +	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
> +
> +	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1 |
> +			     KVM_ARM64_EXCEPT_AA64_ELx_SYNC |
> +			     KVM_ARM64_PENDING_EXCEPTION);
> +
> +	__kvm_adjust_pc(vcpu);
> +
> +	write_sysreg_el1(esr, SYS_ESR);
> +	write_sysreg_el1(read_sysreg_el2(SYS_ELR), SYS_ELR);
> +}
> +
> +/*
> + * Inject an unknown/undefined exception to the guest while most of its sysregs
> + * are live.
> + */
> +static inline void __inject_undef(struct kvm_vcpu *vcpu)
> +{
> +	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
> +	*vcpu_cpsr(vcpu) = read_sysreg_el2(SYS_SPSR);
> +
> +	inject_undef(vcpu);
> +
> +	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
> +	write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
> +}
> +
> +/*
> + * Accessor for undefined accesses.
> + */
> +static bool undef_access(struct kvm_vcpu *vcpu,
> +			 struct sys_reg_params *p,
> +			 const struct sys_reg_desc *r)
> +{
> +	__inject_undef(vcpu);
> +	return false;
> +}
> +
> +/*
> + * Returns the restricted features values of the feature register based on the
> + * limitations in restrict_fields.
> + * A feature id field value of 0b0000 does not impose any restrictions.
> + * Note: Use only for unsigned feature field values.
> + */
> +static u64 get_restricted_features_unsigned(u64 sys_reg_val,
> +					    u64 restrict_fields)
> +{
> +	u64 value = 0UL;
> +	u64 mask = GENMASK_ULL(ARM64_FEATURE_FIELD_BITS - 1, 0);
> +
> +	/*
> +	 * According to the Arm Architecture Reference Manual, feature fields
> +	 * use increasing values to indicate increases in functionality.
> +	 * Iterate over the restricted feature fields and calculate the minimum
> +	 * unsigned value between the one supported by the system, and what the
> +	 * value is being restricted to.
> +	 */
> +	while (sys_reg_val && restrict_fields) {
> +		value |= min(sys_reg_val & mask, restrict_fields & mask);
> +		sys_reg_val &= ~mask;
> +		restrict_fields &= ~mask;
> +		mask <<= ARM64_FEATURE_FIELD_BITS;
> +	}
> +
> +	return value;
> +}
> +
> +/*
> + * Functions that return the value of feature id registers for protected VMs
> + * based on allowed features, system features, and KVM support.
> + */
> +
> +u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm *kvm = (const struct kvm *) kern_hyp_va(vcpu->kvm);

I didn't think checkpatch liked spaces after casts.


> +	u64 set_mask = 0;
> +	u64 allow_mask = PVM_ID_AA64PFR0_ALLOW;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		allow_mask &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_SVE);

I'm not sure why this is here. SVE is not set in PVM_ID_AA64PFR0_ALLOW
and there's even a comment for PVM_ID_AA64ZFR0_ALLOW stating that SVE
is not supported for protected VMs.

> +
> +	set_mask |= get_restricted_features_unsigned(id_aa64pfr0_el1_sys_val,
> +		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED);
> +
> +	/* Spectre and Meltdown mitigation in KVM */
> +	set_mask |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV2),
> +			       (u64)kvm->arch.pfr0_csv2);
> +	set_mask |= FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_CSV3),
> +			       (u64)kvm->arch.pfr0_csv3);
> +
> +	return (id_aa64pfr0_el1_sys_val & allow_mask) | set_mask;
> +}
> +
> +u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu)
> +{
> +	const struct kvm *kvm = (const struct kvm *) kern_hyp_va(vcpu->kvm);
> +	u64 allow_mask = PVM_ID_AA64PFR1_ALLOW;
> +
> +	if (!kvm_has_mte(kvm))
> +		allow_mask &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_MTE);

Again, I'm not sure why we're clearing bits we never set.

> +
> +	return id_aa64pfr1_el1_sys_val & allow_mask;
> +}
> +
> +u64 get_pvm_id_aa64zfr0(const struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * No support for Scalable Vectors, therefore, hyp has no sanitized
> +	 * copy of the feature id register.
> +	 */
> +	BUILD_BUG_ON(PVM_ID_AA64ZFR0_ALLOW != 0ULL);
> +	return 0;
> +}
> +
> +u64 get_pvm_id_aa64dfr0(const struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * No support for debug, including breakpoints, and watchpoints,
> +	 * therefore, pKVM has no sanitized copy of the feature id register.
> +	 */
> +	BUILD_BUG_ON(PVM_ID_AA64DFR0_ALLOW != 0ULL);
> +	return 0;
> +}
> +
> +u64 get_pvm_id_aa64dfr1(const struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * No support for debug, therefore, hyp has no sanitized copy of the
> +	 * feature id register.
> +	 */
> +	BUILD_BUG_ON(PVM_ID_AA64DFR1_ALLOW != 0ULL);
> +	return 0;
> +}
> +
> +u64 get_pvm_id_aa64afr0(const struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * No support for implementation defined features, therefore, hyp has no
> +	 * sanitized copy of the feature id register.
> +	 */
> +	BUILD_BUG_ON(PVM_ID_AA64AFR0_ALLOW != 0ULL);
> +	return 0;
> +}
> +
> +u64 get_pvm_id_aa64afr1(const struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * No support for implementation defined features, therefore, hyp has no
> +	 * sanitized copy of the feature id register.
> +	 */
> +	BUILD_BUG_ON(PVM_ID_AA64AFR1_ALLOW != 0ULL);
> +	return 0;
> +}
> +
> +u64 get_pvm_id_aa64isar0(const struct kvm_vcpu *vcpu)
> +{
> +	return id_aa64isar0_el1_sys_val & PVM_ID_AA64ISAR0_ALLOW;
> +}
> +
> +u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu)
> +{
> +	u64 allow_mask = PVM_ID_AA64ISAR1_ALLOW;
> +
> +	if (!vcpu_has_ptrauth(vcpu))
> +		allow_mask &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR1_APA) |
> +				ARM64_FEATURE_MASK(ID_AA64ISAR1_API) |
> +				ARM64_FEATURE_MASK(ID_AA64ISAR1_GPA) |
> +				ARM64_FEATURE_MASK(ID_AA64ISAR1_GPI));

So here, since PVM_ID_AA64ISAR1_ALLOW is ~0, we do actually clear bits
when the vcpu doesn't support ptrauth. I presume the trap handling for
ptrauth will be covered for protected VMs too when we don't clear them.

> +
> +	return id_aa64isar1_el1_sys_val & allow_mask;
> +}
> +
> +u64 get_pvm_id_aa64mmfr0(const struct kvm_vcpu *vcpu)
> +{
> +	u64 set_mask =
> +		get_restricted_features_unsigned(id_aa64mmfr0_el1_sys_val,
> +		PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED);

Rather than the above style, how about

	u64 set_mask;

	set_mask = get_restricted_features_unsigned(id_aa64mmfr0_el1_sys_val,
						    PVM_ID_AA64MMFR0_RESTRICT_UNSIGNED);

which is a best effort at staying in 80 chars and definitely stays
under 100, which is checkpatch's max. Alternatively, the local
function get_restricted_features_unsigned could be named more tersely.

> +
> +	return (id_aa64mmfr0_el1_sys_val & PVM_ID_AA64MMFR0_ALLOW) | set_mask;
> +}
> +
> +u64 get_pvm_id_aa64mmfr1(const struct kvm_vcpu *vcpu)
> +{
> +	return id_aa64mmfr1_el1_sys_val & PVM_ID_AA64MMFR1_ALLOW;
> +}
> +
> +u64 get_pvm_id_aa64mmfr2(const struct kvm_vcpu *vcpu)
> +{
> +	return id_aa64mmfr2_el1_sys_val & PVM_ID_AA64MMFR2_ALLOW;
> +}
> +
> +/* Read a sanitized cpufeature ID register by its sys_reg_desc. */
> +static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> +		       struct sys_reg_desc const *r)
> +{
> +	u32 id = reg_to_encoding(r);
> +
> +	switch (id) {
> +	case SYS_ID_AA64PFR0_EL1:
> +		return get_pvm_id_aa64pfr0(vcpu);
> +	case SYS_ID_AA64PFR1_EL1:
> +		return get_pvm_id_aa64pfr1(vcpu);
> +	case SYS_ID_AA64ZFR0_EL1:
> +		return get_pvm_id_aa64zfr0(vcpu);
> +	case SYS_ID_AA64DFR0_EL1:
> +		return get_pvm_id_aa64dfr0(vcpu);
> +	case SYS_ID_AA64DFR1_EL1:
> +		return get_pvm_id_aa64dfr1(vcpu);
> +	case SYS_ID_AA64AFR0_EL1:
> +		return get_pvm_id_aa64afr0(vcpu);
> +	case SYS_ID_AA64AFR1_EL1:
> +		return get_pvm_id_aa64afr1(vcpu);
> +	case SYS_ID_AA64ISAR0_EL1:
> +		return get_pvm_id_aa64isar0(vcpu);
> +	case SYS_ID_AA64ISAR1_EL1:
> +		return get_pvm_id_aa64isar1(vcpu);
> +	case SYS_ID_AA64MMFR0_EL1:
> +		return get_pvm_id_aa64mmfr0(vcpu);
> +	case SYS_ID_AA64MMFR1_EL1:
> +		return get_pvm_id_aa64mmfr1(vcpu);
> +	case SYS_ID_AA64MMFR2_EL1:
> +		return get_pvm_id_aa64mmfr2(vcpu);
> +	default:
> +		/*
> +		 * Should never happen because all cases are covered in
> +		 * pvm_sys_reg_descs[] below.
> +		 */
> +		BUG();
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Accessor for AArch32 feature id registers.
> + *
> + * The value of these registers is "unknown" according to the spec if AArch32
> + * isn't supported.
> + */
> +static bool pvm_access_id_aarch32(struct kvm_vcpu *vcpu,
> +				  struct sys_reg_params *p,
> +				  const struct sys_reg_desc *r)
> +{
> +	if (p->is_write)
> +		return undef_access(vcpu, p, r);
> +
> +	/*
> +	 * No support for AArch32 guests, therefore, pKVM has no sanitized copy
> +	 * of AArch32 feature id registers.
> +	 */
> +	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1),
> +		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) >
> +			ID_AA64PFR0_ELx_64BIT_ONLY);

I'd prefer to blow the 80 char soft limit here and do

		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_ELx_64BIT_ONLY);
> +
> +	/* Use 0 for architecturally "unknown" values. */
> +	p->regval = 0;
> +	return true;
> +}
> +
> +/*
> + * Accessor for AArch64 feature id registers.
> + *
> + * If access is allowed, set the regval to the protected VM's view of the
> + * register and return true.
> + * Otherwise, inject an undefined exception and return false.
> + */
> +static bool pvm_access_id_aarch64(struct kvm_vcpu *vcpu,
> +				  struct sys_reg_params *p,
> +				  const struct sys_reg_desc *r)
> +{
> +	if (p->is_write)
> +		return undef_access(vcpu, p, r);
> +
> +	p->regval = read_id_reg(vcpu, r);
> +	return true;
> +}
> +
> +/* Mark the specified system register as an AArch32 feature id register. */
> +#define AARCH32(REG) { SYS_DESC(REG), .access = pvm_access_id_aarch32 }
> +
> +/* Mark the specified system register as an AArch64 feature id register. */
> +#define AARCH64(REG) { SYS_DESC(REG), .access = pvm_access_id_aarch64 }
> +
> +/* Mark the specified system register as not being handled in hyp. */
> +#define HOST_HANDLED(REG) { SYS_DESC(REG), .access = NULL }
> +
> +/*
> + * Architected system registers.
> + * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
> + *
> + * NOTE: Anything not explicitly listed here is *restricted by default*, i.e.,
> + * it will lead to injecting an exception into the guest.
> + */
> +static const struct sys_reg_desc pvm_sys_reg_descs[] = {
> +	/* Cache maintenance by set/way operations are restricted. */
> +
> +	/* Debug and Trace Registers are restricted. */
> +
> +	/* AArch64 mappings of the AArch32 ID registers */
> +	/* CRm=1 */
> +	AARCH32(SYS_ID_PFR0_EL1),
> +	AARCH32(SYS_ID_PFR1_EL1),
> +	AARCH32(SYS_ID_DFR0_EL1),
> +	AARCH32(SYS_ID_AFR0_EL1),
> +	AARCH32(SYS_ID_MMFR0_EL1),
> +	AARCH32(SYS_ID_MMFR1_EL1),
> +	AARCH32(SYS_ID_MMFR2_EL1),
> +	AARCH32(SYS_ID_MMFR3_EL1),
> +
> +	/* CRm=2 */
> +	AARCH32(SYS_ID_ISAR0_EL1),
> +	AARCH32(SYS_ID_ISAR1_EL1),
> +	AARCH32(SYS_ID_ISAR2_EL1),
> +	AARCH32(SYS_ID_ISAR3_EL1),
> +	AARCH32(SYS_ID_ISAR4_EL1),
> +	AARCH32(SYS_ID_ISAR5_EL1),
> +	AARCH32(SYS_ID_MMFR4_EL1),
> +	AARCH32(SYS_ID_ISAR6_EL1),
> +
> +	/* CRm=3 */
> +	AARCH32(SYS_MVFR0_EL1),
> +	AARCH32(SYS_MVFR1_EL1),
> +	AARCH32(SYS_MVFR2_EL1),
> +	AARCH32(SYS_ID_PFR2_EL1),
> +	AARCH32(SYS_ID_DFR1_EL1),
> +	AARCH32(SYS_ID_MMFR5_EL1),
> +
> +	/* AArch64 ID registers */
> +	/* CRm=4 */
> +	AARCH64(SYS_ID_AA64PFR0_EL1),
> +	AARCH64(SYS_ID_AA64PFR1_EL1),
> +	AARCH64(SYS_ID_AA64ZFR0_EL1),
> +	AARCH64(SYS_ID_AA64DFR0_EL1),
> +	AARCH64(SYS_ID_AA64DFR1_EL1),
> +	AARCH64(SYS_ID_AA64AFR0_EL1),
> +	AARCH64(SYS_ID_AA64AFR1_EL1),
> +	AARCH64(SYS_ID_AA64ISAR0_EL1),
> +	AARCH64(SYS_ID_AA64ISAR1_EL1),
> +	AARCH64(SYS_ID_AA64MMFR0_EL1),
> +	AARCH64(SYS_ID_AA64MMFR1_EL1),
> +	AARCH64(SYS_ID_AA64MMFR2_EL1),
> +
> +	HOST_HANDLED(SYS_SCTLR_EL1),
> +	HOST_HANDLED(SYS_ACTLR_EL1),
> +	HOST_HANDLED(SYS_CPACR_EL1),
> +
> +	HOST_HANDLED(SYS_RGSR_EL1),
> +	HOST_HANDLED(SYS_GCR_EL1),
> +
> +	/* Scalable Vector Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_TTBR0_EL1),
> +	HOST_HANDLED(SYS_TTBR1_EL1),
> +	HOST_HANDLED(SYS_TCR_EL1),
> +
> +	HOST_HANDLED(SYS_APIAKEYLO_EL1),
> +	HOST_HANDLED(SYS_APIAKEYHI_EL1),
> +	HOST_HANDLED(SYS_APIBKEYLO_EL1),
> +	HOST_HANDLED(SYS_APIBKEYHI_EL1),
> +	HOST_HANDLED(SYS_APDAKEYLO_EL1),
> +	HOST_HANDLED(SYS_APDAKEYHI_EL1),
> +	HOST_HANDLED(SYS_APDBKEYLO_EL1),
> +	HOST_HANDLED(SYS_APDBKEYHI_EL1),
> +	HOST_HANDLED(SYS_APGAKEYLO_EL1),
> +	HOST_HANDLED(SYS_APGAKEYHI_EL1),
> +
> +	HOST_HANDLED(SYS_AFSR0_EL1),
> +	HOST_HANDLED(SYS_AFSR1_EL1),
> +	HOST_HANDLED(SYS_ESR_EL1),
> +
> +	HOST_HANDLED(SYS_ERRIDR_EL1),
> +	HOST_HANDLED(SYS_ERRSELR_EL1),
> +	HOST_HANDLED(SYS_ERXFR_EL1),
> +	HOST_HANDLED(SYS_ERXCTLR_EL1),
> +	HOST_HANDLED(SYS_ERXSTATUS_EL1),
> +	HOST_HANDLED(SYS_ERXADDR_EL1),
> +	HOST_HANDLED(SYS_ERXMISC0_EL1),
> +	HOST_HANDLED(SYS_ERXMISC1_EL1),
> +
> +	HOST_HANDLED(SYS_TFSR_EL1),
> +	HOST_HANDLED(SYS_TFSRE0_EL1),
> +
> +	HOST_HANDLED(SYS_FAR_EL1),
> +	HOST_HANDLED(SYS_PAR_EL1),
> +
> +	/* Performance Monitoring Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_MAIR_EL1),
> +	HOST_HANDLED(SYS_AMAIR_EL1),
> +
> +	/* Limited Ordering Regions Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_VBAR_EL1),
> +	HOST_HANDLED(SYS_DISR_EL1),
> +
> +	/* GIC CPU Interface registers are restricted. */
> +
> +	HOST_HANDLED(SYS_CONTEXTIDR_EL1),
> +	HOST_HANDLED(SYS_TPIDR_EL1),
> +
> +	HOST_HANDLED(SYS_SCXTNUM_EL1),
> +
> +	HOST_HANDLED(SYS_CNTKCTL_EL1),
> +
> +	HOST_HANDLED(SYS_CCSIDR_EL1),
> +	HOST_HANDLED(SYS_CLIDR_EL1),
> +	HOST_HANDLED(SYS_CSSELR_EL1),
> +	HOST_HANDLED(SYS_CTR_EL0),
> +
> +	/* Performance Monitoring Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_TPIDR_EL0),
> +	HOST_HANDLED(SYS_TPIDRRO_EL0),
> +
> +	HOST_HANDLED(SYS_SCXTNUM_EL0),
> +
> +	/* Activity Monitoring Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_CNTP_TVAL_EL0),
> +	HOST_HANDLED(SYS_CNTP_CTL_EL0),
> +	HOST_HANDLED(SYS_CNTP_CVAL_EL0),
> +
> +	/* Performance Monitoring Registers are restricted. */
> +
> +	HOST_HANDLED(SYS_DACR32_EL2),
> +	HOST_HANDLED(SYS_IFSR32_EL2),
> +	HOST_HANDLED(SYS_FPEXC32_EL2),
> +};
> +
> +/*
> + * Handler for protected VM restricted exceptions.
> + *
> + * Inject an undefined exception into the guest and return true to indicate that
> + * the hypervisor has handled the exit, and control should go back to the guest.
> + */
> +bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code)
> +{
> +	__inject_undef(vcpu);
> +	return true;
> +}
> +
> +/*
> + * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
> + *
> + * Returns true if the hypervisor has handled the exit, and control should go
> + * back to the guest, or false if it hasn't.
> + */
> +bool kvm_handle_pvm_sys64(struct kvm_vcpu *vcpu, u64 *exit_code)
> +{
> +	const struct sys_reg_desc *r;
> +	struct sys_reg_params params;
> +	unsigned long esr = kvm_vcpu_get_esr(vcpu);
> +	int Rt = kvm_vcpu_sys_get_rt(vcpu);
> +
> +	params = esr_sys64_to_params(esr);
> +	params.regval = vcpu_get_reg(vcpu, Rt);
> +
> +	r = find_reg(&params, pvm_sys_reg_descs, ARRAY_SIZE(pvm_sys_reg_descs));
> +
> +	/* Undefined access (RESTRICTED). */
> +	if (r == NULL)
> +		return kvm_handle_pvm_restricted(vcpu, exit_code);
> +
> +	/* Handled by the host (HOST_HANDLED) */
> +	if (r->access == NULL)
> +		return kvm_hyp_handle_sysreg(vcpu, exit_code);
> +
> +	/* Handled by hyp: skip instruction if instructed to do so. */
> +	if (r->access(vcpu, &params, r))
> +		__kvm_skip_instr(vcpu);
> +
> +	if (!params.is_write)
> +		vcpu_set_reg(vcpu, Rt, params.regval);
> +
> +	return true;
> +}
> +
> +/*
> + * Handler for protected floating-point and Advanced SIMD accesses.
> + *
> + * Returns true if the hypervisor has handled the exit, and control should go
> + * back to the guest, or false if it hasn't.
> + */
> +bool kvm_handle_pvm_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
> +{
> +	/* Linux guests assume support for floating-point and Advanced SIMD. */
> +	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_FP),
> +				PVM_ID_AA64PFR0_ALLOW));
> +	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD),
> +				PVM_ID_AA64PFR0_ALLOW));
> +
> +	return kvm_hyp_handle_fpsimd(vcpu, exit_code);
> +}
> -- 
> 2.33.0.259.gc128427fd7-goog
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
