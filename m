Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B283A50F140
	for <lists+kvmarm@lfdr.de>; Tue, 26 Apr 2022 08:41:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA6324B204;
	Tue, 26 Apr 2022 02:41:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zlfOtDuNcmG4; Tue, 26 Apr 2022 02:41:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F4644B1EC;
	Tue, 26 Apr 2022 02:41:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA13D4A0FE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 02:41:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbwVNjJvlZwd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Apr 2022 02:41:08 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EDE049F5D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 02:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650955267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaxfFpiwJIOoU//KMEFt34Dr7h93sV4bGjReNBc2liQ=;
 b=IfdKtb1TZrVM9qh8zLyYvD1v9YOAhUbfhlbpTB83vV1pKcGzh0XA0fXBm9sJwaUDThswOK
 vkaObhhP2RnneF3VgEHoPHeRfU8yetq89yapk4Acp/JbjaN5QX/b4GQ8JmTNIjN8oSBj0n
 hbjdkW4cyLMhKTKc11LkMUYI2bZZiOk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-j3eAS5owPFKpkX7Q1MXcXQ-1; Tue, 26 Apr 2022 02:41:01 -0400
X-MC-Unique: j3eAS5owPFKpkX7Q1MXcXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0D42800882;
 Tue, 26 Apr 2022 06:41:00 +0000 (UTC)
Received: from [10.72.13.230] (ovpn-13-230.pek2.redhat.com [10.72.13.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04500463EC1;
 Tue, 26 Apr 2022 06:40:52 +0000 (UTC)
Subject: Re: [PATCH v6 4/9] KVM: arm64: Add vendor hypervisor firmware register
To: Raghavendra Rao Ananta <rananta@google.com>, Marc Zyngier
 <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220423000328.2103733-1-rananta@google.com>
 <20220423000328.2103733-5-rananta@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <a5c43c41-8981-07f7-8bc7-6aabbaa05436@redhat.com>
Date: Tue, 26 Apr 2022 14:40:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220423000328.2103733-5-rananta@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 4/23/22 8:03 AM, Raghavendra Rao Ananta wrote:
> Introduce the firmware register to hold the vendor specific
> hypervisor service calls (owner value 6) as a bitmap. The
> bitmap represents the features that'll be enabled for the
> guest, as configured by the user-space. Currently, this
> includes support for KVM-vendor features along with
> reading the UID, represented by bit-0, and Precision Time
> Protocol (PTP), represented by bit-1.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  2 ++
>   arch/arm64/include/uapi/asm/kvm.h |  4 ++++
>   arch/arm64/kvm/hypercalls.c       | 23 ++++++++++++++++++-----
>   include/kvm/arm_hypercalls.h      |  2 ++
>   4 files changed, 26 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 27d4b2a7970e..a025c2ba012a 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -106,10 +106,12 @@ struct kvm_arch_memory_slot {
>    *
>    * @std_bmap: Bitmap of standard secure service calls
>    * @std_hyp_bmap: Bitmap of standard hypervisor service calls
> + * @vendor_hyp_bmap: Bitmap of vendor specific hypervisor service calls
>    */
>   struct kvm_smccc_features {
>   	unsigned long std_bmap;
>   	unsigned long std_hyp_bmap;
> +	unsigned long vendor_hyp_bmap;
>   };
>   
>   struct kvm_arch {
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index 9eecc7ee8c14..e7d5ae222684 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -344,6 +344,10 @@ struct kvm_arm_copy_mte_tags {
>   #define KVM_REG_ARM_STD_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(1)
>   #define KVM_REG_ARM_STD_HYP_BIT_PV_TIME		0
>   
> +#define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(2)
> +#define KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT	0
> +#define KVM_REG_ARM_VENDOR_HYP_BIT_PTP		1
> +
>   /* Device Control API: ARM VGIC */
>   #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
>   #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index f097bebdad39..76e626d0e699 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -72,9 +72,6 @@ static bool kvm_hvc_call_default_allowed(struct kvm_vcpu *vcpu, u32 func_id)
>   	 */
>   	case ARM_SMCCC_VERSION_FUNC_ID:
>   	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
> -	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
> -	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
> -	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
>   		return true;
>   	default:
>   		return kvm_psci_func_id_is_valid(vcpu, func_id);
> @@ -97,6 +94,13 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
>   	case ARM_SMCCC_HV_PV_TIME_ST:
>   		return kvm_arm_fw_reg_feat_enabled(&smccc_feat->std_hyp_bmap,
>   					KVM_REG_ARM_STD_HYP_BIT_PV_TIME);
> +	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
> +	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
> +		return kvm_arm_fw_reg_feat_enabled(&smccc_feat->vendor_hyp_bmap,
> +					KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT);
> +	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
> +		return kvm_arm_fw_reg_feat_enabled(&smccc_feat->vendor_hyp_bmap,
> +					KVM_REG_ARM_VENDOR_HYP_BIT_PTP);
>   	default:
>   		return kvm_hvc_call_default_allowed(vcpu, func_id);
>   	}
> @@ -189,8 +193,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>   		val[3] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
>   		break;
>   	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
> -		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
> -		val[0] |= BIT(ARM_SMCCC_KVM_FUNC_PTP);
> +		val[0] = smccc_feat->vendor_hyp_bmap;
>   		break;
>   	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
>   		kvm_ptp_get_time(vcpu, val);
> @@ -217,6 +220,7 @@ static const u64 kvm_arm_fw_reg_ids[] = {
>   	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3,
>   	KVM_REG_ARM_STD_BMAP,
>   	KVM_REG_ARM_STD_HYP_BMAP,
> +	KVM_REG_ARM_VENDOR_HYP_BMAP,
>   };
>   
>   void kvm_arm_init_hypercalls(struct kvm *kvm)
> @@ -225,6 +229,7 @@ void kvm_arm_init_hypercalls(struct kvm *kvm)
>   
>   	smccc_feat->std_bmap = KVM_ARM_SMCCC_STD_FEATURES;
>   	smccc_feat->std_hyp_bmap = KVM_ARM_SMCCC_STD_HYP_FEATURES;
> +	smccc_feat->vendor_hyp_bmap = KVM_ARM_SMCCC_VENDOR_HYP_FEATURES;
>   }
>   
>   int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
> @@ -317,6 +322,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   	case KVM_REG_ARM_STD_HYP_BMAP:
>   		val = READ_ONCE(smccc_feat->std_hyp_bmap);
>   		break;
> +	case KVM_REG_ARM_VENDOR_HYP_BMAP:
> +		val = READ_ONCE(smccc_feat->vendor_hyp_bmap);
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
> @@ -343,6 +351,10 @@ static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
>   		fw_reg_bmap = &smccc_feat->std_hyp_bmap;
>   		fw_reg_features = KVM_ARM_SMCCC_STD_HYP_FEATURES;
>   		break;
> +	case KVM_REG_ARM_VENDOR_HYP_BMAP:
> +		fw_reg_bmap = &smccc_feat->vendor_hyp_bmap;
> +		fw_reg_features = KVM_ARM_SMCCC_VENDOR_HYP_FEATURES;
> +		break;
>   	default:
>   		return -ENOENT;
>   	}
> @@ -445,6 +457,7 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>   		return 0;
>   	case KVM_REG_ARM_STD_BMAP:
>   	case KVM_REG_ARM_STD_HYP_BMAP:
> +	case KVM_REG_ARM_VENDOR_HYP_BMAP:
>   		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
>   	default:
>   		return -ENOENT;
> diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
> index aadd6ae3ab72..4ebfdd26e486 100644
> --- a/include/kvm/arm_hypercalls.h
> +++ b/include/kvm/arm_hypercalls.h
> @@ -9,9 +9,11 @@
>   /* Last valid bits of the bitmapped firmware registers */
>   #define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
>   #define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0
> +#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX	1
>   
>   #define KVM_ARM_SMCCC_STD_FEATURES		GENMASK(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
>   #define KVM_ARM_SMCCC_STD_HYP_FEATURES		GENMASK(KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX, 0)
> +#define KVM_ARM_SMCCC_VENDOR_HYP_FEATURES	GENMASK(KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX, 0)
>   
>   int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
>   
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
