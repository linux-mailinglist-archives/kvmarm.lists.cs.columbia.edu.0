Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA4532AC79B
	for <lists+kvmarm@lfdr.de>; Mon,  9 Nov 2020 22:47:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EE614BA6C;
	Mon,  9 Nov 2020 16:47:56 -0500 (EST)
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
	with ESMTP id lDwh8kuH5C3a; Mon,  9 Nov 2020 16:47:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E952D4BA39;
	Mon,  9 Nov 2020 16:47:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 338C84BA4C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 16:47:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6djtpfsPvZj for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Nov 2020 16:47:51 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 391BD4BA20
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Nov 2020 16:47:51 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F095B20809;
 Mon,  9 Nov 2020 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604958470;
 bh=pHSa2phLcFmScsYbkPw47ndt/SYrxfSBSl4PgS4n0Zw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BXZjUJQ+ltq5xcTSgPSwKBSSTrpr9b7ftB7nCouwnCtzSWmjmfGtaM2kEgizjWJY0
 oLZliHG+v7yZAPC7r4RDgPaGccna1WzCZxNW1vAxy9AEDaxFRNZYzkfQvLJkZUPc8j
 JQ2SS8AKQz7CMtpHgGg05oHaUdZUyahugR3iILM4=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 4/9] KVM: arm64: Make BP hardening globals static instead
Date: Mon,  9 Nov 2020 21:47:21 +0000
Message-Id: <20201109214726.15276-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201109214726.15276-1-will@kernel.org>
References: <20201109214726.15276-1-will@kernel.org>
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

Branch predictor hardening of the hyp vectors is partially driven by a
couple of global variables ('__kvm_bp_vect_base' and
'__kvm_harden_el2_vector_slot'). However, these are only used within a
single compilation unit, so internalise them there instead.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 ---
 arch/arm64/kvm/arm.c             | 8 ++++++++
 arch/arm64/kvm/va_layout.c       | 3 ---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 23182e7d9413..db721be0df62 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -208,9 +208,6 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
 	return ret;
 }
 
-extern void *__kvm_bp_vect_base;
-extern int __kvm_harden_el2_vector_slot;
-
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
 static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c63c0b3c9b17..3262c16f0449 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -51,6 +51,14 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 
+/* Hypervisor VA of the indirect vector trampoline page */
+static void *__kvm_bp_vect_base;
+/*
+ * Slot in the hyp vector page for use by the indirect vector trampoline
+ * when mitigation against Spectre-v2 is not required.
+ */
+static int __kvm_harden_el2_vector_slot;
+
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index e0404bcab019..d1195c288c9f 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -131,9 +131,6 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
 	}
 }
 
-void *__kvm_bp_vect_base;
-int __kvm_harden_el2_vector_slot;
-
 void kvm_patch_vector_branch(struct alt_instr *alt,
 			     __le32 *origptr, __le32 *updptr, int nr_inst)
 {
-- 
2.29.2.222.g5d2a92d10f8-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
