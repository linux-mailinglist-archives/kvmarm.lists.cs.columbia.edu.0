Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A30471BFF13
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 16:49:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55FE24B511;
	Thu, 30 Apr 2020 10:49:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6N4BZLtfsE0X; Thu, 30 Apr 2020 10:49:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EDF5B4B52C;
	Thu, 30 Apr 2020 10:49:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDC9C4B440
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 10:49:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeftNSJfQoP4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 10:49:05 -0400 (EDT)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7CC8C4B477
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 10:49:05 -0400 (EDT)
Received: by mail-wm1-f68.google.com with SMTP id 188so2190494wmc.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ckUwu7M7JnKxYtp4YcyrixRVYD5P7zPGk5W5SBVtZIc=;
 b=eAxFbpbB88WAkJkK/l0R+gS1GNcXp/5WU1ermJF6JaRu8CL7y0KBxwF4rYpBJNoqEk
 uMBG0Mpd+54DfMHAEtG/netau4iRLtv9gAkLhVv2kyThzDUxxAxVFo7cyC8504ipYelv
 YKbPwQJpptOmlug7glvf9oRPsbp7MPzoaJsX5bSwCLI3IWYG5qaTIW8K3M/XgVbLdUmE
 hnwvr6onUFwMvoaDI6rVs5OMSydrUpoUcZ3Md2u6jQ8rs1eY3nd6u5fvRnDbjEl49A3B
 SYcYGodJJG8djLsJa7mJ/Hix99bwtyGQp/KA/CCqEb+Iaplo8npFdAfbPwYKja+PD4nZ
 FXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ckUwu7M7JnKxYtp4YcyrixRVYD5P7zPGk5W5SBVtZIc=;
 b=qLV1xnDevYvIlt0JU9djCWQyAPpL5Xem6SZQPMdHJx4cjWAvmLY3sfBHiYz5PYtFAI
 a84jC1LnaKj935wOvi2VjQ01XGgeD8Cz5/LqMZal5m5RT85dK0rbrFET7TQFGE0k5tq0
 fKNtumeNX/DcGLJgpheM3wVySrU5vOl6IlnpMomE+uPWjT6NN0HkKXPDLeflw42/zPOY
 malDJJMx091c6Q+orl6Q4HGG7T8xgLCQEihI/xgxODaX/dN/AbuK42Rt3lHmqhPydRuM
 oPNRqWr/yu9RhE5sad+QAufngQ5qtyyWy92OXbd24KGhhit4T+nCAwt6WAFLbzCqZyxh
 7KYg==
X-Gm-Message-State: AGi0Pub4XqbG2fdnVWVEO72LIFPPXv4yPT4dGxeY80f6+JSFMYq/cq8T
 dYe2o7eDqEkI4BePyyN00Pn+mA==
X-Google-Smtp-Source: APiQypJQWNduwzltaDXtimSwwlg/dZj+fSo++nsFEKtvMxqxIiImB5DCuDmEuHuiKTNz9McXBvQpuw==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr3395070wmt.98.1588258144030;
 Thu, 30 Apr 2020 07:49:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
 by smtp.gmail.com with ESMTPSA id j22sm1317015wre.84.2020.04.30.07.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 07:49:03 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH 10/15] arm64: kvm: Split hyp/sysreg-sr.c to VHE/nVHE
Date: Thu, 30 Apr 2020 15:48:26 +0100
Message-Id: <20200430144831.59194-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

sysreg-sr.c contains KVM's code for saving/restoring system registers, with
some parts shared between VHE/nVHE. These common routines are moved to
sysreg-sr.h, VHE-specific code is left in sysreg-sr.c and nVHE-specific code is
moved to nvhe/sysreg-sr.c.

Naming of helper functions is simplified as VHE/nVHE symbol names cannot clash
anymore.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h    |   4 +
 arch/arm64/include/asm/kvm_host.h   |   4 +-
 arch/arm64/include/asm/kvm_hyp.h    |   4 +
 arch/arm64/kernel/image-vars.h      |   5 -
 arch/arm64/kvm/hyp/nvhe/Makefile    |   2 +-
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c |  56 +++++++
 arch/arm64/kvm/hyp/sysreg-sr.c      | 227 +---------------------------
 arch/arm64/kvm/hyp/sysreg-sr.h      | 218 ++++++++++++++++++++++++++
 8 files changed, 290 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/sysreg-sr.h

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 0cb229b9e148..646201a6576e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -88,6 +88,10 @@ extern void __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high);
 
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
 
+#ifdef __HYPERVISOR__
+extern void __kvm_enable_ssbs(void);
+#endif
+
 extern u64 __vgic_v3_get_ich_vtr_el2(void);
 extern u64 __vgic_v3_read_vmcr(void);
 extern void __vgic_v3_write_vmcr(u32 vmcr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5dec3b06f2b7..e4abe9d759bc 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -547,8 +547,6 @@ static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 	cpu_ctxt->sys_regs[MPIDR_EL1] = read_cpuid_mpidr();
 }
 
-void __kvm_enable_ssbs(void);
-
 static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 				       unsigned long hyp_stack_ptr,
 				       unsigned long vector_ptr)
@@ -577,7 +575,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 */
 	if (!has_vhe() && this_cpu_has_cap(ARM64_SSBS) &&
 	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
-		kvm_call_hyp(__kvm_enable_ssbs);
+		kvm_call_hyp_nvhe(__kvm_enable_ssbs);
 	}
 }
 
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index b5895040c16a..c2bcd5dea030 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -67,12 +67,16 @@ int __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu);
 void __timer_enable_traps(struct kvm_vcpu *vcpu);
 void __timer_disable_traps(struct kvm_vcpu *vcpu);
 
+#ifdef __HYPERVISOR__
 void __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt);
 void __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt);
+#else
 void sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt);
 void sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt);
 void sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt);
 void sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt);
+#endif
+
 void __sysreg32_save_state(struct kvm_vcpu *vcpu);
 void __sysreg32_restore_state(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 0e9ede9c473a..c4ff4a61eb5d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -66,13 +66,8 @@ __hyp_text___fpsimd_save_state = __fpsimd_save_state;
 __hyp_text___guest_enter = __guest_enter;
 __hyp_text___guest_exit = __guest_exit;
 __hyp_text___icache_flags = __icache_flags;
-__hyp_text___kvm_enable_ssbs = __kvm_enable_ssbs;
 __hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
 __hyp_text___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
-__hyp_text___sysreg32_restore_state = __sysreg32_restore_state;
-__hyp_text___sysreg32_save_state = __sysreg32_save_state;
-__hyp_text___sysreg_restore_state_nvhe = __sysreg_restore_state_nvhe;
-__hyp_text___sysreg_save_state_nvhe = __sysreg_save_state_nvhe;
 __hyp_text___timer_disable_traps = __timer_disable_traps;
 __hyp_text___timer_enable_traps = __timer_enable_traps;
 __hyp_text___vgic_v2_perform_cpuif_access = __vgic_v2_perform_cpuif_access;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index bca3b862927c..cfb55c01b3ff 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__HYPERVISOR__
 ccflags-y := -D__HYPERVISOR__ -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 	     $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := debug-sr.o switch.o tlb.o host_hypercall.o ../hyp-entry.o
+obj-y := sysreg-sr.o debug-sr.o switch.o tlb.o host_hypercall.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c b/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
new file mode 100644
index 000000000000..55ab924d841a
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2012-2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kprobes.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
+
+#include "../sysreg-sr.h"
+
+/*
+ * Non-VHE: Both host and guest must save everything.
+ */
+
+void __hyp_text __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt)
+{
+	__sysreg_save_el1_state(ctxt);
+	__sysreg_save_common_state(ctxt);
+	__sysreg_save_user_state(ctxt);
+	__sysreg_save_el2_return_state(ctxt);
+}
+
+void __hyp_text __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt)
+{
+	__sysreg_restore_el1_state(ctxt);
+	__sysreg_restore_common_state(ctxt);
+	__sysreg_restore_user_state(ctxt);
+	__sysreg_restore_el2_return_state(ctxt);
+}
+
+void __hyp_text __sysreg32_save_state(struct kvm_vcpu *vcpu)
+{
+	___sysreg32_save_state(vcpu);
+}
+
+void __hyp_text __sysreg32_restore_state(struct kvm_vcpu *vcpu)
+{
+	___sysreg32_restore_state(vcpu);
+}
+
+void __hyp_text __kvm_enable_ssbs(void)
+{
+	u64 tmp;
+
+	asm volatile(
+	"mrs	%0, sctlr_el2\n"
+	"orr	%0, %0, %1\n"
+	"msr	sctlr_el2, %0"
+	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
+}
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 7a261ace2405..7d4b946739e9 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -12,9 +12,9 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
+#include "sysreg-sr.h"
+
 /*
- * Non-VHE: Both host and guest must save everything.
- *
  * VHE: Host and guest must save mdscr_el1 and sp_el0 (and the PC and pstate,
  * which are handled as part of the el2 return state) on every switch.
  * tpidr_el0 and tpidrro_el0 only need to be switched when going
@@ -23,66 +23,6 @@
  * classes are handled as part of kvm_arch_vcpu_load and kvm_arch_vcpu_put.
  */
 
-static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
-
-	/*
-	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
-	 * therefore be saved/restored on every entry/exit to/from the guest.
-	 */
-	ctxt->gp_regs.regs.sp		= read_sysreg(sp_el0);
-}
-
-static void __hyp_text __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt->sys_regs[TPIDR_EL0]	= read_sysreg(tpidr_el0);
-	ctxt->sys_regs[TPIDRRO_EL0]	= read_sysreg(tpidrro_el0);
-}
-
-static void __hyp_text __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt->sys_regs[CSSELR_EL1]	= read_sysreg(csselr_el1);
-	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(SYS_SCTLR);
-	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
-	ctxt->sys_regs[CPACR_EL1]	= read_sysreg_el1(SYS_CPACR);
-	ctxt->sys_regs[TTBR0_EL1]	= read_sysreg_el1(SYS_TTBR0);
-	ctxt->sys_regs[TTBR1_EL1]	= read_sysreg_el1(SYS_TTBR1);
-	ctxt->sys_regs[TCR_EL1]		= read_sysreg_el1(SYS_TCR);
-	ctxt->sys_regs[ESR_EL1]		= read_sysreg_el1(SYS_ESR);
-	ctxt->sys_regs[AFSR0_EL1]	= read_sysreg_el1(SYS_AFSR0);
-	ctxt->sys_regs[AFSR1_EL1]	= read_sysreg_el1(SYS_AFSR1);
-	ctxt->sys_regs[FAR_EL1]		= read_sysreg_el1(SYS_FAR);
-	ctxt->sys_regs[MAIR_EL1]	= read_sysreg_el1(SYS_MAIR);
-	ctxt->sys_regs[VBAR_EL1]	= read_sysreg_el1(SYS_VBAR);
-	ctxt->sys_regs[CONTEXTIDR_EL1]	= read_sysreg_el1(SYS_CONTEXTIDR);
-	ctxt->sys_regs[AMAIR_EL1]	= read_sysreg_el1(SYS_AMAIR);
-	ctxt->sys_regs[CNTKCTL_EL1]	= read_sysreg_el1(SYS_CNTKCTL);
-	ctxt->sys_regs[PAR_EL1]		= read_sysreg(par_el1);
-	ctxt->sys_regs[TPIDR_EL1]	= read_sysreg(tpidr_el1);
-
-	ctxt->gp_regs.sp_el1		= read_sysreg(sp_el1);
-	ctxt->gp_regs.elr_el1		= read_sysreg_el1(SYS_ELR);
-	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(SYS_SPSR);
-}
-
-static void __hyp_text __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt->gp_regs.regs.pc		= read_sysreg_el2(SYS_ELR);
-	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(SYS_SPSR);
-
-	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
-		ctxt->sys_regs[DISR_EL1] = read_sysreg_s(SYS_VDISR_EL2);
-}
-
-void __hyp_text __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt)
-{
-	__sysreg_save_el1_state(ctxt);
-	__sysreg_save_common_state(ctxt);
-	__sysreg_save_user_state(ctxt);
-	__sysreg_save_el2_return_state(ctxt);
-}
-
 void sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_save_common_state(ctxt);
@@ -96,116 +36,6 @@ void sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt)
 }
 NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
 
-static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
-{
-	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
-
-	/*
-	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
-	 * therefore be saved/restored on every entry/exit to/from the guest.
-	 */
-	write_sysreg(ctxt->gp_regs.regs.sp,	  sp_el0);
-}
-
-static void __hyp_text __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
-{
-	write_sysreg(ctxt->sys_regs[TPIDR_EL0],		tpidr_el0);
-	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0],	tpidrro_el0);
-}
-
-static void __hyp_text __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
-{
-	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
-	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
-
-	if (!cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
-		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
-		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
-	} else	if (!ctxt->__hyp_running_vcpu) {
-		/*
-		 * Must only be done for guest registers, hence the context
-		 * test. We're coming from the host, so SCTLR.M is already
-		 * set. Pairs with nVHE's __activate_traps().
-		 */
-		write_sysreg_el1((ctxt->sys_regs[TCR_EL1] |
-				  TCR_EPD1_MASK | TCR_EPD0_MASK),
-				 SYS_TCR);
-		isb();
-	}
-
-	write_sysreg(ctxt->sys_regs[ACTLR_EL1],		actlr_el1);
-	write_sysreg_el1(ctxt->sys_regs[CPACR_EL1],	SYS_CPACR);
-	write_sysreg_el1(ctxt->sys_regs[TTBR0_EL1],	SYS_TTBR0);
-	write_sysreg_el1(ctxt->sys_regs[TTBR1_EL1],	SYS_TTBR1);
-	write_sysreg_el1(ctxt->sys_regs[ESR_EL1],	SYS_ESR);
-	write_sysreg_el1(ctxt->sys_regs[AFSR0_EL1],	SYS_AFSR0);
-	write_sysreg_el1(ctxt->sys_regs[AFSR1_EL1],	SYS_AFSR1);
-	write_sysreg_el1(ctxt->sys_regs[FAR_EL1],	SYS_FAR);
-	write_sysreg_el1(ctxt->sys_regs[MAIR_EL1],	SYS_MAIR);
-	write_sysreg_el1(ctxt->sys_regs[VBAR_EL1],	SYS_VBAR);
-	write_sysreg_el1(ctxt->sys_regs[CONTEXTIDR_EL1],SYS_CONTEXTIDR);
-	write_sysreg_el1(ctxt->sys_regs[AMAIR_EL1],	SYS_AMAIR);
-	write_sysreg_el1(ctxt->sys_regs[CNTKCTL_EL1],	SYS_CNTKCTL);
-	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
-	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
-
-	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE) &&
-	    ctxt->__hyp_running_vcpu) {
-		/*
-		 * Must only be done for host registers, hence the context
-		 * test. Pairs with nVHE's __deactivate_traps().
-		 */
-		isb();
-		/*
-		 * At this stage, and thanks to the above isb(), S2 is
-		 * deconfigured and disabled. We can now restore the host's
-		 * S1 configuration: SCTLR, and only then TCR.
-		 */
-		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
-		isb();
-		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
-	}
-
-	write_sysreg(ctxt->gp_regs.sp_el1,		sp_el1);
-	write_sysreg_el1(ctxt->gp_regs.elr_el1,		SYS_ELR);
-	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],SYS_SPSR);
-}
-
-static void __hyp_text
-__sysreg_restore_el2_return_state(struct kvm_cpu_context *ctxt)
-{
-	u64 pstate = ctxt->gp_regs.regs.pstate;
-	u64 mode = pstate & PSR_AA32_MODE_MASK;
-
-	/*
-	 * Safety check to ensure we're setting the CPU up to enter the guest
-	 * in a less privileged mode.
-	 *
-	 * If we are attempting a return to EL2 or higher in AArch64 state,
-	 * program SPSR_EL2 with M=EL2h and the IL bit set which ensures that
-	 * we'll take an illegal exception state exception immediately after
-	 * the ERET to the guest.  Attempts to return to AArch32 Hyp will
-	 * result in an illegal exception return because EL2's execution state
-	 * is determined by SCR_EL3.RW.
-	 */
-	if (!(mode & PSR_MODE32_BIT) && mode >= PSR_MODE_EL2t)
-		pstate = PSR_MODE_EL2h | PSR_IL_BIT;
-
-	write_sysreg_el2(ctxt->gp_regs.regs.pc,		SYS_ELR);
-	write_sysreg_el2(pstate,			SYS_SPSR);
-
-	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
-		write_sysreg_s(ctxt->sys_regs[DISR_EL1], SYS_VDISR_EL2);
-}
-
-void __hyp_text __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt)
-{
-	__sysreg_restore_el1_state(ctxt);
-	__sysreg_restore_common_state(ctxt);
-	__sysreg_restore_user_state(ctxt);
-	__sysreg_restore_el2_return_state(ctxt);
-}
-
 void sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_restore_common_state(ctxt);
@@ -219,48 +49,14 @@ void sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt)
 }
 NOKPROBE_SYMBOL(sysreg_restore_guest_state_vhe);
 
-void __hyp_text __sysreg32_save_state(struct kvm_vcpu *vcpu)
+void __sysreg32_save_state(struct kvm_vcpu *vcpu)
 {
-	u64 *spsr, *sysreg;
-
-	if (!vcpu_el1_is_32bit(vcpu))
-		return;
-
-	spsr = vcpu->arch.ctxt.gp_regs.spsr;
-	sysreg = vcpu->arch.ctxt.sys_regs;
-
-	spsr[KVM_SPSR_ABT] = read_sysreg(spsr_abt);
-	spsr[KVM_SPSR_UND] = read_sysreg(spsr_und);
-	spsr[KVM_SPSR_IRQ] = read_sysreg(spsr_irq);
-	spsr[KVM_SPSR_FIQ] = read_sysreg(spsr_fiq);
-
-	sysreg[DACR32_EL2] = read_sysreg(dacr32_el2);
-	sysreg[IFSR32_EL2] = read_sysreg(ifsr32_el2);
-
-	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
-		sysreg[DBGVCR32_EL2] = read_sysreg(dbgvcr32_el2);
+	___sysreg32_save_state(vcpu);
 }
 
-void __hyp_text __sysreg32_restore_state(struct kvm_vcpu *vcpu)
+void __sysreg32_restore_state(struct kvm_vcpu *vcpu)
 {
-	u64 *spsr, *sysreg;
-
-	if (!vcpu_el1_is_32bit(vcpu))
-		return;
-
-	spsr = vcpu->arch.ctxt.gp_regs.spsr;
-	sysreg = vcpu->arch.ctxt.sys_regs;
-
-	write_sysreg(spsr[KVM_SPSR_ABT], spsr_abt);
-	write_sysreg(spsr[KVM_SPSR_UND], spsr_und);
-	write_sysreg(spsr[KVM_SPSR_IRQ], spsr_irq);
-	write_sysreg(spsr[KVM_SPSR_FIQ], spsr_fiq);
-
-	write_sysreg(sysreg[DACR32_EL2], dacr32_el2);
-	write_sysreg(sysreg[IFSR32_EL2], ifsr32_el2);
-
-	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
-		write_sysreg(sysreg[DBGVCR32_EL2], dbgvcr32_el2);
+	___sysreg32_restore_state(vcpu);
 }
 
 /**
@@ -329,14 +125,3 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.sysregs_loaded_on_cpu = false;
 }
-
-void __hyp_text __kvm_enable_ssbs(void)
-{
-	u64 tmp;
-
-	asm volatile(
-	"mrs	%0, sctlr_el2\n"
-	"orr	%0, %0, %1\n"
-	"msr	sctlr_el2, %0"
-	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
-}
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/sysreg-sr.h
new file mode 100644
index 000000000000..f667d3fb680f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/sysreg-sr.h
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2012-2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kprobes.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
+
+static inline void __hyp_text
+__sysreg_save_common_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
+
+	/*
+	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
+	 * therefore be saved/restored on every entry/exit to/from the guest.
+	 */
+	ctxt->gp_regs.regs.sp		= read_sysreg(sp_el0);
+}
+
+static inline void __hyp_text
+__sysreg_save_user_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt->sys_regs[TPIDR_EL0]	= read_sysreg(tpidr_el0);
+	ctxt->sys_regs[TPIDRRO_EL0]	= read_sysreg(tpidrro_el0);
+}
+
+static inline void __hyp_text
+__sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt->sys_regs[CSSELR_EL1]	= read_sysreg(csselr_el1);
+	ctxt->sys_regs[SCTLR_EL1]	= read_sysreg_el1(SYS_SCTLR);
+	ctxt->sys_regs[ACTLR_EL1]	= read_sysreg(actlr_el1);
+	ctxt->sys_regs[CPACR_EL1]	= read_sysreg_el1(SYS_CPACR);
+	ctxt->sys_regs[TTBR0_EL1]	= read_sysreg_el1(SYS_TTBR0);
+	ctxt->sys_regs[TTBR1_EL1]	= read_sysreg_el1(SYS_TTBR1);
+	ctxt->sys_regs[TCR_EL1]		= read_sysreg_el1(SYS_TCR);
+	ctxt->sys_regs[ESR_EL1]		= read_sysreg_el1(SYS_ESR);
+	ctxt->sys_regs[AFSR0_EL1]	= read_sysreg_el1(SYS_AFSR0);
+	ctxt->sys_regs[AFSR1_EL1]	= read_sysreg_el1(SYS_AFSR1);
+	ctxt->sys_regs[FAR_EL1]		= read_sysreg_el1(SYS_FAR);
+	ctxt->sys_regs[MAIR_EL1]	= read_sysreg_el1(SYS_MAIR);
+	ctxt->sys_regs[VBAR_EL1]	= read_sysreg_el1(SYS_VBAR);
+	ctxt->sys_regs[CONTEXTIDR_EL1]	= read_sysreg_el1(SYS_CONTEXTIDR);
+	ctxt->sys_regs[AMAIR_EL1]	= read_sysreg_el1(SYS_AMAIR);
+	ctxt->sys_regs[CNTKCTL_EL1]	= read_sysreg_el1(SYS_CNTKCTL);
+	ctxt->sys_regs[PAR_EL1]		= read_sysreg(par_el1);
+	ctxt->sys_regs[TPIDR_EL1]	= read_sysreg(tpidr_el1);
+
+	ctxt->gp_regs.sp_el1		= read_sysreg(sp_el1);
+	ctxt->gp_regs.elr_el1		= read_sysreg_el1(SYS_ELR);
+	ctxt->gp_regs.spsr[KVM_SPSR_EL1]= read_sysreg_el1(SYS_SPSR);
+}
+
+static inline void __hyp_text
+__sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt->gp_regs.regs.pc		= read_sysreg_el2(SYS_ELR);
+	ctxt->gp_regs.regs.pstate	= read_sysreg_el2(SYS_SPSR);
+
+	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
+		ctxt->sys_regs[DISR_EL1] = read_sysreg_s(SYS_VDISR_EL2);
+}
+
+static inline void __hyp_text
+__sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
+{
+	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
+
+	/*
+	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
+	 * therefore be saved/restored on every entry/exit to/from the guest.
+	 */
+	write_sysreg(ctxt->gp_regs.regs.sp,	  sp_el0);
+}
+
+static inline void __hyp_text
+__sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
+{
+	write_sysreg(ctxt->sys_regs[TPIDR_EL0],		tpidr_el0);
+	write_sysreg(ctxt->sys_regs[TPIDRRO_EL0],	tpidrro_el0);
+}
+
+static inline void __hyp_text
+__sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
+{
+	write_sysreg(ctxt->sys_regs[MPIDR_EL1],		vmpidr_el2);
+	write_sysreg(ctxt->sys_regs[CSSELR_EL1],	csselr_el1);
+
+	if (!cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
+		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
+		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
+	} else	if (!ctxt->__hyp_running_vcpu) {
+		/*
+		 * Must only be done for guest registers, hence the context
+		 * test. We're coming from the host, so SCTLR.M is already
+		 * set. Pairs with nVHE's __activate_traps().
+		 */
+		write_sysreg_el1((ctxt->sys_regs[TCR_EL1] |
+				  TCR_EPD1_MASK | TCR_EPD0_MASK),
+				 SYS_TCR);
+		isb();
+	}
+
+	write_sysreg(ctxt->sys_regs[ACTLR_EL1],		actlr_el1);
+	write_sysreg_el1(ctxt->sys_regs[CPACR_EL1],	SYS_CPACR);
+	write_sysreg_el1(ctxt->sys_regs[TTBR0_EL1],	SYS_TTBR0);
+	write_sysreg_el1(ctxt->sys_regs[TTBR1_EL1],	SYS_TTBR1);
+	write_sysreg_el1(ctxt->sys_regs[ESR_EL1],	SYS_ESR);
+	write_sysreg_el1(ctxt->sys_regs[AFSR0_EL1],	SYS_AFSR0);
+	write_sysreg_el1(ctxt->sys_regs[AFSR1_EL1],	SYS_AFSR1);
+	write_sysreg_el1(ctxt->sys_regs[FAR_EL1],	SYS_FAR);
+	write_sysreg_el1(ctxt->sys_regs[MAIR_EL1],	SYS_MAIR);
+	write_sysreg_el1(ctxt->sys_regs[VBAR_EL1],	SYS_VBAR);
+	write_sysreg_el1(ctxt->sys_regs[CONTEXTIDR_EL1],SYS_CONTEXTIDR);
+	write_sysreg_el1(ctxt->sys_regs[AMAIR_EL1],	SYS_AMAIR);
+	write_sysreg_el1(ctxt->sys_regs[CNTKCTL_EL1],	SYS_CNTKCTL);
+	write_sysreg(ctxt->sys_regs[PAR_EL1],		par_el1);
+	write_sysreg(ctxt->sys_regs[TPIDR_EL1],		tpidr_el1);
+
+	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE) &&
+	    ctxt->__hyp_running_vcpu) {
+		/*
+		 * Must only be done for host registers, hence the context
+		 * test. Pairs with nVHE's __deactivate_traps().
+		 */
+		isb();
+		/*
+		 * At this stage, and thanks to the above isb(), S2 is
+		 * deconfigured and disabled. We can now restore the host's
+		 * S1 configuration: SCTLR, and only then TCR.
+		 */
+		write_sysreg_el1(ctxt->sys_regs[SCTLR_EL1],	SYS_SCTLR);
+		isb();
+		write_sysreg_el1(ctxt->sys_regs[TCR_EL1],	SYS_TCR);
+	}
+
+	write_sysreg(ctxt->gp_regs.sp_el1,		sp_el1);
+	write_sysreg_el1(ctxt->gp_regs.elr_el1,		SYS_ELR);
+	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],SYS_SPSR);
+}
+
+static inline void __hyp_text
+__sysreg_restore_el2_return_state(struct kvm_cpu_context *ctxt)
+{
+	u64 pstate = ctxt->gp_regs.regs.pstate;
+	u64 mode = pstate & PSR_AA32_MODE_MASK;
+
+	/*
+	 * Safety check to ensure we're setting the CPU up to enter the guest
+	 * in a less privileged mode.
+	 *
+	 * If we are attempting a return to EL2 or higher in AArch64 state,
+	 * program SPSR_EL2 with M=EL2h and the IL bit set which ensures that
+	 * we'll take an illegal exception state exception immediately after
+	 * the ERET to the guest.  Attempts to return to AArch32 Hyp will
+	 * result in an illegal exception return because EL2's execution state
+	 * is determined by SCR_EL3.RW.
+	 */
+	if (!(mode & PSR_MODE32_BIT) && mode >= PSR_MODE_EL2t)
+		pstate = PSR_MODE_EL2h | PSR_IL_BIT;
+
+	write_sysreg_el2(ctxt->gp_regs.regs.pc,		SYS_ELR);
+	write_sysreg_el2(pstate,			SYS_SPSR);
+
+	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
+		write_sysreg_s(ctxt->sys_regs[DISR_EL1], SYS_VDISR_EL2);
+}
+
+static inline void __hyp_text ___sysreg32_save_state(struct kvm_vcpu *vcpu)
+{
+	u64 *spsr, *sysreg;
+
+	if (!vcpu_el1_is_32bit(vcpu))
+		return;
+
+	spsr = vcpu->arch.ctxt.gp_regs.spsr;
+	sysreg = vcpu->arch.ctxt.sys_regs;
+
+	spsr[KVM_SPSR_ABT] = read_sysreg(spsr_abt);
+	spsr[KVM_SPSR_UND] = read_sysreg(spsr_und);
+	spsr[KVM_SPSR_IRQ] = read_sysreg(spsr_irq);
+	spsr[KVM_SPSR_FIQ] = read_sysreg(spsr_fiq);
+
+	sysreg[DACR32_EL2] = read_sysreg(dacr32_el2);
+	sysreg[IFSR32_EL2] = read_sysreg(ifsr32_el2);
+
+	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
+		sysreg[DBGVCR32_EL2] = read_sysreg(dbgvcr32_el2);
+}
+
+static inline void __hyp_text ___sysreg32_restore_state(struct kvm_vcpu *vcpu)
+{
+	u64 *spsr, *sysreg;
+
+	if (!vcpu_el1_is_32bit(vcpu))
+		return;
+
+	spsr = vcpu->arch.ctxt.gp_regs.spsr;
+	sysreg = vcpu->arch.ctxt.sys_regs;
+
+	write_sysreg(spsr[KVM_SPSR_ABT], spsr_abt);
+	write_sysreg(spsr[KVM_SPSR_UND], spsr_und);
+	write_sysreg(spsr[KVM_SPSR_IRQ], spsr_irq);
+	write_sysreg(spsr[KVM_SPSR_FIQ], spsr_fiq);
+
+	write_sysreg(sysreg[DACR32_EL2], dacr32_el2);
+	write_sysreg(sysreg[IFSR32_EL2], ifsr32_el2);
+
+	if (has_vhe() || vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY)
+		write_sysreg(sysreg[DBGVCR32_EL2], dbgvcr32_el2);
+}
-- 
2.26.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
