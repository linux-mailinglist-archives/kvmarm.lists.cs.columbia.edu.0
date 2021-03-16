Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C6F3133D183
	for <lists+kvmarm@lfdr.de>; Tue, 16 Mar 2021 11:13:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76A434B1EF;
	Tue, 16 Mar 2021 06:13:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMejMQOjglWv; Tue, 16 Mar 2021 06:13:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 123864B604;
	Tue, 16 Mar 2021 06:13:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C3754B3CB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 06:13:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ceEbUSzknee for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Mar 2021 06:13:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59B9C4B1F4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 06:13:35 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 700716502B;
 Tue, 16 Mar 2021 10:13:34 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lM6hg-001uep-M0; Tue, 16 Mar 2021 10:13:32 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
Subject: [PATCH 05/10] KVM: arm64: Rework SVE host-save/guest-restore
Date: Tue, 16 Mar 2021 10:13:07 +0000
Message-Id: <20210316101312.102925-6-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316101312.102925-1-maz@kernel.org>
References: <20210316101312.102925-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, dave.martin@arm.com,
 daniel.kiss@arm.com, will@kernel.org, catalin.marinas@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 broonie@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 broonie@kernel.org, Will Deacon <will@kernel.org>, dave.martin@arm.com,
 daniel.kiss@arm.com
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

In order to keep the code readable, move the host-save/guest-restore
sequences in their own functions, with the following changes:
- the hypervisor ZCR is now set from C code
- ZCR_EL2 is always used as the EL2 accessor

This results in some minor assembler macro rework.
No functional change intended.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/fpsimdmacros.h   |  8 +++--
 arch/arm64/include/asm/kvm_hyp.h        |  2 +-
 arch/arm64/kvm/hyp/fpsimd.S             |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h | 41 +++++++++++++++----------
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e9b72d35b867..a2563992d2dc 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -232,8 +232,7 @@
 		str		w\nxtmp, [\xpfpsr, #4]
 .endm
 
-.macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp, xtmp2
-		sve_load_vq	\xvqminus1, x\nxtmp, \xtmp2
+.macro __sve_load nxbase, xpfpsr, nxtmp
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
 		_sve_ldr_p	0, \nxbase
 		_sve_wrffr	0
@@ -244,3 +243,8 @@
 		ldr		w\nxtmp, [\xpfpsr, #4]
 		msr		fpcr, x\nxtmp
 .endm
+
+.macro sve_load nxbase, xpfpsr, xvqminus1, nxtmp, xtmp2
+		sve_load_vq	\xvqminus1, x\nxtmp, \xtmp2
+		__sve_load	\nxbase, \xpfpsr, \nxtmp
+.endm
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index e8b0f7fcd86b..a3e89424ae63 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -86,7 +86,7 @@ void __debug_switch_to_host(struct kvm_vcpu *vcpu);
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr);
-void __sve_restore_state(void *sve_pffr, u32 *fpsr, unsigned int vqminus1);
+void __sve_restore_state(void *sve_pffr, u32 *fpsr);
 
 #ifndef __KVM_NVHE_HYPERVISOR__
 void activate_traps_vhe_load(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e4010d1acb79..a36d363a5981 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,7 +21,7 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	sve_load 0, x1, x2, 3, x4
+	__sve_load 0, x1, 2
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index fb68271c1a0f..d34dc220a1ce 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -196,6 +196,25 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static inline void __hyp_sve_save_host(struct kvm_vcpu *vcpu)
+{
+	struct thread_struct *thread;
+
+	thread = container_of(vcpu->arch.host_fpsimd_state, struct thread_struct,
+			      uw.fpsimd_state);
+
+	__sve_save_state(sve_pffr(thread), &vcpu->arch.host_fpsimd_state->fpsr);
+}
+
+static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
+{
+	if (read_sysreg_s(SYS_ZCR_EL2) != (vcpu_sve_vq(vcpu) - 1))
+		write_sysreg_s(vcpu_sve_vq(vcpu) - 1, SYS_ZCR_EL2);
+	__sve_restore_state(vcpu_sve_pffr(vcpu),
+			    &vcpu->arch.ctxt.fp_regs.fpsr);
+	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
+}
+
 /* Check for an FPSIMD/SVE trap and handle as appropriate */
 static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 {
@@ -251,28 +270,18 @@ static inline bool __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
 		 * In the SVE case, VHE is assumed: it is enforced by
 		 * Kconfig and kvm_arch_init().
 		 */
-		if (sve_host) {
-			struct thread_struct *thread = container_of(
-				vcpu->arch.host_fpsimd_state,
-				struct thread_struct, uw.fpsimd_state);
-
-			__sve_save_state(sve_pffr(thread),
-					 &vcpu->arch.host_fpsimd_state->fpsr);
-		} else {
+		if (sve_host)
+			__hyp_sve_save_host(vcpu);
+		else
 			__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
-		}
 
 		vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
 	}
 
-	if (sve_guest) {
-		__sve_restore_state(vcpu_sve_pffr(vcpu),
-				    &vcpu->arch.ctxt.fp_regs.fpsr,
-				    vcpu_sve_vq(vcpu) - 1);
-		write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
-	} else {
+	if (sve_guest)
+		__hyp_sve_restore_guest(vcpu);
+	else
 		__fpsimd_restore_state(&vcpu->arch.ctxt.fp_regs);
-	}
 
 	/* Skip restoring fpexc32 for AArch64 guests */
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
