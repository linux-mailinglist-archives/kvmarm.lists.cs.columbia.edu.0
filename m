Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BF7865FA9AD
	for <lists+kvmarm@lfdr.de>; Tue, 11 Oct 2022 03:07:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CAAE4B651;
	Mon, 10 Oct 2022 21:07:03 -0400 (EDT)
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
	with ESMTP id U9oLzTIgn-dp; Mon, 10 Oct 2022 21:07:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25A3F4B6B2;
	Mon, 10 Oct 2022 21:07:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5FBD4B637
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:06:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O9FodKNP-2vD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Oct 2022 21:06:56 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9BA0B4B633
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:06:56 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 t8-20020a258388000000b006bfb0865043so7687366ybk.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8dLIpD8ljXy45IrICHbNRjNl4/9BRIvyuVvrFLFHnuw=;
 b=VhkqbWS2lwnorNFeBySulwBq1pi8TvSvDzAt5y3AawnYr3WsT20cz1LZkkEvSUng1m
 BS+eoUiw8Rm8ah7rEaVxCPMJqmL3buB6ER80A8LEwpcN5SR/nEXn8c3Au90c09qrPizh
 unDYL44xV1+v6FEWbF9VL3/kg1NMzqIzapPLpKZFr/FO+pHlUyxxWr2S+n3nQcbSsekg
 T6Jt6qSdYMJ8Fshl7BOXHgJBOKLw1o4TWCAeTjZP+j00VJL2WA72iVoITWtxTNLL1KM/
 U2mzVzavnp5g/9FC4MORHAOQ4LRmTL0avHXkeBQM26Ex/CqpR/QrY86OMzN+jXFiEAm1
 LZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dLIpD8ljXy45IrICHbNRjNl4/9BRIvyuVvrFLFHnuw=;
 b=trnY3KYn0/zF0sSdO+2AFNAPxonD1Lg5Fvv1MFx3yj5intV3ms+QaTHxNGtp4MTz5c
 9LW/O/c78IFSw6P9yU7bDzNFa+yQ4go8thGTCEed9hjhqxBSRZJHDqw+CXw2rDPEMcKh
 ywaN2lNee4PihOdC5olVK/JGN8ajdSIJ7qnd8SBznTAR2Ts11bGknulsgJcDBM1fRndS
 ZUygvfbUbLrWt7jjT+klUNP4EZn+bHryUijqu2ZsC60kUWMAkcNNTCFPOharggRun+dN
 dJa5URvgJd8HmVbw9245wJkzya3jZQZJKyG1zdycpPyzIJNEaEGlRvyByae+J582m2je
 CGzQ==
X-Gm-Message-State: ACrzQf35MIokPxtwdj31MwUutjyGFteg7FKAz3p+S0bZd79aYKHTCRF5
 XX2WsXR9z39NSSOS2IpnFhgSlh2KMiqRcw==
X-Google-Smtp-Source: AMsMyM5MY+h27o1+WCep0csBatYWFp5mXYjmhqY91nXvUvDzdiektPvB0C0xEgrSxcOzI31wJguuMcgvrrhyIQ==
X-Received: from ricarkol4.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:1248])
 (user=ricarkol job=sendgmr) by 2002:a81:d34e:0:b0:353:1cdc:330c with SMTP id
 d14-20020a81d34e000000b003531cdc330cmr18939068ywl.315.1665450416209; Mon, 10
 Oct 2022 18:06:56 -0700 (PDT)
Date: Tue, 11 Oct 2022 01:06:25 +0000
In-Reply-To: <20221011010628.1734342-1-ricarkol@google.com>
Mime-Version: 1.0
References: <20221011010628.1734342-1-ricarkol@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011010628.1734342-12-ricarkol@google.com>
Subject: [PATCH v9 11/14] KVM: selftests: aarch64: Add userfaultfd tests into
 page_fault_test
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, 
 andrew.jones@linux.dev
Cc: maz@kernel.org, bgardon@google.com, pbonzini@redhat.com,
 axelrasmussen@google.com, dmatlack@google.com
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
 .../selftests/kvm/aarch64/page_fault_test.c   | 189 +++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 8583be16e1fe..cf937b90deab 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -35,6 +35,12 @@ static uint64_t *guest_test_memory = (uint64_t *)TEST_GVA;
 #define PREPARE_FN_NR				10
 #define CHECK_FN_NR				10
 
+static struct event_cnt {
+	int uffd_faults;
+	/* uffd_faults is incremented from multiple threads. */
+	pthread_mutex_t uffd_faults_mutex;
+} events;
+
 struct test_desc {
 	const char *name;
 	uint64_t mem_mark_cmd;
@@ -42,11 +48,14 @@ struct test_desc {
 	bool (*guest_prepare[PREPARE_FN_NR])(void);
 	void (*guest_test)(void);
 	void (*guest_test_check[CHECK_FN_NR])(void);
+	uffd_handler_t uffd_pt_handler;
+	uffd_handler_t uffd_data_handler;
 	void (*dabt_handler)(struct ex_regs *regs);
 	void (*iabt_handler)(struct ex_regs *regs);
 	uint32_t pt_memslot_flags;
 	uint32_t data_memslot_flags;
 	bool skip;
+	struct event_cnt expected_events;
 };
 
 struct test_params {
@@ -263,7 +272,110 @@ static void no_iabt_handler(struct ex_regs *regs)
 	GUEST_ASSERT_1(false, regs->pc);
 }
 
+static struct uffd_args {
+	char *copy;
+	void *hva;
+	uint64_t paging_size;
+} pt_args, data_args;
+
 /* Returns true to continue the test, and false if it should be skipped. */
+static int uffd_generic_handler(int uffd_mode, int uffd,
+		struct uffd_msg *msg, struct uffd_args *args,
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
+	ASSERT_EQ(addr, (uint64_t)args->hva);
+
+	pr_debug("uffd fault: addr=%p write=%d\n",
+			(void *)addr, !!(flags & UFFD_PAGEFAULT_FLAG_WRITE));
+
+	copy.src = (uint64_t)args->copy;
+	copy.dst = addr;
+	copy.len = args->paging_size;
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
+	return uffd_generic_handler(mode, uffd, msg, &pt_args, true);
+}
+
+static int uffd_data_write_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	return uffd_generic_handler(mode, uffd, msg, &data_args, true);
+}
+
+static int uffd_data_read_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	return uffd_generic_handler(mode, uffd, msg, &data_args, false);
+}
+
+static void setup_uffd_args(struct userspace_mem_region *region,
+				struct uffd_args *args)
+{
+	args->hva = (void *)region->region.userspace_addr;
+	args->paging_size = region->region.memory_size;
+
+	args->copy = malloc(args->paging_size);
+	TEST_ASSERT(args->copy, "Failed to allocate data copy.");
+	memcpy(args->copy, args->hva, args->paging_size);
+}
+
+static void setup_uffd(struct kvm_vm *vm, struct test_params *p,
+		struct uffd_desc **pt_uffd, struct uffd_desc **data_uffd)
+{
+	struct test_desc *test = p->test_desc;
+
+	setup_uffd_args(vm_get_mem_region(vm, MEM_REGION_PT), &pt_args);
+	setup_uffd_args(vm_get_mem_region(vm, MEM_REGION_TEST_DATA), &data_args);
+
+	*pt_uffd = NULL;
+	if (test->uffd_pt_handler)
+		*pt_uffd = uffd_setup_demand_paging(
+				UFFDIO_REGISTER_MODE_MISSING, 0,
+				pt_args.hva, pt_args.paging_size,
+				test->uffd_pt_handler);
+
+	*data_uffd = NULL;
+	if (test->uffd_data_handler)
+		*data_uffd = uffd_setup_demand_paging(
+				UFFDIO_REGISTER_MODE_MISSING, 0,
+				data_args.hva, data_args.paging_size,
+				test->uffd_data_handler);
+}
+
+static void free_uffd(struct test_desc *test, struct uffd_desc *pt_uffd,
+			struct uffd_desc *data_uffd)
+{
+	if (test->uffd_pt_handler)
+		uffd_stop_demand_paging(pt_uffd);
+	if (test->uffd_data_handler)
+		uffd_stop_demand_paging(data_uffd);
+
+	free(pt_args.copy);
+	free(data_args.copy);
+}
+
+/* Returns false if the test should be skipped. */
 static bool punch_hole_in_backing_store(struct kvm_vm *vm,
 					struct userspace_mem_region *region)
 {
@@ -404,6 +516,11 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
 	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
 }
 
+static void check_event_counts(struct test_desc *test)
+{
+	ASSERT_EQ(test->expected_events.uffd_faults, events.uffd_faults);
+}
+
 static void print_test_banner(enum vm_guest_mode mode, struct test_params *p)
 {
 	struct test_desc *test = p->test_desc;
@@ -414,12 +531,17 @@ static void print_test_banner(enum vm_guest_mode mode, struct test_params *p)
 			vm_mem_backing_src_alias(p->src_type)->name);
 }
 
+static void reset_event_counts(void)
+{
+	memset(&events, 0, sizeof(events));
+}
+
 /*
  * This function either succeeds, skips the test (after setting test->skip), or
  * fails with a TEST_FAIL that aborts all tests.
  */
 static void vcpu_run_loop(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			  struct test_desc *test)
+		struct test_desc *test)
 {
 	struct ucall uc;
 
@@ -453,6 +575,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct test_desc *test = p->test_desc;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
+	struct uffd_desc *pt_uffd, *data_uffd;
 
 	print_test_banner(mode, p);
 
@@ -465,7 +588,16 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	ucall_init(vm, NULL);
 
+	reset_event_counts();
+
+	/*
+	 * Set some code in the data memslot for the guest to execute (only
+	 * applicable to the EXEC tests). This has to be done before
+	 * setup_uffd() as that function copies the memslot data for the uffd
+	 * handler.
+	 */
 	load_exec_code_for_test(vm);
+	setup_uffd(vm, p, &pt_uffd, &data_uffd);
 	setup_abort_handlers(vm, vcpu, test);
 	vcpu_args_set(vcpu, 1, test);
 
@@ -473,6 +605,14 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
+	free_uffd(test, pt_uffd, data_uffd);
+
+	/*
+	 * Make sure we check the events after the uffd threads have exited,
+	 * which means they updated their respective event counters.
+	 */
+	if (!test->skip)
+		check_event_counts(test);
 }
 
 static void help(char *name)
@@ -488,6 +628,7 @@ static void help(char *name)
 #define SNAME(s)			#s
 #define SCAT2(a, b)			SNAME(a ## _ ## b)
 #define SCAT3(a, b, c)			SCAT2(a, SCAT2(b, c))
+#define SCAT4(a, b, c, d)		SCAT2(a, SCAT3(b, c, d))
 
 #define _CHECK(_test)			_CHECK_##_test
 #define _PREPARE(_test)			_PREPARE_##_test
@@ -515,6 +656,21 @@ static void help(char *name)
 	.mem_mark_cmd		= _mark_cmd,					\
 	.guest_test		= _access,					\
 	.guest_test_check	= { _CHECK(_with_af) },				\
+	.expected_events	= { 0 },					\
+}
+
+#define TEST_UFFD(_access, _with_af, _mark_cmd,					\
+		  _uffd_data_handler, _uffd_pt_handler, _uffd_faults)		\
+{										\
+	.name			= SCAT4(uffd, _access, _with_af, #_mark_cmd),	\
+	.guest_prepare		= { _PREPARE(_with_af),				\
+				    _PREPARE(_access) },			\
+	.guest_test		= _access,					\
+	.mem_mark_cmd		= _mark_cmd,					\
+	.guest_test_check	= { _CHECK(_with_af) },				\
+	.uffd_data_handler	= _uffd_data_handler,				\
+	.uffd_pt_handler	= _uffd_pt_handler,				\
+	.expected_events	= { .uffd_faults = _uffd_faults, },		\
 }
 
 static struct test_desc tests[] = {
@@ -545,6 +701,37 @@ static struct test_desc tests[] = {
 	TEST_ACCESS(guest_at, no_af, CMD_HOLE_DATA),
 	TEST_ACCESS(guest_dc_zva, no_af, CMD_HOLE_DATA),
 
+	/*
+	 * Punch holes in the data and PT backing stores and mark them for
+	 * userfaultfd handling. This should result in 2 faults: the access
+	 * on the data backing store, and its respective S1 page table walk
+	 * (S1PTW).
+	 */
+	TEST_UFFD(guest_read64, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 2),
+	/* no_af should also lead to a PT write. */
+	TEST_UFFD(guest_read64, no_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 2),
+	/* Note how that cas invokes the read handler. */
+	TEST_UFFD(guest_cas, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 2),
+	/*
+	 * Can't test guest_at with_af as it's IMPDEF whether the AF is set.
+	 * The S1PTW fault should still be marked as a write.
+	 */
+	TEST_UFFD(guest_at, no_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 1),
+	TEST_UFFD(guest_ld_preidx, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 2),
+	TEST_UFFD(guest_write64, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_write_handler, uffd_pt_write_handler, 2),
+	TEST_UFFD(guest_dc_zva, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_write_handler, uffd_pt_write_handler, 2),
+	TEST_UFFD(guest_st_preidx, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_write_handler, uffd_pt_write_handler, 2),
+	TEST_UFFD(guest_exec, with_af, CMD_HOLE_DATA | CMD_HOLE_PT,
+			uffd_data_read_handler, uffd_pt_write_handler, 2),
+
 	{ 0 }
 };
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
