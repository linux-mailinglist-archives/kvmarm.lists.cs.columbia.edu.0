Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5464E4D06FB
	for <lists+kvmarm@lfdr.de>; Mon,  7 Mar 2022 19:53:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADFAC4B106;
	Mon,  7 Mar 2022 13:53:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.767
X-Spam-Level: 
X-Spam-Status: No, score=-0.767 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, MISSING_HEADERS=1.021,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLO+vxpNJ5eV; Mon,  7 Mar 2022 13:53:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1512249F5F;
	Mon,  7 Mar 2022 13:53:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED95749EED
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 13:53:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yrn8ZG9V5VZW for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Mar 2022 13:53:46 -0500 (EST)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 54CCF4B172
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Mar 2022 13:53:46 -0500 (EST)
Received: by mail-yb1-f201.google.com with SMTP id
 o133-20020a25738b000000b0062872621d0eso14270495ybc.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 07 Mar 2022 10:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
 bh=gp49bwxlp/PxlJHwkVMdcAzBdelX+CGPSzAgbUQS+yI=;
 b=MkNnkKNY3SMuIzh9I1+CaqPXibe4Y6SFu/RHev5wMtDxmx46hQwiewmvu8xe0hyHkj
 3Bwe/aZ2+z3wTzDsqRdcIN16SE7ijKHRLsfVr+D6wf8c6X2SJEeO8k8LHZmiP0KKMLPm
 ysAK6Dn+wHkoQ1cs8sTlOwa1RDFg5btXjup/IY85L+jqZMAcTK808psi8NP8lZfEJKI8
 Kxa+hpV/S63fVJ6MGBvSTj0LtJCqKyfkgPw3GSuoDJG7Hl/ygJ5w8B0G1VL+srlrGLIl
 V3iLGV7B9buCj117dAfbFliPrlvFsLE/rar5VISR3m2QTVh/z+a9vccpJdcv5VTbOav3
 tEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:cc;
 bh=gp49bwxlp/PxlJHwkVMdcAzBdelX+CGPSzAgbUQS+yI=;
 b=SAFqKT4aWyinpWfMI2tUoAAPSK1igNBGTRIDjk3FKqE7lHovPaUNmPPdQugs/5XMrw
 M3yE9MUHLnNN/ja4UXS2HPCL3du/IoMQPfbPl+YAhPgnuyjxjkR6tvH3syoVNpjfFQQl
 m3m2WA+Qqi5iciFJNDXCRR6phCQuHzGhD+7RUFB8bJl5DraoIDihxKv4pLeSwaIobISE
 Ghpqga/9ohhz5HHnXMoRvQxyxFWH7Q1M1Rl9Gdtg8yYnnP3bJchAlbbvCMU8IECH3Cck
 6p/V2D7x/0TtdKOyVcL1w17AGbByvOaVyc1VLy0Xr2DZwuVKlYsXLf/Eds0gziE+TmiW
 +CvA==
X-Gm-Message-State: AOAM530znxdty1a2LbO10Hjk8VzFTwDAi0gKxFK+SifjgsooTVOyzcBM
 0p06TBQTU+jAKic/1B0iUG0IQifYwrO2i3NKQg==
X-Google-Smtp-Source: ABdhPJzbU5qgK/xJ2/og1vwuImYwxkGHt49Sk4nprmPRXYFGNvbr/4dATjcU/VbMtNefMKAhz5O1nAC7mORp7a+Waw==
X-Received: from kaleshsingh.mtv.corp.google.com
 ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8684:0:b0:629:917:c5c with SMTP id
 z4-20020a258684000000b0062909170c5cmr8734183ybk.403.1646679225768; Mon, 07
 Mar 2022 10:53:45 -0800 (PST)
Date: Mon,  7 Mar 2022 10:49:05 -0800
In-Reply-To: <20220307184935.1704614-1-kaleshsingh@google.com>
Message-Id: <20220307184935.1704614-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
From: Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Walbran <qwandor@google.com>, will@kernel.org,
 Peter Collingbourne <pcc@google.com>, maz@kernel.org,
 linux-kernel@vger.kernel.org,
 "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
 Mark Brown <broonie@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-arm-kernel@lists.infradead.org, surenb@google.com,
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

Unwind the stack in EL1, when CONFIG_NVHE_EL2_DEBUG is enabled.
This is possible because CONFIG_NVHE_EL2_DEBUG disables the host
stage-2 protection on hyp_panic(), allowing the host to access
the hypervisor stack pages in EL1.

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

Changes in v4:
  - Update commit text and struct kvm_nvhe_panic_info kernel-doc comment
    to clarify that CONFIG_NVHE_EL2_DEBUG only disables the host stage-2
    protection on hyp_panic(), per Fuad
  - Update NVHE_EL2_DEBUG Kconfig description to clarify that the
    hypervisor stack trace is printed when hyp_panic() is called, per Fuad

Changes in v3:
  - The nvhe hyp stack unwinder now makes use of the core logic from the
    regular kernel unwinder to avoid duplication, per Mark

Changes in v2:
  - Add cpu_prepare_nvhe_panic_info()
  - Move updating the panic info to hyp_panic(), so that unwinding also
    works for conventional nVHE Hyp-mode.


 arch/arm64/include/asm/kvm_asm.h    |  20 +++
 arch/arm64/include/asm/stacktrace.h |  12 ++
 arch/arm64/kernel/stacktrace.c      | 210 +++++++++++++++++++++++++---
 arch/arm64/kvm/Kconfig              |   5 +-
 arch/arm64/kvm/arm.c                |   2 +-
 arch/arm64/kvm/handle_exit.c        |   3 +
 arch/arm64/kvm/hyp/nvhe/switch.c    |  18 +++
 7 files changed, 244 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2e277f2ed671..4abcf93c6662 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -176,6 +176,26 @@ struct kvm_nvhe_init_params {
 	unsigned long vtcr;
 };
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+/**
+ * struct kvm_nvhe_panic_info - nVHE hypervisor panic info.
+ * @hyp_stack_base:             hyp VA of the hyp_stack base.
+ * @hyp_overflow_stack_base:    hyp VA of the hyp_overflow_stack base.
+ * @fp:                         hyp FP where the backtrace begins.
+ * @pc:                         hyp PC where the backtrace begins.
+ *
+ * Used by the host in EL1 to dump the nVHE hypervisor backtrace on
+ * hyp_panic. This is possible because CONFIG_NVHE_EL2_DEBUG disables
+ * the host stage 2 protection on hyp_panic(). See: __hyp_do_panic()
+ */
+struct kvm_nvhe_panic_info {
+	unsigned long hyp_stack_base;
+	unsigned long hyp_overflow_stack_base;
+	unsigned long fp;
+	unsigned long pc;
+};
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index e77cdef9ca29..18611a51cf14 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -22,6 +22,10 @@ enum stack_type {
 	STACK_TYPE_OVERFLOW,
 	STACK_TYPE_SDEI_NORMAL,
 	STACK_TYPE_SDEI_CRITICAL,
+#ifdef CONFIG_NVHE_EL2_DEBUG
+	STACK_TYPE_KVM_NVHE_HYP,
+	STACK_TYPE_KVM_NVHE_OVERFLOW,
+#endif /* CONFIG_NVHE_EL2_DEBUG */
 	__NR_STACK_TYPES
 };
 
@@ -147,4 +151,12 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	return false;
 }
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+void kvm_nvhe_dump_backtrace(unsigned long hyp_offset);
+#else
+static inline void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e4103e085681..6ec85cb69b1f 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -15,6 +15,8 @@
 
 #include <asm/irq.h>
 #include <asm/pointer_auth.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -64,26 +66,15 @@ NOKPROBE_SYMBOL(start_backtrace);
  * records (e.g. a cycle), determined based on the location and fp value of A
  * and the location (but not the fp value) of B.
  */
-static int notrace unwind_frame(struct task_struct *tsk,
-				struct stackframe *frame)
+static int notrace __unwind_frame(struct stackframe *frame, struct stack_info *info,
+		unsigned long (*translate_fp)(unsigned long, enum stack_type))
 {
 	unsigned long fp = frame->fp;
-	struct stack_info info;
-
-	if (!tsk)
-		tsk = current;
-
-	/* Final frame; nothing to unwind */
-	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
-		return -ENOENT;
 
 	if (fp & 0x7)
 		return -EINVAL;
 
-	if (!on_accessible_stack(tsk, fp, 16, &info))
-		return -EINVAL;
-
-	if (test_bit(info.type, frame->stacks_done))
+	if (test_bit(info->type, frame->stacks_done))
 		return -EINVAL;
 
 	/*
@@ -94,28 +85,62 @@ static int notrace unwind_frame(struct task_struct *tsk,
 	 *
 	 * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
 	 * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
+	 * KVM_NVHE_HYP -> KVM_NVHE_OVERFLOW
 	 *
 	 * ... but the nesting itself is strict. Once we transition from one
 	 * stack to another, it's never valid to unwind back to that first
 	 * stack.
 	 */
-	if (info.type == frame->prev_type) {
+	if (info->type == frame->prev_type) {
 		if (fp <= frame->prev_fp)
 			return -EINVAL;
 	} else {
 		set_bit(frame->prev_type, frame->stacks_done);
 	}
 
+	/* Record fp as prev_fp before attempting to get the next fp */
+	frame->prev_fp = fp;
+
+	/*
+	 * If fp is not from the current address space perform the
+	 * necessary translation before dereferencing it to get next fp.
+	 */
+	if (translate_fp)
+		fp = translate_fp(fp, info->type);
+	if (!fp)
+		return -EINVAL;
+
 	/*
 	 * Record this frame record's values and location. The prev_fp and
-	 * prev_type are only meaningful to the next unwind_frame() invocation.
+	 * prev_type are only meaningful to the next __unwind_frame() invocation.
 	 */
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
-	frame->prev_fp = fp;
-	frame->prev_type = info.type;
-
 	frame->pc = ptrauth_strip_insn_pac(frame->pc);
+	frame->prev_type = info->type;
+
+	return 0;
+}
+
+static int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
+{
+	unsigned long fp = frame->fp;
+	struct stack_info info;
+	int err;
+
+	if (!tsk)
+		tsk = current;
+
+	/* Final frame; nothing to unwind */
+	if (fp == (unsigned long)task_pt_regs(tsk)->stackframe)
+		return -ENOENT;
+
+	if (!on_accessible_stack(tsk, fp, 16, &info))
+		return -EINVAL;
+
+	err = __unwind_frame(frame, &info, NULL);
+	if (err)
+		return err;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
@@ -143,20 +168,27 @@ static int notrace unwind_frame(struct task_struct *tsk,
 }
 NOKPROBE_SYMBOL(unwind_frame);
 
-static void notrace walk_stackframe(struct task_struct *tsk,
-				    struct stackframe *frame,
-				    bool (*fn)(void *, unsigned long), void *data)
+static void notrace __walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
+		bool (*fn)(void *, unsigned long), void *data,
+		int (*unwind_frame_fn)(struct task_struct *tsk, struct stackframe *frame))
 {
 	while (1) {
 		int ret;
 
 		if (!fn(data, frame->pc))
 			break;
-		ret = unwind_frame(tsk, frame);
+		ret = unwind_frame_fn(tsk, frame);
 		if (ret < 0)
 			break;
 	}
 }
+
+static void notrace walk_stackframe(struct task_struct *tsk,
+				    struct stackframe *frame,
+				    bool (*fn)(void *, unsigned long), void *data)
+{
+	__walk_stackframe(tsk, frame, fn, data, unwind_frame);
+}
 NOKPROBE_SYMBOL(walk_stackframe);
 
 static bool dump_backtrace_entry(void *arg, unsigned long where)
@@ -210,3 +242,135 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	walk_stackframe(task, &frame, consume_entry, cookie);
 }
+
+#ifdef CONFIG_NVHE_EL2_DEBUG
+DECLARE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DECLARE_KVM_NVHE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack);
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static inline bool kvm_nvhe_on_overflow_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_overflow_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_OVERFLOW, info);
+}
+
+static inline bool kvm_nvhe_on_hyp_stack(unsigned long sp, unsigned long size,
+				 struct stack_info *info)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long low = (unsigned long)panic_info->hyp_stack_base;
+	unsigned long high = low + PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_KVM_NVHE_HYP, info);
+}
+
+static inline bool kvm_nvhe_on_accessible_stack(unsigned long sp, unsigned long size,
+				       struct stack_info *info)
+{
+	if (info)
+		info->type = STACK_TYPE_UNKNOWN;
+
+	if (kvm_nvhe_on_hyp_stack(sp, size, info))
+		return true;
+	if (kvm_nvhe_on_overflow_stack(sp, size, info))
+		return true;
+
+	return false;
+}
+
+static unsigned long kvm_nvhe_hyp_stack_kern_va(unsigned long addr)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_stack_base;
+	hyp_offset = addr - hyp_base;
+
+	kern_base = (unsigned long)*this_cpu_ptr(&kvm_arm_hyp_stack_page);
+
+	return kern_base + hyp_offset;
+}
+
+static unsigned long kvm_nvhe_overflow_stack_kern_va(unsigned long addr)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	unsigned long hyp_base, kern_base, hyp_offset;
+
+	hyp_base = (unsigned long)panic_info->hyp_overflow_stack_base;
+	hyp_offset = addr - hyp_base;
+
+	kern_base = (unsigned long)this_cpu_ptr_nvhe_sym(hyp_overflow_stack);
+
+	return kern_base + hyp_offset;
+}
+
+/*
+ * Convert KVM nVHE hypervisor stack VA to a kernel VA.
+ *
+ * The nVHE hypervisor stack is mapped in the flexible 'private' VA range, to allow
+ * for guard pages below the stack. Consequently, the fixed offset address
+ * translation macros won't work here.
+ *
+ * The kernel VA is calculated as an offset from the kernel VA of the hypervisor
+ * stack base. See: kvm_nvhe_hyp_stack_kern_va(),  kvm_nvhe_overflow_stack_kern_va()
+ */
+static unsigned long kvm_nvhe_stack_kern_va(unsigned long addr,
+					enum stack_type type)
+{
+	switch (type) {
+	case STACK_TYPE_KVM_NVHE_HYP:
+		return kvm_nvhe_hyp_stack_kern_va(addr);
+	case STACK_TYPE_KVM_NVHE_OVERFLOW:
+		return kvm_nvhe_overflow_stack_kern_va(addr);
+	default:
+		return 0UL;
+	}
+}
+
+static int notrace kvm_nvhe_unwind_frame(struct task_struct *tsk,
+					struct stackframe *frame)
+{
+	struct stack_info info;
+
+	if (!kvm_nvhe_on_accessible_stack(frame->fp, 16, &info))
+		return -EINVAL;
+
+	return  __unwind_frame(frame, &info, kvm_nvhe_stack_kern_va);
+}
+
+static bool kvm_nvhe_dump_backtrace_entry(void *arg, unsigned long where)
+{
+	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
+	unsigned long hyp_offset = (unsigned long)arg;
+
+	where &= va_mask;	/* Mask tags */
+	where += hyp_offset;	/* Convert to kern addr */
+
+	kvm_err("[<%016lx>] %pB\n", where, (void *)where);
+
+	return true;
+}
+
+static void notrace kvm_nvhe_walk_stackframe(struct task_struct *tsk,
+				    struct stackframe *frame,
+				    bool (*fn)(void *, unsigned long), void *data)
+{
+	__walk_stackframe(tsk, frame, fn, data, kvm_nvhe_unwind_frame);
+}
+
+void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr_nvhe_sym(kvm_panic_info);
+	struct stackframe frame;
+
+	start_backtrace(&frame, panic_info->fp, panic_info->pc);
+	pr_err("nVHE HYP call trace:\n");
+	kvm_nvhe_walk_stackframe(NULL, &frame, kvm_nvhe_dump_backtrace_entry,
+					(void *)hyp_offset);
+	pr_err("---- end of nVHE HYP call trace ----\n");
+}
+#endif /* CONFIG_NVHE_EL2_DEBUG */
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..a7be4ef35fbf 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -51,8 +51,9 @@ config NVHE_EL2_DEBUG
 	depends on KVM
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
-	  Failure reports will BUG() in the hypervisor. This is intended for
-	  local EL2 hypervisor development.
+	  Failure reports will BUG() in the hypervisor; and calls to hyp_panic()
+	  will result in printing the hypervisor call stack.
+	  This is intended for local EL2 hypervisor development.
 
 	  If unsure, say N.
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index cc712e421c5a..3d9efcf4fbb5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -49,7 +49,7 @@ DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
-static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e3140abd2e2e..ff69dff33700 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -17,6 +17,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/debug-monitors.h>
+#include <asm/stacktrace.h>
 #include <asm/traps.h>
 
 #include <kvm/arm_hypercalls.h>
@@ -326,6 +327,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
 		kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
 	}
 
+	kvm_nvhe_dump_backtrace(hyp_offset);
+
 	/*
 	 * Hyp has panicked and we're going to handle that by panicking the
 	 * kernel. The kernel offset will be revealed in the panic so we're
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index efc20273a352..b8ecffc47424 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -37,6 +37,22 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 #ifdef CONFIG_NVHE_EL2_DEBUG
 DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], hyp_overflow_stack)
 	__aligned(16);
+DEFINE_PER_CPU(struct kvm_nvhe_panic_info, kvm_panic_info);
+
+static inline void cpu_prepare_nvhe_panic_info(void)
+{
+	struct kvm_nvhe_panic_info *panic_info = this_cpu_ptr(&kvm_panic_info);
+	struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
+
+	panic_info->hyp_stack_base = (unsigned long)(params->stack_hyp_va - PAGE_SIZE);
+	panic_info->hyp_overflow_stack_base = (unsigned long)this_cpu_ptr(hyp_overflow_stack);
+	panic_info->fp = (unsigned long)__builtin_frame_address(0);
+	panic_info->pc = _THIS_IP_;
+}
+ #else
+static inline void cpu_prepare_nvhe_panic_info(void)
+{
+}
 #endif
 
 static void __activate_traps(struct kvm_vcpu *vcpu)
@@ -360,6 +376,8 @@ asmlinkage void __noreturn hyp_panic(void)
 	struct kvm_cpu_context *host_ctxt;
 	struct kvm_vcpu *vcpu;
 
+	cpu_prepare_nvhe_panic_info();
+
 	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	vcpu = host_ctxt->__hyp_running_vcpu;
 
-- 
2.35.1.616.g0bdcbb4464-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
