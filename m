Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 493B333BCBB
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 15:35:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ECC924B5AA;
	Mon, 15 Mar 2021 10:35:52 -0400 (EDT)
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
	with ESMTP id RyYsD15T0u9C; Mon, 15 Mar 2021 10:35:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD9414B5AB;
	Mon, 15 Mar 2021 10:35:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E55824B5A7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 10:35:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ycgx4xJ+LftU for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 10:35:48 -0400 (EDT)
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D05F84B5BB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 10:35:47 -0400 (EDT)
Received: by mail-wm1-f74.google.com with SMTP id c7so8283422wml.8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=L8AAIWNPQ1dDcNSKWQN4i2g9ce1CACsE0X8GRkSHj90=;
 b=F+MCj7E/I5FdfVqb+2pdibjqfY1nTLTI23SmoLV/tXQ2QxEaxzSdyAfPUaEupshTdC
 RAtxpDbWz5CQ7g/af8rI5dt8cg+cfsqORFa9IZLebVXrbxVisPAL5XREl0F7q+ig4Ohx
 um0OHPcFj0clCFjf0Z947XFHsZSWZDlUKQpAg+u/URRYVuVwIKaBzmf4Sq1gpfZfYbRf
 Sso4JE5zFcOTVh0O0XPZEtzmJzQnz3iSpVaZeYmKYbWerA/BHk3L1Wb9x/8gcVACj6Lu
 xemtVGy03b1c04f3xusJ97bH9CpggaaMYFaiIzuSXPKN0fU0TWKb2laNg0M/LNUWqAZu
 wtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=L8AAIWNPQ1dDcNSKWQN4i2g9ce1CACsE0X8GRkSHj90=;
 b=Ke873mFnHNbSbfTl+8tOzdrKKTL+X+2a7dHsTB1oqtcOaEAYuxgZGuBrt7i6RCm3hs
 jZcnLhHlcZ+brS/7lEB/65okC/XQbi+a8AKItoiR0ZScYZovip0Ns4dWG64UZdp7gAM1
 8eo9RTmIUjv+HDV8pgOv34+IyYQLxu+aP7tZvwtnO2LqGFwt3Kjmbpp0Aj06ECxyayJh
 w9uW0NBJLPSsHrAn7pTfTD1TPB5QFjccLHXX8eb7yZi/nNTDK7uTMGcnj/YoKQlgtfqT
 Vcnc8eGrOPk/RRqNR+bQ8x1ETMjkrzu/2g4WO1JzWVKfgAuX0yx3uL4/548YPGTwC7G6
 w9jw==
X-Gm-Message-State: AOAM533fbZ2YKBWMudtiiXuoow4Ls1LxG4FJ0lEY+wnZ1BfcH0BEBJav
 JclR7BUPJVBLR4dFTTFQnLCszOHFo3Gi
X-Google-Smtp-Source: ABdhPJx8V7P2YtiT8B2D1YooW7EBW+hxWy0Iw4siQ0JVnCrrmjIF5cJoWMp9R3HYDdUDbia0FBdH7XA8M1NJ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:6243:: with SMTP id
 w64mr1121458wmb.0.1615818946274; Mon, 15 Mar 2021 07:35:46 -0700 (PDT)
Date: Mon, 15 Mar 2021 14:35:03 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-4-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 03/36] arm64: kvm: Add standalone ticket spinlock
 implementation for use at hyp
From: Quentin Perret <qperret@google.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Cc: android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, tabba@google.com,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

From: Will Deacon <will@kernel.org>

We will soon need to synchronise multiple CPUs in the hyp text at EL2.
The qspinlock-based locking used by the host is overkill for this purpose
and relies on the kernel's "percpu" implementation for the MCS nodes.

Implement a simple ticket locking scheme based heavily on the code removed
by commit c11090474d70 ("arm64: locking: Replace ticket lock implementation
with qspinlock").

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
new file mode 100644
index 000000000000..76b537f8d1c6
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * A stand-alone ticket spinlock implementation for use by the non-VHE
+ * KVM hypervisor code running at EL2.
+ *
+ * Copyright (C) 2020 Google LLC
+ * Author: Will Deacon <will@kernel.org>
+ *
+ * Heavily based on the implementation removed by c11090474d70 which was:
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ARM64_KVM_NVHE_SPINLOCK_H__
+#define __ARM64_KVM_NVHE_SPINLOCK_H__
+
+#include <asm/alternative.h>
+#include <asm/lse.h>
+
+typedef union hyp_spinlock {
+	u32	__val;
+	struct {
+#ifdef __AARCH64EB__
+		u16 next, owner;
+#else
+		u16 owner, next;
+#endif
+	};
+} hyp_spinlock_t;
+
+#define hyp_spin_lock_init(l)						\
+do {									\
+	*(l) = (hyp_spinlock_t){ .__val = 0 };				\
+} while (0)
+
+static inline void hyp_spin_lock(hyp_spinlock_t *lock)
+{
+	u32 tmp;
+	hyp_spinlock_t lockval, newval;
+
+	asm volatile(
+	/* Atomically increment the next ticket. */
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+"	prfm	pstl1strm, %3\n"
+"1:	ldaxr	%w0, %3\n"
+"	add	%w1, %w0, #(1 << 16)\n"
+"	stxr	%w2, %w1, %3\n"
+"	cbnz	%w2, 1b\n",
+	/* LSE atomics */
+"	mov	%w2, #(1 << 16)\n"
+"	ldadda	%w2, %w0, %3\n"
+	__nops(3))
+
+	/* Did we get the lock? */
+"	eor	%w1, %w0, %w0, ror #16\n"
+"	cbz	%w1, 3f\n"
+	/*
+	 * No: spin on the owner. Send a local event to avoid missing an
+	 * unlock before the exclusive load.
+	 */
+"	sevl\n"
+"2:	wfe\n"
+"	ldaxrh	%w2, %4\n"
+"	eor	%w1, %w2, %w0, lsr #16\n"
+"	cbnz	%w1, 2b\n"
+	/* We got the lock. Critical section starts here. */
+"3:"
+	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
+	: "Q" (lock->owner)
+	: "memory");
+}
+
+static inline void hyp_spin_unlock(hyp_spinlock_t *lock)
+{
+	u64 tmp;
+
+	asm volatile(
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	ldrh	%w1, %0\n"
+	"	add	%w1, %w1, #1\n"
+	"	stlrh	%w1, %0",
+	/* LSE atomics */
+	"	mov	%w1, #1\n"
+	"	staddlh	%w1, %0\n"
+	__nops(1))
+	: "=Q" (lock->owner), "=&r" (tmp)
+	:
+	: "memory");
+}
+
+#endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
