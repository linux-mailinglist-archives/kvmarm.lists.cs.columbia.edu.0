Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08C248601
	for <lists+kvmarm@lfdr.de>; Tue, 18 Aug 2020 15:28:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CBAD4BBD8;
	Tue, 18 Aug 2020 09:28:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZD+TsjGhe8V; Tue, 18 Aug 2020 09:28:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 255D84BD62;
	Tue, 18 Aug 2020 09:28:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D11BB4BBD7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwyIQEr0hHo8 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 09:28:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D643F4BB98
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 09:28:55 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D691206B5;
 Tue, 18 Aug 2020 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597757335;
 bh=Ge63UNixM6YMc60ymyLYbY4xYbK1T8PxnURJ2esDv90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qqsHFPIWq4oNmF2zQvfJ8eAg34soxdEvA+K86SR8VDnnxkJlj+2WmGjIhBSSd9huQ
 DavF29lD4uLgRLwWrQuKPQnJxSGY7Gsn6bHTwO1xdwjzXVf7DS8Y2AR7bnczsVOPEo
 fEWWGMjCjYgK5stDXdz9rBkrlAOBoRhYUMJaQoYE=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 13/22] KVM: arm64: Add support for stage-2 write-protect in
 generic page-table
Date: Tue, 18 Aug 2020 14:28:09 +0100
Message-Id: <20200818132818.16065-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818132818.16065-1-will@kernel.org>
References: <20200818132818.16065-1-will@kernel.org>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

From: Quentin Perret <qperret@google.com>

Add a stage-2 wrprotect() operation to the generic page-table code.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h | 15 +++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index ae56534f87a0..0c96b78d791d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -173,6 +173,21 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
 
+/**
+ * kvm_pgtable_stage2_wrprotect() - Write-protect guest stage-2 address range
+ *                                  without TLB invalidation.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address from which to write-protect,
+ * @size:	Size of the range.
+ *
+ * Note that it is the caller's responsibility to invalidate the TLB after
+ * calling this function to ensure that the updated permissions are visible
+ * to the CPUs.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size);
+
 /**
  * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
  * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 30713eb773e0..c218651f8eba 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -726,6 +726,12 @@ static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
 	return 0;
 }
 
+int kvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	return stage2_update_leaf_attrs(pgt, addr, size, 0,
+					KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W, NULL);
+}
+
 kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
 {
 	kvm_pte_t pte = 0;
-- 
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
