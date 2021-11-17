Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CCC99454A0B
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 16:37:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BD7C4B19A;
	Wed, 17 Nov 2021 10:37:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEa1YGOACwhF; Wed, 17 Nov 2021 10:37:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B15964B139;
	Wed, 17 Nov 2021 10:37:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91FD54B131
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqa9ZLdpFy6P for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 10:37:38 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B8EA54B15E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 10:37:38 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8062FED1;
 Wed, 17 Nov 2021 07:37:38 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B879A3F5A1;
 Wed, 17 Nov 2021 07:37:36 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, mark.rutland@arm.com
Subject: [RFC PATCH v5 21/38] KVM: arm64: Add SPE VCPU device attribute to set
 the interrupt number
Date: Wed, 17 Nov 2021 15:38:25 +0000
Message-Id: <20211117153842.302159-22-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117153842.302159-1-alexandru.elisei@arm.com>
References: <20211117153842.302159-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: Sudeep Holla <sudeep.holla@arm.com>
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

From: Sudeep Holla <sudeep.holla@arm.com>

Add KVM_ARM_VCPU_SPE_CTRL(KVM_ARM_VCPU_SPE_IRQ) to allow the user to set
the interrupt number for the buffer management interrupt.

[ Alexandru E: Split from "KVM: arm64: Add a new VCPU device control group
               for SPE" ]

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/devices/vcpu.rst | 19 ++++++
 arch/arm64/include/asm/kvm_host.h       |  2 +
 arch/arm64/include/asm/kvm_spe.h        | 10 +++
 arch/arm64/include/uapi/asm/kvm.h       |  1 +
 arch/arm64/kvm/spe.c                    | 86 +++++++++++++++++++++++++
 5 files changed, 118 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index c200545d4950..a27b149c3b8b 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -236,3 +236,22 @@ From the destination VMM process:
 ===============================
 
 :Architectures: ARM64
+
+5.1 ATTRIBUTE: KVM_ARM_VCPU_SPE_IRQ
+-----------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for the Profiling Buffer
+             management interrupt number as a pointer to an int
+
+Returns:
+
+	 =======  ======================================================
+	 -EBUSY   Interrupt number already set for this VCPU
+	 -EFAULT  Error accessing the buffer management interrupt number
+	 -EINVAL  Invalid interrupt number
+	 -ENXIO   SPE not supported or not properly configured
+	 =======  ======================================================
+
+Specifies the Profiling Buffer management interrupt number. The interrupt number
+must be a PPI and the interrupt number must be the same for each VCPU. SPE
+emulation requires an in-kernel vGIC implementation.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 96ce98f6135d..8c6e6eef0ae9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -26,6 +26,7 @@
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_spe.h>
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -357,6 +358,7 @@ struct kvm_vcpu_arch {
 	struct vgic_cpu vgic_cpu;
 	struct arch_timer_cpu timer_cpu;
 	struct kvm_pmu pmu;
+	struct kvm_vcpu_spe spe;
 
 	/*
 	 * Anything that is not used directly from assembly code goes
diff --git a/arch/arm64/include/asm/kvm_spe.h b/arch/arm64/include/asm/kvm_spe.h
index 6443f9b66e4c..a5484953d06f 100644
--- a/arch/arm64/include/asm/kvm_spe.h
+++ b/arch/arm64/include/asm/kvm_spe.h
@@ -6,6 +6,8 @@
 #ifndef __ARM64_KVM_SPE_H__
 #define __ARM64_KVM_SPE_H__
 
+#include <linux/kvm.h>
+
 #ifdef CONFIG_KVM_ARM_SPE
 DECLARE_STATIC_KEY_FALSE(kvm_spe_available);
 
@@ -14,6 +16,11 @@ static __always_inline bool kvm_supports_spe(void)
 	return static_branch_likely(&kvm_spe_available);
 }
 
+struct kvm_vcpu_spe {
+	bool initialized;	/* SPE initialized for the VCPU */
+	int irq_num;		/* Buffer management interrut number */
+};
+
 int kvm_spe_vcpu_enable_spe(struct kvm_vcpu *vcpu);
 
 int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
@@ -22,6 +29,9 @@ int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr);
 #else
 #define kvm_supports_spe()	(false)
 
+struct kvm_vcpu_spe {
+};
+
 static inline int kvm_spe_vcpu_enable_spe(struct kvm_vcpu *vcpu)
 {
 	return 0;
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 7159a1e23da2..c55d94a1a8f5 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -369,6 +369,7 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 #define KVM_ARM_VCPU_SPE_CTRL		3
+#define   KVM_ARM_VCPU_SPE_IRQ		0
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/arch/arm64/kvm/spe.c b/arch/arm64/kvm/spe.c
index e3f82be398a6..7520d7925460 100644
--- a/arch/arm64/kvm/spe.c
+++ b/arch/arm64/kvm/spe.c
@@ -45,17 +45,103 @@ int kvm_spe_vcpu_enable_spe(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static bool kvm_vcpu_supports_spe(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_supports_spe())
+		return false;
+
+	if (!kvm_vcpu_has_spe(vcpu))
+		return false;
+
+	if (!irqchip_in_kernel(vcpu->kvm))
+		return false;
+
+	return true;
+}
+
+static bool kvm_spe_irq_is_valid(struct kvm *kvm, int irq)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	if (!irq_is_ppi(irq))
+		return -EINVAL;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!vcpu->arch.spe.irq_num)
+			continue;
+
+		if (vcpu->arch.spe.irq_num != irq)
+			return false;
+	}
+
+	return true;
+}
+
 int kvm_spe_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	if (vcpu->arch.spe.initialized)
+		return -EBUSY;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (vcpu->arch.spe.irq_num)
+			return -EBUSY;
+
+		if (get_user(irq, uaddr))
+			return -EFAULT;
+
+		if (!kvm_spe_irq_is_valid(vcpu->kvm, irq))
+			return -EINVAL;
+
+		kvm_debug("Set KVM_ARM_VCPU_SPE_IRQ: %d\n", irq);
+		vcpu->arch.spe.irq_num = irq;
+		return 0;
+	}
+	}
+
 	return -ENXIO;
 }
 
 int kvm_spe_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	switch (attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		int irq;
+
+		if (!vcpu->arch.spe.irq_num)
+			return -ENXIO;
+
+		irq = vcpu->arch.spe.irq_num;
+		if (put_user(irq, uaddr))
+			return -EFAULT;
+
+		return 0;
+	}
+	}
+
 	return -ENXIO;
 }
 
 int kvm_spe_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 {
+	if (!kvm_vcpu_supports_spe(vcpu))
+		return -ENXIO;
+
+	switch(attr->attr) {
+	case KVM_ARM_VCPU_SPE_IRQ:
+		return 0;
+	}
+
 	return -ENXIO;
 }
-- 
2.33.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
