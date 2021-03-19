Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7334191C
	for <lists+kvmarm@lfdr.de>; Fri, 19 Mar 2021 11:02:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 93A264B686;
	Fri, 19 Mar 2021 06:02:18 -0400 (EDT)
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
	with ESMTP id TWxoQXVL8K70; Fri, 19 Mar 2021 06:02:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3209C4B6B0;
	Fri, 19 Mar 2021 06:02:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8505F4B5D8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 06:02:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlnuKhbRWvHc for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 06:02:13 -0400 (EDT)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AA12D4B610
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 06:02:13 -0400 (EDT)
Received: by mail-qv1-f73.google.com with SMTP id u17so31771823qvq.23
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
 b=dpjDBn6OQpH5nXPKZsRJwReQXwbupeBLtYsMpd576nHxHjvnVc9vqmVeYVqLuoneaK
 2/gC7yD7I/DtFOk15LofKF36Dw24Wv6Sv8dC52KQRYF1DluXut/IFYKkV108Ni5SSv+h
 BAgmE0xLosT42H7aMLk+Rm+1LHDumfxog8gA7y5gWlN03GqE5TOZ2qFMFfz25+hy+st3
 iOzPFZ2VmH2IhadveRw5E5FJi8M+fyQ5mb46COqCD7HHx6+pZVmAtnrdXzyD88leRm5f
 cegleOOJQIjNH3rHYuIjh1XtNE9mCawnKwxERwDK7stiTysr5C9UpfJ63Peg7UUGKxAV
 z5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
 b=L4qbkYp4W+xL2Ly85qRMMBuo85cyf6bdP5zUW8FCDcukq+cR6ceye8A1/1pqIv8Pjo
 ipuJcXC8POaP5kQH8Vy2ZJnVx63i8cBzFqUB1OqbqXprv3Jo61JxHr25SxEY4t6TrtAp
 Zx53rtKtUrQO+UGcXc/EuJszbXDaqp9oQpWlDv5L6XudhjPs2oFle4ZCWtDX+/ZC7aa+
 afWcajezTwSMGvbZ/FyOnuLUCxQkMoAsPZ2lphxkxgHX/wr0bcLY+CsmKP0fqPN8A2Tb
 U3xKUeflSNpfjhqwSmon9ugH3EZmjhOo7IFSh0EB4fPuCPJhlwUwRy9/zrGjrQXxTjkO
 B2Yg==
X-Gm-Message-State: AOAM531uFSI4LdjQUgu8IyS4bN98sR0eQ2BGasjcWIHogNtFJ6lQS9dt
 cTdLC1KGRN3SghkYjUA/JghPaj24P+ZD
X-Google-Smtp-Source: ABdhPJy40vcJgyO4z2WwwLPNXTxcJo3PmnLkzvLiVsroYLI2jeLnpRpxAFfdfa6RyPy0NgQ4uvhb7terjePA
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:eb87:: with SMTP id
 x7mr8762653qvo.14.1616148133288; Fri, 19 Mar 2021 03:02:13 -0700 (PDT)
Date: Fri, 19 Mar 2021 10:01:19 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-12-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 11/38] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
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

In order to use the kernel list library at EL2, introduce stubs for the
CONFIG_DEBUG_LIST out-of-lines calls.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
 arch/arm64/kvm/hyp/nvhe/stub.c   | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 24ff99e2eac5..144da72ad510 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,7 +13,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
new file mode 100644
index 000000000000..c0aa6bbfd79d
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/stub.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Stubs for out-of-line function calls caused by re-using kernel
+ * infrastructure at EL2.
+ *
+ * Copyright (C) 2020 - Google LLC
+ */
+
+#include <linux/list.h>
+
+#ifdef CONFIG_DEBUG_LIST
+bool __list_add_valid(struct list_head *new, struct list_head *prev,
+		      struct list_head *next)
+{
+		return true;
+}
+
+bool __list_del_entry_valid(struct list_head *entry)
+{
+		return true;
+}
+#endif
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
