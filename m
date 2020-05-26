Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC11B1C90
	for <lists+kvmarm@lfdr.de>; Tue, 21 Apr 2020 05:24:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4E514B107;
	Mon, 20 Apr 2020 23:24:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8LNQKOaYumw; Mon, 20 Apr 2020 23:24:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D4644B137;
	Mon, 20 Apr 2020 23:24:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 06F654B113
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 23:24:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Q-0X1zSTop1 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Apr 2020 23:23:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8136C4B12F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 23:23:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E589C14;
 Mon, 20 Apr 2020 20:23:58 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com
 [10.169.40.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 830103F6CF;
 Mon, 20 Apr 2020 20:23:52 -0700 (PDT)
From: Jianyong Wu <jianyong.wu@arm.com>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 maz@kernel.org, richardcochran@gmail.com, Mark.Rutland@arm.com,
 will@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com
Subject: [RFC PATCH v11 5/9] psci: Add hypercall service for ptp_kvm.
Date: Tue, 21 Apr 2020 11:23:00 +0800
Message-Id: <20200421032304.26300-6-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421032304.26300-1-jianyong.wu@arm.com>
References: <20200421032304.26300-1-jianyong.wu@arm.com>
Cc: justin.he@arm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

ptp_kvm modules will get this service through smccc call.
The service offers real time and counter cycle of host for guest.
Also let caller determine which cycle of virtual counter or physical counter
to return.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 include/linux/arm-smccc.h | 21 +++++++++++++++++++
 virt/kvm/arm/hypercalls.c | 44 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df0f55b..747b7595d0c6 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -77,6 +77,27 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x7fff)
 
+/* PTP KVM call requests clock time from guest OS to host */
+#define ARM_SMCCC_HYP_KVM_PTP_FUNC_ID				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0)
+
+/* request for virtual counter from ptp_kvm guest */
+#define ARM_SMCCC_HYP_KVM_PTP_VIRT				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   1)
+
+/* request for physical counter from ptp_kvm guest */
+#define ARM_SMCCC_HYP_KVM_PTP_PHY				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   2)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
index 550dfa3e53cd..a5309c28d4dc 100644
--- a/virt/kvm/arm/hypercalls.c
+++ b/virt/kvm/arm/hypercalls.c
@@ -3,6 +3,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
+#include <linux/clocksource_ids.h>
 
 #include <asm/kvm_emulate.h>
 
@@ -11,8 +12,11 @@
 
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
-	u32 func_id = smccc_get_function(vcpu);
+	struct system_time_snapshot systime_snapshot;
+	long arg[4];
+	u64 cycles;
 	long val = SMCCC_RET_NOT_SUPPORTED;
+	u32 func_id = smccc_get_function(vcpu);
 	u32 feature;
 	gpa_t gpa;
 
@@ -62,6 +66,44 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		if (gpa != GPA_INVALID)
 			val = gpa;
 		break;
+	/*
+	 * This serves virtual kvm_ptp.
+	 * Four values will be passed back.
+	 * reg0 stores high 32-bit host ktime;
+	 * reg1 stores low 32-bit host ktime;
+	 * reg2 stores high 32-bit difference of host cycles and cntvoff;
+	 * reg3 stores low 32-bit difference of host cycles and cntvoff.
+	 */
+	case ARM_SMCCC_HYP_KVM_PTP_FUNC_ID:
+		/*
+		 * system time and counter value must captured in the same
+		 * time to keep consistency and precision.
+		 */
+		ktime_get_snapshot(&systime_snapshot);
+		if (systime_snapshot.cs_id != CSID_ARM_ARCH_COUNTER)
+			break;
+		arg[0] = upper_32_bits(systime_snapshot.real);
+		arg[1] = lower_32_bits(systime_snapshot.real);
+		/*
+		 * which of virtual counter or physical counter being
+		 * asked for is decided by the first argument.
+		 */
+		feature = smccc_get_arg1(vcpu);
+		switch (feature) {
+		case ARM_SMCCC_HYP_KVM_PTP_PHY:
+			cycles = systime_snapshot.cycles;
+			break;
+		case ARM_SMCCC_HYP_KVM_PTP_VIRT:
+		default:
+			cycles = systime_snapshot.cycles -
+			vcpu_vtimer(vcpu)->cntvoff;
+		}
+		arg[2] = upper_32_bits(cycles);
+		arg[3] = lower_32_bits(cycles);
+
+		smccc_set_retval(vcpu, arg[0], arg[1], arg[2], arg[3]);
+		return 1;
+
 	default:
 		return kvm_psci_call(vcpu);
 	}
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
