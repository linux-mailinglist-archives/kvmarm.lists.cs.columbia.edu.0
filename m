Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7821842219C
	for <lists+kvmarm@lfdr.de>; Tue,  5 Oct 2021 11:03:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11AB74B2B4;
	Tue,  5 Oct 2021 05:03:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dyc19H9GSC7k; Tue,  5 Oct 2021 05:03:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3C4B4B2BD;
	Tue,  5 Oct 2021 05:03:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 333D64B2AC
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 05:03:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jVSDKxmrNr5x for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Oct 2021 05:03:06 -0400 (EDT)
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1D9524B267
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Oct 2021 05:03:06 -0400 (EDT)
Received: by mail-wr1-f74.google.com with SMTP id
 c2-20020adfa302000000b0015e4260febdso5475161wrb.20
 for <kvmarm@lists.cs.columbia.edu>; Tue, 05 Oct 2021 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Zg+gUiu3ox2wHV7TW+7r/xAJBwKqffZp8cWRWiJTXrY=;
 b=ethTiy3lTzcSneIbLwawi+5olik16z23jgqCFT9E6S+igJ69OtJ1TPMCM3LUeMuDWh
 kwcRJn93q32+YoPQuqYwcmM2DdY9Fe9IYJKgK+GXLbcXpWzMDJRW3LbNqRmKiJUsc6DC
 CebD0o+l0nqeRevVQD1bAdXZQHBHCWfG8Rcoy58tJcFsFAxUPA0SJI81RMitxFI9xF+C
 YxiAvhisoF3VIur01ICFsq3MrvN2eqrXvL8fZNMl/vG0AqdzcjPWDTaTqFZDJuk+h9ab
 QCMcSvBsSTabymd8vvOKuV6YemDU3oBdSpPn6xfZo8O6vSq3YJh46dvt7fuELrY2dzVh
 x/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Zg+gUiu3ox2wHV7TW+7r/xAJBwKqffZp8cWRWiJTXrY=;
 b=TDto+myDry4TlQv1auvnVjwlCUFwZZ5W+yHIPzK3x6CqajUWnicWJylIEUCQZMSQs+
 4Xrk7VZWNm2lyHEL8AheTPopNBif+ZJmnvTdbesN30O3aigfcq4lTdoTCHJx3P4jleXt
 iEBzTX/rUsA48cQm3PuC0uylsNCQdTc0qDp7UEQfirIa7ch968Uk8eh2B6TiKr1iLshf
 +p+uFDyg4BZnBNAk3C8talwncNZMt43z+BoEmRqpOfEoj+jNOPrBstnB5wp3bDhMQMro
 zZec6c3+LkuEPNTV+qYFWkajDlhXCELrVfdZuSJH24+8y+eEhIYpxeas5bhUWy7Xi5MX
 H0eQ==
X-Gm-Message-State: AOAM532Py9Exeug2N80tph7uio7l/GCUFGuXETtpCDsaS9J9lgTMpfDH
 sy00hlcwRpsu3PEd8ilX6PWyomTSvhAk
X-Google-Smtp-Source: ABdhPJxUSKr1FTBsupYcr01qanV2kSzxpxGMspE323G2ZVQjyutuN9ik2CBJcXODTdTUv+X78VCL5yV8AtM/
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:adf:a45e:: with SMTP id
 e30mr18268872wra.269.1633424585068; Tue, 05 Oct 2021 02:03:05 -0700 (PDT)
Date: Tue,  5 Oct 2021 10:01:41 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-5-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 1/2] KVM: arm64: Fix host stage-2 PGD refcount
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Quentin Perret <qperret@google.com>, Fuad Tabba <tabba@google.com>, 
 David Brazdil <dbrazdil@google.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
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

The KVM page-table library refcounts the pages of concatenated stage-2
PGDs individually. However, when running KVM in protected mode, the
host's stage-2 PGD is currently managed by EL2 as a single high-order
compound page, which can cause the refcount of the tail pages to reach 0
when they shouldn't, hence corrupting the page-table.

Fix this by introducing a new hyp_split_page() helper in the EL2 page
allocator (matching the kernel's split_page() function), and make use of
it from host_s2_zalloc_pages_exact().

Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
Acked-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 13 ++++++++++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index fb0f523d1492..0a048dc06a7d 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -24,6 +24,7 @@ struct hyp_pool {
 
 /* Allocation */
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
+void hyp_split_page(struct hyp_page *page);
 void hyp_get_page(struct hyp_pool *pool, void *addr);
 void hyp_put_page(struct hyp_pool *pool, void *addr);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bacd493a4eac..34eeb524b686 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -35,7 +35,18 @@ const u8 pkvm_hyp_id = 1;
 
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
-	return hyp_alloc_pages(&host_s2_pool, get_order(size));
+	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
+
+	hyp_split_page(hyp_virt_to_page(addr));
+
+	/*
+	 * The size of concatenated PGDs is always a power of two of PAGE_SIZE,
+	 * so there should be no need to free any of the tail pages to make the
+	 * allocation exact.
+	 */
+	WARN_ON(size != (PAGE_SIZE << get_order(size)));
+
+	return addr;
 }
 
 static void *host_s2_zalloc_page(void *pool)
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index 41fc25bdfb34..a6e874e61a40 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -193,6 +193,20 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
 	hyp_spin_unlock(&pool->lock);
 }
 
+void hyp_split_page(struct hyp_page *p)
+{
+	unsigned short order = p->order;
+	unsigned int i;
+
+	p->order = 0;
+	for (i = 1; i < (1 << order); i++) {
+		struct hyp_page *tail = p + i;
+
+		tail->order = 0;
+		hyp_set_page_refcounted(tail);
+	}
+}
+
 void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
 {
 	unsigned short i = order;
-- 
2.33.0.800.g4c38ced690-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
