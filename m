Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 62E79313377
	for <lists+kvmarm@lfdr.de>; Mon,  8 Feb 2021 14:40:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13A114B615;
	Mon,  8 Feb 2021 08:40:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5H8TAcEE0hQH; Mon,  8 Feb 2021 08:40:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77C264B686;
	Mon,  8 Feb 2021 08:40:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78CF04B687
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 08:40:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NPnI0zkKDaq for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Feb 2021 08:40:44 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 22E864B676
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Feb 2021 08:40:43 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 427D264E6B;
 Mon,  8 Feb 2021 13:40:40 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l96mM-00Cn0C-GE; Mon, 08 Feb 2021 13:40:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, seanjc@google.com,
 richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
 suzuki.poulose@arm.com, Andre.Przywara@arm.com, steven.price@arm.com,
 lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Subject: [PATCH v18 6/7] KVM: arm64: Add support for the KVM PTP service
Date: Mon,  8 Feb 2021 13:40:28 +0000
Message-Id: <20210208134029.3269384-7-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208134029.3269384-1-maz@kernel.org>
References: <20210208134029.3269384-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: netdev@vger.kernel.org, yangbo.lu@nxp.com,
 john.stultz@linaro.org, tglx@linutronix.de, pbonzini@redhat.com,
 seanjc@google.com, richardcochran@gmail.com, Mark.Rutland@arm.com,
 will@kernel.org, suzuki.poulose@arm.com, Andre.Przywara@arm.com,
 steven.price@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Steve.Capper@arm.com,
 justin.he@arm.com, jianyong.wu@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

From: Jianyong Wu <jianyong.wu@arm.com>

Implement the hypervisor side of the KVM PTP interface.

The service offers wall time and cycle count from host to guest.
The caller must specify whether they want the host's view of
either the virtual or physical counter.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201209060932.212364-7-jianyong.wu@arm.com
---
 Documentation/virt/kvm/api.rst         |  9 +++++
 Documentation/virt/kvm/arm/index.rst   |  1 +
 Documentation/virt/kvm/arm/ptp_kvm.rst | 25 ++++++++++++
 arch/arm64/kvm/arm.c                   |  1 +
 arch/arm64/kvm/hypercalls.c            | 53 ++++++++++++++++++++++++++
 include/linux/arm-smccc.h              | 16 ++++++++
 include/uapi/linux/kvm.h               |  1 +
 7 files changed, 106 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/ptp_kvm.rst

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c136e254b496..7123bedd4248 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6501,3 +6501,12 @@ KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling
 KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual
 machine will switch to ring-buffer dirty page tracking and further
 KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
+
+8.30 KVM_CAP_PTP_KVM
+--------------------
+
+:Architectures: arm64
+
+This capability indicates that the KVM virtual PTP service is
+supported in the host. A VMM can check whether the service is
+available to the guest on migration.
diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
index 3e2b2aba90fc..78a9b670aafe 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -10,3 +10,4 @@ ARM
    hyp-abi
    psci
    pvtime
+   ptp_kvm
diff --git a/Documentation/virt/kvm/arm/ptp_kvm.rst b/Documentation/virt/kvm/arm/ptp_kvm.rst
new file mode 100644
index 000000000000..68cffb50d8bf
--- /dev/null
+++ b/Documentation/virt/kvm/arm/ptp_kvm.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+PTP_KVM support for arm/arm64
+=============================
+
+PTP_KVM is used for high precision time sync between host and guests.
+It relies on transferring the wall clock and counter value from the
+host to the guest using a KVM-specific hypercall.
+
+* ARM_SMCCC_HYP_KVM_PTP_FUNC_ID: 0x86000001
+
+This hypercall uses the SMC32/HVC32 calling convention:
+
+ARM_SMCCC_HYP_KVM_PTP_FUNC_ID
+    =============    ==========    ==========
+    Function ID:     (uint32)      0x86000001
+    Arguments:       (uint32)      KVM_PTP_VIRT_COUNTER(0)
+                                   KVM_PTP_PHYS_COUNTER(1)
+    Return Values:   (int32)       NOT_SUPPORTED(-1) on error, or
+                     (uint32)      Upper 32 bits of wall clock time (r0)
+                     (uint32)      Lower 32 bits of wall clock time (r1)
+                     (uint32)      Upper 32 bits of counter (r2)
+                     (uint32)      Lower 32 bits of counter (r3)
+    Endianness:                    No Restrictions.
+    =============    ==========    ==========
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04c44853b103..7ce851fc5643 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -206,6 +206,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_INJECT_EXT_DABT:
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
+	case KVM_CAP_PTP_KVM:
 		r = 1;
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index b9d8607083eb..71812879f503 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -9,6 +9,55 @@
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_psci.h>
 
+static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
+{
+	struct system_time_snapshot systime_snapshot;
+	u64 cycles = ~0UL;
+	u32 feature;
+
+	/*
+	 * system time and counter value must captured at the same
+	 * time to keep consistency and precision.
+	 */
+	ktime_get_snapshot(&systime_snapshot);
+
+	/*
+	 * This is only valid if the current clocksource is the
+	 * architected counter, as this is the only one the guest
+	 * can see.
+	 */
+	if (systime_snapshot.cs_id != CSID_ARM_ARCH_COUNTER)
+		return;
+
+	/*
+	 * The guest selects one of the two reference counters
+	 * (virtual or physical) with the first argument of the SMCCC
+	 * call. In case the identifier is not supported, error out.
+	 */
+	feature = smccc_get_arg1(vcpu);
+	switch (feature) {
+	case KVM_PTP_VIRT_COUNTER:
+		cycles = systime_snapshot.cycles - vcpu_read_sys_reg(vcpu, CNTVOFF_EL2);
+		break;
+	case KVM_PTP_PHYS_COUNTER:
+		cycles = systime_snapshot.cycles;
+		break;
+	default:
+		return;
+	}
+
+	/*
+	 * This relies on the top bit of val[0] never being set for
+	 * valid values of system time, because that is *really* far
+	 * in the future (about 292 years from 1970, and at that stage
+	 * nobody will give a damn about it).
+	 */
+	val[0] = upper_32_bits(systime_snapshot.real);
+	val[1] = lower_32_bits(systime_snapshot.real);
+	val[2] = upper_32_bits(cycles);
+	val[3] = lower_32_bits(cycles);
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -79,6 +128,10 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		break;
 	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
 		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
+		val[0] |= BIT(ARM_SMCCC_KVM_FUNC_PTP);
+		break;
+	case ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID:
+		kvm_ptp_get_time(vcpu, val);
 		break;
 	default:
 		return kvm_psci_call(vcpu);
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 74e90b65b489..96d4973d42d3 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -103,6 +103,7 @@
 
 /* KVM "vendor specific" services */
 #define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_FUNC_PTP			1
 #define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
 #define ARM_SMCCC_KVM_NUM_FUNCS			128
 
@@ -114,6 +115,21 @@
 
 #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
 
+/*
+ * ptp_kvm is a feature used for time sync between vm and host.
+ * ptp_kvm module in guest kernel will get service from host using
+ * this hypercall ID.
+ */
+#define ARM_SMCCC_VENDOR_HYP_KVM_PTP_FUNC_ID				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_PTP)
+
+/* ptp_kvm counter type ID */
+#define KVM_PTP_VIRT_COUNTER			0
+#define KVM_PTP_PHYS_COUNTER			1
+
 /* Paravirtualised time calls (defined by ARM DEN0057A) */
 #define ARM_SMCCC_HV_PV_TIME_FEATURES				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 374c67875cdb..ef75c3532759 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1058,6 +1058,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
 #define KVM_CAP_SYS_HYPERV_CPUID 191
 #define KVM_CAP_DIRTY_LOG_RING 192
+#define KVM_CAP_PTP_KVM 193
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
