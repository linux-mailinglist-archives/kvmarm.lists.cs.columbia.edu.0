Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9737F05D
	for <lists+kvmarm@lfdr.de>; Thu, 13 May 2021 02:28:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1EAB4B378;
	Wed, 12 May 2021 20:28:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUt+QPqqeuaN; Wed, 12 May 2021 20:28:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B0A074B84C;
	Wed, 12 May 2021 20:28:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 047964B85E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 20:28:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzOIS8uFFBe4 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 May 2021 20:28:14 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1CCDB4B857
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 20:28:14 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 l35-20020a635b630000b029020f1edbc5dfso15469668pgm.22
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=W+z6ph43WEoqzK/h0XR5xPv+BQTmvSnsoISA0GsP8mc=;
 b=KSRHUT0CZchN8QDX+Qmq4o6cKbn5IRF7Mqms8ZRwiWGv/lsLoGylG0Ar42dLWCrfb/
 3JflgbqhixbfCSBVY4NQnE9fDc6bhi72GysQzbUvKWJ31WmAbjWLHPG7xGUtMvCt4HSG
 7nT2M12ug8i4/dzTvnlojJeqWvVYw822llHB213vSxS3IXLbREzQzBxRghazwNed/PVu
 GmduMsJRIXQQlK7UE9PgxuRAPANS+hD5Z9z2FKwqCOm6OMkgCQQnWaj4CAjBA2Sur3pV
 +r1p1RJJeso5r+u35Ew0UJEaiWJV817boBKFaBigld6an3iZGQQ7qzUksyOhfsDiaUKi
 9GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=W+z6ph43WEoqzK/h0XR5xPv+BQTmvSnsoISA0GsP8mc=;
 b=MfQp0J4fLe0rJP+tLU+izhg9m5UltTcccqTFUv5K8uLWUdns2D7F52crjKh4a0qVW+
 7zaB14oDMkMPuMoY6WmOYLEVRlbaLupcNN4ReQIlmzHTi6GHspWj0dcMcQqPQvAVbLDI
 xYN11cDuYBlmP+NpCkVzteSbj7bpaXvCzMBcKBLKeyg/n61moDuA84Mi2T7fW31FDZSe
 jH7ernT0zzXSY+gRD003K4ZM2SRNE/yni40YTt6xKR0148YLhqXE6ri59D+C+76bEd9e
 6PsYfGNOzUS0JRlKC0nzBrC+qvfDAUqfqmDYDYSVK0Ixfdcatu9wiD18Tz9W102NdWcu
 nvgQ==
X-Gm-Message-State: AOAM533beOSiNYriDaDbRddrRSCq95psixm+OVRW3JLgo+ZirTIy6P/r
 814olX/HW6+emzxAsfVbwgiI5Njid7YyYg==
X-Google-Smtp-Source: ABdhPJw09k+v45DCOrkklD3IrTc/H+4DaLy55rV+eRCbsm8LTN+FOp02MZluXl2JNqbZrRyQ+g5GCx43xaJJJw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:90a:7f83:: with SMTP id
 m3mr15750pjl.0.1620865692836; Wed, 12 May 2021 17:28:12 -0700 (PDT)
Date: Wed, 12 May 2021 17:28:02 -0700
In-Reply-To: <20210513002802.3671838-1-ricarkol@google.com>
Message-Id: <20210513002802.3671838-6-ricarkol@google.com>
Mime-Version: 1.0
References: <20210513002802.3671838-1-ricarkol@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v3 5/5] KVM: selftests: Add aarch64/debug-exceptions test
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

Covers fundamental tests for debug exceptions. The guest installs and
handle its debug exceptions itself, without KVM_SET_GUEST_DEBUG.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/debug-exceptions.c  | 250 ++++++++++++++++++
 .../selftests/kvm/include/aarch64/processor.h |  22 +-
 4 files changed, 268 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/debug-exceptions.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index e65d5572aefc..f09ed908422b 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+/aarch64/debug-exceptions
 /aarch64/get-reg-list
 /aarch64/get-reg-list-sve
 /aarch64/vgic_init
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 618c5903f478..2f92442c0cc9 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -73,6 +73,7 @@ TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 
+TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
new file mode 100644
index 000000000000..51c42ac24dca
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_util.h>
+#include <kvm_util.h>
+#include <processor.h>
+
+#define VCPU_ID 0
+
+#define MDSCR_KDE	(1 << 13)
+#define MDSCR_MDE	(1 << 15)
+#define MDSCR_SS	(1 << 0)
+
+#define DBGBCR_LEN8	(0xff << 5)
+#define DBGBCR_EXEC	(0x0 << 3)
+#define DBGBCR_EL1	(0x1 << 1)
+#define DBGBCR_E	(0x1 << 0)
+
+#define DBGWCR_LEN8	(0xff << 5)
+#define DBGWCR_RD	(0x1 << 3)
+#define DBGWCR_WR	(0x2 << 3)
+#define DBGWCR_EL1	(0x1 << 1)
+#define DBGWCR_E	(0x1 << 0)
+
+#define SPSR_D		(1 << 9)
+#define SPSR_SS		(1 << 21)
+
+extern unsigned char sw_bp, hw_bp, bp_svc, bp_brk, hw_wp, ss_start;
+static volatile uint64_t sw_bp_addr, hw_bp_addr;
+static volatile uint64_t wp_addr, wp_data_addr;
+static volatile uint64_t svc_addr;
+static volatile uint64_t ss_addr[4], ss_idx;
+#define  PC(v)  ((uint64_t)&(v))
+
+static void reset_debug_state(void)
+{
+	asm volatile("msr daifset, #8");
+
+	write_sysreg(osdlr_el1, 0);
+	write_sysreg(oslar_el1, 0);
+	isb();
+
+	write_sysreg(mdscr_el1, 0);
+	/* This test only uses the first bp and wp slot. */
+	write_sysreg(dbgbvr0_el1, 0);
+	write_sysreg(dbgbcr0_el1, 0);
+	write_sysreg(dbgwcr0_el1, 0);
+	write_sysreg(dbgwvr0_el1, 0);
+	isb();
+}
+
+static void install_wp(uint64_t addr)
+{
+	uint32_t wcr;
+	uint32_t mdscr;
+
+	wcr = DBGWCR_LEN8 | DBGWCR_RD | DBGWCR_WR | DBGWCR_EL1 | DBGWCR_E;
+	write_sysreg(dbgwcr0_el1, wcr);
+	write_sysreg(dbgwvr0_el1, addr);
+	isb();
+
+	asm volatile("msr daifclr, #8");
+
+	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_MDE;
+	write_sysreg(mdscr_el1, mdscr);
+	isb();
+}
+
+static void install_hw_bp(uint64_t addr)
+{
+	uint32_t bcr;
+	uint32_t mdscr;
+
+	bcr = DBGBCR_LEN8 | DBGBCR_EXEC | DBGBCR_EL1 | DBGBCR_E;
+	write_sysreg(dbgbcr0_el1, bcr);
+	write_sysreg(dbgbvr0_el1, addr);
+	isb();
+
+	asm volatile("msr daifclr, #8");
+
+	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_MDE;
+	write_sysreg(mdscr_el1, mdscr);
+	isb();
+}
+
+static void install_ss(void)
+{
+	uint32_t mdscr;
+
+	asm volatile("msr daifclr, #8");
+
+	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_SS;
+	write_sysreg(mdscr_el1, mdscr);
+	isb();
+}
+
+static volatile char write_data;
+
+static void guest_code(void)
+{
+	GUEST_SYNC(0);
+
+	/* Software-breakpoint */
+	asm volatile("sw_bp: brk #0");
+	GUEST_ASSERT_EQ(sw_bp_addr, PC(sw_bp));
+
+	GUEST_SYNC(1);
+
+	/* Hardware-breakpoint */
+	reset_debug_state();
+	install_hw_bp(PC(hw_bp));
+	asm volatile("hw_bp: nop");
+	GUEST_ASSERT_EQ(hw_bp_addr, PC(hw_bp));
+
+	GUEST_SYNC(2);
+
+	/* Hardware-breakpoint + svc */
+	reset_debug_state();
+	install_hw_bp(PC(bp_svc));
+	asm volatile("bp_svc: svc #0");
+	GUEST_ASSERT_EQ(hw_bp_addr, PC(bp_svc));
+	GUEST_ASSERT_EQ(svc_addr, PC(bp_svc) + 4);
+
+	GUEST_SYNC(3);
+
+	/* Hardware-breakpoint + software-breakpoint */
+	reset_debug_state();
+	install_hw_bp(PC(bp_brk));
+	asm volatile("bp_brk: brk #0");
+	GUEST_ASSERT_EQ(sw_bp_addr, PC(bp_brk));
+	GUEST_ASSERT_EQ(hw_bp_addr, PC(bp_brk));
+
+	GUEST_SYNC(4);
+
+	/* Watchpoint */
+	reset_debug_state();
+	install_wp(PC(write_data));
+	write_data = 'x';
+	GUEST_ASSERT_EQ(write_data, 'x');
+	GUEST_ASSERT_EQ(wp_data_addr, PC(write_data));
+
+	GUEST_SYNC(5);
+
+	/* Single-step */
+	reset_debug_state();
+	install_ss();
+	ss_idx = 0;
+	asm volatile("ss_start:\n"
+		     "mrs x0, esr_el1\n"
+		     "add x0, x0, #1\n"
+		     "msr daifset, #8\n"
+		     : : : "x0");
+	GUEST_ASSERT_EQ(ss_addr[0], PC(ss_start));
+	GUEST_ASSERT_EQ(ss_addr[1], PC(ss_start) + 4);
+	GUEST_ASSERT_EQ(ss_addr[2], PC(ss_start) + 8);
+
+	GUEST_DONE();
+}
+
+static void guest_sw_bp_handler(struct ex_regs *regs)
+{
+	sw_bp_addr = regs->pc;
+	regs->pc += 4;
+}
+
+static void guest_hw_bp_handler(struct ex_regs *regs)
+{
+	hw_bp_addr = regs->pc;
+	regs->pstate |= SPSR_D;
+}
+
+static void guest_wp_handler(struct ex_regs *regs)
+{
+	wp_data_addr = read_sysreg(far_el1);
+	wp_addr = regs->pc;
+	regs->pstate |= SPSR_D;
+}
+
+static void guest_ss_handler(struct ex_regs *regs)
+{
+	GUEST_ASSERT_1(ss_idx < 4, ss_idx);
+	ss_addr[ss_idx++] = regs->pc;
+	regs->pstate |= SPSR_SS;
+}
+
+static void guest_svc_handler(struct ex_regs *regs)
+{
+	svc_addr = regs->pc;
+}
+
+static int debug_version(struct kvm_vm *vm)
+{
+	uint64_t id_aa64dfr0;
+
+	get_reg(vm, VCPU_ID, ARM64_SYS_REG(ID_AA64DFR0_EL1), &id_aa64dfr0);
+	return id_aa64dfr0 & 0xf;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int stage;
+
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	ucall_init(vm, NULL);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vm, VCPU_ID);
+
+	if (debug_version(vm) < 6) {
+		print_skip("Armv8 debug architecture not supported.");
+		kvm_vm_free(vm);
+		exit(KSFT_SKIP);
+	}
+
+	vm_install_exception_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_EC_BRK_INS, guest_sw_bp_handler);
+	vm_install_exception_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_EC_HW_BP_CURRENT, guest_hw_bp_handler);
+	vm_install_exception_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_EC_WP_CURRENT, guest_wp_handler);
+	vm_install_exception_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_EC_SSTEP_CURRENT, guest_ss_handler);
+	vm_install_exception_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_EC_SVC64, guest_svc_handler);
+
+	for (stage = 0; stage < 7; stage++) {
+		vcpu_run(vm, VCPU_ID);
+
+		switch (get_ucall(vm, VCPU_ID, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT(uc.args[1] == stage,
+				"Stage %d: Unexpected sync ucall, got %lx",
+				stage, (ulong)uc.args[1]);
+			break;
+		case UCALL_ABORT:
+			TEST_FAIL("%s at %s:%ld\n\tvalues: %#lx, %#lx",
+				(const char *)uc.args[0],
+				__FILE__, uc.args[1], uc.args[2], uc.args[3]);
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index bc81cd62254f..1a3abe1037b0 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -14,12 +14,14 @@
 #define ARM64_CORE_REG(x) (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 			   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
-#define CPACR_EL1	3, 0,  1, 0, 2
-#define TCR_EL1		3, 0,  2, 0, 2
-#define MAIR_EL1	3, 0, 10, 2, 0
-#define TTBR0_EL1	3, 0,  2, 0, 0
-#define SCTLR_EL1	3, 0,  1, 0, 0
-#define VBAR_EL1	3, 0, 12, 0, 0
+#define CPACR_EL1               3, 0,  1, 0, 2
+#define TCR_EL1                 3, 0,  2, 0, 2
+#define MAIR_EL1                3, 0, 10, 2, 0
+#define TTBR0_EL1               3, 0,  2, 0, 0
+#define SCTLR_EL1               3, 0,  1, 0, 0
+#define VBAR_EL1                3, 0, 12, 0, 0
+
+#define ID_AA64DFR0_EL1         3, 0,  0, 5, 0
 
 /*
  * Default MAIR
@@ -98,6 +100,12 @@ enum {
 #define ESR_EC_SHIFT		26
 #define ESR_EC_MASK		(ESR_EC_NUM - 1)
 
+#define ESR_EC_SVC64		0x15
+#define ESR_EC_HW_BP_CURRENT	0x31
+#define ESR_EC_SSTEP_CURRENT	0x33
+#define ESR_EC_WP_CURRENT	0x35
+#define ESR_EC_BRK_INS		0x3c
+
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vcpu_init_descriptor_tables(struct kvm_vm *vm, uint32_t vcpuid);
 
@@ -119,4 +127,6 @@ void vm_install_vector_handler(struct kvm_vm *vm,
 	val;								  \
 })
 
+#define isb()	asm volatile("isb" : : : "memory")
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.31.1.607.g51e8a6a459-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
