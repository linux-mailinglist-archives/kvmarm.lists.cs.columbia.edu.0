Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCD4E430
	for <lists+kvmarm@lfdr.de>; Fri, 21 Jun 2019 11:40:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C9A334A4FD;
	Fri, 21 Jun 2019 05:40:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYiZrKPIKvIg; Fri, 21 Jun 2019 05:40:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A7614A4C1;
	Fri, 21 Jun 2019 05:40:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDB5C4A520
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 05:40:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btbQ86QIJ5OV for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Jun 2019 05:40:39 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 492794A50F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 05:40:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BE1142F;
 Fri, 21 Jun 2019 02:40:34 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B322A3F246;
 Fri, 21 Jun 2019 02:40:32 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 52/59] KVM: arm64: nv: vgic: Allow userland to set VGIC
 maintenance IRQ
Date: Fri, 21 Jun 2019 10:38:36 +0100
Message-Id: <20190621093843.220980-53-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621093843.220980-1-marc.zyngier@arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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

From: Andre Przywara <andre.przywara@arm.com>

The VGIC maintenance IRQ signals various conditions about the LRs, when
the GIC's virtualization extension is used.
So far we didn't need it, but nested virtualization needs to know about
this interrupt, so add a userland interface to setup the IRQ number.
The architecture mandates that it must be a PPI, on top of that this code
only exports a per-device option, so the PPI is the same on all VCPUs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
[added some bits of documentation]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../virtual/kvm/devices/arm-vgic-v3.txt       |  9 ++++++++
 arch/arm/include/uapi/asm/kvm.h               |  1 +
 arch/arm64/include/uapi/asm/kvm.h             |  1 +
 include/kvm/arm_vgic.h                        |  3 +++
 virt/kvm/arm/vgic/vgic-kvm-device.c           | 22 +++++++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index ff290b43c8e5..c70e8f2e0c9c 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -249,3 +249,12 @@ Groups:
   Errors:
     -EINVAL: vINTID is not multiple of 32 or
      info field is not VGIC_LEVEL_INFO_LINE_LEVEL
+
+  KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ
+    The attr field of kvm_device_attr encodes the following values:
+    bits:     | 31   ....    5 | 4  ....  0 |
+    values:   |      RES0      |   vINTID   |
+
+    The vINTID specifies which interrupt is generated when the vGIC
+    must generate a maintenance interrupt. This must be a PPI.
+
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index 4602464ebdfb..a6af45645a6d 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -233,6 +233,7 @@ struct kvm_vcpu_events {
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
 #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
+#define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ	9
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 563e2a8bae93..8e1c6ffe1b59 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -295,6 +295,7 @@ struct kvm_vcpu_events {
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
 #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
+#define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ  9
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 17d32c2797c0..95c6232663c3 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -229,6 +229,9 @@ struct vgic_dist {
 
 	int			nr_spis;
 
+	/* The GIC maintenance IRQ for nested hypervisors. */
+	u32			maint_irq;
+
 	/* base addresses in guest physical address space: */
 	gpa_t			vgic_dist_base;		/* distributor */
 	union {
diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
index 44419679f91a..dfb1d7cc66b3 100644
--- a/virt/kvm/arm/vgic/vgic-kvm-device.c
+++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
@@ -241,6 +241,12 @@ static int vgic_get_common_attr(struct kvm_device *dev,
 			     VGIC_NR_PRIVATE_IRQS, uaddr);
 		break;
 	}
+	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+
+		r = put_user(dev->kvm->arch.vgic.maint_irq, uaddr);
+		break;
+	}
 	}
 
 	return r;
@@ -627,6 +633,21 @@ static int vgic_v3_set_attr(struct kvm_device *dev,
 		reg = tmp32;
 		return vgic_v3_attr_regs_access(dev, attr, &reg, true);
 	}
+	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ: {
+		u32 __user *uaddr = (u32 __user *)(long)attr->addr;
+		u32 val;
+
+		if (get_user(val, uaddr))
+			return -EFAULT;
+
+		/* Must be a PPI. */
+		if ((val >= VGIC_NR_PRIVATE_IRQS) || (val < VGIC_NR_SGIS))
+			return -EINVAL;
+
+		dev->kvm->arch.vgic.maint_irq = val;
+
+		return 0;
+	}
 	case KVM_DEV_ARM_VGIC_GRP_CTRL: {
 		int ret;
 
@@ -712,6 +733,7 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
 	case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS:
 		return vgic_v3_has_attr_regs(dev, attr);
 	case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
+	case KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ:
 		return 0;
 	case KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO: {
 		if (((attr->attr & KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK) >>
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
