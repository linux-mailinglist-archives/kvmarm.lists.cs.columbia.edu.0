Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF111CEA9F
	for <lists+kvmarm@lfdr.de>; Tue, 12 May 2020 04:14:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 976354B12C;
	Mon, 11 May 2020 22:14:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoRYNA16c6tV; Mon, 11 May 2020 22:14:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 706924B139;
	Mon, 11 May 2020 22:14:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96C434B12C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 May 2020 22:14:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GKIb+sGd5EmR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 May 2020 22:14:03 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C5754B11F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 May 2020 22:14:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D777C1FB;
 Mon, 11 May 2020 19:14:02 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DC573F71E;
 Mon, 11 May 2020 19:14:00 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/cpufeature: Add ID_AA64MMFR0_PARANGE_MASK
Date: Tue, 12 May 2020 07:43:26 +0530
Message-Id: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

This replaces multiple open encoding (0x7) with ID_AA64MMFR0_PARANGE_MASK
thus cleaning the clutter. It modifies an existing ID_AA64MMFR0 helper and
introduces a new one i.e id_aa64mmfr0_iparange() and id_aa64mmfr0_parange()
respectively.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies after (https://patchwork.kernel.org/patch/11541893/).

 arch/arm64/include/asm/cpufeature.h | 11 ++++++++++-
 arch/arm64/kernel/cpufeature.c      |  5 ++---
 arch/arm64/kvm/reset.c              |  9 +++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1291ad5a9ccb..320cfc5b6025 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -706,8 +706,17 @@ void arm64_set_ssbd_mitigation(bool state);
 
 extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 
-static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+#define ID_AA64MMFR0_PARANGE_MASK 0x7
+
+static inline u32 id_aa64mmfr0_parange(u64 mmfr0)
 {
+	return mmfr0 & ID_AA64MMFR0_PARANGE_MASK;
+}
+
+static inline u32 id_aa64mmfr0_iparange(u64 mmfr0)
+{
+	int parange = id_aa64mmfr0_parange(mmfr0);
+
 	switch (parange) {
 	case 0: return 32;
 	case 1: return 36;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 30917fe7942a..2c62f7c64a3c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2185,7 +2185,7 @@ static void verify_sve_features(void)
 void verify_hyp_capabilities(void)
 {
 	u64 safe_mmfr1, mmfr0, mmfr1;
-	int parange, ipa_max;
+	int ipa_max;
 	unsigned int safe_vmid_bits, vmid_bits;
 
 	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
@@ -2201,8 +2201,7 @@ void verify_hyp_capabilities(void)
 	}
 
 	/* Verify IPA range */
-	parange = mmfr0 & 0x7;
-	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
+	ipa_max = id_aa64mmfr0_iparange(mmfr0);
 	if (ipa_max < get_kvm_ipa_limit()) {
 		pr_crit("CPU%d: IPA range mismatch\n", smp_processor_id());
 		cpu_die_early();
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 841b492ff334..2e4da75d79ea 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -347,10 +347,10 @@ u32 get_kvm_ipa_limit(void)
 
 void kvm_set_ipa_limit(void)
 {
-	unsigned int ipa_max, pa_max, va_max, parange;
+	unsigned int ipa_max, pa_max, va_max;
 
-	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
-	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
+	pa_max = id_aa64mmfr0_iparange(read_sanitised_ftr_reg
+						(SYS_ID_AA64MMFR0_EL1));
 
 	/* Clamp the IPA limit to the PA size supported by the kernel */
 	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
@@ -411,7 +411,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 		phys_shift = KVM_PHYS_SHIFT;
 	}
 
-	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
+	parange = id_aa64mmfr0_parange(read_sanitised_ftr_reg
+						(SYS_ID_AA64MMFR0_EL1));
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
 	vtcr |= parange << VTCR_EL2_PS_SHIFT;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
