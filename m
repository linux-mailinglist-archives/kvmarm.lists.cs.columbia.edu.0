Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE14D5B2C
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 07:02:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF12449EE8;
	Fri, 11 Mar 2022 01:02:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSMn+C6M7LgE; Fri, 11 Mar 2022 01:02:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51A3C49E5F;
	Fri, 11 Mar 2022 01:02:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D34F40FB2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Mar 2022 01:02:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwgwHZJLLxBe for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Mar 2022 01:02:25 -0500 (EST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 030C840CDE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Mar 2022 01:02:25 -0500 (EST)
Received: by mail-pl1-f201.google.com with SMTP id
 j9-20020a170903024900b0015195e68490so4002702plh.19
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 22:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=alEF4uVy3MKXE24ouehI1MHV6RHYI67VpMz3Zfm+ONs=;
 b=a17s5aFrzaiqb1z7opXV82rLA2vSvLZNXNuq37ak2Qvx28RsT/omtU9iGPs3lhqeCR
 wtAJb016pv3gN3L9yD6V0Hl3cxRHTRj98Vl6tTfWv5EFBg3HqCiI2N/v0Udh8rU3KI9u
 SOEHfUyCjaatotJHKN4bpSNJF2sUztpRyOd6FtqlB8e46KtZW2zmvpA1YRwTrQbsUrLh
 26W10aSvsfvdj0abidkAAggZhUy4CZsIgOIHhr2MIsvKasAp5T6X6MWtNqBjxTB7s/V+
 V3GZp5LTrLixyWIDKSGuP4xbZMAncTbOB0c+79EhPVcyh5IGjSYmsH6DI2N5XEKrbzMH
 n01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=alEF4uVy3MKXE24ouehI1MHV6RHYI67VpMz3Zfm+ONs=;
 b=gzzsSfQhETxP8p1sB9QX9eTrKYWwD52a4U0mMtK2WdFGx1Okd+y3RhUbhasAJyzZrA
 WOFGfQ/GAo3IC2cEWe1/I9N7M7A6q8xRakVmIJBKj0dPGFwNJM6/UuqGv3WsCpq4C6xp
 P0H+rbAXNDMOZB6hk3dE37eW1HIFjd4Ebn2VH/YYu4mDE5NipJFt+s7oCNG8YitbNo8U
 JMC9oWgyn+2wtjIaoV2tT52Jr34nF9U08m56rBQcwXWt+NZnCB28IIAyRdW0YgAwvYfQ
 wazXc2etcpJPjRIzbJ82KgYQXL0X3BZ1GUzS5Ub8piJlWxKLhe6TzfQsq0/2d+X8aAX4
 jUDA==
X-Gm-Message-State: AOAM530xUkOw36dWFvcW/wl/7YWmkjjRQq8m8wPfrMsDa4nv2nOoTabC
 Y9dWgnm/dZHPXhAWZKwHznq0ct2jqzORDA==
X-Google-Smtp-Source: ABdhPJznL/it5YOK+KY5NGPo/3x1bNZC6rgXgXoGw2xSri2UThyOu3yVtmktdqOQuvf/jkK5wHWwutFyWm6C7Q==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a05:6a02:19a:b0:378:4f44:b1da with SMTP
 id bj26-20020a056a02019a00b003784f44b1damr7101775pgb.568.1646978544281; Thu,
 10 Mar 2022 22:02:24 -0800 (PST)
Date: Thu, 10 Mar 2022 22:02:04 -0800
In-Reply-To: <20220311060207.2438667-1-ricarkol@google.com>
Message-Id: <20220311060207.2438667-9-ricarkol@google.com>
Mime-Version: 1.0
References: <20220311060207.2438667-1-ricarkol@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 08/11] KVM: selftests: aarch64: Add userfaultfd tests into
 page_fault_test
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

Add some userfaultfd tests into page_fault_test. Punch holes into the
data and/or page-table memslots, perform some accesses, and check that
the faults are taken (or not taken) when expected.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../selftests/kvm/aarch64/page_fault_test.c   | 232 +++++++++++++++++-
 1 file changed, 229 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 00477a4f10cb..99449eaddb2b 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -57,6 +57,8 @@ uint64_t pte_gpa;
 enum { PT, TEST, NR_MEMSLOTS};
 
 struct memslot_desc {
+	size_t paging_size;
+	char *data_copy;
 	void *hva;
 	uint64_t gpa;
 	uint64_t size;
@@ -78,6 +80,9 @@ struct memslot_desc {
 static struct event_cnt {
 	int aborts;
 	int fail_vcpu_runs;
+	int uffd_faults;
+	/* uffd_faults is incremented from multiple threads. */
+	pthread_mutex_t uffd_faults_mutex;
 } events;
 
 struct test_desc {
@@ -87,6 +92,8 @@ struct test_desc {
 	bool (*guest_prepare[PREPARE_FN_NR])(void);
 	void (*guest_test)(void);
 	void (*guest_test_check[CHECK_FN_NR])(void);
+	int (*uffd_pt_handler)(int mode, int uffd, struct uffd_msg *msg);
+	int (*uffd_test_handler)(int mode, int uffd, struct uffd_msg *msg);
 	void (*dabt_handler)(struct ex_regs *regs);
 	void (*iabt_handler)(struct ex_regs *regs);
 	uint32_t pt_memslot_flags;
@@ -305,6 +312,56 @@ static void no_iabt_handler(struct ex_regs *regs)
 	GUEST_ASSERT_1(false, regs->pc);
 }
 
+static int uffd_generic_handler(int uffd_mode, int uffd,
+		struct uffd_msg *msg, struct memslot_desc *memslot,
+		bool expect_write)
+{
+	uint64_t addr = msg->arg.pagefault.address;
+	uint64_t flags = msg->arg.pagefault.flags;
+	struct uffdio_copy copy;
+	int ret;
+
+	TEST_ASSERT(uffd_mode == UFFDIO_REGISTER_MODE_MISSING,
+			"The only expected UFFD mode is MISSING");
+	ASSERT_EQ(!!(flags & UFFD_PAGEFAULT_FLAG_WRITE), expect_write);
+	ASSERT_EQ(addr, (uint64_t)memslot->hva);
+
+	pr_debug("uffd fault: addr=%p write=%d\n",
+			(void *)addr, !!(flags & UFFD_PAGEFAULT_FLAG_WRITE));
+
+	copy.src = (uint64_t)memslot->data_copy;
+	copy.dst = addr;
+	copy.len = memslot->paging_size;
+	copy.mode = 0;
+
+	ret = ioctl(uffd, UFFDIO_COPY, &copy);
+	if (ret == -1) {
+		pr_info("Failed UFFDIO_COPY in 0x%lx with errno: %d\n",
+				addr, errno);
+		return ret;
+	}
+
+	pthread_mutex_lock(&events.uffd_faults_mutex);
+	events.uffd_faults += 1;
+	pthread_mutex_unlock(&events.uffd_faults_mutex);
+	return 0;
+}
+
+static int uffd_pt_write_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	return uffd_generic_handler(mode, uffd, msg, &memslot[PT], true);
+}
+
+static int uffd_test_write_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	return uffd_generic_handler(mode, uffd, msg, &memslot[TEST], true);
+}
+
+static int uffd_test_read_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	return uffd_generic_handler(mode, uffd, msg, &memslot[TEST], false);
+}
+
 static void punch_hole_in_memslot(struct kvm_vm *vm,
 		struct memslot_desc *memslot)
 {
@@ -314,11 +371,11 @@ static void punch_hole_in_memslot(struct kvm_vm *vm,
 	fd = vm_mem_region_get_src_fd(vm, memslot->idx);
 	if (fd != -1) {
 		ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				0, memslot->size);
+				0, memslot->paging_size);
 		TEST_ASSERT(ret == 0, "fallocate failed, errno: %d\n", errno);
 	} else {
 		hva = addr_gpa2hva(vm, memslot->gpa);
-		ret = madvise(hva, memslot->size, MADV_DONTNEED);
+		ret = madvise(hva, memslot->paging_size, MADV_DONTNEED);
 		TEST_ASSERT(ret == 0, "madvise failed, errno: %d\n", errno);
 	}
 }
@@ -457,9 +514,60 @@ static void setup_memslots(struct kvm_vm *vm, enum vm_guest_mode mode,
 	virt_pg_map(vm, pte_gva, pte_gpa);
 }
 
+static void setup_uffd(enum vm_guest_mode mode, struct test_params *p,
+		struct uffd_desc **uffd)
+{
+	struct test_desc *test = p->test_desc;
+	uint64_t large_page_size = get_backing_src_pagesz(p->src_type);
+	int i;
+
+	/*
+	 * When creating the map, we might not only have created a pte page,
+	 * but also an intermediate level (pte_gpa != gpa[PT]). So, we
+	 * might need to demand page both.
+	 */
+	memslot[PT].paging_size = align_up(pte_gpa - memslot[PT].gpa,
+			large_page_size) + large_page_size;
+	memslot[TEST].paging_size = large_page_size;
+
+	for (i = 0; i < NR_MEMSLOTS; i++) {
+		memslot[i].data_copy = malloc(memslot[i].paging_size);
+		TEST_ASSERT(memslot[i].data_copy, "Failed malloc.");
+		memcpy(memslot[i].data_copy, memslot[i].hva,
+				memslot[i].paging_size);
+	}
+
+	uffd[PT] = NULL;
+	if (test->uffd_pt_handler)
+		uffd[PT] = uffd_setup_demand_paging(
+				UFFDIO_REGISTER_MODE_MISSING, 0,
+				memslot[PT].hva, memslot[PT].paging_size,
+				test->uffd_pt_handler);
+
+	uffd[TEST] = NULL;
+	if (test->uffd_test_handler)
+		uffd[TEST] = uffd_setup_demand_paging(
+				UFFDIO_REGISTER_MODE_MISSING, 0,
+				memslot[TEST].hva, memslot[TEST].paging_size,
+				test->uffd_test_handler);
+}
+
 static void check_event_counts(struct test_desc *test)
 {
 	ASSERT_EQ(test->expected_events.aborts,	events.aborts);
+	ASSERT_EQ(test->expected_events.uffd_faults, events.uffd_faults);
+}
+
+static void free_uffd(struct test_desc *test, struct uffd_desc **uffd)
+{
+	int i;
+
+	if (test->uffd_pt_handler)
+		uffd_stop_demand_paging(uffd[PT]);
+	if (test->uffd_test_handler)
+		uffd_stop_demand_paging(uffd[TEST]);
+	for (i = 0; i < NR_MEMSLOTS; i++)
+		free(memslot[i].data_copy);
 }
 
 static void print_test_banner(enum vm_guest_mode mode, struct test_params *p)
@@ -517,6 +625,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct test_params *p = (struct test_params *)arg;
 	struct test_desc *test = p->test_desc;
 	struct kvm_vm *vm;
+	struct uffd_desc *uffd[NR_MEMSLOTS];
 	bool skip_test = false;
 
 	print_test_banner(mode, p);
@@ -528,7 +637,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	reset_event_counts();
 	setup_memslots(vm, mode, p);
 
+	/*
+	 * Set some code at memslot[TEST].hva for the guest to execute (only
+	 * applicable to the EXEC tests). This has to be done before
+	 * setup_uffd() as that function copies the memslot data for the uffd
+	 * handler.
+	 */
 	load_exec_code_for_test();
+	setup_uffd(mode, p, uffd);
 	setup_abort_handlers(vm, test);
 	setup_guest_args(vm, test);
 
@@ -542,7 +658,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	sync_stats_from_guest(vm);
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
+	free_uffd(test, uffd);
 
+	/*
+	 * Make sure this is called after the uffd threads have exited (and
+	 * updated their respective event counters).
+	 */
 	if (!skip_test)
 		check_event_counts(test);
 }
@@ -625,6 +746,43 @@ int main(int argc, char *argv[])
 	__VA_ARGS__								\
 }
 
+#define TEST_ACCESS_ON_HOLE_UFFD(__a, __uffd_handler, ...)			\
+{										\
+	.name			= SNAME(ACCESS_ON_HOLE_UFFD ## _ ## __a),	\
+	.guest_test		= __a,						\
+	.mem_mark_cmd		= CMD_HOLE_TEST,				\
+	.uffd_test_handler	= __uffd_handler,				\
+	.expected_events	= { .uffd_faults = 1, },			\
+	__VA_ARGS__								\
+}
+
+#define TEST_S1PTW_ON_HOLE_UFFD(__a, __uffd_handler, ...)			\
+{										\
+	.name			= SNAME(S1PTW_ON_HOLE_UFFD ## _ ## __a),	\
+	.guest_test		= __a,						\
+	.mem_mark_cmd		= CMD_HOLE_PT,					\
+	.uffd_pt_handler	= __uffd_handler,				\
+	.expected_events	= { .uffd_faults = 1, },			\
+	__VA_ARGS__								\
+}
+
+#define TEST_S1PTW_ON_HOLE_UFFD_AF(__a, __uffd_handler)				\
+	TEST_S1PTW_ON_HOLE_UFFD(__a, __uffd_handler, __AF_TEST_ARGS)
+
+#define TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(__a, __th, __ph, ...)		\
+{										\
+	.name			= SNAME(ACCESS_S1PTW_ON_HOLE_UFFD ## _ ## __a),	\
+	.guest_test		= __a,						\
+	.mem_mark_cmd		= CMD_HOLE_PT | CMD_HOLE_TEST,			\
+	.uffd_pt_handler	= __ph,						\
+	.uffd_test_handler	= __th,						\
+	.expected_events	= { .uffd_faults = 2, },			\
+	__VA_ARGS__								\
+}
+
+#define TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(__a, __th, __ph)			\
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(__a, __th, __ph, __AF_TEST_ARGS)
+
 static struct test_desc tests[] = {
 	/* Check that HW is setting the AF (sanity checks). */
 	TEST_HW_ACCESS_FLAG(guest_test_read64),
@@ -640,10 +798,78 @@ static struct test_desc tests[] = {
 	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_cas, __PREPARE_LSE_TEST_ARGS),
 	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_ld_preidx),
 	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_write64),
-	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_at),
 	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_dc_zva),
 	TEST_ACCESS_ON_HOLE_NO_FAULTS(guest_test_st_preidx),
 
+	/* UFFD basic (sanity checks) */
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_read64, uffd_test_read_handler),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_cas, uffd_test_read_handler,
+			__PREPARE_LSE_TEST_ARGS),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_ld_preidx, uffd_test_read_handler),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_write64, uffd_test_write_handler),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_st_preidx, uffd_test_write_handler),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_dc_zva, uffd_test_write_handler),
+	TEST_ACCESS_ON_HOLE_UFFD(guest_test_exec, uffd_test_read_handler),
+
+	/* UFFD fault due to S1PTW. Note how they are all write faults. */
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_read64, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_cas, uffd_pt_write_handler,
+			__PREPARE_LSE_TEST_ARGS),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_at, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_ld_preidx, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_write64, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_dc_zva, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_st_preidx, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_exec, uffd_pt_write_handler),
+
+	/* UFFD fault due to S1PTW with AF. Note how they all write faults. */
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_read64, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD(guest_test_cas, uffd_pt_write_handler,
+			__AF_LSE_TEST_ARGS),
+	/*
+	 * Can't test the AF case for address translation insts (D5.4.11) as
+	 * it's IMPDEF whether that marks the AF.
+	 */
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_ld_preidx, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_write64, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_st_preidx, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_dc_zva, uffd_pt_write_handler),
+	TEST_S1PTW_ON_HOLE_UFFD_AF(guest_test_exec, uffd_pt_write_handler),
+
+	/* UFFD faults due to an access and its S1PTW. */
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_read64,
+			uffd_test_read_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_cas,
+			uffd_test_read_handler, uffd_pt_write_handler,
+			__PREPARE_LSE_TEST_ARGS),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_ld_preidx,
+			uffd_test_read_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_write64,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_dc_zva,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_st_preidx,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_exec,
+			uffd_test_read_handler, uffd_pt_write_handler),
+
+	/* UFFD faults due to an access and its S1PTW with AF. */
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_read64,
+			uffd_test_read_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(guest_test_cas,
+			uffd_test_read_handler, uffd_pt_write_handler,
+			__AF_LSE_TEST_ARGS),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_ld_preidx,
+			uffd_test_read_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_write64,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_dc_zva,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_st_preidx,
+			uffd_test_write_handler, uffd_pt_write_handler),
+	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_exec,
+			uffd_test_read_handler, uffd_pt_write_handler),
+
 	{ 0 },
 };
 
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
