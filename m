Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 993B32B1A29
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 12:39:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D49E4BD20;
	Fri, 13 Nov 2020 06:39:04 -0500 (EST)
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
	with ESMTP id TmgYoU0JZsdD; Fri, 13 Nov 2020 06:39:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 030AD4BD40;
	Fri, 13 Nov 2020 06:39:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93FA44BCDE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FhoPihNhjTIN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 06:38:59 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A0A694BCB6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:38:58 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E56B22252;
 Fri, 13 Nov 2020 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605267537;
 bh=5oKkedONqxp5jXLd3uh3IYZZu0+rHtM/7Ls9fb2LGGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tWWyF5m7esfGq0NAGn83PupZXsWuSaMoau/aVCZ2PO0DjU+Pq7KgRMg9NrhP7wnFl
 b9mPWlJ5DuhzTOU+FCUl8x+vCebpi8xcrB6GdjXv+Tjbp7JSRhJyY9AS4w5b611RaR
 rdSjZ6JwkD3/F5oY1bS7WJr3dcWDXP7fKVGamjFo=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 03/10] KVM: arm64: Move kvm_get_hyp_vector() out of header
 file
Date: Fri, 13 Nov 2020 11:38:40 +0000
Message-Id: <20201113113847.21619-4-will@kernel.org>
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

kvm_get_hyp_vector() has only one caller, so move it out of kvm_mmu.h
and inline it into a new function, cpu_set_hyp_vector(), for setting
the vector.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 43 -----------------------------
 arch/arm64/kvm/arm.c             | 46 ++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 331394306cce..23182e7d9413 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -208,52 +208,9 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
 	return ret;
 }
 
-/*
- * EL2 vectors can be mapped and rerouted in a number of ways,
- * depending on the kernel configuration and CPU present:
- *
- * - If the CPU is affected by Spectre-v2, the hardening sequence is
- *   placed in one of the vector slots, which is executed before jumping
- *   to the real vectors.
- *
- * - If the CPU also has the ARM64_HARDEN_EL2_VECTORS cap, the slot
- *   containing the hardening sequence is mapped next to the idmap page,
- *   and executed before jumping to the real vectors.
- *
- * - If the CPU only has the ARM64_HARDEN_EL2_VECTORS cap, then an
- *   empty slot is selected, mapped next to the idmap page, and
- *   executed before jumping to the real vectors.
- *
- * Note that ARM64_HARDEN_EL2_VECTORS is somewhat incompatible with
- * VHE, as we don't have hypervisor-specific mappings. If the system
- * is VHE and yet selects this capability, it will be ignored.
- */
 extern void *__kvm_bp_vect_base;
 extern int __kvm_harden_el2_vector_slot;
 
-static inline void *kvm_get_hyp_vector(void)
-{
-	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
-	void *vect = kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
-	int slot = -1;
-
-	if (cpus_have_const_cap(ARM64_SPECTRE_V2) && data->fn) {
-		vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
-		slot = data->hyp_vectors_slot;
-	}
-
-	if (this_cpu_has_cap(ARM64_HARDEN_EL2_VECTORS) && !has_vhe()) {
-		vect = __kvm_bp_vect_base;
-		if (slot == -1)
-			slot = __kvm_harden_el2_vector_slot;
-	}
-
-	if (slot != -1)
-		vect += slot * SZ_2K;
-
-	return vect;
-}
-
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
 static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 476bc613d0e6..c63c0b3c9b17 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1375,13 +1375,55 @@ static void cpu_hyp_reset(void)
 		__hyp_reset_vectors();
 }
 
+/*
+ * EL2 vectors can be mapped and rerouted in a number of ways,
+ * depending on the kernel configuration and CPU present:
+ *
+ * - If the CPU is affected by Spectre-v2, the hardening sequence is
+ *   placed in one of the vector slots, which is executed before jumping
+ *   to the real vectors.
+ *
+ * - If the CPU also has the ARM64_HARDEN_EL2_VECTORS cap, the slot
+ *   containing the hardening sequence is mapped next to the idmap page,
+ *   and executed before jumping to the real vectors.
+ *
+ * - If the CPU only has the ARM64_HARDEN_EL2_VECTORS cap, then an
+ *   empty slot is selected, mapped next to the idmap page, and
+ *   executed before jumping to the real vectors.
+ *
+ * Note that ARM64_HARDEN_EL2_VECTORS is somewhat incompatible with
+ * VHE, as we don't have hypervisor-specific mappings. If the system
+ * is VHE and yet selects this capability, it will be ignored.
+ */
+static void cpu_set_hyp_vector(void)
+{
+	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
+	void *vect = kern_hyp_va(kvm_ksym_ref(__kvm_hyp_vector));
+	int slot = -1;
+
+	if (cpus_have_const_cap(ARM64_SPECTRE_V2) && data->fn) {
+		vect = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
+		slot = data->hyp_vectors_slot;
+	}
+
+	if (this_cpu_has_cap(ARM64_HARDEN_EL2_VECTORS) && !has_vhe()) {
+		vect = __kvm_bp_vect_base;
+		if (slot == -1)
+			slot = __kvm_harden_el2_vector_slot;
+	}
+
+	if (slot != -1)
+		vect += slot * SZ_2K;
+
+	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)vect;
+}
+
 static void cpu_hyp_reinit(void)
 {
 	kvm_init_host_cpu_context(&this_cpu_ptr_hyp_sym(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
-
-	*this_cpu_ptr_hyp_sym(kvm_hyp_vector) = (unsigned long)kvm_get_hyp_vector();
+	cpu_set_hyp_vector();
 
 	if (is_kernel_in_hyp_mode())
 		kvm_timer_init_vhe();
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
