Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 30F414D5B2F
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 07:02:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B38B849E37;
	Fri, 11 Mar 2022 01:02:35 -0500 (EST)
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
	with ESMTP id QXlep6vT5NcW; Fri, 11 Mar 2022 01:02:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEE0D40E00;
	Fri, 11 Mar 2022 01:02:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B22A540BDC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Mar 2022 01:02:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LpHHbnGFIHrz for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Mar 2022 01:02:28 -0500 (EST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E5ECD40C02
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Mar 2022 01:02:27 -0500 (EST)
Received: by mail-pj1-f74.google.com with SMTP id
 e14-20020a17090a684e00b001bf09ac2385so4736027pjm.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xPgQVfI2Y1I/KtRzUMNKCQIc7yU1OAIv+46ymAD0UPo=;
 b=G2sEVMECVrKhpuBCyJWirf6hhHYiGny9N+2jM2o16/Ud0JJmLBZUCI0QlXzrBAdwXf
 RtEA/T2uSBldDhq69glIdy23EBdOBpGdFFZcdlBAqoXkXgdOx3EssIMBB/E+FJ4x8zMZ
 4jWZ69krhpTz+te3T1e38wIMoE2RH19+/9gS9Z7CNo4t5If+Dnt+LZtXbCVHP7GMVp/n
 au7n7Ezu8eRoiqttpcflOaQl68DL6iDHgZvEK+B4GJlr3WCOccAi6YtxMG65DtYZ3DZv
 MWm7ChvNNzbzQqwf2qCKnuFVpmh7G5XNZomPZPepjT3CWVR2H3RnkVXMweCLUtuGd76n
 Kn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xPgQVfI2Y1I/KtRzUMNKCQIc7yU1OAIv+46ymAD0UPo=;
 b=M+vpsz5DKetwRajWlp3r4XESh2qxeBoNaBV38WMaveIU2uZ+IdX2BXgkzfwyky27CZ
 IL5IGbPhii8GNESipxMNJLdkS5L/tSWb/nJ4140m5v3mITFWS6adiVadgH+9Ug2iiOVj
 IM4s9veupYu2mAbUZjKkTAPph7EywaTjAiYjmUM3pxWP6FZAmDHH9Z70o9Ccbru4qG5R
 bLQ/R0/Um2AxFeqkom6MJuAzh+xlcL2nUcbal9dDXYOvfsknzJJ1RC/iwSC8gjPDxu0B
 OKkKtgXg4oExI/EyJL+yZXf0iypSwhp7RfSDUxjicvVTLNqnbZAFfGdbyNpMHOlUkvWM
 e2Pg==
X-Gm-Message-State: AOAM533q559xM+Z/m3/SDgRhW1Qee8JmjlNFsmK78BmVYzNTzUFC8/Kb
 D6y0MbtFkfOG9tnSjmPmw0+lmOzX0ymqFA==
X-Google-Smtp-Source: ABdhPJwiK2P1PitciFQTJDaWIirN71r4sXA6wmv6Mr37j6aMujc02xvgf7jF/CmCmMNQG2sXg6OyRkTWXDKDcw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a05:6a00:17a5:b0:4f6:f3fb:b6d8 with SMTP
 id s37-20020a056a0017a500b004f6f3fbb6d8mr8269665pfg.75.1646978547125; Thu, 10
 Mar 2022 22:02:27 -0800 (PST)
Date: Thu, 10 Mar 2022 22:02:06 -0800
In-Reply-To: <20220311060207.2438667-1-ricarkol@google.com>
Message-Id: <20220311060207.2438667-11-ricarkol@google.com>
Mime-Version: 1.0
References: <20220311060207.2438667-1-ricarkol@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 10/11] KVM: selftests: aarch64: Add readonly memslot tests
 into page_fault_test
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, drjones@redhat.com
Cc: maz@kernel.org, bgardon@google.com, pbonzini@redhat.com,
 axelrasmussen@google.com
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

Add some readonly memslot tests into page_fault_test. Mark the data
and/or page-table memslots as readonly, perform some accesses, and check
that the right fault is triggered when expected (e.g., a store with no
write-back should lead to an mmio exit).

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../selftests/kvm/aarch64/page_fault_test.c   | 303 +++++++++++++++++-
 1 file changed, 300 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index b41da9317242..e6607f903bc1 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -84,6 +84,7 @@ struct memslot_desc {
 
 static struct event_cnt {
 	int aborts;
+	int mmio_exits;
 	int fail_vcpu_runs;
 	int uffd_faults;
 	/* uffd_faults is incremented from multiple threads. */
@@ -101,6 +102,8 @@ struct test_desc {
 	int (*uffd_test_handler)(int mode, int uffd, struct uffd_msg *msg);
 	void (*dabt_handler)(struct ex_regs *regs);
 	void (*iabt_handler)(struct ex_regs *regs);
+	void (*mmio_handler)(struct kvm_run *run);
+	void (*fail_vcpu_run_handler)(int ret);
 	uint32_t pt_memslot_flags;
 	uint32_t test_memslot_flags;
 	void (*guest_pre_run)(struct kvm_vm *vm);
@@ -322,6 +325,20 @@ static void guest_code(struct test_desc *test)
 	GUEST_DONE();
 }
 
+static void dabt_s1ptw_on_ro_memslot_handler(struct ex_regs *regs)
+{
+	GUEST_ASSERT_EQ(read_sysreg(far_el1), GUEST_TEST_GVA);
+	events.aborts += 1;
+	GUEST_SYNC(CMD_RECREATE_PT_MEMSLOT_WR);
+}
+
+static void iabt_s1ptw_on_ro_memslot_handler(struct ex_regs *regs)
+{
+	GUEST_ASSERT_EQ(regs->pc, GUEST_TEST_EXEC_GVA);
+	events.aborts += 1;
+	GUEST_SYNC(CMD_RECREATE_PT_MEMSLOT_WR);
+}
+
 static void no_dabt_handler(struct ex_regs *regs)
 {
 	GUEST_ASSERT_1(false, read_sysreg(far_el1));
@@ -400,6 +417,57 @@ static void punch_hole_in_memslot(struct kvm_vm *vm,
 	}
 }
 
+static int __memory_region_add(struct kvm_vm *vm, void *mem, uint32_t slot,
+		uint32_t size, uint64_t guest_addr,
+		uint32_t flags)
+{
+	struct kvm_userspace_memory_region region;
+	int ret;
+
+	region.slot = slot;
+	region.flags = flags;
+	region.guest_phys_addr = guest_addr;
+	region.memory_size = size;
+	region.userspace_addr = (uintptr_t) mem;
+	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &region);
+
+	return ret;
+}
+
+static void recreate_memslot(struct kvm_vm *vm, struct memslot_desc *ms,
+		uint32_t flags)
+{
+	__memory_region_add(vm, ms->hva, ms->idx, 0, ms->gpa, 0);
+	__memory_region_add(vm, ms->hva, ms->idx, ms->size, ms->gpa, flags);
+}
+
+static void clear_pte_accessflag(struct kvm_vm *vm)
+{
+	volatile uint64_t *pte_hva;
+
+	pte_hva = (uint64_t *)addr_gpa2hva(vm, pte_gpa);
+	*pte_hva &= ~PTE_AF;
+}
+
+static void mmio_on_test_gpa_handler(struct kvm_run *run)
+{
+	ASSERT_EQ(run->mmio.phys_addr, memslot[TEST].gpa);
+
+	memcpy(memslot[TEST].hva, run->mmio.data, run->mmio.len);
+	events.mmio_exits += 1;
+}
+
+static void mmio_no_handler(struct kvm_run *run)
+{
+	uint64_t data;
+
+	memcpy(&data, run->mmio.data, sizeof(data));
+	pr_debug("addr=%lld len=%d w=%d data=%lx\n",
+			run->mmio.phys_addr, run->mmio.len,
+			run->mmio.is_write, data);
+	TEST_FAIL("There was no MMIO exit expected.");
+}
+
 static bool check_write_in_dirty_log(struct kvm_vm *vm,
 		struct memslot_desc *ms, uint64_t host_pg_nr)
 {
@@ -419,6 +487,8 @@ static void handle_cmd(struct kvm_vm *vm, int cmd)
 		punch_hole_in_memslot(vm, &memslot[PT]);
 	if (cmd & CMD_HOLE_TEST)
 		punch_hole_in_memslot(vm, &memslot[TEST]);
+	if (cmd & CMD_RECREATE_PT_MEMSLOT_WR)
+		recreate_memslot(vm, &memslot[PT], 0);
 	if (cmd & CMD_CHECK_WRITE_IN_DIRTY_LOG)
 		TEST_ASSERT(check_write_in_dirty_log(vm, &memslot[TEST], 0),
 				"Missing write in dirty log");
@@ -442,6 +512,13 @@ void fail_vcpu_run_no_handler(int ret)
 	TEST_FAIL("Unexpected vcpu run failure\n");
 }
 
+void fail_vcpu_run_mmio_no_syndrome_handler(int ret)
+{
+	TEST_ASSERT(errno == ENOSYS, "The mmio handler in the kernel"
+			" should have returned not implemented.");
+	events.fail_vcpu_runs += 1;
+}
+
 static uint64_t get_total_guest_pages(enum vm_guest_mode mode,
 		struct test_params *p)
 {
@@ -594,10 +671,21 @@ static void setup_uffd(enum vm_guest_mode mode, struct test_params *p,
 				test->uffd_test_handler);
 }
 
+static void setup_default_handlers(struct test_desc *test)
+{
+	if (!test->mmio_handler)
+		test->mmio_handler = mmio_no_handler;
+
+	if (!test->fail_vcpu_run_handler)
+		test->fail_vcpu_run_handler = fail_vcpu_run_no_handler;
+}
+
 static void check_event_counts(struct test_desc *test)
 {
 	ASSERT_EQ(test->expected_events.aborts,	events.aborts);
 	ASSERT_EQ(test->expected_events.uffd_faults, events.uffd_faults);
+	ASSERT_EQ(test->expected_events.mmio_exits, events.mmio_exits);
+	ASSERT_EQ(test->expected_events.fail_vcpu_runs, events.fail_vcpu_runs);
 }
 
 static void free_uffd(struct test_desc *test, struct uffd_desc **uffd)
@@ -629,12 +717,20 @@ static void reset_event_counts(void)
 
 static bool vcpu_run_loop(struct kvm_vm *vm, struct test_desc *test)
 {
+	struct kvm_run *run;
 	bool skip_test = false;
 	struct ucall uc;
-	int stage;
+	int stage, ret;
+
+	run = vcpu_state(vm, VCPU_ID);
 
 	for (stage = 0; ; stage++) {
-		vcpu_run(vm, VCPU_ID);
+		ret = _vcpu_run(vm, VCPU_ID);
+		if (ret) {
+			test->fail_vcpu_run_handler(ret);
+			pr_debug("Done.\n");
+			goto done;
+		}
 
 		switch (get_ucall(vm, VCPU_ID, &uc)) {
 		case UCALL_SYNC:
@@ -653,6 +749,10 @@ static bool vcpu_run_loop(struct kvm_vm *vm, struct test_desc *test)
 		case UCALL_DONE:
 			pr_debug("Done.\n");
 			goto done;
+		case UCALL_NONE:
+			if (run->exit_reason == KVM_EXIT_MMIO)
+				test->mmio_handler(run);
+			break;
 		default:
 			TEST_FAIL("Unknown ucall %lu", uc.cmd);
 		}
@@ -677,6 +777,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	ucall_init(vm, NULL);
 
 	reset_event_counts();
+	setup_abort_handlers(vm, test);
 	setup_memslots(vm, mode, p);
 
 	/*
@@ -687,7 +788,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	 */
 	load_exec_code_for_test();
 	setup_uffd(mode, p, uffd);
-	setup_abort_handlers(vm, test);
+	setup_default_handlers(test);
 	setup_guest_args(vm, test);
 
 	if (test->guest_pre_run)
@@ -875,6 +976,135 @@ int main(int argc, char *argv[])
 #define	TEST_S1PTW_AF_DIRTY_LOG(__a, ...)					\
 	TEST_S1PTW_DIRTY_LOG(__a, __AF_TEST_ARGS_FOR_DIRTY_LOG)
 
+#define	TEST_WRITE_ON_RO_MEMSLOT(__a, ...)					\
+{										\
+	.name			= SNAME(WRITE_ON_RO_MEMSLOT ## _ ## __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.mmio_handler		= mmio_on_test_gpa_handler,			\
+	.expected_events	= { .mmio_exits = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define	TEST_READ_ON_RO_MEMSLOT(__a, ...)					\
+{										\
+	.name			= SNAME(READ_ON_RO_MEMSLOT ## _ ## __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.expected_events	= { 0 },					\
+	__VA_ARGS__								\
+}
+
+#define	TEST_CM_ON_RO_MEMSLOT(__a, ...)						\
+{										\
+	.name			= SNAME(CM_ON_RO_MEMSLOT ## _ ## __a),		\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.fail_vcpu_run_handler	= fail_vcpu_run_mmio_no_syndrome_handler,	\
+	.expected_events	= { .fail_vcpu_runs = 1, },			\
+	__VA_ARGS__								\
+}
+
+#define __AF_TEST_IN_RO_MEMSLOT_ARGS						\
+	.guest_pre_run		= clear_pte_accessflag,				\
+	.guest_prepare		= { guest_set_ha, },				\
+	.guest_test_check	= { guest_check_pte_af, }
+
+#define __AF_LSE_IN_RO_MEMSLOT_ARGS						\
+	.guest_pre_run		= clear_pte_accessflag,				\
+	.guest_prepare		= { guest_set_ha, guest_check_lse, },		\
+	.guest_test_check	= { guest_check_pte_af, }
+
+#define	TEST_WRITE_ON_RO_MEMSLOT_AF(__a)					\
+	TEST_WRITE_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
+#define	TEST_READ_ON_RO_MEMSLOT_AF(__a)						\
+	TEST_READ_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
+#define	TEST_CM_ON_RO_MEMSLOT_AF(__a)						\
+	TEST_CM_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
+#define	TEST_S1PTW_ON_RO_MEMSLOT_DATA(__a, ...)					\
+{										\
+	.name			= SNAME(S1PTW_ON_RO_MEMSLOT_DATA ## _ ## __a),	\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.dabt_handler		= dabt_s1ptw_on_ro_memslot_handler,		\
+	.expected_events	= { .aborts = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define	TEST_S1PTW_ON_RO_MEMSLOT_EXEC(__a, ...)					\
+{										\
+	.name			= SNAME(S1PTW_ON_RO_MEMSLOT_EXEC ## _ ## __a),	\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.iabt_handler		= iabt_s1ptw_on_ro_memslot_handler,		\
+	.expected_events	= { .aborts = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(__a)					\
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
+#define	TEST_S1PTW_AF_ON_RO_MEMSLOT_EXEC(__a)					\
+	TEST_S1PTW_ON_RO_MEMSLOT_EXEC(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
+#define	TEST_WRITE_AND_S1PTW_ON_RO_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SCAT(WRITE_AND_S1PTW_ON_RO_MEMSLOT, __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.mmio_handler		= mmio_on_test_gpa_handler,			\
+	.dabt_handler		= dabt_s1ptw_on_ro_memslot_handler,		\
+	.expected_events	= { .mmio_exits = 1, .aborts = 1, },		\
+	__VA_ARGS__								\
+}
+
+#define	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SCAT(READ_AND_S1PTW_ON_RO_MEMSLOT, __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.dabt_handler		= dabt_s1ptw_on_ro_memslot_handler,		\
+	.expected_events	= { .aborts = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SCAT(CM_AND_S1PTW_ON_RO_MEMSLOT, __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.dabt_handler		= dabt_s1ptw_on_ro_memslot_handler,		\
+	.fail_vcpu_run_handler	= fail_vcpu_run_mmio_no_syndrome_handler,	\
+	.expected_events	= { .aborts = 1, .fail_vcpu_runs = 1 },		\
+	__VA_ARGS__								\
+}
+
+#define	TEST_EXEC_AND_S1PTW_ON_RO_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SCAT(EXEC_AND_S1PTW_ON_RO_MEMSLOT, __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY,				\
+	.pt_memslot_flags	= KVM_MEM_READONLY,				\
+	.guest_test 		= __a,						\
+	.iabt_handler		= iabt_s1ptw_on_ro_memslot_handler,		\
+	.expected_events	= { .aborts = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define TEST_WRITE_AND_S1PTW_AF_ON_RO_MEMSLOT(__a) 				\
+	TEST_WRITE_AND_S1PTW_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+#define TEST_READ_AND_S1PTW_AF_ON_RO_MEMSLOT(__a) 				\
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+#define TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT(__a) 				\
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+#define TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT(__a) 				\
+	TEST_EXEC_AND_S1PTW_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
+
 static struct test_desc tests[] = {
 	/* Check that HW is setting the AF (sanity checks). */
 	TEST_HW_ACCESS_FLAG(guest_test_read64),
@@ -993,6 +1223,73 @@ static struct test_desc tests[] = {
 	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_exec,
 			uffd_test_read_handler, uffd_pt_write_handler),
 
+	/* Access on readonly memslot (sanity check). */
+	TEST_WRITE_ON_RO_MEMSLOT(guest_test_write64),
+	TEST_READ_ON_RO_MEMSLOT(guest_test_read64),
+	TEST_READ_ON_RO_MEMSLOT(guest_test_ld_preidx),
+	TEST_READ_ON_RO_MEMSLOT(guest_test_exec),
+	/*
+	 * CM and ld/st with pre-indexing don't have any syndrome.  And so
+	 * vcpu_run just fails; which is expected.
+	 */
+	TEST_CM_ON_RO_MEMSLOT(guest_test_dc_zva),
+	TEST_CM_ON_RO_MEMSLOT(guest_test_cas, __PREPARE_LSE_TEST_ARGS),
+	TEST_CM_ON_RO_MEMSLOT(guest_test_st_preidx),
+
+	/* Access on readonly memslot w/ non-faulting S1PTW w/ AF. */
+	TEST_WRITE_ON_RO_MEMSLOT_AF(guest_test_write64),
+	TEST_READ_ON_RO_MEMSLOT_AF(guest_test_read64),
+	TEST_READ_ON_RO_MEMSLOT_AF(guest_test_ld_preidx),
+	TEST_CM_ON_RO_MEMSLOT(guest_test_cas, __AF_LSE_IN_RO_MEMSLOT_ARGS),
+	TEST_CM_ON_RO_MEMSLOT_AF(guest_test_dc_zva),
+	TEST_CM_ON_RO_MEMSLOT_AF(guest_test_st_preidx),
+	TEST_READ_ON_RO_MEMSLOT_AF(guest_test_exec),
+
+	/*
+	 * S1PTW without AF on a readonly memslot. Note that even though this
+	 * page table walk does not actually write the access flag, it is still
+	 * considered a write, and therefore there is a fault.
+	 */
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_write64),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_read64),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_ld_preidx),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_cas, __PREPARE_LSE_TEST_ARGS),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_at),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_dc_zva),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_st_preidx),
+	TEST_S1PTW_ON_RO_MEMSLOT_EXEC(guest_test_exec),
+
+	/* S1PTW with AF on a readonly memslot. */
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_write64),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_read64),
+	TEST_S1PTW_ON_RO_MEMSLOT_DATA(guest_test_cas,
+			__AF_LSE_IN_RO_MEMSLOT_ARGS),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_ld_preidx),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_at),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_st_preidx),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_DATA(guest_test_dc_zva),
+	TEST_S1PTW_AF_ON_RO_MEMSLOT_EXEC(guest_test_exec),
+
+	/* Access on a RO memslot with S1PTW also on a RO memslot. */
+	TEST_WRITE_AND_S1PTW_ON_RO_MEMSLOT(guest_test_write64),
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT(guest_test_ld_preidx),
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT(guest_test_read64),
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(guest_test_cas,
+			__PREPARE_LSE_TEST_ARGS),
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(guest_test_dc_zva),
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(guest_test_st_preidx),
+	TEST_EXEC_AND_S1PTW_ON_RO_MEMSLOT(guest_test_exec),
+
+	/* Access on a RO memslot with S1PTW w/ AF also on a RO memslot. */
+	TEST_WRITE_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_write64),
+	TEST_READ_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_read64),
+	TEST_READ_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_ld_preidx),
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(guest_test_cas,
+			__AF_LSE_IN_RO_MEMSLOT_ARGS),
+	TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_dc_zva),
+	TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_st_preidx),
+	TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_exec),
+
 	{ 0 },
 };
 
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
