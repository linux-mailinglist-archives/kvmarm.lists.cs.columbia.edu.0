Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E05AE4848D7
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jan 2022 20:49:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76D534B10C;
	Tue,  4 Jan 2022 14:49:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJaM9SsQBJvb; Tue,  4 Jan 2022 14:49:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB9A54B09C;
	Tue,  4 Jan 2022 14:49:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4521E49F39
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jan 2022 14:49:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dh1CM1Phf4Rw for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jan 2022 14:49:41 -0500 (EST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 02DB649F4D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jan 2022 14:49:40 -0500 (EST)
Received: by mail-pj1-f74.google.com with SMTP id
 y13-20020a17090a134d00b001b10368d9dcso24710459pjf.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 04 Jan 2022 11:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=NThWuJJv1eDlfbOWPKu7GCi45ybYUBHmYiTkKwzgRSw=;
 b=VUO+kExe94u03M0LZHYsjrYRtgJmIMFql+PGknkbO6PruiP+p1wZ80thsXtTKR9egV
 tcBeHUVF9LoedB5Ippr13FYXC3XWvYeB6ybM0L2TU2Qigf6w505+aC8RUBlGhZpWjw3y
 kZkBelPGlgURXegyUCHiunEixTEf6YOCvdezeCeEkR3cg9dokV7JjUDjFMysLXvIa3pE
 wqh8/W6GZQ6f8hXjfNMIAt4oA9VA6qPi9rbh6xUHhX0fj7zjGGu5TCn6BQlLewXlI5uB
 VHlojL2YAjMMwQAEgyl447bMxmpqVNsztop9jVYmQiJgu9e1nJodxbfG1DsGjjpzRdcj
 BdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=NThWuJJv1eDlfbOWPKu7GCi45ybYUBHmYiTkKwzgRSw=;
 b=GkBAKtw+2NZH3rVLzAnqCLQC9i9giKOoRv7BvwGfPVxzdoTqIR2KzTXxMI0t0ZCS+e
 abJH6XQp/Boutbr9iWRjpifBLfOAzX2AIBc3fpl/gq07lg7i5VkKTScGija/YCOHd76O
 fB0NqpyJ9TzrRdIUIOyb5rMcScMUnSX69yT6S6ycicN6V45XMR2bHbyrYDjidburoMsi
 FWejRFvYhwbB76xSANAiUbkNgbgbD3Cepbz4rcmYYfJivHbG3FXDwHtrK3V1yvtLq4ce
 fxmIxMzaSLNjUJMvObRVStQPFBDA4kX1cY5wNZ/EwtTSgyZv0jQ9KZo8Ngb6DlDNDaBc
 xazQ==
X-Gm-Message-State: AOAM5330vwVeiTX5agQeaVdfQ3UpMepfWXE9Bu9tgL3/92WU7VdJKskG
 2WlyGgYZBLfoay+E2yEl3MdAiYBedU/k
X-Google-Smtp-Source: ABdhPJyobZZpJK0l5WdADNJkWljSUPBVr/2uJdANDvY1ksPiweeFd70aUC1wldb9FDT1AlEgO5pp7qWgaeqh
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:e884:b0:148:b91b:d7e2 with SMTP id
 w4-20020a170902e88400b00148b91bd7e2mr49845016plg.87.1641325780182; Tue, 04
 Jan 2022 11:49:40 -0800 (PST)
Date: Tue,  4 Jan 2022 19:49:12 +0000
In-Reply-To: <20220104194918.373612-1-rananta@google.com>
Message-Id: <20220104194918.373612-6-rananta@google.com>
Mime-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [RFC PATCH v3 05/11] KVM: arm64: Add standard hypervisor firmware
 register
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

Introduce the firmware register to hold the standard hypervisor
service calls (owner value 5) as a bitmap. The bitmap represents
the features that'll be enabled for the guest, as configured by
the user-space. Currently, this includes support only for
Paravirtualized time, represented by bit-0.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 ++
 arch/arm64/include/uapi/asm/kvm.h |  4 ++++
 arch/arm64/kvm/hypercalls.c       | 17 ++++++++++++++++-
 arch/arm64/kvm/pvtime.c           |  3 +++
 include/kvm/arm_hypercalls.h      |  3 +++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a32cded0371b..1daf2c0b3b85 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -106,9 +106,11 @@ struct kvm_arch_memory_slot {
  * struct kvm_hvc_desc: KVM ARM64 hypercall descriptor
  *
  * @hvc_std_bmap: Bitmap of standard secure service calls
+ * @hvc_std_hyp_bmap: Bitmap of standard hypervisor service calls
  */
 struct kvm_hvc_desc {
 	u64 hvc_std_bmap;
+	u64 hvc_std_hyp_bmap;
 };
 
 struct kvm_arch {
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 0d6f29c58456..af59c434ae33 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -285,6 +285,10 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_REG_ARM_STD_BIT_TRNG_V1_0		BIT(0)
 #define KVM_REG_ARM_STD_BMAP_BIT_MAX		0       /* Last valid bit */
 
+#define KVM_REG_ARM_STD_HYP_BMAP		KVM_REG_ARM_FW_REG(4)
+#define KVM_REG_ARM_STD_HYP_BIT_PV_TIME		BIT(0)
+#define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0       /* Last valid bit */
+
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
 
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 06243e4670eb..9df0221834a3 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -75,6 +75,10 @@ bool kvm_hvc_call_supported(struct kvm_vcpu *vcpu, u32 func_id)
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_bmap,
 						KVM_REG_ARM_STD_BIT_TRNG_V1_0);
+	case ARM_SMCCC_HV_PV_TIME_FEATURES:
+	case ARM_SMCCC_HV_PV_TIME_ST:
+		return kvm_arm_fw_reg_feat_enabled(hvc_desc->hvc_std_hyp_bmap,
+					KVM_REG_ARM_STD_HYP_BIT_PV_TIME);
 	default:
 		/* By default, allow the services that aren't listed here */
 		return true;
@@ -134,7 +138,8 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 			}
 			break;
 		case ARM_SMCCC_HV_PV_TIME_FEATURES:
-			val[0] = SMCCC_RET_SUCCESS;
+			if (kvm_hvc_call_supported(vcpu, feature))
+				val[0] = SMCCC_RET_SUCCESS;
 			break;
 		}
 		break;
@@ -182,6 +187,7 @@ static const u64 kvm_arm_fw_reg_ids[] = {
 
 static const u64 kvm_arm_fw_reg_bmap_ids[] = {
 	KVM_REG_ARM_STD_BMAP,
+	KVM_REG_ARM_STD_HYP_BMAP,
 };
 
 void kvm_arm_init_hypercalls(struct kvm *kvm)
@@ -189,6 +195,7 @@ void kvm_arm_init_hypercalls(struct kvm *kvm)
 	struct kvm_hvc_desc *hvc_desc = &kvm->arch.hvc_desc;
 
 	hvc_desc->hvc_std_bmap = ARM_SMCCC_STD_FEATURES;
+	hvc_desc->hvc_std_hyp_bmap = ARM_SMCCC_STD_HYP_FEATURES;
 }
 
 int kvm_arm_num_fw_bmap_regs(void)
@@ -286,6 +293,9 @@ int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_STD_BMAP:
 		kvm_arm_get_fw_reg_bmap(vcpu, hvc_desc->hvc_std_bmap, &val);
 		break;
+	case KVM_REG_ARM_STD_HYP_BMAP:
+		kvm_arm_get_fw_reg_bmap(vcpu, hvc_desc->hvc_std_hyp_bmap, &val);
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -308,6 +318,10 @@ static int kvm_arm_set_fw_reg_bmap(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
 		fw_reg_bmap = &hvc_desc->hvc_std_bmap;
 		fw_reg_features = ARM_SMCCC_STD_FEATURES;
 		break;
+	case KVM_REG_ARM_STD_HYP_BMAP:
+		fw_reg_bmap = &hvc_desc->hvc_std_hyp_bmap;
+		fw_reg_features = ARM_SMCCC_STD_HYP_FEATURES;
+		break;
 	default:
 		return -ENOENT;
 	}
@@ -410,6 +424,7 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 		return 0;
 	case KVM_REG_ARM_STD_BMAP:
+	case KVM_REG_ARM_STD_HYP_BMAP:
 		return kvm_arm_set_fw_reg_bmap(vcpu, reg->id, val);
 	default:
 		return -ENOENT;
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 78a09f7a6637..4fa436dbd0b7 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -37,6 +37,9 @@ long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
 	u32 feature = smccc_get_arg1(vcpu);
 	long val = SMCCC_RET_NOT_SUPPORTED;
 
+	if (!kvm_hvc_call_supported(vcpu, feature))
+		return val;
+
 	switch (feature) {
 	case ARM_SMCCC_HV_PV_TIME_FEATURES:
 	case ARM_SMCCC_HV_PV_TIME_ST:
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 8fe68d8d6d96..1a79b5f89a24 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -9,6 +9,9 @@
 #define ARM_SMCCC_STD_FEATURES \
 	GENMASK_ULL(KVM_REG_ARM_STD_BMAP_BIT_MAX, 0)
 
+#define ARM_SMCCC_STD_HYP_FEATURES \
+	GENMASK_ULL(KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX, 0)
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-- 
2.34.1.448.ga2b2bfdf31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
