Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 90643561C1B
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jun 2022 15:58:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D46C4B497;
	Thu, 30 Jun 2022 09:58:55 -0400 (EDT)
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
	with ESMTP id 2L3TsvoxT3e9; Thu, 30 Jun 2022 09:58:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E1DA54B4F1;
	Thu, 30 Jun 2022 09:58:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D83541175
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:58:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q+L5Y4Zslbjv for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jun 2022 09:58:51 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8DC414B4C6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:58:51 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2317B6219B;
 Thu, 30 Jun 2022 13:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF78C341CD;
 Thu, 30 Jun 2022 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656597530;
 bh=ImX+07VIs5/ywt24lHtORtVCTgqMYbIoz08sSw7dG5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ootCpjVRtnqzVmn1mwhZUMtV8bYTxenIQKgiaKFTfCOWzVtLOlGukUgK11Y/QxETv
 DG/XEDFz/0pNp/+wZK1c2FyiU4zNitzt2vfF9PzkndCP9j0GvTa6V6LEKSRCV6aevu
 KtmTKlAHDPkvtmcb5a1QULTPxXQtRxtLyefDNMZtydnUFFegyInKie9BZUE34oLANK
 PhW+PgAlZ0wXGeUgHVaaXeBMrx8C+QhbJxPMWjcvizwhzfhyDqHNWLYdzsS0QfiKwG
 EcNvudZnUPEPbMW2RAp6ybhehuvN1goNMvErHjySZKVSPh67mOaelr5GPWRWbrXIAZ
 UpZDzftYs7G7w==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 14/24] KVM: arm64: Add pcpu fixmap infrastructure at EL2
Date: Thu, 30 Jun 2022 14:57:37 +0100
Message-Id: <20220630135747.26983-15-will@kernel.org>
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

We will soon need to temporarily map pages into the hypervisor stage-1
in nVHE protected mode. To do this efficiently, let's introduce a
per-cpu fixmap allowing to map a single page without needing to take any
lock or to allocate memory.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
 arch/arm64/kvm/hyp/include/nvhe/mm.h          |  4 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |  1 -
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 72 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c               |  4 ++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 3a0817b5c739..d11d9d68a680 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -59,6 +59,8 @@ enum pkvm_component_id {
 	PKVM_ID_HYP,
 };
 
+extern unsigned long hyp_nr_cpus;
+
 int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index b2ee6d5df55b..882c5711eda5 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -13,6 +13,10 @@
 extern struct kvm_pgtable pkvm_pgtable;
 extern hyp_spinlock_t pkvm_pgd_lock;
 
+int hyp_create_pcpu_fixmap(void);
+void *hyp_fixmap_map(phys_addr_t phys);
+int hyp_fixmap_unmap(void);
+
 int hyp_create_idmap(u32 hyp_va_bits);
 int hyp_map_vectors(void);
 int hyp_back_vmemmap(phys_addr_t back);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 9baf731736be..a0af23de2640 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -21,7 +21,6 @@
 
 #define KVM_HOST_S2_FLAGS (KVM_PGTABLE_S2_NOFWB | KVM_PGTABLE_S2_IDMAP)
 
-extern unsigned long hyp_nr_cpus;
 struct host_kvm host_kvm;
 
 static struct hyp_pool host_s2_pool;
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index d3a3b47181de..17d689483ec4 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -14,6 +14,7 @@
 #include <nvhe/early_alloc.h>
 #include <nvhe/gfp.h>
 #include <nvhe/memory.h>
+#include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
 #include <nvhe/spinlock.h>
 
@@ -24,6 +25,7 @@ struct memblock_region hyp_memory[HYP_MEMBLOCK_REGIONS];
 unsigned int hyp_memblock_nr;
 
 static u64 __io_map_base;
+static DEFINE_PER_CPU(void *, hyp_fixmap_base);
 
 static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 				  unsigned long phys, enum kvm_pgtable_prot prot)
@@ -212,6 +214,76 @@ int hyp_map_vectors(void)
 	return 0;
 }
 
+void *hyp_fixmap_map(phys_addr_t phys)
+{
+	void *addr = *this_cpu_ptr(&hyp_fixmap_base);
+	int ret = kvm_pgtable_hyp_map(&pkvm_pgtable, (u64)addr, PAGE_SIZE,
+				      phys, PAGE_HYP);
+	return ret ? NULL : addr;
+}
+
+int hyp_fixmap_unmap(void)
+{
+	void *addr = *this_cpu_ptr(&hyp_fixmap_base);
+	int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, (u64)addr, PAGE_SIZE);
+
+	return (ret != PAGE_SIZE) ? -EINVAL : 0;
+}
+
+static int __pin_pgtable_cb(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
+			    enum kvm_pgtable_walk_flags flag, void * const arg)
+{
+	if (!kvm_pte_valid(*ptep) || level != KVM_PGTABLE_MAX_LEVELS - 1)
+		return -EINVAL;
+	hyp_page_ref_inc(hyp_virt_to_page(ptep));
+
+	return 0;
+}
+
+static int hyp_pin_pgtable_pages(u64 addr)
+{
+	struct kvm_pgtable_walker walker = {
+		.cb	= __pin_pgtable_cb,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	return kvm_pgtable_walk(&pkvm_pgtable, addr, PAGE_SIZE, &walker);
+}
+
+int hyp_create_pcpu_fixmap(void)
+{
+	unsigned long addr, i;
+	int ret;
+
+	for (i = 0; i < hyp_nr_cpus; i++) {
+		ret = pkvm_alloc_private_va_range(PAGE_SIZE, &addr);
+		if (ret)
+			return ret;
+
+		/*
+		 * Create a dummy mapping, to get the intermediate page-table
+		 * pages allocated, then take a reference on the last level
+		 * page to keep it around at all times.
+		 */
+		ret = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, PAGE_SIZE,
+					  __hyp_pa(__hyp_bss_start), PAGE_HYP);
+		if (ret)
+			return ret;
+
+		ret = hyp_pin_pgtable_pages(addr);
+		if (ret)
+			return ret;
+
+		ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, addr, PAGE_SIZE);
+		if (ret != PAGE_SIZE)
+			return -EINVAL;
+
+		*per_cpu_ptr(&hyp_fixmap_base, i) = (void *)addr;
+	}
+
+	return 0;
+}
+
 int hyp_create_idmap(u32 hyp_va_bits)
 {
 	unsigned long start, end;
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index fb0eff15a89f..3f689ffb2693 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -321,6 +321,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = hyp_create_pcpu_fixmap();
+	if (ret)
+		goto out;
+
 	hyp_shadow_table_init(shadow_table_base);
 out:
 	/*
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
