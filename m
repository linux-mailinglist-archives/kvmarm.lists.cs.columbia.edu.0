Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 309542629FC
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 10:18:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D78E84B5AE;
	Wed,  9 Sep 2020 04:18:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4DUfCt8lGgJ; Wed,  9 Sep 2020 04:18:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C5804B5D7;
	Wed,  9 Sep 2020 04:18:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E58684B3F1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 16:57:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fOZKYADg1Eio for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 16:57:45 -0400 (EDT)
Received: from smtp-fw-4101.amazon.com (smtp-fw-4101.amazon.com [72.21.198.25])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD75F4B3B2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 16:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1599598666; x=1631134666;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w+WDjUguH6wxTf/jOmY/ulveNsmF3SzEEfvwqGmwBIE=;
 b=VNO1LHvd6X8/8/clAbF7T0MTcXjFwa6z5F7LcL+TBAWhtwjxd0gFl9C7
 7NrHnF503i/rCS3SHTzU5G+bBR5GH2fT1tw9817gawOt7t37uDUTYuhpv
 4DU9DMyE3wpRPrzCpSX/9uHzr3/znz+p9AWdzSTZfs51ABN2CX8qqaPDc A=;
X-IronPort-AV: E=Sophos;i="5.76,407,1592870400"; d="scan'208";a="52844612"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 08 Sep 2020 20:57:45 +0000
Received: from EX13MTAUWC002.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS
 id E8903A1716; Tue,  8 Sep 2020 20:57:41 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 8 Sep 2020 20:57:41 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.160.215) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 8 Sep 2020 20:57:38 +0000
From: Alexander Graf <graf@amazon.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH v2] KVM: arm64: Allow to limit number of PMU counters
Date: Tue, 8 Sep 2020 22:57:30 +0200
Message-ID: <20200908205730.23898-1-graf@amazon.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
MIME-Version: 1.0
X-Originating-IP: [10.43.160.215]
X-ClientProxiedBy: EX13D03UWA002.ant.amazon.com (10.43.160.144) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
X-Mailman-Approved-At: Wed, 09 Sep 2020 04:18:03 -0400
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

We currently pass through the number of PMU counters that we have available
in hardware to guests. So if my host supports 10 concurrently active PMU
counters, my guest will be able to spawn 10 counters as well.

This is undesireable if we also want to use the PMU on the host for
monitoring. In that case, we want to split the PMU between guest and
host.

To help that case, let's add a PMU attr that allows us to limit the number
of PMU counters that we expose. With this patch in place, user space can
keep some counters free for host use.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

Because this patch touches the same code paths as the vPMU filtering one
and the vPMU filtering generalized a few conditions in the attr path,
I've based it on top. Please let me know if you want it independent instead.

v1 -> v2:

  - Add documentation
  - Add read support
---
 Documentation/virt/kvm/devices/vcpu.rst | 25 +++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/kvm.h       |  7 ++++---
 arch/arm64/kvm/pmu-emul.c               | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c               |  5 +++++
 include/kvm/arm_pmu.h                   |  1 +
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 203b91e93151..1a1c8d8c8b1d 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -102,6 +102,31 @@ isn't strictly speaking an event. Filtering the cycle counter is possible
 using event 0x11 (CPU_CYCLES).
 
 
+1.4 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_NUM_EVENTS
+---------------------------------------------
+
+:Parameters: in kvm_device_attr.addr the address for the limit of concurrent
+             events is a pointer to an int
+
+:Returns:
+
+	 =======  ======================================================
+	 -ENODEV: PMUv3 not supported
+	 -EBUSY:  PMUv3 already initialized
+	 -EINVAL: Too large number of events
+	 =======  ======================================================
+
+Reconfigure the limit of concurrent PMU events that the guest can monitor.
+This number is directly exposed as part of the PMCR_EL0 register.
+
+On vcpu creation, this attribute is set to the hardware limit of the current
+platform. If you need to determine the hardware limit, you can read this
+attribute before setting it.
+
+Restrictions: The default value for this property is the number of hardware
+supported events. Only values that are smaller than the hardware limit can
+be set.
+
 2. GROUP: KVM_ARM_VCPU_TIMER_CTRL
 =================================
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 7b1511d6ce44..db025c0b5a40 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -342,9 +342,10 @@ struct kvm_vcpu_events {
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
-#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
-#define   KVM_ARM_VCPU_PMU_V3_INIT	1
-#define   KVM_ARM_VCPU_PMU_V3_FILTER	2
+#define   KVM_ARM_VCPU_PMU_V3_IRQ		0
+#define   KVM_ARM_VCPU_PMU_V3_INIT		1
+#define   KVM_ARM_VCPU_PMU_V3_FILTER		2
+#define   KVM_ARM_VCPU_PMU_V3_NUM_EVENTS	3
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 0458860bade2..c7915b95fec0 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -253,6 +253,8 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
 		pmu->pmc[i].idx = i;
+
+	pmu->num_events = perf_num_counters() - 1;
 }
 
 /**
@@ -978,6 +980,25 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 
 		return 0;
 	}
+	case KVM_ARM_VCPU_PMU_V3_NUM_EVENTS: {
+		u64 mask = ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT;
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		u32 num_events;
+
+		if (get_user(num_events, uaddr))
+			return -EFAULT;
+
+		if (num_events >= perf_num_counters())
+			return -EINVAL;
+
+		vcpu->arch.pmu.num_events = num_events;
+
+		num_events <<= ARMV8_PMU_PMCR_N_SHIFT;
+		__vcpu_sys_reg(vcpu, SYS_PMCR_EL0) &= ~mask;
+		__vcpu_sys_reg(vcpu, SYS_PMCR_EL0) |= num_events;
+
+		return 0;
+	}
 	case KVM_ARM_VCPU_PMU_V3_INIT:
 		return kvm_arm_pmu_v3_init(vcpu);
 	}
@@ -1004,6 +1025,16 @@ int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		irq = vcpu->arch.pmu.irq_num;
 		return put_user(irq, uaddr);
 	}
+	case KVM_ARM_VCPU_PMU_V3_NUM_EVENTS: {
+		int __user *uaddr = (int __user *)(long)attr->addr;
+		u32 num_events;
+
+		if (!test_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features))
+			return -ENODEV;
+
+		num_events = vcpu->arch.pmu.num_events;
+		return put_user(num_events, uaddr);
+	}
 	}
 
 	return -ENXIO;
@@ -1015,6 +1046,7 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	case KVM_ARM_VCPU_PMU_V3_IRQ:
 	case KVM_ARM_VCPU_PMU_V3_INIT:
 	case KVM_ARM_VCPU_PMU_V3_FILTER:
+	case KVM_ARM_VCPU_PMU_V3_NUM_EVENTS:
 		if (kvm_arm_support_pmu_v3() &&
 		    test_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features))
 			return 0;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 20ab2a7d37ca..d51e39600bbd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -672,6 +672,11 @@ static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 	       | (ARMV8_PMU_PMCR_MASK & 0xdecafbad)) & (~ARMV8_PMU_PMCR_E);
 	if (!system_supports_32bit_el0())
 		val |= ARMV8_PMU_PMCR_LC;
+
+	/* Override number of event selectors */
+	val &= ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
+	val |= (u32)vcpu->arch.pmu.num_events << ARMV8_PMU_PMCR_N_SHIFT;
+
 	__vcpu_sys_reg(vcpu, r->reg) = val;
 }
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 98cbfe885a53..ea3fc96a37d9 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -27,6 +27,7 @@ struct kvm_pmu {
 	bool ready;
 	bool created;
 	bool irq_level;
+	u8 num_events;
 };
 
 #define kvm_arm_pmu_v3_ready(v)		((v)->arch.pmu.ready)
-- 
2.16.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
