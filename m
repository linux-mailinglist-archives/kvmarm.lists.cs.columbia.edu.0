Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C12515A0
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 11:40:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51F5E4C08B;
	Tue, 25 Aug 2020 05:40:39 -0400 (EDT)
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
	with ESMTP id hH-e+10u1VB2; Tue, 25 Aug 2020 05:40:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BF124C079;
	Tue, 25 Aug 2020 05:40:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 04ABB4C05A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9rJW8tWtLwX for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 05:40:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 921094C07C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 05:40:33 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 209612074D;
 Tue, 25 Aug 2020 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598348432;
 bh=F9ltbSd45j09M/5O+5jDEzsQTMkypAYPgGQ3FAUVwjw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J3zsTbXLPZfMBMpkPjdol1sRCZdFNSyJESwg5btZyUF80wuqocU372ppRRJtsdKwk
 F4SZlVJZkW6Nayab/1hIe426eLemlFIVQBVMR3A3FlPVkCHYejvzK0jXO9vSsl+Whi
 wRvgYCOfeYS9ID6Da7uW8iBKUpzU+CuTpfzRoYQI=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 14/21] KVM: arm64: Add support for stage-2 cache flushing
 in generic page-table
Date: Tue, 25 Aug 2020 10:39:46 +0100
Message-Id: <20200825093953.26493-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825093953.26493-1-will@kernel.org>
References: <20200825093953.26493-1-will@kernel.org>
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

Add support for cache flushing a range of the stage-2 address space to
the generic page-table code.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h | 12 ++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 0c96b78d791d..ea823fe31913 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -226,6 +226,18 @@ kvm_pte_t kvm_pgtable_stage2_mkold(struct kvm_pgtable *pgt, u64 addr);
  */
 bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
 
+/**
+ * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
+ * 				      of Coherency for guest stage-2 address
+ *				      range.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init().
+ * @addr:	Intermediate physical address from which to flush.
+ * @size:	Size of the range.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size);
+
 /**
  * kvm_pgtable_walk() - Walk a page-table.
  * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c218651f8eba..75887185f1e2 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -762,6 +762,32 @@ bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr)
 	return pte & KVM_PTE_LEAF_ATTR_LO_S2_AF;
 }
 
+static int stage2_flush_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			       enum kvm_pgtable_walk_flags flag,
+			       void * const arg)
+{
+	kvm_pte_t pte = *ptep;
+
+	if (!kvm_pte_valid(pte) || !stage2_pte_cacheable(pte))
+		return 0;
+
+	stage2_flush_dcache(kvm_pte_follow(pte), kvm_granule_size(level));
+	return 0;
+}
+
+int kvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= stage2_flush_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		return 0;
+
+	return kvm_pgtable_walk(pgt, addr, size, &walker);
+}
+
 int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm *kvm)
 {
 	size_t pgd_sz;
-- 
2.28.0.297.g1956fa8f8d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
