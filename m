Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DFED451856E
	for <lists+kvmarm@lfdr.de>; Tue,  3 May 2022 15:28:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C5894B11A;
	Tue,  3 May 2022 09:28:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ERVTIIn7z7w; Tue,  3 May 2022 09:28:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 455F34B118;
	Tue,  3 May 2022 09:28:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDF9D49EE8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 09:28:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZWTLVsP3dW2 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 May 2022 09:28:11 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2283649EE3
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 09:28:11 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3CC5D61752;
 Tue,  3 May 2022 13:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA10C385A4;
 Tue,  3 May 2022 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651584489;
 bh=QwmIUlQM1eJ2fVKn0TQalKPtO5mO8fMZ2qGfALJ3p2M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nV6nI62F9/ENkoFrx/W8/AeBXZQdbDASzXOPkx6Crdl459IHpVQDUUU8DTWatghYg
 bf3nMojsN3w5QJbaasLmySzQ54yT33rVDJ60k3EsSvMj9ga7eumHxWGkNr4JJZ/Ho2
 bLCvmNhv1Nb0GGBXtD7dOokyrv3Xkz3ky3keANuO4hp71ujLV8EA3CLY1qg+T+7LVA
 n6p7lzVt8Wu2PA8uWuMW5+ZyLHycm+rzLklTZx5+x/NTJNjxzbhGyarL5Xsht62RGO
 pUB3BBzVIXLKPOqqpSce0cWx4t4s7/sqyh6WYRQNhGTeU7+7wDjFsipS69bulJ4d94
 YdvcKGpS2crgA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nlsZS-008eUp-So; Tue, 03 May 2022 14:28:06 +0100
Date: Tue, 03 May 2022 14:28:06 +0100
Message-ID: <87czgu9255.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v7 2/9] KVM: arm64: Setup a framework for hypercall bitmap
 firmware registers
In-Reply-To: <20220502233853.1233742-3-rananta@google.com>
References: <20220502233853.1233742-1-rananta@google.com>
 <20220502233853.1233742-3-rananta@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rananta@google.com, drjones@redhat.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, pshier@google.com,
 ricarkol@google.com, oupton@google.com, reijiw@google.com,
 jingzhangos@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, gshan@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Tue, 03 May 2022 00:38:46 +0100,
Raghavendra Rao Ananta <rananta@google.com> wrote:
> 
> KVM regularly introduces new hypercall services to the guests without
> any consent from the userspace. This means, the guests can observe
> hypercall services in and out as they migrate across various host
> kernel versions. This could be a major problem if the guest
> discovered a hypercall, started using it, and after getting migrated
> to an older kernel realizes that it's no longer available. Depending
> on how the guest handles the change, there's a potential chance that
> the guest would just panic.
> 
> As a result, there's a need for the userspace to elect the services
> that it wishes the guest to discover. It can elect these services
> based on the kernels spread across its (migration) fleet. To remedy
> this, extend the existing firmware pseudo-registers, such as
> KVM_REG_ARM_PSCI_VERSION, but by creating a new COPROC register space
> for all the hypercall services available.
> 
> These firmware registers are categorized based on the service call
> owners, but unlike the existing firmware pseudo-registers, they hold
> the features supported in the form of a bitmap.
> 
> During the VM initialization, the registers are set to upper-limit of
> the features supported by the corresponding registers. It's expected
> that the VMMs discover the features provided by each register via
> GET_ONE_REG, and write back the desired values using SET_ONE_REG.
> KVM allows this modification only until the VM has started.
> 
> Some of the standard features are not mapped to any bits of the
> registers. But since they can recreate the original problem of
> making it available without userspace's consent, they need to
> be explicitly added to the case-list in
> kvm_hvc_call_default_allowed(). Any function-id that's not enabled
> via the bitmap, or not listed in kvm_hvc_call_default_allowed, will
> be returned as SMCCC_RET_NOT_SUPPORTED to the guest.
> 
> Older userspace code can simply ignore the feature and the
> hypercall services will be exposed unconditionally to the guests,
> thus ensuring backward compatibility.
> 
> In this patch, the framework adds the register only for ARM's standard
> secure services (owner value 4). Currently, this includes support only
> for ARM True Random Number Generator (TRNG) service, with bit-0 of the
> register representing mandatory features of v1.0. Other services are
> momentarily added in the upcoming patches.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  12 ++++
>  arch/arm64/include/uapi/asm/kvm.h |   9 +++
>  arch/arm64/kvm/arm.c              |   1 +
>  arch/arm64/kvm/guest.c            |   8 ++-
>  arch/arm64/kvm/hypercalls.c       | 106 ++++++++++++++++++++++++++++++
>  arch/arm64/kvm/psci.c             |  13 ++++
>  include/kvm/arm_hypercalls.h      |   6 ++
>  include/kvm/arm_psci.h            |   2 +-
>  8 files changed, 154 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 94a27a7520f4..fef597af0beb 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -101,6 +101,15 @@ struct kvm_s2_mmu {
>  struct kvm_arch_memory_slot {
>  };
>  
> +/**
> + * struct kvm_smccc_features: Descriptor of the hypercall services exposed to the guests
> + *
> + * @std_bmap: Bitmap of standard secure service calls
> + */
> +struct kvm_smccc_features {
> +	unsigned long std_bmap;
> +};
> +
>  struct kvm_arch {
>  	struct kvm_s2_mmu mmu;
>  
> @@ -150,6 +159,9 @@ struct kvm_arch {
>  
>  	u8 pfr0_csv2;
>  	u8 pfr0_csv3;
> +
> +	/* Hypercall features firmware registers' descriptor */
> +	struct kvm_smccc_features smccc_feat;
>  };
>  
>  struct kvm_vcpu_fault_info {
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index c1b6ddc02d2f..0b79d2dc6ffd 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -332,6 +332,15 @@ struct kvm_arm_copy_mte_tags {
>  #define KVM_ARM64_SVE_VLS_WORDS	\
>  	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
>  
> +/* Bitmap feature firmware registers */
> +#define KVM_REG_ARM_FW_FEAT_BMAP		(0x0016 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM_FW_FEAT_BMAP_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
> +						KVM_REG_ARM_FW_FEAT_BMAP |	\
> +						((r) & 0xffff))
> +
> +#define KVM_REG_ARM_STD_BMAP			KVM_REG_ARM_FW_FEAT_BMAP_REG(0)
> +#define KVM_REG_ARM_STD_BIT_TRNG_V1_0		0
> +
>  /* Device Control API: ARM VGIC */
>  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
>  #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 523bc934fe2f..a37fadbd617e 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -156,6 +156,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.max_vcpus = kvm_arm_default_max_vcpus();
>  
>  	set_default_spectre(kvm);
> +	kvm_arm_init_hypercalls(kvm);
>  
>  	return ret;
>  out_free_stage2_pgd:
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 0d5cca56cbda..8c607199cad1 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -756,7 +756,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  
>  	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
>  	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
> -	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
> +	case KVM_REG_ARM_FW:
> +	case KVM_REG_ARM_FW_FEAT_BMAP:
> +		return kvm_arm_get_fw_reg(vcpu, reg);
>  	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
>  	}
>  
> @@ -774,7 +776,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  
>  	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
>  	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
> -	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
> +	case KVM_REG_ARM_FW:
> +	case KVM_REG_ARM_FW_FEAT_BMAP:
> +		return kvm_arm_set_fw_reg(vcpu, reg);
>  	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
>  	}
>  
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index fa6d9378d8e7..5c53fd1f5690 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -58,6 +58,48 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
>  	val[3] = lower_32_bits(cycles);
>  }
>  
> +static bool kvm_arm_fw_reg_feat_enabled(unsigned long *reg_bmap, unsigned long feat_bit)
> +{
> +	return test_bit(feat_bit, reg_bmap);
> +}

Please use test_bit(std_bmap, bit) directly. It is just as readable as
kvm_arm_fw_reg_feat_enabled.

> +
> +static bool kvm_hvc_call_default_allowed(u32 func_id)
> +{
> +	switch (func_id) {
> +	/*
> +	 * List of function-ids that are not gated with the bitmapped feature
> +	 * firmware registers, and are to be allowed for servicing the call by default.
> +	 */
> +	case ARM_SMCCC_VERSION_FUNC_ID:
> +	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
> +	case ARM_SMCCC_HV_PV_TIME_FEATURES:
> +	case ARM_SMCCC_HV_PV_TIME_ST:
> +	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
> +	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
> +	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
> +		return true;
> +	default:
> +		return kvm_psci_func_id_is_valid(func_id);
> +	}
> +}
> +
> +static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
> +{
> +	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
> +
> +	switch (func_id) {
> +	case ARM_SMCCC_TRNG_VERSION:
> +	case ARM_SMCCC_TRNG_FEATURES:
> +	case ARM_SMCCC_TRNG_GET_UUID:
> +	case ARM_SMCCC_TRNG_RND32:
> +	case ARM_SMCCC_TRNG_RND64:
> +		return kvm_arm_fw_reg_feat_enabled(&smccc_feat->std_bmap,
> +						KVM_REG_ARM_STD_BIT_TRNG_V1_0);
> +	default:
> +		return kvm_hvc_call_default_allowed(func_id);
> +	}
> +}
> +
>  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  {
>  	u32 func_id = smccc_get_function(vcpu);
> @@ -65,6 +107,9 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  	u32 feature;
>  	gpa_t gpa;
>  
> +	if (!kvm_hvc_call_allowed(vcpu, func_id))
> +		goto out;
> +
>  	switch (func_id) {
>  	case ARM_SMCCC_VERSION_FUNC_ID:
>  		val[0] = ARM_SMCCC_VERSION_1_1;
> @@ -155,6 +200,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  		return kvm_psci_call(vcpu);
>  	}
>  
> +out:
>  	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
>  	return 1;
>  }
> @@ -164,8 +210,16 @@ static const u64 kvm_arm_fw_reg_ids[] = {
>  	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
>  	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
>  	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3,
> +	KVM_REG_ARM_STD_BMAP,
>  };
>  
> +void kvm_arm_init_hypercalls(struct kvm *kvm)
> +{
> +	struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;
> +
> +	smccc_feat->std_bmap = KVM_ARM_SMCCC_STD_FEATURES;
> +}
> +
>  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
>  {
>  	return ARRAY_SIZE(kvm_arm_fw_reg_ids);
> @@ -237,6 +291,7 @@ static int get_kernel_wa_level(u64 regid)
>  
>  int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
> +	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
>  	void __user *uaddr = (void __user *)(long)reg->addr;
>  	u64 val;
>  
> @@ -249,6 +304,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3:
>  		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
>  		break;
> +	case KVM_REG_ARM_STD_BMAP:
> +		val = READ_ONCE(smccc_feat->std_bmap);
> +		break;
>  	default:
>  		return -ENOENT;
>  	}
> @@ -259,6 +317,52 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return 0;
>  }
>  
> +static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
> +{
> +	int ret = 0;
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;
> +	unsigned long *fw_reg_bmap, fw_reg_features;
> +
> +	switch (reg_id) {
> +	case KVM_REG_ARM_STD_BMAP:
> +		fw_reg_bmap = &smccc_feat->std_bmap;
> +		fw_reg_features = KVM_ARM_SMCCC_STD_FEATURES;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +
> +	/* Check for unsupported bit */
> +	if (val & ~fw_reg_features)
> +		return -EINVAL;
> +
> +	/*
> +	 * Return -EBUSY if the VM (any vCPU) has already started running.
> +	 *
> +	 * To avoid unnecessary serialization of kvm->lock, check for
> +	 * KVM_ARCH_FLAG_HAS_RAN_ONCE, or if there's an update to the
> +	 * current bitmap's value, before grabbing the lock.
> +	 */
> +	if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags))
> +		return -EBUSY;
> +
> +	if (val == *fw_reg_bmap)
> +		return 0;

Honestly, I don't think we need this fast path. It only makes the
error case fast, and it is the one we really don't care about. All
that can go.

> +
> +	mutex_lock(&kvm->lock);
> +
> +	if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	WRITE_ONCE(*fw_reg_bmap, val);
> +out:
> +	mutex_unlock(&kvm->lock);
> +	return ret;
> +}
> +
>  int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  {
>  	void __user *uaddr = (void __user *)(long)reg->addr;
> @@ -337,6 +441,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  			return -EINVAL;
>  
>  		return 0;
> +	case KVM_REG_ARM_STD_BMAP:
> +		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
>  	default:
>  		return -ENOENT;
>  	}
> diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
> index 4bb76eb09248..94111f02674f 100644
> --- a/arch/arm64/kvm/psci.c
> +++ b/arch/arm64/kvm/psci.c
> @@ -437,3 +437,16 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
>  		return -EINVAL;
>  	}
>  }
> +
> +bool kvm_psci_func_id_is_valid(u32 func_id)
> +{
> +	if (ARM_SMCCC_OWNER_NUM(func_id) == ARM_SMCCC_OWNER_STANDARD &&
> +		ARM_SMCCC_FUNC_NUM(func_id) >= 0 && ARM_SMCCC_FUNC_NUM(func_id) <= 0x1f)

The second term is pretty much useless: func_id is a u32, and
FUNC_NUM() only extracts the bottom 16 bits. So this is always an
unsigned quantity, and the test means nothing. A good compiler should
tell you that (but I guess our compilers are all terrible).

> +		return true;
> +
> +	/* KVM's PSCI 0.1 doesn't comply with SMCCC, and has its own function-id base and range */
> +	if (func_id >= KVM_PSCI_FN(0) && func_id <= KVM_PSCI_FN(3))
> +		return true;
> +
> +	return false;
> +}

Also, why is this stuck in psci.c, while the *only* user seems to be
in hypercall.h?

> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> index 5d38628a8d04..c832e8411609 100644
> --- a/include/kvm/arm_hypercalls.h
> +++ b/include/kvm/arm_hypercalls.h
> @@ -6,6 +6,11 @@
>  
>  #include <asm/kvm_emulate.h>
>  
> +/* Last valid bit of the bitmapped firmware registers */
> +#define KVM_REG_ARM_STD_BMAP_BIT_MAX		0

Does this bit represent KVM_REG_ARM_STD_BIT_TRNG_V1_0? If so, this is
very error prone. You really want to keep the definitions together so
that you can update the max when adding something else.

> +
> +#define KVM_ARM_SMCCC_STD_FEATURES		GENMASK(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
> +
>  int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
>  
>  static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
> @@ -42,6 +47,7 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
>  
>  struct kvm_one_reg;
>  
> +void kvm_arm_init_hypercalls(struct kvm *kvm);
>  int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
>  int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
>  int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
> index 6e55b9283789..1f9ec5f2e513 100644
> --- a/include/kvm/arm_psci.h
> +++ b/include/kvm/arm_psci.h
> @@ -36,7 +36,7 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
>  	return KVM_ARM_PSCI_0_1;
>  }
>  
> -
>  int kvm_psci_call(struct kvm_vcpu *vcpu);
> +bool kvm_psci_func_id_is_valid(u32 func_id);

As I mentioned above, I don't think this should be globally visible.

>  
>  #endif /* __KVM_ARM_PSCI_H__ */
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 
> 

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
