Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 66287454A0D
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 16:37:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 154EC4B19A;
	Wed, 17 Nov 2021 10:37:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DBQRNLxri0UQ; Wed, 17 Nov 2021 10:37:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 06AAC4AC78;
	Wed, 17 Nov 2021 10:37:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 113864B15B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYB9TV8yYHtC for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 10:37:43 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 63B054B15E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:42 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D1FED1;
 Wed, 17 Nov 2021 07:37:42 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C31A53F5A1;
 Wed, 17 Nov 2021 07:37:40 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, mark.rutland@arm.com
Subject: [RFC PATCH v5 23/38] KVM: arm64: debug: Configure MDCR_EL2 when a
 VCPU has SPE
Date: Wed, 17 Nov 2021 15:38:27 +0000
Message-Id: <20211117153842.302159-24-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117153842.302159-1-alexandru.elisei@arm.com>
References: <20211117153842.302159-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

Allow the guest running at EL1 to use SPE when that feature is enabled for
the VCPU by setting the profiling buffer owning translation regime to EL1&0
and disabling traps to the profiling control registers. Keep trapping
accesses to the buffer control registers because that's needed to emulate
the buffer management interrupt.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/kvm/debug.c           | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index a39fcf318c77..3c98bcf7234f 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -302,6 +302,7 @@
 #define MDCR_EL2_TPMS		(UL(1) << 14)
 #define MDCR_EL2_E2PB_MASK	(UL(0x3))
 #define MDCR_EL2_E2PB_SHIFT	(UL(12))
+#define MDCR_EL2_E2PB_TRAP_EL1	(UL(2))
 #define MDCR_EL2_TDRA		(UL(1) << 11)
 #define MDCR_EL2_TDOSA		(UL(1) << 10)
 #define MDCR_EL2_TDA		(UL(1) << 9)
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index db9361338b2a..64629b4bb036 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -77,24 +77,39 @@ void kvm_arm_init_debug(void)
  *  - Performance monitors (MDCR_EL2_TPM/MDCR_EL2_TPMCR)
  *  - Debug ROM Address (MDCR_EL2_TDRA)
  *  - OS related registers (MDCR_EL2_TDOSA)
- *  - Statistical profiler (MDCR_EL2_TPMS/MDCR_EL2_E2PB)
  *  - Self-hosted Trace Filter controls (MDCR_EL2_TTRF)
  *  - Self-hosted Trace (MDCR_EL2_TTRF/MDCR_EL2_E2TB)
  */
 static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * This also clears MDCR_EL2_E2PB_MASK and MDCR_EL2_E2TB_MASK
-	 * to disable guest access to the profiling and trace buffers
+	 * This also clears MDCR_EL2_E2TB_MASK to disable guest access to the
+	 * trace buffers.
 	 */
 	vcpu->arch.mdcr_el2 = __this_cpu_read(mdcr_el2) & MDCR_EL2_HPMN_MASK;
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_TPM |
-				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
 				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
+	if (kvm_supports_spe() && kvm_vcpu_has_spe(vcpu)) {
+		/*
+		 * Use EL1&0 for the profiling buffer translation regime and
+		 * trap accesses to the buffer control registers; leave
+		 * MDCR_EL2.TPMS unset and do not trap accesses to the profiling
+		 * control registers.
+		 */
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_E2PB_TRAP_EL1 << MDCR_EL2_E2PB_SHIFT;
+	} else {
+		/*
+		 * Trap accesses to the profiling control registers; leave
+		 * MDCR_EL2.E2PB unset and use the EL2&0 translation regime for
+		 * the profiling buffer.
+		 */
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TPMS;
+	}
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
