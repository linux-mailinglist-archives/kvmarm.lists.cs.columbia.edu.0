Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5200A32F333
	for <lists+kvmarm@lfdr.de>; Fri,  5 Mar 2021 19:53:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00AE04B70F;
	Fri,  5 Mar 2021 13:53:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWymiva443AW; Fri,  5 Mar 2021 13:53:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 222E64B70A;
	Fri,  5 Mar 2021 13:53:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DEC14B286
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Mar 2021 13:53:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3I1LHJiEdL-V for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Mar 2021 13:53:04 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 40E1D4B6D6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Mar 2021 13:53:04 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D6E0650A3;
 Fri,  5 Mar 2021 18:53:03 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lIFZN-00HYFA-JC; Fri, 05 Mar 2021 18:53:01 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/8] KVM: arm64: Turn kvm_arm_support_pmu_v3() into a static
 key
Date: Fri,  5 Mar 2021 18:52:50 +0000
Message-Id: <20210305185254.3730990-5-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305185254.3730990-1-maz@kernel.org>
References: <87eegtzbch.wl-maz@kernel.org>
 <20210305185254.3730990-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 andre.przywara@arm.com, ascull@google.com, catalin.marinas@arm.com,
 christoffer.dall@arm.com, Howard.Zhang@arm.com, justin.he@arm.com,
 mark.rutland@arm.com, qperret@google.com, shameerali.kolothum.thodi@huawei.com,
 suzuki.poulose@arm.com, will@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Jia He <justin.he@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Howard Zhang <Howard.Zhang@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

We currently find out about the presence of a HW PMU (or the handling
of that PMU by perf, which amounts to the same thing) in a fairly
roundabout way, by checking the number of counters available to perf.
That's good enough for now, but we will soon need to find about about
that on paths where perf is out of reach (in the world switch).

Instead, let's turn kvm_arm_support_pmu_v3() into a static key.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
Link: https://lore.kernel.org/r/20210209114844.3278746-2-maz@kernel.org
---
 arch/arm64/kvm/perf.c     | 10 ++++++++++
 arch/arm64/kvm/pmu-emul.c | 10 ----------
 include/kvm/arm_pmu.h     |  9 +++++++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index d45b8b9a4415..739164324afe 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -11,6 +11,8 @@
 
 #include <asm/kvm_emulate.h>
 
+DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
 static int kvm_is_in_guest(void)
 {
         return kvm_get_running_vcpu() != NULL;
@@ -48,6 +50,14 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 
 int kvm_perf_init(void)
 {
+	/*
+	 * Check if HW_PERF_EVENTS are supported by checking the number of
+	 * hardware performance counters. This could ensure the presence of
+	 * a physical PMU and CONFIG_PERF_EVENT is selected.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_PMU) && perf_num_counters() > 0)
+		static_branch_enable(&kvm_arm_pmu_available);
+
 	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index e9ec08b0b070..e32c6e139a09 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -823,16 +823,6 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 	return val & mask;
 }
 
-bool kvm_arm_support_pmu_v3(void)
-{
-	/*
-	 * Check if HW_PERF_EVENTS are supported by checking the number of
-	 * hardware performance counters. This could ensure the presence of
-	 * a physical PMU and CONFIG_PERF_EVENT is selected.
-	 */
-	return (perf_num_counters() > 0);
-}
-
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_vcpu_has_pmu(vcpu))
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 8dcb3e1477bc..6fd3cda608e4 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -13,6 +13,13 @@
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
 
+DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
+static __always_inline bool kvm_arm_support_pmu_v3(void)
+{
+	return static_branch_likely(&kvm_arm_pmu_available);
+}
+
 #ifdef CONFIG_HW_PERF_EVENTS
 
 struct kvm_pmc {
@@ -47,7 +54,6 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx);
-bool kvm_arm_support_pmu_v3(void);
 int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
@@ -87,7 +93,6 @@ static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
 						  u64 data, u64 select_idx) {}
-static inline bool kvm_arm_support_pmu_v3(void) { return false; }
 static inline int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
 					  struct kvm_device_attr *attr)
 {
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
