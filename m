Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7DF3DA41A
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 15:28:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B516A4B0BF;
	Thu, 29 Jul 2021 09:28:30 -0400 (EDT)
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
	with ESMTP id 6OkGwQHJqPYS; Thu, 29 Jul 2021 09:28:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB71A4B0D4;
	Thu, 29 Jul 2021 09:28:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 689C14B0A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 09:28:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLkEYLgt4LdS for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 09:28:25 -0400 (EDT)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EB5114B0B5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 09:28:24 -0400 (EDT)
Received: by mail-qt1-f202.google.com with SMTP id
 l12-20020a05622a050cb029025ca4fbcc12so2729993qtx.18
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=crBqYydgsM0lLmpXbxrQzqnfwJboPEMWJ5uFG+CB388=;
 b=JOIVCVkTKSE7PwC39f/uN10vnOvi7Vzp2RTafhg3kyIB15DlDdxcNRRjKoM75ogyTS
 sjmXizIUunrQ4Q2yIkfgmJDrNF8nuB33MW7tB7YPCbcNhgcnStKG61TKLA9OHyXOwzKH
 i7uDNzA+PPHFpfTHJs2M5QoYOwbb6NUXBh++UvXlYe3cdezMzPl1EZ3sOx0jBVOxIit7
 DsJ4Rk2OJv96rif4hnZqeL50UBKsRJGWc8A2EaMc0YZVDJkZTXTjcJfL1x72E+Z4uyBi
 PGyvbycBPgY92pQ84g5f29LjEY96+E8Pod3jV3Xa3E41vkI8XuIPX9jDrr0GlJ2pzzRS
 RQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=crBqYydgsM0lLmpXbxrQzqnfwJboPEMWJ5uFG+CB388=;
 b=TP7mEC7RuYqRnAD/6gESZ+8yxaFvoGuWnB1LG4oqc7zE/KCxoIZ/Kpoh/B9Qj0hg4e
 Z9GhyWTyq361jl7gjbJPvM+DQo/s/ZPJZK4wV2VM/o6vxkYSWWqZyPTjtVkC6VyZdS5V
 rDQx+zhi0JGt0fR4G93OWGKSDsRbI0epaDcnNcw1OsNodLPaf3sBQsWv++YdhEY8lMhZ
 RjIZXtCNr0Gwr1uAj1NQduQpcbcRbRscO3z3uF3DBMnCUIg9eTSM5lWd63k4+kAcpiAw
 NR9rmWjQLvEga6LTcl8aEsSDsnrNAVoDRqkhGv4gFuKRej9zJZ3uwPLFJrbhwlopY26M
 NRrg==
X-Gm-Message-State: AOAM5337dI4olgxnwG0ZUXXCmY1eZ6RRsuwhrizVdqHju7I3v7L35/fG
 6OzZbJFaxbCnCxtC4vA5nvL2Tm6OMm+o
X-Google-Smtp-Source: ABdhPJxHRTBRw3rhOotBjYPWwjVk04U8m2F1PsiYgMcXVSq1/9Rd7rzCjHaUtz4DsAzceZrGz5P9KOU1HQzs
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr5318862qvr.4.1627565304476; Thu, 29 Jul 2021 06:28:24 -0700 (PDT)
Date: Thu, 29 Jul 2021 14:27:58 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-2-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 01/21] KVM: arm64: Add hyp_spin_is_locked() for basic
 locking assertions at EL2
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, 
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

Introduce hyp_spin_is_locked() so that functions can easily assert that
a given lock is held (albeit possibly by another CPU!) without having to
drag full lockdep support up to EL2.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
index 76b537f8d1c6..04f65b655fcf 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -15,6 +15,7 @@
 
 #include <asm/alternative.h>
 #include <asm/lse.h>
+#include <asm/rwonce.h>
 
 typedef union hyp_spinlock {
 	u32	__val;
@@ -89,4 +90,11 @@ static inline void hyp_spin_unlock(hyp_spinlock_t *lock)
 	: "memory");
 }
 
+static inline bool hyp_spin_is_locked(hyp_spinlock_t *lock)
+{
+	hyp_spinlock_t lockval = READ_ONCE(*lock);
+
+	return lockval.owner != lockval.next;
+}
+
 #endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
