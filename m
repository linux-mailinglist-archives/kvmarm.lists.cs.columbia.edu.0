Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62D3F0C4E
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 22:00:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B9774B0D8;
	Wed, 18 Aug 2021 16:00:21 -0400 (EDT)
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
	with ESMTP id cypkZHPHmvbY; Wed, 18 Aug 2021 16:00:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC0454B112;
	Wed, 18 Aug 2021 15:59:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 17CB44020A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 14:43:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J9J2C4wVIFC5 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 14:43:35 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 33E9049F5F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 14:43:35 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 x5-20020a0569020505b0290592c25b8c59so3815360ybs.18
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wYh8smn48aXYYcSZU2IfL26LMTAImxlTzaqpMoQB+vI=;
 b=kzUtgAJSv2qNhZclEaU8FzKPyTqyxNgL+/U6RRB7b/NCQvhO63nxSBfOCqe12j8twA
 V8F00bR+TZr69FrMgpIK4CoQ8ff3s8YPi1NA8tAGh3pWBM06lyx8YqVDHz2q92fvYh5N
 y6wv2XfKViL8d/TWDzK/8sFitI87sqi/58D1pYUD28q6+DTljmvediyoPFKtwWW8RKjm
 3pzeW/ksT/t5d7qHd4TPWHzFcTbuM7GglokZagJpfoL31QtWyWrNWJjaVzbJkJvr1bYZ
 +HxHwmee1VbX2GCtDvvr/xClS/kuLfWemGLXjahHSybYUj//STJlfyTym+shoKWSdV6G
 jsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wYh8smn48aXYYcSZU2IfL26LMTAImxlTzaqpMoQB+vI=;
 b=g2wVD48ty+QFsmHgYerGR+XC5oEHm/Am0xSgkEUvtgEjGWVWOAAod4ghfuFef+2d7z
 eMlsExcRGULUJ5RHa12NkdZlD9Xo7OQykZTNGc6Kaba3yHJbjAKpZnUnUSqP/rFVm/OJ
 XJAtrsfneH7Z7Qt/tdJi+X0aiS0qpCQe+1rzpEVNwYGEiywMcGSwF0SkM+bDubMvwFOr
 7Vyukz6EYw1Py7ZKaCclGhc4pHzg53KmUAAYXloLUu37RFqpczcam94Li+AUp7Fi4Zi/
 SPAWai9K33oFTsztWOnwA3eIuYC6LiiRE5vkE7tBWpOiV/6JMXp7h6+kYqY9Otl02avn
 VxfA==
X-Gm-Message-State: AOAM533RKFVvVA3EhbMrWUkjOHUMD6zos9sfEpuV5VfAbbR9IZ6CH+Ga
 f/kKMw+9Zmc5eal+CW2XNOGt51w8OfrI
X-Google-Smtp-Source: ABdhPJxOmEaD7HVk4G/6lY+hgeTQktgQhg/NyAhOupYESQ8XGpcFBIq2fwUiPCq1kOf6U13VsKLCyVSfEXxd
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:4216:: with SMTP id
 p22mr12570656yba.397.1629312214825; Wed, 18 Aug 2021 11:43:34 -0700 (PDT)
Date: Wed, 18 Aug 2021 18:43:09 +0000
In-Reply-To: <20210818184311.517295-1-rananta@google.com>
Message-Id: <20210818184311.517295-9-rananta@google.com>
Mime-Version: 1.0
References: <20210818184311.517295-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 08/10] KVM: arm64: selftests: Add light-weight spinlock
 support
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>
X-Mailman-Approved-At: Wed, 18 Aug 2021 15:59:47 -0400
Cc: kvm@vger.kernel.org, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>, kvmarm@lists.cs.columbia.edu
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

Add a simpler version of spinlock support for ARM64 for
the guests to use.

The implementation is loosely based on the spinlock
implementation in kvm-unit-tests.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../selftests/kvm/include/aarch64/spinlock.h  | 13 +++++++++
 .../selftests/kvm/lib/aarch64/spinlock.c      | 27 +++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/spinlock.h
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/spinlock.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..8f6d82b570bd 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,7 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
-LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
+LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
diff --git a/tools/testing/selftests/kvm/include/aarch64/spinlock.h b/tools/testing/selftests/kvm/include/aarch64/spinlock.h
new file mode 100644
index 000000000000..cf0984106d14
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/spinlock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef SELFTEST_KVM_ARM64_SPINLOCK_H
+#define SELFTEST_KVM_ARM64_SPINLOCK_H
+
+struct spinlock {
+	int v;
+};
+
+extern void spin_lock(struct spinlock *lock);
+extern void spin_unlock(struct spinlock *lock);
+
+#endif /* SELFTEST_KVM_ARM64_SPINLOCK_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/spinlock.c b/tools/testing/selftests/kvm/lib/aarch64/spinlock.c
new file mode 100644
index 000000000000..6d66a3dac237
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/aarch64/spinlock.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 Spinlock support
+ */
+#include <stdint.h>
+
+#include "spinlock.h"
+
+void spin_lock(struct spinlock *lock)
+{
+	uint32_t val, res;
+
+	asm volatile(
+	"1:	ldaxr	%w0, [%2]\n"
+	"	cbnz	%w0, 1b\n"
+	"	mov	%w0, #1\n"
+	"	stxr	%w1, %w0, [%2]\n"
+	"	cbnz	%w1, 1b\n"
+	: "=&r" (val), "=&r" (res)
+	: "r" (&lock->v)
+	: "memory");
+}
+
+void spin_unlock(struct spinlock *lock)
+{
+	asm volatile("stlr wzr, [%0]\n"	: : "r" (&lock->v) : "memory");
+}
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
