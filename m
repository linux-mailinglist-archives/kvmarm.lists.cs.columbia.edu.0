Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC14D980A
	for <lists+kvmarm@lfdr.de>; Wed, 16 Oct 2019 19:00:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5A7D4AA06;
	Wed, 16 Oct 2019 13:00:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cQXQ7GBoTSH3; Wed, 16 Oct 2019 13:00:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F5494AA09;
	Wed, 16 Oct 2019 12:59:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F3AA4AA01
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 12:59:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i2ZvTk5sfPVf for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Oct 2019 12:59:56 -0400 (EDT)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1925D4A9BD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Oct 2019 12:59:56 -0400 (EDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iKmeP-0001K0-AV; Wed, 16 Oct 2019 18:59:53 +0200
Date: Wed, 16 Oct 2019 18:59:53 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: KVM: Invoke compute_layout() before alternatives are
 applied
Message-ID: <20191016165953.o6ogh4fdmsjmd2sw@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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

compute_layout() is invoked as part of an alternative fixup under
stop_machine(). This function invokes get_random_long() which acquires a
sleeping lock on -RT which can not be acquired in this context.

Rename compute_layout() to kvm_compute_layout() and invoke it before
stop_machines() invokes the fixups. Add a __init prefix to
kvm_compute_layout() because the caller has it, too (and so the code can
be discarded after boot).

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/include/asm/alternative.h |  6 ++++++
 arch/arm64/kernel/alternative.c      |  1 +
 arch/arm64/kvm/va_layout.c           | 11 ++++-------
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index b9f8d787eea9f..7532f044d713b 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -35,6 +35,12 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
+#ifdef CONFIG_KVM_ARM_HOST
+void kvm_compute_layout(void);
+#else
+static inline void kvm_compute_layout(void) { }
+#endif
+
 #define ALTINSTR_ENTRY(feature,cb)					      \
 	" .word 661b - .\n"				/* label           */ \
 	" .if " __stringify(cb) " == 0\n"				      \
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index d1757ef1b1e74..c28652ee06f64 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -238,6 +238,7 @@ static int __apply_alternatives_multi_stop(void *unused)
 void __init apply_alternatives_all(void)
 {
 	/* better not try code patching on a live SMP system */
+	kvm_compute_layout();
 	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
 }
 
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 2cf7d4b606c38..0b9fbdf0aaddd 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -22,12 +22,15 @@ static u8 tag_lsb;
 static u64 tag_val;
 static u64 va_mask;
 
-static void compute_layout(void)
+__init void kvm_compute_layout(void)
 {
 	phys_addr_t idmap_addr = __pa_symbol(__hyp_idmap_text_start);
 	u64 hyp_va_msb;
 	int kva_msb;
 
+	if (WARN_ON(va_mask))
+		return;
+
 	/* Where is my RAM region? */
 	hyp_va_msb  = idmap_addr & BIT(vabits_actual - 1);
 	hyp_va_msb ^= BIT(vabits_actual - 1);
@@ -110,9 +113,6 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
 
 	BUG_ON(nr_inst != 5);
 
-	if (!has_vhe() && !va_mask)
-		compute_layout();
-
 	for (i = 0; i < nr_inst; i++) {
 		u32 rd, rn, insn, oinsn;
 
@@ -156,9 +156,6 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 		return;
 	}
 
-	if (!va_mask)
-		compute_layout();
-
 	/*
 	 * Compute HYP VA by using the same computation as kern_hyp_va()
 	 */
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
