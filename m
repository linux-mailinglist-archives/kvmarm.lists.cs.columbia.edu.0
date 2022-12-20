Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03484652790
	for <lists+kvmarm@lfdr.de>; Tue, 20 Dec 2022 21:09:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 765AA4B5EA;
	Tue, 20 Dec 2022 15:09:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CexxBoh1XOec; Tue, 20 Dec 2022 15:09:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D59314B6DD;
	Tue, 20 Dec 2022 15:09:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B5AA24B5ED
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Dec 2022 15:09:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eSybwHD-BOPa for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Dec 2022 15:09:35 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0F98E4B125
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Dec 2022 15:09:35 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 69D8BB819B3;
 Tue, 20 Dec 2022 20:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C30AC4339B;
 Tue, 20 Dec 2022 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671566972;
 bh=Y5H16bZnT3rfVYbiCegagG+RRvHTAFJrdQ8iYT1WEZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BknxODm1Ki8W4ZCUfH7e4Px05eb9NKcxZYsv/hT7Ug2LTOfr7H/BygcZyoOoe+sHG
 6U2qVWlABQyhaDthWPp5lya3StPwJ3cYw1M3G1FAC2l4/PO4MVBvIWiZZi9Wnv75YF
 MK6gqej6igkDoCiY8UWp9ux75QpAteaIg0lBq7ZiZ0lZLKxpxTGyydtoAuOPfzo6SG
 CG5Qj9Hp+jzZY44E0qfnO+GfbxF2Fwbx6PqnI9zIfiiONBh0dHJVrO4TQI+8bzWZhI
 AE5YRzt3iDoughdzriEAAVbm4qEd+RzmHGclyhUzdrpHzwSGZlTFnsP8uZm8GqoZWt
 pssTP3FPM7Qlg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p7iva-00Dzct-1i;
 Tue, 20 Dec 2022 20:09:30 +0000
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] KVM: arm64: Convert FSC_* over to ESR_ELx_FSC_*
Date: Tue, 20 Dec 2022 20:09:23 +0000
Message-Id: <20221220200923.1532710-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220200923.1532710-1-maz@kernel.org>
References: <20221220200923.1532710-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 ardb@kernel.org, will@kernel.org, qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>
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

The former is an AArch32 legacy, so let's move over to the
verbose (and strictly identical) version.

This involves moving some of the #defines that were private
to KVM into the more generic esr.h.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/esr.h            |  9 +++++++++
 arch/arm64/include/asm/kvm_arm.h        | 15 ---------------
 arch/arm64/include/asm/kvm_emulate.h    | 20 ++++++++++----------
 arch/arm64/kvm/hyp/include/hyp/fault.h  |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/mmu.c                    | 21 ++++++++++++---------
 6 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 15b34fbfca66..206de10524e3 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -114,6 +114,15 @@
 #define ESR_ELx_FSC_ACCESS	(0x08)
 #define ESR_ELx_FSC_FAULT	(0x04)
 #define ESR_ELx_FSC_PERM	(0x0C)
+#define ESR_ELx_FSC_SEA_TTW0	(0x14)
+#define ESR_ELx_FSC_SEA_TTW1	(0x15)
+#define ESR_ELx_FSC_SEA_TTW2	(0x16)
+#define ESR_ELx_FSC_SEA_TTW3	(0x17)
+#define ESR_ELx_FSC_SECC	(0x18)
+#define ESR_ELx_FSC_SECC_TTW0	(0x1c)
+#define ESR_ELx_FSC_SECC_TTW1	(0x1d)
+#define ESR_ELx_FSC_SECC_TTW2	(0x1e)
+#define ESR_ELx_FSC_SECC_TTW3	(0x1f)
 
 /* ISS field definitions for Data Aborts */
 #define ESR_ELx_ISV_SHIFT	(24)
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 0df3fc3a0173..26b0c97df986 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -319,21 +319,6 @@
 				 BIT(18) |		\
 				 GENMASK(16, 15))
 
-/* For compatibility with fault code shared with 32-bit */
-#define FSC_FAULT	ESR_ELx_FSC_FAULT
-#define FSC_ACCESS	ESR_ELx_FSC_ACCESS
-#define FSC_PERM	ESR_ELx_FSC_PERM
-#define FSC_SEA		ESR_ELx_FSC_EXTABT
-#define FSC_SEA_TTW0	(0x14)
-#define FSC_SEA_TTW1	(0x15)
-#define FSC_SEA_TTW2	(0x16)
-#define FSC_SEA_TTW3	(0x17)
-#define FSC_SECC	(0x18)
-#define FSC_SECC_TTW0	(0x1c)
-#define FSC_SECC_TTW1	(0x1d)
-#define FSC_SECC_TTW2	(0x1e)
-#define FSC_SECC_TTW3	(0x1f)
-
 /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
 #define HPFAR_MASK	(~UL(0xf))
 /*
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 4ee467065042..d67a09c07f98 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -349,16 +349,16 @@ static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *v
 static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 {
 	switch (kvm_vcpu_trap_get_fault(vcpu)) {
-	case FSC_SEA:
-	case FSC_SEA_TTW0:
-	case FSC_SEA_TTW1:
-	case FSC_SEA_TTW2:
-	case FSC_SEA_TTW3:
-	case FSC_SECC:
-	case FSC_SECC_TTW0:
-	case FSC_SECC_TTW1:
-	case FSC_SECC_TTW2:
-	case FSC_SECC_TTW3:
+	case ESR_ELx_FSC_EXTABT:
+	case ESR_ELx_FSC_SEA_TTW0:
+	case ESR_ELx_FSC_SEA_TTW1:
+	case ESR_ELx_FSC_SEA_TTW2:
+	case ESR_ELx_FSC_SEA_TTW3:
+	case ESR_ELx_FSC_SECC:
+	case ESR_ELx_FSC_SECC_TTW0:
+	case ESR_ELx_FSC_SECC_TTW1:
+	case ESR_ELx_FSC_SECC_TTW2:
+	case ESR_ELx_FSC_SECC_TTW3:
 		return true;
 	default:
 		return false;
diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
index 1b8a2dcd712f..9ddcfe2c3e57 100644
--- a/arch/arm64/kvm/hyp/include/hyp/fault.h
+++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
@@ -60,7 +60,7 @@ static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
 	 */
 	if (!(esr & ESR_ELx_S1PTW) &&
 	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
-	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
+	     (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_PERM)) {
 		if (!__translate_far_to_hpfar(far, &hpfar))
 			return false;
 	} else {
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 3330d1b76bdd..07d37ff88a3f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -367,7 +367,7 @@ static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
 		bool valid;
 
-		valid = kvm_vcpu_trap_get_fault_type(vcpu) == FSC_FAULT &&
+		valid = kvm_vcpu_trap_get_fault_type(vcpu) == ESR_ELx_FSC_FAULT &&
 			kvm_vcpu_dabt_isvalid(vcpu) &&
 			!kvm_vcpu_abt_issea(vcpu) &&
 			!kvm_vcpu_abt_iss1tw(vcpu);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 31d7fa4c7c14..a3ee3b605c9b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1212,7 +1212,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
 	VM_BUG_ON(write_fault && exec_fault);
 
-	if (fault_status == FSC_PERM && !write_fault && !exec_fault) {
+	if (fault_status == ESR_ELx_FSC_PERM && !write_fault && !exec_fault) {
 		kvm_err("Unexpected L2 read permission error\n");
 		return -EFAULT;
 	}
@@ -1277,7 +1277,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * only exception to this is when dirty logging is enabled at runtime
 	 * and a write fault needs to collapse a block entry into a table.
 	 */
-	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
+	if (fault_status != ESR_ELx_FSC_PERM ||
+	    (logging_active && write_fault)) {
 		ret = kvm_mmu_topup_memory_cache(memcache,
 						 kvm_mmu_cache_min_pages(kvm));
 		if (ret)
@@ -1342,7 +1343,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * backed by a THP and thus use block mapping if possible.
 	 */
 	if (vma_pagesize == PAGE_SIZE && !(force_pte || device)) {
-		if (fault_status == FSC_PERM && fault_granule > PAGE_SIZE)
+		if (fault_status ==  ESR_ELx_FSC_PERM &&
+		    fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
 			vma_pagesize = transparent_hugepage_adjust(kvm, memslot,
@@ -1350,7 +1352,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 								   &fault_ipa);
 	}
 
-	if (fault_status != FSC_PERM && !device && kvm_has_mte(kvm)) {
+	if (fault_status != ESR_ELx_FSC_PERM && !device && kvm_has_mte(kvm)) {
 		/* Check the VMM hasn't introduced a new disallowed VMA */
 		if (kvm_vma_mte_allowed(vma)) {
 			sanitise_mte_tags(kvm, pfn, vma_pagesize);
@@ -1376,7 +1378,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * permissions only if vma_pagesize equals fault_granule. Otherwise,
 	 * kvm_pgtable_stage2_map() should be called to change block size.
 	 */
-	if (fault_status == FSC_PERM && vma_pagesize == fault_granule)
+	if (fault_status == ESR_ELx_FSC_PERM && vma_pagesize == fault_granule)
 		ret = kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, prot);
 	else
 		ret = kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesize,
@@ -1441,7 +1443,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	fault_ipa = kvm_vcpu_get_fault_ipa(vcpu);
 	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
 
-	if (fault_status == FSC_FAULT) {
+	if (fault_status == ESR_ELx_FSC_FAULT) {
 		/* Beyond sanitised PARange (which is the IPA limit) */
 		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit())) {
 			kvm_inject_size_fault(vcpu);
@@ -1476,8 +1478,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
 	/* Check the stage-2 fault is trans. fault or write fault */
-	if (fault_status != FSC_FAULT && fault_status != FSC_PERM &&
-	    fault_status != FSC_ACCESS) {
+	if (fault_status != ESR_ELx_FSC_FAULT &&
+	    fault_status != ESR_ELx_FSC_PERM &&
+	    fault_status != ESR_ELx_FSC_ACCESS) {
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
@@ -1539,7 +1542,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Userspace should not be able to register out-of-bounds IPAs */
 	VM_BUG_ON(fault_ipa >= kvm_phys_size(vcpu->kvm));
 
-	if (fault_status == FSC_ACCESS) {
+	if (fault_status == ESR_ELx_FSC_ACCESS) {
 		handle_access_fault(vcpu, fault_ipa);
 		ret = 1;
 		goto out_unlock;
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
