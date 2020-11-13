Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 068962B1A30
	for <lists+kvmarm@lfdr.de>; Fri, 13 Nov 2020 12:39:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF1204BCC8;
	Fri, 13 Nov 2020 06:39:15 -0500 (EST)
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
	with ESMTP id Hb2BQC8sfNpa; Fri, 13 Nov 2020 06:39:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E419C4BD8F;
	Fri, 13 Nov 2020 06:39:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 942FE4BCD4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ztg7gztOC-pe for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Nov 2020 06:39:11 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 83F574BCB9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Nov 2020 06:39:10 -0500 (EST)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 715F32224C;
 Fri, 13 Nov 2020 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605267549;
 bh=dV8wWRhfXlV3yk0BWVWZeILp4gAB4FlndRaj8QjiG0Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tp744yq1yzgyPoFk864ttg/9FYlziuxJ+GeFQ2+Nf/TGmpCRM1/TLw2GHZ/iOTNGV
 Pma7oNMHBDOHLOLGytDtijH1MsvZnfjn0qzbtrSXKwPNL39bLB2/+JypfG7fui2sPK
 7RWbprD6myzNoMl3DCRUG6LOpEAXyKDYuzE/BGE0=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 10/10] KVM: arm64: Remove redundant hyp vectors entry
Date: Fri, 13 Nov 2020 11:38:47 +0000
Message-Id: <20201113113847.21619-11-will@kernel.org>
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

The hyp vectors entry corresponding to HYP_VECTOR_DIRECT (i.e. when
neither Spectre-v2 nor Spectre-v3a are present) is unused, as we can
simply dispatch straight to __kvm_hyp_vector in this case.

Remove the redundant vector, and massage the logic for resolving a slot
to a vectors entry.

Reported-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/spectre.h | 2 +-
 arch/arm64/kvm/arm.c             | 9 ++++++++-
 arch/arm64/kvm/hyp/hyp-entry.S   | 1 -
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 12a4eb5e4e6b..4e6d90a4fbe0 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -10,7 +10,7 @@
 #define __ASM_SPECTRE_H
 
 #define BP_HARDEN_EL2_SLOTS 4
-#define __BP_HARDEN_HYP_VECS_SZ (BP_HARDEN_EL2_SLOTS * SZ_2K)
+#define __BP_HARDEN_HYP_VECS_SZ	((BP_HARDEN_EL2_SLOTS - 1) * SZ_2K)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d94b12376d62..ef2c9433fadd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1298,9 +1298,16 @@ static unsigned long nvhe_percpu_order(void)
 /* A lookup table holding the hypervisor VA for each vector slot */
 static void *hyp_spectre_vector_selector[BP_HARDEN_EL2_SLOTS];
 
+static int __kvm_vector_slot2idx(enum arm64_hyp_spectre_vector slot)
+{
+	return slot - (slot != HYP_VECTOR_DIRECT);
+}
+
 static void kvm_init_vector_slot(void *base, enum arm64_hyp_spectre_vector slot)
 {
-	hyp_spectre_vector_selector[slot] = base + (slot * SZ_2K);
+	int idx = __kvm_vector_slot2idx(slot);
+
+	hyp_spectre_vector_selector[slot] = base + (idx * SZ_2K);
 }
 
 static int kvm_init_vector_slots(void)
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index e3249e2dda09..d179056e1af8 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -239,7 +239,6 @@ SYM_CODE_END(__kvm_hyp_vector)
 
 	.align	11
 SYM_CODE_START(__bp_harden_hyp_vecs)
-	generate_vectors indirect = 0, spectrev2 = 0 // HYP_VECTOR_DIRECT
 	generate_vectors indirect = 0, spectrev2 = 1 // HYP_VECTOR_SPECTRE_DIRECT
 	generate_vectors indirect = 1, spectrev2 = 0 // HYP_VECTOR_INDIRECT
 	generate_vectors indirect = 1, spectrev2 = 1 // HYP_VECTOR_SPECTRE_INDIRECT
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
