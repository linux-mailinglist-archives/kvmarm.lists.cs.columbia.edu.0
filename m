Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEA140BB84
	for <lists+kvmarm@lfdr.de>; Wed, 15 Sep 2021 00:31:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C17694B101;
	Tue, 14 Sep 2021 18:31:41 -0400 (EDT)
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
	with ESMTP id GsZVc63+wcFU; Tue, 14 Sep 2021 18:31:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 784CC4B0F3;
	Tue, 14 Sep 2021 18:31:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A7764B11E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUg6UNRtqnrz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Sep 2021 18:31:38 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5B26D4B127
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:38 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 s204-20020a252cd5000000b005a16e62ee63so907638ybs.12
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=++4XnYRgMyNMsEZoy1OpwZj4635Oms83QujRa32HDH4=;
 b=BIj10EokpMKVIQvprsrN7AGSS04qrri+1fJcyz+LKoNcHUz6j8rumrXcsiDSnFs74L
 9FDCrCun3Ns1u9bqKeeY6R1UBzZHKV3TC7bWqekk9UDFkvxAnqgIAZkKWETHfVfnNJIO
 V3hPt9oyY+k9HY3GAvt4y5fuYMjBhEHoTb7lT1apdLkLojeyq56RwWjSplDAAgxXXSXz
 k72BBzzUlAYpu8xxAEVAtyh699qXYz7ZFlfDQ1dLvloxD2CtrwRjAZHg+snteBBYW3sA
 LrqQ4rXsno5KpGxAbJWg5DroQw0n1PtxFlJ5gy/AFbhGWS37uQgYCsDnV0idazo6jKiS
 dHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=++4XnYRgMyNMsEZoy1OpwZj4635Oms83QujRa32HDH4=;
 b=Qedrm/hhv+/xEbfSDWZLfxE4x8EDF/WbdZMB+m+Ph3HkHhPTM28qFE3nwZFpi37svu
 rcqcJMdl2jEn0LLw8eaYBC3B6IsCkmFaPmMkn3IzDusuKnoWCoxKEXFGVs9vgy4MQjmy
 2wdaiqDxs7b8MUVoQ0N7+2cOYniUCUC0V+tpuBQwOL1Hgzj2UoheoTbpCmhq1ruA7Av3
 wpBiyX/FXqntrLuHPH7tsSN1EUnDwLT9iTOC5ojBqlPc7g2nCzIkI0jcyIBGcexq0naP
 NP5el0Quct+XuGSkNakT990DTOuVUsp71lgXxbmOWfUjYpndSzKL6e9joLOa4BbIckeS
 qaHg==
X-Gm-Message-State: AOAM530Qg5rl6EhRBaoi7HdSQujHQuToktd1M1U0osEgQvKhyaR3awEL
 YjbDRYviF2erBdKIH+jsE3Ck6TgUcLvI
X-Google-Smtp-Source: ABdhPJwg1l1wqrNj3CGGHgoFxWtUJBru+go0+LCOPCPO8I6WcM88fBLT6JZsKkfu7HZGdHrfNtOrseuPhlcy
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:c9c5:: with SMTP id
 z188mr2033066ybf.223.1631658697938; Tue, 14 Sep 2021 15:31:37 -0700 (PDT)
Date: Tue, 14 Sep 2021 22:31:06 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-8-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 07/15] KVM: arm64: selftests: Add basic support to generate
 delays
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Add udelay() support to generate a delay in the guest.

The routines are derived and simplified from kernel's
arch/arm64/lib/delay.c.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Oliver Upton <oupton@google.com>
---
 .../selftests/kvm/include/aarch64/delay.h     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/delay.h

diff --git a/tools/testing/selftests/kvm/include/aarch64/delay.h b/tools/testing/selftests/kvm/include/aarch64/delay.h
new file mode 100644
index 000000000000..329e4f5079ea
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/delay.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM simple delay routines
+ */
+
+#ifndef SELFTEST_KVM_ARM_DELAY_H
+#define SELFTEST_KVM_ARM_DELAY_H
+
+#include "arch_timer.h"
+
+static inline void __delay(uint64_t cycles)
+{
+	enum arch_timer timer = VIRTUAL;
+	uint64_t start = timer_get_cntct(timer);
+
+	while ((timer_get_cntct(timer) - start) < cycles)
+		cpu_relax();
+}
+
+static inline void udelay(unsigned long usec)
+{
+	__delay(usec_to_cycles(usec));
+}
+
+#endif /* SELFTEST_KVM_ARM_DELAY_H */
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
