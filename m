Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E0297F9B
	for <lists+kvmarm@lfdr.de>; Sun, 25 Oct 2020 02:28:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5DC44BABA;
	Sat, 24 Oct 2020 20:28:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2voKkN+jzrA5; Sat, 24 Oct 2020 20:28:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B07E34B900;
	Sat, 24 Oct 2020 20:28:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 713474B8F7
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Oct 2020 20:27:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtJLucDaVpPg for <kvmarm@lists.cs.columbia.edu>;
 Sat, 24 Oct 2020 20:27:57 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 980ED4BA7C
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Oct 2020 20:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603585676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ln4YEn/m8ZM509jglIDZmO8wMdhAwk6lG2Wjj3NhsR4=;
 b=cme2PraQpMA1REvvAyJTnlWQGxTYSh2XzRox7MUqfRyo/Lg//tmJosqMFglzHac8N4ulkx
 1lm5SF7VTm6MEqYzKDA6UN2Tg8K7o6M3z/OYLsDc+VPawOvuV4ttbTs0EO7JowqcQX5c5k
 CT660UuggMkqd/1Bhws7n8ciWmm0fH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-BA2FjIjKM5CFGnFbksSt2g-1; Sat, 24 Oct 2020 20:27:53 -0400
X-MC-Unique: BA2FjIjKM5CFGnFbksSt2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84DD4804B7A;
 Sun, 25 Oct 2020 00:27:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFE2C5C1DA;
 Sun, 25 Oct 2020 00:27:50 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 3/3] KVM: arm64: Failback on unsupported huge page sizes
Date: Sun, 25 Oct 2020 11:27:39 +1100
Message-Id: <20201025002739.5804-4-gshan@redhat.com>
In-Reply-To: <20201025002739.5804-1-gshan@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: will@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
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

The huge page could be mapped through multiple contiguous PMDs or PTEs.
The corresponding huge page sizes aren't supported by the page table
walker currently.

This fails the unsupported huge page sizes to the near one. Otherwise,
the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
fail back to PMD_SHIFT and PAGE_SHIFT separately.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0f51585adc04..81cbdc368246 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -793,12 +793,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PMD_SHIFT;
 #endif
 
+	if (vma_shift == CONT_PMD_SHIFT)
+		vma_shift = PMD_SHIFT;
+
 	if (vma_shift == PMD_SHIFT &&
 	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	}
 
+	if (vma_shift == CONT_PTE_SHIFT) {
+		force_pte = true;
+		vma_shift = PAGE_SHIFT;
+	}
+
 	vma_pagesize = 1UL << vma_shift;
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
 		fault_ipa &= ~(vma_pagesize - 1);
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
