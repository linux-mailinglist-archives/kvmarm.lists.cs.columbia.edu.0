Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0893635AA
	for <lists+kvmarm@lfdr.de>; Tue,  9 Jul 2019 14:25:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63F424A56A;
	Tue,  9 Jul 2019 08:25:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JcQR37CvCKd; Tue,  9 Jul 2019 08:25:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 985374A563;
	Tue,  9 Jul 2019 08:25:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D2AB64A568
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jul 2019 08:25:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zX9KQ0UVtmyV for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Jul 2019 08:25:44 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AFA54A543
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jul 2019 08:25:44 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C91C1595;
 Tue,  9 Jul 2019 05:25:44 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (unknown [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707C03F59C;
 Tue,  9 Jul 2019 05:25:42 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 12/18] KVM: arm/arm64: Remove pmc->bitmask
Date: Tue,  9 Jul 2019 13:25:01 +0100
Message-Id: <20190709122507.214494-13-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709122507.214494-1-marc.zyngier@arm.com>
References: <20190709122507.214494-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, Steven Price <steven.price@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Andrew Murray <andrew.murray@arm.com>

We currently use pmc->bitmask to determine the width of the pmc - however
it's superfluous as the pmc index already describes if the pmc is a cycle
counter or event counter. The architecture clearly describes the widths of
these counters.

Let's remove the bitmask to simplify the code.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_pmu.h |  1 -
 virt/kvm/arm/pmu.c    | 30 ++++++++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 45e5205750b4..48a15d4b820e 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -17,7 +17,6 @@
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
 	struct perf_event *perf_event;
-	u64 bitmask;
 };
 
 struct kvm_pmu {
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index f77643f4274c..24c6cf869a16 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -14,6 +14,18 @@
 #include <kvm/arm_vgic.h>
 
 static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
+
+/**
+ * kvm_pmu_idx_is_64bit - determine if select_idx is a 64bit counter
+ * @vcpu: The vcpu pointer
+ * @select_idx: The counter index
+ */
+static bool kvm_pmu_idx_is_64bit(struct kvm_vcpu *vcpu, u64 select_idx)
+{
+	return (select_idx == ARMV8_PMU_CYCLE_IDX &&
+		__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_LC);
+}
+
 /**
  * kvm_pmu_get_counter_value - get PMU counter value
  * @vcpu: The vcpu pointer
@@ -36,7 +48,10 @@ u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
 		counter += perf_event_read_value(pmc->perf_event, &enabled,
 						 &running);
 
-	return counter & pmc->bitmask;
+	if (!kvm_pmu_idx_is_64bit(vcpu, select_idx))
+		counter = lower_32_bits(counter);
+
+	return counter;
 }
 
 /**
@@ -102,7 +117,6 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
 		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 		pmu->pmc[i].idx = i;
-		pmu->pmc[i].bitmask = 0xffffffffUL;
 	}
 }
 
@@ -337,8 +351,6 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
  */
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 {
-	struct kvm_pmu *pmu = &vcpu->arch.pmu;
-	struct kvm_pmc *pmc;
 	u64 mask;
 	int i;
 
@@ -357,11 +369,6 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 		for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++)
 			kvm_pmu_set_counter_value(vcpu, i, 0);
 	}
-
-	if (val & ARMV8_PMU_PMCR_LC) {
-		pmc = &pmu->pmc[ARMV8_PMU_CYCLE_IDX];
-		pmc->bitmask = 0xffffffffffffffffUL;
-	}
 }
 
 static bool kvm_pmu_counter_is_enabled(struct kvm_vcpu *vcpu, u64 select_idx)
@@ -409,7 +416,10 @@ static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx)
 
 	counter = kvm_pmu_get_counter_value(vcpu, select_idx);
 	/* The initial sample period (overflow count) of an event. */
-	attr.sample_period = (-counter) & pmc->bitmask;
+	if (kvm_pmu_idx_is_64bit(vcpu, pmc->idx))
+		attr.sample_period = (-counter) & GENMASK(63, 0);
+	else
+		attr.sample_period = (-counter) & GENMASK(31, 0);
 
 	event = perf_event_create_kernel_counter(&attr, -1, current,
 						 kvm_pmu_perf_overflow, pmc);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
