Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EB64B1A9898
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 11:23:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D7124B1F3;
	Wed, 15 Apr 2020 05:23:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMsvxai4kCJx; Wed, 15 Apr 2020 05:23:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 967D94B22D;
	Wed, 15 Apr 2020 05:23:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A6104B1D9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 04:43:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x3eRyN2iWZgy for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 04:43:44 -0400 (EDT)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2CC434B1D8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 04:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1586940225; x=1618476225;
 h=from:to:cc:subject:date:message-id;
 bh=EMYtFdH844Gy8q0zDObO0i3soKGeCT1N6ZnKHQH7qjI=;
 b=Maq4iTIYb0FmOKjDfKztvMbToKSVLsmNYVIgLHXlsQ+zjv9iXA2hMHRU
 lviHfUr1bXe2r6uKskP9lwBiBKn5MglqfEupM9ITcNc4J1Lprct4/qQwo
 ZYMhpAIS6KkCjRL6vv9kTF/nF8UfjFAtdfXoCgNvtPyc/th8ox1j0OaFf 4=;
IronPort-SDR: sh/mYkNm0w7U8qD8vmxXEf50rvhX5vgl8boba5UFNT+Gie7eTRc2Nu1whcyXfttLtiJVNkb6Bf
 2HJbI0RIxMHQ==
X-IronPort-AV: E=Sophos;i="5.72,386,1580774400"; d="scan'208";a="37157160"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 15 Apr 2020 08:43:42 +0000
Received: from u8ac3f2494b6e5c.ant.amazon.com
 (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
 by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS
 id F023DA218E; Wed, 15 Apr 2020 08:43:37 +0000 (UTC)
Received: from u8ac3f2494b6e5c.ant.amazon.com (localhost [127.0.0.1])
 by u8ac3f2494b6e5c.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTPS id
 03F8hZjA007973
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2020 10:43:35 +0200
Received: (from giangyi@localhost)
 by u8ac3f2494b6e5c.ant.amazon.com (8.15.2/8.15.2/Submit) id 03F8hYvM007966;
 Wed, 15 Apr 2020 10:43:34 +0200
From: Jiang Yi <giangyi@amazon.com>
To: Marc Zyngier <maz@kernel.org>
Subject: [PATCH] KVM: arm/arm64: release kvm->mmu_lock in loop to prevent
 starvation
Date: Wed, 15 Apr 2020 10:42:29 +0200
Message-Id: <20200415084229.29992-1-giangyi@amazon.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 15 Apr 2020 05:23:47 -0400
Cc: Jiang Yi <giangyi@amazon.com>, linux-kernel@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Do cond_resched_lock() in stage2_flush_memslot() like what is done in
unmap_stage2_range() and other places holding mmu_lock while processing
a possibly large range of memory.

Signed-off-by: Jiang Yi <giangyi@amazon.com>
---
 virt/kvm/arm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e3b9ee268823..7315af2c52f8 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -417,16 +417,19 @@ static void stage2_flush_memslot(struct kvm *kvm,
 	phys_addr_t next;
 	pgd_t *pgd;
 
 	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
 	do {
 		next = stage2_pgd_addr_end(kvm, addr, end);
 		if (!stage2_pgd_none(kvm, *pgd))
 			stage2_flush_puds(kvm, pgd, addr, next);
+
+		if (next != end)
+			cond_resched_lock(&kvm->mmu_lock);
 	} while (pgd++, addr = next, addr != end);
 }
 
 /**
  * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
  * @kvm: The struct kvm pointer
  *
  * Go through the stage 2 page tables and invalidate any cache lines
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
