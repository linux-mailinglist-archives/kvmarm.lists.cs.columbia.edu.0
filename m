Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D99252F5EE8
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 11:38:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 880E44B1A3;
	Thu, 14 Jan 2021 05:38:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDvUGHe+Zl0i; Thu, 14 Jan 2021 05:38:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CAF74B1A1;
	Thu, 14 Jan 2021 05:38:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4C464B17B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 05:38:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2-hVa-g6T-Dh for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 05:38:04 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 201064B088
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 05:38:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610620684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=anic7JISky5J6tklMTUhQNcEcEwIWLMFbg21MvKTITY=;
 b=Xp68q79kYOEhZVNsfqpuf8naKofXHhBvVPPvEMtYuwFw3Jv86L4B8XYs/WJK0bpWo2yL/b
 6Omm77rEJ2lq1ioYpxKiMtJr3CvjUyHkZFBOlYQCpfkB4aKMpjMTedKcVRP67fBpVrXHi7
 aQAgKuZpMK8yCnQ23RoOFCH1gIHPugo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-TGE2NxQmOWiCPsNfT9Yglw-1; Thu, 14 Jan 2021 05:38:00 -0500
X-MC-Unique: TGE2NxQmOWiCPsNfT9Yglw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B488100C62F;
 Thu, 14 Jan 2021 10:37:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-165.ams2.redhat.com [10.36.114.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9332F12D7E;
 Thu, 14 Jan 2021 10:37:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com
Subject: [PATCH v2 9/9] KVM: selftests: aarch64/vgic-v3 init sequence tests
Date: Thu, 14 Jan 2021 11:37:08 +0100
Message-Id: <20210114103708.26763-10-eric.auger@redhat.com>
In-Reply-To: <20210114103708.26763-1-eric.auger@redhat.com>
References: <20210114103708.26763-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com, shuah@kernel.org
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

The tests exercise the VGIC_V3 device creation including the
associated KVM_DEV_ARM_VGIC_GRP_ADDR group attributes:

- KVM_VGIC_V3_ADDR_TYPE_DIST/REDIST (vcpu_first and vgic_first)
- KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (redist_regions).

Another test dedicates to KVM_DEV_ARM_VGIC_GRP_REDIST_REGS group
and especially the GICR_TYPER read. The goal was to test the case
recently fixed by commit 23bde34771f1
("KVM: arm64: vgic-v3: Drop the reporting of GICR_TYPER.Last for userspace").

The API under test can be found at
Documentation/virt/kvm/devices/arm-vgic-v3.rst

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/aarch64/vgic_init.c | 453 ++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   5 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  51 ++
 4 files changed, 510 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/vgic_init.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index fe41c6a0fa67..c3c2cb6fe8a1 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -68,6 +68,7 @@ TEST_GEN_PROGS_x86_64 += steal_time
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
+TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
new file mode 100644
index 000000000000..e8caa64c0395
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * vgic init sequence tests
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ */
+#define _GNU_SOURCE
+#include <linux/kernel.h>
+#include <sys/syscall.h>
+#include <asm/kvm.h>
+#include <asm/kvm_para.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define NR_VCPUS		4
+
+#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) (((uint64_t)(count) << 52) | \
+	((uint64_t)((base) >> 16) << 16) | ((uint64_t)(flags) << 12) | index)
+#define REG_OFFSET(vcpu, offset) (((uint64_t)vcpu << 32) | offset)
+
+#define GICR_TYPER 0x8
+
+static int access_redist_reg(int gicv3_fd, int vcpu, int offset,
+			     uint32_t *val, bool write)
+{
+	uint64_t attr = REG_OFFSET(vcpu, offset);
+
+	return kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+				 attr, val, write);
+}
+
+static void guest_code(int cpu)
+{
+	GUEST_SYNC(0);
+	GUEST_SYNC(1);
+	GUEST_SYNC(2);
+	GUEST_DONE();
+}
+
+static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	static int run;
+	struct ucall uc;
+	int ret;
+
+	vcpu_args_set(vm, vcpuid, 1, vcpuid);
+	ret = _vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
+	get_ucall(vm, vcpuid, &uc);
+	run++;
+
+	if (ret)
+		return -errno;
+	return 0;
+}
+
+int dist_rdist_tests(struct kvm_vm *vm)
+{
+	int ret, gicv3_fd, max_ipa_bits;
+	uint64_t addr;
+
+	max_ipa_bits = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
+
+	ret = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
+	if (ret) {
+		print_skip("GICv3 not supported");
+		exit(KSFT_SKIP);
+	}
+
+	ret = kvm_create_device(vm, 0, true);
+	TEST_ASSERT(ret == -ENODEV, "unsupported device");
+
+	/* Create the device */
+
+	gicv3_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	TEST_ASSERT(gicv3_fd > 0, "GICv3 device created");
+
+	/* Check attributes */
+
+	ret = kvm_device_check_attr(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				    KVM_VGIC_V3_ADDR_TYPE_DIST);
+	TEST_ASSERT(!ret, "KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_DIST supported");
+
+	ret = kvm_device_check_attr(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				    KVM_VGIC_V3_ADDR_TYPE_REDIST);
+	TEST_ASSERT(!ret, "KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST supported");
+
+	ret = kvm_device_check_attr(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, 0);
+	TEST_ASSERT(ret == -ENXIO, "attribute not supported");
+
+	/* misaligned DIST and REDIST addresses */
+
+	addr = 0x1000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "GICv3 dist base not 64kB aligned");
+
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "GICv3 redist base not 64kB aligned");
+
+	/* out of range address */
+	if (max_ipa_bits) {
+		addr = 1ULL << max_ipa_bits;
+		ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+					KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
+		TEST_ASSERT(ret == -E2BIG, "dist address beyond IPA limit");
+
+		ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+					KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+		TEST_ASSERT(ret == -E2BIG, "redist address beyond IPA limit");
+	}
+
+	/* set REDIST base address */
+	addr = 0x00000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+	TEST_ASSERT(!ret, "GICv3 redist base set");
+
+	addr = 0xE0000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+	TEST_ASSERT(ret == -EEXIST, "GICv3 redist base set again");
+
+	addr = REDIST_REGION_ATTR_ADDR(NR_VCPUS, 0x100000, 0, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "attempt to mix GICv3 REDIST and REDIST_REGION");
+
+	/*
+	 * Set overlapping DIST / REDIST, cannot be detected here. Will be detected
+	 * on first vcpu run instead.
+	 */
+	addr = 3 * 2 * 0x10000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, KVM_VGIC_V3_ADDR_TYPE_DIST,
+				&addr, true);
+	TEST_ASSERT(!ret, "dist overlapping rdist");
+
+	ret = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	TEST_ASSERT(ret == -EEXIST, "create GICv3 device twice");
+
+	ret = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
+	TEST_ASSERT(!ret, "create GICv3 in test mode while the same already is created");
+
+	if (!kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V2, true)) {
+		ret = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V2, true);
+		TEST_ASSERT(ret == -EINVAL, "create GICv2 while v3 exists");
+	}
+
+	return gicv3_fd;
+}
+
+static int redist_region_tests(struct kvm_vm *vm, int gicv3_fd)
+{
+	int ret, max_ipa_bits;
+	uint64_t addr, expected_addr;
+
+	max_ipa_bits = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
+
+	ret = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
+	if (ret) {
+		print_skip("GICv3 not supported");
+		exit(KSFT_SKIP);
+	}
+
+	if (gicv3_fd < 0) {
+		gicv3_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+		TEST_ASSERT(gicv3_fd >= 0, "VGIC_V3 device created");
+	}
+
+	ret = kvm_device_check_attr(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				    KVM_VGIC_V3_ADDR_TYPE_REDIST);
+	TEST_ASSERT(!ret, "Multiple redist regions advertised");
+
+	addr = REDIST_REGION_ATTR_ADDR(NR_VCPUS, 0x100000, 2, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "redist region attr value with flags != 0");
+
+	addr = REDIST_REGION_ATTR_ADDR(0, 0x100000, 0, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "redist region attr value with count== 0");
+
+	addr = REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "attempt to register the first rdist region with index != 0");
+
+	addr = REDIST_REGION_ATTR_ADDR(2, 0x201000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "rdist region with misaligned address");
+
+	addr = REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "First valid redist region with 2 rdist @ 0x200000, index 0");
+
+	addr = REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "register an rdist region with already used index");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x210000, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "register an rdist region overlapping with another one");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x240000, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "register redist region with index not +1");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x240000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "register valid redist region with 1 rdist @ 0x220000, index 1");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 1ULL << max_ipa_bits, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -E2BIG, "register redist region with base address beyond IPA range");
+
+	addr = 0x260000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "Mix KVM_VGIC_V3_ADDR_TYPE_REDIST and REDIST_REGION");
+
+	/*
+	 * Now there are 2 redist regions:
+	 * region 0 @ 0x200000 2 redists
+	 * region 1 @ 0x240000 1 redist
+	 * now attempt to read their characteristics
+	 */
+
+	addr = REDIST_REGION_ATTR_ADDR(0, 0, 0, 0);
+	expected_addr = REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, false);
+	TEST_ASSERT(!ret && addr == expected_addr, "read characteristics of region #0");
+
+	addr = REDIST_REGION_ATTR_ADDR(0, 0, 0, 1);
+	expected_addr = REDIST_REGION_ATTR_ADDR(1, 0x240000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, false);
+	TEST_ASSERT(!ret && addr == expected_addr, "read characteristics of region #1");
+
+	addr = REDIST_REGION_ATTR_ADDR(0, 0, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, false);
+	TEST_ASSERT(ret == -ENOENT, "read characteristics of non existing region");
+
+	addr = 0x260000;
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
+	TEST_ASSERT(!ret, "set dist region");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x260000, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "register redist region colliding with dist");
+
+	return gicv3_fd;
+}
+
+static void vgic_first(void)
+{
+	int ret, i, gicv3_fd;
+	struct kvm_vm *vm;
+
+	vm = vm_create_default(0, 0, guest_code);
+
+	gicv3_fd = dist_rdist_tests(vm);
+
+	/* Add the rest of the VCPUs */
+	for (i = 1; i < NR_VCPUS; ++i)
+		vm_vcpu_add_default(vm, i, guest_code);
+
+	ret = run_vcpu(vm, 3);
+	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
+
+	close(gicv3_fd);
+	kvm_vm_free(vm);
+}
+
+
+static void vcpu_first(void)
+{
+	int ret, i, gicv3_fd;
+	struct kvm_vm *vm;
+
+	vm = vm_create_default(0, 0, guest_code);
+
+	/* Add the rest of the VCPUs */
+	for (i = 1; i < NR_VCPUS; ++i)
+		vm_vcpu_add_default(vm, i, guest_code);
+
+	gicv3_fd = dist_rdist_tests(vm);
+
+	ret = run_vcpu(vm, 3);
+	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
+
+	close(gicv3_fd);
+	kvm_vm_free(vm);
+}
+
+static void redist_regions(void)
+{
+	int ret, i, gicv3_fd = -1;
+	struct kvm_vm *vm;
+	uint64_t addr;
+	void *dummy = NULL;
+
+	vm = vm_create_default(0, 0, guest_code);
+	ucall_init(vm, NULL);
+
+	/* Add the rest of the VCPUs */
+	for (i = 1; i < NR_VCPUS; ++i)
+		vm_vcpu_add_default(vm, i, guest_code);
+
+	gicv3_fd = redist_region_tests(vm, gicv3_fd);
+
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+				KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+	TEST_ASSERT(!ret, "init the vgic");
+
+	ret = run_vcpu(vm, 3);
+	TEST_ASSERT(ret == -ENXIO, "running without sufficient number of rdists");
+
+	/*
+	 * At this time the kvm_vgic_map_resources destroyed the vgic
+	 * Redo everything
+	 */
+	gicv3_fd = redist_region_tests(vm, gicv3_fd);
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "register a third region allowing to cover the 4 vcpus");
+
+	ret = run_vcpu(vm, 3);
+	TEST_ASSERT(ret == -EBUSY, "running without vgic explicit init");
+
+	/* again need to redo init and this time do the explicit init*/
+	gicv3_fd = redist_region_tests(vm, gicv3_fd);
+
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
+	TEST_ASSERT(ret == -EFAULT, "register a third region allowing to cover the 4 vcpus");
+
+	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "register a third region allowing to cover the 4 vcpus");
+
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+				KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+	TEST_ASSERT(!ret, "init the vgic");
+
+	ret = run_vcpu(vm, 3);
+	TEST_ASSERT(!ret, "vcpu run");
+
+	close(gicv3_fd);
+	kvm_vm_free(vm);
+}
+
+static void typer_accesses(void)
+{
+	int ret, i, gicv3_fd = -1;
+	uint64_t addr;
+	struct kvm_vm *vm;
+	uint32_t val;
+
+	vm = vm_create_default(0, 0, guest_code);
+	ucall_init(vm, NULL);
+
+	gicv3_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	TEST_ASSERT(gicv3_fd >= 0, "VGIC_V3 device created");
+
+	vm_vcpu_add_default(vm, 3, guest_code);
+
+	ret = access_redist_reg(gicv3_fd, 1, GICR_TYPER, &val, false);
+	TEST_ASSERT(ret == -EINVAL, "attempting to read GICR_TYPER of non created vcpu");
+
+	vm_vcpu_add_default(vm, 1, guest_code);
+
+	ret = access_redist_reg(gicv3_fd, 1, GICR_TYPER, &val, false);
+	TEST_ASSERT(ret == -EBUSY, "read GICR_TYPER before GIC initialized");
+
+	vm_vcpu_add_default(vm, 2, guest_code);
+
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+				KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+	TEST_ASSERT(!ret, "init the vgic after the vcpu creations");
+
+	for (i = 0; i < NR_VCPUS ; i++) {
+		ret = access_redist_reg(gicv3_fd, 0, GICR_TYPER, &val, false);
+		TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
+	}
+
+	addr = REDIST_REGION_ATTR_ADDR(2, 0x200000, 0, 0);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "first rdist region with a capacity of 2 rdists");
+
+	/* The 2 first rdists should be put there (vcpu 0 and 3) */
+	ret = access_redist_reg(gicv3_fd, 0, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && !val, "read typer of rdist #0");
+
+	ret = access_redist_reg(gicv3_fd, 3, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && val == 0x310, "read typer of rdist #1");
+
+	addr = REDIST_REGION_ATTR_ADDR(10, 0x100000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(ret == -EINVAL, "collision with previous rdist region");
+
+	ret = access_redist_reg(gicv3_fd, 1, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && val == 0x100,
+		    "no redist region attached to vcpu #1 yet, last cannot be returned");
+
+	ret = access_redist_reg(gicv3_fd, 2, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && val == 0x200,
+		    "no redist region attached to vcpu #2, last cannot be returned");
+
+	addr = REDIST_REGION_ATTR_ADDR(10, 0x20000, 0, 1);
+	ret = kvm_device_access(gicv3_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
+	TEST_ASSERT(!ret, "second rdist region");
+
+	ret = access_redist_reg(gicv3_fd, 1, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #1");
+
+	ret = access_redist_reg(gicv3_fd, 2, GICR_TYPER, &val, false);
+	TEST_ASSERT(!ret && val == 0x210,
+		    "read typer of rdist #1, last properly returned");
+
+	close(gicv3_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int ac, char **av)
+{
+	vcpu_first();
+	vgic_first();
+	redist_regions();
+	typer_accesses();
+
+	return 0;
+}
+
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5cbb861525ed..2262304c6150 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -229,6 +229,11 @@ int vcpu_nested_state_set(struct kvm_vm *vm, uint32_t vcpuid,
 #endif
 void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid);
 
+int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr);
+int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test);
+int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
+		      void *val, bool write);
+
 const char *exit_reason_str(unsigned int exit_reason);
 
 void virt_pgd_alloc(struct kvm_vm *vm, uint32_t pgd_memslot);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fa5a90e6c6f0..f3c7d38cfe78 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1726,6 +1726,57 @@ int _kvm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
 	return ioctl(vm->kvm_fd, cmd, arg);
 }
 
+/*
+ * Device Ioctl
+ */
+
+int kvm_device_check_attr(int dev_fd, uint32_t group, uint64_t attr)
+{
+	struct kvm_device_attr attribute = {
+		.group = group,
+		.attr = attr,
+		.flags = 0,
+	};
+	int ret;
+
+	ret = ioctl(dev_fd, KVM_HAS_DEVICE_ATTR, &attribute);
+	if (ret == -1)
+		return -errno;
+	return ret;
+}
+
+int kvm_create_device(struct kvm_vm *vm, uint64_t type, bool test)
+{
+	struct kvm_create_device create_dev;
+	int ret;
+
+	create_dev.type = type;
+	create_dev.fd = -1;
+	create_dev.flags = test ? KVM_CREATE_DEVICE_TEST : 0;
+	ret = ioctl(vm_get_fd(vm), KVM_CREATE_DEVICE, &create_dev);
+	if (ret == -1)
+		return -errno;
+	return test ? 0 : create_dev.fd;
+}
+
+int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
+		      void *val, bool write)
+{
+	struct kvm_device_attr kvmattr = {
+		.group = group,
+		.attr = attr,
+		.flags = 0,
+		.addr = (uintptr_t)val,
+	};
+	int ret;
+
+	ret = ioctl(dev_fd, write ? KVM_SET_DEVICE_ATTR : KVM_GET_DEVICE_ATTR,
+		    &kvmattr);
+	if (ret)
+		return -errno;
+	return ret;
+}
+
 /*
  * VM Dump
  *
-- 
2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
