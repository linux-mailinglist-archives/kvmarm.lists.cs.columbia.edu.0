Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9164E550131
	for <lists+kvmarm@lfdr.de>; Sat, 18 Jun 2022 02:16:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F165D4B3A1;
	Fri, 17 Jun 2022 20:16:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5vOKYwyivMm; Fri, 17 Jun 2022 20:16:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79B7E4B392;
	Fri, 17 Jun 2022 20:16:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD2F04B332
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 20:16:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57HHhbRR9ltk for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 20:16:24 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 52F5D4B091
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 20:16:24 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 u10-20020a17090a1d4a00b001e862680928so2548656pju.9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=x24stuE9YSyboRYsJii6qNmv/qseDJVnTIl1N3uVWIY=;
 b=nveVuzmF3sQ0gbGmsINjaNznnLouQ2m+5salJ7HtckJDEnTCLP+wgfaQNw7x/QhIWD
 6tgTCWqfAdQgQkiupgvHCRB7rGzB/R8HNChEKFdN0OjMjVAAbrAxENEKdmcbQ1DnTGeG
 nBpRVLs7MRlHec/SZmrAN2zzH4Mr3GVDDTuOyGc0g4sf5KUYa6lQcIK30WUMta+JmM4a
 Ck3cVj26J+ol7NrGI1+GYaG1rILSml+IWPklOyWJZrDWhBcL4ZodzxMbLYQ+1Z+eplHq
 ZBcMyQUDEEnnTGTtqYHb7bns1keg+OZTGEQGLFnpzfaHQ5+0VzkiGiI1lj9HiZPHM++j
 Mdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=x24stuE9YSyboRYsJii6qNmv/qseDJVnTIl1N3uVWIY=;
 b=8GquP6WW5H9HcGlT6FOcNnetFhKBqswrrVeKNDWAGqGr5x7zKawCJf8otRZRQ3W3B0
 U+CELPZpMI+FDWeZrCxnFrfDpbS0AGhbBFkY1NjpH2qvRZ5rTnNDNI8HGe9svZILbkoE
 VZ3+6r8svI0MFCWm2Km+BQKJftN2m0dac0J0qgx6DaoYXAxRIjR/nTjrpo6pV68lTiY2
 lw4CEXbctI7Bg8KeZSBQ0gr2nZhx//oIGJ08Lc7tHf2vGghZ/2M428Dms2+5T1LbGUkT
 OcC6ZCxrLaw724G8M/5449xD1lnnUpbUrpTTtw7C9VvGj8HAQV9PV3kuxoMtw530YkXS
 mIQg==
X-Gm-Message-State: AJIora+9wtt/GhWGBbSNxH+hTZGsMGeIVd95q28BQWNm/s0mshpbyM9D
 wlwD6bGhF4ftWudFPzkAUOYvIEHkowU=
X-Google-Smtp-Source: AGRyM1uib1+y64M6GwToUfWF/y2R6wxJKxiprp53SIrzZaUGweQrf10OahkjnXglWAqtnPNHr30UVofZlxQ=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2310:b0:1e8:8379:6098 with SMTP id
 mt16-20020a17090b231000b001e883796098mr13171732pjb.112.1655511383518; Fri, 17
 Jun 2022 17:16:23 -0700 (PDT)
Date: Sat, 18 Jun 2022 00:16:16 +0000
In-Reply-To: <20220618001618.1840806-1-seanjc@google.com>
Message-Id: <20220618001618.1840806-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220618001618.1840806-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH 1/3] KVM: selftests: Consolidate common code for popuplating
 ucall struct
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Make ucall() a common helper that populates struct ucall, and only calls
into arch code to make the actually call out to userspace.

Rename all arch-specific helpers to make it clear they're arch-specific,
and to avoid collisions with common helpers (one more on its way...)

No functional change intended.

Cc: Colton Lewis <coltonlewis@google.com>
Cc: Andrew Jones <drjones@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/ucall_common.h      | 23 ++++++++++++++++---
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 23 ++++---------------
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 23 ++++---------------
 tools/testing/selftests/kvm/lib/s390x/ucall.c | 23 ++++---------------
 .../testing/selftests/kvm/lib/ucall_common.c  | 20 ++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 23 ++++---------------
 7 files changed, 61 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b52c130f7b2f..bc2aee2af66c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -46,6 +46,7 @@ LIBKVM += lib/perf_test_util.c
 LIBKVM += lib/rbtree.c
 LIBKVM += lib/sparsebit.c
 LIBKVM += lib/test_util.c
+LIBKVM += lib/ucall_common.c
 
 LIBKVM_x86_64 += lib/x86_64/apic.c
 LIBKVM_x86_64 += lib/x86_64/handlers.S
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 98562f685151..c6a4fd7fe443 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -23,10 +23,27 @@ struct ucall {
 	uint64_t args[UCALL_MAX_ARGS];
 };
 
-void ucall_init(struct kvm_vm *vm, void *arg);
-void ucall_uninit(struct kvm_vm *vm);
+void ucall_arch_init(struct kvm_vm *vm, void *arg);
+void ucall_arch_uninit(struct kvm_vm *vm);
+void ucall_arch_do_ucall(vm_vaddr_t uc);
+uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
+
 void ucall(uint64_t cmd, int nargs, ...);
-uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
+
+static inline void ucall_init(struct kvm_vm *vm, void *arg)
+{
+	ucall_arch_init(vm, arg);
+}
+
+static inline void ucall_uninit(struct kvm_vm *vm)
+{
+	ucall_arch_uninit(vm);
+}
+
+static inline uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+{
+	return ucall_arch_get_ucall(vcpu, uc);
+}
 
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index 0b949ee06b5e..2de9fdd34159 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -21,7 +21,7 @@ static bool ucall_mmio_init(struct kvm_vm *vm, vm_paddr_t gpa)
 	return true;
 }
 
-void ucall_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, void *arg)
 {
 	vm_paddr_t gpa, start, end, step, offset;
 	unsigned int bits;
@@ -64,31 +64,18 @@ void ucall_init(struct kvm_vm *vm, void *arg)
 	TEST_FAIL("Can't find a ucall mmio address");
 }
 
-void ucall_uninit(struct kvm_vm *vm)
+void ucall_arch_uninit(struct kvm_vm *vm)
 {
 	ucall_exit_mmio_addr = 0;
 	sync_global_to_guest(vm, ucall_exit_mmio_addr);
 }
 
-void ucall(uint64_t cmd, int nargs, ...)
+void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
-	va_list va;
-	int i;
-
-	nargs = min(nargs, UCALL_MAX_ARGS);
-
-	va_start(va, nargs);
-	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
-	va_end(va);
-
-	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
+	*ucall_exit_mmio_addr = uc;
 }
 
-uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
 	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 087b9740bc8f..b1598f418c1f 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -10,11 +10,11 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-void ucall_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, void *arg)
 {
 }
 
-void ucall_uninit(struct kvm_vm *vm)
+void ucall_arch_uninit(struct kvm_vm *vm)
 {
 }
 
@@ -44,27 +44,14 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 	return ret;
 }
 
-void ucall(uint64_t cmd, int nargs, ...)
+void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
-	va_list va;
-	int i;
-
-	nargs = min(nargs, UCALL_MAX_ARGS);
-
-	va_start(va, nargs);
-	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
-	va_end(va);
-
 	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
 		  KVM_RISCV_SELFTESTS_SBI_UCALL,
-		  (vm_vaddr_t)&uc, 0, 0, 0, 0, 0);
+		  uc, 0, 0, 0, 0, 0);
 }
 
-uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
 	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 73dc4e21190f..114cb4af295f 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -6,34 +6,21 @@
  */
 #include "kvm_util.h"
 
-void ucall_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, void *arg)
 {
 }
 
-void ucall_uninit(struct kvm_vm *vm)
+void ucall_arch_uninit(struct kvm_vm *vm)
 {
 }
 
-void ucall(uint64_t cmd, int nargs, ...)
+void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
-	va_list va;
-	int i;
-
-	nargs = min(nargs, UCALL_MAX_ARGS);
-
-	va_start(va, nargs);
-	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
-	va_end(va);
-
 	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
-	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
+	asm volatile ("diag 0,%0,0x501" : : "a"(uc) : "memory");
 }
 
-uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
 	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
new file mode 100644
index 000000000000..749ffdf23855
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "kvm_util.h"
+
+void ucall(uint64_t cmd, int nargs, ...)
+{
+	struct ucall uc = {
+		.cmd = cmd,
+	};
+	va_list va;
+	int i;
+
+	nargs = min(nargs, UCALL_MAX_ARGS);
+
+	va_start(va, nargs);
+	for (i = 0; i < nargs; ++i)
+		uc.args[i] = va_arg(va, uint64_t);
+	va_end(va);
+
+	ucall_arch_do_ucall((vm_vaddr_t)&uc);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index e5f0f9e0d3ee..9f532dba1003 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -8,34 +8,21 @@
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
-void ucall_init(struct kvm_vm *vm, void *arg)
+void ucall_arch_init(struct kvm_vm *vm, void *arg)
 {
 }
 
-void ucall_uninit(struct kvm_vm *vm)
+void ucall_arch_uninit(struct kvm_vm *vm)
 {
 }
 
-void ucall(uint64_t cmd, int nargs, ...)
+void ucall_arch_do_ucall(vm_vaddr_t uc)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
-	va_list va;
-	int i;
-
-	nargs = min(nargs, UCALL_MAX_ARGS);
-
-	va_start(va, nargs);
-	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
-	va_end(va);
-
 	asm volatile("in %[port], %%al"
-		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax", "memory");
+		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
+uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 {
 	struct kvm_run *run = vcpu->run;
 	struct ucall ucall = {};
-- 
2.37.0.rc0.104.g0611611a94-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
