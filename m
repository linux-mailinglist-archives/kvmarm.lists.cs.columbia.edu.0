Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEB50651D
	for <lists+kvmarm@lfdr.de>; Tue, 19 Apr 2022 08:57:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 141634B23A;
	Tue, 19 Apr 2022 02:57:56 -0400 (EDT)
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
	with ESMTP id J3+HGkyVyjx7; Tue, 19 Apr 2022 02:57:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D2A604B25E;
	Tue, 19 Apr 2022 02:57:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5058A4B1BF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 02:57:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8z+rHoiOruU for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Apr 2022 02:57:46 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 358484B1F2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Apr 2022 02:57:44 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 v9-20020a17090a7c0900b001cb45f88cdcso10161561pjf.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Apr 2022 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Vbwtrqr+eHVV/oHotYjLI/3rV0rt1T+kM65UOU/rgIA=;
 b=REPpged9kFttbzIyZ/YCTSb0/AoOiPFxrc6ZizNpZjiCvowQkfRs4MrZqLc9pZmF5g
 55y1bSYWXl39XsZqivfk0dNGnc3aQIZXk1Bfl42nbaxTeK8iQvmq03j5yRgRChR3Yvtg
 4HT3uU9Zsz41ooAVIRNNHjT1PAxJFO6QMnOmPea8mFSUJH67F9kofqaDXNA/OUMK9TYS
 WvtVFJX+KXDj3678fqk5C7NDg6jzBD8xhujtOn3jpQD4ZKcXIt3Ks2o3HYCAFNJ/wuoR
 iXZWzM2lRrlWpLRu6oPd+enNnA6RGYXmQZyo4RGzZSpnz4c43307Iw6tPUJ264+0y6+V
 yYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Vbwtrqr+eHVV/oHotYjLI/3rV0rt1T+kM65UOU/rgIA=;
 b=W5NpzFXzGsA4pyBpAcbpAl6ZBcke9sD0hBCqfz3+Kl0LqR1rptCwZbiWn+LW6UG6Ea
 NmnJ4qcWRLJYrOPxM1FBPGFH0x39ZUf7lI6TToTBnWdjrdV37nfcbQxBnwEU9Ci8ZePt
 5vIuoKAtxp0KgkUw/IdoNi0IuYtZpl3fnYI1+RWngEoN8Y7mpUmTINuN3nzSFbIscR4w
 A4FuQixZ7bBE668Y0hb3WXboCpnHyTIUanJaVLZHrX5muH+EA12Paisfy/zLBaZwRk4/
 jDfUyJOSlvq5MYeekno1scmKzEEzDRl28OM6PW8U51qmFJBpX2K9Ma9VGyRj/TUD+nnX
 aIYw==
X-Gm-Message-State: AOAM5307U1VnTjIu/eXhY2moZlDfqyMGLYOxmaEyUcXeHPbr+TLCjBgU
 ZlLkLdgO6bUBjqKuG5GiCz/63xlqz6U=
X-Google-Smtp-Source: ABdhPJwnhrejVRefMrvmQDGwzk9+Az3BAg+uNSDFoDPTXNp0c/NSEgSr4ixFwAHzivhuRewJuhcx0BiUDnM=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id
 p15-20020a056a0026cf00b004f6fc527b6amr16349280pfw.39.1650351463411; Mon, 18
 Apr 2022 23:57:43 -0700 (PDT)
Date: Mon, 18 Apr 2022 23:55:29 -0700
In-Reply-To: <20220419065544.3616948-1-reijiw@google.com>
Message-Id: <20220419065544.3616948-24-reijiw@google.com>
Mime-Version: 1.0
References: <20220419065544.3616948-1-reijiw@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v7 23/38] KVM: arm64: Add kunit test for ID register validation
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

Since tools/testing/kunit/qemu_configs/arm64.py, which is the
default qemu_config for arm64, doesn't have all params that the
new tests needs, 'extra_qemu_params' in the default one needs to be
replaced with the one below to fully run all of those kunit tests.

 extra_qemu_params=['-M virt,virtualization=on,mte=on', '-cpu max,sve=on'])
 (the default one: extra_qemu_params=['-machine virt', '-cpu cortex-a57'])

The outputs from the tests are:
-----------------------------------------------------------------------
$ tools/testing/kunit/kunit.py run --timeout=60 --jobs=`nproc --all` \
          --arch=arm64 --cross_compile=aarch64-linux-gnu- \
          --qemu_config arm64_kvm_min.py \
          --kunitconfig=arch/arm64/kvm/.kunitconfig
[22:45:39] Configuring KUnit Kernel ...
[22:45:39] Building KUnit Kernel ...
Populating config with:
$ make ARCH=arm64 olddefconfig CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
Building with:
$ make ARCH=arm64 --jobs=96 CROSS_COMPILE=aarch64-linux-gnu- O=.kunit
[22:45:47] Starting KUnit Kernel (1/1)...
[22:45:47] ============================================================
Running tests with:
$ qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Image.gz -append 'mem=1G console=tty kunit_shutdown=halt console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -M virt,virtualization=on,mte=on -cpu max,sve=on
[22:45:48] ========== kvm-sys-regs-test-suite (14 subtests) ===========
[22:45:48] =========== vcpu_id_reg_feature_frac_check_test ============
[22:45:48] [PASSED] feat - shift:28, val:1, lim:2, frac - shift:12, val:1, lim:1
[22:45:48] [PASSED] feat - shift:28, val:1, lim:2, frac - shift:12, val:1, lim:2
[22:45:48] [PASSED] feat - shift:28, val:1, lim:2, frac - shift:12, val:2, lim:1
[22:45:48] [PASSED] feat - shift:28, val:1, lim:1, frac - shift:12, val:1, lim:1
[22:45:48] [PASSED] feat - shift:28, val:1, lim:1, frac - shift:12, val:1, lim:2
[22:45:48] [PASSED] feat - shift:28, val:1, lim:1, frac - shift:12, val:2, lim:1
[22:45:48] ======= [PASSED] vcpu_id_reg_feature_frac_check_test =======
[22:45:48] ============ validate_id_aa64mmfr0_tgran2_test =============
[22:45:48] [PASSED] gran2(field=40): val=2, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=2, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=1, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=1 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=2 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=2 gran1: val=1 limit=0
[22:45:48] [PASSED] gran2(field=40): val=1, lim=0 gran1: val=0 limit=15
[22:45:48] [PASSED] gran2(field=40): val=1, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=2, lim=0 gran1: val=15 limit=15
[22:45:48] [PASSED] gran2(field=40): val=2, lim=0 gran1: val=0 limit=0
[22:45:48] ======== [PASSED] validate_id_aa64mmfr0_tgran2_test ========
[22:45:48] ============ validate_id_aa64mmfr0_tgran2_test =============
[22:45:48] [PASSED] gran2(field=36): val=2, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=2, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=1, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=0, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=0, lim=1 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=36): val=0, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=0, lim=2 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=36): val=1, lim=0 gran1: val=0 limit=15
[22:45:48] [PASSED] gran2(field=36): val=1, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=36): val=2, lim=0 gran1: val=15 limit=15
[22:45:48] [PASSED] gran2(field=36): val=2, lim=0 gran1: val=0 limit=0
[22:45:48] ======== [PASSED] validate_id_aa64mmfr0_tgran2_test ========
[22:45:48] ============ validate_id_aa64mmfr0_tgran2_test =============
[22:45:48] [PASSED] gran2(field=32): val=2, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=2, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=1, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=0, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=0, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=0, lim=1 gran1: val=1 limit=0
[22:45:48] [PASSED] gran2(field=32): val=0, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=0, lim=2 gran1: val=2 limit=2
[22:45:48] [PASSED] gran2(field=32): val=1, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=1, lim=0 gran1: val=0 limit=1
[22:45:48] [PASSED] gran2(field=32): val=2, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=32): val=2, lim=0 gran1: val=0 limit=1
[22:45:48] [PASSED] gran2(field=32): val=2, lim=0 gran1: val=0 limit=2
[22:45:48] ======== [PASSED] validate_id_aa64mmfr0_tgran2_test ========
[22:45:48] [PASSED] validate_id_aa64pfr0_el1_test
[22:45:48] [PASSED] validate_id_aa64pfr1_el1_test
[22:45:48] [PASSED] validate_id_aa64isar0_el1_test
[22:45:48] [PASSED] validate_id_aa64isar1_el1_test
[22:45:48] [PASSED] validate_id_aa64isar2_el1_test
[22:45:48] ============== validate_id_aa64mmfr0_el1_test ==============
[22:45:48] [PASSED] gran2(field=40): val=2, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=2, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=1, lim=2 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=1 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=1 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=2 gran1: val=15 limit=0
[22:45:48] [PASSED] gran2(field=40): val=0, lim=2 gran1: val=1 limit=0
[22:45:48] [PASSED] gran2(field=40): val=1, lim=0 gran1: val=0 limit=15
[22:45:48] [PASSED] gran2(field=40): val=1, lim=0 gran1: val=0 limit=0
[22:45:48] [PASSED] gran2(field=40): val=2, lim=0 gran1: val=15 limit=15
[22:45:48] [PASSED] gran2(field=40): val=2, lim=0 gran1: val=0 limit=0
[22:45:48] ========= [PASSED] validate_id_aa64mmfr0_el1_test ==========
[22:45:48] [PASSED] validate_id_aa64dfr0_el1_test
[22:45:48] [PASSED] validate_id_dfr0_el1_test
[22:45:48] [PASSED] validate_mvfr1_el1_test
[22:45:48] [PASSED] validate_id_reg_test
[22:45:48] ============= [PASSED] kvm-sys-regs-test-suite =============
[22:45:48] ============================================================
[22:45:48] Testing complete. Passed: 63, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
[22:45:48] Elapsed time: 8.977s total, 0.003s configuring, 7.300s building, 1.620s running
-----------------------------------------------------------------------

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/.kunitconfig    |    4 +
 arch/arm64/kvm/Kconfig         |   11 +
 arch/arm64/kvm/sys_regs.c      |    4 +
 arch/arm64/kvm/sys_regs_test.c | 1068 ++++++++++++++++++++++++++++++++
 4 files changed, 1087 insertions(+)
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
index fc7a8f2539a4..a71c52aee34e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4486,3 +4486,7 @@ static void kvm_reset_id_regs(struct kvm_vcpu *vcpu)
 			r->reset(vcpu, r);
 	}
 }
+
+#if IS_ENABLED(CONFIG_KVM_KUNIT_TEST)
+#include "sys_regs_test.c"
+#endif
diff --git a/arch/arm64/kvm/sys_regs_test.c b/arch/arm64/kvm/sys_regs_test.c
new file mode 100644
index 000000000000..dff146fe0e62
--- /dev/null
+++ b/arch/arm64/kvm/sys_regs_test.c
@@ -0,0 +1,1068 @@
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
+	set_bit(KVM_ARCH_FLAG_MTE_ENABLED, &vcpu->kvm->arch.flags);
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
+	u64 v, org_limit;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64ISAR1_EL1);
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
+	/* Tests with PTRAUTH disabled */
+
+	/* Just for convenience, set all of GPI/GPA/API/APA to 1. */
+	org_limit = id_reg->vcpu_limit_val;
+	id_reg->vcpu_limit_val = 0x11000110;
+
+	v = 0x00000000;	/* GPI = 0, GPA = 0, API = 0, APA = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000100;	/* GPI = 1, GPA = 0, API = 1, APA = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x10000010;	/* GPI = 1, GPA = 0, API = 0, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000100;	/* GPI = 0, GPA = 1, API = 1, APA = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	v = 0x01000010;	/* GPI = 0, GPA = 1, API = 0, APA = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar1_el1(vcpu, id_reg, v), 0);
+
+	if (!system_has_full_ptr_auth()) {
+		id_reg->vcpu_limit_val = org_limit;
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
+	/* Restore the original value */
+	id_reg->vcpu_limit_val = org_limit;
+}
+
+/* Tests for validate_id_aa64isar2_el1() */
+static void validate_id_aa64isar2_el1_test(struct kunit *test)
+{
+	struct id_reg_desc *id_reg;
+	struct kvm_vcpu *vcpu;
+	u64 v, org_limit;
+
+	vcpu = test_kvm_vcpu_init(test);
+	KUNIT_ASSERT_TRUE(test, vcpu);
+
+	id_reg = get_id_reg_desc(SYS_ID_AA64ISAR2_EL1);
+
+	/* Tests for GPA3/APA3. */
+
+	/* Tests with PTRAUTH disabled  */
+
+	/* Set the limit of APA3/GPA3 to 1. */
+	org_limit = id_reg->vcpu_limit_val;
+	id_reg->vcpu_limit_val = 0x1100;
+
+	v = 0x0000;	/* GPA3 = 0, APA3 = 0 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1000;	/* GPA3 = 1, APA3 = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0x0100;	/* GPA3 = 0, APA3 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1100;	/* GPA3 = 1, APA3 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	if (!system_has_full_ptr_auth()) {
+		id_reg->vcpu_limit_val = org_limit;
+		kunit_skip(test, "(No PTRAUTH support. Partial skip)");
+		/* Not reached */
+	}
+
+	/* Tests with PTRAUTH enabled */
+	vcpu->arch.flags |= KVM_ARM64_GUEST_HAS_PTRAUTH;
+
+	v = 0x1100;	/* APA3 = 1, GPA3 = 1 */
+	KUNIT_EXPECT_EQ(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0x1000;	/* APA3 = 1, GPA3 = 0 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0x0100;	/* APA3 = 0, GPA3 = 1 */
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	v = 0;
+	KUNIT_EXPECT_NE(test, validate_id_aa64isar2_el1(vcpu, id_reg, v), 0);
+
+	/* Restore the original value */
+	id_reg->vcpu_limit_val = org_limit;
+}
+
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
+
+	/* Copy ftr_bits from the original one */
+	original_idr = get_id_reg_desc(id);
+	memcpy(idr->ftr_bits, original_idr->ftr_bits, sizeof(idr->ftr_bits));
+	idr->vcpu_limit_val = (u64)flim << pos;
+	validate_id_reg_test_one_field(test, id, pos, fval, flim, false, idr);
+
+	/* Test with signed field */
+	pos = ID_AA64PFR0_FP_SHIFT;
+
+	/* Set up id_reg_desc for testing */
+	memset(idr, 0, sizeof(*idr));
+	set_sys_desc((struct sys_reg_desc *)&idr->reg_desc, id);
+
+	/* Copy ftr_bits from the original one */
+	memcpy(idr->ftr_bits, original_idr->ftr_bits, sizeof(idr->ftr_bits));
+
+	idr->vcpu_limit_val = (u64)flim << pos;
+	validate_id_reg_test_one_field(test, id, pos, fval, flim, true, idr);
+
+	/* Test with the original limit val */
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
+	KUNIT_CASE(validate_id_aa64isar2_el1_test),
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
2.36.0.rc0.470.gd361397f0d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
