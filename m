Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4730D3C218B
	for <lists+kvmarm@lfdr.de>; Fri,  9 Jul 2021 11:25:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA7E94B0A3;
	Fri,  9 Jul 2021 05:25:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iSkSaSUToi76; Fri,  9 Jul 2021 05:25:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F0134A531;
	Fri,  9 Jul 2021 05:25:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8674349F5D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Jul 2021 00:37:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U21gyNnFGnB5 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  9 Jul 2021 00:37:42 -0400 (EDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3D29740870
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Jul 2021 00:37:42 -0400 (EDT)
Received: by mail-pj1-f47.google.com with SMTP id n11so5086596pjo.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 08 Jul 2021 21:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QP3/GYzOBKmilm7HuEJkuqubxHWg9l5vJdRHFzc5VNI=;
 b=RclDDj3+rehsUldw5TyhuwvHXTZwkgCQaCL0mXmrg3nr75emQHZsdQL/PMBpmd2FSB
 1okB0a10syEhmCx3GptxPQ6XYeTuHpa4AESmoVEqtDp3+bLgb4ii01UctXQhRSyNL3s2
 nQd9N40sCnQ4Tz9f+NrHySY4qVntzcKYSjVho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QP3/GYzOBKmilm7HuEJkuqubxHWg9l5vJdRHFzc5VNI=;
 b=WramGx1Yvmnn/1KXytvKURM9IlzSAJReqFRkcNX2U6Dw6T2hYVkW8W6ER164vPHYui
 6TV5G/s0kCwNFalZtdjn73MbDGm1k4l6UFOSKMKrCQ4oQcmFvmfGQY9ktKSMdCVb3fZY
 1oImeAc2nXnAjAIh39e+b+YIZsWylid2LEy48zc5mQVo5YSPxF+PXzN39PgH9BSq6gpb
 ICC3mKpgz2nxrGosfWMjVcT0CXr/1JE+WTpv1E5GMA4hvt+1HsVvfs6fuzJajMXzpyeV
 qu0X9Wyv8E5eBnYYdBIp0mnJ7pxEr5J7o1/clhj4oB29eqxZk2DvkC2fnn5rSUNfTKJy
 w57Q==
X-Gm-Message-State: AOAM531Ac1myGf2Fc9ppa4nBKLBWE1eQOIYfW2RQernDlqc6UtgWMbDv
 B2IpvsN5j1FVIuaECCqTWi6hiw==
X-Google-Smtp-Source: ABdhPJw7ofI5jbueMZXenvbdrtCTJqUoJIWkbzb4yngHCY3TUfGWSBMgYm2T5M9G4xte0hL+XeYjmw==
X-Received: by 2002:a17:902:bc47:b029:129:dd30:1c30 with SMTP id
 t7-20020a170902bc47b0290129dd301c30mr5497773plz.4.1625805461468; 
 Thu, 08 Jul 2021 21:37:41 -0700 (PDT)
Received: from senozhatsky.flets-east.jp
 ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
 by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jul 2021 21:37:41 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCHv2 3/4] arm64: do not use dummy vcpu_is_preempted()
Date: Fri,  9 Jul 2021 13:37:12 +0900
Message-Id: <20210709043713.887098-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709043713.887098-1-senozhatsky@chromium.org>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 09 Jul 2021 05:25:42 -0400
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Suleiman Souhlal <suleiman@google.com>, kvmarm@lists.cs.columbia.edu,
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

vcpu_is_preempted() now can represent the actual state of
the VCPU, so the scheduler can make better decisions when
it picks the idle CPU to enqueue a task on.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/arm64/include/asm/spinlock.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 0525c0b089ed..1d579497e1b8 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -7,21 +7,23 @@
 
 #include <asm/qspinlock.h>
 #include <asm/qrwlock.h>
+#include <asm/paravirt.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
-/*
- * Changing this will break osq_lock() thanks to the call inside
- * smp_cond_load_relaxed().
- *
- * See:
- * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
- */
 #define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(int cpu)
+
+#ifdef CONFIG_PARAVIRT
+static inline bool vcpu_is_preempted(unsigned int cpu)
+{
+	return paravirt_vcpu_is_preempted(cpu);
+}
+#else
+static inline bool vcpu_is_preempted(unsigned int cpu)
 {
 	return false;
 }
+#endif /* CONFIG_PARAVIRT */
 
 #endif /* __ASM_SPINLOCK_H */
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
