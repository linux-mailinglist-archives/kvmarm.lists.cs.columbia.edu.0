Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63741B69F
	for <lists+kvmarm@lfdr.de>; Tue, 28 Sep 2021 20:48:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 148DB4B126;
	Tue, 28 Sep 2021 14:48:21 -0400 (EDT)
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
	with ESMTP id kLMxMwulo0hu; Tue, 28 Sep 2021 14:48:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AE144B108;
	Tue, 28 Sep 2021 14:48:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 53B9D4B105
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 14:48:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20Q3kHwqgGgq for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Sep 2021 14:48:16 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47C1D4B133
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 14:48:16 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 e5-20020a656885000000b0027e0068121fso6248pgt.16
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Sep 2021 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=F7aqOIEmOFV8diRfZp4dNiKd4MPkYLZp/qoxZ1VUK2U=;
 b=KlPS1tJZw9GoWeMpxib832vHY3m3bVqzvlJ+jzwWA/Okcl2jcAda9LpHym0WjgwhEz
 HLXLoYUW0guPWluWegHRMHmKUY9Wd1yR7AdOjZKbDo032cweOdAoAW0i3kdxx9XBm7TR
 29jGuUCmMS2pg4yyo9Jw49VwyGml9V4860KPutHajy0x25xD8Qahe76m6/W+TYYs6JD+
 C9tXvuqMlHEKzgaNKRUAgrzmXx1GIOhGLrLobbaRlrj+OiAYieHSaeHp3yeQmfVrlfk9
 jwF7vJN06Eokow+PvmZ3bWSSBOUO7BPGZmqakopw02VGqP93uN7k1fr26F3++r0/jGOi
 Xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=F7aqOIEmOFV8diRfZp4dNiKd4MPkYLZp/qoxZ1VUK2U=;
 b=3K3l0V+e65kN2Vql34Qr2YnwFBptKlj9tbcibvx91YQ5P68ABUMdVu/ENH6QOH8QBh
 K9pGEZ2D3bU+I2W8mPKgcosGs2putkotleczEd2xnst2Kf48467TsYe0ZsypKx3b0xS4
 zXvzK04me6UxcKx3Jm96EHwdVFtiaUO+s9R4692HFjLz2qgF5qqGDcVfS1zzyq4ViYk7
 U431UX3VY6nd7T+mB2uQ+HcZoD311w+RON/gBTbnBEur360OR9AnUwHQ/heASpYbTXms
 lh68xhjndOaNDD369wfXLRkt+qmBZ+rviBIqDIobNBeWKAwU45fVu4/awMJ0Jsni659E
 DIyg==
X-Gm-Message-State: AOAM532vETbyunaO9Qcv6hovS29Ylww+wlntG14amraMB8hGYEGSfJrW
 40y/XFXYyD8eVh8ndfOxDzvBhQq0CtuNzg==
X-Google-Smtp-Source: ABdhPJybyOlsvI4Y9Hh810B6h4bfDyVtA3FzCarDmWRVzOfE+SgT8Rm5EdcPHbXB97QInEIXyVu3X6IFFJ4Pxg==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:90b:1013:: with SMTP id
 gm19mr142195pjb.1.1632854895088; Tue, 28 Sep 2021 11:48:15 -0700 (PDT)
Date: Tue, 28 Sep 2021 11:47:59 -0700
In-Reply-To: <20210928184803.2496885-1-ricarkol@google.com>
Message-Id: <20210928184803.2496885-6-ricarkol@google.com>
Mime-Version: 1.0
References: <20210928184803.2496885-1-ricarkol@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 05/10] KVM: arm64: selftests: Make vgic_init gic version
 agnostic
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

As a preparation for the next commits which will add some tests for
GICv2, make aarch64/vgic_init GIC version agnostic. Add a new generic
run_tests function(gic_dev_type) that starts all applicable tests using
GICv3 or GICv2. GICv2 tests are attempted if GICv3 is not available in
the system. There are currently no GICv2 tests, but the test passes now
in GICv2 systems.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../testing/selftests/kvm/aarch64/vgic_init.c | 156 +++++++++++-------
 1 file changed, 95 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 623f31a14326..896a29f2503d 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -22,6 +22,9 @@
 
 #define GICR_TYPER 0x8
 
+#define VGIC_DEV_IS_V2(_d) ((_d) == KVM_DEV_TYPE_ARM_VGIC_V2)
+#define VGIC_DEV_IS_V3(_d) ((_d) == KVM_DEV_TYPE_ARM_VGIC_V3)
+
 struct vm_gic {
 	struct kvm_vm *vm;
 	int gic_fd;
@@ -30,8 +33,8 @@ struct vm_gic {
 static int max_ipa_bits;
 
 /* helper to access a redistributor register */
-static int access_redist_reg(int gicv3_fd, int vcpu, int offset,
-			     uint32_t *val, bool write)
+static int access_v3_redist_reg(int gicv3_fd, int vcpu, int offset,
+				uint32_t *val, bool write)
 {
 	uint64_t attr = REG_OFFSET(vcpu, offset);
 
@@ -58,7 +61,7 @@ static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
 	return 0;
 }
 
-static struct vm_gic vm_gic_create(void)
+static struct vm_gic vm_gic_v3_create(void)
 {
 	struct vm_gic v;
 
@@ -80,7 +83,7 @@ static void vm_gic_destroy(struct vm_gic *v)
  * device gets created, a legacy RDIST region is set at @0x0
  * and a DIST region is set @0x60000
  */
-static void subtest_dist_rdist(struct vm_gic *v)
+static void subtest_v3_dist_rdist(struct vm_gic *v)
 {
 	int ret;
 	uint64_t addr;
@@ -145,7 +148,7 @@ static void subtest_dist_rdist(struct vm_gic *v)
 }
 
 /* Test the new REDIST region API */
-static void subtest_redist_regions(struct vm_gic *v)
+static void subtest_v3_redist_regions(struct vm_gic *v)
 {
 	uint64_t addr, expected_addr;
 	int ret;
@@ -249,7 +252,7 @@ static void subtest_redist_regions(struct vm_gic *v)
  * VGIC KVM device is created and initialized before the secondary CPUs
  * get created
  */
-static void test_vgic_then_vcpus(void)
+static void test_v3_vgic_then_vcpus(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
 	int ret, i;
@@ -257,7 +260,7 @@ static void test_vgic_then_vcpus(void)
 	v.vm = vm_create_default(0, 0, guest_code);
 	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
 
-	subtest_dist_rdist(&v);
+	subtest_v3_dist_rdist(&v);
 
 	/* Add the rest of the VCPUs */
 	for (i = 1; i < NR_VCPUS; ++i)
@@ -270,14 +273,14 @@ static void test_vgic_then_vcpus(void)
 }
 
 /* All the VCPUs are created before the VGIC KVM device gets initialized */
-static void test_vcpus_then_vgic(void)
+static void test_v3_vcpus_then_vgic(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
 	int ret;
 
-	v = vm_gic_create();
+	v = vm_gic_v3_create();
 
-	subtest_dist_rdist(&v);
+	subtest_v3_dist_rdist(&v);
 
 	ret = run_vcpu(v.vm, 3);
 	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
@@ -285,15 +288,15 @@ static void test_vcpus_then_vgic(void)
 	vm_gic_destroy(&v);
 }
 
-static void test_new_redist_regions(void)
+static void test_v3_new_redist_regions(void)
 {
 	void *dummy = NULL;
 	struct vm_gic v;
 	uint64_t addr;
 	int ret;
 
-	v = vm_gic_create();
-	subtest_redist_regions(&v);
+	v = vm_gic_v3_create();
+	subtest_v3_redist_regions(&v);
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
 			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
 
@@ -303,8 +306,8 @@ static void test_new_redist_regions(void)
 
 	/* step2 */
 
-	v = vm_gic_create();
-	subtest_redist_regions(&v);
+	v = vm_gic_v3_create();
+	subtest_v3_redist_regions(&v);
 
 	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
@@ -317,8 +320,8 @@ static void test_new_redist_regions(void)
 
 	/* step 3 */
 
-	v = vm_gic_create();
-	subtest_redist_regions(&v);
+	v = vm_gic_v3_create();
+	subtest_v3_redist_regions(&v);
 
 	_kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
@@ -338,7 +341,7 @@ static void test_new_redist_regions(void)
 	vm_gic_destroy(&v);
 }
 
-static void test_typer_accesses(void)
+static void test_v3_typer_accesses(void)
 {
 	struct vm_gic v;
 	uint64_t addr;
@@ -351,12 +354,12 @@ static void test_typer_accesses(void)
 
 	vm_vcpu_add_default(v.vm, 3, guest_code);
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(ret && errno == EINVAL, "attempting to read GICR_TYPER of non created vcpu");
 
 	vm_vcpu_add_default(v.vm, 1, guest_code);
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(ret && errno == EBUSY, "read GICR_TYPER before GIC initialized");
 
 	vm_vcpu_add_default(v.vm, 2, guest_code);
@@ -365,7 +368,7 @@ static void test_typer_accesses(void)
 			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
 
 	for (i = 0; i < NR_VCPUS ; i++) {
-		ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
+		ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
 		TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
 	}
 
@@ -374,10 +377,10 @@ static void test_typer_accesses(void)
 			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
 
 	/* The 2 first rdists should be put there (vcpu 0 and 3) */
-	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && !val, "read typer of rdist #0");
 
-	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x310, "read typer of rdist #1");
 
 	addr = REDIST_REGION_ATTR_ADDR(10, 0x100000, 0, 1);
@@ -385,11 +388,11 @@ static void test_typer_accesses(void)
 				 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
 	TEST_ASSERT(ret && errno == EINVAL, "collision with previous rdist region");
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x100,
 		    "no redist region attached to vcpu #1 yet, last cannot be returned");
 
-	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x200,
 		    "no redist region attached to vcpu #2, last cannot be returned");
 
@@ -397,10 +400,10 @@ static void test_typer_accesses(void)
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #1");
 
-	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x210,
 		    "read typer of rdist #1, last properly returned");
 
@@ -417,7 +420,7 @@ static void test_typer_accesses(void)
  * rdist region #2 @0x200000 2 rdist capacity
  *     rdists: 1, 2
  */
-static void test_last_bit_redist_regions(void)
+static void test_v3_last_bit_redist_regions(void)
 {
 	uint32_t vcpuids[] = { 0, 3, 5, 4, 1, 2 };
 	struct vm_gic v;
@@ -444,29 +447,29 @@ static void test_last_bit_redist_regions(void)
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
 
-	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x000, "read typer of rdist #0");
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #1");
 
-	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x200, "read typer of rdist #2");
 
-	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x310, "read typer of rdist #3");
 
-	ret = access_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x500, "read typer of rdist #5");
 
-	ret = access_redist_reg(v.gic_fd, 4, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 4, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x410, "read typer of rdist #4");
 
 	vm_gic_destroy(&v);
 }
 
 /* Test last bit with legacy region */
-static void test_last_bit_single_rdist(void)
+static void test_v3_last_bit_single_rdist(void)
 {
 	uint32_t vcpuids[] = { 0, 3, 5, 4, 1, 2 };
 	struct vm_gic v;
@@ -485,28 +488,32 @@ static void test_last_bit_single_rdist(void)
 	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
 			  KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
 
-	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x000, "read typer of rdist #0");
 
-	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x300, "read typer of rdist #1");
 
-	ret = access_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x500, "read typer of rdist #2");
 
-	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #3");
 
-	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
+	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
 	TEST_ASSERT(!ret && val == 0x210, "read typer of rdist #3");
 
 	vm_gic_destroy(&v);
 }
 
-void test_kvm_device(void)
+/*
+ * Returns 0 if it's possible to create GIC device of a given type (V2 or V3).
+ */
+int test_kvm_device(uint32_t gic_dev_type)
 {
 	struct vm_gic v;
 	int ret, fd;
+	uint32_t other;
 
 	v.vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0, guest_code, NULL);
 
@@ -514,38 +521,65 @@ void test_kvm_device(void)
 	ret = _kvm_create_device(v.vm, 0, true, &fd);
 	TEST_ASSERT(ret && errno == ENODEV, "unsupported device");
 
-	/* trial mode with VGIC_V3 device */
-	ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, true, &fd);
-	if (ret) {
-		print_skip("GICv3 not supported");
-		exit(KSFT_SKIP);
-	}
-	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	/* trial mode */
+	ret = _kvm_create_device(v.vm, gic_dev_type, true, &fd);
+	if (ret)
+		return ret;
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type, false);
+
+	ret = _kvm_create_device(v.vm, gic_dev_type, false, &fd);
+	TEST_ASSERT(ret && errno == EEXIST, "create GIC device twice");
 
-	ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false, &fd);
-	TEST_ASSERT(ret && errno == EEXIST, "create GICv3 device twice");
+	kvm_create_device(v.vm, gic_dev_type, true);
 
-	kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
+	/* try to create the other gic_dev_type */
+	other = VGIC_DEV_IS_V2(gic_dev_type) ? KVM_DEV_TYPE_ARM_VGIC_V3
+					     : KVM_DEV_TYPE_ARM_VGIC_V2;
 
-	if (!_kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V2, true, &fd)) {
-		ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V2, false, &fd);
-		TEST_ASSERT(ret && errno == EINVAL, "create GICv2 while v3 exists");
+	if (!_kvm_create_device(v.vm, other, true, &fd)) {
+		ret = _kvm_create_device(v.vm, other, false, &fd);
+		TEST_ASSERT(ret && errno == EINVAL,
+				"create GIC device while other version exists");
 	}
 
 	vm_gic_destroy(&v);
+
+	return 0;
+}
+
+void run_tests(uint32_t gic_dev_type)
+{
+	if (VGIC_DEV_IS_V3(gic_dev_type)) {
+		test_v3_vcpus_then_vgic(gic_dev_type);
+		test_v3_vgic_then_vcpus(gic_dev_type);
+		test_v3_new_redist_regions();
+		test_v3_typer_accesses();
+		test_v3_last_bit_redist_regions();
+		test_v3_last_bit_single_rdist();
+	}
 }
 
 int main(int ac, char **av)
 {
+	int ret;
+
 	max_ipa_bits = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
 
-	test_kvm_device();
-	test_vcpus_then_vgic();
-	test_vgic_then_vcpus();
-	test_new_redist_regions();
-	test_typer_accesses();
-	test_last_bit_redist_regions();
-	test_last_bit_single_rdist();
+	ret = test_kvm_device(KVM_DEV_TYPE_ARM_VGIC_V3);
+	if (!ret) {
+		pr_info("Running GIC_v3 tests.\n");
+		run_tests(KVM_DEV_TYPE_ARM_VGIC_V3);
+		return 0;
+	}
+
+	ret = test_kvm_device(KVM_DEV_TYPE_ARM_VGIC_V2);
+	if (!ret) {
+		pr_info("Running GIC_v2 tests.\n");
+		run_tests(KVM_DEV_TYPE_ARM_VGIC_V2);
+		return 0;
+	}
 
+	print_skip("No GICv2 nor GICv3 support");
+	exit(KSFT_SKIP);
 	return 0;
 }
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
