Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 943992A338C
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 20:03:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47E7F4B568;
	Mon,  2 Nov 2020 14:03:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yYHI0ZeC2h29; Mon,  2 Nov 2020 14:03:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 715A14B57B;
	Mon,  2 Nov 2020 14:03:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 407384B3E9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 14:03:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTSC2EJpW8zC for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 14:03:26 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AC4054B382
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 14:03:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C63jy3hqdadYKSteR0FEPZe7aVUDW7HgDsq8q1jdpHQ=;
 b=B1TTiBFiu8EXTTwVjnqK9GuEkB/IzY6DYVQcEZXhtdddivM64YdxkhNfwSltrOIZQALGzm
 SR265pz3jup7k/vQpovr3/gC+5u89vL2UXnXYOs/PGIn2aS4Yi+StAN4hJlVljSdTfKGFx
 B1yP8O3CZypI6lKocP2KCpvz4MUk7dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-p85GC5u6NTK494Bqtwfs-Q-1; Mon, 02 Nov 2020 14:03:21 -0500
X-MC-Unique: p85GC5u6NTK494Bqtwfs-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 836AD188C136;
 Mon,  2 Nov 2020 19:03:20 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED81A5B4A1;
 Mon,  2 Nov 2020 19:03:14 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 3/3] KVM: selftests: Add blessed SVE registers to
 get-reg-list
Date: Mon,  2 Nov 2020 20:02:53 +0100
Message-Id: <20201102190253.50575-4-drjones@redhat.com>
In-Reply-To: <20201102190253.50575-1-drjones@redhat.com>
References: <20201102190253.50575-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com, Dave.Martin@arm.com, maz@kernel.org
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

Add support for the SVE registers to get-reg-list and create a
new test, get-reg-list-sve, which tests them when running on a
machine with SVE support.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/get-reg-list-sve.c  |   3 +
 .../selftests/kvm/aarch64/get-reg-list.c      | 254 +++++++++++++++---
 4 files changed, 217 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/get-reg-list-sve.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index b2fc44bf8c3c..795535a33312 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /aarch64/get-reg-list
+/aarch64/get-reg-list-sve
 /s390x/memop
 /s390x/resets
 /s390x/sync_regs_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 54c931e70089..48c28129f78c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -66,6 +66,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
+TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list-sve.c b/tools/testing/selftests/kvm/aarch64/get-reg-list-sve.c
new file mode 100644
index 000000000000..efba76682b4b
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list-sve.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define REG_LIST_SVE
+#include "get-reg-list.c"
diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index db97001f37f7..6ca27beb6a5f 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -29,6 +29,13 @@
 #include <string.h>
 #include "kvm_util.h"
 #include "test_util.h"
+#include "processor.h"
+
+#ifdef REG_LIST_SVE
+#define reg_list_sve() (true)
+#else
+#define reg_list_sve() (false)
+#endif
 
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_COPROC_MASK)
 
@@ -46,8 +53,9 @@
 
 static struct kvm_reg_list *reg_list;
 
-static __u64 blessed_reg[];
-static __u64 blessed_n;
+static __u64 base_regs[], vregs[], sve_regs[], rejects_set[];
+static __u64 base_regs_n, vregs_n, sve_regs_n, rejects_set_n;
+static __u64 *blessed_reg, blessed_n;
 
 static bool find_reg(__u64 regs[], __u64 nr_regs, __u64 reg)
 {
@@ -119,6 +127,40 @@ static const char *core_id_to_str(__u64 id)
 	return NULL;
 }
 
+static const char *sve_id_to_str(__u64 id)
+{
+	__u64 sve_off, n, i;
+
+	if (id == KVM_REG_ARM64_SVE_VLS)
+		return "KVM_REG_ARM64_SVE_VLS";
+
+	sve_off = id & ~(REG_MASK | ((1ULL << 5) - 1));
+	i = id & (KVM_ARM64_SVE_MAX_SLICES - 1);
+
+	TEST_ASSERT(i == 0, "Currently we don't expect slice > 0, reg id 0x%llx", id);
+
+	switch (sve_off) {
+	case KVM_REG_ARM64_SVE_ZREG_BASE ...
+	     KVM_REG_ARM64_SVE_ZREG_BASE + (1ULL << 5) * KVM_ARM64_SVE_NUM_ZREGS - 1:
+		n = (id >> 5) & (KVM_ARM64_SVE_NUM_ZREGS - 1);
+		TEST_ASSERT(id == KVM_REG_ARM64_SVE_ZREG(n, 0),
+			    "Unexpected bits set in SVE ZREG id: 0x%llx", id);
+		return str_with_index("KVM_REG_ARM64_SVE_ZREG(##, 0)", n);
+	case KVM_REG_ARM64_SVE_PREG_BASE ...
+	     KVM_REG_ARM64_SVE_PREG_BASE + (1ULL << 5) * KVM_ARM64_SVE_NUM_PREGS - 1:
+		n = (id >> 5) & (KVM_ARM64_SVE_NUM_PREGS - 1);
+		TEST_ASSERT(id == KVM_REG_ARM64_SVE_PREG(n, 0),
+			    "Unexpected bits set in SVE PREG id: 0x%llx", id);
+		return str_with_index("KVM_REG_ARM64_SVE_PREG(##, 0)", n);
+	case KVM_REG_ARM64_SVE_FFR_BASE:
+		TEST_ASSERT(id == KVM_REG_ARM64_SVE_FFR(0),
+			    "Unexpected bits set in SVE FFR id: 0x%llx", id);
+		return "KVM_REG_ARM64_SVE_FFR(0)";
+	}
+
+	return NULL;
+}
+
 static void print_reg(__u64 id)
 {
 	unsigned op0, op1, crn, crm, op2;
@@ -186,7 +228,10 @@ static void print_reg(__u64 id)
 		printf("\tKVM_REG_ARM_FW_REG(%lld),\n", id & 0xffff);
 		break;
 	case KVM_REG_ARM64_SVE:
-		TEST_FAIL("KVM_REG_ARM64_SVE is an unexpected coproc type in reg id: 0x%llx", id);
+		if (reg_list_sve())
+			printf("\t%s,\n", sve_id_to_str(id));
+		else
+			TEST_FAIL("KVM_REG_ARM64_SVE is an unexpected coproc type in reg id: 0x%llx", id);
 		break;
 	default:
 		TEST_FAIL("Unexpected coproc type: 0x%llx in reg id: 0x%llx",
@@ -251,12 +296,40 @@ static void core_reg_fixup(void)
 	reg_list = tmp;
 }
 
+static void prepare_vcpu_init(struct kvm_vcpu_init *init)
+{
+	if (reg_list_sve())
+		init->features[0] |= 1 << KVM_ARM_VCPU_SVE;
+}
+
+static void finalize_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	int feature;
+
+	if (reg_list_sve()) {
+		feature = KVM_ARM_VCPU_SVE;
+		vcpu_ioctl(vm, vcpuid, KVM_ARM_VCPU_FINALIZE, &feature);
+	}
+}
+
+static void check_supported(void)
+{
+	if (reg_list_sve() && !kvm_check_cap(KVM_CAP_ARM_SVE)) {
+		fprintf(stderr, "SVE not available, skipping tests\n");
+		exit(KSFT_SKIP);
+	}
+}
+
 int main(int ac, char **av)
 {
+	struct kvm_vcpu_init init = { .target = -1, };
 	int new_regs = 0, missing_regs = 0, i;
-	int failed_get = 0, failed_set = 0;
+	int failed_get = 0, failed_set = 0, failed_reject = 0;
 	bool print_list = false, fixup_core_regs = false;
 	struct kvm_vm *vm;
+	__u64 *vec_regs;
+
+	check_supported();
 
 	for (i = 1; i < ac; ++i) {
 		if (strcmp(av[i], "--core-reg-fixup") == 0)
@@ -267,7 +340,11 @@ int main(int ac, char **av)
 			TEST_FAIL("Unknown option: %s\n", av[i]);
 	}
 
-	vm = vm_create_default(0, 0, NULL);
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	prepare_vcpu_init(&init);
+	aarch64_vcpu_add_default(vm, 0, &init, NULL);
+	finalize_vcpu(vm, 0);
+
 	reg_list = vcpu_get_reg_list(vm, 0);
 
 	if (fixup_core_regs)
@@ -307,6 +384,18 @@ int main(int ac, char **av)
 			++failed_get;
 		}
 
+		/* rejects_set registers are rejected after KVM_ARM_VCPU_FINALIZE */
+		if (find_reg(rejects_set, rejects_set_n, reg.id)) {
+			ret = _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
+			if (ret != -1 || errno != EPERM) {
+				printf("Failed to reject (ret=%d, errno=%d) ", ret, errno);
+				print_reg(reg.id);
+				putchar('\n');
+				++failed_reject;
+			}
+			continue;
+		}
+
 		ret = _vcpu_ioctl(vm, 0, KVM_SET_ONE_REG, &reg);
 		if (ret) {
 			puts("Failed to set ");
@@ -316,6 +405,20 @@ int main(int ac, char **av)
 		}
 	}
 
+	if (reg_list_sve()) {
+		blessed_n = base_regs_n + sve_regs_n;
+		vec_regs = sve_regs;
+	} else {
+		blessed_n = base_regs_n + vregs_n;
+		vec_regs = vregs;
+	}
+
+	blessed_reg = calloc(blessed_n, sizeof(__u64));
+	for (i = 0; i < base_regs_n; ++i)
+		blessed_reg[i] = base_regs[i];
+	for (i = 0; i < blessed_n - base_regs_n; ++i)
+		blessed_reg[base_regs_n + i] = vec_regs[i];
+
 	for_each_new_reg(i)
 		++new_regs;
 
@@ -344,9 +447,10 @@ int main(int ac, char **av)
 		putchar('\n');
 	}
 
-	TEST_ASSERT(!missing_regs && !failed_get && !failed_set,
-		    "There are %d missing registers; %d registers failed get; %d registers failed set",
-		    missing_regs, failed_get, failed_set);
+	TEST_ASSERT(!missing_regs && !failed_get && !failed_set && !failed_reject,
+		    "There are %d missing registers; "
+		    "%d registers failed get; %d registers failed set; %d registers failed reject",
+		    missing_regs, failed_get, failed_set, failed_reject);
 
 	return 0;
 }
@@ -357,7 +461,7 @@ int main(int ac, char **av)
  *
  * The blessed list is up to date with kernel version v5.10-rc2
  */
-static __u64 blessed_reg[] = {
+static __u64 base_regs[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[0]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[1]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[2]),
@@ -399,38 +503,6 @@ static __u64 blessed_reg[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(spsr[2]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(spsr[3]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(spsr[4]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[1]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[2]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[3]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[4]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[5]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[6]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[7]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[8]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[9]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[10]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[11]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[12]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[13]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[14]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[15]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[16]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[17]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[18]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[19]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[20]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[21]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[22]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[23]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[24]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[25]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[26]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[27]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[28]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[29]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[30]),
-	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.fpsr),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.fpcr),
 	KVM_REG_ARM_FW_REG(0),
@@ -670,4 +742,102 @@ static __u64 blessed_reg[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX | KVM_REG_ARM_DEMUX_ID_CCSIDR | 1,
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX | KVM_REG_ARM_DEMUX_ID_CCSIDR | 2,
 };
-static __u64 blessed_n = ARRAY_SIZE(blessed_reg);
+static __u64 base_regs_n = ARRAY_SIZE(base_regs);
+
+static __u64 vregs[] = {
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[1]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[2]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[3]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[4]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[5]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[6]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[7]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[8]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[9]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[10]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[11]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[12]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[13]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[14]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[15]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[16]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[17]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[18]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[19]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[20]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[21]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[22]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[23]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[24]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[25]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[26]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[27]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[28]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[29]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[30]),
+	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]),
+};
+static __u64 vregs_n = ARRAY_SIZE(vregs);
+
+static __u64 sve_regs[] = {
+	KVM_REG_ARM64_SVE_VLS,
+	KVM_REG_ARM64_SVE_ZREG(0, 0),
+	KVM_REG_ARM64_SVE_ZREG(1, 0),
+	KVM_REG_ARM64_SVE_ZREG(2, 0),
+	KVM_REG_ARM64_SVE_ZREG(3, 0),
+	KVM_REG_ARM64_SVE_ZREG(4, 0),
+	KVM_REG_ARM64_SVE_ZREG(5, 0),
+	KVM_REG_ARM64_SVE_ZREG(6, 0),
+	KVM_REG_ARM64_SVE_ZREG(7, 0),
+	KVM_REG_ARM64_SVE_ZREG(8, 0),
+	KVM_REG_ARM64_SVE_ZREG(9, 0),
+	KVM_REG_ARM64_SVE_ZREG(10, 0),
+	KVM_REG_ARM64_SVE_ZREG(11, 0),
+	KVM_REG_ARM64_SVE_ZREG(12, 0),
+	KVM_REG_ARM64_SVE_ZREG(13, 0),
+	KVM_REG_ARM64_SVE_ZREG(14, 0),
+	KVM_REG_ARM64_SVE_ZREG(15, 0),
+	KVM_REG_ARM64_SVE_ZREG(16, 0),
+	KVM_REG_ARM64_SVE_ZREG(17, 0),
+	KVM_REG_ARM64_SVE_ZREG(18, 0),
+	KVM_REG_ARM64_SVE_ZREG(19, 0),
+	KVM_REG_ARM64_SVE_ZREG(20, 0),
+	KVM_REG_ARM64_SVE_ZREG(21, 0),
+	KVM_REG_ARM64_SVE_ZREG(22, 0),
+	KVM_REG_ARM64_SVE_ZREG(23, 0),
+	KVM_REG_ARM64_SVE_ZREG(24, 0),
+	KVM_REG_ARM64_SVE_ZREG(25, 0),
+	KVM_REG_ARM64_SVE_ZREG(26, 0),
+	KVM_REG_ARM64_SVE_ZREG(27, 0),
+	KVM_REG_ARM64_SVE_ZREG(28, 0),
+	KVM_REG_ARM64_SVE_ZREG(29, 0),
+	KVM_REG_ARM64_SVE_ZREG(30, 0),
+	KVM_REG_ARM64_SVE_ZREG(31, 0),
+	KVM_REG_ARM64_SVE_PREG(0, 0),
+	KVM_REG_ARM64_SVE_PREG(1, 0),
+	KVM_REG_ARM64_SVE_PREG(2, 0),
+	KVM_REG_ARM64_SVE_PREG(3, 0),
+	KVM_REG_ARM64_SVE_PREG(4, 0),
+	KVM_REG_ARM64_SVE_PREG(5, 0),
+	KVM_REG_ARM64_SVE_PREG(6, 0),
+	KVM_REG_ARM64_SVE_PREG(7, 0),
+	KVM_REG_ARM64_SVE_PREG(8, 0),
+	KVM_REG_ARM64_SVE_PREG(9, 0),
+	KVM_REG_ARM64_SVE_PREG(10, 0),
+	KVM_REG_ARM64_SVE_PREG(11, 0),
+	KVM_REG_ARM64_SVE_PREG(12, 0),
+	KVM_REG_ARM64_SVE_PREG(13, 0),
+	KVM_REG_ARM64_SVE_PREG(14, 0),
+	KVM_REG_ARM64_SVE_PREG(15, 0),
+	KVM_REG_ARM64_SVE_FFR(0),
+	ARM64_SYS_REG(3, 0, 1, 2, 0),   /* ZCR_EL1 */
+};
+static __u64 sve_regs_n = ARRAY_SIZE(sve_regs);
+
+static __u64 rejects_set[] = {
+#ifdef REG_LIST_SVE
+	KVM_REG_ARM64_SVE_VLS,
+#endif
+};
+static __u64 rejects_set_n = ARRAY_SIZE(rejects_set);
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
