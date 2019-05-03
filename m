Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1388412E15
	for <lists+kvmarm@lfdr.de>; Fri,  3 May 2019 14:46:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B482F4A546;
	Fri,  3 May 2019 08:46:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y84otHCK-n-x; Fri,  3 May 2019 08:46:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA6744A55F;
	Fri,  3 May 2019 08:46:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3ED294A51F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 May 2019 08:46:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5fHNhROGaIDG for <kvmarm@lists.cs.columbia.edu>;
 Fri,  3 May 2019 08:46:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 944784A536
 for <kvmarm@lists.cs.columbia.edu>; Fri,  3 May 2019 08:46:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D5B15AD;
 Fri,  3 May 2019 05:46:00 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0EA13F220;
 Fri,  3 May 2019 05:45:56 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 22/56] KVM: arm/arm64: Add KVM_ARM_VCPU_FINALIZE ioctl
Date: Fri,  3 May 2019 13:43:53 +0100
Message-Id: <20190503124427.190206-23-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503124427.190206-1-marc.zyngier@arm.com>
References: <20190503124427.190206-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 "zhang . lei" <zhang.lei@jp.fujitsu.com>, Julien Grall <julien.grall@arm.com>,
 kvmarm@lists.cs.columbia.edu, Amit Daniel Kachhap <amit.kachhap@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

From: Dave Martin <Dave.Martin@arm.com>

Some aspects of vcpu configuration may be too complex to be
completed inside KVM_ARM_VCPU_INIT.  Thus, there may be a
requirement for userspace to do some additional configuration
before various other ioctls will work in a consistent way.

In particular this will be the case for SVE, where userspace will
need to negotiate the set of vector lengths to be made available to
the guest before the vcpu becomes fully usable.

In order to provide an explicit way for userspace to confirm that
it has finished setting up a particular vcpu feature, this patch
adds a new ioctl KVM_ARM_VCPU_FINALIZE.

When userspace has opted into a feature that requires finalization,
typically by means of a feature flag passed to KVM_ARM_VCPU_INIT, a
matching call to KVM_ARM_VCPU_FINALIZE is now required before
KVM_RUN or KVM_GET_REG_LIST is allowed.  Individual features may
impose additional restrictions where appropriate.

No existing vcpu features are affected by this, so current
userspace implementations will continue to work exactly as before,
with no need to issue KVM_ARM_VCPU_FINALIZE.

As implemented in this patch, KVM_ARM_VCPU_FINALIZE is currently a
placeholder: no finalizable features exist yet, so ioctl is not
required and will always yield EINVAL.  Subsequent patches will add
the finalization logic to make use of this ioctl for SVE.

No functional change for existing userspace.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: zhang.lei <zhang.lei@jp.fujitsu.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   |  4 ++++
 arch/arm64/include/asm/kvm_host.h |  4 ++++
 include/uapi/linux/kvm.h          |  3 +++
 virt/kvm/arm/arm.c                | 18 ++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index a49ee01242ff..e80cfc18412b 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -19,6 +19,7 @@
 #ifndef __ARM_KVM_HOST_H__
 #define __ARM_KVM_HOST_H__
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/kvm_types.h>
 #include <asm/cputype.h>
@@ -411,4 +412,7 @@ static inline int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 	return 0;
 }
 
+#define kvm_arm_vcpu_finalize(vcpu, what) (-EINVAL)
+#define kvm_arm_vcpu_is_finalized(vcpu) true
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3e8950942591..98658f7dad68 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -23,6 +23,7 @@
 #define __ARM64_KVM_HOST_H__
 
 #include <linux/bitmap.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/jump_label.h>
 #include <linux/kvm_types.h>
@@ -625,4 +626,7 @@ void kvm_arch_free_vm(struct kvm *kvm);
 
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
 
+#define kvm_arm_vcpu_finalize(vcpu, what) (-EINVAL)
+#define kvm_arm_vcpu_is_finalized(vcpu) true
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dc77a5a3648d..c3b8e7a31315 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1441,6 +1441,9 @@ struct kvm_enc_region {
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
 
+/* Available with KVM_CAP_ARM_SVE */
+#define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index c69e1370a5dc..9edbf0f676e7 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -545,6 +545,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (likely(vcpu->arch.has_run_once))
 		return 0;
 
+	if (!kvm_arm_vcpu_is_finalized(vcpu))
+		return -EPERM;
+
 	vcpu->arch.has_run_once = true;
 
 	if (likely(irqchip_in_kernel(kvm))) {
@@ -1116,6 +1119,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (unlikely(!kvm_vcpu_initialized(vcpu)))
 			break;
 
+		r = -EPERM;
+		if (!kvm_arm_vcpu_is_finalized(vcpu))
+			break;
+
 		r = -EFAULT;
 		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
 			break;
@@ -1169,6 +1176,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_set_events(vcpu, &events);
 	}
+	case KVM_ARM_VCPU_FINALIZE: {
+		int what;
+
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
+		if (get_user(what, (const int __user *)argp))
+			return -EFAULT;
+
+		return kvm_arm_vcpu_finalize(vcpu, what);
+	}
 	default:
 		r = -EINVAL;
 	}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
