Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 887164CB599
	for <lists+kvmarm@lfdr.de>; Thu,  3 Mar 2022 04:56:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8F1349F03;
	Wed,  2 Mar 2022 22:56:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7X5eDEe7QEr2; Wed,  2 Mar 2022 22:56:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 946CF49EED;
	Wed,  2 Mar 2022 22:56:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A02DE4101F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Mar 2022 22:56:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 193XEUAA0Lmu for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Mar 2022 22:56:00 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2791840C1B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Mar 2022 22:56:00 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 o5-20020aa79785000000b004f672289911so225464pfp.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Mar 2022 19:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=2O5tqm85dJQhkLMWZJPT1tS2tYSeXeUxQ48vdWcXam8=;
 b=bgptN9PY5GNZgfMeVshpiNtEDjxaMAlBk8Yqu0QEftcmyVcfjWL3WKh1QFk2dh9FNi
 0ME1/Jjr4igNaLdvStc9ZdZtzcq5G+B2wY3smWw1YfQTcqa55l3ew49S25DarCwInMGV
 R+yYG/o0UtV0SDYL/7ODecscfIkjY1nLrI5gPnQzzsZLq+mTRfQSlZ1PpBvGNn4A+I2J
 ZRtf1HwsYMiYwxIsbXHVwTccJqn2YFhht1RdfW2ZPsVSGJxKaW//kkDdNqViJL8Sf49e
 OgtVqNiVFLy7vwK/IX5NmHEIA0xYm009EF7+bPtUnTIOOMYYdB3mfuCBhKy4gM1q/yyc
 +kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=2O5tqm85dJQhkLMWZJPT1tS2tYSeXeUxQ48vdWcXam8=;
 b=XURQ/eD0LzcqdFf7IPiuxQ5VHc7TDh9JABGORppgIWDOe/OXPCkgcXEkxq13RVpin4
 hovA2pRrsApuGhwdURBnDt2ECMDsIZRR30E/u14eddSdJkcvqE74WcCmTA2pYFrFjmyM
 k2S1Ym/ul4zAkEBwfOnZq1/Ml6L6AvklTOSM/w+6XSt9IAu0TpDUMaIhpEExCRbckjNX
 TF86uutMqfwDWef9O858uZ2HTdyiSRA3K5uRKcn7mEi4NNxWlhw+5FmtMPPNQLf9G41X
 9zY/BDX/bpv1xWcZQCKiYV09p7WnCO3cP4rTmE4lMhk2CKzVlwFPPOH5cRZX3NzXhDTy
 v9HQ==
X-Gm-Message-State: AOAM532ubzrGYy2YS+LPXJwwS/fI34tEwI9gZGX2qw90jv/UDDfM+UQW
 J8xN7ZS4r8ulzw7Cqhu+DuXYQvSkFms=
X-Google-Smtp-Source: ABdhPJw9yx/IyJvkFVOwn5qC3Id+SAO2jS9BZYH+J414vcDMXDqLc0Xq9fymwb4L9yNCuks6le/ym0ztXHE=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:a15:b0:4f6:5051:61ad with SMTP id
 p21-20020a056a000a1500b004f6505161admr6582732pfh.69.1646279759153; Wed, 02
 Mar 2022 19:55:59 -0800 (PST)
Date: Wed,  2 Mar 2022 19:54:07 -0800
In-Reply-To: <20220303035408.3708241-1-reijiw@google.com>
Message-Id: <20220303035408.3708241-2-reijiw@google.com>
Mime-Version: 1.0
References: <20220303035408.3708241-1-reijiw@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 2/3] KVM: arm64: mixed-width check should be skipped for
 uninitialized vCPUs
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

KVM allows userspace to configure either all EL1 32bit or 64bit vCPUs
for a guest.  At vCPU reset, vcpu_allowed_register_width() checks
if the vcpu's register width is consistent with all other vCPUs'.
Since the checking is done even against vCPUs that are not initialized
(KVM_ARM_VCPU_INIT has not been done) yet, the uninitialized vCPUs
are erroneously treated as 64bit vCPU, which causes the function to
incorrectly detect a mixed-width VM.

Introduce KVM_ARCH_FLAG_EL1_32BIT and KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED
bits for kvm->arch.flags.  A value of the EL1_32BIT bit indicates that
the guest needs to be configured with all 32bit or 64bit vCPUs, and
a value of the REG_WIDTH_CONFIGURED bit indicates if a value of the
EL1_32BIT bit is valid (already set up). Values in those bits are set at
the first KVM_ARM_VCPU_INIT for the guest based on KVM_ARM_VCPU_EL1_32BIT
configuration for the vCPU.

Check vcpu's register width against those new bits at the vcpu's
KVM_ARM_VCPU_INIT (instead of against other vCPUs' register width).

Fixes: 66e94d5cafd4 ("KVM: arm64: Prevent mixed-width VM creation")
Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 25 +++++++++++------
 arch/arm64/include/asm/kvm_host.h    |  8 ++++++
 arch/arm64/kvm/arm.c                 | 41 ++++++++++++++++++++++++++++
 arch/arm64/kvm/reset.c               |  8 ------
 4 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d62405ce3e6d..f4f960819888 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -20,6 +20,7 @@
 #include <asm/ptrace.h>
 #include <asm/cputype.h>
 #include <asm/virt.h>
+#include <asm/kvm_mmu.h>
 
 #define CURRENT_EL_SP_EL0_VECTOR	0x0
 #define CURRENT_EL_SP_ELx_VECTOR	0x200
@@ -45,7 +46,14 @@ void kvm_vcpu_wfi(struct kvm_vcpu *vcpu);
 
 static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 {
-	return !(vcpu->arch.hcr_el2 & HCR_RW);
+	struct kvm *kvm;
+
+	kvm = is_kernel_in_hyp_mode() ? kern_hyp_va(vcpu->kvm) : vcpu->kvm;
+
+	WARN_ON_ONCE(!test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED,
+			       &kvm->arch.flags));
+
+	return test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
 }
 
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
@@ -72,15 +80,14 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 		vcpu->arch.hcr_el2 |= HCR_TVM;
 	}
 
-	if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features))
+	if (vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
-
-	/*
-	 * TID3: trap feature register accesses that we virtualise.
-	 * For now this is conditional, since no AArch32 feature regs
-	 * are currently virtualised.
-	 */
-	if (!vcpu_el1_is_32bit(vcpu))
+	else
+		/*
+		 * TID3: trap feature register accesses that we virtualise.
+		 * For now this is conditional, since no AArch32 feature regs
+		 * are currently virtualised.
+		 */
 		vcpu->arch.hcr_el2 |= HCR_TID3;
 
 	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 11a7ae747ded..5cde7f7b5042 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -125,6 +125,14 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
 	/* Memory Tagging Extension enabled for the guest */
 #define KVM_ARCH_FLAG_MTE_ENABLED			1
+	/*
+	 * The guest's EL1 register width.  A value of KVM_ARCH_FLAG_EL1_32BIT
+	 * bit is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED is set.
+	 * Otherwise, the guest's EL1 register width has not yet been
+	 * determined yet.
+	 */
+#define KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED		2
+#define KVM_ARCH_FLAG_EL1_32BIT				3
 	unsigned long flags;
 
 	/*
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9a2d240ef6a3..9ac75aa46e2f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1101,6 +1101,43 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 	return -EINVAL;
 }
 
+/*
+ * A guest can have either all EL1 32bit or 64bit vcpus only. It is
+ * indicated by a value of KVM_ARCH_FLAG_EL1_32BIT bit in kvm->arch.flags,
+ * which is valid only when KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED in
+ * kvm->arch.flags is set.
+ * This function checks if the vCPU's register width configuration is
+ * consistent with a value of the EL1_32BIT bit in kvm->arch.flags
+ * when the REG_WIDTH_CONFIGURED bit is set.
+ * Otherwise, the function sets a value of EL1_32BIT bit based on the vcpu's
+ * KVM_ARM_VCPU_EL1_32BIT configuration (and sets the REG_WIDTH_CONFIGURED
+ * bit of kvm->arch.flags).
+ */
+static int kvm_register_width_check_or_init(struct kvm_vcpu *vcpu)
+{
+	bool is32bit;
+	bool allowed = true;
+	struct kvm *kvm = vcpu->kvm;
+
+	is32bit = vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT);
+
+	mutex_lock(&kvm->lock);
+
+	if (test_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags)) {
+		allowed = (is32bit ==
+			   test_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags));
+	} else {
+		if (is32bit)
+			set_bit(KVM_ARCH_FLAG_EL1_32BIT, &kvm->arch.flags);
+
+		set_bit(KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED, &kvm->arch.flags);
+	}
+
+	mutex_unlock(&kvm->lock);
+
+	return allowed ? 0 : -EINVAL;
+}
+
 static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 			       const struct kvm_vcpu_init *init)
 {
@@ -1140,6 +1177,10 @@ static int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 
 	/* Now we know what it is, we can reset it. */
 	ret = kvm_reset_vcpu(vcpu);
+
+	if (!ret)
+		ret = kvm_register_width_check_or_init(vcpu);
+
 	if (ret) {
 		vcpu->arch.target = -1;
 		bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index ecc40c8cd6f6..6c5f7677057d 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -183,9 +183,7 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)
 
 static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
 {
-	struct kvm_vcpu *tmp;
 	bool is32bit;
-	unsigned long i;
 
 	is32bit = vcpu_has_feature(vcpu, KVM_ARM_VCPU_EL1_32BIT);
 	if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1) && is32bit)
@@ -195,12 +193,6 @@ static bool vcpu_allowed_register_width(struct kvm_vcpu *vcpu)
 	if (kvm_has_mte(vcpu->kvm) && is32bit)
 		return false;
 
-	/* Check that the vcpus are either all 32bit or all 64bit */
-	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
-		if (vcpu_has_feature(tmp, KVM_ARM_VCPU_EL1_32BIT) != is32bit)
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.35.1.574.g5d30c73bfb-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
