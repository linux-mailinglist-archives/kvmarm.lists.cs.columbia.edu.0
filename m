Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04D392E4E
	for <lists+kvmarm@lfdr.de>; Thu, 27 May 2021 14:51:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB1714A98B;
	Thu, 27 May 2021 08:51:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6eNFt3a8H4Z; Thu, 27 May 2021 08:51:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C78D04B090;
	Thu, 27 May 2021 08:51:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C19484AEDC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 May 2021 08:51:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erkK261ANi1l for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 May 2021 08:51:42 -0400 (EDT)
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 136FA4A126
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 May 2021 08:51:42 -0400 (EDT)
Received: by mail-ed1-f73.google.com with SMTP id
 b8-20020a05640202c8b029038f1782a77eso250745edx.15
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 May 2021 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=VHJDxJbB4/0UaCkiYnMDocZA1owly4T7PndnhH3Iyu4=;
 b=UDif3Yk+PyirPGKgjwApMLsdwDDazlqNcaTddUUJiaL8CggB5IbFz5NLz+d9ZujoSo
 u8Xf/rgSYRCQD/oc+W4sOqrYqYmC7x+K1DQXP5vUh+EOiMm4BxzGCJSf8fx6PwAhXcbd
 gkhGM3OrqR+90yiYgmUu67RympC5WD928YRa28W+0oQBp+e6/VqCIhcc66fRffxi6sQI
 /XS5VRbW4WYDR9dWTO9BYGzExAT4Vp5kecespCA9X0qN9QfbAMuPf0L98P+j58hrFH6X
 0Ls9N20YBcgJclgF+UnbQYPzKM6w7Xo3sh1Hc0vmcrCcAhVhNUuAGLR2l5w+KWYa7hWi
 e7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=VHJDxJbB4/0UaCkiYnMDocZA1owly4T7PndnhH3Iyu4=;
 b=DZq/4XQJ+bcGZ4NiBst1fhUvXPXLxuTzHpuC0cgGW06i1MNeUfJhEXkdClcfqwdjXO
 +s5QRkyjU+Tfkbl2JhEVzgxaSUAcEgE/3s8vgnbRaKBVB4S0WAABogR8987+1rn6lJx1
 Cryr5ELsTZz8XBPNM8oZZ2W1BPc/PG5g8liJn23yUJoWoIMZ5O2vJ2HpZtF+mq8FTJhk
 QjCoQ+B12vj+2D3JJ/s1CDoF83SFG6STV6bcxiyeXppcfFotBAXb9g60iec7fJTwzXb0
 iiCkvQ60rfNSCNz782rioJMyrR/blD9ntBDWBJdWq479/HqkdpqWQCDsKFpXhQkaDs8e
 n44A==
X-Gm-Message-State: AOAM531D8aji84Hz7Qcv5xpSYEyNHAkNQrgFlEn+UQ0d5VOkcNIR3dzO
 2rdAGnUE+IwjnMi0vvUMCVc++lHvAvI2
X-Google-Smtp-Source: ABdhPJzJ2BtVqbgXgWjGsYBVJOsLAqvofOY6EixOvHYix2dY7OIUQXm2cfj8F2j3qMKF+qpDs8y5eIV8ZZje
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6402:50cd:: with SMTP id
 h13mr3939968edb.111.1622119901220; Thu, 27 May 2021 05:51:41 -0700 (PDT)
Date: Thu, 27 May 2021 12:51:29 +0000
In-Reply-To: <20210527125134.2116404-1-qperret@google.com>
Message-Id: <20210527125134.2116404-3-qperret@google.com>
Mime-Version: 1.0
References: <20210527125134.2116404-1-qperret@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 2/7] KVM: arm64: Use refcount at hyp to check page availability
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, will@kernel.org, james.morse@arm.com, 
 alexandru.elisei@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

The hyp buddy allocator currently checks the struct hyp_page list node
to see if a page is available for allocation or not when trying to
coalesce memory. Now that decrementing the refcount and attaching to
the buddy tree is done in the same critical section, we can rely on the
refcount of the buddy page to be in sync, which allows to replace the
list node check by a refcount check. This will ease removing the list
node from struct hyp_page later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 04573bf35441..7ee882f36767 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -55,7 +55,7 @@ static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
 {
 	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
 
-	if (!buddy || buddy->order != order || list_empty(&buddy->node))
+	if (!buddy || buddy->order != order || buddy->refcount)
 		return NULL;
 
 	return buddy;
@@ -116,14 +116,19 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 	return p;
 }
 
+static void __hyp_put_page(struct hyp_pool *pool, struct hyp_page *p)
+{
+	if (hyp_page_ref_dec_and_test(p))
+		__hyp_attach_page(pool, p);
+}
+
 void hyp_put_page(void *addr)
 {
 	struct hyp_page *p = hyp_virt_to_page(addr);
 	struct hyp_pool *pool = hyp_page_to_pool(p);
 
 	hyp_spin_lock(&pool->lock);
-	if (hyp_page_ref_dec_and_test(p))
-		__hyp_attach_page(pool, p);
+	__hyp_put_page(pool, p);
 	hyp_spin_unlock(&pool->lock);
 }
 
@@ -178,15 +183,16 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 
 	/* Init the vmemmap portion */
 	p = hyp_phys_to_page(phys);
-	memset(p, 0, sizeof(*p) * nr_pages);
 	for (i = 0; i < nr_pages; i++) {
 		p[i].pool = pool;
+		p[i].order = 0;
 		INIT_LIST_HEAD(&p[i].node);
+		hyp_set_page_refcounted(&p[i]);
 	}
 
 	/* Attach the unused pages to the buddy tree */
 	for (i = reserved_pages; i < nr_pages; i++)
-		__hyp_attach_page(pool, &p[i]);
+		__hyp_put_page(pool, &p[i]);
 
 	return 0;
 }
-- 
2.31.1.818.g46aad6cb9e-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
