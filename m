Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36334EB26
	for <lists+kvmarm@lfdr.de>; Tue, 30 Mar 2021 16:54:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC7594B30A;
	Tue, 30 Mar 2021 10:54:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DbRleJCcsVwM; Tue, 30 Mar 2021 10:54:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E3DD4B2F8;
	Tue, 30 Mar 2021 10:54:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 044DB4B1B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 10:54:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGuPNeiwY59k for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Mar 2021 10:54:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8C32B4B265
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Mar 2021 10:54:47 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D765619C8;
 Tue, 30 Mar 2021 14:54:46 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lRFlU-004hoo-Hc; Tue, 30 Mar 2021 15:54:44 +0100
From: Marc Zyngier <maz@kernel.org>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, seanjc@google.com,
 richardcochran@gmail.com, Mark.Rutland@arm.com, will@kernel.org,
 suzuki.poulose@arm.com, Andre.Przywara@arm.com, steven.price@arm.com,
 lorenzo.pieralisi@arm.com, sudeep.holla@arm.com
Subject: [PATCH v19 1/7] arm/arm64: Probe for the presence of KVM hypervisor
Date: Tue, 30 Mar 2021 15:54:24 +0100
Message-Id: <20210330145430.996981-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330145430.996981-1-maz@kernel.org>
References: <20210330145430.996981-1-maz@kernel.org>
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

From: Will Deacon <will@kernel.org>

Although the SMCCC specification provides some limited functionality for
describing the presence of hypervisor and firmware services, this is
generally applicable only to functions designated as "Arm Architecture
Service Functions" and no portable discovery mechanism is provided for
standard hypervisor services, despite having a designated range of
function identifiers reserved by the specification.

In an attempt to avoid the need for additional firmware changes every
time a new function is added, introduce a UID to identify the service
provider as being compatible with KVM. Once this has been established,
additional services can be discovered via a feature bitmap.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
[maz: move code to its own file, plug it into PSCI]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201209060932.212364-2-jianyong.wu@arm.com
---
 arch/arm/include/asm/hypervisor.h   |  3 ++
 arch/arm64/include/asm/hypervisor.h |  3 ++
 drivers/firmware/psci/psci.c        |  2 ++
 drivers/firmware/smccc/Makefile     |  2 +-
 drivers/firmware/smccc/kvm_guest.c  | 50 +++++++++++++++++++++++++++++
 drivers/firmware/smccc/smccc.c      |  1 +
 include/linux/arm-smccc.h           | 25 +++++++++++++++
 7 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/smccc/kvm_guest.c

diff --git a/arch/arm/include/asm/hypervisor.h b/arch/arm/include/asm/hypervisor.h
index df8524365637..bd61502b9715 100644
--- a/arch/arm/include/asm/hypervisor.h
+++ b/arch/arm/include/asm/hypervisor.h
@@ -4,4 +4,7 @@
 
 #include <asm/xen/hypervisor.h>
 
+void kvm_init_hyp_services(void);
+bool kvm_arm_hyp_service_available(u32 func_id);
+
 #endif
diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
index f9cc1d021791..0ae427f352c8 100644
--- a/arch/arm64/include/asm/hypervisor.h
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -4,4 +4,7 @@
 
 #include <asm/xen/hypervisor.h>
 
+void kvm_init_hyp_services(void);
+bool kvm_arm_hyp_service_available(u32 func_id);
+
 #endif
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..69e296f02902 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -23,6 +23,7 @@
 
 #include <asm/cpuidle.h>
 #include <asm/cputype.h>
+#include <asm/hypervisor.h>
 #include <asm/system_misc.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
@@ -498,6 +499,7 @@ static int __init psci_probe(void)
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
 		psci_init_system_reset2();
+		kvm_init_hyp_services();
 	}
 
 	return 0;
diff --git a/drivers/firmware/smccc/Makefile b/drivers/firmware/smccc/Makefile
index 72ab84042832..40d19144a860 100644
--- a/drivers/firmware/smccc/Makefile
+++ b/drivers/firmware/smccc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o
+obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o kvm_guest.o
 obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
new file mode 100644
index 000000000000..08836f2f39ee
--- /dev/null
+++ b/drivers/firmware/smccc/kvm_guest.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "smccc: KVM: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/hypervisor.h>
+
+static DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS) __ro_after_init = { };
+
+void __init kvm_init_hyp_services(void)
+{
+	struct arm_smccc_res res;
+	u32 val[4];
+
+	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
+		return;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+	if (res.a0 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0 ||
+	    res.a1 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1 ||
+	    res.a2 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 ||
+	    res.a3 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3)
+		return;
+
+	memset(&res, 0, sizeof(res));
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID, &res);
+
+	val[0] = lower_32_bits(res.a0);
+	val[1] = lower_32_bits(res.a1);
+	val[2] = lower_32_bits(res.a2);
+	val[3] = lower_32_bits(res.a3);
+
+	bitmap_from_arr32(__kvm_arm_hyp_services, val, ARM_SMCCC_KVM_NUM_FUNCS);
+
+	pr_info("hypervisor services detected (0x%08lx 0x%08lx 0x%08lx 0x%08lx)\n",
+		 res.a3, res.a2, res.a1, res.a0);
+}
+
+bool kvm_arm_hyp_service_available(u32 func_id)
+{
+	if (func_id >= ARM_SMCCC_KVM_NUM_FUNCS)
+		return -EINVAL;
+
+	return test_bit(func_id, __kvm_arm_hyp_services);
+}
+EXPORT_SYMBOL_GPL(kvm_arm_hyp_service_available);
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index d52bfc5ed5e4..028f81d702cc 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -8,6 +8,7 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/arm-smccc.h>
+#include <linux/kernel.h>
 #include <asm/archrandom.h>
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 62c54234576c..1a27bd9493fe 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -55,6 +55,8 @@
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
 #define ARM_SMCCC_OWNER_TRUSTED_OS_END	63
 
+#define ARM_SMCCC_FUNC_QUERY_CALL_UID  0xff01
+
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
@@ -87,6 +89,29 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x7fff)
 
+#define ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_FUNC_QUERY_CALL_UID)
+
+/* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0	0xb66fb428U
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1	0xe911c52eU
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2	0x564bcaa9U
+#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3	0x743a004dU
+
+/* KVM "vendor specific" services */
+#define ARM_SMCCC_KVM_FUNC_FEATURES		0
+#define ARM_SMCCC_KVM_FUNC_FEATURES_2		127
+#define ARM_SMCCC_KVM_NUM_FUNCS			128
+
+#define ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   ARM_SMCCC_OWNER_VENDOR_HYP,			\
+			   ARM_SMCCC_KVM_FUNC_FEATURES)
+
 #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
 
 /* Paravirtualised time calls (defined by ARM DEN0057A) */
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
