Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00B26602F
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 15:26:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D32334B390;
	Fri, 11 Sep 2020 09:26:07 -0400 (EDT)
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
	with ESMTP id cnNmHvzZ0ez7; Fri, 11 Sep 2020 09:26:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6264B3A9;
	Fri, 11 Sep 2020 09:26:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D8154B2D5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2leunt5fTZ6m for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 09:26:03 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6DFED4B3A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:02 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA0F222225;
 Fri, 11 Sep 2020 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599830761;
 bh=4ay5TrojnSOgCRLDVXg3OBrxLTg6M52CZnqCfmoNoEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zIbtel2p4oT1lU1bHPQDfVz3HPu3aldsSs5eExk4RXX6x2z7A2sRnYlIUJkwHFNB2
 4yPQBGQ24MckYowiQbQ+kfWc/oPlgqZRf0hR9irVZH9YB3KgjTQjgcBelOJipIqyNw
 umRamyxmHDXjL+NrCDrdKCfWmqAbwUCmAIC3iBvY=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 10/21] KVM: arm64: Add support for stage-2 page-aging in
 generic page-table
Date: Fri, 11 Sep 2020 14:25:18 +0100
Message-Id: <20200911132529.19844-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911132529.19844-1-will@kernel.org>
References: <20200911132529.19844-1-will@kernel.org>
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

Add stage-2 mkyoung(), mkold() and is_young() operations to the generic
page-table code.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h | 44 ++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 86 ++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 895b2238062b..50782128c861 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -186,6 +186,50 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
  */
 int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size);
 
+/**
+ * kvm_pgtable_stage2_mkyoung() - Set the access flag in a page-table entry.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address to identify the page-table entry.
+ *
+ * The offset of @addr within a page is ignored.
+ *
+ * If there is a valid, leaf page-table entry used to translate @addr, then
+ * set the access flag in that entry.
+ *
+ * Return: The old page-table entry prior to setting the flag, 0 on failure.
+ */
+kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
+
+/**
+ * kvm_pgtable_stage2_mkold() - Clear the access flag in a page-table entry.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address to identify the page-table entry.
+ *
+ * The offset of @addr within a page is ignored.
+ *
+ * If there is a valid, leaf page-table entry used to translate @addr, then
+ * clear the access flag in that entry.
+ *
+ * Note that it is the caller's responsibility to invalidate the TLB after
+ * calling this function to ensure that the updated permissions are visible
+ * to the CPUs.
+ *
+ * Return: The old page-table entry prior to clearing the flag, 0 on failure.
+ */
+kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
+
+/**
+ * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
+ *				   access flag set.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address to identify the page-table entry.
+ *
+ * The offset of @addr within a page is ignored.
+ *
+ * Return: True if the page-table entry has the access flag set, false otherwise.
+ */
+bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
+
 /**
  * kvm_pgtable_walk() - Walk a page-table.
  * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 2f9b872f5355..af60ea8ee29d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -690,6 +690,92 @@ int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
+struct stage2_attr_data {
+	kvm_pte_t	attr_set;
+	kvm_pte_t	attr_clr;
+	kvm_pte_t	pte;
+};
+
+static int stage2_attr_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			      enum kvm_pgtable_walk_flags flag,
+			      void * const arg)
+{
+	kvm_pte_t pte = *ptep;
+	struct stage2_attr_data *data = arg;
+
+	if (!kvm_pte_valid(pte))
+		return 0;
+
+	data->pte = pte;
+	pte &= ~data->attr_clr;
+	pte |= data->attr_set;
+
+	/*
+	 * We may race with the CPU trying to set the access flag here,
+	 * but worst-case the access flag update gets lost and will be
+	 * set on the next access instead.
+	 */
+	if (data->pte != pte)
+		WRITE_ONCE(*ptep, pte);
+
+	return 0;
+}
+
+static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
+				    u64 size, kvm_pte_t attr_set,
+				    kvm_pte_t attr_clr, kvm_pte_t *orig_pte)
+{
+	int ret;
+	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
+	struct stage2_attr_data data = {
+		.attr_set	= attr_set & attr_mask,
+		.attr_clr	= attr_clr & attr_mask,
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb		= stage2_attr_walker,
+		.arg		= &data,
+		.flags		= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
+	if (ret)
+		return ret;
+
+	if (orig_pte)
+		*orig_pte = data.pte;
+	return 0;
+}
+
+kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
+{
+	kvm_pte_t pte = 0;
+	stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
+				 &pte);
+	dsb(ishst);
+	return pte;
+}
+
+kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr)
+{
+	kvm_pte_t pte = 0;
+	stage2_update_leaf_attrs(pgt, addr, 1, 0, KVM_PTE_LEAF_ATTR_LO_S2_AF,
+				 &pte);
+	/*
+	 * "But where's the TLBI?!", you scream.
+	 * "Over in the core code", I sigh.
+	 *
+	 * See the '->clear_flush_young()' callback on the KVM mmu notifier.
+	 */
+	return pte;
+}
+
+bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
+{
+	kvm_pte_t pte = 0;
+	stage2_update_leaf_attrs(pgt, addr, 1, 0, 0, &pte);
+	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
+}
+
 int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm)
 {
 	size_t pgd_sz;
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
