Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 343B14C3390
	for <lists+kvmarm@lfdr.de>; Thu, 24 Feb 2022 18:26:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE7FB4BD9F;
	Thu, 24 Feb 2022 12:26:28 -0500 (EST)
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
	with ESMTP id 2OYrRpvX4Z8f; Thu, 24 Feb 2022 12:26:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 999F44BEBC;
	Thu, 24 Feb 2022 12:26:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C46024BD36
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 12:26:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIJgbBJ1U0CN for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Feb 2022 12:26:25 -0500 (EST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A9C5B4BD7E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 12:26:24 -0500 (EST)
Received: by mail-pj1-f74.google.com with SMTP id
 c14-20020a17090a8d0e00b001bc72e5c3ecso1618304pjo.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Feb 2022 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=0wDRpcCunfnn6jCq2Avo69TvJ8i4x6eSnCJLc/mO0iE=;
 b=ciEhdzZf28FOJSjBalS1IXNdMFbY6mvXPtNTSgACZqBzz53Fw5WS+3q7RMKXXr0e6f
 Yze4Oiywc8kMCpD1QhLgqXFtFk6jSdqVP9eKRBsXSKO5b1OYcJ2rqZb6pS78RrqiV2rj
 SSswk2sH09OAW1GYjO44B1cM8+1dTNx7Rxheuih2CHf8M8ETwuK0boZnjK2Z0aExSuw0
 Rp0qyU7BMMoMsl7YlYBpOFaR8OWovgakrwllhYAnPu/fwwP+JLAIQ8F+F8on+FcdPGzN
 Pew7kD00APKcrjSXCaLpU+b37D4YcYibmne+3dmu7tB3E7w0NqBBIytvwvkUs/1MuZ8+
 jEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=0wDRpcCunfnn6jCq2Avo69TvJ8i4x6eSnCJLc/mO0iE=;
 b=tZg8581hDESlAbV3/REshOO/ayUmqAm44VUVHq224PdJWh3hbKpLxCuLTpkghS8PI2
 Bf4BAqW6j9oxnaOz4wbD7Vp19rrfrOWhoQqlWiofadCwrKNCJI9tlzIqzmrV9h6JDA4q
 0okgGMQukZz/kxWYlnuuNEC/9vJgzmQ/evxZsBc8FDiTTLDjXeYLNmEiCHq17ygmG7l0
 2xA3Gw9aeO1dE2Q6X4Ef0uQbvKTja1o8zEJqf50s7LQON8/pbQ/10TZLE46KWJRto/xM
 Q61UXWWW4BG/McXeeZbmB1srrwuPDLIZhj50SQoLMeXJDtQXcxaIWFNY/azHvI3kl05c
 cSrA==
X-Gm-Message-State: AOAM533ItBpvv1c0PExXNV5GKnRZB9hb0TyDd9uqEtcDKOZkhCYbQT5N
 tKDBGKUM9vLMqy+8u53Ie1ncjtiUmOiZ
X-Google-Smtp-Source: ABdhPJzqjbV4k4lcCU4qKhTeOaOfUQ1qbFWWZSE6Unijap+Xg11o0GsRTN8d58koVdyFFG9WdVpF4hMmJYWM
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:1f08:b0:4c6:eb85:be8c with SMTP
 id be8-20020a056a001f0800b004c6eb85be8cmr3806765pfb.62.1645723583919; Thu, 24
 Feb 2022 09:26:23 -0800 (PST)
Date: Thu, 24 Feb 2022 17:25:53 +0000
In-Reply-To: <20220224172559.4170192-1-rananta@google.com>
Message-Id: <20220224172559.4170192-8-rananta@google.com>
Mime-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 07/13] KVM: arm64: Add vendor hypervisor firmware register
From: Raghavendra Rao Ananta <rananta@google.com>
To: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>, 
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
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

Introduce the firmware register to hold the vendor specific
hypervisor service calls (owner value 6) as a bitmap. The
bitmap represents the features that'll be enabled for the
guest, as configured by the user-space. Currently, this
includes support only for Precision Time Protocol (PTP),
represented by bit-0.

The register is also added to the kvm_arm_vm_scope_fw_regs[]
list as it maintains its state per-VM.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/uapi/asm/kvm.h |  4 ++++
 arch/arm64/kvm/guest.c            |  1 +
 arch/arm64/kvm/hypercalls.c       | 22 +++++++++++++++++++++-
 include/kvm/arm_hypercalls.h      |  3 +++
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 318148b69279..d999456c4604 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -106,10 +106,12 @@ struct kvm_arch_memory_slot {
  *
  * @hvc_std_bmap: Bitmap of standard secure service calls
  * @hvc_std_hyp_bmap: Bitmap of standard hypervisor service calls
+ * @hvc_vendor_hyp_bmap: Bitmap of vendor specific hypervisor service calls
  */
 struct kvm_hvc_desc {
 	u64 hvc_std_bmap;
 	u64 hvc_std_hyp_bmap;
+	u64 hvc_vendor_hyp_bmap;
 };
 
 struct kvm_arch {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 9a2caead7359..ed470bde13d8 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -299,6 +299,10 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_STD_HYP_BIT_PV_TIME		BIT(0)
 #define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0       /* Last valid bit */
 
+#define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_BMAP_REG(2)
+#define KVM_REG_ARM_VENDOR_HYP_BIT_PTP		BIT(0)
+#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX	0       /* Last valid bit */
+
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
 
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index c42426d6137e..fc3656f91aed 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -67,6 +67,7 @@ static const u64 kvm_arm_vm_scope_fw_regs[] = {
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
 	KVM_REG_ARM_STD_BMAP,
 	KVM_REG_ARM_STD_HYP_BMAP,
+	KVM_REG_ARM_VENDOR_HYP_BMAP,
 };
 
 /**
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index ebc0cc26cf2e..5c5098c8f1f9 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -79,6 +79,9 @@ static bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id)
 	case ARM_SMCCC_HV_PV_TIME_ST:
 		return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_hyp_bmap,
 					KVM_REG_ARM_STD_HYP_BIT_PV_TIME);
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_vendor_hyp_bmap,
+					KVM_REG_ARM_VENDOR_HYP_BIT_PTP);
 	default:
 		/* By default, allow the services that aren't listed here */
 		return true;
@@ -162,7 +165,14 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
-		val[0] |= BIT(ARM_SMCCC_KVM_FUNC_PTP);
+
+		/*
+		 * The feature bits exposed to user-space doesn't include
+		 * ARM_SMCCC_KVM_FUNC_FEATURES. However, we expose this to
+		 * the guest as bit-0. Hence, left-shift the user-space
+		 * exposed bitmap by 1 to accommodate this.
+		 */
+		val[0] |= hvc_desc->hvc_vendor_hyp_bmap << 1;
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
 		kvm_ptp_get_time(vcpu, val);
@@ -188,6 +198,7 @@ static const u64 kvm_arm_fw_reg_ids[] = {
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
 	KVM_REG_ARM_STD_BMAP,
 	KVM_REG_ARM_STD_HYP_BMAP,
+	KVM_REG_ARM_VENDOR_HYP_BMAP,
 };
 
 void kvm_arm_init_hypercalls(struct kvm *kvm)
@@ -196,6 +207,7 @@ void kvm_arm_init_hypercalls(struct kvm *kvm)
 
 	hvc_desc->hvc_std_bmap = ARM_SMCCC_STD_FEATURES;
 	hvc_desc->hvc_std_hyp_bmap = ARM_SMCCC_STD_HYP_FEATURES;
+	hvc_desc->hvc_vendor_hyp_bmap = ARM_SMCCC_VENDOR_HYP_FEATURES;
 }
 
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
@@ -285,6 +297,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_STD_HYP_BMAP:
 		val = READ_ONCE(hvc_desc->hvc_std_hyp_bmap);
 		break;
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
+		val = READ_ONCE(hvc_desc->hvc_vendor_hyp_bmap);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -311,6 +326,10 @@ static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
 		fw_reg_bmap = &hvc_desc->hvc_std_hyp_bmap;
 		fw_reg_features = ARM_SMCCC_STD_HYP_FEATURES;
 		break;
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
+		fw_reg_bmap = &hvc_desc->hvc_vendor_hyp_bmap;
+		fw_reg_features = ARM_SMCCC_VENDOR_HYP_FEATURES;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -416,6 +435,7 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return 0;
 	case KVM_REG_ARM_STD_BMAP:
 	case KVM_REG_ARM_STD_HYP_BMAP:
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
 		return kvm_arm_set_fw_reg_bmap(vcpu, reg_id, val);
 	default:
 		return -ENOENT;
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index a1cb6e839c74..91be758ca58e 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -12,6 +12,9 @@
 #define ARM_SMCCC_STD_HYP_FEATURES \
 	GENMASK_ULL(KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX, 0)
 
+#define ARM_SMCCC_VENDOR_HYP_FEATURES \
+	GENMASK_ULL(KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX, 0)
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
