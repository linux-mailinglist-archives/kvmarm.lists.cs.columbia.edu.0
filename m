Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 36758266EC
	for <lists+kvmarm@lfdr.de>; Wed, 22 May 2019 17:30:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D66144A4E6;
	Wed, 22 May 2019 11:30:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SK2a-15d248R; Wed, 22 May 2019 11:30:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 290AB4A4F2;
	Wed, 22 May 2019 11:30:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 766924A2E5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 May 2019 11:30:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vvKDv+0r+hTQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 May 2019 11:30:30 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 128B64A4BE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 May 2019 11:30:30 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A67F15AB;
 Wed, 22 May 2019 08:30:29 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B843F718;
 Wed, 22 May 2019 08:30:27 -0700 (PDT)
From: Andrew Murray <andrew.murray@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v8 1/6] KVM: arm/arm64: rename
 kvm_pmu_{enable/disable}_counter functions
Date: Wed, 22 May 2019 16:30:14 +0100
Message-Id: <20190522153019.18645-2-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522153019.18645-1-andrew.murray@arm.com>
References: <20190522153019.18645-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

The kvm_pmu_{enable/disable}_counter functions can enabled/disable
multiple counters at once as they operate on a bitmask. Let's
make this clearer by renaming the function.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kvm/sys_regs.c |  4 ++--
 include/kvm/arm_pmu.h     |  8 ++++----
 virt/kvm/arm/pmu.c        | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 9d02643bc601..8e98fb173ed3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -876,12 +876,12 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 		if (r->Op2 & 0x1) {
 			/* accessing PMCNTENSET_EL0 */
 			__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) |= val;
-			kvm_pmu_enable_counter(vcpu, val);
+			kvm_pmu_enable_counter_mask(vcpu, val);
 			kvm_vcpu_pmu_restore_guest(vcpu);
 		} else {
 			/* accessing PMCNTENCLR_EL0 */
 			__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= ~val;
-			kvm_pmu_disable_counter(vcpu, val);
+			kvm_pmu_disable_counter_mask(vcpu, val);
 		}
 	} else {
 		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index f87fe20fcb05..b73f31baca52 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -46,8 +46,8 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
-void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val);
-void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
+void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
 bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu);
@@ -83,8 +83,8 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 }
 static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
-static inline void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val) {}
-static inline void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
+static inline void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 1c5b76c46e26..c5a722ad283f 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -135,13 +135,13 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 }
 
 /**
- * kvm_pmu_enable_counter - enable selected PMU counter
+ * kvm_pmu_enable_counter_mask - enable selected PMU counters
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENSET register
  *
  * Call perf_event_enable to start counting the perf event
  */
-void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
+void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
@@ -164,13 +164,13 @@ void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
 }
 
 /**
- * kvm_pmu_disable_counter - disable selected PMU counter
+ * kvm_pmu_disable_counter_mask - disable selected PMU counters
  * @vcpu: The vcpu pointer
  * @val: the value guest writes to PMCNTENCLR register
  *
  * Call perf_event_disable to stop counting the perf event
  */
-void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val)
+void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
 {
 	int i;
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
@@ -347,10 +347,10 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 
 	mask = kvm_pmu_valid_counter_mask(vcpu);
 	if (val & ARMV8_PMU_PMCR_E) {
-		kvm_pmu_enable_counter(vcpu,
+		kvm_pmu_enable_counter_mask(vcpu,
 		       __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
 	} else {
-		kvm_pmu_disable_counter(vcpu, mask);
+		kvm_pmu_disable_counter_mask(vcpu, mask);
 	}
 
 	if (val & ARMV8_PMU_PMCR_C)
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
