Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ACEBE4EF082
	for <lists+kvmarm@lfdr.de>; Fri,  1 Apr 2022 16:35:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CA854B288;
	Fri,  1 Apr 2022 10:35:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J6NOfYOBr6l7; Fri,  1 Apr 2022 10:35:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE1904B22B;
	Fri,  1 Apr 2022 10:35:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 657C74B18F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Apr 2022 10:35:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kb4El6Nt0s9t for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Apr 2022 10:35:00 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DA5AB4B164
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Apr 2022 10:34:59 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6919EB82522;
 Fri,  1 Apr 2022 14:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83411C340F2;
 Fri,  1 Apr 2022 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648823695;
 bh=h6tEdTEiLa3QMvSfq+L4/ZRy7SJQezJ633iJ7+1klsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EKZP1uH6QieLhU1pKEh5QHV6RWg5Wn4FfbYgBQttlgxK6eVkX1PLtQ4ObTM5lWEbL
 JiHCFX7swmVdIsAx0XZrVjXCCd+WjM/mdpKK/JTHsDhaNkRLQylKxJYUgcsNskVLdK
 0e9HKKGNpviJ6+G2ALc/6mN3HiAdGLYD+/3IMDyUBShSzSbqRZNAD4SJPQ5xWWteP3
 HFWDb7aVeFy80u+duOMleA9xYyzH7aiVk1G/Qe4JPoSGbCOtQlVkKXuSvR2vi8VUoA
 odI6C/1oPjEPgzewb5L8qMbqmFUdI3bPWu+9VbyLN3Ddc3TCNXdKMkaZ0LNrGl4sOb
 8eC3XRWGeFbvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 042/109] KVM: arm64: Do not change the PMU event
 filter after a VCPU has run
Date: Fri,  1 Apr 2022 10:31:49 -0400
Message-Id: <20220401143256.1950537-42-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org, will@kernel.org,
 corbet@lwn.net, Marc Zyngier <maz@kernel.org>, linux-doc@vger.kernel.org,
 catalin.marinas@arm.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 5177fe91e4cf78a659aada2c9cf712db4d788481 ]

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220127161759.53553-2-alexandru.elisei@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
index d016f27af6da..8c7ba346d713 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -137,6 +137,7 @@ struct kvm_arch {
 
 	/* Memory Tagging Extension enabled for the guest */
 	bool mte_enabled;
+	bool ran_once;
 };
 
 struct kvm_vcpu_fault_info {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1eadf9088880..6f3be4d44abe 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -629,6 +629,10 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (kvm_vm_is_protected(kvm))
 		kvm_call_hyp_nvhe(__pkvm_vcpu_init_traps, vcpu);
 
+	mutex_lock(&kvm->lock);
+	kvm->arch.ran_once = true;
+	mutex_unlock(&kvm->lock);
+
 	return ret;
 }
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a5e4bbf5e68f..c996fc562da4 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -921,6 +921,8 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 
 int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	struct kvm *kvm = vcpu->kvm;
+
 	if (!kvm_vcpu_has_pmu(vcpu))
 		return -ENODEV;
 
@@ -938,7 +940,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		int __user *uaddr = (int __user *)(long)attr->addr;
 		int irq;
 
-		if (!irqchip_in_kernel(vcpu->kvm))
+		if (!irqchip_in_kernel(kvm))
 			return -EINVAL;
 
 		if (get_user(irq, uaddr))
@@ -948,7 +950,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		if (!(irq_is_ppi(irq) || irq_is_spi(irq)))
 			return -EINVAL;
 
-		if (!pmu_irq_is_valid(vcpu->kvm, irq))
+		if (!pmu_irq_is_valid(kvm, irq))
 			return -EINVAL;
 
 		if (kvm_arm_pmu_irq_initialized(vcpu))
@@ -963,7 +965,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		struct kvm_pmu_event_filter filter;
 		int nr_events;
 
-		nr_events = kvm_pmu_event_mask(vcpu->kvm) + 1;
+		nr_events = kvm_pmu_event_mask(kvm) + 1;
 
 		uaddr = (struct kvm_pmu_event_filter __user *)(long)attr->addr;
 
@@ -975,12 +977,17 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
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
 
@@ -991,17 +998,17 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
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
