Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16D200508
	for <lists+kvmarm@lfdr.de>; Fri, 19 Jun 2020 11:31:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00D024B1AD;
	Fri, 19 Jun 2020 05:31:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGQsTKvL-5Eq; Fri, 19 Jun 2020 05:31:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC06A4B1A7;
	Fri, 19 Jun 2020 05:31:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D6094B188
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 05:31:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKuWmeiRiUlh for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Jun 2020 05:31:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 731794B133
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 05:31:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2279D11B3;
 Fri, 19 Jun 2020 02:31:02 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com
 [10.169.40.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E99253F71F;
 Fri, 19 Jun 2020 02:30:55 -0700 (PDT)
From: Jianyong Wu <jianyong.wu@arm.com>
To: netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 maz@kernel.org, richardcochran@gmail.com, Mark.Rutland@arm.com,
 will@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com
Subject: [RFC PATCH v13 2/9] arm/arm64: KVM: Advertise KVM UID to guests via
 SMCCC
Date: Fri, 19 Jun 2020 17:30:26 +0800
Message-Id: <20200619093033.58344-3-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619093033.58344-1-jianyong.wu@arm.com>
References: <20200619093033.58344-1-jianyong.wu@arm.com>
Cc: justin.he@arm.com, Wei.Chen@arm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, nd@arm.com, kvmarm@lists.cs.columbia.edu,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Will Deacon <will@kernel.org>

We can advertise ourselves to guests as KVM and provide a basic features
bitmap for discoverability of future hypervisor services.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 arch/arm64/kvm/hypercalls.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 550dfa3e53cd..db6dce3d0e23 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -12,13 +12,13 @@
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
-	long val = SMCCC_RET_NOT_SUPPORTED;
+	u32 val[4] = {SMCCC_RET_NOT_SUPPORTED};
 	u32 feature;
 	gpa_t gpa;
 
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
-		val = ARM_SMCCC_VERSION_1_1;
+		val[0] = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
 		feature = smccc_get_arg1(vcpu);
@@ -28,10 +28,10 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 			case KVM_BP_HARDEN_UNKNOWN:
 				break;
 			case KVM_BP_HARDEN_WA_NEEDED:
-				val = SMCCC_RET_SUCCESS;
+				val[0] = SMCCC_RET_SUCCESS;
 				break;
 			case KVM_BP_HARDEN_NOT_REQUIRED:
-				val = SMCCC_RET_NOT_REQUIRED;
+				val[0] = SMCCC_RET_NOT_REQUIRED;
 				break;
 			}
 			break;
@@ -41,31 +41,40 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 			case KVM_SSBD_UNKNOWN:
 				break;
 			case KVM_SSBD_KERNEL:
-				val = SMCCC_RET_SUCCESS;
+				val[0] = SMCCC_RET_SUCCESS;
 				break;
 			case KVM_SSBD_FORCE_ENABLE:
 			case KVM_SSBD_MITIGATED:
-				val = SMCCC_RET_NOT_REQUIRED;
+				val[0] = SMCCC_RET_NOT_REQUIRED;
 				break;
 			}
 			break;
 		case ARM_SMCCC_HV_PV_TIME_FEATURES:
-			val = SMCCC_RET_SUCCESS;
+			val[0] = SMCCC_RET_SUCCESS;
 			break;
 		}
 		break;
 	case ARM_SMCCC_HV_PV_TIME_FEATURES:
-		val = kvm_hypercall_pv_features(vcpu);
+		val[0] = kvm_hypercall_pv_features(vcpu);
 		break;
 	case ARM_SMCCC_HV_PV_TIME_ST:
 		gpa = kvm_init_stolen_time(vcpu);
 		if (gpa != GPA_INVALID)
-			val = gpa;
+			val[0] = gpa;
+		break;
+	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
+		val[0] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0;
+		val[1] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1;
+		val[2] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2;
+		val[3] = ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
+		break;
+	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
+		val[0] = BIT(ARM_SMCCC_KVM_FUNC_FEATURES);
 		break;
 	default:
 		return kvm_psci_call(vcpu);
 	}
 
-	smccc_set_retval(vcpu, val, 0, 0, 0);
+	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
 	return 1;
 }
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
