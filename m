Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A07D84D59EE
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 05:49:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 33EC649EE9;
	Thu, 10 Mar 2022 23:49:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmV-ueu4+1DT; Thu, 10 Mar 2022 23:49:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FF1049EAA;
	Thu, 10 Mar 2022 23:49:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D05EA49EBD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:49:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8TRAhO6nC3c for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Mar 2022 23:48:57 -0500 (EST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E155049EDE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:48:56 -0500 (EST)
Received: by mail-pf1-f201.google.com with SMTP id
 187-20020a6205c4000000b004f77af0afb5so1904414pff.17
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 20:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jfOH2015965eWLFEWQQye3bOrg7hJCS3oXcPyaL1nbU=;
 b=sG/c9gU4wM5zOhcrJieLoUIYWMfGBw/6exm9gIixl0aHC/kj6Dondr0Q7x3JYLM5vj
 R+ouNeyO2pn4b8bqk26LJaw3qWh63XOGLBQGFRtfPQOGjMQGABhwNsPUJk2ibi4EdKsR
 Gh7N1QezxcHNaJDjznAmAaNUb0U+ztqg1Pop0QeeSpU1lkmFKB+Z0XHK2ZfxGGpuwZYE
 Xd2YMpJZz0vlUUMTOOee9epkA98ryHEi30vIxXfCc64v8DXtTFL/q2E49MyY4FdbbWHB
 E0kg9EIRb89GBwOu83gU2io4RwiRV1zIZeiJcErZuO4mORkz8WxSLkh4u0nH5xJsCjMn
 ig9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jfOH2015965eWLFEWQQye3bOrg7hJCS3oXcPyaL1nbU=;
 b=Vh76wGaIOAv78WQA9TCfGGzTBrbRD1x9u272u7JjyrF70ihgyyQXXvx8C88wJCZqB0
 u0qpl/XknhBe64hpgCgffFYBuxWGpuvUnDWrOu6oFZxzrYPeie1+MVRopaPEJ3nT2CTT
 B9rhTd6jnZO4EbvDZyyyLfp+nh6xlSPShR2NKtJTKXQlEqBWGzLBjJY1G3M36yskM664
 8P2RxvruAqVPissTJs70aFmwq2SGf+iQbJbuPJoaoIiRDmS8dspYeLFkAFdBbRPvWi/w
 RHhWa8omCrb67fQeV1w270n05mAzx8ObIROkUzrLB82SzAIz5fvJI8q2Qrr4bd7/Mg4L
 em6Q==
X-Gm-Message-State: AOAM532jzzAHEgyGc2jP7Jjafnw3FY7Dpus/trKZ+D4V1Rg6i0peZV6W
 nCS8luXcY3+5M9Wal1CkJqjAypNeL2M=
X-Google-Smtp-Source: ABdhPJw/8c0fXAUEpUFmm96pA3F7939672imxM0ZO6QIV+mfM91xCKyGQlgMwUOKKPrD09erGPx81DXak9I=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90b:4d88:b0:1bf:793:7134 with SMTP id
 oj8-20020a17090b4d8800b001bf07937134mr19865544pjb.112.1646974136161; Thu, 10
 Mar 2022 20:48:56 -0800 (PST)
Date: Thu, 10 Mar 2022 20:48:01 -0800
In-Reply-To: <20220311044811.1980336-1-reijiw@google.com>
Message-Id: <20220311044811.1980336-16-reijiw@google.com>
Mime-Version: 1.0
References: <20220311044811.1980336-1-reijiw@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 15/25] KVM: arm64: Add kunit test for ID register validation
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org
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

Add kunit tests for functions that are used for validation of ID
registers, CONFIG_KVM_KUNIT_TEST option to enable the tests, and
.kunitconfig to run the kunit tests.

One line change below is needed in the default arm64.py to fully
run all of those kunit tests.
-----------------------------------------------------------------------
$ diff tools/testing/kunit/qemu_configs/arm64.py arm64_kvm_min.py
12c12
< 			   extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
---
> 			   extra_qemu_params=['-M virt,virtualization=on,mte=on', '-cpu max,sve=on'])
-----------------------------------------------------------------------

The outputs from the tests are:
-----------------------------------------------------------------------
$ tools/testing/kunit/kunit.py run --timeout=60 --jobs=`nproc --all` \
          --arch=arm64 --cross_compile=aarch64-linux-gnu- \
          --qemu_config arm64_kvm_min.py \
          --kunitconfig=arch/arm64/kvm/.kunitconfig
[20:02:52] Configuring KUnit Kernel ...
[20:02:52] Building KUnit Kernel ...
Populating config with:
$ make ARCH=arm64 olddefconfig CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
Building with:
$ make ARCH=arm64 --jobs=96 CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
[20:02:59] Starting KUnit Kernel (1/1)...
[20:02:59] ============================================================
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Image.gz -append 'mem=1G console=tty kunit_shutdown=halt console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -M virt,virtualization=on,mte=on -cpu max,sve=on
[20:03:00] ========== kvm-sys-regs-test-suite (14 subtests) ===========
[20:03:00] [PASSED] vcpu_id_reg_feature_frac_check_test
[20:03:00] [PASSED] validate_id_aa64mmfr0_tgran2_test
[20:03:01] [PASSED] validate_id_aa64mmfr0_tgran2_test
[20:03:01] [PASSED] validate_id_aa64mmfr0_tgran2_test
[20:03:01] [PASSED] validate_id_aa64pfr0_el1_test
[20:03:01] [PASSED] validate_id_aa64pfr1_el1_test
[20:03:01] [PASSED] validate_id_aa64isar0_el1_test
[20:03:01] [PASSED] validate_id_aa64isar1_el1_test
[20:03:01] [PASSED] validate_id_aa64mmfr0_el1_test
[20:03:01] [PASSED] validate_id_aa64mmfr1_el1_test
[20:03:01] [PASSED] validate_id_aa64dfr0_el1_test
[20:03:01] [PASSED] validate_id_dfr0_el1_test
[20:03:01] [PASSED] validate_mvfr1_el1_test
[20:03:01] [PASSED] validate_id_reg_test
[20:03:01] ============= [PASSED] kvm-sys-regs-test-suite =============
[20:03:01] ============================================================
[20:03:01] Testing complete. Passed: 14, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
[20:03:01] Elapsed time: 8.534s total, 0.003s configuring, 6.962s building, 1.569s running
-----------------------------------------------------------------------

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/.kunitconfig    |   4 +
 arch/arm64/kvm/Kconfig         |  11 +
 arch/arm64/kvm/sys_regs.c      |   4 +
 arch/arm64/kvm/sys_regs_test.c | 983 +++++++++++++++++++++++++++++++++
 4 files changed, 1002 insertions(+)
 create mode 100644 arch/arm64/kvm/.kunitconfig
 create mode 100644 arch/arm64/kvm/sys_regs_test.c

diff --git a/arch/arm64/kvm/.kunitconfig b/arch/arm64/kvm/.kunitconfig
new file mode 100644
index 000000000000..c564c98fc319
--- /dev/null
+++ b/arch/arm64/kvm/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM=y
+CONFIG_KVM_KUNIT_TEST=y
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..0d628d0e7dd5 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -56,4 +56,15 @@ config NVHE_EL2_DEBUG
 
 	  If unsure, say N.
 
+config KVM_KUNIT_TEST
+	bool "KUnit tests for KVM on ARM64 processors" if !KUNIT_ALL_TESTS
+	depends on KVM && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Say Y here to enable KUnit tests for the KVM on ARM64.
+	  Only useful for KVM/ARM development and are not for inclusion into
+	  a production build.
+
+	  If unsure, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 3805b69ed23e..b44a3bf488c1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3762,3 +3762,7 @@ static void kvm_reset_id_regs(struct kvm_vcpu *vcpu)
 			r->reset(vcpu, r);
 	}
 }
+
+#if IS_ENABLED(CONFIG_KVM_KUNIT_TEST)
+#include "sys_regs_test.c"
+#endif
diff --git a/arch/arm64/kvm/sys_regs_test.c b/arch/arm64/kvm/sys_regs_test.c
new file mode 100644
index 000000000000..954c01876977
--- /dev/null
+++ b/arch/arm64/kvm/sys_regs_test.c
@@ -0,0 +1,983 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for arch/arm64/kvm/sys_regs.c.
+ */
+
+#include <linux/module.h>
+#include <kunit/test.h>
+#include <kunit/test.h>
+#include <linux/kvm_host.h>
+#include <asm/cpufeature.h>
+#include "asm/sysreg.h"
+
+/*
+ * Create a vcpu with the minimum fields required for testing in this file
+ * including the struct kvm.  Any resources that are allocated by this
+ * function must be allocated by kunit_* so that we don't need to explicitly
+ * free them.
+ */
+static struct kvm_vcpu *test_kvm_vcpu_init(struct kunit *test)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm *kvm;
+
+	kvm = kunit_kzalloc(test, sizeof(struct kvm), GFP_KERNEL);
+	if (!kvm)
+		return NULL;
+
+	vcpu = kunit_kzalloc(test, sizeof(struct kvm_vcpu), GFP_KERNEL);
+	if (!vcpu) {
+		kunit_kfree(test, kvm);
+		return NULL;
+	}
+
+	vcpu->cpu = -1;
+	vcpu->kvm = kvm;
+	vcpu->vcpu_id = 0;
+
+	return vcpu;
+}
+
+static void test_kvm_vcpu_fini(struct kunit *test, struct kvm_vcpu *vcpu)
+{
+	if (vcpu->kvm)
+		kunit_kfree(test, vcpu->kvm);
+
+	kunit_kfree(test, vcpu);
+}
+
+/* Test parameter information to test arm64_check_features */
+struct check_features_test {
+	u64	check_types;
+	u64	value;
+	u64	limit;
+	int	expected;
+};
+
+
+/* Used to define test parameters of vcpu_id_reg_feature_frac_check_test() */
+struct feat_info {
+	u32	id;
+	u32	shift;
+	u32	value;
+	u32	limit;
+};
+
+struct frac_check_test {
+	struct feat_info feat;
+	struct feat_info frac_feat;
+	int ret;
+};
+
+#define	FRAC_FEAT(id, shift, value, limit)	{id, shift, value, limit}
+
+/* Tests parameters of vcpu_id_reg_feature_frac_check_test() */
+struct frac_check_test frac_params[] = {
+	{
+		/*
+		 * The feature value is smaller than its limit.
+		 * Expect no error regardless of the frac value.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 2),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 1, 1),
+		0,
+	},
+	{
+		/*
+		 * The feature value is smaller than its limit.
+		 * Expect no error regardless of the frac value.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 2),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 1, 2),
+		0,
+	},
+	{
+		/*
+		 * The feature value is smaller than its limit.
+		 * Expect no error regardless of the frac value.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 2),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 2, 1),
+		0,
+	},
+	{
+		/*
+		 * Both the feature and frac values are same as their limits.
+		 * Expect no error.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 1),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 1, 1),
+		0,
+	},
+	{
+		/*
+		 * The feature value is same as its limit, and the frac value
+		 * is smaller than its limit. Expect no error.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 1),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 1, 2),
+		0,
+	},
+	{
+		/*
+		 * The feature value is same as its limit, and the frac value
+		 * is larger than its limit. Expect an error.
+		 */
+		FRAC_FEAT(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_RAS_SHIFT, 1, 1),
+		FRAC_FEAT(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_RASFRAC_SHIFT, 2, 1),
+		-E2BIG,
+	},
+
+};
+
+static void frac_case_to_desc(struct frac_check_test *t, char *desc)
+{
+	struct feat_info *feat = &t->feat;
+	struct feat_info *frac = &t->frac_feat;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "feat - shift:%d, val:%d, lim:%d, frac - shift:%d, val:%d, lim:%d\n",
+		 feat->shift, feat->value, feat->limit,
+		 frac->shift, frac->value, frac->limit);
+}
+
+KUNIT_ARRAY_PARAM(frac, frac_params, frac_case_to_desc);
+
+/* Tests for vcpu_id_reg_feature_frac_check(). */
+static void vcpu_id_reg_feature_frac_check_test(struct kunit *test)
+{
+	struct kvm_vcpu *vcpu;
+	u32 id, frac_id;
+	struct id_reg_desc id_data, frac_id_data;
+	struct id_reg_desc *idr, *frac_idr;
+	struct feature_frac frac_data, *frac = &frac_data;
+	const struct frac_check_test *frct = test->param_value;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id = frct->feat.id;
+	frac_id = frct->frac_feat.id;
+
+	frac->id = id;
+	frac->shift = frct->feat.shift;
+	frac->frac_id = frac_id;
+	frac->frac_shift = frct->frac_feat.shift;
+
+	idr = get_id_reg_desc(id);
+	frac_idr = get_id_reg_desc(frac_id);
+
+	/* Save the original id_reg_desc (and restore later) */
+	memcpy(&id_data, idr, sizeof(id_data));
+	memcpy(&frac_id_data, frac_idr, sizeof(frac_id_data));
+
+	/* The id could be same as the frac_id */
+	idr->vcpu_limit_val = (u64)frct->feat.limit << frac->shift;
+	frac_idr->vcpu_limit_val |=
+			(u64)frct->frac_feat.limit << frac->frac_shift;
+
+	write_kvm_id_reg(vcpu->kvm, id, (u64)frct->feat.value << frac->shift);
+	write_kvm_id_reg(vcpu->kvm, frac_id,
+			  (u64)frct->frac_feat.value << frac->frac_shift);
+
+	KUNIT_EXPECT_EQ(test,
+			vcpu_id_reg_feature_frac_check(vcpu, frac),
+			frct->ret);
+
+	/* Restore id_reg_desc */
+	memcpy(idr, &id_data, sizeof(id_data));
+	memcpy(frac_idr, &frac_id_data, sizeof(frac_id_data));
+}
+
+/*
+ * Test parameter information to test validate_id_aa64mmfr0_tgran2
+ * and validate_id_aa64mmfr0_el1_test.
+ */
+struct tgran_test {
+	int gran2_field;
+	int gran2;
+	int gran2_lim;
+	int gran1;
+	int gran1_lim;
+	int ret;
+};
+
+/*
+ * Test parameters of validate_id_aa64mmfr0_tgran2_test() for TGran4_2.
+ * Defined values for the field are:
+ *  0x0: Support for 4KB granule at stage 2 is identified in TGran4.
+ *  0x1: 4KB granule not supported at stage 2.
+ *  0x2: 4KB granule supported at stage 2.
+ *  0x3: 4KB granule at stage 2 supports 52-bit input and output addresses.
+ *
+ * Defined values for the TGran4 are:
+ *  0x0: 4KB granule supported.
+ *  0x1: 4KB granule supports 52-bit input and output addresses.
+ *  0xf: 4KB granule not supported.
+ */
+struct tgran_test tgran4_2_test_params[] = {
+	/* Enable 4KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 2,  0,   0, 0},
+	/* Enable 4KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 1,  0,   0, -E2BIG},
+	/* Disable 4KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 2,  0,   0, 0},
+	/* Enable 4KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 0,  0,   0, 0},
+	/* Disable 4KB granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 1, 0xf,   0, 0},
+	/* Enable 4KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 1,   0,   0, -E2BIG},
+	/* Disable 4KB granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 2, 0xf,   0, 0},
+	/*
+	 * Enable 4KB granule with 52 bit address on the host that doesn't
+	 * support it.
+	 */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 2,   1,   0, -E2BIG},
+	/* Disable 4KB granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 0,   0, 0xf,  0},
+	/* Disable 4KB granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 0,   0,   0,  0},
+	/* Enable 4KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 0, 0xf, 0xf,  -E2BIG},
+	/* Enable 4KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 0,   0,   0,  0},
+};
+
+/*
+ * Test parameters of validate_id_aa64mmfr0_tgran2_test() for TGran64_2.
+ * Defined values for the field are:
+ *  0x0: Support for 64KB granule at stage 2 is identified in TGran64.
+ *  0x1: 64KB granule not supported at stage 2.
+ *  0x2: 64KB granule supported at stage 2.
+ *  0x3: 64KB granule at stage 2 supports 52-bit input and output addresses.
+ *
+ * Defined values for the TGran64 are:
+ *  0x0: 64KB granule supported.
+ *  0xf: 64KB granule not supported.
+ */
+struct tgran_test tgran64_2_test_params[] = {
+	/* Enable 64KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 2,   0,   0, 0},
+	/* Enable 64KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 1,   0,   0, -E2BIG},
+	/* Enable 64KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 2,   0,   0, 0},
+	/* Enable 64KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 0,   0,   0, 0},
+	/* Disable 64KB granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 1, 0xf,   0, 0},
+	/* Enable 64KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 1,   0,   0, -E2BIG},
+	/* Disable 64KB granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 2, 0xf,   0, 0},
+	/* Disable 64KB granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 0,   0, 0xf, 0},
+	/* Disable 64KB granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 0,   0,   0, 0},
+	/* Enable 64KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 0, 0xf, 0xf, -E2BIG},
+	/* Enable 64KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 0,   0,   0, 0},
+};
+
+/*
+ * Test parameters of validate_id_aa64mmfr0_tgran2_test() for TGran16_2
+ * Defined values for the field are:
+ *  0x0: Support for 16KB granule at stage 2 is identified in TGran16.
+ *  0x1: 16KB granule not supported at stage 2.
+ *  0x2: 16KB granule supported at stage 2.
+ *  0x3: 16KB granule at stage 2 supports 52-bit input and output addresses.
+ *
+ * Defined values for the TGran16 are:
+ *  0x0: 16KB granule not supported.
+ *  0x1: 16KB granule supported.
+ *  0x2: 16KB granule supports 52-bit input and output addresses.
+ */
+struct tgran_test tgran16_2_test_params[] = {
+	/* Enable 16KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 2,  0,  0, 0},
+	/* Enable 16KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 1,  0,  0, -E2BIG},
+	/* Disable 16KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 2,  0,  0, 0},
+	/* Disable 16KB granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 0,  0,  0, 0},
+	/* Disable 16KB granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 1,  0,  0, 0},
+	/* Enable 16KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 1,  1,  0, -E2BIG},
+	/* Disable 16KB granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 2,  0,  0, 0},
+	/*
+	 * Enable 16KB granule with 52 bit address on the host that doesn't
+	 * support it.
+	 */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 2,  2,  2, -E2BIG},
+	/* Disable 16KB granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 0,  0,  0, 0},
+	/* Disable 16KB granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 0,  0,  1, 0},
+	/* Enable 16KB granule on the host that doesn't support the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 0,  0,  0, -E2BIG},
+	/* Enable 16KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 0,  0,  1, 0},
+	/* Enable 16KB granule on the host that supports the granule */
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 0,  0,  2, 0},
+};
+
+static void tgran2_case_to_desc(struct tgran_test *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "gran2(field=%d): val=%d, lim=%d gran1: val=%d limit=%d\n",
+		 t->gran2_field, t->gran2, t->gran2_lim,
+		 t->gran1, t->gran1_lim);
+}
+
+KUNIT_ARRAY_PARAM(tgran4_2, tgran4_2_test_params, tgran2_case_to_desc);
+KUNIT_ARRAY_PARAM(tgran64_2, tgran64_2_test_params, tgran2_case_to_desc);
+KUNIT_ARRAY_PARAM(tgran16_2, tgran16_2_test_params, tgran2_case_to_desc);
+
+#define	MAKE_MMFR0_TGRAN(shift1, gran1, shift2, gran2)		\
+	(((u64)((gran1) & 0xf) << (shift1)) |			\
+	 ((u64)((gran2) & 0xf) << (shift2)))
+
+/* Return the bit position of TGranX field for the given TGranX_2 field. */
+static int tgran2_to_tgran1_shift(int tgran2_shift)
+{
+	int tgran1_shift = -1;
+
+	switch (tgran2_shift) {
+	case ID_AA64MMFR0_TGRAN4_2_SHIFT:
+		tgran1_shift = ID_AA64MMFR0_TGRAN4_SHIFT;
+		break;
+	case ID_AA64MMFR0_TGRAN64_2_SHIFT:
+		tgran1_shift = ID_AA64MMFR0_TGRAN64_SHIFT;
+		break;
+	case ID_AA64MMFR0_TGRAN16_2_SHIFT:
+		tgran1_shift = ID_AA64MMFR0_TGRAN16_SHIFT;
+		break;
+	default:
+		break;
+	}
+
+	return tgran1_shift;
+}
+
+/* Tests for validate_id_aa64mmfr0_el1(). */
+static void validate_id_aa64mmfr0_tgran2_test(struct kunit *test)
+{
+	const struct tgran_test *t = test->param_value;
+	int shift1, shift2;
+	u64 v, lim;
+
+	shift2 = t->gran2_field;
+	shift1 = tgran2_to_tgran1_shift(shift2);
+	v = MAKE_MMFR0_TGRAN(shift1, t->gran1, shift2, t->gran2);
+	lim = MAKE_MMFR0_TGRAN(shift1, t->gran1_lim, shift2, t->gran2_lim);
+
+	KUNIT_EXPECT_EQ(test, aa64mmfr0_tgran2_check(shift2, v, lim), t->ret);
+}
+
+/* Tests for validate_id_aa64pfr0_el1(). */
+static void validate_id_aa64pfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64PFR0_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	/*
+	 * Tests for GIC.
+	 * GIC must be 1 when vGIC3 is configured.
+	 */
+	v = 0x0000000;	/* GIC = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Test with VGIC_V2 */
+	vcpu->kvm->arch.vgic.in_kernel = true;
+	vcpu->kvm->arch.vgic.vgic_model = KVM_DEV_TYPE_ARM_VGIC_V2;
+
+	v = 0x0000000;	/* GIC = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Test with VGIC_V3 */
+	vcpu->kvm->arch.vgic.vgic_model = KVM_DEV_TYPE_ARM_VGIC_V3;
+
+	v = 0x0000000;	/* GIC = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+	v = 0x1000000;	/* GIC = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Restore the original VGIC state */
+	vcpu->kvm->arch.vgic.in_kernel = false;
+	vcpu->kvm->arch.vgic.vgic_model = 0;
+
+	/*
+	 * Tests for AdvSIMD/FP.
+	 * AdvSIMD must have the same value as FP.
+	 */
+
+	/* Tests with SVE disabled */
+	v = 0x000010000;	/* AdvSIMD = 0, FP = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000100000;	/* AdvSIMD = 1, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000ff0000;	/* AdvSIMD = 0xf, FP = 0xf */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100000000;	/* SVE =1, AdvSIMD = 0, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+	if (!system_supports_sve()) {
+		kunit_skip(test, "No SVE support. Partial skip)");
+		/* Not reached */
+	}
+
+	/* Tests with SVE enabled */
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_SVE;
+
+	v = 0x100000000;	/* SVE =1, AdvSIMD = 0, FP = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100ff0000;	/* SVE =1, AdvSIMD = 0, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	vcpu->arch.flags &= ~KVM_ARM64_GUEST_HAS_SVE;
+}
+
+/* Tests for validate_id_aa64pfr1_el1() */
+static void validate_id_aa64pfr1_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64PFR1_EL1);
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	/* Tests for MTE */
+
+	/* Tests with MTE disabled */
+	KUNIT_EXPECT_FALSE(test, vcpu->kvm->arch.mte_enabled);
+
+	v = 0x000;	/* MTE = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100;	/* MTE = 1*/
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	if (!system_supports_mte()) {
+		kunit_skip(test, "(No MTE support. Partial skip)");
+		/* Not reached */
+	}
+
+	/* Tests with MTE enabled */
+	vcpu->kvm->arch.mte_enabled = true;
+
+	v = 0x100;	/* MTE = 1*/
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x0;	/* MTE = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+}
+
+/* Tests for validate_id_aa64isar0_el1(). */
+static void validate_id_aa64isar0_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64ISAR0_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	/*
+	 * Tests for SM3/SM4.
+	 * Arm ARM says SM3 must have the same value as SM4.
+	 */
+
+	v = 0x01000000000;	/* SM4 = 0, SM3 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000000000;	/* SM4 = 1, SM3 = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000000000;	/* SM3 = SM4 = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+
+	/*
+	 * Tests for SHA1/SHA2/SHA3.  Arm ARM says:
+	 * If SHA1 is 0x0, both SHA2 and SHA3 must be 0x0.
+	 * If SHA2 is 0x0, SHA1 must be 0x0.
+	 * If SHA2 is 0x2, SHA3 must be 0x1.
+	 * If SHA3 is 0x1, SHA2 msut be 0x2.
+	 */
+
+	v = 0x000000100;	/* SHA2 = 0, SHA1 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000001000;	/* SHA2 = 1, SHA1 = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000001100;	/* SHA2 = 1, SHA1 = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100002000;	/* SHA3 = 1, SHA2 = 2 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000002000;	/* SHA3 = 0, SHA2 = 2 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100001000;	/* SHA3 = 1, SHA2 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x200000000;	/* SHA3 = 2, SHA1 = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x200001100;	/* SHA3 = 2, SHA2= 1, SHA1 = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x300003300;	/* SHA3 = 3, SHA2 = 3, SHA1 = 3 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
+}
+
+/* Tests for validate_id_aa64isar1_el1() */
+static void validate_id_aa64isar1_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64ISAR1_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	/*
+	 * Tests for GPI/GPA/API/APA.
+	 * Arm ARM says:
+	 * If GPA is non-zero, GPI must be zero.
+	 * If GPI is non-zero, GPA must be zero.
+	 * If APA is non-zero, API must be zero.
+	 * If API is non-zero, APA must be zero.
+	 */
+
+	/* Tests with PTRAUTH disabled */
+	v = 0x11000110;	/* GPI = 1, GPA = 1, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000100;	/* GPI = 1, GPA = 1, API = 1, APA = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000010;	/* GPI = 1, GPA = 1, API = 0, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000110;	/* GPI = 1, GPA = 0, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000110;	/* GPI = 0, GPA = 1, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	if (!system_has_full_ptr_auth()) {
+		kunit_skip(test, "(No PTRAUTH support. Partial skip)");
+		/* Not reached */
+	}
+
+	/* Tests with PTRAUTH enabled */
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_PTRAUTH;
+
+	v = 0x10000100;	/* GPI = 1, GPA = 0, API = 1, APA = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000010;	/* GPI = 1, GPA = 0, API = 0, APA = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000100;	/* GPI = 0, GPA = 1, API = 1, APA = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000010;	/* GPI = 0, GPA = 1, API = 0, APA = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0;
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+}
+
+/* Tests for validate_id_aa64mmfr0_el1() */
+static void validate_id_aa64mmfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_desc id_data, *id_reg;
+	const struct tgran_test *t4, *t64, *t16;
+	struct kvm_vcpu *vcpu;
+	int field4, field4_2, field64, field64_2, field16, field16_2;
+	u64 v, v4, lim4, v64, lim64, v16, lim16;
+	int i, j, ret;
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64MMFR0_EL1);
+
+	/* Save the original id_reg_desc (and restore later) */
+	memcpy(&id_data, id_reg, sizeof(id_data));
+
+	vcpu = test_kvm_vcpu_init(test);
+
+	t4 = test->param_value;
+	field4_2 = t4->gran2_field;
+	field4 = tgran2_to_tgran1_shift(field4_2);
+	v4 = MAKE_MMFR0_TGRAN(field4, t4->gran1, field4_2, t4->gran2);
+	lim4 = MAKE_MMFR0_TGRAN(field4, t4->gran1_lim, field4_2, t4->gran2_lim);
+
+	/*
+	 * For each given gran4_2 params, test validate_id_aa64mmfr0_el1
+	 * with each of tgran64_2 and tgran16_2 params.
+	 */
+	for (i = 0; i < ARRAY_SIZE(tgran64_2_test_params); i++) {
+		t64 = &tgran64_2_test_params[i];
+		field64_2 = t64->gran2_field;
+		field64 = tgran2_to_tgran1_shift(field64_2);
+		v64 = MAKE_MMFR0_TGRAN(field64, t64->gran1,
+				       field64_2, t64->gran2);
+		lim64 = MAKE_MMFR0_TGRAN(field64, t64->gran1_lim,
+					 field64_2, t64->gran2_lim);
+
+		for (j = 0; j < ARRAY_SIZE(tgran16_2_test_params); j++) {
+			t16 = &tgran16_2_test_params[j];
+
+			field16_2 = t16->gran2_field;
+			field16 = tgran2_to_tgran1_shift(field16_2);
+			v16 = MAKE_MMFR0_TGRAN(field16, t16->gran1,
+					       field16_2, t16->gran2);
+			lim16 = MAKE_MMFR0_TGRAN(field16, t16->gran1_lim,
+						 field16_2, t16->gran2_lim);
+
+			/* Build id_aa64mmfr0_el1 from tgran16/64/4 values */
+			v = v16 | v64 | v4;
+			id_reg->vcpu_limit_val = lim16 | lim64 | lim4;
+
+			ret = t4->ret ? t4->ret : t64->ret;
+			ret = ret ? ret : t16->ret;
+			KUNIT_EXPECT_EQ(test,
+				validate_id_aa64mmfr0_el1(vcpu, id_reg, v),
+				ret);
+		}
+	}
+
+	/* Restore id_reg_desc */
+	memcpy(id_reg, &id_data, sizeof(id_data));
+}
+
+/* Tests for validate_id_aa64dfr0_el1() */
+static void validate_id_aa64dfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64DFR0_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	/*
+	 * Tests for CTX_CMPS/BRPS.
+	 * Number of context-aware breakpoints can be no more than number
+	 * of supported breakpoints.
+	 */
+	v = 0x10001000;	/* CTX_CMPS = 1, BRPS = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x20001000;	/* CTX_CMPS = 2, BRPS = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Tests for PMUVer */
+
+	/* Tests with PMUv3 disabled. */
+
+	v = 0x000;	/* PMUVER = 0x0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0xf00;	/* PMUVER = 0xf */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100;	/* PMUVER = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Tests with PMUv3 enabled */
+	set_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features);
+
+	v = 0x000;	/* PMUVER = 0x0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000;	/* PMUVER = 0xf */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100;	/* PMUVER = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+}
+
+/* Tests for validate_id_dfr0_el1() */
+static void validate_id_dfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = get_id_reg_desc(SYS_ID_DFR0_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	/* Tests for PERFMON */
+
+	/* Tests with PMUv3 disabled */
+
+	v = 0x0000000;	/* PERFMON = 0x0 */
+	KUNIT_EXPECT_EQ(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0xf000000;	/* PERFMON = 0xf */
+	KUNIT_EXPECT_EQ(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1000000;	/* PERFMON = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x2000000;	/* PERFMON = 2 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x3000000;	/* PERFMON = 3 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+
+	/* Tests with PMUv3 enabled */
+	set_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features);
+
+	v = 0x0000000;	/* PERFMON = 0x0 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0xf000000;	/* PERFMON = 0xf */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1000000;	/* PERFMON = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x2000000;	/* PERFMON = 2 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x3000000;	/* PERFMON = 3 */
+	KUNIT_EXPECT_EQ(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+}
+
+/* Tests for validate_mvfr1_el1(). */
+static void validate_mvfr1_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = get_id_reg_desc(SYS_MVFR1_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	/*
+	 * Tests for FPHP/SIMDHP.
+	 * Arm ARM says the level of support indicated by FPHP must be
+	 * equivalent to the level of support indicated by the SIMDHP,
+	 * meaning the permitted values are:
+	 * FPHP = 0x0, SIMDHP = 0x0
+	 * FPHP = 0x2, SIMDHP = 0x1
+	 * FPHP = 0x3, SIMDHP = 0x2
+	 */
+	v = 0x0000000;	/* FPHP = 0, SIMDHP = 0 */
+	KUNIT_EXPECT_EQ(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x2100000;	/* FPHP = 2, SIMDHP = 1 */
+	KUNIT_EXPECT_EQ(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x3200000;	/* FPHP = 3, SIMDHP = 2 */
+	KUNIT_EXPECT_EQ(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1100000;	/* FPHP = 1, SIMDHP = 1 */
+	KUNIT_EXPECT_NE(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x2200000;	/* FPHP = 2, SIMDHP = 2 */
+	KUNIT_EXPECT_NE(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x3300000;	/* FPHP = 3, SIMDHP = 3 */
+	KUNIT_EXPECT_NE(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+
+	v = (u64)-1;
+	KUNIT_EXPECT_NE(test, validate_mvfr1_el1(vcpu, id_reg, v), 0);
+}
+
+/*
+ * Helper function for validate_id_reg_test().
+ * We don't use KUNIT_ASSERT or kunit_skip because this is a helper test
+ * function and we are not sure if it's safe to exist from the test case.
+ */
+static void validate_id_reg_test_one_field(struct kunit *test,
+		u32 id, int pos, int fval, int flimit,
+		bool is_signed, struct id_reg_desc *idr)
+{
+	struct kvm_vcpu *vcpu;
+	int fmin = is_signed ? -1 : 0;
+	int fmax = is_signed ? 7 : 15;
+	u64 fmask = ARM64_FEATURE_FIELD_MASK;
+	u64 val;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	if (flimit > fmax) {
+		/* Shouldn't happen. Make the test failure. */
+		KUNIT_EXPECT_FALSE(test, flimit > fmax);
+		kunit_err(test, "%s: flimit(%d) > fmax(%d). Must be test bug",
+			  __func__, flimit, fmax);
+		return;
+	}
+
+	if (fval > fmin) {
+		/* Set the field to a smaller value */
+		val = ((u64)(fval - 1) & fmask) << pos;
+		KUNIT_EXPECT_EQ(test, validate_id_reg(vcpu, idr, val), 0);
+	}
+
+	if (fval < flimit) {
+		/* Set the field to a larger value, but smaller than flimit */
+		val = ((u64)(fval + 1) & fmask) << pos;
+		KUNIT_EXPECT_EQ(test, validate_id_reg(vcpu, idr, val), 0);
+
+		/* Set the field to the flimit */
+		val = ((u64)flimit & fmask) << pos;
+		KUNIT_EXPECT_EQ(test, validate_id_reg(vcpu, idr, val), 0);
+	}
+
+	if (flimit < fmax) {
+		/* Set the field to a larger value than flimit */
+		val = ((u64)(flimit + 1) & fmask) << pos;
+		KUNIT_EXPECT_NE(test, validate_id_reg(vcpu, idr, val), 0);
+
+		/* Test with ignore_mask */
+		if (idr) {
+			idr->ignore_mask = fmask << pos;
+			KUNIT_EXPECT_EQ(test, validate_id_reg(vcpu, idr, val), 0);
+		}
+	}
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void set_sys_desc(struct sys_reg_desc *rd, u32 encoding)
+{
+	rd->Op0 = sys_reg_Op0(encoding);
+	rd->Op1 = sys_reg_Op1(encoding);
+	rd->CRn = sys_reg_CRn(encoding);
+	rd->CRm = sys_reg_CRm(encoding);
+	rd->Op2 = sys_reg_Op2(encoding);
+}
+
+/*
+ * Test for validate_id_reg().
+ */
+static void validate_id_reg_test(struct kunit *test)
+{
+	struct id_reg_desc idr_data, *idr, *original_idr;
+	u32 id;
+	int fval, flim, pos;
+	u64 val;
+	bool sign;
+
+	/* Use AA64PFR0_EL1 because it includes both sign/unsigned fields */
+	id = SYS_ID_AA64PFR0_EL1;
+
+	/* Test with a temporary id_reg_desc for testing */
+	idr = &idr_data;
+
+	fval = 0x1;
+	flim = 0x2;
+
+	/* Test with unsigned field */
+	pos = ID_AA64PFR0_RAS_SHIFT;
+
+	/* Set up id_reg_desc for testing */
+	memset(idr, 0, sizeof(*idr));
+	set_sys_desc((struct sys_reg_desc *)&idr->reg_desc, id);
+	idr->vcpu_limit_val = (u64)flim << pos;
+	validate_id_reg_test_one_field(test, id, pos, fval, flim, false, idr);
+
+	/* Test with signed field */
+	pos = ID_AA64PFR0_FP_SHIFT;
+
+	/* Set up id_reg_desc for testing */
+	memset(idr, 0, sizeof(*idr));
+	set_sys_desc((struct sys_reg_desc *)&idr->reg_desc, id);
+	idr->vcpu_limit_val = (u64)flim << pos;
+	validate_id_reg_test_one_field(test, id, pos, fval, flim, true, idr);
+
+	/* Test with the original limit val */
+	original_idr = get_id_reg_desc(id);
+	val = original_idr->vcpu_limit_val;
+	idr->vcpu_limit_val = val;
+
+	for (pos = 0; pos < 64; pos += 4) {
+		if (pos == ID_AA64PFR0_FP_SHIFT ||
+		    pos == ID_AA64PFR0_ASIMD_SHIFT)
+			sign = true;
+		else
+			sign = false;
+
+		fval = cpuid_feature_extract_field(val, pos, sign);
+		validate_id_reg_test_one_field(test, id, pos, fval, fval,
+					       sign, idr);
+	}
+}
+
+static struct kunit_case kvm_sys_regs_test_cases[] = {
+	KUNIT_CASE_PARAM(vcpu_id_reg_feature_frac_check_test, frac_gen_params),
+	KUNIT_CASE_PARAM(validate_id_aa64mmfr0_tgran2_test, tgran4_2_gen_params),
+	KUNIT_CASE_PARAM(validate_id_aa64mmfr0_tgran2_test, tgran64_2_gen_params),
+	KUNIT_CASE_PARAM(validate_id_aa64mmfr0_tgran2_test, tgran16_2_gen_params),
+	KUNIT_CASE(validate_id_aa64pfr0_el1_test),
+	KUNIT_CASE(validate_id_aa64pfr1_el1_test),
+	KUNIT_CASE(validate_id_aa64isar0_el1_test),
+	KUNIT_CASE(validate_id_aa64isar1_el1_test),
+	KUNIT_CASE_PARAM(validate_id_aa64mmfr0_el1_test, tgran4_2_gen_params),
+	KUNIT_CASE(validate_id_aa64dfr0_el1_test),
+	KUNIT_CASE(validate_id_dfr0_el1_test),
+	KUNIT_CASE(validate_mvfr1_el1_test),
+	KUNIT_CASE(validate_id_reg_test),
+	{}
+};
+
+static struct kunit_suite kvm_sys_regs_test_suite = {
+	.name = "kvm-sys-regs-test-suite",
+	.test_cases = kvm_sys_regs_test_cases,
+};
+
+kunit_test_suites(&kvm_sys_regs_test_suite);
+MODULE_LICENSE("GPL");
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
