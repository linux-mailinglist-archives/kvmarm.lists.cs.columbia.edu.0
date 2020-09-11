Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 44B88266028
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 15:25:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE8574B375;
	Fri, 11 Sep 2020 09:25:49 -0400 (EDT)
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
	with ESMTP id VsI0ZGFTiOUP; Fri, 11 Sep 2020 09:25:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 497F04B391;
	Fri, 11 Sep 2020 09:25:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5364A4B363
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:25:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SVchsLy8wrhX for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 09:25:45 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EBBA14B391
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 09:25:44 -0400 (EDT)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 357E122227;
 Fri, 11 Sep 2020 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599830744;
 bh=vP+X7Za5pevSJbT9+KkcmRT0tcGIiqEq7A8u81tMCvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BsX/hlkbQ5/J1hpQITes8Ewq+AF+ogovrqB/qwJzyU1rzQGehDgOQF3t5iKOEfLln
 UJ/oSLnF3p448fDUM/gb3CcatfpNgaSz3WNuZIakiMZ84QqAZey/aWteOCu9XC5rK1
 8iJMO1W6d9u+wo0rva9yFu6qllqhKHKGj0mwT2dQ=
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 03/21] KVM: arm64: Add support for creating kernel-agnostic
 stage-1 page tables
Date: Fri, 11 Sep 2020 14:25:11 +0100
Message-Id: <20200911132529.19844-4-will@kernel.org>
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

The generic page-table walker is pretty useless as it stands, because it
doesn't understand enough to allocate anything. Teach it about stage-1
page-tables, and hook up an API for allocating these for the hypervisor
at EL2.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h |  40 ++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 133 +++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 9423e5d609f1..d0a207d095e6 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -77,6 +77,46 @@ struct kvm_pgtable_walker {
 	const enum kvm_pgtable_walk_flags	flags;
 };
 
+/**
+ * kvm_pgtable_hyp_init() - Initialise a hypervisor stage-1 page-table.
+ * @pgt:	Uninitialised page-table structure to initialise.
+ * @va_bits:	Maximum virtual address bits.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits);
+
+/**
+ * kvm_pgtable_hyp_destroy() - Destroy an unused hypervisor stage-1 page-table.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_hyp_init().
+ *
+ * The page-table is assumed to be unreachable by any hardware walkers prior
+ * to freeing and therefore no TLB invalidation is performed.
+ */
+void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt);
+
+/**
+ * kvm_pgtable_hyp_map() - Install a mapping in a hypervisor stage-1 page-table.
+ * @pgt:	Page-table structure initialised by kvm_pgtable_hyp_init().
+ * @addr:	Virtual address at which to place the mapping.
+ * @size:	Size of the mapping.
+ * @phys:	Physical address of the memory to map.
+ * @prot:	Permissions and attributes for the mapping.
+ *
+ * The offset of @addr within a page is ignored, @size is rounded-up to
+ * the next page boundary and @phys is rounded-down to the previous page
+ * boundary.
+ *
+ * If device attributes are not explicitly requested in @prot, then the
+ * mapping will be normal, cacheable. Attempts to install a new mapping
+ * for a virtual address that is already mapped will be rejected with an
+ * error and a WARN().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
+			enum kvm_pgtable_prot prot);
+
 /**
  * kvm_pgtable_walk() - Walk a page-table.
  * @pgt:	Page-table structure initialised by kvm_pgtable_*_init().
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3fb9d1949a3f..23a1006aa4ef 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -24,8 +24,18 @@
 
 #define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
 
+#define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP	GENMASK(7, 6)
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RO	3
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RW	1
+#define KVM_PTE_LEAF_ATTR_LO_S1_SH	GENMASK(9, 8)
+#define KVM_PTE_LEAF_ATTR_LO_S1_SH_IS	3
+#define KVM_PTE_LEAF_ATTR_LO_S1_AF	BIT(10)
+
 #define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 51)
 
+#define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
+
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable		*pgt;
 	struct kvm_pgtable_walker	*walker;
@@ -283,3 +293,126 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
 
 	return _kvm_pgtable_walk(&walk_data);
 }
+
+struct hyp_map_data {
+	u64		phys;
+	kvm_pte_t	attr;
+};
+
+static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
+				 struct hyp_map_data *data)
+{
+	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
+	u32 mtype = device ? MT_DEVICE_nGnRE : MT_NORMAL;
+	kvm_pte_t attr = FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX, mtype);
+	u32 sh = KVM_PTE_LEAF_ATTR_LO_S1_SH_IS;
+	u32 ap = (prot & KVM_PGTABLE_PROT_W) ? KVM_PTE_LEAF_ATTR_LO_S1_AP_RW :
+					       KVM_PTE_LEAF_ATTR_LO_S1_AP_RO;
+
+	if (!(prot & KVM_PGTABLE_PROT_R))
+		return -EINVAL;
+
+	if (prot & KVM_PGTABLE_PROT_X) {
+		if (prot & KVM_PGTABLE_PROT_W)
+			return -EINVAL;
+
+		if (device)
+			return -EINVAL;
+	} else {
+		attr |= KVM_PTE_LEAF_ATTR_HI_S1_XN;
+	}
+
+	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
+	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
+	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
+	data->attr = attr;
+	return 0;
+}
+
+static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
+				    kvm_pte_t *ptep, struct hyp_map_data *data)
+{
+	u64 granule = kvm_granule_size(level), phys = data->phys;
+
+	if (!kvm_block_mapping_supported(addr, end, phys, level))
+		return false;
+
+	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
+	data->phys += granule;
+	return true;
+}
+
+static int hyp_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			  enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	kvm_pte_t *childp;
+
+	if (hyp_map_walker_try_leaf(addr, end, level, ptep, arg))
+		return 0;
+
+	if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
+		return -EINVAL;
+
+	childp = (kvm_pte_t *)get_zeroed_page(GFP_KERNEL);
+	if (!childp)
+		return -ENOMEM;
+
+	kvm_set_table_pte(ptep, childp);
+	return 0;
+}
+
+int kvm_pgtable_hyp_map(struct kvm_pgtable *pgt, u64 addr, u64 size, u64 phys,
+			enum kvm_pgtable_prot prot)
+{
+	int ret;
+	struct hyp_map_data map_data = {
+		.phys	= ALIGN_DOWN(phys, PAGE_SIZE),
+	};
+	struct kvm_pgtable_walker walker = {
+		.cb	= hyp_map_walker,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.arg	= &map_data,
+	};
+
+	ret = hyp_map_set_prot_attr(prot, &map_data);
+	if (ret)
+		return ret;
+
+	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
+	dsb(ishst);
+	isb();
+	return ret;
+}
+
+int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
+{
+	u64 levels = ARM64_HW_PGTABLE_LEVELS(va_bits);
+
+	pgt->pgd = (kvm_pte_t *)get_zeroed_page(GFP_KERNEL);
+	if (!pgt->pgd)
+		return -ENOMEM;
+
+	pgt->ia_bits		= va_bits;
+	pgt->start_level	= KVM_PGTABLE_MAX_LEVELS - levels;
+	pgt->mmu		= NULL;
+	return 0;
+}
+
+static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			   enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	free_page((unsigned long)kvm_pte_follow(*ptep));
+	return 0;
+}
+
+void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= hyp_free_walker,
+		.flags	= KVM_PGTABLE_WALK_TABLE_POST,
+	};
+
+	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
+	free_page((unsigned long)pgt->pgd);
+	pgt->pgd = NULL;
+}
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
