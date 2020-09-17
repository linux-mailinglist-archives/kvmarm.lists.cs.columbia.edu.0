Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82926D530
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 09:51:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1255D4B87C;
	Thu, 17 Sep 2020 03:51:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpzGd0Tol-tj; Thu, 17 Sep 2020 03:51:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 007E44B861;
	Thu, 17 Sep 2020 03:51:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3E494B71D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 23:01:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id grl2gD-en66n for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Sep 2020 23:01:10 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B5EF04B720
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Sep 2020 23:01:10 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D8323A70BE5E9F12EC37;
 Thu, 17 Sep 2020 11:01:06 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:01:00 +0800
From: Ying Fang <fangying1@huawei.com>
To: <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 2/2] kvm/arm: Add mp_affinity for arm vcpu
Date: Thu, 17 Sep 2020 11:00:53 +0800
Message-ID: <20200917030053.1747-3-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200917030053.1747-1-fangying1@huawei.com>
References: <20200917030053.1747-1-fangying1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 17 Sep 2020 03:51:33 -0400
Cc: zhang.zhanghailiang@huawei.com, maz@kernel.org, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>
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

Allow userspace to set MPIDR using vcpu ioctl KVM_ARM_SET_MP_AFFINITY,
so that we can support cpu topology for arm.

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 arch/arm64/include/asm/kvm_host.h |  5 +++++
 arch/arm64/kvm/arm.c              |  8 ++++++++
 arch/arm64/kvm/reset.c            | 11 +++++++++++
 arch/arm64/kvm/sys_regs.c         | 30 +++++++++++++++++++-----------
 include/uapi/linux/kvm.h          |  2 ++
 5 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e52c927aade5..7adc351ee70a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -372,6 +372,9 @@ struct kvm_vcpu_arch {
 		u64 last_steal;
 		gpa_t base;
 	} steal;
+
+	/* vCPU MP Affinity */
+	u64 mp_affinity;
 };
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
@@ -685,6 +688,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type);
 int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 
+int kvm_arm_vcpu_set_mp_affinity(struct kvm_vcpu *vcpu, uint64_t mpidr);
+
 #define kvm_arm_vcpu_sve_finalized(vcpu) \
 	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 913c8da539b3..5f1fa625dc11 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1178,6 +1178,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_SET_MP_AFFINITY: {
+		u64 mpidr;
+
+		if (get_user(mpidr, (const unsigned int __user *)argp))
+			return -EFAULT;
+
+		return kvm_arm_vcpu_set_mp_affinity(vcpu, mpidr);
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index ee33875c5c2a..4918c967b0c9 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -188,6 +188,17 @@ int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
 	return -EINVAL;
 }
 
+int kvm_arm_vcpu_set_mp_affinity(struct kvm_vcpu *vcpu, uint64_t mpidr)
+{
+	if (!(mpidr & (1ULL << 31))) {
+		pr_warn("invalid mp_affinity format\n");
+		return -EINVAL;
+	}
+
+	vcpu->arch.mp_affinity = mpidr;
+	return 0;
+}
+
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_has_sve(vcpu) && !kvm_arm_vcpu_sve_finalized(vcpu))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 077293b5115f..e76f483475ad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -646,17 +646,25 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	u64 mpidr;
 
-	/*
-	 * Map the vcpu_id into the first three affinity level fields of
-	 * the MPIDR. We limit the number of VCPUs in level 0 due to a
-	 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
-	 * of the GICv3 to be able to address each CPU directly when
-	 * sending IPIs.
-	 */
-	mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
-	mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
-	mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
-	vcpu_write_sys_reg(vcpu, (1ULL << 31) | mpidr, MPIDR_EL1);
+	if (vcpu->arch.mp_affinity) {
+		/* If mp_affinity is set by userspace, it means an customized cpu
+		 * topology is defined. Let it be MPIDR of the vcpu
+		 */
+		mpidr = vcpu->arch.mp_affinity;
+	} else {
+		/*
+		 * Map the vcpu_id into the first three affinity level fields of
+		 * the MPIDR. We limit the number of VCPUs in level 0 due to a
+		 * limitation to 16 CPUs in that level in the ICC_SGIxR registers
+		 * of the GICv3 to be able to address each CPU directly when
+		 * sending IPIs.
+		 */
+		mpidr = (vcpu->vcpu_id & 0x0f) << MPIDR_LEVEL_SHIFT(0);
+		mpidr |= ((vcpu->vcpu_id >> 4) & 0xff) << MPIDR_LEVEL_SHIFT(1);
+		mpidr |= ((vcpu->vcpu_id >> 12) & 0xff) << MPIDR_LEVEL_SHIFT(2);
+		mpidr |= (1ULL << 31);
+	}
+	vcpu_write_sys_reg(vcpu, mpidr, MPIDR_EL1);
 }
 
 static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c4874905cd9c..ae45876a689d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1475,6 +1475,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 /* Memory Encryption Commands */
 #define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+/* Available with KVM_CAP_ARM_MP_AFFINITY */
+#define KVM_ARM_SET_MP_AFFINITY    _IOWR(KVMIO, 0xbb, unsigned long)
 
 struct kvm_enc_region {
 	__u64 addr;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
