Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E157C3E0
	for <lists+kvmarm@lfdr.de>; Thu, 21 Jul 2022 07:57:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73BCC4D9D7;
	Thu, 21 Jul 2022 01:57:40 -0400 (EDT)
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
	with ESMTP id M5YvpSIDK7xy; Thu, 21 Jul 2022 01:57:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 019BC4DA05;
	Thu, 21 Jul 2022 01:57:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 73AAE4D0F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jul 2022 01:57:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ho9v4QX-jBY1 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Jul 2022 01:57:36 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F34BB4CB66
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jul 2022 01:57:35 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 k64-20020a253d43000000b0067080eb57fdso587454yba.5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 Jul 2022 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/mwH9EWDJWeQ4laSz1bWCJhYrLz4u2A8wHs/a7qp59U=;
 b=HVMOkL8lAmyxaj14HSkhJ/XpnwUixvSfAWxN5/y+aX2HAXjSBlkKVweGHVwOwt8XtV
 YxYTQMZXio8PdX6ANR3JdivsMX/96xETdvW1x6+oXuvMLM9SDZlwR9n6AEUddsVcOvi6
 cajz6uQYDGQTHEiB/aRqBTEp1L8kbRksRmzY+mg2oIWFgDE0yBGf7REFbRs+/EBv76Re
 MmgL3lUX6VAMjkIgbWm+s+2peqTyg9A+Flrh4X/ZjyDuBSXK+9wqsALLfXz3hfA9UKBf
 fHy6W+xIyxmkAa87YOP9kTmMLMEd4Xa3+zWRzroj/9W0RWTD6tJ3EGY7E8nI1D6dP9rC
 eXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/mwH9EWDJWeQ4laSz1bWCJhYrLz4u2A8wHs/a7qp59U=;
 b=TneWuvQCaGB2CdPxULoXzbiH0l9hSRl8wEXPIH5xNYMOwBf3h1LXad17aFqChJxPIj
 3OfGkqvrWiNwn3JPuoTliaRQQByUQTs5fE87x52X+9i0OtBaF03oOt51F1o07qWSyuM7
 nwtK2v0f3s2yXfaKs6ww1WyNeXbnGeW+mIOU6pZGfAq2LokVUaw+tf+yc+YL29Uom6me
 bdRlCEhHPIDqsv0DRB03BXsjrj5AE++hV21R2Q0gEE4RFq6a3teitJzG7a7vXRRY/KBG
 6UTByP3lMJuLgnT31pykMuqHL7ynddhnM93QUgRdLlXUWGJjKM0jgInuXXtD2B4Rb3a+
 KkGA==
X-Gm-Message-State: AJIora9aP3HBnn20lCzoFAdca0Iw4aqoL+8liEz9DDesoj9c/RSzC/xu
 wDNl2g2kfNnlPUt9ncii6SCxpzkRAcLjvAbjXw==
X-Google-Smtp-Source: AGRyM1vthVL8l0Tsianog3OGjfg5ppgLsI6G8O96dlBCQ/jcifO3VCL34n3vIaVHrhOdKHAcwrECZcLJMQCbe2jBOQ==
X-Received: from kaleshsingh.mtv.corp.google.com
 ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:6a57:0:b0:66e:c1bf:4a2 with SMTP
 id f84-20020a256a57000000b0066ec1bf04a2mr38420840ybc.263.1658383055575; Wed,
 20 Jul 2022 22:57:35 -0700 (PDT)
Date: Wed, 20 Jul 2022 22:57:12 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 01/17] arm64: stacktrace: Add shared header for common
 stack unwinding code
From: Kalesh Singh <kaleshsingh@google.com>
To: maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org, 
 madvenka@linux.microsoft.com, tabba@google.com
Cc: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, elver@google.com,
 vincenzo.frascino@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 android-mm@google.com, kernel-team@android.com, drjones@redhat.com,
 ast@kernel.org, linux-arm-kernel@lists.infradead.org, andreyknvl@gmail.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org
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

In order to reuse the arm64 stack unwinding logic for the nVHE
hypervisor stack, move the common code to a shared header
(arch/arm64/include/asm/stacktrace/common.h).

The nVHE hypervisor cannot safely link against kernel code, so we
make use of the shared header to avoid duplicated logic later in
this series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v5:
  - Add Reviewed-by tags from Mark Brown and Fuad

 arch/arm64/include/asm/stacktrace.h        |  35 +------
 arch/arm64/include/asm/stacktrace/common.h | 105 +++++++++++++++++++++
 arch/arm64/kernel/stacktrace.c             |  57 -----------
 3 files changed, 106 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm64/include/asm/stacktrace/common.h

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index aec9315bf156..79f455b37c84 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -8,52 +8,19 @@
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
-#include <linux/types.h>
 #include <linux/llist.h>
 
 #include <asm/memory.h>
 #include <asm/ptrace.h>
 #include <asm/sdei.h>
 
-enum stack_type {
-	STACK_TYPE_UNKNOWN,
-	STACK_TYPE_TASK,
-	STACK_TYPE_IRQ,
-	STACK_TYPE_OVERFLOW,
-	STACK_TYPE_SDEI_NORMAL,
-	STACK_TYPE_SDEI_CRITICAL,
-	__NR_STACK_TYPES
-};
-
-struct stack_info {
-	unsigned long low;
-	unsigned long high;
-	enum stack_type type;
-};
+#include <asm/stacktrace/common.h>
 
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
 DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-static inline bool on_stack(unsigned long sp, unsigned long size,
-			    unsigned long low, unsigned long high,
-			    enum stack_type type, struct stack_info *info)
-{
-	if (!low)
-		return false;
-
-	if (sp < low || sp + size < sp || sp + size > high)
-		return false;
-
-	if (info) {
-		info->low = low;
-		info->high = high;
-		info->type = type;
-	}
-	return true;
-}
-
 static inline bool on_irq_stack(unsigned long sp, unsigned long size,
 				struct stack_info *info)
 {
diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
new file mode 100644
index 000000000000..64ae4f6b06fe
--- /dev/null
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common arm64 stack unwinder code.
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ */
+#ifndef __ASM_STACKTRACE_COMMON_H
+#define __ASM_STACKTRACE_COMMON_H
+
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+enum stack_type {
+	STACK_TYPE_UNKNOWN,
+	STACK_TYPE_TASK,
+	STACK_TYPE_IRQ,
+	STACK_TYPE_OVERFLOW,
+	STACK_TYPE_SDEI_NORMAL,
+	STACK_TYPE_SDEI_CRITICAL,
+	__NR_STACK_TYPES
+};
+
+struct stack_info {
+	unsigned long low;
+	unsigned long high;
+	enum stack_type type;
+};
+
+/*
+ * A snapshot of a frame record or fp/lr register values, along with some
+ * accounting information necessary for robust unwinding.
+ *
+ * @fp:          The fp value in the frame record (or the real fp)
+ * @pc:          The lr value in the frame record (or the real lr)
+ *
+ * @stacks_done: Stacks which have been entirely unwound, for which it is no
+ *               longer valid to unwind to.
+ *
+ * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
+ *               of 0. This is used to ensure that within a stack, each
+ *               subsequent frame record is at an increasing address.
+ * @prev_type:   The type of stack this frame record was on, or a synthetic
+ *               value of STACK_TYPE_UNKNOWN. This is used to detect a
+ *               transition from one stack to another.
+ *
+ * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
+ *               associated with the most recently encountered replacement lr
+ *               value.
+ *
+ * @task:        The task being unwound.
+ */
+struct unwind_state {
+	unsigned long fp;
+	unsigned long pc;
+	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
+	unsigned long prev_fp;
+	enum stack_type prev_type;
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+#endif
+	struct task_struct *task;
+};
+
+static inline bool on_stack(unsigned long sp, unsigned long size,
+			    unsigned long low, unsigned long high,
+			    enum stack_type type, struct stack_info *info)
+{
+	if (!low)
+		return false;
+
+	if (sp < low || sp + size < sp || sp + size > high)
+		return false;
+
+	if (info) {
+		info->low = low;
+		info->high = high;
+		info->type = type;
+	}
+	return true;
+}
+
+static inline void unwind_init_common(struct unwind_state *state,
+				      struct task_struct *task)
+{
+	state->task = task;
+#ifdef CONFIG_KRETPROBES
+	state->kr_cur = NULL;
+#endif
+
+	/*
+	 * Prime the first unwind.
+	 *
+	 * In unwind_next() we'll check that the FP points to a valid stack,
+	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
+	 * treated as a transition to whichever stack that happens to be. The
+	 * prev_fp value won't be used, but we set it to 0 such that it is
+	 * definitely not an accessible stack address.
+	 */
+	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
+	state->prev_fp = 0;
+	state->prev_type = STACK_TYPE_UNKNOWN;
+}
+
+#endif	/* __ASM_STACKTRACE_COMMON_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index fcaa151b81f1..94a5dd2ab8fd 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -18,63 +18,6 @@
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
-/*
- * A snapshot of a frame record or fp/lr register values, along with some
- * accounting information necessary for robust unwinding.
- *
- * @fp:          The fp value in the frame record (or the real fp)
- * @pc:          The lr value in the frame record (or the real lr)
- *
- * @stacks_done: Stacks which have been entirely unwound, for which it is no
- *               longer valid to unwind to.
- *
- * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
- *               of 0. This is used to ensure that within a stack, each
- *               subsequent frame record is at an increasing address.
- * @prev_type:   The type of stack this frame record was on, or a synthetic
- *               value of STACK_TYPE_UNKNOWN. This is used to detect a
- *               transition from one stack to another.
- *
- * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
- *               associated with the most recently encountered replacement lr
- *               value.
- *
- * @task:        The task being unwound.
- */
-struct unwind_state {
-	unsigned long fp;
-	unsigned long pc;
-	DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
-	unsigned long prev_fp;
-	enum stack_type prev_type;
-#ifdef CONFIG_KRETPROBES
-	struct llist_node *kr_cur;
-#endif
-	struct task_struct *task;
-};
-
-static void unwind_init_common(struct unwind_state *state,
-			       struct task_struct *task)
-{
-	state->task = task;
-#ifdef CONFIG_KRETPROBES
-	state->kr_cur = NULL;
-#endif
-
-	/*
-	 * Prime the first unwind.
-	 *
-	 * In unwind_next() we'll check that the FP points to a valid stack,
-	 * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
-	 * treated as a transition to whichever stack that happens to be. The
-	 * prev_fp value won't be used, but we set it to 0 such that it is
-	 * definitely not an accessible stack address.
-	 */
-	bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
-	state->prev_fp = 0;
-	state->prev_type = STACK_TYPE_UNKNOWN;
-}
-
 /*
  * Start an unwind from a pt_regs.
  *
-- 
2.37.0.170.g444d1eabd0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
