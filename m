Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D99255FA9A0
	for <lists+kvmarm@lfdr.de>; Tue, 11 Oct 2022 03:06:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 595704B639;
	Mon, 10 Oct 2022 21:06:45 -0400 (EDT)
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
	with ESMTP id nnkvszmKw+AF; Mon, 10 Oct 2022 21:06:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD8AF4B62D;
	Mon, 10 Oct 2022 21:06:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A0D67403FD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:06:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1E1rO8P7Epch for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Oct 2022 21:06:37 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 289014B630
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:06:36 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 g66-20020a636b45000000b0043a256d3639so6958248pgc.12
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=u7F1os0mJuXLfiLwqh0k0HRHdo0cntgRCvywFbQepqQ=;
 b=e8DMx8RRBGzYwtMr3Zrcp8c9J8eRnu7GvNx4/mJCytViVSDWn/wWICXvZGk8fFXRNy
 aGkz3OU6jgtkTUgk06foddzBuq4av2PXsHhyjL0ZPtrIISz4KVMNjahwkNDpexaOzxJJ
 NsEtuE0XWN2stM3UqREARuHViPVpUGlZWbjzAJb/j+n466LiToYCBQyS4g/4qzwzQ8gd
 Ouvt4CyNRlM9QX8P5oUq1Lxd1R3sQIbHvzRapTrQmF4gxhN+JpMV73C4FZxzbYf4BEDp
 G9pV0ji3CbAdtbNXyV5sxfvV4UNmspL7PrZDDnbmud+wO5/NQxSJP73X3HwYCjBut+A0
 4UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7F1os0mJuXLfiLwqh0k0HRHdo0cntgRCvywFbQepqQ=;
 b=pC0nPNJqTfPI7nVOMz13DCpC3Gx4+h2/qLZ8pevT5aMvu+YJGXqlwkElDMdiBnOtSU
 QS3GvdVVsvcoN/64TWuYb6I7cj0kCcyrflvrOu8xQgl43rVlZoa84xXBHbj5u7o8RP6H
 7+1jocLEvJSS8aBpkNxdWMNu9+ThYK2DLamYoKg8FlXb2yx3yVh6quWNyGhYZdHf4U4b
 b37+SCrW2uYrXVqntR7TS6q9w2mue3L3iKkieTudoIEZL5n95ny1FLi3GVTg9cQRQbzw
 fk4eSMk0MNUtWfkjZ0PQygNLtl1/j59ra+ykId77EtoKjBRgIJZ7qglqYz96PV9ZaVQV
 8smQ==
X-Gm-Message-State: ACrzQf2KyP8/4/CnuQ1EdTjGxxdbXX2iYk4tlcDsHgWkjQHc382ECwGz
 JTCuJ6Sxp8ZTeWmUaR5KObYNzI6ZhVeiPQ==
X-Google-Smtp-Source: AMsMyM4aZLy8aurH7gsfUH8wpLX5OB/LVMOXPf285yO9n9le1ZdT8fr0i8tq/SkZQJXQvimje4cLl1P6kRNIlQ==
X-Received: from ricarkol4.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:1248])
 (user=ricarkol job=sendgmr) by 2002:a17:90a:460d:b0:20c:1147:bf32 with SMTP
 id w13-20020a17090a460d00b0020c1147bf32mr18960321pjg.24.1665450394777; Mon,
 10 Oct 2022 18:06:34 -0700 (PDT)
Date: Tue, 11 Oct 2022 01:06:15 +0000
In-Reply-To: <20221011010628.1734342-1-ricarkol@google.com>
Mime-Version: 1.0
References: <20221011010628.1734342-1-ricarkol@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011010628.1734342-2-ricarkol@google.com>
Subject: [PATCH v9 01/14] KVM: selftests: Add a userfaultfd library
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

Move the generic userfaultfd code out of demand_paging_test.c into a
common library, userfaultfd_util. This library consists of a setup and a
stop function. The setup function starts a thread for handling page
faults using the handler callback function. This setup returns a
uffd_desc object which is then used in the stop function (to wait and
destroy the threads).

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/demand_paging_test.c        | 228 +++---------------
 .../selftests/kvm/include/userfaultfd_util.h  |  45 ++++
 .../selftests/kvm/lib/userfaultfd_util.c      | 186 ++++++++++++++
 4 files changed, 262 insertions(+), 198 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/userfaultfd_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/userfaultfd_util.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 0172eb6cb6ee..08a2606aff33 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -47,6 +47,7 @@ LIBKVM += lib/perf_test_util.c
 LIBKVM += lib/rbtree.c
 LIBKVM += lib/sparsebit.c
 LIBKVM += lib/test_util.c
+LIBKVM += lib/userfaultfd_util.c
 
 LIBKVM_STRING += lib/string_override.c
 
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 779ae54f89c4..8e1fe4ffcccd 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -22,23 +22,13 @@
 #include "test_util.h"
 #include "perf_test_util.h"
 #include "guest_modes.h"
+#include "userfaultfd_util.h"
 
 #ifdef __NR_userfaultfd
 
-#ifdef PRINT_PER_PAGE_UPDATES
-#define PER_PAGE_DEBUG(...) printf(__VA_ARGS__)
-#else
-#define PER_PAGE_DEBUG(...) _no_printf(__VA_ARGS__)
-#endif
-
-#ifdef PRINT_PER_VCPU_UPDATES
-#define PER_VCPU_DEBUG(...) printf(__VA_ARGS__)
-#else
-#define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
-#endif
-
 static int nr_vcpus = 1;
 static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
+
 static size_t demand_paging_size;
 static char *guest_data_prototype;
 
@@ -67,9 +57,11 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
 		       ts_diff.tv_sec, ts_diff.tv_nsec);
 }
 
-static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
+static int handle_uffd_page_request(int uffd_mode, int uffd,
+		struct uffd_msg *msg)
 {
 	pid_t tid = syscall(__NR_gettid);
+	uint64_t addr = msg->arg.pagefault.address;
 	struct timespec start;
 	struct timespec ts_diff;
 	int r;
@@ -116,174 +108,32 @@ static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
 	return 0;
 }
 
-bool quit_uffd_thread;
-
-struct uffd_handler_args {
+struct test_params {
 	int uffd_mode;
-	int uffd;
-	int pipefd;
-	useconds_t delay;
+	useconds_t uffd_delay;
+	enum vm_mem_backing_src_type src_type;
+	bool partition_vcpu_memory_access;
 };
 
-static void *uffd_handler_thread_fn(void *arg)
-{
-	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
-	int uffd = uffd_args->uffd;
-	int pipefd = uffd_args->pipefd;
-	useconds_t delay = uffd_args->delay;
-	int64_t pages = 0;
-	struct timespec start;
-	struct timespec ts_diff;
-
-	clock_gettime(CLOCK_MONOTONIC, &start);
-	while (!quit_uffd_thread) {
-		struct uffd_msg msg;
-		struct pollfd pollfd[2];
-		char tmp_chr;
-		int r;
-		uint64_t addr;
-
-		pollfd[0].fd = uffd;
-		pollfd[0].events = POLLIN;
-		pollfd[1].fd = pipefd;
-		pollfd[1].events = POLLIN;
-
-		r = poll(pollfd, 2, -1);
-		switch (r) {
-		case -1:
-			pr_info("poll err");
-			continue;
-		case 0:
-			continue;
-		case 1:
-			break;
-		default:
-			pr_info("Polling uffd returned %d", r);
-			return NULL;
-		}
-
-		if (pollfd[0].revents & POLLERR) {
-			pr_info("uffd revents has POLLERR");
-			return NULL;
-		}
-
-		if (pollfd[1].revents & POLLIN) {
-			r = read(pollfd[1].fd, &tmp_chr, 1);
-			TEST_ASSERT(r == 1,
-				    "Error reading pipefd in UFFD thread\n");
-			return NULL;
-		}
-
-		if (!(pollfd[0].revents & POLLIN))
-			continue;
-
-		r = read(uffd, &msg, sizeof(msg));
-		if (r == -1) {
-			if (errno == EAGAIN)
-				continue;
-			pr_info("Read of uffd got errno %d\n", errno);
-			return NULL;
-		}
-
-		if (r != sizeof(msg)) {
-			pr_info("Read on uffd returned unexpected size: %d bytes", r);
-			return NULL;
-		}
-
-		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
-			continue;
-
-		if (delay)
-			usleep(delay);
-		addr =  msg.arg.pagefault.address;
-		r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
-		if (r < 0)
-			return NULL;
-		pages++;
-	}
-
-	ts_diff = timespec_elapsed(start);
-	PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n",
-		       pages, ts_diff.tv_sec, ts_diff.tv_nsec,
-		       pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
-
-	return NULL;
-}
-
-static void setup_demand_paging(struct kvm_vm *vm,
-				pthread_t *uffd_handler_thread, int pipefd,
-				int uffd_mode, useconds_t uffd_delay,
-				struct uffd_handler_args *uffd_args,
-				void *hva, void *alias, uint64_t len)
+static void prefault_mem(void *alias, uint64_t len)
 {
-	bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
-	int uffd;
-	struct uffdio_api uffdio_api;
-	struct uffdio_register uffdio_register;
-	uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
-	int ret;
+	size_t p;
 
-	PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
-		       is_minor ? "MINOR" : "MISSING",
-		       is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
-
-	/* In order to get minor faults, prefault via the alias. */
-	if (is_minor) {
-		size_t p;
-
-		expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
-
-		TEST_ASSERT(alias != NULL, "Alias required for minor faults");
-		for (p = 0; p < (len / demand_paging_size); ++p) {
-			memcpy(alias + (p * demand_paging_size),
-			       guest_data_prototype, demand_paging_size);
-		}
+	TEST_ASSERT(alias != NULL, "Alias required for minor faults");
+	for (p = 0; p < (len / demand_paging_size); ++p) {
+		memcpy(alias + (p * demand_paging_size),
+		       guest_data_prototype, demand_paging_size);
 	}
-
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
-	TEST_ASSERT(uffd >= 0, __KVM_SYSCALL_ERROR("userfaultfd()", uffd));
-
-	uffdio_api.api = UFFD_API;
-	uffdio_api.features = 0;
-	ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
-	TEST_ASSERT(ret != -1, __KVM_SYSCALL_ERROR("UFFDIO_API", ret));
-
-	uffdio_register.range.start = (uint64_t)hva;
-	uffdio_register.range.len = len;
-	uffdio_register.mode = uffd_mode;
-	ret = ioctl(uffd, UFFDIO_REGISTER, &uffdio_register);
-	TEST_ASSERT(ret != -1, __KVM_SYSCALL_ERROR("UFFDIO_REGISTER", ret));
-	TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
-		    expected_ioctls, "missing userfaultfd ioctls");
-
-	uffd_args->uffd_mode = uffd_mode;
-	uffd_args->uffd = uffd;
-	uffd_args->pipefd = pipefd;
-	uffd_args->delay = uffd_delay;
-	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
-		       uffd_args);
-
-	PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
-		       hva, hva + len);
 }
 
-struct test_params {
-	int uffd_mode;
-	useconds_t uffd_delay;
-	enum vm_mem_backing_src_type src_type;
-	bool partition_vcpu_memory_access;
-};
-
 static void run_test(enum vm_guest_mode mode, void *arg)
 {
 	struct test_params *p = arg;
-	pthread_t *uffd_handler_threads = NULL;
-	struct uffd_handler_args *uffd_args = NULL;
+	struct uffd_desc **uffd_descs = NULL;
 	struct timespec start;
 	struct timespec ts_diff;
-	int *pipefds = NULL;
 	struct kvm_vm *vm;
-	int r, i;
+	int i;
 
 	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size, 1,
 				 p->src_type, p->partition_vcpu_memory_access);
@@ -296,15 +146,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
 	if (p->uffd_mode) {
-		uffd_handler_threads =
-			malloc(nr_vcpus * sizeof(*uffd_handler_threads));
-		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
-
-		uffd_args = malloc(nr_vcpus * sizeof(*uffd_args));
-		TEST_ASSERT(uffd_args, "Memory allocation failed");
-
-		pipefds = malloc(sizeof(int) * nr_vcpus * 2);
-		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
+		uffd_descs = malloc(nr_vcpus * sizeof(struct uffd_desc *));
+		TEST_ASSERT(uffd_descs, "Memory allocation failed");
 
 		for (i = 0; i < nr_vcpus; i++) {
 			struct perf_test_vcpu_args *vcpu_args;
@@ -317,19 +160,17 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			vcpu_hva = addr_gpa2hva(vm, vcpu_args->gpa);
 			vcpu_alias = addr_gpa2alias(vm, vcpu_args->gpa);
 
+			prefault_mem(vcpu_alias,
+				vcpu_args->pages * perf_test_args.guest_page_size);
+
 			/*
 			 * Set up user fault fd to handle demand paging
 			 * requests.
 			 */
-			r = pipe2(&pipefds[i * 2],
-				  O_CLOEXEC | O_NONBLOCK);
-			TEST_ASSERT(!r, "Failed to set up pipefd");
-
-			setup_demand_paging(vm, &uffd_handler_threads[i],
-					    pipefds[i * 2], p->uffd_mode,
-					    p->uffd_delay, &uffd_args[i],
-					    vcpu_hva, vcpu_alias,
-					    vcpu_args->pages * perf_test_args.guest_page_size);
+			uffd_descs[i] = uffd_setup_demand_paging(
+				p->uffd_mode, p->uffd_delay, vcpu_hva,
+				vcpu_args->pages * perf_test_args.guest_page_size,
+				&handle_uffd_page_request);
 		}
 	}
 
@@ -344,15 +185,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	pr_info("All vCPU threads joined\n");
 
 	if (p->uffd_mode) {
-		char c;
-
 		/* Tell the user fault fd handler threads to quit */
-		for (i = 0; i < nr_vcpus; i++) {
-			r = write(pipefds[i * 2 + 1], &c, 1);
-			TEST_ASSERT(r == 1, "Unable to write to pipefd");
-
-			pthread_join(uffd_handler_threads[i], NULL);
-		}
+		for (i = 0; i < nr_vcpus; i++)
+			uffd_stop_demand_paging(uffd_descs[i]);
 	}
 
 	pr_info("Total guest execution time: %ld.%.9lds\n",
@@ -364,11 +199,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	perf_test_destroy_vm(vm);
 
 	free(guest_data_prototype);
-	if (p->uffd_mode) {
-		free(uffd_handler_threads);
-		free(uffd_args);
-		free(pipefds);
-	}
+	if (p->uffd_mode)
+		free(uffd_descs);
 }
 
 static void help(char *name)
diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
new file mode 100644
index 000000000000..aef029300b76
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KVM userfaultfd util
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2019-2022 Google LLC
+ */
+
+#define _GNU_SOURCE /* for pipe2 */
+
+#include <inttypes.h>
+#include <time.h>
+#include <pthread.h>
+#include <linux/userfaultfd.h>
+
+#include "test_util.h"
+
+typedef int (*uffd_handler_t)(int uffd_mode, int uffd, struct uffd_msg *msg);
+
+struct uffd_desc {
+	int uffd_mode;
+	int uffd;
+	int pipefds[2];
+	useconds_t delay;
+	uffd_handler_t handler;
+	pthread_t thread;
+};
+
+struct uffd_desc *uffd_setup_demand_paging(int uffd_mode,
+		useconds_t uffd_delay, void *hva, uint64_t len,
+		uffd_handler_t handler);
+
+void uffd_stop_demand_paging(struct uffd_desc *uffd);
+
+#ifdef PRINT_PER_PAGE_UPDATES
+#define PER_PAGE_DEBUG(...) printf(__VA_ARGS__)
+#else
+#define PER_PAGE_DEBUG(...) _no_printf(__VA_ARGS__)
+#endif
+
+#ifdef PRINT_PER_VCPU_UPDATES
+#define PER_VCPU_DEBUG(...) printf(__VA_ARGS__)
+#else
+#define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
+#endif
diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
new file mode 100644
index 000000000000..9c08ddca03c9
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM userfaultfd util
+ * Adapted from demand_paging_test.c
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2019-2022 Google LLC
+ */
+
+#define _GNU_SOURCE /* for pipe2 */
+
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <poll.h>
+#include <pthread.h>
+#include <linux/userfaultfd.h>
+#include <sys/syscall.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+#include "perf_test_util.h"
+#include "userfaultfd_util.h"
+
+#ifdef __NR_userfaultfd
+
+static void *uffd_handler_thread_fn(void *arg)
+{
+	struct uffd_desc *uffd_desc = (struct uffd_desc *)arg;
+	int uffd = uffd_desc->uffd;
+	int pipefd = uffd_desc->pipefds[0];
+	useconds_t delay = uffd_desc->delay;
+	int64_t pages = 0;
+	struct timespec start;
+	struct timespec ts_diff;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	while (1) {
+		struct uffd_msg msg;
+		struct pollfd pollfd[2];
+		char tmp_chr;
+		int r;
+
+		pollfd[0].fd = uffd;
+		pollfd[0].events = POLLIN;
+		pollfd[1].fd = pipefd;
+		pollfd[1].events = POLLIN;
+
+		r = poll(pollfd, 2, -1);
+		switch (r) {
+		case -1:
+			pr_info("poll err");
+			continue;
+		case 0:
+			continue;
+		case 1:
+			break;
+		default:
+			pr_info("Polling uffd returned %d", r);
+			return NULL;
+		}
+
+		if (pollfd[0].revents & POLLERR) {
+			pr_info("uffd revents has POLLERR");
+			return NULL;
+		}
+
+		if (pollfd[1].revents & POLLIN) {
+			r = read(pollfd[1].fd, &tmp_chr, 1);
+			TEST_ASSERT(r == 1,
+				    "Error reading pipefd in UFFD thread\n");
+			return NULL;
+		}
+
+		if (!(pollfd[0].revents & POLLIN))
+			continue;
+
+		r = read(uffd, &msg, sizeof(msg));
+		if (r == -1) {
+			if (errno == EAGAIN)
+				continue;
+			pr_info("Read of uffd got errno %d\n", errno);
+			return NULL;
+		}
+
+		if (r != sizeof(msg)) {
+			pr_info("Read on uffd returned unexpected size: %d bytes", r);
+			return NULL;
+		}
+
+		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
+			continue;
+
+		if (delay)
+			usleep(delay);
+		r = uffd_desc->handler(uffd_desc->uffd_mode, uffd, &msg);
+		if (r < 0)
+			return NULL;
+		pages++;
+	}
+
+	ts_diff = timespec_elapsed(start);
+	PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n",
+		       pages, ts_diff.tv_sec, ts_diff.tv_nsec,
+		       pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
+
+	return NULL;
+}
+
+struct uffd_desc *uffd_setup_demand_paging(int uffd_mode,
+		useconds_t uffd_delay, void *hva, uint64_t len,
+		uffd_handler_t handler)
+{
+	struct uffd_desc *uffd_desc;
+	bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
+	int uffd;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
+	int ret;
+
+	PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
+		       is_minor ? "MINOR" : "MISSING",
+		       is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
+
+	uffd_desc = malloc(sizeof(struct uffd_desc));
+	TEST_ASSERT(uffd_desc, "malloc failed");
+
+	/* In order to get minor faults, prefault via the alias. */
+	if (is_minor)
+		expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
+		    "ioctl UFFDIO_API failed: %" PRIu64,
+		    (uint64_t)uffdio_api.api);
+
+	uffdio_register.range.start = (uint64_t)hva;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = uffd_mode;
+	TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
+		    "ioctl UFFDIO_REGISTER failed");
+	TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
+			expected_ioctls, "missing userfaultfd ioctls");
+
+	ret = pipe2(uffd_desc->pipefds, O_CLOEXEC | O_NONBLOCK);
+	TEST_ASSERT(!ret, "Failed to set up pipefd");
+
+	uffd_desc->uffd_mode = uffd_mode;
+	uffd_desc->uffd = uffd;
+	uffd_desc->delay = uffd_delay;
+	uffd_desc->handler = handler;
+	pthread_create(&uffd_desc->thread, NULL, uffd_handler_thread_fn,
+		       uffd_desc);
+
+	PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
+		       hva, hva + len);
+
+	return uffd_desc;
+}
+
+void uffd_stop_demand_paging(struct uffd_desc *uffd)
+{
+	char c = 0;
+	int ret;
+
+	ret = write(uffd->pipefds[1], &c, 1);
+	TEST_ASSERT(ret == 1, "Unable to write to pipefd");
+
+	ret = pthread_join(uffd->thread, NULL);
+	TEST_ASSERT(ret == 0, "Pthread_join failed.");
+
+	close(uffd->uffd);
+
+	close(uffd->pipefds[1]);
+	close(uffd->pipefds[0]);
+
+	free(uffd);
+}
+
+#endif /* __NR_userfaultfd */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
