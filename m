Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32C3CA25A
	for <lists+kvmarm@lfdr.de>; Thu, 15 Jul 2021 18:32:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBFA04B093;
	Thu, 15 Jul 2021 12:32:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzvoP+HJ19rQ; Thu, 15 Jul 2021 12:32:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B25984B0B4;
	Thu, 15 Jul 2021 12:32:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 259EC4B09A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:32:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GOZxbZIZeDlo for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Jul 2021 12:32:19 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1329A4B08A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 12:32:19 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA98A613F6;
 Thu, 15 Jul 2021 16:32:16 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m44HX-00DYjr-3s; Thu, 15 Jul 2021 17:32:15 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/16] KVM: arm64: Generalise VM features into a set of flags
Date: Thu, 15 Jul 2021 17:31:44 +0100
Message-Id: <20210715163159.1480168-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715163159.1480168-1-maz@kernel.org>
References: <20210715163159.1480168-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org, qperret@google.com,
 dbrazdil@google.com, vatsa@codeaurora.org, sdonthineni@nvidia.com,
 james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
 Shanker R Donthineni <sdonthineni@nvidia.com>, will@kernel.org
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

We currently deal with a set of booleans for VM features,
while they could be better represented as set of flags
contained in an unsigned long, similarily to what we are
doing on the CPU side.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 12 +++++++-----
 arch/arm64/kvm/arm.c              |  5 +++--
 arch/arm64/kvm/mmio.c             |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 41911585ae0c..4add6c27251f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -122,7 +122,10 @@ struct kvm_arch {
 	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
 	 * supported.
 	 */
-	bool return_nisv_io_abort_to_user;
+#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
+	/* Memory Tagging Extension enabled for the guest */
+#define KVM_ARCH_FLAG_MTE_ENABLED			1
+	unsigned long flags;
 
 	/*
 	 * VM-wide PMU filter, implemented as a bitmap and big enough for
@@ -133,9 +136,6 @@ struct kvm_arch {
 
 	u8 pfr0_csv2;
 	u8 pfr0_csv3;
-
-	/* Memory Tagging Extension enabled for the guest */
-	bool mte_enabled;
 };
 
 struct kvm_vcpu_fault_info {
@@ -777,7 +777,9 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_arm_vcpu_sve_finalized(vcpu) \
 	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
 
-#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
+#define kvm_has_mte(kvm)					\
+	(system_supports_mte() &&				\
+	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(test_bit(KVM_ARM_VCPU_PMU_V3, (vcpu)->arch.features))
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..97ab1512c44f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -91,13 +91,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 	switch (cap->cap) {
 	case KVM_CAP_ARM_NISV_TO_USER:
 		r = 0;
-		kvm->arch.return_nisv_io_abort_to_user = true;
+		set_bit(KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER,
+			&kvm->arch.flags);
 		break;
 	case KVM_CAP_ARM_MTE:
 		if (!system_supports_mte() || kvm->created_vcpus)
 			return -EINVAL;
 		r = 0;
-		kvm->arch.mte_enabled = true;
+		set_bit(KVM_ARCH_FLAG_MTE_ENABLED, &kvm->arch.flags);
 		break;
 	default:
 		r = -EINVAL;
diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index 3e2d8ba11a02..3dd38a151d2a 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -135,7 +135,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	 * volunteered to do so, and bail out otherwise.
 	 */
 	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
-		if (vcpu->kvm->arch.return_nisv_io_abort_to_user) {
+		if (test_bit(KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER,
+			     &vcpu->kvm->arch.flags)) {
 			run->exit_reason = KVM_EXIT_ARM_NISV;
 			run->arm_nisv.esr_iss = kvm_vcpu_dabt_iss_nisv_sanitized(vcpu);
 			run->arm_nisv.fault_ipa = fault_ipa;
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
