Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 976523F0CA3
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 22:21:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47BD94A19B;
	Wed, 18 Aug 2021 16:21:56 -0400 (EDT)
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
	with ESMTP id FvMUmsQZU2S6; Wed, 18 Aug 2021 16:21:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C22F74B0F7;
	Wed, 18 Aug 2021 16:21:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A88924A19B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RATCveU65Zvn for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 16:21:43 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 925584B0D9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:40 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 n189-20020a6b8bc6000000b005b92c64b625so357916iod.20
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=yAtZtpeE6rXx+fuJoapWocNkmFQzDonUY35/KDI+IeY=;
 b=ukh2RD/BqyAU1d74OgmsRHjzX4dQVXV1GIVny8z/opUmJkGoCQ/baXzWOQljwKEOTb
 5ddhuBSix/6R092GSSnXFbderKVgnVxTCPDY3KYc5QZqttwKL6vjv0i7RK8O3JGT4dfi
 7irNwrj0kpxnn9/kqFtij4Nhx8U4tp2agScQ8QRcGIK2dUaUm8nOSoQa8RyJCad1PmZi
 0JFbI6UCd69QZh07OetfzMgHSXui+I4Qo/gULNtjX4fdDdc3Mo25mLubw5GlhEfZjJde
 jzeMkxU8bNbLZ6MXCKP3h5sVQuxfx8vKQj6tTKbvFar9IvV60AJ3eRVE71QkvjN+M5Qa
 Uo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=yAtZtpeE6rXx+fuJoapWocNkmFQzDonUY35/KDI+IeY=;
 b=knrDQq8yuYeA2Pu9RW5h/x/hfUgUtQlykMbn/F2nmiLtHrD0mV1y5Rt+gwGk/vW0tQ
 XHARcfpcwIa700zWTkbYvxl5h5vLp1y5MB/TsofC/CXgSONg2Tw99sZWX83OMHWwXTVK
 XqvkFha1FoRYldo+yMmG/EdFNkhbXHvWOwHfbS00j82XS56A9t1OXhLI7qq3EStshO0g
 RXdc/eiOE06YDDEqar4nLQSN4DRXbHLnKpg/kQ7v1Fian1p1L7UOlhIAgFZoccbX+7Z1
 Q0VxF5PT2XmQRmqwMeAnFmFrMW3A267rsx2qnYZWZpykwU42z9L/RsUDXZgYDNrZMDJb
 Gohw==
X-Gm-Message-State: AOAM533hi6glihfaijN5rHPa5SM9OUCQI3YevBPvhj6V2gvaFgw/mHSY
 5RDHhpAvOase35gpDkoA5ENpzsxZHSQ=
X-Google-Smtp-Source: ABdhPJx8L5x+5ANU3cfMuUU/WOy3ghT1hZAvB2jAQ+JGEZsTwEMjLQGWVLtPcPNJTc+zHhaeV0CsGw50XNM=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a92:d10d:: with SMTP id
 a13mr7518827ilb.87.1629318099945; 
 Wed, 18 Aug 2021 13:21:39 -0700 (PDT)
Date: Wed, 18 Aug 2021 20:21:33 +0000
In-Reply-To: <20210818202133.1106786-1-oupton@google.com>
Message-Id: <20210818202133.1106786-5-oupton@google.com>
Mime-Version: 1.0
References: <20210818202133.1106786-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 4/4] selftests: KVM: Introduce psci_cpu_on_test
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>
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

Introduce a test for aarch64 that ensures CPU resets induced by PSCI are
reflected in the target vCPU's state, even if the target is never run
again. This is a regression test for a race between vCPU migration and
PSCI.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/psci_cpu_on_test.c  | 121 ++++++++++++++++++
 .../selftests/kvm/include/aarch64/processor.h |   3 +
 4 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 0709af0144c8..98053d3afbda 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /aarch64/debug-exceptions
 /aarch64/get-reg-list
+/aarch64/psci_cpu_on_test
 /aarch64/vgic_init
 /s390x/memop
 /s390x/resets
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..5d05801ab816 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -86,6 +86,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
+TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
new file mode 100644
index 000000000000..018c269990e1
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * psci_cpu_on_test - Test that the observable state of a vCPU targeted by the
+ * CPU_ON PSCI call matches what the caller requested.
+ *
+ * Copyright (c) 2021 Google LLC.
+ *
+ * This is a regression test for a race between KVM servicing the PSCI call and
+ * userspace reading the vCPUs registers.
+ */
+
+#define _GNU_SOURCE
+
+#include <linux/psci.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define VCPU_ID_SOURCE 0
+#define VCPU_ID_TARGET 1
+
+#define CPU_ON_ENTRY_ADDR 0xfeedf00dul
+#define CPU_ON_CONTEXT_ID 0xdeadc0deul
+
+static uint64_t psci_cpu_on(uint64_t target_cpu, uint64_t entry_addr,
+			    uint64_t context_id)
+{
+	register uint64_t x0 asm("x0") = PSCI_0_2_FN64_CPU_ON;
+	register uint64_t x1 asm("x1") = target_cpu;
+	register uint64_t x2 asm("x2") = entry_addr;
+	register uint64_t x3 asm("x3") = context_id;
+
+	asm("hvc #0"
+	    : "=r"(x0)
+	    : "r"(x0), "r"(x1), "r"(x2), "r"(x3)
+	    : "memory");
+
+	return x0;
+}
+
+static uint64_t psci_affinity_info(uint64_t target_affinity,
+				   uint64_t lowest_affinity_level)
+{
+	register uint64_t x0 asm("x0") = PSCI_0_2_FN64_AFFINITY_INFO;
+	register uint64_t x1 asm("x1") = target_affinity;
+	register uint64_t x2 asm("x2") = lowest_affinity_level;
+
+	asm("hvc #0"
+	    : "=r"(x0)
+	    : "r"(x0), "r"(x1), "r"(x2)
+	    : "memory");
+
+	return x0;
+}
+
+static void guest_main(uint64_t target_cpu)
+{
+	GUEST_ASSERT(!psci_cpu_on(target_cpu, CPU_ON_ENTRY_ADDR, CPU_ON_CONTEXT_ID));
+	uint64_t target_state;
+
+	do {
+		target_state = psci_affinity_info(target_cpu, 0);
+
+		GUEST_ASSERT((target_state == PSCI_0_2_AFFINITY_LEVEL_ON) ||
+			     (target_state == PSCI_0_2_AFFINITY_LEVEL_OFF));
+	} while (target_state != PSCI_0_2_AFFINITY_LEVEL_ON);
+
+	GUEST_DONE();
+}
+
+int main(void)
+{
+	uint64_t target_mpidr, obs_pc, obs_x0;
+	struct kvm_vcpu_init init;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	kvm_vm_elf_load(vm, program_invocation_name);
+	ucall_init(vm, NULL);
+
+	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
+	init.features[0] |= (1 << KVM_ARM_VCPU_PSCI_0_2);
+
+	aarch64_vcpu_add_default(vm, VCPU_ID_SOURCE, &init, guest_main);
+
+	/*
+	 * make sure the target is already off when executing the test.
+	 */
+	init.features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
+	aarch64_vcpu_add_default(vm, VCPU_ID_TARGET, &init, guest_main);
+
+	get_reg(vm, VCPU_ID_TARGET, ARM64_SYS_REG(MPIDR_EL1), &target_mpidr);
+	vcpu_args_set(vm, VCPU_ID_SOURCE, 1, target_mpidr & MPIDR_HWID_BITMASK);
+	vcpu_run(vm, VCPU_ID_SOURCE);
+
+	switch (get_ucall(vm, VCPU_ID_SOURCE, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0], __FILE__,
+			  uc.args[1]);
+		break;
+	default:
+		TEST_FAIL("Unhandled ucall: %lu", uc.cmd);
+	}
+
+	get_reg(vm, VCPU_ID_TARGET, ARM64_CORE_REG(regs.pc), &obs_pc);
+	get_reg(vm, VCPU_ID_TARGET, ARM64_CORE_REG(regs.regs[0]), &obs_x0);
+
+	TEST_ASSERT(obs_pc == CPU_ON_ENTRY_ADDR,
+		    "unexpected target cpu pc: %lx (expected: %lx)",
+		    obs_pc, CPU_ON_ENTRY_ADDR);
+	TEST_ASSERT(obs_x0 == CPU_ON_CONTEXT_ID,
+		    "unexpected target context id: %lx (expected: %lx)",
+		    obs_x0, CPU_ON_CONTEXT_ID);
+
+	kvm_vm_free(vm);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 27dc5c2e56b9..c0273aefa63d 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -17,6 +17,7 @@
 #define CPACR_EL1               3, 0,  1, 0, 2
 #define TCR_EL1                 3, 0,  2, 0, 2
 #define MAIR_EL1                3, 0, 10, 2, 0
+#define MPIDR_EL1               3, 0,  0, 0, 5
 #define TTBR0_EL1               3, 0,  2, 0, 0
 #define SCTLR_EL1               3, 0,  1, 0, 0
 #define VBAR_EL1                3, 0, 12, 0, 0
@@ -40,6 +41,8 @@
 			  (0xfful << (4 * 8)) | \
 			  (0xbbul << (5 * 8)))
 
+#define MPIDR_HWID_BITMASK (0xff00fffffful)
+
 static inline void get_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint64_t *addr)
 {
 	struct kvm_one_reg reg;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
