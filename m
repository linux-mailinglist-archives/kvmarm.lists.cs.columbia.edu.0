Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BACEA409F52
	for <lists+kvmarm@lfdr.de>; Mon, 13 Sep 2021 23:44:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D70C4B163;
	Mon, 13 Sep 2021 17:44:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Y6Th2iWkZ8I; Mon, 13 Sep 2021 17:44:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C81B34B1DD;
	Mon, 13 Sep 2021 17:43:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 339E74B13E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 17:43:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcgI2i09DYQK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Sep 2021 17:43:56 -0400 (EDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F17804B104
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 17:43:55 -0400 (EDT)
Received: by mail-pf1-f173.google.com with SMTP id v123so10126549pfb.11
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sG2eyH9Bgb1L/y1jzf6CQp6ymvgMkzFT8CFUJyXDBcQ=;
 b=TWS+2rX8IxtjrkxvQtcSH/ADskq5QVzTpyXa/gp84aAP+wRjMIAzVdqhgRvPzuL4mo
 ChskmWITqBwQR4TyWlFo7HszU3Tk/JmS55gCwXHHKOJ1FARnRAHMIJwTLcvr3agz6NMS
 XtT+97h0KqDF2lHmoQ9/AfAAqJ6Lk0q9ywzmHxHD/uRQdXVAAWVwHgCdsCRK7klJ9Er3
 XOGXQq1QSDafboUYWUSM8EHRLgHYORG2Mrw7xS4IFqpOCsi/U3PvonrnEe+0i7wIBB0i
 gIqkd49tlbo/10Xd4fShNYZ0ZGaM7NXx0v+hBiPlkMdeF6rd+IHT0FHevBm1eqxhjAC2
 1UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sG2eyH9Bgb1L/y1jzf6CQp6ymvgMkzFT8CFUJyXDBcQ=;
 b=VNolH40ZXjsptEtH1ZBUb4U+08fL+2Cb+/J9T7c9GnTE0Hs9MgScjbE7Kw+JAn/TEV
 5ioC5XsLzLHhpvgimw/x1ioj95xOs8xSjapI2VX1sYuRrrjkTWxh1qtctPLR/+GHT36E
 961RNrmtEoPIooiYv3kfAumAm4cL8rXCnvKw5pva2uMG7tPxANlQxTWsoYqXWL2ECMOI
 +IfWVOTuc1hiBZXHsI+9NpvyexX92EOe7MZ+3LIu9OcSFreqNJO/FG91j7LwkJ8bAPZH
 8zJOqkLFF3df+ZdnBI2bP1Job8fxIRw6AaHFqFrebB5fUhICRAKhKWF0iG84D3wsPvni
 dx1w==
X-Gm-Message-State: AOAM530slvuB5mJy0G5KFN/U93VbIJXozC4tkXZMI6Oq4mvaUCzzQF2E
 ohxboH5RGRKl3JaIfXBVldRfzg==
X-Google-Smtp-Source: ABdhPJwgblB3hOcn7bN2z+YFe7ozcUxqKzo3wlKfTkc5oVOZHVQhtOLvuw4PrXPWus8czkAZNPgAWg==
X-Received: by 2002:aa7:8387:0:b029:395:a683:a0e6 with SMTP id
 u7-20020aa783870000b0290395a683a0e6mr1441934pfm.12.1631569434793; 
 Mon, 13 Sep 2021 14:43:54 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com.
 [34.83.12.150])
 by smtp.gmail.com with ESMTPSA id u15sm8384455pfl.14.2021.09.13.14.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:43:54 -0700 (PDT)
Date: Mon, 13 Sep 2021 14:43:50 -0700
From: Ricardo Koller <ricarkol@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v5 04/14] KVM: arm64: selftests: Introduce
 ARM64_SYS_KVM_REG
Message-ID: <YT/GFj9GVv6ZD8I5@google.com>
References: <20210913204930.130715-1-rananta@google.com>
 <20210913204930.130715-5-rananta@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913204930.130715-5-rananta@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

On Mon, Sep 13, 2021 at 08:49:20PM +0000, Raghavendra Rao Ananta wrote:
> With the inclusion of sysreg.h, that brings in system register
> encodings, it would be redundant to re-define register encodings
> again in processor.h to use it with ARM64_SYS_REG for the KVM
> functions such as set_reg() or get_reg(). Hence, add helper macro,
> ARM64_SYS_KVM_REG, that converts SYS_* definitions in sysreg.h
> into ARM64_SYS_REG definitions.
> 
> Also replace all the users of ARM64_SYS_REG, relying on
> the encodings created in processor.h, with ARM64_SYS_KVM_REG and
> remove the definitions.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/aarch64/debug-exceptions.c  |  2 +-
>  .../selftests/kvm/aarch64/psci_cpu_on_test.c  |  2 +-
>  .../selftests/kvm/include/aarch64/processor.h | 20 ++++++++++---------
>  .../selftests/kvm/lib/aarch64/processor.c     | 16 +++++++--------
>  4 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> index 11fd23e21cb4..ea189d83abf7 100644
> --- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> +++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> @@ -190,7 +190,7 @@ static int debug_version(struct kvm_vm *vm)
>  {
>  	uint64_t id_aa64dfr0;
>  
> -	get_reg(vm, VCPU_ID, ARM64_SYS_REG(ID_AA64DFR0_EL1), &id_aa64dfr0);
> +	get_reg(vm, VCPU_ID, KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &id_aa64dfr0);
>  	return id_aa64dfr0 & 0xf;
>  }
>  
> diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
> index 018c269990e1..4c5f6814030f 100644
> --- a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
> +++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
> @@ -91,7 +91,7 @@ int main(void)
>  	init.features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
>  	aarch64_vcpu_add_default(vm, VCPU_ID_TARGET, &init, guest_main);
>  
> -	get_reg(vm, VCPU_ID_TARGET, ARM64_SYS_REG(MPIDR_EL1), &target_mpidr);
> +	get_reg(vm, VCPU_ID_TARGET, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &target_mpidr);
>  	vcpu_args_set(vm, VCPU_ID_SOURCE, 1, target_mpidr & MPIDR_HWID_BITMASK);
>  	vcpu_run(vm, VCPU_ID_SOURCE);
>  
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 7989e832cafb..93797783abad 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -16,15 +16,17 @@
>  #define ARM64_CORE_REG(x) (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>  			   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>  
> -#define CPACR_EL1               3, 0,  1, 0, 2
> -#define TCR_EL1                 3, 0,  2, 0, 2
> -#define MAIR_EL1                3, 0, 10, 2, 0
> -#define MPIDR_EL1               3, 0,  0, 0, 5
> -#define TTBR0_EL1               3, 0,  2, 0, 0
> -#define SCTLR_EL1               3, 0,  1, 0, 0
> -#define VBAR_EL1                3, 0, 12, 0, 0
> -
> -#define ID_AA64DFR0_EL1         3, 0,  0, 5, 0
> +/*
> + * KVM_ARM64_SYS_REG(sys_reg_id): Helper macro to convert
> + * SYS_* register definitions in asm/sysreg.h to use in KVM
> + * calls such as get_reg() and set_reg().
> + */
> +#define KVM_ARM64_SYS_REG(sys_reg_id)			\
> +	ARM64_SYS_REG(sys_reg_Op0(sys_reg_id),		\
> +			sys_reg_Op1(sys_reg_id),	\
> +			sys_reg_CRn(sys_reg_id),	\
> +			sys_reg_CRm(sys_reg_id),	\
> +			sys_reg_Op2(sys_reg_id))
>  
>  /*
>   * Default MAIR
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 632b74d6b3ca..db64ee206064 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -232,10 +232,10 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
>  	 * Enable FP/ASIMD to avoid trapping when accessing Q0-Q15
>  	 * registers, which the variable argument list macros do.
>  	 */
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(CPACR_EL1), 3 << 20);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_CPACR_EL1), 3 << 20);
>  
> -	get_reg(vm, vcpuid, ARM64_SYS_REG(SCTLR_EL1), &sctlr_el1);
> -	get_reg(vm, vcpuid, ARM64_SYS_REG(TCR_EL1), &tcr_el1);
> +	get_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), &sctlr_el1);
> +	get_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), &tcr_el1);
>  
>  	switch (vm->mode) {
>  	case VM_MODE_P52V48_4K:
> @@ -273,10 +273,10 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
>  	tcr_el1 |= (1 << 8) | (1 << 10) | (3 << 12);
>  	tcr_el1 |= (64 - vm->va_bits) /* T0SZ */;
>  
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(SCTLR_EL1), sctlr_el1);
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(TCR_EL1), tcr_el1);
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(MAIR_EL1), DEFAULT_MAIR_EL1);
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(TTBR0_EL1), vm->pgd);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_SCTLR_EL1), sctlr_el1);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
>  }
>  
>  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
> @@ -362,7 +362,7 @@ void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid)
>  {
>  	extern char vectors;
>  
> -	set_reg(vm, vcpuid, ARM64_SYS_REG(VBAR_EL1), (uint64_t)&vectors);
> +	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_VBAR_EL1), (uint64_t)&vectors);
>  }
>  
>  void route_exception(struct ex_regs *regs, int vector)
> -- 
> 2.33.0.309.g3052b89438-goog
> 

Reviewed-by: Ricardo Koller <ricarkol@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
