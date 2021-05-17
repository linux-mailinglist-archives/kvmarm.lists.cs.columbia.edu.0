Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC1382C2E
	for <lists+kvmarm@lfdr.de>; Mon, 17 May 2021 14:33:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78BB24B808;
	Mon, 17 May 2021 08:33:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HmfXLibw0oUh; Mon, 17 May 2021 08:33:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07E9C4B836;
	Mon, 17 May 2021 08:33:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 84AE04B4D6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 May 2021 08:33:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mP1-6KiISHlC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 May 2021 08:33:16 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 369954B4CB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 May 2021 08:33:16 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29C5139F;
 Mon, 17 May 2021 05:33:15 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B943F73B;
 Mon, 17 May 2021 05:33:12 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v12 2/8] arm64: Handle MTE tags zeroing in
 __alloc_zeroed_user_highpage()
Date: Mon, 17 May 2021 13:32:33 +0100
Message-Id: <20210517123239.8025-3-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517123239.8025-1-steven.price@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
MIME-Version: 1.0
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Dave Martin <Dave.Martin@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

From: Catalin Marinas <catalin.marinas@arm.com>

Currently, on an anonymous page fault, the kernel allocates a zeroed
page and maps it in user space. If the mapping is tagged (PROT_MTE),
set_pte_at() additionally clears the tags under a spinlock to avoid a
race on the page->flags. In order to optimise the lock, clear the page
tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
have VM_MTE set.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/page.h |  6 ++++--
 arch/arm64/mm/fault.c         | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..97853570d0f1 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/personality.h> /* for READ_IMPLIES_EXEC */
+#include <linux/types.h>
 #include <asm/pgtable-types.h>
 
 struct page;
@@ -28,8 +29,9 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
-#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
-	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
+struct page *__alloc_zeroed_user_highpage(gfp_t movableflags,
+					  struct vm_area_struct *vma,
+					  unsigned long vaddr);
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 871c82ab0a30..5a03428e97f3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -921,3 +921,24 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 	debug_exception_exit(regs);
 }
 NOKPROBE_SYMBOL(do_debug_exception);
+
+/*
+ * Used during anonymous page fault handling.
+ */
+struct page *__alloc_zeroed_user_highpage(gfp_t movableflags,
+					  struct vm_area_struct *vma,
+					  unsigned long vaddr)
+{
+	struct page *page;
+	bool tagged = system_supports_mte() && (vma->vm_flags & VM_MTE);
+
+	page = alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma,
+			      vaddr);
+	if (tagged && page) {
+		mte_clear_page_tags(page_address(page));
+		page_kasan_tag_reset(page);
+		set_bit(PG_mte_tagged, &page->flags);
+	}
+
+	return page;
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
