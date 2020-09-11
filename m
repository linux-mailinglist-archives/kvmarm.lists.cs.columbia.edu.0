Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9E266035
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 15:26:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0E24B33F;
	Fri, 11 Sep 2020 09:26:21 -0400 (EDT)
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
	with ESMTP id fpV8N9dhDE7a; Fri, 11 Sep 2020 09:26:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E8BE4B259;
	Fri, 11 Sep 2020 09:26:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 952424B372
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aomSNz9DZ-L5 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 09:26:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ED9D34B3ED
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:26:16 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33EB222224;
 Fri, 11 Sep 2020 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599830776;
 bh=jS315xI31Tqwa14UYQFjIyLOhtPliTy3EJkI+IJhZDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EZmuPhT5A5uCWUWC77oL/kgmx0sIxq1OzCijFi8Qjr6BaB9lR0nW92yfHopIFtbDO
 CxRm4pH+AuqSCLu9vhoWlT7UtaGrkUvBOHx9imD3n3u9bbsHSAnv/NA7KmjLSCY2kA
 EymyynG5xIPNfWfhcNbk1iuDq7GTqPKncS2tidKk=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 16/21] KVM: arm64: Add support for relaxing stage-2 perms
 in generic page-table code
Date: Fri, 11 Sep 2020 14:25:24 +0100
Message-Id: <20200911132529.19844-17-will@kernel.org>
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

Add support for relaxing the permissions of a stage-2 mapping (i.e.
adding additional permissions) to the generic page-table code.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h | 19 +++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 77c027456c61..52ab38db04c7 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -236,6 +236,25 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr);
  */
 kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
 
+/**
+ * kvm_pgtable_stage2_relax_perms() - Relax the permissions enforced by a
+ *				      page-table entry.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address to identify the page-table entry.
+ * @prot:	Additional permissions to grant for the mapping.
+ *
+ * The offset of @addr within a page is ignored.
+ *
+ * If there is a valid, leaf page-table entry used to translate @addr, then
+ * relax the permissions in that entry according to the read, write and
+ * execute permissions specified by @prot. No permissions are removed, and
+ * TLB invalidation is performed after updating the entry.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
+				   enum kvm_pgtable_prot prot);
+
 /**
  * kvm_pgtable_stage2_is_young() - Test whether a page-table entry has the
  *				   access flag set.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index d382756a527c..603d6b415337 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -782,6 +782,26 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
 	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
 }
 
+int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
+				   enum kvm_pgtable_prot prot)
+{
+	int ret;
+	kvm_pte_t set = 0, clr = 0;
+
+	if (prot & KVM_PGTABLE_PROT_R)
+		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R;
+
+	if (prot & KVM_PGTABLE_PROT_W)
+		set |= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W;
+
+	if (prot & KVM_PGTABLE_PROT_X)
+		clr |= KVM_PTE_LEAF_ATTR_HI_S2_XN;
+
+	ret = stage2_update_leaf_attrs(pgt, addr, 1, set, clr, NULL);
+	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, pgt->mmu, addr, 0);
+	return ret;
+}
+
 static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			       enum kvm_pgtable_walk_flags flag,
 			       void * const arg)
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
