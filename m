Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 575AB45415C
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 07:53:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A48A4B177;
	Wed, 17 Nov 2021 01:53:45 -0500 (EST)
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
	with ESMTP id Hx02FWSsloSx; Wed, 17 Nov 2021 01:53:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 792044B17D;
	Wed, 17 Nov 2021 01:53:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91DBA4B0F5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eLsZJN6tXdMv for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 01:53:37 -0500 (EST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 959194B0F7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:37 -0500 (EST)
Received: by mail-pj1-f74.google.com with SMTP id
 jx2-20020a17090b46c200b001a62e9db321so848018pjb.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Nov 2021 22:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RHoCEP+RyOR/HV9iNPiomfNv7ul8MH2rBqrRr7QAURo=;
 b=bSlIdu0vgD02Z71Rv6UYf3entcYwXwLIe9uzKVa9d84HVgK1hz+qp3Zq2nUwu0Gho7
 vpMyMGDIbDOj2xS1heR7meQPaElPePl8GwKg3DTQ/1xilReuAK68rSf3ouhkk3FWxqpz
 aHMe0gNu0xPNduP4ZwA1g4RbTwj5TOrx3ktbhizcB7BdO9fEFu8B48P289ky+JZNLJVR
 ZGkFoQ9RnZfMDlUv2aaBgeR1sTFdtBycQIEEV7f2dXcmxIBERDkfAQxTy4MsXQ/onk9l
 MF9e0iXMrSerSQIep7G8hdQtjNJjSJ+woXKhCsjf9KVEGFZEfJNNVs2lYruWm9uHyWD0
 F3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RHoCEP+RyOR/HV9iNPiomfNv7ul8MH2rBqrRr7QAURo=;
 b=0DdRmbl65+IGXGBD10drAXFX5HSyk18qh0682sCAV6/wGMbQU4yVFfCamtgnc1tZRs
 F3FWJw/QTQ/sJRv5TUkWbdqSee/IoopdYqkj6UNQyqC7xa83pmoJUniYD/nQK2GeFfLU
 rfNOqpP4ueeEweB45bHc8oSXy0at21jNQZGqpfKphX+F6ees9QdhZq4oKN7dbYnJ8B+W
 teSKAdNzB1NDyl9m3yg7oHCKFvuge79cEjD0Abuq8lB64Sq2Y5xWKajBwcZ5VDGdbwi0
 IfrluhV0wnmYdK7zFfI7070/86H3F1j81Iss/EGAo/OM9lXzAYzfUW1O01fvkCphb2WF
 Th0A==
X-Gm-Message-State: AOAM533R0mPXtCXfVMdKPmN3WrSvUHVaPsMhkx5CmCONS4TQwrrzRUOr
 yB/gvz+Ih0+cVJvVLO1l4IooosebMAw=
X-Google-Smtp-Source: ABdhPJzRBrBQ3yiWgcfeQXijGQ8XxjTXwR/EIFMKT2Bq8TAtIEXtizZ6lbfAezu4UsXdDLo3yiwO6usTUYA=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a62:8c55:0:b0:49f:df22:c4ca with SMTP id
 m82-20020a628c55000000b0049fdf22c4camr46411533pfd.11.1637132016850; Tue, 16
 Nov 2021 22:53:36 -0800 (PST)
Date: Tue, 16 Nov 2021 22:43:48 -0800
In-Reply-To: <20211117064359.2362060-1-reijiw@google.com>
Message-Id: <20211117064359.2362060-19-reijiw@google.com>
Mime-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v3 18/29] KVM: arm64: Add kunit test for ID register
 validation
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
registers and CONFIG_KVM_KUNIT_TEST option to enable the tests.

Since those tests only cover ID register validation so far, only
a few lines of change are needed in the default arm64.py to run
all of those tests as follows.
-----------------------------------------------------------------------
$ diff tools/testing/kunit/qemu_configs/arm64.py arm64_kvm_min.py
4a5,7
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=y
> CONFIG_KVM_KUNIT_TEST=y
12c15
< 			   extra_qemu_params=['-machine virt', '-cpu cortex-a57'])
---
> 			   extra_qemu_params=['-M virt,virtualization=on,mte=on', '-cpu max,sve=on'])
$ tools/testing/kunit/kunit.py run --timeout=60 --jobs=16 --arch=arm64 --cross_compile=aarch64-linux-gnu- --qemu_config arm64_kvm_min.py
[19:58:09] Configuring KUnit Kernel ...
[19:58:09] Building KUnit Kernel ...
Populating config with:
$ make ARCH=arm64 olddefconfig CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
Building with:
$ make ARCH=arm64 --jobs=16 CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
[19:58:12] Starting KUnit Kernel (1/1)...
[19:58:12] ============================================================
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Image.gz -append 'mem=1G console=tty kunit_shutdown=halt console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -M virt,virtualization=on,mte=on -cpu max,sve=on
[19:58:14] ========== kvm-sys-regs-test-suite (14 subtests) ===========
[19:58:14] [PASSED] arm64_check_feature_one_test
[19:58:14] [PASSED] arm64_check_features_test
[19:58:14] [PASSED] vcpu_id_reg_feature_frac_check_test
[19:58:14] [PASSED] validate_id_aa64mmfr0_tgran2_test
[19:58:14] [PASSED] validate_id_aa64mmfr0_tgran2_test
[19:58:14] [PASSED] validate_id_aa64mmfr0_tgran2_test
[19:58:14] [PASSED] validate_id_aa64pfr0_el1_test
[19:58:14] [PASSED] validate_id_aa64pfr1_el1_test
[19:58:14] [PASSED] validate_id_aa64isar0_el1_test
[19:58:14] [PASSED] validate_id_aa64isar1_el1_test
[19:58:14] [PASSED] validate_id_aa64mmfr0_el1_test
[19:58:14] [PASSED] validate_id_aa64dfr0_el1_test
[19:58:14] [PASSED] validate_id_dfr0_el1_test
[19:58:14] [PASSED] validate_mvfr1_el1_test
[19:58:14] ============= [PASSED] kvm-sys-regs-test-suite =============
[19:58:14] ============================================================
[19:58:14] Testing complete. Passed: 14, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
[19:58:14] Elapsed time: 4.644s total, 0.002s configuring, 2.959s building, 1.682s running
-----------------------------------------------------------------------

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/Kconfig         |  11 +
 arch/arm64/kvm/sys_regs.c      |   4 +
 arch/arm64/kvm/sys_regs_test.c | 871 +++++++++++++++++++++++++++++++++
 3 files changed, 886 insertions(+)
 create mode 100644 arch/arm64/kvm/sys_regs_test.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8ffcbe29395e..48fbdd17b2fd 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -54,4 +54,15 @@ config NVHE_EL2_DEBUG
 
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
index b848ecea0c59..2f96103fc0d2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3630,3 +3630,7 @@ void kvm_sys_reg_table_init(void)
 
 	id_reg_info_init_all();
 }
+
+#if IS_ENABLED(CONFIG_KVM_KUNIT_TEST)
+#include "sys_regs_test.c"
+#endif
diff --git a/arch/arm64/kvm/sys_regs_test.c b/arch/arm64/kvm/sys_regs_test.c
new file mode 100644
index 000000000000..8d27c7c361fb
--- /dev/null
+++ b/arch/arm64/kvm/sys_regs_test.c
@@ -0,0 +1,871 @@
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
+/* Some utilities for minimal vcpu/kvm setup for existing testings. */
+static struct kvm_vcpu *test_vcpu_init(struct kunit *test, u32 id,
+				       struct kvm *kvm)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = kunit_kzalloc(test, sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return NULL;
+
+	vcpu->cpu = -1;
+	vcpu->kvm = kvm;
+	vcpu->vcpu_id = id;
+
+	return vcpu;
+}
+
+static void test_vcpu_fini(struct kunit *test, struct kvm_vcpu *vcpu)
+{
+	kunit_kfree(test, vcpu);
+}
+
+static struct kvm *test_kvm_init(struct kunit *test)
+{
+	struct kvm *kvm;
+
+	kvm = kunit_kzalloc(test, sizeof(struct kvm), GFP_KERNEL);
+	if (!kvm)
+		return NULL;
+
+	return kvm;
+}
+
+static void test_kvm_fini(struct kunit *test, struct kvm *kvm)
+{
+	kunit_kfree(test, kvm);
+}
+
+static struct kvm_vcpu *test_kvm_vcpu_init(struct kunit *test)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm *kvm;
+
+	kvm = test_kvm_init(test);
+	if (!kvm)
+		return NULL;
+
+	vcpu = test_vcpu_init(test, 0, kvm);
+	if (!vcpu) {
+		test_kvm_fini(test, kvm);
+		return NULL;
+	}
+	return vcpu;
+}
+
+static void test_kvm_vcpu_fini(struct kunit *test, struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	test_vcpu_fini(test, vcpu);
+	if (kvm)
+		test_kvm_fini(test, kvm);
+}
+
+/* Test parameter information to test arm64_check_feature_one() */
+struct check_feature_one_test {
+	enum feature_check_type type;
+	int	value;
+	int	limit;
+	int	expected;
+};
+
+struct check_feature_one_test feature_one_params[] = {
+	{FCT_LOWER_SAFE,  0,  0,  0},
+	{FCT_LOWER_SAFE, -1, -1,  0},
+	{FCT_LOWER_SAFE,  1,  1,  0},
+	{FCT_LOWER_SAFE,  1,  2,  0},
+	{FCT_LOWER_SAFE, -1,  0,  0},
+	{FCT_LOWER_SAFE,  2,  1, -1},
+	{FCT_LOWER_SAFE, -1, -2, -1},
+
+	{FCT_HIGHER_SAFE,  0,  0,  0},
+	{FCT_HIGHER_SAFE, -1, -1,  0},
+	{FCT_HIGHER_SAFE,  1,  1,  0},
+	{FCT_HIGHER_SAFE,  1,  2, -1},
+	{FCT_HIGHER_SAFE, -1,  0, -1},
+	{FCT_HIGHER_SAFE,  2,  1,  0},
+	{FCT_HIGHER_SAFE, -1, -2,  0},
+
+	{FCT_HIGHER_OR_ZERO_SAFE,  0,  0,  0},
+	{FCT_HIGHER_OR_ZERO_SAFE, -1, -1,  0},
+	{FCT_HIGHER_OR_ZERO_SAFE,  1,  1,  0},
+	{FCT_HIGHER_OR_ZERO_SAFE,  1,  2, -1},
+	{FCT_HIGHER_OR_ZERO_SAFE, -1,  0, -1},
+	{FCT_HIGHER_OR_ZERO_SAFE,  2,  1,  0},
+	{FCT_HIGHER_OR_ZERO_SAFE, -1, -2,  0},
+	{FCT_HIGHER_OR_ZERO_SAFE,  0,  2,  0},
+
+	{FCT_EXACT,  0,  0,  0},
+	{FCT_EXACT, -1, -1,  0},
+	{FCT_EXACT,  1,  1,  0},
+	{FCT_EXACT,  1,  2, -1},
+	{FCT_EXACT, -1,  0, -1},
+	{FCT_EXACT,  2,  1, -1},
+	{FCT_EXACT, -1, -2, -1},
+
+	{FCT_IGNORE,  0,  0,  0},
+	{FCT_IGNORE, -1, -1,  0},
+	{FCT_IGNORE,  1,  1,  0},
+	{FCT_IGNORE,  1,  2,  0},
+	{FCT_IGNORE, -1,  0,  0},
+	{FCT_IGNORE,  2,  1,  0},
+	{FCT_IGNORE, -1, -2,  0},
+};
+
+static void feature_one_case_to_desc(struct check_feature_one_test *t,
+				     char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "type:%x, value:%d, limit:%d\n", t->type, t->value, t->limit);
+}
+
+void arm64_check_feature_one_test(struct kunit *test)
+{
+	const struct check_feature_one_test *ft = test->param_value;
+
+	KUNIT_EXPECT_EQ(test,
+			arm64_check_feature_one(ft->type, ft->value, ft->limit),
+			ft->expected);
+}
+
+KUNIT_ARRAY_PARAM(feature_one, feature_one_params, feature_one_case_to_desc);
+
+
+/* Test parameter information to test arm64_check_features */
+struct check_features_test {
+	u64	check_types;
+	u64	value;
+	u64	limit;
+	int	expected;
+};
+
+#define	U_FEAT_TEST(shift, type, value, limit, exp)	\
+	{U_FCT(shift, type), (u64)value << shift, (u64)limit << shift, exp}
+
+#define	S_FEAT_TEST(shift, type, value, limit, exp)	\
+	{S_FCT(shift, type), (u64)value << shift, (u64)limit << shift, exp}
+
+struct check_features_test features_params[] = {
+	/* Unsigned */
+	U_FEAT_TEST(0, FCT_LOWER_SAFE, 1, 2, 0),
+	U_FEAT_TEST(0, FCT_HIGHER_SAFE, 1, 2, -E2BIG),
+	U_FEAT_TEST(0, FCT_HIGHER_OR_ZERO_SAFE, 1, 2, -E2BIG),
+	U_FEAT_TEST(0, FCT_EXACT, 1, 2, -E2BIG),
+	U_FEAT_TEST(0, FCT_IGNORE, 1, 2, 0),
+	U_FEAT_TEST(0, FCT_LOWER_SAFE, 1, 0xf, 0),
+	U_FEAT_TEST(0, FCT_HIGHER_SAFE, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(0, FCT_HIGHER_OR_ZERO_SAFE, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(0, FCT_EXACT, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(0, FCT_IGNORE, 1, 0xf, 0),
+	U_FEAT_TEST(60, FCT_LOWER_SAFE, 1, 2, 0),
+	U_FEAT_TEST(60, FCT_HIGHER_SAFE, 1, 2, -E2BIG),
+	U_FEAT_TEST(60, FCT_HIGHER_OR_ZERO_SAFE, 1, 2, -E2BIG),
+	U_FEAT_TEST(60, FCT_EXACT, 1, 2, -E2BIG),
+	U_FEAT_TEST(60, FCT_IGNORE, 1, 2, 0),
+	U_FEAT_TEST(60, FCT_LOWER_SAFE, 1, 0xf, 0),
+	U_FEAT_TEST(60, FCT_HIGHER_SAFE, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(60, FCT_HIGHER_OR_ZERO_SAFE, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(60, FCT_EXACT, 1, 0xf, -E2BIG),
+	U_FEAT_TEST(60, FCT_IGNORE, 1, 0xf, 0),
+
+	/* Signed */
+	S_FEAT_TEST(0, FCT_LOWER_SAFE, 1, 2, 0),
+	S_FEAT_TEST(0, FCT_HIGHER_SAFE, 1, 2, -E2BIG),
+	S_FEAT_TEST(0, FCT_HIGHER_OR_ZERO_SAFE, 1, 2, -E2BIG),
+	S_FEAT_TEST(0, FCT_EXACT, 1, 2, -E2BIG),
+	S_FEAT_TEST(0, FCT_IGNORE, 1, 2, 0),
+	S_FEAT_TEST(0, FCT_LOWER_SAFE, 1, 0xf, -E2BIG),
+	S_FEAT_TEST(0, FCT_HIGHER_SAFE, 1, 0xf, 0),
+	S_FEAT_TEST(0, FCT_HIGHER_OR_ZERO_SAFE, 1, 0xf, 0),
+	S_FEAT_TEST(0, FCT_EXACT, 1, 0xf, -E2BIG),
+	S_FEAT_TEST(0, FCT_IGNORE, 1, 0xf, 0),
+	S_FEAT_TEST(60, FCT_LOWER_SAFE, 1, 2, 0),
+	S_FEAT_TEST(60, FCT_HIGHER_SAFE, 1, 2, -E2BIG),
+	S_FEAT_TEST(60, FCT_HIGHER_OR_ZERO_SAFE, 1, 2, -E2BIG),
+	S_FEAT_TEST(60, FCT_EXACT, 1, 2, -E2BIG),
+	S_FEAT_TEST(60, FCT_IGNORE, 1, 2, 0),
+	S_FEAT_TEST(60, FCT_LOWER_SAFE, 1, 0xf, -E2BIG),
+	S_FEAT_TEST(60, FCT_HIGHER_SAFE, 1, 0xf, 0),
+	S_FEAT_TEST(60, FCT_HIGHER_OR_ZERO_SAFE, 1, 0xf, 0),
+	S_FEAT_TEST(60, FCT_EXACT, 1, 0xf, -E2BIG),
+	S_FEAT_TEST(60, FCT_IGNORE, 1, 0xf, 0),
+};
+
+static void features_case_to_desc(struct check_features_test *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "check_types:0x%llx, value:0x%llx, limit:0x%llx\n",
+		 t->check_types, t->value, t->limit);
+}
+
+KUNIT_ARRAY_PARAM(features, features_params, features_case_to_desc);
+
+
+void arm64_check_features_test(struct kunit *test)
+{
+	const struct check_features_test *ft = test->param_value;
+
+	KUNIT_EXPECT_EQ(test,
+		arm64_check_features(ft->check_types, ft->value, ft->limit),
+		ft->expected);
+}
+
+
+/* Test parameter information to test vcpu_id_reg_feature_frac_check */
+struct feat_info {
+	u32	id;
+	u32	shift;
+	u32	value;
+	u32	limit;
+	u8	check_type;
+};
+
+struct frac_check_test {
+	struct feat_info feat;
+	struct feat_info frac_feat;
+	int ret;
+};
+
+#define	FEAT(id, shift, value, limit, type)	{id, shift, value, limit, type}
+
+struct frac_check_test frac_params[] = {
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 2, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 1, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		0,
+	},
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 2, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 1, 2, U_FCT(0, FCT_LOWER_SAFE)),
+		0,
+	},
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 2, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 2, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		0,
+	},
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 1, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		0,
+	},
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 1, 2, U_FCT(0, FCT_LOWER_SAFE)),
+		0,
+	},
+	{
+		FEAT(SYS_ID_AA64PFR1_EL1, 12, 1, 1, U_FCT(0, FCT_LOWER_SAFE)),
+		FEAT(SYS_ID_AA64PFR1_EL1, 32, 2, 1, U_FCT(0, FCT_LOWER_SAFE)),
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
+		 "feat - shift:%d, val:%d, lim:%d, frac - shift:%d, val:%d, lim:%d, type:%x\n",
+		 feat->shift, feat->value, feat->limit,
+		 frac->shift, frac->value, frac->limit, frac->check_type);
+}
+
+KUNIT_ARRAY_PARAM(frac, frac_params, frac_case_to_desc);
+
+static void vcpu_id_reg_feature_frac_check_test(struct kunit *test)
+{
+	struct kvm_vcpu *vcpu;
+	u32 id, frac_id;
+	struct id_reg_info id_data, frac_id_data;
+	struct id_reg_info *idr, *frac_idr;
+	struct feature_frac frac_data, *frac = &frac_data;
+	const struct frac_check_test *frct = test->param_value;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	id = frct->feat.id;
+	frac_id = frct->frac_feat.id;
+
+	frac->id = id;
+	frac->shift = frct->feat.shift;
+	frac->frac_id = frac_id;
+	frac->frac_shift = frct->frac_feat.shift;
+	frac->frac_ftr_check = frct->frac_feat.check_type;
+
+	idr = GET_ID_REG_INFO(id);
+	frac_idr = GET_ID_REG_INFO(frac_id);
+
+	/* Save the original id_reg_info (and restore later) */
+	memcpy(&id_data, idr, sizeof(id_data));
+	memcpy(&frac_id_data, frac_idr, sizeof(frac_id_data));
+
+	/* The id could be same as the frac_id */
+	idr->vcpu_limit_val = (u64)frct->feat.limit << frac->shift;
+	frac_idr->vcpu_limit_val |=
+			(u64)frct->frac_feat.limit << frac->frac_shift;
+
+	__vcpu_sys_reg(vcpu, IDREG_SYS_IDX(id)) =
+			(u64)frct->feat.value << frac->shift;
+	__vcpu_sys_reg(vcpu, IDREG_SYS_IDX(frac_id)) |=
+			(u64)frct->frac_feat.value << frac->frac_shift;
+
+	KUNIT_EXPECT_EQ(test,
+			vcpu_id_reg_feature_frac_check(vcpu, frac),
+			frct->ret);
+
+	test_kvm_vcpu_fini(test, vcpu);
+
+	/* Restore id_reg_info */
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
+struct tgran_test tgran4_2_test_params[] = {
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 1,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 1, -1,  0, 0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 1,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 2, -1,  0, 0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 0, 2,  1,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 0,  0, -1,  0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 1, 0,  0,  0,  0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 0,  0, -1,  -E2BIG},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 0,  0,  0,  0},
+	{ID_AA64MMFR0_TGRAN4_2_SHIFT, 2, 0,  0,  2,  0},
+};
+
+struct tgran_test tgran64_2_test_params[] = {
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 1,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 1, -1,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 1,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 2, -1,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 0, 2,  1,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 0,  0, -1, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 1, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 0,  0, -1, -E2BIG},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN64_2_SHIFT, 2, 0,  0,  2, 0},
+};
+
+struct tgran_test tgran16_2_test_params[] = {
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 1,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 1,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 1,  1,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 2,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 0, 2,  2,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 0,  0,  0, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 1, 0,  0,  1, 0},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 0,  0,  0, -E2BIG},
+	{ID_AA64MMFR0_TGRAN16_2_SHIFT, 2, 0,  0,  1, 0},
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
+static void validate_id_aa64pfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64PFR0_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000010000;	/* ASIMD = 0, FP = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000100000;	/* ASIMD = 1, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x000ff0000;	/* ASIMD = 0xf, FP = 0xf */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100000000;	/* SVE =1, ASIMD = 0, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+	if (!system_supports_sve()) {
+		test_kvm_vcpu_fini(test, vcpu);
+		kunit_skip(test, "No SVE support. Partial skip)");
+		/* Not reached */
+	}
+
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_SVE;
+
+	v = 0x100000000;	/* SVE =1, ASIMD = 0, FP = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100ff0000;	/* SVE =1, ASIMD = 0, FP = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	vcpu->arch.flags &= ~KVM_ARM64_GUEST_HAS_SVE;
+
+	v = 0x1000000;		/* GIC = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	vcpu->kvm->arch.vgic.in_kernel = true;
+	v = 0x1000000;		/* GIC = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	vcpu->kvm->arch.vgic.vgic_model = KVM_DEV_TYPE_ARM_VGIC_V2;
+	v = 0x1000000;		/* GIC = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0;		/* GIC = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1000000;		/* GIC = 1 */
+	vcpu->kvm->arch.vgic.vgic_model = KVM_DEV_TYPE_ARM_VGIC_V3;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr0_el1(vcpu, id_reg, v), 0);
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_aa64pfr1_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64PFR1_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100;	/* MTE = 1*/
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	if (!system_supports_mte()) {
+		test_kvm_vcpu_fini(test, vcpu);
+		kunit_skip(test, "(No MTE support. Partial skip)");
+		/* Not reached */
+	}
+
+	vcpu->kvm->arch.mte_enabled = true;
+
+	v = 0x100;	/* MTE = 1*/
+	KUNIT_EXPECT_EQ(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x0;
+	vcpu->kvm->arch.mte_enabled = true;
+	KUNIT_EXPECT_NE(test, validate_id_aa64pfr1_el1(vcpu, id_reg, v), 0);
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_aa64isar0_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64ISAR0_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar0_el1(vcpu, id_reg, v), 0);
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
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_aa64isar1_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64ISAR1_EL1);
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000110;	/* GPI = 1, GPA = 1, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000100;	/* GPI = 1, GPA = 1, API = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x11000010;	/* GPI = 1, GPA = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000110;	/* GPI = 1, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000110;	/* GPA = 1, API = 1, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	if (!system_has_full_ptr_auth()) {
+		test_kvm_vcpu_fini(test, vcpu);
+		kunit_skip(test, "(No PTRAUTH support. Partial skip)");
+		/* Not reached */
+	}
+
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_PTRAUTH;
+
+	v = 0x10000100;	/* GPI = 1, API = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000010;	/* GPI = 1, APA = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000100;	/* GPA = 1, API = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000010;	/* GPA = 1, APA = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0;
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_aa64mmfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_info id_data, *id_reg;
+	const struct tgran_test *t4, *t64, *t16;
+	struct kvm_vcpu *vcpu;
+	int field4, field4_2, field64, field64_2, field16, field16_2;
+	u64 v, v4, lim4, v64, lim64, v16, lim16;
+	int i, j, ret;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64MMFR0_EL1);
+
+	/* Save the original id_reg_info (and restore later) */
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
+	/* Restore id_reg_info */
+	memcpy(id_reg, &id_data, sizeof(id_data));
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_aa64dfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_AA64DFR0_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	v = 0;
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10001000;	/* CTX_CMPS = 2, BRPS = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x20001000;	/* CTX_CMPS = 2, BRPS = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0xf00;	/* PMUVER = 0xf */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x100;	/* PMUVER = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	set_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features);
+
+	v = 0x100;	/* PMUVER = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x0;	/* PMUVER = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64dfr0_el1(vcpu, id_reg, v), 0);
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_id_dfr0_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = GET_ID_REG_INFO(SYS_ID_DFR0_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	v = 0;
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
+	set_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features);
+
+	v = 0x1000000;	/* PERFMON = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x2000000;	/* PERFMON = 2 */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0x3000000;	/* PERFMON = 3 */
+	KUNIT_EXPECT_EQ(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	v = 0xf000000;	/* PERFMON = 0xf */
+	KUNIT_EXPECT_NE(test, validate_id_dfr0_el1(vcpu, id_reg, v), 0);
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static void validate_mvfr1_el1_test(struct kunit *test)
+{
+	struct id_reg_info *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v;
+
+	id_reg = GET_ID_REG_INFO(SYS_MVFR1_EL1);
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_EXPECT_TRUE(test, vcpu);
+	if (!vcpu)
+		return;
+
+	v = 0;
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
+
+	test_kvm_vcpu_fini(test, vcpu);
+}
+
+static struct kunit_case kvm_sys_regs_test_cases[] = {
+	KUNIT_CASE_PARAM(arm64_check_feature_one_test, feature_one_gen_params),
+	KUNIT_CASE_PARAM(arm64_check_features_test, features_gen_params),
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
2.34.0.rc1.387.gb447b232ab-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
