Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1411426E41
	for <lists+kvmarm@lfdr.de>; Fri,  8 Oct 2021 17:58:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 515AC4B137;
	Fri,  8 Oct 2021 11:58:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dFS9rTlTHbqe; Fri,  8 Oct 2021 11:58:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CEC534B163;
	Fri,  8 Oct 2021 11:58:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB4084B0D6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 11:58:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WX3b5YClTP5U for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 11:58:52 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59D934B160
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 11:58:52 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id
 y25-20020ac87059000000b002a71d24c242so8109304qtm.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xy+MJK6BW+A6eWT46OQ72xzCmIV6RWUt4hWcPRTbYWI=;
 b=jIeSC/5PweoLSS/uKvhwpF+0zUy+0JQJVYug+rJ64zOWkemyjcP0Tr827nPzjZfy7R
 kYSwsavJHXDEAyF+tpN5UgFe7htBKiIkNRPsChTtX+O1Zu4CnkNYmNpxoci9LyF5WlAs
 zmcpx0IloDI03OXa17foqA/DTaz3C8RsIF9QpPPHOulAnhFgCNmug1dzkbzc92pqtZpO
 seST5Tu6A9Oy2gMPAsdyFw75Sp+jpzx9u5TDDLi3LcSrfLHbCrdjE6IFharlKDnKDrEW
 WvorvtAhxqJQzrN8AY7clCAuT8BwAm8Y8twj4MvmOpSj5nmKcyQ/sD8i6VsnR8V1vwmF
 XAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xy+MJK6BW+A6eWT46OQ72xzCmIV6RWUt4hWcPRTbYWI=;
 b=7rPQCi6iCpbKoadS3MO+7rPErc7maPsgRihLKasgNuVk8lqd0SbS5zrbJvkXfm2Vm5
 64k8YAReH+tc2fKyqFfLOxhSzTFlE152RtXV7ETWsyUD/RZWvkQvzr7VnMPX7P1C8zQN
 9RMQJqAKRnhQ86PAK3EV40AoY72Z0hPH0n9S3US4kQqLPYo2eOw0FEKdJ8MGecVG8ni3
 UMJoip7AlhoMBnas+UlGcSvXPVqtrFrvLdlKHJ9fvQ6JZvh1A8mHrumWi4r8bVPz9tsR
 Cpqc9AewqmYAgvD6OfbnQmCpQhQ134+kIs2tG1Z8d9LLgqiZ3ok9oq4aY5VIJsQ+YIRp
 rkJg==
X-Gm-Message-State: AOAM5306JXq9uZcn8feV28RGLgH26dA0TpZq+mO4CxYR4A8TN89IOG0W
 /eE1pO85EC8IczQ/JmrTKhTiQtOaYBNJG+zjzptQxYpR0CDwhK6ks3aLDNsVAPMERWr5DPVClXw
 gcpdbttsU+imHiMSLH0CaY385k0dxj/OU4mdYWW5lGPZ0CEmJphELL0D2SoMz7frMf20=
X-Google-Smtp-Source: ABdhPJykKWkckN3tBqcO+0BqOgNU2/k+eo/O2cB+Zmu5T3eo4/i5nbWhb/E0gnv9647ShSfmF+MjCrwUpw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:ac8:514f:: with SMTP id
 h15mr12180556qtn.340.1633708731847; 
 Fri, 08 Oct 2021 08:58:51 -0700 (PDT)
Date: Fri,  8 Oct 2021 16:58:29 +0100
In-Reply-To: <20211008155832.1415010-1-tabba@google.com>
Message-Id: <20211008155832.1415010-9-tabba@google.com>
Mime-Version: 1.0
References: <20211008155832.1415010-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v7 08/11] KVM: arm64: Initialize trap registers for protected
 VMs
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Protected VMs have more restricted features that need to be
trapped. Moreover, the host should not be trusted to set the
appropriate trapping registers and their values.

Initialize the trapping registers, i.e., hcr_el2, mdcr_el2, and
cptr_el2 at EL2 for protected guests, based on the values of the
guest's feature id registers.

No functional change intended as trap handlers introduced in the
previous patch are still not hooked in to the guest exit
handlers.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_asm.h              |   1 +
 arch/arm64/include/asm/kvm_host.h             |   2 +
 arch/arm64/kvm/arm.c                          |   8 +
 .../arm64/kvm/hyp/include/nvhe/trap_handler.h |   2 +
 arch/arm64/kvm/hyp/nvhe/Makefile              |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   9 +
 arch/arm64/kvm/hyp/nvhe/pkvm.c                | 185 ++++++++++++++++++
 7 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/pkvm.c

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index e86045ac43ba..a460e1243cef 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -64,6 +64,7 @@
 #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector		18
 #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize		19
 #define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc			20
+#define __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_init_traps		21
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8be56d5342b..4a323aa27a6b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -780,6 +780,8 @@ static inline bool kvm_vm_is_protected(struct kvm *kvm)
 	return false;
 }
 
+void kvm_init_protected_traps(struct kvm_vcpu *vcpu);
+
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6aa7b0c5bf21..3af6d59d1919 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -620,6 +620,14 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 
 	ret = kvm_arm_pmu_v3_enable(vcpu);
 
+	/*
+	 * Initialize traps for protected VMs.
+	 * NOTE: Move to run in EL2 directly, rather than via a hypercall, once
+	 * the code is in place for first run initialization at EL2.
+	 */
+	if (kvm_vm_is_protected(kvm))
+		kvm_call_hyp_nvhe(__pkvm_vcpu_init_traps, vcpu);
+
 	return ret;
 }
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trap_handler.h b/arch/arm64/kvm/hyp/include/nvhe/trap_handler.h
index 1e6d995968a1..45a84f0ade04 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trap_handler.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trap_handler.h
@@ -15,4 +15,6 @@
 #define DECLARE_REG(type, name, ctxt, reg)	\
 				type name = (type)cpu_reg(ctxt, (reg))
 
+void __pkvm_vcpu_init_traps(struct kvm_vcpu *vcpu);
+
 #endif /* __ARM64_KVM_NVHE_TRAP_HANDLER_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 0bbe37a18d5d..c3c11974fa3b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -14,7 +14,7 @@ lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 8ca1104f4774..a6303db09cd6 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -160,6 +160,14 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
 {
 	cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
 }
+
+static void handle___pkvm_vcpu_init_traps(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
+
+	__pkvm_vcpu_init_traps(kern_hyp_va(vcpu));
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -185,6 +193,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
+	HANDLE_FUNC(__pkvm_vcpu_init_traps),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
new file mode 100644
index 000000000000..ddd3ee13de8f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Google LLC
+ * Author: Fuad Tabba <tabba@google.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/mm.h>
+#include <asm/kvm_fixed_config.h>
+#include <nvhe/sys_regs.h>
+
+/*
+ * Set trap register values based on features in ID_AA64PFR0.
+ */
+static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
+{
+	const u64 feature_ids = get_pvm_id_aa64pfr0(vcpu);
+	u64 hcr_set = HCR_RW;
+	u64 hcr_clear = 0;
+	u64 cptr_set = 0;
+
+	/* Protected KVM does not support AArch32 guests. */
+	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL0),
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_ELx_64BIT_ONLY);
+	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1),
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_ELx_64BIT_ONLY);
+
+	/*
+	 * Linux guests assume support for floating-point and Advanced SIMD. Do
+	 * not change the trapping behavior for these from the KVM default.
+	 */
+	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_FP),
+				PVM_ID_AA64PFR0_ALLOW));
+	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD),
+				PVM_ID_AA64PFR0_ALLOW));
+
+	/* Trap RAS unless all current versions are supported */
+	if (FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_RAS), feature_ids) <
+	    ID_AA64PFR0_RAS_V1P1) {
+		hcr_set |= HCR_TERR | HCR_TEA;
+		hcr_clear |= HCR_FIEN;
+	}
+
+	/* Trap AMU */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_AMU), feature_ids)) {
+		hcr_clear |= HCR_AMVOFFEN;
+		cptr_set |= CPTR_EL2_TAM;
+	}
+
+	/* Trap SVE */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_SVE), feature_ids))
+		cptr_set |= CPTR_EL2_TZ;
+
+	vcpu->arch.hcr_el2 |= hcr_set;
+	vcpu->arch.hcr_el2 &= ~hcr_clear;
+	vcpu->arch.cptr_el2 |= cptr_set;
+}
+
+/*
+ * Set trap register values based on features in ID_AA64PFR1.
+ */
+static void pvm_init_traps_aa64pfr1(struct kvm_vcpu *vcpu)
+{
+	const u64 feature_ids = get_pvm_id_aa64pfr1(vcpu);
+	u64 hcr_set = 0;
+	u64 hcr_clear = 0;
+
+	/* Memory Tagging: Trap and Treat as Untagged if not supported. */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR1_MTE), feature_ids)) {
+		hcr_set |= HCR_TID5;
+		hcr_clear |= HCR_DCT | HCR_ATA;
+	}
+
+	vcpu->arch.hcr_el2 |= hcr_set;
+	vcpu->arch.hcr_el2 &= ~hcr_clear;
+}
+
+/*
+ * Set trap register values based on features in ID_AA64DFR0.
+ */
+static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
+{
+	const u64 feature_ids = get_pvm_id_aa64dfr0(vcpu);
+	u64 mdcr_set = 0;
+	u64 mdcr_clear = 0;
+	u64 cptr_set = 0;
+
+	/* Trap/constrain PMU */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMUVER), feature_ids)) {
+		mdcr_set |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
+		mdcr_clear |= MDCR_EL2_HPME | MDCR_EL2_MTPME |
+			      MDCR_EL2_HPMN_MASK;
+	}
+
+	/* Trap Debug */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_DEBUGVER), feature_ids))
+		mdcr_set |= MDCR_EL2_TDRA | MDCR_EL2_TDA | MDCR_EL2_TDE;
+
+	/* Trap OS Double Lock */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_DOUBLELOCK), feature_ids))
+		mdcr_set |= MDCR_EL2_TDOSA;
+
+	/* Trap SPE */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_PMSVER), feature_ids)) {
+		mdcr_set |= MDCR_EL2_TPMS;
+		mdcr_clear |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
+	}
+
+	/* Trap Trace Filter */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_TRACE_FILT), feature_ids))
+		mdcr_set |= MDCR_EL2_TTRF;
+
+	/* Trap Trace */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_TRACEVER), feature_ids))
+		cptr_set |= CPTR_EL2_TTA;
+
+	vcpu->arch.mdcr_el2 |= mdcr_set;
+	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
+	vcpu->arch.cptr_el2 |= cptr_set;
+}
+
+/*
+ * Set trap register values based on features in ID_AA64MMFR0.
+ */
+static void pvm_init_traps_aa64mmfr0(struct kvm_vcpu *vcpu)
+{
+	const u64 feature_ids = get_pvm_id_aa64mmfr0(vcpu);
+	u64 mdcr_set = 0;
+
+	/* Trap Debug Communications Channel registers */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR0_FGT), feature_ids))
+		mdcr_set |= MDCR_EL2_TDCC;
+
+	vcpu->arch.mdcr_el2 |= mdcr_set;
+}
+
+/*
+ * Set trap register values based on features in ID_AA64MMFR1.
+ */
+static void pvm_init_traps_aa64mmfr1(struct kvm_vcpu *vcpu)
+{
+	const u64 feature_ids = get_pvm_id_aa64mmfr1(vcpu);
+	u64 hcr_set = 0;
+
+	/* Trap LOR */
+	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR1_LOR), feature_ids))
+		hcr_set |= HCR_TLOR;
+
+	vcpu->arch.hcr_el2 |= hcr_set;
+}
+
+/*
+ * Set baseline trap register values.
+ */
+static void pvm_init_trap_regs(struct kvm_vcpu *vcpu)
+{
+	const u64 hcr_trap_feat_regs = HCR_TID3;
+	const u64 hcr_trap_impdef = HCR_TACR | HCR_TIDCP | HCR_TID1;
+
+	/*
+	 * Always trap:
+	 * - Feature id registers: to control features exposed to guests
+	 * - Implementation-defined features
+	 */
+	vcpu->arch.hcr_el2 |= hcr_trap_feat_regs | hcr_trap_impdef;
+
+	/* Clear res0 and set res1 bits to trap potential new features. */
+	vcpu->arch.hcr_el2 &= ~(HCR_RES0);
+	vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_RES0);
+	vcpu->arch.cptr_el2 |= CPTR_NVHE_EL2_RES1;
+	vcpu->arch.cptr_el2 &= ~(CPTR_NVHE_EL2_RES0);
+}
+
+/*
+ * Initialize trap register values for protected VMs.
+ */
+void __pkvm_vcpu_init_traps(struct kvm_vcpu *vcpu)
+{
+	pvm_init_trap_regs(vcpu);
+	pvm_init_traps_aa64pfr0(vcpu);
+	pvm_init_traps_aa64pfr1(vcpu);
+	pvm_init_traps_aa64dfr0(vcpu);
+	pvm_init_traps_aa64mmfr0(vcpu);
+	pvm_init_traps_aa64mmfr1(vcpu);
+}
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
