Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0CEA368BC8
	for <lists+kvmarm@lfdr.de>; Fri, 23 Apr 2021 06:04:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AB204B51C;
	Fri, 23 Apr 2021 00:04:06 -0400 (EDT)
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
	with ESMTP id o7qyi-Vz5P5p; Fri, 23 Apr 2021 00:04:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BB104B4F6;
	Fri, 23 Apr 2021 00:04:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6712B4B3BD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 00:04:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj+FC4HyYmek for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Apr 2021 00:04:02 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 175AF4B457
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 00:04:02 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 d8-20020a25eb080000b02904e6f038cad5so22540500ybs.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=YiVwtBVL/pOUXDA1kClnzHrI3XyPs8Rvvwwd0LrXoL4=;
 b=AkvMQr2HAbsRNL2vcxQ6E6RhfJu1qrPwlp1Q9SPuVbUfiTxzVIX06FZhzYs2Pgqu5V
 YE2zv+wuUCxKbWLsFgmnIMmnZz04ZXTTXYF8/x41miMA8kcSlio3KSYik7FbfITE0y2A
 KrcIofSeRqOMdwZTkJW6z0znihMokgEf7V17Plrp8fJRAPuS4lKt21VxcnbgMEsulhsv
 s2pBPNNgTS+0UphTDjJtF8U5mdP+AF72iM0PUmkKyLc3ksyCj/bkVw9JYzj+xqggU1lD
 yDFsEya/21cZJdgUC3LG2MheUkmlQbbkCCNLTM/8xmoIuYODjc2uIzHIpd7GQ9/DpxfD
 wumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=YiVwtBVL/pOUXDA1kClnzHrI3XyPs8Rvvwwd0LrXoL4=;
 b=jrUBSaED7gG8fvpAqDEMjQrJSusm+m7wLUiXrnkfhh8eilxQ5bOpQWtzuvDCD9XOnL
 AbzMQLonZFg78wJdWDEbuWqTOZwZt9S9N0Js5ky9twwO7tXh+EEFaE1dScYKkbU09Z3U
 bM5zvkNApOws+AI0zfWxOQPYw21/Uie1laNQHAt3vcW2rX3zuFjSOss6JUmTpO1B1RG9
 CgMCqZMgQhOjNpA6sCoK8M9W7WM3OWF4Cm5w98XrMQ59+xOz5EKH4VtLMt88C2oRmj87
 Qb3TKxwj/hHJ8AQDUB2D7tDmSB/Kw31dJx+GN6MyjiGsQzlxTnlr2TfI9UhaJwvdkA+s
 QpNQ==
X-Gm-Message-State: AOAM531ZQobP6n2CNZ3VGornLkLkGPUtaOB0pqZDobf29vzUmXXJbEcY
 PCsQBP0ILMwIPU+wgoAL0ZHvF6KWv7P0eQ==
X-Google-Smtp-Source: ABdhPJyFCWJFP9wUa3EEhaotFzFlHuSo2vPOiQWFas8rbajb6F+czhSpzglPQ3wUJRlNwXJKTz71oqDQPLlbQQ==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:9085:: with SMTP id
 t5mr1887813ybl.26.1619150641488; Thu, 22 Apr 2021 21:04:01 -0700 (PDT)
Date: Thu, 22 Apr 2021 21:03:49 -0700
In-Reply-To: <20210423040351.1132218-1-ricarkol@google.com>
Message-Id: <20210423040351.1132218-2-ricarkol@google.com>
Mime-Version: 1.0
References: <20210423040351.1132218-1-ricarkol@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 1/3] KVM: selftests: Add exception handling support for aarch64
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, pbonzini@redhat.com
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

Add the infrastructure needed to enable exception handling in aarch64
selftests. The exception handling defaults to an unhandled-exception
handler which aborts the test, just like x86. These handlers can be
overridden by calling vm_handle_exception with a (vector, error-code)
tuple. The unhandled exception reporting from the guest is done using
the new ucall UCALL_UNHANDLED.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 +-
 .../selftests/kvm/include/aarch64/processor.h |  69 ++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../selftests/kvm/lib/aarch64/handlers.S      | 104 ++++++++++++++++++
 .../selftests/kvm/lib/aarch64/processor.c     |  56 ++++++++++
 5 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/handlers.S

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4e548d7ab0ab..618c5903f478 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,7 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
-LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
+LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index b7fa0c8551db..5c902ad95c35 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -8,6 +8,7 @@
 #define SELFTEST_KVM_PROCESSOR_H
 
 #include "kvm_util.h"
+#include <linux/stringify.h>
 
 
 #define ARM64_CORE_REG(x) (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
@@ -18,6 +19,7 @@
 #define MAIR_EL1	3, 0, 10, 2, 0
 #define TTBR0_EL1	3, 0,  2, 0, 0
 #define SCTLR_EL1	3, 0,  1, 0, 0
+#define VBAR_EL1	3, 0, 12, 0, 0
 
 /*
  * Default MAIR
@@ -56,4 +58,71 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
 void aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
 			      struct kvm_vcpu_init *init, void *guest_code);
 
+struct ex_regs {
+	u64 pc;
+	u64 pstate;
+	u64 sp;
+	u64 lr;
+	u64 regs[31];
+};
+
+#define VECTOR_NUM	16
+
+enum {
+	VECTOR_SYNC_EL1_SP0,
+	VECTOR_IRQ_EL1_SP0,
+	VECTOR_FIQ_EL1_SP0,
+	VECTOR_ERROR_EL1_SP0,
+
+	VECTOR_SYNC_EL1,
+	VECTOR_IRQ_EL1,
+	VECTOR_FIQ_EL1,
+	VECTOR_ERROR_EL1,
+
+	VECTOR_SYNC_EL0_64,
+	VECTOR_IRQ_EL0_64,
+	VECTOR_FIQ_EL0_64,
+	VECTOR_ERROR_EL0_64,
+
+	VECTOR_SYNC_EL0_32,
+	VECTOR_IRQ_EL0_32,
+	VECTOR_FIQ_EL0_32,
+	VECTOR_ERROR_EL0_32,
+};
+
+/* Some common EC (Exception classes) */
+#define ESR_EC_ILLEGAL_INS	0x0e
+#define ESR_EC_SVC64		0x15
+#define ESR_EC_IABORT_EL1	0x21
+#define ESR_EC_DABORT_EL1	0x25
+#define ESR_EC_SERROR		0x2f
+#define ESR_EC_HW_BP_EL1	0x31
+#define ESR_EC_SSTEP_EL1	0x33
+#define ESR_EC_WP_EL1		0x35
+#define ESR_EC_BRK_INS		0x3C
+
+#define ESR_EC_NUM		64
+
+#define ESR_EC_SHIFT		26
+#define ESR_EC_MASK		0x3f
+
+void vm_init_descriptor_tables(struct kvm_vm *vm);
+void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid);
+void vm_handle_exception(struct kvm_vm *vm, int vector, int ec,
+			void (*handler)(struct ex_regs *));
+
+#define SPSR_D          (1 << 9)
+#define SPSR_SS         (1 << 21)
+
+#define write_sysreg(reg, val)						  \
+({									  \
+	asm volatile("msr "__stringify(reg)", %0" : : "r"(val));	  \
+})
+
+#define read_sysreg(reg)						  \
+({	u64 val;							  \
+	asm volatile("mrs %0, "__stringify(reg) : "=r"(val) : : "memory");\
+	val;								  \
+})
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bea4644d645d..7880929ea548 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -347,6 +347,7 @@ enum {
 	UCALL_SYNC,
 	UCALL_ABORT,
 	UCALL_DONE,
+	UCALL_UNHANDLED,
 };
 
 #define UCALL_MAX_ARGS 6
diff --git a/tools/testing/selftests/kvm/lib/aarch64/handlers.S b/tools/testing/selftests/kvm/lib/aarch64/handlers.S
new file mode 100644
index 000000000000..c920679b87c0
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/aarch64/handlers.S
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+.macro save_registers, el
+	stp	x28, x29, [sp, #-16]!
+	stp	x26, x27, [sp, #-16]!
+	stp	x24, x25, [sp, #-16]!
+	stp	x22, x23, [sp, #-16]!
+	stp	x20, x21, [sp, #-16]!
+	stp	x18, x19, [sp, #-16]!
+	stp	x16, x17, [sp, #-16]!
+	stp	x14, x15, [sp, #-16]!
+	stp	x12, x13, [sp, #-16]!
+	stp	x10, x11, [sp, #-16]!
+	stp	x8, x9, [sp, #-16]!
+	stp	x6, x7, [sp, #-16]!
+	stp	x4, x5, [sp, #-16]!
+	stp	x2, x3, [sp, #-16]!
+	stp	x0, x1, [sp, #-16]!
+
+	.if \el == 0
+	mrs	x1, sp_el0
+	.else
+	mov	x1, sp
+	.endif
+	stp	x1, lr, [sp, #-16]! /* SP, LR */
+
+	mrs	x1, elr_el1
+	mrs	x2, spsr_el1
+	stp	x1, x2, [sp, #-16]! /* PC, PSTATE */
+.endm
+
+.macro restore_registers, el
+	ldp	x1, x2, [sp], #16 /* PC, PSTATE */
+	msr	elr_el1, x1
+	msr	spsr_el1, x2
+
+	ldp	x1, lr, [sp], #16 /* SP, LR */
+	.if \el == 0
+	msr	sp_el0, x1
+	.endif
+
+	ldp	x0, x1, [sp], #16
+	ldp	x2, x3, [sp], #16
+	ldp	x4, x5, [sp], #16
+	ldp	x6, x7, [sp], #16
+	ldp	x8, x9, [sp], #16
+	ldp	x10, x11, [sp], #16
+	ldp	x12, x13, [sp], #16
+	ldp	x14, x15, [sp], #16
+	ldp	x16, x17, [sp], #16
+	ldp	x18, x19, [sp], #16
+	ldp	x20, x21, [sp], #16
+	ldp	x22, x23, [sp], #16
+	ldp	x24, x25, [sp], #16
+	ldp	x26, x27, [sp], #16
+	ldp	x28, x29, [sp], #16
+
+	eret
+.endm
+
+.pushsection ".entry.text", "ax"
+.balign 0x800
+.global vectors
+vectors:
+.popsection
+
+/*
+ * Build an exception handler for vector and append a jump to it into
+ * vectors (while making sure that it's 0x80 aligned).
+ */
+.macro HANDLER, el, label, vector
+handler\()\vector:
+	save_registers \el
+	mov	x0, sp
+	mov	x1, \vector
+	bl	route_exception
+	restore_registers \el
+
+.pushsection ".entry.text", "ax"
+.balign 0x80
+	b	handler\()\vector
+.popsection
+.endm
+
+.global ex_handler_code
+ex_handler_code:
+	HANDLER	1, sync, 0			// Synchronous EL1t
+	HANDLER	1, irq, 1			// IRQ EL1t
+	HANDLER	1, fiq, 2			// FIQ EL1t
+	HANDLER	1, error, 3			// Error EL1t
+
+	HANDLER	1, sync, 4			// Synchronous EL1h
+	HANDLER	1, irq, 5			// IRQ EL1h
+	HANDLER	1, fiq, 6			// FIQ EL1h
+	HANDLER	1, error, 7			// Error EL1h
+
+	HANDLER	0, sync, 8			// Synchronous 64-bit EL0
+	HANDLER	0, irq, 9			// IRQ 64-bit EL0
+	HANDLER	0, fiq, 10			// FIQ 64-bit EL0
+	HANDLER	0, error, 11			// Error 64-bit EL0
+
+	HANDLER	0, sync, 12			// Synchronous 32-bit EL0
+	HANDLER	0, irq, 13			// IRQ 32-bit EL0
+	HANDLER	0, fiq, 14			// FIQ 32-bit EL0
+	HANDLER	0, error, 15			// Error 32-bit EL0
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index cee92d477dc0..286305b561d8 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/compiler.h>
+#include <assert.h>
 
 #include "kvm_util.h"
 #include "../kvm_util_internal.h"
@@ -14,6 +15,8 @@
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR		0x180000
 #define DEFAULT_ARM64_GUEST_STACK_VADDR_MIN	0xac0000
 
+vm_vaddr_t exception_handlers;
+
 static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
 {
 	return (v + vm->page_size) & ~(vm->page_size - 1);
@@ -336,4 +339,57 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 
 void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
 {
+	struct ucall uc;
+
+	if (get_ucall(vm, vcpuid, &uc) == UCALL_UNHANDLED) {
+		TEST_ASSERT(false,
+			"Unexpected exception guest (vector:0x%lx, ec:0x%lx)",
+			uc.args[0], uc.args[1]);
+	}
+}
+
+void kvm_exit_unexpected_vector(int vector, uint64_t ec)
+{
+	ucall(UCALL_UNHANDLED, 2, vector, ec);
+}
+
+#define HANDLERS_IDX(_vector, _ec)	((_vector * ESR_EC_NUM) + _ec)
+
+void vm_init_descriptor_tables(struct kvm_vm *vm)
+{
+	vm->handlers = vm_vaddr_alloc(vm,
+			VECTOR_NUM * ESR_EC_NUM * sizeof(void *),
+			vm->page_size, 0, 0);
+	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
+}
+
+void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	extern char vectors;
+
+	set_reg(vm, vcpuid, ARM64_SYS_REG(VBAR_EL1), (uint64_t)&vectors);
+}
+
+void route_exception(struct ex_regs *regs, int vector)
+{
+	typedef void(*handler)(struct ex_regs *);
+	uint64_t esr = read_sysreg(esr_el1);
+	uint64_t ec = (esr >> ESR_EC_SHIFT) & ESR_EC_MASK;
+
+	handler *handlers = (handler *)exception_handlers;
+
+	if (handlers && handlers[HANDLERS_IDX(vector, ec)])
+		handlers[HANDLERS_IDX(vector, ec)](regs);
+	else
+		kvm_exit_unexpected_vector(vector, ec);
+}
+
+void vm_handle_exception(struct kvm_vm *vm, int vector, int ec,
+			 void (*handler)(struct ex_regs *))
+{
+	vm_vaddr_t *handlers = (vm_vaddr_t *)addr_gva2hva(vm, vm->handlers);
+
+	assert(vector < VECTOR_NUM);
+	assert(ec < ESR_EC_NUM);
+	handlers[HANDLERS_IDX(vector, ec)] = (vm_vaddr_t)handler;
 }
-- 
2.31.1.498.g6c1eba8ee3d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
