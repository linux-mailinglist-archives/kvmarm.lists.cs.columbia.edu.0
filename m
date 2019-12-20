Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAC127CB2
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 15:30:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85E8D4AC65;
	Fri, 20 Dec 2019 09:30:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PQGgb1qBqzk2; Fri, 20 Dec 2019 09:30:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DB6A4ACEE;
	Fri, 20 Dec 2019 09:30:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FCEF4A3A3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 09:30:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4XiNPH-izyT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 09:30:50 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2157C4AC68
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 09:30:50 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD54106F;
 Fri, 20 Dec 2019 06:30:49 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113893F718;
 Fri, 20 Dec 2019 06:30:47 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 08/18] arm64: KVM: add support to save/restore SPE
 profiling buffer controls
Date: Fri, 20 Dec 2019 14:30:15 +0000
Message-Id: <20191220143025.33853-9-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191220143025.33853-1-andrew.murray@arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
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

From: Sudeep Holla <sudeep.holla@arm.com>

Currently since we don't support profiling using SPE in the guests,
we just save the PMSCR_EL1, flush the profiling buffers and disable
sampling. However in order to support simultaneous sampling both in
the host and guests, we need to save and reatore the complete SPE
profiling buffer controls' context.

Let's add the support for the same and keep it disabled for now.
We can enable it conditionally only if guests are allowed to use
SPE.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[ Clear PMBSR bit when saving state to prevent spurious interrupts ]
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kvm/hyp/debug-sr.c | 51 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
index 8a70a493345e..12429b212a3a 100644
--- a/arch/arm64/kvm/hyp/debug-sr.c
+++ b/arch/arm64/kvm/hyp/debug-sr.c
@@ -85,7 +85,8 @@
 	default:	write_debug(ptr[0], reg, 0);			\
 	}
 
-static void __hyp_text __debug_save_spe_nvhe(struct kvm_cpu_context *ctxt)
+static void __hyp_text
+__debug_save_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
 {
 	u64 reg;
 
@@ -102,22 +103,46 @@ static void __hyp_text __debug_save_spe_nvhe(struct kvm_cpu_context *ctxt)
 	if (reg & BIT(SYS_PMBIDR_EL1_P_SHIFT))
 		return;
 
-	/* No; is the host actually using the thing? */
-	reg = read_sysreg_s(SYS_PMBLIMITR_EL1);
-	if (!(reg & BIT(SYS_PMBLIMITR_EL1_E_SHIFT)))
+	/* Save the control register and disable data generation */
+	ctxt->sys_regs[PMSCR_EL1] = read_sysreg_el1(SYS_PMSCR);
+
+	if (!ctxt->sys_regs[PMSCR_EL1])
 		return;
 
 	/* Yes; save the control register and disable data generation */
-	ctxt->sys_regs[PMSCR_EL1] = read_sysreg_el1(SYS_PMSCR);
 	write_sysreg_el1(0, SYS_PMSCR);
 	isb();
 
 	/* Now drain all buffered data to memory */
 	psb_csync();
 	dsb(nsh);
+
+	if (!full_ctxt)
+		return;
+
+	ctxt->sys_regs[PMBLIMITR_EL1] = read_sysreg_s(SYS_PMBLIMITR_EL1);
+	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
+
+	/*
+	 * As PMBSR is conditionally restored when returning to the host we
+	 * must ensure the service bit is unset here to prevent a spurious
+	 * host SPE interrupt from being raised.
+	 */
+	ctxt->sys_regs[PMBSR_EL1] = read_sysreg_s(SYS_PMBSR_EL1);
+	write_sysreg_s(0, SYS_PMBSR_EL1);
+
+	isb();
+
+	ctxt->sys_regs[PMSICR_EL1] = read_sysreg_s(SYS_PMSICR_EL1);
+	ctxt->sys_regs[PMSIRR_EL1] = read_sysreg_s(SYS_PMSIRR_EL1);
+	ctxt->sys_regs[PMSFCR_EL1] = read_sysreg_s(SYS_PMSFCR_EL1);
+	ctxt->sys_regs[PMSEVFR_EL1] = read_sysreg_s(SYS_PMSEVFR_EL1);
+	ctxt->sys_regs[PMSLATFR_EL1] = read_sysreg_s(SYS_PMSLATFR_EL1);
+	ctxt->sys_regs[PMBPTR_EL1] = read_sysreg_s(SYS_PMBPTR_EL1);
 }
 
-static void __hyp_text __debug_restore_spe_nvhe(struct kvm_cpu_context *ctxt)
+static void __hyp_text
+__debug_restore_spe_nvhe(struct kvm_cpu_context *ctxt, bool full_ctxt)
 {
 	if (!ctxt->sys_regs[PMSCR_EL1])
 		return;
@@ -126,6 +151,16 @@ static void __hyp_text __debug_restore_spe_nvhe(struct kvm_cpu_context *ctxt)
 	isb();
 
 	/* Re-enable data generation */
+	if (full_ctxt) {
+		write_sysreg_s(ctxt->sys_regs[PMBPTR_EL1], SYS_PMBPTR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMBLIMITR_EL1], SYS_PMBLIMITR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMSFCR_EL1], SYS_PMSFCR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMSEVFR_EL1], SYS_PMSEVFR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMSLATFR_EL1], SYS_PMSLATFR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMSIRR_EL1], SYS_PMSIRR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMSICR_EL1], SYS_PMSICR_EL1);
+		write_sysreg_s(ctxt->sys_regs[PMBSR_EL1], SYS_PMBSR_EL1);
+	}
 	write_sysreg_el1(ctxt->sys_regs[PMSCR_EL1], SYS_PMSCR);
 }
 
@@ -198,7 +233,7 @@ void __hyp_text __debug_restore_host_context(struct kvm_vcpu *vcpu)
 	guest_ctxt = &vcpu->arch.ctxt;
 
 	if (!has_vhe())
-		__debug_restore_spe_nvhe(host_ctxt);
+		__debug_restore_spe_nvhe(host_ctxt, false);
 
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
@@ -222,7 +257,7 @@ void __hyp_text __debug_save_host_context(struct kvm_vcpu *vcpu)
 
 	host_ctxt = kern_hyp_va(vcpu->arch.host_cpu_context);
 	if (!has_vhe())
-		__debug_save_spe_nvhe(host_ctxt);
+		__debug_save_spe_nvhe(host_ctxt, false);
 }
 
 void __hyp_text __debug_save_guest_context(struct kvm_vcpu *vcpu)
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
