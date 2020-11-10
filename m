Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D946F2AD7AB
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 14:36:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4DD4B9AF;
	Tue, 10 Nov 2020 08:36:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B6prSWKBPOL5; Tue, 10 Nov 2020 08:36:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C4F14B9AC;
	Tue, 10 Nov 2020 08:36:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 990034B767
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id deqb8czJ+knD for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 08:36:31 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 77E824B985
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 08:36:31 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C2D2207D3;
 Tue, 10 Nov 2020 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605015390;
 bh=Q2FlY7BpvXcPTtmcmTGIhO77yAmIF8KMzHMNzz1Yytc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k5AvbH5Zu4GW3Z4wi4oIRrBT8/+FHAWKZuORpG7CSUbXc/W/BIB6l5e5mlx88I96G
 z31q+p0MHNa4x7jqGYSdhKvWlUFvhmQTWL0fI9OeLGZw0o2Y/rIgbAT2JAfzYbtupp
 0/9pdRwjmXSV+PYVyIUYS0NrDuHn9gxtkk9Uztao=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcToy-009SZy-Jh; Tue, 10 Nov 2020 13:36:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/9] KVM: arm64: Move AArch32 exceptions over to AArch64
 sysregs
Date: Tue, 10 Nov 2020 13:36:12 +0000
Message-Id: <20201110133619.451157-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110133619.451157-1-maz@kernel.org>
References: <20201110133619.451157-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

The use of the AArch32-specific accessors have always been a bit
annoying on 64bit, and it is time for a change.

Let's move the AArch32 exception injection over to the AArch64 encoding,
which requires us to split the two halves of FAR_EL1 into DFAR and IFAR.
This enables us to drop the preempt_disable() games on VHE, and to kill
the last user of the vcpu_cp15() macro.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/inject_fault.c     | 62 ++++++++++---------------------
 2 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 803cb2427b54..c905c3fcaaa0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -562,7 +562,6 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 #define CPx_BIAS		IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
 
 #define vcpu_cp14(v,r)		((v)->arch.ctxt.copro[(r) ^ CPx_BIAS])
-#define vcpu_cp15(v,r)		((v)->arch.ctxt.copro[(r) ^ CPx_BIAS])
 
 struct kvm_vm_stat {
 	ulong remote_tlb_flush;
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index e2a2e48ca371..b47df73e98d7 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -69,26 +69,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 #define DFSR_FSC_EXTABT_LPAE	0x10
 #define DFSR_FSC_EXTABT_nLPAE	0x08
 #define DFSR_LPAE		BIT(9)
-
-static bool pre_fault_synchronize(struct kvm_vcpu *vcpu)
-{
-	preempt_disable();
-	if (vcpu->arch.sysregs_loaded_on_cpu) {
-		kvm_arch_vcpu_put(vcpu);
-		return true;
-	}
-
-	preempt_enable();
-	return false;
-}
-
-static void post_fault_synchronize(struct kvm_vcpu *vcpu, bool loaded)
-{
-	if (loaded) {
-		kvm_arch_vcpu_load(vcpu, smp_processor_id());
-		preempt_enable();
-	}
-}
+#define TTBCR_EAE		BIT(31)
 
 static void inject_undef32(struct kvm_vcpu *vcpu)
 {
@@ -100,39 +81,36 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
  * Modelled after TakeDataAbortException() and TakePrefetchAbortException
  * pseudocode.
  */
-static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
-			 unsigned long addr)
+static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 {
-	u32 *far, *fsr;
-	bool is_lpae;
-	bool loaded;
+	u64 far;
+	u32 fsr;
+
+	/* Give the guest an IMPLEMENTATION DEFINED exception */
+	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
+		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
+	} else {
+		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
+		fsr = DFSR_FSC_EXTABT_nLPAE;
+	}
 
-	loaded = pre_fault_synchronize(vcpu);
+	far = vcpu_read_sys_reg(vcpu, FAR_EL1);
 
 	if (is_pabt) {
 		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IABT |
 				     KVM_ARM64_PENDING_EXCEPTION);
-		far = &vcpu_cp15(vcpu, c6_IFAR);
-		fsr = &vcpu_cp15(vcpu, c5_IFSR);
+		far &= GENMASK(31, 0);
+		far |= (u64)addr << 32;
+		vcpu_write_sys_reg(vcpu, fsr, IFSR32_EL2);
 	} else { /* !iabt */
 		vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_DABT |
 				     KVM_ARM64_PENDING_EXCEPTION);
-		far = &vcpu_cp15(vcpu, c6_DFAR);
-		fsr = &vcpu_cp15(vcpu, c5_DFSR);
-	}
-
-	*far = addr;
-
-	/* Give the guest an IMPLEMENTATION DEFINED exception */
-	is_lpae = (vcpu_cp15(vcpu, c2_TTBCR) >> 31);
-	if (is_lpae) {
-		*fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
-	} else {
-		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
-		*fsr = DFSR_FSC_EXTABT_nLPAE;
+		far &= GENMASK(63, 32);
+		far |= addr;
+		vcpu_write_sys_reg(vcpu, fsr, ESR_EL1);
 	}
 
-	post_fault_synchronize(vcpu, loaded);
+	vcpu_write_sys_reg(vcpu, far, FAR_EL1);
 }
 
 /**
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
