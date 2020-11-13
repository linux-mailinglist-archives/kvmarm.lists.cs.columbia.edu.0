Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDBD2B1A2B
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 12:39:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D3A944BD4E;
	Fri, 13 Nov 2020 06:39:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGBvJQpbbHs1; Fri, 13 Nov 2020 06:39:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 462604BCE0;
	Fri, 13 Nov 2020 06:39:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3942A4BCC1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MzeprFV0zGA6 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 06:39:02 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F07A94BD11
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:01 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2A602224F;
 Fri, 13 Nov 2020 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605267541;
 bh=0EYYv1krMY9/OWn3wIVl6dQcMqvbyxJiIPItZGREqjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0WdRtEDRi4qG4D93FpKXIEcZvFePJQLrB6jFLcptkdJA1fkxcVqS56MkwYgQdGVZr
 lnzmhXBZoYd89H/Uhr9Kc4nre99hyhXzmn4LfoEcbGfpqeFWLv31h5t/Mz6uRz+xxF
 ewH3qUsFk5wiTapRUXCCvctCDGqWnPVENvMrLAMc=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 05/10] KVM: arm64: Move BP hardening helpers into spectre.h
Date: Fri, 13 Nov 2020 11:38:42 +0000
Message-Id: <20201113113847.21619-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113113847.21619-1-will@kernel.org>
References: <20201113113847.21619-1-will@kernel.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
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

The BP hardening helpers are an integral part of the Spectre-v2
mitigation, so move them into asm/spectre.h and inline the
arm64_get_bp_hardening_data() function at the same time.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu.h     | 29 -----------------------------
 arch/arm64/include/asm/spectre.h | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/kvm/hyp/hyp-entry.S   |  1 +
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index b2e91c187e2a..75beffe2ee8a 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -12,9 +12,6 @@
 #define USER_ASID_FLAG	(UL(1) << USER_ASID_BIT)
 #define TTBR_ASID_MASK	(UL(0xffff) << 48)
 
-#define BP_HARDEN_EL2_SLOTS 4
-#define __BP_HARDEN_HYP_VECS_SZ (BP_HARDEN_EL2_SLOTS * SZ_2K)
-
 #ifndef __ASSEMBLY__
 
 #include <linux/refcount.h>
@@ -41,32 +38,6 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
 	return cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
-typedef void (*bp_hardening_cb_t)(void);
-
-struct bp_hardening_data {
-	int			hyp_vectors_slot;
-	bp_hardening_cb_t	fn;
-};
-
-DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
-
-static inline struct bp_hardening_data *arm64_get_bp_hardening_data(void)
-{
-	return this_cpu_ptr(&bp_hardening_data);
-}
-
-static inline void arm64_apply_bp_hardening(void)
-{
-	struct bp_hardening_data *d;
-
-	if (!cpus_have_const_cap(ARM64_SPECTRE_V2))
-		return;
-
-	d = arm64_get_bp_hardening_data();
-	if (d->fn)
-		d->fn();
-}
-
 extern void arm64_memblock_init(void);
 extern void paging_init(void);
 extern void bootmem_init(void);
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index fcdfbce302bd..d22f8b7d9c50 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -9,7 +9,15 @@
 #ifndef __ASM_SPECTRE_H
 #define __ASM_SPECTRE_H
 
+#define BP_HARDEN_EL2_SLOTS 4
+#define __BP_HARDEN_HYP_VECS_SZ (BP_HARDEN_EL2_SLOTS * SZ_2K)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/percpu.h>
+
 #include <asm/cpufeature.h>
+#include <asm/virt.h>
 
 /* Watch out, ordering is important here. */
 enum mitigation_state {
@@ -20,6 +28,27 @@ enum mitigation_state {
 
 struct task_struct;
 
+typedef void (*bp_hardening_cb_t)(void);
+
+struct bp_hardening_data {
+	int			hyp_vectors_slot;
+	bp_hardening_cb_t	fn;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
+
+static inline void arm64_apply_bp_hardening(void)
+{
+	struct bp_hardening_data *d;
+
+	if (!cpus_have_const_cap(ARM64_SPECTRE_V2))
+		return;
+
+	d = this_cpu_ptr(&bp_hardening_data);
+	if (d->fn)
+		d->fn();
+}
+
 enum mitigation_state arm64_get_spectre_v2_state(void);
 bool has_spectre_v2(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v2_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
@@ -29,4 +58,5 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope);
 void spectre_v4_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 
+#endif	/* __ASSEMBLY__ */
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3262c16f0449..044c5fc81f90 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1405,7 +1405,7 @@ static void cpu_hyp_reset(void)
  */
 static void cpu_set_hyp_vector(void)
 {
-	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
+	struct bp_hardening_data *data = this_cpu_ptr(&bp_hardening_data);
 	void *vect = kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
 	int slot = -1;
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 0a5b36eb54b3..874eacdabc64 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -13,6 +13,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/mmu.h>
+#include <asm/spectre.h>
 
 .macro save_caller_saved_regs_vect
 	/* x0 and x1 were saved in the vector entry */
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
