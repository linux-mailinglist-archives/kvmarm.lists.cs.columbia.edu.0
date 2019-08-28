Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF26A036C
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:39:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 238174A59C;
	Wed, 28 Aug 2019 09:39:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jdXv+2ucrzFB; Wed, 28 Aug 2019 09:39:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F98E4A5CE;
	Wed, 28 Aug 2019 09:39:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C7EB4A557
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id werKu+F7A++T for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:39:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 31E5E4A599
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:39:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB8815AB;
 Wed, 28 Aug 2019 06:39:00 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B75353F246;
 Wed, 28 Aug 2019 06:38:59 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 08/16] lib: arm/arm64: Refuse to disable
 the MMU with non-identity stack pointer
Date: Wed, 28 Aug 2019 14:38:23 +0100
Message-Id: <1566999511-24916-9-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

When the MMU is off, all addresses are physical addresses. If the stack
pointer is not an identity mapped address (the virtual address is not the
same as the physical address), then we end up trying to access an invalid
memory region. This can happen if we call mmu_disable from a secondary CPU,
which has its stack allocated from the vmalloc region.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/arm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/arm/mmu.c b/lib/arm/mmu.c
index 3d38c8397f5a..161f7a8e607c 100644
--- a/lib/arm/mmu.c
+++ b/lib/arm/mmu.c
@@ -66,8 +66,12 @@ void mmu_enable(pgd_t *pgtable)
 extern void asm_mmu_disable(void);
 void mmu_disable(void)
 {
+	unsigned long sp = current_stack_pointer;
 	int cpu = current_thread_info()->cpu;
 
+	assert_msg(__virt_to_phys(sp) == sp,
+			"Attempting to disable MMU with non-identity mapped stack");
+
 	mmu_mark_disabled(cpu);
 
 	asm_mmu_disable();
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
