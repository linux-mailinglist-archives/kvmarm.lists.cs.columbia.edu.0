Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 04D20561C10
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jun 2022 15:58:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5E904B4F8;
	Thu, 30 Jun 2022 09:58:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUPw2u9WgZIE; Thu, 30 Jun 2022 09:58:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E39E4B4D1;
	Thu, 30 Jun 2022 09:58:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1415B4B498
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:58:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pCEE-eODIY8 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jun 2022 09:58:09 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CF2B04B4AC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:58:09 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 65BAA61FDB;
 Thu, 30 Jun 2022 13:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83526C341CC;
 Thu, 30 Jun 2022 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656597488;
 bh=yadXOfubMUxLUzRkyxEAup5usFqPCH4T2xXyNSgVPtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g5X7ki+Y2Iy3DsMlQSU47oCGLslPC8BXKPiNdBsuha0zfhvZriVDYnqaMkXUD4fqm
 2MKbrKYs574+R4I9Ce/DhzDa1lWOaILCtu0sqh+8xd7i9Aq8T1o+2mL6Yfdnwz+syW
 EWOY/rXh7Q9Lc+fOlK80RUsCaiUAUmJ36Ecjuj+nGAOZN4f4M7vF0FLCjqAYMsdXCB
 iR4L8UHqytGxe4gggGLQmJeFpGP6aTBn8vKDKMnyYqJBB4di1rNGb6AR73XuonBpHs
 CxIMpn2I8Cw5ZaVStk5gphHEuZJilIS/piD9o1Cu0x1FoPq9rEEx6LkxktNYDjEams
 eKj0a69NV7uPQ==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 03/24] KVM: arm64: Add flags to struct hyp_page
Date: Thu, 30 Jun 2022 14:57:26 +0100
Message-Id: <20220630135747.26983-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220630135747.26983-1-will@kernel.org>
References: <20220630135747.26983-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>
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

From: Quentin Perret <qperret@google.com>

Add a 'flags' field to struct hyp_page, and reduce the size of the order
field to u8 to avoid growing the struct size.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  6 +++---
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  3 ++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 14 +++++++-------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index 0a048dc06a7d..9330b13075f8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -7,7 +7,7 @@
 #include <nvhe/memory.h>
 #include <nvhe/spinlock.h>
 
-#define HYP_NO_ORDER	USHRT_MAX
+#define HYP_NO_ORDER	0xff
 
 struct hyp_pool {
 	/*
@@ -19,11 +19,11 @@ struct hyp_pool {
 	struct list_head free_area[MAX_ORDER];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
-	unsigned short max_order;
+	u8 max_order;
 };
 
 /* Allocation */
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
+void *hyp_alloc_pages(struct hyp_pool *pool, u8 order);
 void hyp_split_page(struct hyp_page *page);
 void hyp_get_page(struct hyp_pool *pool, void *addr);
 void hyp_put_page(struct hyp_pool *pool, void *addr);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 418b66a82a50..2681f632e1c1 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -9,7 +9,8 @@
 
 struct hyp_page {
 	unsigned short refcount;
-	unsigned short order;
+	u8 order;
+	u8 flags;
 };
 
 extern u64 __hyp_vmemmap;
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 0d15227aced8..e6e4b550752b 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -32,7 +32,7 @@ u64 __hyp_vmemmap;
  */
 static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 					     struct hyp_page *p,
-					     unsigned short order)
+					     u8 order)
 {
 	phys_addr_t addr = hyp_page_to_phys(p);
 
@@ -51,7 +51,7 @@ static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
 /* Find a buddy page currently available for allocation */
 static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned short order)
+					   u8 order)
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
@@ -94,8 +94,8 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 			      struct hyp_page *p)
 {
 	phys_addr_t phys = hyp_page_to_phys(p);
-	unsigned short order = p->order;
 	struct hyp_page *buddy;
+	u8 order = p->order;
 
 	memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
 
@@ -128,7 +128,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
 
 static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 					   struct hyp_page *p,
-					   unsigned short order)
+					   u8 order)
 {
 	struct hyp_page *buddy;
 
@@ -182,7 +182,7 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
 
 void hyp_split_page(struct hyp_page *p)
 {
-	unsigned short order = p->order;
+	u8 order = p->order;
 	unsigned int i;
 
 	p->order = 0;
@@ -194,10 +194,10 @@ void hyp_split_page(struct hyp_page *p)
 	}
 }
 
-void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
+void *hyp_alloc_pages(struct hyp_pool *pool, u8 order)
 {
-	unsigned short i = order;
 	struct hyp_page *p;
+	u8 i = order;
 
 	hyp_spin_lock(&pool->lock);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
