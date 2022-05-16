Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB97528943
	for <lists+kvmarm@lfdr.de>; Mon, 16 May 2022 17:55:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 359274B298;
	Mon, 16 May 2022 11:55:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hrq9H6zEaGy; Mon, 16 May 2022 11:55:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB02A4B2B2;
	Mon, 16 May 2022 11:55:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B4DF4B29A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 May 2022 11:55:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44Hy7eqXQSVM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 May 2022 11:55:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6167F49DED
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 May 2022 11:55:33 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19DCE11FB;
 Mon, 16 May 2022 08:55:33 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A93F13F73D;
 Mon, 16 May 2022 08:55:31 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org,
 suzuki.poulose@arm.com, julien@xen.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com
Subject: [PATCH v2 kvmtool 06/12] arm/arm64: Kill the ARM_MAX_MEMORY() macro
Date: Mon, 16 May 2022 16:55:20 +0100
Message-Id: <20220516155526.181694-7-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516155526.181694-1-alexandru.elisei@arm.com>
References: <20220516155526.181694-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

For 32-bit guests, the maximum memory size is represented by the define
ARM_LOMAP_MAX_MEMORY, which ARM_MAX_MEMORY() returns.

For 64-bit guests, the RAM size is checked against the maximum allowed
by KVM in kvm__get_vm_type().

There are no users left for the ARM_MAX_MEMORY() macro, remove it.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/aarch32/include/kvm/kvm-arch.h |  2 --
 arm/aarch64/include/kvm/kvm-arch.h | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index 5616b27e257e..467fb09175b8 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -8,8 +8,6 @@
 struct kvm;
 static inline void kvm__arch_enable_mte(struct kvm *kvm) {}
 
-#define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY
-
 #define MAX_PAGE_SIZE	SZ_4K
 
 #include "arm-common/kvm-arch.h"
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 9124f6919d0f..ff857ca6e7b4 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -8,22 +8,6 @@ unsigned long long kvm__arch_get_kern_offset(struct kvm *kvm, int fd);
 int kvm__arch_get_ipa_limit(struct kvm *kvm);
 void kvm__arch_enable_mte(struct kvm *kvm);
 
-#define ARM_MAX_MEMORY(kvm)	({					\
-	u64 max_ram;							\
-									\
-	if ((kvm)->cfg.arch.aarch32_guest) {				\
-		max_ram = ARM_LOMAP_MAX_MEMORY;				\
-	} else {							\
-		int ipabits = kvm__arch_get_ipa_limit(kvm);		\
-		if (ipabits <= 0)					\
-			max_ram = ARM_HIMAP_MAX_MEMORY;			\
-		else							\
-			max_ram = (1ULL << ipabits) - ARM_MEMORY_AREA;	\
-	}								\
-									\
-	max_ram;							\
-})
-
 #define MAX_PAGE_SIZE	SZ_64K
 
 #include "arm-common/kvm-arch.h"
-- 
2.36.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
