Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94C4C10F0
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 12:02:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDD744C479;
	Wed, 23 Feb 2022 06:02:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.766
X-Spam-Level: 
X-Spam-Status: No, score=-0.766 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, MISSING_HEADERS=1.021,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Og83UDvJ1fYt; Wed, 23 Feb 2022 06:02:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 033EE4C4A6;
	Wed, 23 Feb 2022 06:02:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71BD249EB4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 12:01:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eXFava6etM8k for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Feb 2022 12:01:43 -0500 (EST)
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com
 [209.85.128.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8651C49EFF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 12:01:43 -0500 (EST)
Received: by mail-yw1-f202.google.com with SMTP id
 00721157ae682-2d6baed6aafso127869797b3.3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Feb 2022 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
 bh=EEB0cF7W8Z4tzEJGAGYjBKXuJWIAUS9G1/uPvryZBvQ=;
 b=p7Id9dQujHyG29UdzWat8WdvrrPOw9krxSXiqk00tl1BZL9gYpFz1Lm+YwRDklhGUH
 150VLbRfa0vcn/ERLt+En0egKXNgOC8lOqXzts0iqORAExDDaPBq3HdTShbvH1CSuDZK
 lCiPBIiXIti2UHtIQayQ0NSEjtzeT40JmK27ityUxx5sAtcfCy46cvf6FedW4XfLEfmZ
 fhR9famMNOpZEMx80sWjahdWq+EzlpJ4922/FHyVPoD0Ln4NAfbQO+vCazvCjeJOFkzM
 uavkGk1fmEM0XM2PtoEUoda5VCyP1ut3qzRDpZH2wkQuOscNUT3ISzbq5dQ2OWa6ykos
 IBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:cc;
 bh=EEB0cF7W8Z4tzEJGAGYjBKXuJWIAUS9G1/uPvryZBvQ=;
 b=TB1EOKGadyfEQmYMPDxJ9rpgzJNBL3tteRZ1nfTrTOlEtPA1c+u22wf8D/lzwzLp6a
 omAbKVJPa+2d0EnXgBdLn2QdR2ve7c5+jmd+HLtzRG/r/72hcq4LVt+6HHW0BABFjOEq
 ak8TOmcTv7nt20B0Ei7EDA9QxRZdjjUjBpefSMRG8YIxy4cc98tSS6TMlO74T+LGgu+T
 ZNv8FLHQaGJ/RVr0NDcf2aPttmgL92I4ZDKklQvid9C73LexFCPaE04Db8AuXCMT/SA8
 yH+QK3Vew9MlEq36hhwoXVetliV/cj4c+R6Ean9pXlOuAqI8mvHyE1zdAcZBQy4KoniU
 pIBQ==
X-Gm-Message-State: AOAM531XD3z/kBNQ7qvLSFavRLiuhXYgZMd6tUQ0m0pKE7HCwOBzJKcl
 +H1asSnj0eEh+VztKL2KF/RGbhWi0kXXM1Qy+g==
X-Google-Smtp-Source: ABdhPJzEcdFuLjZ+IU/YVKrt6YVo9vU91uda9Y6U5r89FElLqqMG4NnbgdLFIeyeY+V8GzaBnO8HGFz4Jr+YvAi4wg==
X-Received: from kaleshsingh.mtv.corp.google.com
 ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a25:84cf:0:b0:621:a740:3249 with SMTP
 id x15-20020a2584cf000000b00621a7403249mr23161492ybm.275.1645549303006; Tue,
 22 Feb 2022 09:01:43 -0800 (PST)
Date: Tue, 22 Feb 2022 08:51:09 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-9-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 8/9] KVM: arm64: Unwind and dump nVHE HYP stacktrace
From: Kalesh Singh <kaleshsingh@google.com>
X-Mailman-Approved-At: Wed, 23 Feb 2022 06:02:29 -0500
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, will@kernel.org,
 Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 kvmarm@lists.cs.columbia.edu, Kalesh Singh <kaleshsingh@google.com>,
 surenb@google.com, linux-arm-kernel@lists.infradead.org
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

Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled. This is
possible because CONFIG_NVHE_EL2_DEBUG disables the host stage 2 protection
which allows host to access the hypervisor stack pages in EL1.

Unwinding and dumping hyp call traces is gated on CONFIG_NVHE_EL2_DEBUG
to avoid the potential leaking of information to the host.

A simple stack overflow test produces the following output:

[  580.376051][  T412] kvm: nVHE hyp panic at: ffffffc0116145c4!
[  580.378034][  T412] kvm [412]: nVHE HYP call trace:
[  580.378591][  T412] kvm [412]:  [<ffffffc011614934>]
[  580.378993][  T412] kvm [412]:  [<ffffffc01160fa48>]
[  580.379386][  T412] kvm [412]:  [<ffffffc0116145dc>]  // Non-terminating recursive call
[  580.379772][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380158][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380544][  T412] kvm [412]:  [<ffffffc0116145dc>]
[  580.380928][  T412] kvm [412]:  [<ffffffc0116145dc>]
. . .

Since nVHE hyp symbols are not included by kallsyms to avoid issues
with aliasing, we fallback to the vmlinux addresses. Symbolizing the
addresses is handled in the next patch in this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Add cpu_prepare_nvhe_panic_info()
  - Move updating the panic info to hyp_panic(), so that unwinding also
    works for conventional nVHE Hyp-mode.

 arch/arm64/include/asm/kvm_asm.h |  17 ++
 arch/arm64/kvm/Kconfig           |   5 +-
 arch/arm64/kvm/Makefile          |   1 +
 arch/arm64/kvm/arm.c             |   2 +-
 arch/arm64/kvm/handle_exit.c     |   3 +
 arch/arm64/kvm/hyp/nvhe/switch.c |  19 ++
 arch/arm64/kvm/stacktrace.c      | 290 +++++++++++++++++++++++++++++++
 arch/arm64/kvm/stacktrace.h      |  17 ++
 8 files changed, 351 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/stacktrace.c
 create mode 100644 arch/arm64/kvm/stacktrace.h

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..af44b3a0596b 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,23 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/*
+ * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
+ * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
+ * the host stage 2 protection. See: __hyp_do_panic()
+ *
+ * @hyp_stack_base:		hyp VA of the hyp_stack base.
+ * @hyp_overflow_stack_base:	hyp VA of the hyp_overflow_stack base.
+ * @start_fp:			hyp FP where the hyp backtrace should begin.
+ */
+struct kvm_nvhe_panic_info {
+	unsigned long hyp_stack_base;
+	unsigned long hyp_overflow_stack_base;
+	unsigned long start_fp;
+};
+#endif
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..75f2c8255ff0 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -51,8 +51,9 @@ config NVHE_EL2_DEBUG
 	depends on KVM
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
-	  Failure reports will BUG() in the hypervisor. This is intended for
-	  local EL2 hypervisor development.
+	  Failure reports will BUG() in the hypervisor; and panics will print
+	  the hypervisor call stack. This is intended for local EL2 hypervisor
+	  development.
 
 	  If unsure, say N.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 91861fd8b897..262b5c58cc62 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
+kvm-$(CONFIG_NVHE_EL2_DEBUG)  += stacktrace.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7e2e680c3ffb..491cf1eb28f6 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e3140abd2e2e..b038c32a3236 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -23,6 +23,7 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace_handle_exit.h"
+#include "stacktrace.h"
 
 typedef int (*exit_handle_fn)(struct kvm_vcpu *);
 
@@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
 	}
 
+	hyp_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 2accc158210f..57ab23f03b1e 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -37,6 +37,23 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 #ifdef CONFIG_NVHE_EL2_DEBUG
 DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
 	__aligned(16);
+DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+DECLARE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static void cpu_prepare_nvhe_panic_info(void)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr(&kvm_panic_info);
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+
+	panic_info->hyp_stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+	panic_info->hyp_overflow_stack_base = (unsigned long)this_cpu_ptr(hyp_overflow_stack);
+	panic_info->start_fp = (unsigned long)__builtin_frame_address(0);
+}
+#else
+static void cpu_prepare_nvhe_panic_info(void)
+{
+}
 #endif
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -360,6 +377,8 @@ void __noreturn hyp_panic(void)
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_vcpu *vcpu;
 
+	cpu_prepare_nvhe_panic_info();
+
 	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	vcpu = host_ctxt->__hyp_running_vcpu;
 
diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
new file mode 100644
index 000000000000..cdd672bf0ea8
--- /dev/null
+++ b/arch/arm64/kvm/stacktrace.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Stack unwinder for EL2 nVHE hypervisor.
+ *
+ * Code mostly copied from the arm64 kernel stack unwinder
+ * and adapted to the nVHE hypervisor.
+ *
+ * See: arch/arm64/kernel/stacktrace.c
+ *
+ * CONFIG_NVHE_EL2_DEBUG disables the host stage-2 protection
+ * allowing us to access the hypervisor stack pages and
+ * consequently unwind its stack from the host in EL1.
+ *
+ * See: __hyp_do_panic()
+ */
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
+#include <linux/kvm_host.h>
+#include "stacktrace.h"
+
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+enum hyp_stack_type {
+	HYP_STACK_TYPE_UNKNOWN,
+	HYP_STACK_TYPE_HYP,
+	HYP_STACK_TYPE_OVERFLOW,
+	__NR_HYP_STACK_TYPES
+};
+
+struct hyp_stack_info {
+	unsigned long low;
+	unsigned long high;
+	enum hyp_stack_type type;
+};
+
+/*
+ * A snapshot of a frame record or fp/lr register values, along with some
+ * accounting information necessary for robust unwinding.
+ *
+ * @fp:          The fp value in the frame record (or the real fp)
+ * @pc:          The pc value calculated from lr in the frame record.
+ *
+ * @stacks_done: Stacks which have been entirely unwound, for which it is no
+ *               longer valid to unwind to.
+ *
+ * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
+ *               of 0. This is used to ensure that within a stack, each
+ *               subsequent frame record is at an increasing address.
+ * @prev_type:   The type of stack this frame record was on, or a synthetic
+ *               value of HYP_STACK_TYPE_UNKNOWN. This is used to detect a
+ *               transition from one stack to another.
+ */
+struct hyp_stackframe {
+	unsigned long fp;
+	unsigned long pc;
+	DECLARE_BITMAP(stacks_done, __NR_HYP_STACK_TYPES);
+	unsigned long prev_fp;
+	enum hyp_stack_type prev_type;
+};
+
+static inline bool __on_hyp_stack(unsigned long hyp_sp, unsigned long size,
+				unsigned long low, unsigned long high,
+				enum hyp_stack_type type,
+				struct hyp_stack_info *info)
+{
+	if (!low)
+		return false;
+
+	if (hyp_sp < low || hyp_sp + size < hyp_sp || hyp_sp + size > high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = type;
+	}
+	return true;
+}
+
+static inline bool on_hyp_overflow_stack(unsigned long hyp_sp, unsigned long size,
+				 struct hyp_stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_overflow_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return __on_hyp_stack(hyp_sp, size, low, high, HYP_STACK_TYPE_OVERFLOW, info);
+}
+
+static inline bool on_hyp_stack(unsigned long hyp_sp, unsigned long size,
+				 struct hyp_stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return __on_hyp_stack(hyp_sp, size, low, high, HYP_STACK_TYPE_HYP, info);
+}
+
+static inline bool on_hyp_accessible_stack(unsigned long hyp_sp, unsigned long size,
+				       struct hyp_stack_info *info)
+{
+	if (info)
+		info->type = HYP_STACK_TYPE_UNKNOWN;
+
+	if (on_hyp_stack(hyp_sp, size, info))
+		return true;
+	if (on_hyp_overflow_stack(hyp_sp, size, info))
+		return true;
+
+	return false;
+}
+
+static unsigned long __hyp_stack_kern_va(unsigned long hyp_va)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_stack_base;
+	hyp_offset = hyp_va - hyp_base;
+
+	kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+
+	return kern_base + hyp_offset;
+}
+
+static unsigned long __hyp_overflow_stack_kern_va(unsigned long hyp_va)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_overflow_stack_base;
+	hyp_offset = hyp_va - hyp_base;
+
+	kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow_stack);
+
+	return kern_base + hyp_offset;
+}
+
+/*
+ * Convert hypervisor stack VA to a kernel VA.
+ *
+ * The hypervisor stack is mapped in the flexible 'private' VA range, to allow
+ * for guard pages below the stack. Consequently, the fixed offset address
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
+ * stack base. See: __hyp_stack_kern_va(),  __hyp_overflow_stack_kern_va()
+ */
+static unsigned long hyp_stack_kern_va(unsigned long hyp_va,
+					enum hyp_stack_type stack_type)
+{
+	switch (stack_type) {
+	case HYP_STACK_TYPE_HYP:
+		return __hyp_stack_kern_va(hyp_va);
+	case HYP_STACK_TYPE_OVERFLOW:
+		return __hyp_overflow_stack_kern_va(hyp_va);
+	default:
+		return 0UL;
+	}
+}
+
+/*
+ * Unwind from one frame record (A) to the next frame record (B).
+ *
+ * We terminate early if the location of B indicates a malformed chain of frame
+ * records (e.g. a cycle), determined based on the location and fp value of A
+ * and the location (but not the fp value) of B.
+ */
+static int notrace hyp_unwind_frame(struct hyp_stackframe *frame)
+{
+	unsigned long fp = frame->fp, fp_kern_va;
+	struct hyp_stack_info info;
+
+	if (fp & 0x7)
+		return -EINVAL;
+
+	if (!on_hyp_accessible_stack(fp, 16, &info))
+		return -EINVAL;
+
+	if (test_bit(info.type, frame->stacks_done))
+		return -EINVAL;
+
+	/*
+	 * As stacks grow downward, any valid record on the same stack must be
+	 * at a strictly higher address than the prior record.
+	 *
+	 * Stacks can nest in the following order:
+	 *
+	 * HYP -> OVERFLOW
+	 *
+	 * ... but the nesting itself is strict. Once we transition from one
+	 * stack to another, it's never valid to unwind back to that first
+	 * stack.
+	 */
+	if (info.type == frame->prev_type) {
+		if (fp <= frame->prev_fp)
+			return -EINVAL;
+	} else {
+		set_bit(frame->prev_type, frame->stacks_done);
+	}
+
+	/* Translate the hyp stack address to a kernel address */
+	fp_kern_va = hyp_stack_kern_va(fp, info.type);
+	if (!fp_kern_va)
+		return -EINVAL;
+
+	/*
+	 * Record this frame record's values and location. The prev_fp and
+	 * prev_type are only meaningful to the next hyp_unwind_frame()
+	 * invocation.
+	 */
+	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp_kern_va));
+	/* PC = LR - 4; All aarch64 instructions are 32-bits in size */
+	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp_kern_va + 8)) - 4;
+	frame->prev_fp = fp;
+	frame->prev_type = info.type;
+
+	return 0;
+}
+
+/*
+ * AArch64 PCS assigns the frame pointer to x29.
+ *
+ * A simple function prologue looks like this:
+ *	sub	sp, sp, #0x10
+ *	stp	x29, x30, [sp]
+ *	mov	x29, sp
+ *
+ * A simple function epilogue looks like this:
+ *	mov	sp, x29
+ *	ldp	x29, x30, [sp]
+ *	add	sp, sp, #0x10
+ */
+static void hyp_start_backtrace(struct hyp_stackframe *frame, unsigned long fp)
+{
+	frame->fp = fp;
+
+	/*
+	 * Prime the first unwind.
+	 *
+	 * In hyp_unwind_frame() we'll check that the FP points to a valid
+	 * stack, which can't be HYP_STACK_TYPE_UNKNOWN, and the first unwind
+	 * will be treated as a transition to whichever stack that happens to
+	 * be. The prev_fp value won't be used, but we set it to 0 such that
+	 * it is definitely not an accessible stack address. The first frame
+	 * (hyp_panic()) is skipped, so we also set PC to 0.
+	 */
+	bitmap_zero(frame->stacks_done, __NR_HYP_STACK_TYPES);
+	frame->pc = frame->prev_fp = 0;
+	frame->prev_type = HYP_STACK_TYPE_UNKNOWN;
+}
+
+static void hyp_dump_backtrace_entry(unsigned long hyp_pc, unsigned long hyp_offset)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+
+	hyp_pc &= va_mask;	/* Mask tags */
+	hyp_pc += hyp_offset;
+
+	kvm_err("[<%016lx>]\n", hyp_pc);
+}
+
+void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	struct hyp_stackframe frame;
+	int frame_nr = 0;
+	int skip = 1;		/* Skip the first frame: hyp_panic() */
+
+	kvm_err("nVHE HYP call trace:\n");
+
+	hyp_start_backtrace(&frame, (unsigned long)panic_info->start_fp);
+
+	do {
+		if (skip) {
+			skip--;
+			continue;
+		}
+
+		hyp_dump_backtrace_entry(frame.pc, hyp_offset);
+
+		frame_nr++;
+	} while (!hyp_unwind_frame(&frame));
+
+	kvm_err("---- end of nVHE HYP call trace ----\n");
+}
diff --git a/arch/arm64/kvm/stacktrace.h b/arch/arm64/kvm/stacktrace.h
new file mode 100644
index 000000000000..40c397394b9b
--- /dev/null
+++ b/arch/arm64/kvm/stacktrace.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Stack unwinder for EL2 nVHE hypervisor.
+ */
+
+#ifndef __KVM_HYP_STACKTRACE_H
+#define __KVM_HYP_STACKTRACE_H
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+void hyp_dump_backtrace(unsigned long hyp_offset);
+#else
+static inline void hyp_dump_backtrace(unsigned long hyp_offset)
+{
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
+#endif /* __KVM_HYP_STACKTRACE_H */
-- 
2.35.1.473.g83b2b277ed-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
