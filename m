Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09512421BC7
	for <lists+kvmarm@lfdr.de>; Tue,  5 Oct 2021 03:19:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD0704B26A;
	Mon,  4 Oct 2021 21:19:41 -0400 (EDT)
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
	with ESMTP id n7mG4dNZTEET; Mon,  4 Oct 2021 21:19:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87EF84B2A9;
	Mon,  4 Oct 2021 21:19:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 475194B26A
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 21:19:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5gyOPNnWvGB for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Oct 2021 21:19:36 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A156A4B2E3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Oct 2021 21:19:36 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 b9-20020a5b07890000b0290558245b7eabso25943879ybq.10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 04 Oct 2021 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xZ3lpAQvqvEeyK874ekrhdyFJaFrtuodkxZuQJWmclc=;
 b=jgZT1Lggck69qe6woDJ0WTw1urdpeGjzK3yYEYJULq1ZsKqtfYNe0hkSjvtjFxy3JV
 aAiL9OZTv2WA0JaITcIu3c4MU807tUIb9ZG0YiVzcNCWJU/ZZJDZZmoAEvWQqru8kGqV
 zQ6SMe80Ds841k7BSsck/jrTNXbKce3qabnTwZKBb7FES3n+N2kivohi2luqh+2E45DW
 IXsCEkuZ4iKC8GYxwUedf9DpSzHosJzi8inbjq0rG8PIPaH1S9CG549Qq1epj05z2D8P
 NhkEE1sB7ekIjDtwhKUhG6OjKngT1kACs72kX2ACpuYIlxIVFiGjcoNDBEV0Y/YMydwU
 BeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xZ3lpAQvqvEeyK874ekrhdyFJaFrtuodkxZuQJWmclc=;
 b=kESZJUWvw5EvuA+J1W8SEaE7U5XWRIj3G4xvvINGUWuFjq87cA6TChmpwIEtKel8cV
 +Ogpu8LfTHza9dYemvpGQ82WpBu71BJnhxstWDyho/OcX8SP0IhOIuYOPVV9EvG4YaVT
 ZDAIK6I3MSNE1U7YxiQR1dkOU8WiWKcqL+MzjI0wzLaVB1wbe6nMkTRwYm3LVtitktIR
 /9XkTAvZhdWlg8xfTlFsUZmzh5Hvzs5TibxAl8ec0ktXge6dYcIHgKxcUPZQ0JmGcQOg
 2DZPD1fRY4FDPewYU+JSaWlZsQ4QjbpXRd4bkgAeXMzyzieX+x/jSvCXQ25l71hMvhr/
 32Pg==
X-Gm-Message-State: AOAM532wqN0hKgMB696ssZS4dRdlVyuxtnidOJ++awu3Q9QmyWdbuYfy
 HPy/SA6XT1FpFhaYJ3/c1FYoiK6wX1iJyQ==
X-Google-Smtp-Source: ABdhPJxQzuNxg9iNW+ZJGfZqm2MUI5dcNt8rKxttbtIEU4oUWm8qSH7TZUi5okLbCXgyrCgYEoxcL227cXvoYA==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:7ec4:: with SMTP id
 z187mr18936928ybc.35.1633396776240; Mon, 04 Oct 2021 18:19:36 -0700 (PDT)
Date: Mon,  4 Oct 2021 18:19:18 -0700
In-Reply-To: <20211005011921.437353-1-ricarkol@google.com>
Message-Id: <20211005011921.437353-9-ricarkol@google.com>
Mime-Version: 1.0
References: <20211005011921.437353-1-ricarkol@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 08/11] KVM: arm64: selftests: Add some tests for GICv2 in
 vgic_init
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu, 
 drjones@redhat.com, eric.auger@redhat.com, alexandru.elisei@arm.com
Cc: pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
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

Add some GICv2 tests: general KVM device tests and DIST/CPUIF overlap
tests.  Do this by making test_vcpus_then_vgic and test_vgic_then_vcpus
in vgic_init GIC version agnostic.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../testing/selftests/kvm/aarch64/vgic_init.c | 111 +++++++++++++-----
 1 file changed, 79 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 7521dc80cf23..cb69e195ad1d 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -79,74 +79,120 @@ static void vm_gic_destroy(struct vm_gic *v)
 	kvm_vm_free(v->vm);
 }
 
+struct vgic_region_attr {
+	uint64_t attr;
+	uint64_t size;
+	uint64_t alignment;
+};
+
+struct vgic_region_attr gic_v3_dist_region = {
+	.attr = KVM_VGIC_V3_ADDR_TYPE_DIST,
+	.size = 0x10000,
+	.alignment = 0x10000,
+};
+
+struct vgic_region_attr gic_v3_redist_region = {
+	.attr = KVM_VGIC_V3_ADDR_TYPE_REDIST,
+	.size = NR_VCPUS * 0x20000,
+	.alignment = 0x10000,
+};
+
+struct vgic_region_attr gic_v2_dist_region = {
+	.attr = KVM_VGIC_V2_ADDR_TYPE_DIST,
+	.size = 0x1000,
+	.alignment = 0x1000,
+};
+
+struct vgic_region_attr gic_v2_cpu_region = {
+	.attr = KVM_VGIC_V2_ADDR_TYPE_CPU,
+	.size = 0x2000,
+	.alignment = 0x1000,
+};
+
 /**
- * Helper routine that performs KVM device tests in general and
- * especially ARM_VGIC_V3 ones. Eventually the ARM_VGIC_V3
- * device gets created, a legacy RDIST region is set at @0x0
- * and a DIST region is set @0x60000
+ * Helper routine that performs KVM device tests in general. Eventually the
+ * ARM_VGIC (GICv2 or GICv3) device gets created with an overlapping
+ * DIST/REDIST (or DIST/CPUIF for GICv2). Assumption is 4 vcpus are going to be
+ * used hence the overlap. In the case of GICv3, A RDIST region is set at @0x0
+ * and a DIST region is set @0x70000. The GICv2 case sets a CPUIF @0x0 and a
+ * DIST region @0x1000.
  */
-static void subtest_v3_dist_rdist(struct vm_gic *v)
+static void subtest_dist_rdist(struct vm_gic *v)
 {
 	int ret;
 	uint64_t addr;
+	struct vgic_region_attr rdist; /* CPU interface in GICv2*/
+	struct vgic_region_attr dist;
+
+	rdist = VGIC_DEV_IS_V3(v->gic_dev_type) ? gic_v3_redist_region
+						: gic_v2_cpu_region;
+	dist = VGIC_DEV_IS_V3(v->gic_dev_type) ? gic_v3_dist_region
+						: gic_v2_dist_region;
 
 	/* Check existing group/attributes */
 	kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			      KVM_VGIC_V3_ADDR_TYPE_DIST);
+			      dist.attr);
 
 	kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			      KVM_VGIC_V3_ADDR_TYPE_REDIST);
+			      rdist.attr);
 
 	/* check non existing attribute */
-	ret = _kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, 0);
+	ret = _kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, -1);
 	TEST_ASSERT(ret && errno == ENXIO, "attribute not supported");
 
 	/* misaligned DIST and REDIST address settings */
-	addr = 0x1000;
+	addr = dist.alignment / 0x10;
 	ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-				 KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
-	TEST_ASSERT(ret && errno == EINVAL, "GICv3 dist base not 64kB aligned");
+				 dist.attr, &addr, true);
+	TEST_ASSERT(ret && errno == EINVAL, "GIC dist base not aligned");
 
+	addr = rdist.alignment / 0x10;
 	ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-				 KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
-	TEST_ASSERT(ret && errno == EINVAL, "GICv3 redist base not 64kB aligned");
+				 rdist.attr, &addr, true);
+	TEST_ASSERT(ret && errno == EINVAL, "GIC redist/cpu base not aligned");
 
 	/* out of range address */
 	if (max_ipa_bits) {
 		addr = 1ULL << max_ipa_bits;
 		ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-					 KVM_VGIC_V3_ADDR_TYPE_DIST, &addr, true);
+					 dist.attr, &addr, true);
 		TEST_ASSERT(ret && errno == E2BIG, "dist address beyond IPA limit");
 
 		ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-					 KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+					 rdist.attr, &addr, true);
 		TEST_ASSERT(ret && errno == E2BIG, "redist address beyond IPA limit");
 	}
 
 	/* set REDIST base address @0x0*/
 	addr = 0x00000;
 	kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			  KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
+			  rdist.attr, &addr, true);
 
 	/* Attempt to create a second legacy redistributor region */
 	addr = 0xE0000;
 	ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-				 KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
-	TEST_ASSERT(ret && errno == EEXIST, "GICv3 redist base set again");
+				 rdist.attr, &addr, true);
+	TEST_ASSERT(ret && errno == EEXIST, "GIC redist base set again");
 
-	/* Attempt to mix legacy and new redistributor regions */
-	addr = REDIST_REGION_ATTR_ADDR(NR_VCPUS, 0x100000, 0, 0);
-	ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-				 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
-	TEST_ASSERT(ret && errno == EINVAL, "attempt to mix GICv3 REDIST and REDIST_REGION");
+	ret = _kvm_device_check_attr(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				     KVM_VGIC_V3_ADDR_TYPE_REDIST);
+	if (!ret) {
+		/* Attempt to mix legacy and new redistributor regions */
+		addr = REDIST_REGION_ATTR_ADDR(NR_VCPUS, 0x100000, 0, 0);
+		ret = _kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+					 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION,
+					 &addr, true);
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "attempt to mix GICv3 REDIST and REDIST_REGION");
+	}
 
 	/*
 	 * Set overlapping DIST / REDIST, cannot be detected here. Will be detected
 	 * on first vcpu run instead.
 	 */
-	addr = 3 * 2 * 0x10000;
-	kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR, KVM_VGIC_V3_ADDR_TYPE_DIST,
-			  &addr, true);
+	addr = rdist.size - rdist.alignment;
+	kvm_device_access(v->gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			  dist.attr, &addr, true);
 }
 
 /* Test the new REDIST region API */
@@ -254,14 +300,14 @@ static void subtest_v3_redist_regions(struct vm_gic *v)
  * VGIC KVM device is created and initialized before the secondary CPUs
  * get created
  */
-static void test_v3_vgic_then_vcpus(uint32_t gic_dev_type)
+static void test_vgic_then_vcpus(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
 	int ret, i;
 
 	v = vm_gic_create_with_vcpus(gic_dev_type, 1);
 
-	subtest_v3_dist_rdist(&v);
+	subtest_dist_rdist(&v);
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
@@ -274,14 +320,14 @@ static void test_v3_vgic_then_vcpus(uint32_t gic_dev_type)
 }
 
 /* All the VCPUs are created before the VGIC KVM device gets initialized */
-static void test_v3_vcpus_then_vgic(uint32_t gic_dev_type)
+static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
 	int ret;
 
 	v = vm_gic_create_with_vcpus(gic_dev_type, NR_VCPUS);
 
-	subtest_v3_dist_rdist(&v);
+	subtest_dist_rdist(&v);
 
 	ret = run_vcpu(v.vm, 3);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
@@ -550,9 +596,10 @@ int test_kvm_device(uint32_t gic_dev_type)
 
 void run_tests(uint32_t gic_dev_type)
 {
+	test_vcpus_then_vgic(gic_dev_type);
+	test_vgic_then_vcpus(gic_dev_type);
+
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
-		test_v3_vcpus_then_vgic(gic_dev_type);
-		test_v3_vgic_then_vcpus(gic_dev_type);
 		test_v3_new_redist_regions();
 		test_v3_typer_accesses();
 		test_v3_last_bit_redist_regions();
-- 
2.33.0.800.g4c38ced690-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
