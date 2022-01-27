Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA949E741
	for <lists+kvmarm@lfdr.de>; Thu, 27 Jan 2022 17:18:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CEBC4B0C0;
	Thu, 27 Jan 2022 11:18:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnDgHzfYlVtW; Thu, 27 Jan 2022 11:18:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 818B44B086;
	Thu, 27 Jan 2022 11:18:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 346DF49EBD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Jan 2022 11:18:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23XkzpYUIY7n for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Jan 2022 11:18:02 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5105C4A11C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Jan 2022 11:18:01 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3DF7113E;
 Thu, 27 Jan 2022 08:18:00 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0183F766;
 Thu, 27 Jan 2022 08:17:58 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 1/6] KVM: arm64: Do not change the PMU event filter after a
 VCPU has run
Date: Thu, 27 Jan 2022 16:17:54 +0000
Message-Id: <20220127161759.53553-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127161759.53553-1-alexandru.elisei@arm.com>
References: <20220127161759.53553-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: tglx@linutronix.de, mingo@redhat.com
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

From: Marc Zyngier <maz@kernel.org>

Userspace can specify which events a guest is allowed to use with the
KVM_ARM_VCPU_PMU_V3_FILTER attribute. The list of allowed events can be
identified by a guest from reading the PMCEID{0,1}_EL0 registers.

Changing the PMU event filter after a VCPU has run can cause reads of the
registers performed before the filter is changed to return different values
than reads performed with the new event filter in place. The architecture
defines the two registers as read-only, and this behaviour contradicts
that.

Keep track when the first VCPU has run and deny changes to the PMU event
filter to prevent this from happening.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[ Alexandru E: Added commit message, updated ioctl documentation ]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Tested with a hacked version of kvmtool [1], which sets the event filter
for VCPU 1 only after VCPU 0 has already run.

[1] https://gitlab.arm.com/linux-arm/kvmtool-ae/-/tree/test-pmu-filter-after-vcpu-has-run-v1

 Documentation/virt/kvm/devices/vcpu.rst |  2 +-
 arch/arm64/include/asm/kvm_host.h       |  1 +
 arch/arm64/kvm/arm.c                    |  4 +++
 arch/arm64/kvm/pmu-emul.c               | 33 +++++++++++++++----------
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 60a29972d3f1..d063aaee5bb7 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -70,7 +70,7 @@ irqchip.
 	 -ENODEV  PMUv3 not supported or GIC not initialized
 	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
 	 	  configured as required prior to calling this attribute
-	 -EBUSY   PMUv3 already initialized
+	 -EBUSY   PMUv3 already initialized or a VCPU has already run
 	 -EINVAL  Invalid filter range
 	 =======  ======================================================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5bc01e62c08a..2869259e10c0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -136,6 +136,7 @@ struct kvm_arch {
 
 	/* Memory Tagging Extension enabled for the guest */
 	bool mte_enabled;
+	bool ran_once;
 };
 
 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a4a0063df456..f4e7e38a19e9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -634,6 +634,10 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	if (kvm_vm_is_protected(kvm))
 		kvm_call_hyp_nvhe(__pkvm_vcpu_init_traps, vcpu);
 
+	mutex_lock(&kvm->lock);
+	kvm->arch.ran_once = true;
+	mutex_unlock(&kvm->lock);
+
 	return ret;
 }
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index fbcfd4ec6f92..bc771bc1a041 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -924,6 +924,8 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 
 int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	struct kvm *kvm = vcpu->kvm;
+
 	if (!kvm_vcpu_has_pmu(vcpu))
 		return -ENODEV;
 
@@ -941,7 +943,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		int __user *uaddr = (int __user *)(long)attr->addr;
 		int irq;
 
-		if (!irqchip_in_kernel(vcpu->kvm))
+		if (!irqchip_in_kernel(kvm))
 			return -EINVAL;
 
 		if (get_user(irq, uaddr))
@@ -951,7 +953,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		if (!(irq_is_ppi(irq) || irq_is_spi(irq)))
 			return -EINVAL;
 
-		if (!pmu_irq_is_valid(vcpu->kvm, irq))
+		if (!pmu_irq_is_valid(kvm, irq))
 			return -EINVAL;
 
 		if (kvm_arm_pmu_irq_initialized(vcpu))
@@ -966,7 +968,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		struct kvm_pmu_event_filter filter;
 		int nr_events;
 
-		nr_events = kvm_pmu_event_mask(vcpu->kvm) + 1;
+		nr_events = kvm_pmu_event_mask(kvm) + 1;
 
 		uaddr = (struct kvm_pmu_event_filter __user *)(long)attr->addr;
 
@@ -978,12 +980,17 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		     filter.action != KVM_PMU_EVENT_DENY))
 			return -EINVAL;
 
-		mutex_lock(&vcpu->kvm->lock);
+		mutex_lock(&kvm->lock);
+
+		if (kvm->arch.ran_once) {
+			mutex_unlock(&kvm->lock);
+			return -EBUSY;
+		}
 
-		if (!vcpu->kvm->arch.pmu_filter) {
-			vcpu->kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
-			if (!vcpu->kvm->arch.pmu_filter) {
-				mutex_unlock(&vcpu->kvm->lock);
+		if (!kvm->arch.pmu_filter) {
+			kvm->arch.pmu_filter = bitmap_alloc(nr_events, GFP_KERNEL_ACCOUNT);
+			if (!kvm->arch.pmu_filter) {
+				mutex_unlock(&kvm->lock);
 				return -ENOMEM;
 			}
 
@@ -994,17 +1001,17 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 			 * events, the default is to allow.
 			 */
 			if (filter.action == KVM_PMU_EVENT_ALLOW)
-				bitmap_zero(vcpu->kvm->arch.pmu_filter, nr_events);
+				bitmap_zero(kvm->arch.pmu_filter, nr_events);
 			else
-				bitmap_fill(vcpu->kvm->arch.pmu_filter, nr_events);
+				bitmap_fill(kvm->arch.pmu_filter, nr_events);
 		}
 
 		if (filter.action == KVM_PMU_EVENT_ALLOW)
-			bitmap_set(vcpu->kvm->arch.pmu_filter, filter.base_event, filter.nevents);
+			bitmap_set(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
 		else
-			bitmap_clear(vcpu->kvm->arch.pmu_filter, filter.base_event, filter.nevents);
+			bitmap_clear(kvm->arch.pmu_filter, filter.base_event, filter.nevents);
 
-		mutex_unlock(&vcpu->kvm->lock);
+		mutex_unlock(&kvm->lock);
 
 		return 0;
 	}
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
