Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A532414987
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 14:47:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A2E54B0DD;
	Wed, 22 Sep 2021 08:47:33 -0400 (EDT)
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
	with ESMTP id 6r+cGEHAqT7g; Wed, 22 Sep 2021 08:47:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 440A24B0E7;
	Wed, 22 Sep 2021 08:47:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 752AE4B0B4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHrgbzwPkd1p for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Sep 2021 08:47:26 -0400 (EDT)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 367934B0B8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:26 -0400 (EDT)
Received: by mail-qt1-f201.google.com with SMTP id
 13-20020ac8560d000000b0029f69548889so9254378qtr.3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Zd6vu6jHN9Knpi5xoFlhsLM9MQ1uM83fQQaf35ywpQs=;
 b=bEenDvINAnTU7MU5phIIode8wFSOBbw+/1fxjDxz4BuLxM4XWNG+mi25MPrXP3Bet3
 UZMm3GYavfqs4HnUuVnv3dBQIXk3IozInah2OuYydAPaMBLUmb2O0/ZZeJrUdfzthADo
 cb7Xdw9R8j6n+zIhweV/mWh0Ogod0k9Qw/pgoTr14qte4cfEWOKnHpuV1u2Fkbzvk96U
 Jrlqz8qXvSlk1ScoYGMowObq3Vn/9CmbnNaytXTpyAZKnXpEidyE+JZ5/KcQzc4QfxNP
 sONwv/E6DZNPioziJRkDOiOeuleSn6ZbPQ2CAvhLXsjtSbBReASmEEzPB99HNi4NdMxK
 LJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Zd6vu6jHN9Knpi5xoFlhsLM9MQ1uM83fQQaf35ywpQs=;
 b=jnFXr1ASeYkLsUTDMre9biPqxOE8B4haMIsY+8Gbf/o2gbmo5U5/0YXfaXOrzcxE5o
 kBVBl36nNsMq+cJzdGXYwd9VPFI7JJVlyJg5OCStOTsp4Ry9XYXDdigQIvL4O5brkMWw
 aRs6Szi9oW42+g/6DSIJbxNamAGl4YESa6AJ02nQ+OgxxuczRzH5HyI4h0AVIFRsMaQh
 UyI98YB4VeVnj0MO/e9hkGSgTaXqOC93zPYWe5eeXl8BvZYMB6kcrQ++W4widcYCNq+g
 FJYkA8nOOeZBuQyMlU09gEYRJ0EXEjklQiolCInb9I2brNF6aH4zBRZDGc3Rn895kEr6
 dM4Q==
X-Gm-Message-State: AOAM530V8WNZ1rmt0r6HmA/A6wWcz/RZb1P+O54rjDiWFbIXTRFj29wp
 OFKOeDS3NQptwmbPTnWENV0nyEDXgGaDXfAA2kF2KR+n9KmrH4Nnem9AqkcYKnBoB1bKFUpV2SB
 Yx1eR2uMQe9eejyVu9M1Vge+XSCPg4pf/wl8yh0f1+SimpSlmbgdN8eB8V1UGjYqpKOA=
X-Google-Smtp-Source: ABdhPJwEslVgsjjsAzzIL1AgtYGlyYIMO259s4/tSv1MzNS81+n5oK4sSfCCusweqpzG/+uAGmsW1PxdcA==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a0c:8045:: with SMTP id
 63mr18568702qva.63.1632314845728; 
 Wed, 22 Sep 2021 05:47:25 -0700 (PDT)
Date: Wed, 22 Sep 2021 13:47:01 +0100
In-Reply-To: <20210922124704.600087-1-tabba@google.com>
Message-Id: <20210922124704.600087-10-tabba@google.com>
Mime-Version: 1.0
References: <20210922124704.600087-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v6 09/12] KVM: arm64: Initialize trap registers for protected
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

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_asm.h       |   1 +
 arch/arm64/include/asm/kvm_host.h      |   2 +
 arch/arm64/kvm/arm.c                   |   8 ++
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  14 ++
 arch/arm64/kvm/hyp/nvhe/Makefile       |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c     |  10 ++
 arch/arm64/kvm/hyp/nvhe/pkvm.c         | 186 +++++++++++++++++++++++++
 7 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/pkvm.h
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
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
new file mode 100644
index 000000000000..e6c259db6719
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google LLC
+ * Author: Fuad Tabba <tabba@google.com>
+ */
+
+#ifndef __ARM64_KVM_NVHE_PKVM_H__
+#define __ARM64_KVM_NVHE_PKVM_H__
+
+#include <asm/kvm_host.h>
+
+void __pkvm_vcpu_init_traps(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM64_KVM_NVHE_PKVM_H__ */
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
index 8ca1104f4774..f59e0870c343 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -15,6 +15,7 @@
 
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
+#include <nvhe/pkvm.h>
 #include <nvhe/trap_handler.h>
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
@@ -160,6 +161,14 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
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
@@ -185,6 +194,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_create_private_mapping),
 	HANDLE_FUNC(__pkvm_prot_finalize),
+	HANDLE_FUNC(__pkvm_vcpu_init_traps),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
new file mode 100644
index 000000000000..cc6139631dc4
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -0,0 +1,186 @@
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
+	u64 hcr_set = 0;
+	u64 hcr_clear = 0;
+	u64 cptr_set = 0;
+
+	/* Trap AArch32 guests */
+	if (FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL0), feature_ids) <
+		    ID_AA64PFR0_ELx_32BIT_64BIT ||
+	    FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1), feature_ids) <
+		    ID_AA64PFR0_ELx_32BIT_64BIT)
+		hcr_set |= HCR_RW | HCR_TID0;
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
+	/*
+	 * Linux guests assume support for floating-point and Advanced SIMD. Do
+	 * not change the trapping behavior for these from the KVM default.
+	 */
+	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_FP),
+				PVM_ID_AA64PFR0_ALLOW));
+	BUILD_BUG_ON(!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_ASIMD),
+				PVM_ID_AA64PFR0_ALLOW));
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
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
