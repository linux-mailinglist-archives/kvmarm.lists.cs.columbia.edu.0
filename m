Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 710924F7012
	for <lists+kvmarm@lfdr.de>; Thu,  7 Apr 2022 03:16:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20C1C4B1D5;
	Wed,  6 Apr 2022 21:16:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMPDYbHvQNdH; Wed,  6 Apr 2022 21:16:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77EC24B1F0;
	Wed,  6 Apr 2022 21:16:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B5EF4B1AF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Apr 2022 21:16:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhwRwWAazbJo for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Apr 2022 21:16:21 -0400 (EDT)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5C86E4B1F3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Apr 2022 21:16:20 -0400 (EDT)
Received: by mail-pl1-f202.google.com with SMTP id
 q3-20020a170902dac300b001570362c37bso361501plx.9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 06 Apr 2022 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=uKF3LzEpbt0jcGyoq/1Xe6ZugarWRpxWPPyqjttx12c=;
 b=HM05i9xYqmF9YTZlktYDfk2oGC8DrHDBcY4XhwET5dVfw8LN4y0IMKOS1ytyeBj8Cw
 B/wBVDV66kxEe7mCNTi5PXpHQruPW8ePrvO8hkkzFwhNNhTkWTw3dBSL13pBojaT/ggB
 dhMU2E2GXe5p9geAbeSEqsG6Bf026kh91SwOsyaNZHE0DTtCorey8FKXNypvuZsJtoxr
 W2ec6Q0+9bZ6Eoqrj+shgeLEBouwJmsPfDHNu5f6oNjZa3dH2N4ATifv8AIPOrXmYvjX
 e4BXmNBCrIgJPm9lQ4QoBR/i/KWJu+PkQUWdvus429ZSK8xW60jcdBza69jIYxO2Elp7
 Jm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=uKF3LzEpbt0jcGyoq/1Xe6ZugarWRpxWPPyqjttx12c=;
 b=A0YOl5+kakYUOJRf12xXLsmG9gtuG6WKY1ruRolea/ubowIKENpw2Weca0Ur9mQGdo
 H0vafTiGej9LAko5KaZWmsZwlIaIQRm07rUDQAs+azrpOUJHQ9E4Bzwnk1hLeSGVsyjD
 Oq1F3lLrGZzU8yaFlOsoEH98Cudx9c99nWde1onew3WBiZvMwFyPC6/cKfTz5d6rG12V
 iwFawF5/nMv6h9RrHdX57nqWGVt66OpwHVY2Es5gIhm9CcHkeGclVWaGURaaPcKZkdIu
 7bhnAWW9yDyW406GBcZO7Fi9LWfXmBq7GGWwmvgmvzMILFurq11nWCOfpPaIJcPAayGX
 a1Cw==
X-Gm-Message-State: AOAM533RLQ436bSVzVMcYZPIwEkpc9xhF67Kif9fIuqnEbWG2V5hlqt8
 USNRZc6a/LEJomOomIhbt991tg+1s1Sc
X-Google-Smtp-Source: ABdhPJw2IUgAWNtqzd51LY4wfv37u3QV9B0xYw5NFlCSPW6EpcxGVctPDL5vzpbqWcSbeoJoMsCmwREaVyUd
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:23c1:b0:4fa:efcb:9c81 with SMTP
 id g1-20020a056a0023c100b004faefcb9c81mr11488095pfc.75.1649294179498; Wed, 06
 Apr 2022 18:16:19 -0700 (PDT)
Date: Thu,  7 Apr 2022 01:15:59 +0000
In-Reply-To: <20220407011605.1966778-1-rananta@google.com>
Message-Id: <20220407011605.1966778-5-rananta@google.com>
Mime-Version: 1.0
References: <20220407011605.1966778-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v5 04/10] KVM: arm64: Add vendor hypervisor firmware register
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
includes support for KVM-vendor features, and Precision Time
Protocol (PTP), represented by bit-0 and bit-1 respectively.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/uapi/asm/kvm.h |  4 ++++
 arch/arm64/kvm/hypercalls.c       | 21 +++++++++++++++++----
 include/kvm/arm_hypercalls.h      |  4 ++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 20165242ebd9..b79161bad69a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -106,10 +106,12 @@ struct kvm_arch_memory_slot {
  *
  * @std_bmap: Bitmap of standard secure service calls
  * @std_hyp_bmap: Bitmap of standard hypervisor service calls
+ * @vendor_hyp_bmap: Bitmap of vendor specific hypervisor service calls
  */
 struct kvm_smccc_features {
 	u64 std_bmap;
 	u64 std_hyp_bmap;
+	u64 vendor_hyp_bmap;
 };
 
 struct kvm_arch {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 67353bf4e69d..9a5ac0ed4113 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -344,6 +344,10 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_STD_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(1)
 #define KVM_REG_ARM_STD_HYP_BIT_PV_TIME		BIT(0)
 
+#define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(2)
+#define KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT	BIT(0)
+#define KVM_REG_ARM_VENDOR_HYP_BIT_PTP		BIT(1)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 64ae6c7e7145..80836c341fd3 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -66,8 +66,6 @@ static const u32 hvc_func_default_allowed_list[] = {
 	ARM_SMCCC_VERSION_FUNC_ID,
 	ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 	ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
-	ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID,
-	ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID,
 };
 
 static bool kvm_hvc_call_default_allowed(struct kvm_vcpu *vcpu, u32 func_id)
@@ -102,6 +100,12 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 	case ARM_SMCCC_HV_PV_TIME_ST:
 		return kvm_arm_fw_reg_feat_enabled(smccc_feat->std_hyp_bmap,
 					KVM_REG_ARM_STD_HYP_BIT_PV_TIME);
+	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
+		return kvm_arm_fw_reg_feat_enabled(smccc_feat->vendor_hyp_bmap,
+					KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT);
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		return kvm_arm_fw_reg_feat_enabled(smccc_feat->vendor_hyp_bmap,
+					KVM_REG_ARM_VENDOR_HYP_BIT_PTP);
 	default:
 		return kvm_hvc_call_default_allowed(vcpu, func_id);
 	}
@@ -194,8 +198,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		val[3] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
-		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
-		val[0] |= BIT(ARM_SMCCC_KVM_FUNC_PTP);
+		val[0] = smccc_feat->vendor_hyp_bmap;
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
 		kvm_ptp_get_time(vcpu, val);
@@ -222,6 +225,7 @@ static const u64 kvm_arm_fw_reg_ids[] = {
 	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3,
 	KVM_REG_ARM_STD_BMAP,
 	KVM_REG_ARM_STD_HYP_BMAP,
+	KVM_REG_ARM_VENDOR_HYP_BMAP,
 };
 
 void kvm_arm_init_hypercalls(struct kvm *kvm)
@@ -230,6 +234,7 @@ void kvm_arm_init_hypercalls(struct kvm *kvm)
 
 	smccc_feat->std_bmap = KVM_ARM_SMCCC_STD_FEATURES;
 	smccc_feat->std_hyp_bmap = KVM_ARM_SMCCC_STD_HYP_FEATURES;
+	smccc_feat->vendor_hyp_bmap = KVM_ARM_SMCCC_VENDOR_HYP_FEATURES;
 }
 
 int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
@@ -322,6 +327,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_STD_HYP_BMAP:
 		val = READ_ONCE(smccc_feat->std_hyp_bmap);
 		break;
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
+		val = READ_ONCE(smccc_feat->vendor_hyp_bmap);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -348,6 +356,10 @@ static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
 		fw_reg_bmap = &smccc_feat->std_hyp_bmap;
 		fw_reg_features = KVM_ARM_SMCCC_STD_HYP_FEATURES;
 		break;
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
+		fw_reg_bmap = &smccc_feat->vendor_hyp_bmap;
+		fw_reg_features = KVM_ARM_SMCCC_VENDOR_HYP_FEATURES;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -453,6 +465,7 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		return 0;
 	case KVM_REG_ARM_STD_BMAP:
 	case KVM_REG_ARM_STD_HYP_BMAP:
+	case KVM_REG_ARM_VENDOR_HYP_BMAP:
 		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
 	default:
 		return -ENOENT;
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index b0915d8c5b81..eaf4f6b318a8 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -9,6 +9,7 @@
 /* Last valid bits of the bitmapped firmware registers */
 #define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
 #define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0
+#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX	1
 
 #define KVM_ARM_SMCCC_STD_FEATURES \
 	GENMASK_ULL(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
@@ -16,6 +17,9 @@
 #define KVM_ARM_SMCCC_STD_HYP_FEATURES \
 	GENMASK_ULL(KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX, 0)
 
+#define KVM_ARM_SMCCC_VENDOR_HYP_FEATURES \
+	GENMASK_ULL(KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX, 0)
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-- 
2.35.1.1094.g7c7d902a7c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
