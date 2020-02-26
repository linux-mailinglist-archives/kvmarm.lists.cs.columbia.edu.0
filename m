Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FB16F3E0
	for <lists+kvmarm@lfdr.de>; Wed, 26 Feb 2020 00:52:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71D524AFB1;
	Tue, 25 Feb 2020 18:52:50 -0500 (EST)
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
	with ESMTP id 194qKQ9EogeA; Tue, 25 Feb 2020 18:52:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C2224B011;
	Tue, 25 Feb 2020 18:52:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 083CE4AFBB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Feb 2020 18:52:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9zdTf2KxP05 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Feb 2020 18:52:44 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A83B24AFBD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Feb 2020 18:52:44 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEE1224650;
 Tue, 25 Feb 2020 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582674764;
 bh=iBBwlWbCwGpC+/ma5xl8Yn/0zKLQQaEp1vrpjPaXUgo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CIKtyFFpCUUTmGxj6eexXZVhXiKctFHZIDmi6flhC15MDHTAi8wQjDtPYuzler6sb
 sgn557K2KkP39XRhmGh+LMt/GeyNXdSxUjhakF72vX1/aVxnUmmDW1sGD6BpI5lxix
 Hzdd/jz3S+p50ktFUqZA1zNPsOwmMPHwC/DEpCwY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j6k0I-007xuY-1g; Tue, 25 Feb 2020 23:52:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] kvm: arm/arm64: Fold VHE entry/exit work into
 kvm_vcpu_run_vhe()
Date: Tue, 25 Feb 2020 23:52:20 +0000
Message-Id: <20200225235223.12839-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225235223.12839-1-maz@kernel.org>
References: <20200225235223.12839-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, james.morse@arm.com, jcline@redhat.com,
 mark.rutland@arm.com, will@kernel.org, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

From: Mark Rutland <mark.rutland@arm.com>

With VHE, running a vCPU always requires the sequence:

1. kvm_arm_vhe_guest_enter();
2. kvm_vcpu_run_vhe();
3. kvm_arm_vhe_guest_exit()

... and as we invoke this from the shared arm/arm64 KVM code, 32-bit arm
has to provide stubs for all three functions.

To simplify the common code, and make it easier to make further
modifications to the arm64-specific portions in the near future, let's
fold kvm_arm_vhe_guest_enter() and kvm_arm_vhe_guest_exit() into
kvm_vcpu_run_vhe().

The 32-bit stubs for kvm_arm_vhe_guest_enter() and
kvm_arm_vhe_guest_exit() are removed, as they are no longer used. The
32-bit stub for kvm_vcpu_run_vhe() is left as-is.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200210114757.2889-1-mark.rutland@arm.com
---
 arch/arm/include/asm/kvm_host.h   |  3 ---
 arch/arm64/include/asm/kvm_host.h | 32 -------------------------
 arch/arm64/kvm/hyp/switch.c       | 39 +++++++++++++++++++++++++++++--
 virt/kvm/arm/arm.c                |  2 --
 4 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index bd2233805d99..cbd26ae95e7e 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -394,9 +394,6 @@ static inline void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
 
-static inline void kvm_arm_vhe_guest_enter(void) {}
-static inline void kvm_arm_vhe_guest_exit(void) {}
-
 #define KVM_BP_HARDEN_UNKNOWN		-1
 #define KVM_BP_HARDEN_WA_NEEDED		0
 #define KVM_BP_HARDEN_NOT_REQUIRED	1
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f6a77ddab956..d740ec00ecd3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -628,38 +628,6 @@ static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
 #endif
 
-static inline void kvm_arm_vhe_guest_enter(void)
-{
-	local_daif_mask();
-
-	/*
-	 * Having IRQs masked via PMR when entering the guest means the GIC
-	 * will not signal the CPU of interrupts of lower priority, and the
-	 * only way to get out will be via guest exceptions.
-	 * Naturally, we want to avoid this.
-	 *
-	 * local_daif_mask() already sets GIC_PRIO_PSR_I_SET, we just need a
-	 * dsb to ensure the redistributor is forwards EL2 IRQs to the CPU.
-	 */
-	pmr_sync();
-}
-
-static inline void kvm_arm_vhe_guest_exit(void)
-{
-	/*
-	 * local_daif_restore() takes care to properly restore PSTATE.DAIF
-	 * and the GIC PMR if the host is using IRQ priorities.
-	 */
-	local_daif_restore(DAIF_PROCCTX_NOIRQ);
-
-	/*
-	 * When we exit from the guest we change a number of CPU configuration
-	 * parameters, such as traps.  Make sure these changes take effect
-	 * before running the host or additional guests.
-	 */
-	isb();
-}
-
 #define KVM_BP_HARDEN_UNKNOWN		-1
 #define KVM_BP_HARDEN_WA_NEEDED		0
 #define KVM_BP_HARDEN_NOT_REQUIRED	1
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 72fbbd86eb5e..457067706b75 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -617,7 +617,7 @@ static void __hyp_text __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
 }
 
 /* Switch to the guest for VHE systems running in EL2 */
-int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
+static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_cpu_context *guest_ctxt;
@@ -670,7 +670,42 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	return exit_code;
 }
-NOKPROBE_SYMBOL(kvm_vcpu_run_vhe);
+NOKPROBE_SYMBOL(__kvm_vcpu_run_vhe);
+
+int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	local_daif_mask();
+
+	/*
+	 * Having IRQs masked via PMR when entering the guest means the GIC
+	 * will not signal the CPU of interrupts of lower priority, and the
+	 * only way to get out will be via guest exceptions.
+	 * Naturally, we want to avoid this.
+	 *
+	 * local_daif_mask() already sets GIC_PRIO_PSR_I_SET, we just need a
+	 * dsb to ensure the redistributor is forwards EL2 IRQs to the CPU.
+	 */
+	pmr_sync();
+
+	ret = __kvm_vcpu_run_vhe(vcpu);
+
+	/*
+	 * local_daif_restore() takes care to properly restore PSTATE.DAIF
+	 * and the GIC PMR if the host is using IRQ priorities.
+	 */
+	local_daif_restore(DAIF_PROCCTX_NOIRQ);
+
+	/*
+	 * When we exit from the guest we change a number of CPU configuration
+	 * parameters, such as traps.  Make sure these changes take effect
+	 * before running the host or additional guests.
+	 */
+	isb();
+
+	return ret;
+}
 
 /* Switch to the guest for legacy non-VHE systems */
 int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index efda376ab3c5..560d6f258297 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -797,9 +797,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		guest_enter_irqoff();
 
 		if (has_vhe()) {
-			kvm_arm_vhe_guest_enter();
 			ret = kvm_vcpu_run_vhe(vcpu);
-			kvm_arm_vhe_guest_exit();
 		} else {
 			ret = kvm_call_hyp_ret(__kvm_vcpu_run_nvhe, vcpu);
 		}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
