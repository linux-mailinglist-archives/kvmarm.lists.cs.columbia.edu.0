Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 983DC4E5B8F
	for <lists+kvmarm@lfdr.de>; Wed, 23 Mar 2022 23:54:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CB614B0B4;
	Wed, 23 Mar 2022 18:54:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUG8kmqBwuSA; Wed, 23 Mar 2022 18:54:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 896B649F0A;
	Wed, 23 Mar 2022 18:54:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 015E249F0A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Mar 2022 18:54:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ry+M5N0Gqagx for <kvmarm@lists.cs.columbia.edu>;
 Wed, 23 Mar 2022 18:54:28 -0400 (EDT)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D353D49F4C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Mar 2022 18:54:27 -0400 (EDT)
Received: by mail-pf1-f201.google.com with SMTP id
 x186-20020a627cc3000000b004fa939658c5so1666242pfc.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Mar 2022 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=rIGGxCKW6wA4RApzu/HCVy5JcPZMFgCPd5kmjCwZ9O0=;
 b=piZXHjsIkJ450mWbYKngbm3r2F9EiJqQAxZ1le7FNtfC3xFdjIpPNCmarUWoufU8L3
 APRC/TKWSo17t4ibuolc+YTfas8qlKhUpSzpv9fSQ1UYbRxuhDMfHFFI0Zw3EKMeqRPP
 tdiSYUtt4QD0aPgJo618/IEPivUwPL74tuWT4Xf+bZxaQ+cHeB7HgZnc2c9KWLU8bIfL
 VKWheO/kLL+g7KwzZ/Vmv5fb42buxWcMZT5/At2It1a1F5UHUhcB8QqXbK6DE+KL73W4
 5DY4pccU40444jrVf5F7sgOd/4wrWaKlIW7hC8wpeGVChUrDxVXzVlGTsJzMXHfJHgN8
 h12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=rIGGxCKW6wA4RApzu/HCVy5JcPZMFgCPd5kmjCwZ9O0=;
 b=T9TSO4Y8PgiECFpyZi0emVgyUs1VkBLR18wiHtutQHtrvTT80ro8j5t+qDnqe690N8
 IJreFjYqJ7qTjatpzQV1+QGfBu50fOwjI02jjTFWJigw0UgRJW7i2CKg0NEGOs6INWXn
 quofPPbNVx5pA8h66Y3b2TzT3WBC4HBEDMyAmG3R/dlmcKtwTA4xMBTHjPvQoA5P4UkN
 qwfhqppU2BJqoHVEEif7oM6VBTecH861eCJFr5isxnfV6mEKjw4lrIBYy1VbalQg91I5
 iy+BSb0ZmdMxJJnRZdcQa6VaisDyTAw8d7XjlwffaKdehxPY3GUoSO1KO6vtCJ7KtXsd
 TvOA==
X-Gm-Message-State: AOAM5325AJXRMardNVRcgW6jlxiRVCrjRAN3Dbdh1WBH3XhgDbcYvneq
 G1aeX1O7h2XZHqsXoCE5mo5S6jlDpQKF8A==
X-Google-Smtp-Source: ABdhPJyQoyjnUIA1nAFuaTRO6TMxt5W14CprA5TK+iqbEUoBmU6oXnnhTS2xfse4MRrVKkMft9PG8GnMgAdGXw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP
 id s1-20020a170902a50100b00153f95629f0mr2583559plq.120.1648076067074; Wed, 23
 Mar 2022 15:54:27 -0700 (PDT)
Date: Wed, 23 Mar 2022 15:54:05 -0700
In-Reply-To: <20220323225405.267155-1-ricarkol@google.com>
Message-Id: <20220323225405.267155-12-ricarkol@google.com>
Mime-Version: 1.0
References: <20220323225405.267155-1-ricarkol@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2 11/11] KVM: selftests: aarch64: Add mix of tests into
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

Add some mix of tests into page_fault_test, like stage 2 faults on
memslots marked for both userfaultfd and dirty-logging.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../selftests/kvm/aarch64/page_fault_test.c   | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index e6607f903bc1..f1a5bf081a5b 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -399,6 +399,12 @@ static int uffd_test_read_handler(int mode, int uffd, struct uffd_msg *msg)
 	return uffd_generic_handler(mode, uffd, msg, &memslot[TEST], false);
 }
 
+static int uffd_no_handler(int mode, int uffd, struct uffd_msg *msg)
+{
+	TEST_FAIL("There was no UFFD fault expected.");
+	return -1;
+}
+
 static void punch_hole_in_memslot(struct kvm_vm *vm,
 		struct memslot_desc *memslot)
 {
@@ -912,6 +918,30 @@ int main(int argc, char *argv[])
 #define TEST_S1PTW_ON_HOLE_UFFD_AF(__a, __uffd_handler)				\
 	TEST_S1PTW_ON_HOLE_UFFD(__a, __uffd_handler, __AF_TEST_ARGS)
 
+#define __DIRTY_LOG_TEST							\
+	.test_memslot_flags	= KVM_MEM_LOG_DIRTY_PAGES,			\
+	.guest_test_check	= { guest_check_write_in_dirty_log, },		\
+
+#define __DIRTY_LOG_S1PTW_TEST							\
+	.pt_memslot_flags	= KVM_MEM_LOG_DIRTY_PAGES,			\
+	.guest_test_check	= { guest_check_s1ptw_wr_in_dirty_log, },	\
+
+#define TEST_WRITE_DIRTY_LOG_AND_S1PTW_ON_UFFD(__a, __uffd_handler, ...)	\
+	TEST_S1PTW_ON_HOLE_UFFD(__a, __uffd_handler,				\
+			__DIRTY_LOG_TEST __VA_ARGS__)
+
+#define TEST_WRITE_ON_DIRTY_LOG_AND_UFFD(__a, __uffd_handler, ...)		\
+	TEST_ACCESS_ON_HOLE_UFFD(__a, __uffd_handler,				\
+			__DIRTY_LOG_TEST __VA_ARGS__)
+
+#define TEST_WRITE_UFFD_AND_S1PTW_ON_DIRTY_LOG(__a, __uffd_handler, ...)	\
+	TEST_ACCESS_ON_HOLE_UFFD(__a, __uffd_handler,				\
+			__DIRTY_LOG_S1PTW_TEST __VA_ARGS__)
+
+#define TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(__a, __uffd_handler, ...)		\
+	TEST_S1PTW_ON_HOLE_UFFD(__a, __uffd_handler,				\
+			__DIRTY_LOG_S1PTW_TEST __VA_ARGS__)
+
 #define TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD(__a, __th, __ph, ...)		\
 {										\
 	.name			= SNAME(ACCESS_S1PTW_ON_HOLE_UFFD ## _ ## __a),	\
@@ -1015,6 +1045,10 @@ int main(int argc, char *argv[])
 	.guest_prepare		= { guest_set_ha, guest_check_lse, },		\
 	.guest_test_check	= { guest_check_pte_af, }
 
+#define __NULL_UFFD_HANDLERS							\
+	.uffd_test_handler	= uffd_no_handler,				\
+	.uffd_pt_handler	= uffd_no_handler
+
 #define	TEST_WRITE_ON_RO_MEMSLOT_AF(__a)					\
 	TEST_WRITE_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
 
@@ -1105,6 +1139,37 @@ int main(int argc, char *argv[])
 #define TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT(__a) 				\
 	TEST_EXEC_AND_S1PTW_ON_RO_MEMSLOT(__a, __AF_TEST_IN_RO_MEMSLOT_ARGS)
 
+#define TEST_WRITE_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(__a)			\
+	TEST_WRITE_AND_S1PTW_ON_RO_MEMSLOT(__a, __NULL_UFFD_HANDLERS)
+#define TEST_READ_AND_S1PTW_ON_RO_MEMSLOT_WITH_UFFD(__a)			\
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT(__a, __NULL_UFFD_HANDLERS)
+#define TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(__a)			\
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(__a, __NULL_UFFD_HANDLERS)
+#define TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(__a)			\
+	TEST_EXEC_AND_S1PTW_ON_RO_MEMSLOT(__a, __NULL_UFFD_HANDLERS)
+
+#define	TEST_WRITE_ON_RO_DIRTY_LOG_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SNAME(WRITE_ON_RO_MEMSLOT ## _ ## __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY | KVM_MEM_LOG_DIRTY_PAGES,	\
+	.guest_test		= __a,						\
+	.guest_test_check	= { guest_check_no_write_in_dirty_log, },	\
+	.mmio_handler		= mmio_on_test_gpa_handler,			\
+	.expected_events	= { .mmio_exits = 1, },				\
+	__VA_ARGS__								\
+}
+
+#define	TEST_CM_ON_RO_DIRTY_LOG_MEMSLOT(__a, ...)				\
+{										\
+	.name			= SNAME(WRITE_ON_RO_MEMSLOT ## _ ## __a),	\
+	.test_memslot_flags	= KVM_MEM_READONLY | KVM_MEM_LOG_DIRTY_PAGES,	\
+	.guest_test		= __a,						\
+	.guest_test_check	= { guest_check_no_write_in_dirty_log, },	\
+	.fail_vcpu_run_handler	= fail_vcpu_run_mmio_no_syndrome_handler,	\
+	.expected_events	= { .fail_vcpu_runs = 1, },			\
+	__VA_ARGS__								\
+}
+
 static struct test_desc tests[] = {
 	/* Check that HW is setting the AF (sanity checks). */
 	TEST_HW_ACCESS_FLAG(guest_test_read64),
@@ -1223,6 +1288,65 @@ static struct test_desc tests[] = {
 	TEST_ACCESS_AND_S1PTW_ON_HOLE_UFFD_AF(guest_test_exec,
 			uffd_test_read_handler, uffd_pt_write_handler),
 
+	/* Write into a memslot marked for both dirty logging and UFFD. */
+	TEST_WRITE_ON_DIRTY_LOG_AND_UFFD(guest_test_write64,
+			uffd_test_write_handler),
+	/* Note that the cas uffd handler is for a read. */
+	TEST_WRITE_ON_DIRTY_LOG_AND_UFFD(guest_test_cas,
+			uffd_test_read_handler, __PREPARE_LSE_TEST_ARGS),
+	TEST_WRITE_ON_DIRTY_LOG_AND_UFFD(guest_test_dc_zva,
+			uffd_test_write_handler),
+	TEST_WRITE_ON_DIRTY_LOG_AND_UFFD(guest_test_st_preidx,
+			uffd_test_write_handler),
+
+	/*
+	 * Access whose s1ptw faults on a hole that's marked for both dirty
+	 * logging and UFFD.
+	 */
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_read64,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_cas,
+			uffd_pt_write_handler, __PREPARE_LSE_TEST_ARGS),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_ld_preidx,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_exec,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_write64,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_st_preidx,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_dc_zva,
+			uffd_pt_write_handler),
+	TEST_S1PTW_ON_DIRTY_LOG_AND_UFFD(guest_test_at,
+			uffd_pt_write_handler),
+
+	/*
+	 * Write on a memslot marked for dirty logging whose related s1ptw
+	 * is on a hole marked with UFFD.
+	 */
+	TEST_WRITE_DIRTY_LOG_AND_S1PTW_ON_UFFD(guest_test_write64,
+			uffd_pt_write_handler),
+	TEST_WRITE_DIRTY_LOG_AND_S1PTW_ON_UFFD(guest_test_cas,
+			uffd_pt_write_handler, __PREPARE_LSE_TEST_ARGS),
+	TEST_WRITE_DIRTY_LOG_AND_S1PTW_ON_UFFD(guest_test_dc_zva,
+			uffd_pt_write_handler),
+	TEST_WRITE_DIRTY_LOG_AND_S1PTW_ON_UFFD(guest_test_st_preidx,
+			uffd_pt_write_handler),
+
+	/*
+	 * Write on a memslot that's on a hole marked with UFFD, whose related
+	 * sp1ptw is on a memslot marked for dirty logging.
+	 */
+	TEST_WRITE_UFFD_AND_S1PTW_ON_DIRTY_LOG(guest_test_write64,
+			uffd_test_write_handler),
+	/* Note that the uffd handler is for a read. */
+	TEST_WRITE_UFFD_AND_S1PTW_ON_DIRTY_LOG(guest_test_cas,
+			uffd_test_read_handler, __PREPARE_LSE_TEST_ARGS),
+	TEST_WRITE_UFFD_AND_S1PTW_ON_DIRTY_LOG(guest_test_dc_zva,
+			uffd_test_write_handler),
+	TEST_WRITE_UFFD_AND_S1PTW_ON_DIRTY_LOG(guest_test_st_preidx,
+			uffd_test_write_handler),
+
 	/* Access on readonly memslot (sanity check). */
 	TEST_WRITE_ON_RO_MEMSLOT(guest_test_write64),
 	TEST_READ_ON_RO_MEMSLOT(guest_test_read64),
@@ -1290,6 +1414,30 @@ static struct test_desc tests[] = {
 	TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_st_preidx),
 	TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT(guest_test_exec),
 
+	/*
+	 * Access on a memslot marked as readonly with also dirty log tracking.
+	 * There should be no write in the dirty log.
+	 */
+	TEST_WRITE_ON_RO_DIRTY_LOG_MEMSLOT(guest_test_write64),
+	TEST_CM_ON_RO_DIRTY_LOG_MEMSLOT(guest_test_cas,
+			__PREPARE_LSE_TEST_ARGS),
+	TEST_CM_ON_RO_DIRTY_LOG_MEMSLOT(guest_test_dc_zva),
+	TEST_CM_ON_RO_DIRTY_LOG_MEMSLOT(guest_test_st_preidx),
+
+	/*
+	 * Access on a RO memslot with S1PTW also on a RO memslot, while also
+	 * having those memslot regions marked for UFFD fault handling.  The
+	 * result is that UFFD fault handlers should not be called.
+	 */
+	TEST_WRITE_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(guest_test_write64),
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT_WITH_UFFD(guest_test_read64),
+	TEST_READ_AND_S1PTW_ON_RO_MEMSLOT_WITH_UFFD(guest_test_ld_preidx),
+	TEST_CM_AND_S1PTW_ON_RO_MEMSLOT(guest_test_cas,
+			__PREPARE_LSE_TEST_ARGS __NULL_UFFD_HANDLERS),
+	TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(guest_test_dc_zva),
+	TEST_CM_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(guest_test_st_preidx),
+	TEST_EXEC_AND_S1PTW_AF_ON_RO_MEMSLOT_WITH_UFFD(guest_test_exec),
+
 	{ 0 },
 };
 
-- 
2.35.1.894.gb6a874cedc-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
