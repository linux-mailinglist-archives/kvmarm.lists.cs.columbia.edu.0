Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC35402E2A
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 20:10:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF0954079D;
	Tue,  7 Sep 2021 14:10:07 -0400 (EDT)
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
	with ESMTP id roXPEsBOZxqa; Tue,  7 Sep 2021 14:10:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AB524B192;
	Tue,  7 Sep 2021 14:10:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB8C24B10E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 14:10:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1y5fI1kztnha for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 14:10:04 -0400 (EDT)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A411B4A19A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 14:10:04 -0400 (EDT)
Received: by mail-pf1-f202.google.com with SMTP id
 c7-20020aa788070000b029035630a4b35dso5618880pfo.9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Sep 2021 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=G7khVBYFvA49zN1MZ52NeR3EN5XVTugXq2LEuJFRcSA=;
 b=j5Bz7AXuSg3CFWHBEXnXFwThJ99vfcD2XwHZE92kzgu1zge+KC2SWxZD61KbdFqOcR
 ASi8mmRYrhCFzIel0syhVI1xrdwW7So4mf0kTjL1ajiGQnzgvjxIz3ogBXSdOKsUfqum
 zKbDsZ6FD/vBqHeqAltqAEMvaZV3SopNjeyIIvAt6BNbxVjycueIl+y4fPhVT8QdxqeA
 QaJlxgkul+qDZGk4SgsFv40rGrPwaQuYvNu+dLWZEapdx/c6Kr9a8RMuznpAUviZZfeh
 9ahG+mehOIbgso7lxiEuic4NL/jCz2X7BVllvRYwv7JigC0jR1nkpR5OmyvQFFf9VfXz
 tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=G7khVBYFvA49zN1MZ52NeR3EN5XVTugXq2LEuJFRcSA=;
 b=ReJPHIQ7kjuRgTrpkwCLo2lSa8B1vhyoctio3VG6r7DOLPWvGysOp7UDQOP9OQo5ZO
 4JNiBIhyCB+BbS2XmnIsmctnt+jYSbpEFJteWB3p0gKXi1pXX5rneGn+zY+jDRgmGiiQ
 qbJfD6jlX/H9gGtIccYLvy3Kmh1drKkFQWJ3eVitO66yeOdaQ2kzgmBVY/4jZHRjjP/G
 CXp0+98EgmEQqPjCCOIWyKQfpAx4l7zLuN+ls629ygqrhZuMFStxPb9xbhU7rVEKEtBI
 gsQtEWoLVm+MXmfukFa1g24Qfzb5RtRwh5/hIrKY0onyQCey+CzAm9YjXhc/Kt0bgkRa
 DOcA==
X-Gm-Message-State: AOAM532gH+g5ZzBB0V7i8DQRz000deEwP1KQR6v1VhgzIpCvJ1L9BthH
 LIDuyjA6iJeTWXHRmJy8xKgOJjvBCkS18Q==
X-Google-Smtp-Source: ABdhPJzOG5I1fc7cdWS5mntyea5A+bvSpEcgpb5MNPWkd63BQ4U5Q72ws4t4TnVZOwpxXfsKb56ncunp1kc5Vw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:902:c613:b0:136:5fc8:5372 with SMTP
 id r19-20020a170902c61300b001365fc85372mr15873926plr.41.1631038203685; Tue,
 07 Sep 2021 11:10:03 -0700 (PDT)
Date: Tue,  7 Sep 2021 11:09:56 -0700
In-Reply-To: <20210907180957.609966-1-ricarkol@google.com>
Message-Id: <20210907180957.609966-2-ricarkol@google.com>
Mime-Version: 1.0
References: <20210907180957.609966-1-ricarkol@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v2 1/2] KVM: selftests: make memslot_perf_test arch independent
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>,
 maciej.szmigiero@oracle.com
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

memslot_perf_test uses ucalls for synchronization between guest and
host. Ucalls API is architecture independent: tests do not need to know
details like what kind of exit they generate on a specific arch.  More
specifically, there is no need to check whether an exit is KVM_EXIT_IO
in x86 for the host to know that the exit is ucall related, as
get_ucall() already makes that check.

Change memslot_perf_test to not require specifying what exit does a
ucall generate. Also add a missing ucall_init.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../testing/selftests/kvm/memslot_perf_test.c | 56 +++++++++++--------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index d6e381e01db7..1727f75e0c2c 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -127,43 +127,54 @@ static bool verbose;
 			pr_info(__VA_ARGS__);	\
 	} while (0)
 
+static void check_mmio_access(struct vm_data *vm, struct kvm_run *run)
+{
+	TEST_ASSERT(vm->mmio_ok, "Unexpected mmio exit");
+	TEST_ASSERT(run->mmio.is_write, "Unexpected mmio read");
+	TEST_ASSERT(run->mmio.len == 8,
+		    "Unexpected exit mmio size = %u", run->mmio.len);
+	TEST_ASSERT(run->mmio.phys_addr >= vm->mmio_gpa_min &&
+		    run->mmio.phys_addr <= vm->mmio_gpa_max,
+		    "Unexpected exit mmio address = 0x%llx",
+		    run->mmio.phys_addr);
+}
+
 static void *vcpu_worker(void *data)
 {
 	struct vm_data *vm = data;
 	struct kvm_run *run;
 	struct ucall uc;
-	uint64_t cmd;
 
 	run = vcpu_state(vm->vm, VCPU_ID);
 	while (1) {
 		vcpu_run(vm->vm, VCPU_ID);
 
-		if (run->exit_reason == KVM_EXIT_IO) {
-			cmd = get_ucall(vm->vm, VCPU_ID, &uc);
-			if (cmd != UCALL_SYNC)
-				break;
-
+		switch (get_ucall(vm->vm, VCPU_ID, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT(uc.args[1] == 0,
+				"Unexpected sync ucall, got %lx",
+				(ulong)uc.args[1]);
 			sem_post(&vcpu_ready);
 			continue;
-		}
-
-		if (run->exit_reason != KVM_EXIT_MMIO)
+		case UCALL_NONE:
+			if (run->exit_reason == KVM_EXIT_MMIO)
+				check_mmio_access(vm, run);
+			else
+				goto done;
 			break;
-
-		TEST_ASSERT(vm->mmio_ok, "Unexpected mmio exit");
-		TEST_ASSERT(run->mmio.is_write, "Unexpected mmio read");
-		TEST_ASSERT(run->mmio.len == 8,
-			    "Unexpected exit mmio size = %u", run->mmio.len);
-		TEST_ASSERT(run->mmio.phys_addr >= vm->mmio_gpa_min &&
-			    run->mmio.phys_addr <= vm->mmio_gpa_max,
-			    "Unexpected exit mmio address = 0x%llx",
-			    run->mmio.phys_addr);
+		case UCALL_ABORT:
+			TEST_FAIL("%s at %s:%ld, val = %lu",
+					(const char *)uc.args[0],
+					__FILE__, uc.args[1], uc.args[2]);
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
 	}
 
-	if (run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
-		TEST_FAIL("%s at %s:%ld, val = %lu", (const char *)uc.args[0],
-			  __FILE__, uc.args[1], uc.args[2]);
-
+done:
 	return NULL;
 }
 
@@ -268,6 +279,7 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	TEST_ASSERT(data->hva_slots, "malloc() fail");
 
 	data->vm = vm_create_default(VCPU_ID, mempages, guest_code);
+	ucall_init(data->vm, NULL);
 
 	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
 		max_mem_slots - 1, data->pages_per_slot, rempages);
-- 
2.33.0.153.gba50c8fa24-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
