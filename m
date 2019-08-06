Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7103F835FB
	for <lists+kvmarm@lfdr.de>; Tue,  6 Aug 2019 17:57:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92C304A562;
	Tue,  6 Aug 2019 11:57:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGSg7x1kD9NH; Tue,  6 Aug 2019 11:57:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EC544A55C;
	Tue,  6 Aug 2019 11:57:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7DE84A526
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Aug 2019 11:57:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7BxoiKgWkBm8 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Aug 2019 11:57:49 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CEB84A4F4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Aug 2019 11:57:49 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D65344;
 Tue,  6 Aug 2019 08:57:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C30353F575;
 Tue,  6 Aug 2019 08:57:47 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/kvm: remove VMID rollover I-cache maintenance
Date: Tue,  6 Aug 2019 16:57:37 +0100
Message-Id: <20190806155737.39307-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu
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

For VPIPT I-caches, we need I-cache maintenance on VMID rollover to
avoid an ABA problem. Consider a single vCPU VM, with a pinned stage-2,
running with an idmap VA->IPA and idmap IPA->PA. If we don't do
maintenance on rollover:

        // VMID A
        Writes insn X to PA 0xF
        Invalidates PA 0xF (for VMID A)

        I$ contains [{A,F}->X]

        [VMID ROLLOVER]

        // VMID B
        Writes insn Y to PA 0xF
        Invalidates PA 0xF (for VMID B)

        I$ contains [{A,F}->X, {B,F}->Y]

        [VMID ROLLOVER]

        // VMID A
        I$ contains [{A,F}->X, {B,F}->Y]

        Unexpectedly hits stale I$ line {A,F}->X.

However, for PIPT and VIPT I-caches, the VMID doesn't affect lookup or
constrain maintenance. Given the VMID doesn't affect PIPT and VIPT
I-caches, and given VMID rollover is independent of changes to stage-2
mappings, I-cache maintenance cannot be necessary on VMID rollover for
PIPT or VIPT I-caches.

This patch removes the maintenance on rollover for VIPT and PIPT
I-caches. At the same time, the unnecessary colons are removed from the
asm statement to make it more legible.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/hyp/tlb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index d49a14497715..c466060b76d6 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -193,6 +193,18 @@ void __hyp_text __kvm_flush_vm_context(void)
 {
 	dsb(ishst);
 	__tlbi(alle1is);
-	asm volatile("ic ialluis" : : );
+
+	/*
+	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
+	 * is necessary across a VMID rollover.
+	 *
+	 * VPIPT caches constrain lookup and maintenance to the active VMID,
+	 * so we need to invalidate lines with a stale VMID to avoid an ABA
+	 * race after multiple rollovers.
+	 *
+	 */
+	if (icache_is_vpipt())
+		asm volatile("ic ialluis");
+
 	dsb(ish);
 }
-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
