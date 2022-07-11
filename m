Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 67734561C21
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jun 2022 15:59:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 143064B4D4;
	Thu, 30 Jun 2022 09:59:16 -0400 (EDT)
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
	with ESMTP id yGK+tOdpGhAS; Thu, 30 Jun 2022 09:59:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D5E541175;
	Thu, 30 Jun 2022 09:59:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CA984B4A2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:59:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hP95g04NPr+H for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jun 2022 09:59:12 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C46C44B496
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jun 2022 09:59:11 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 08C2BB82A7D;
 Thu, 30 Jun 2022 13:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D787C34115;
 Thu, 30 Jun 2022 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656597549;
 bh=30dNE0wWVFK96CPhSt0kble4nLGBd3sqOAIzyYktuZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fBQ1FC/rmwtl/nbtkcDgDbzXz/I0tdCnVXtgM8mVz/8KUxQu0Jof6biBGWYfLwsfJ
 /XjWJHdiYqHcA9IkP03K/BkbIYz5zLukiuyYdL3ZH+iCuVIidreGvURcSymuElUeSX
 g5hL3PKru9ueEu08z7f5PEBPyDBTukzlEgzgaRJu0Htp7Pje82e8sB5NwmWBcppP1A
 r+IkzMwR4EZJ1pkoM4JsSotXtgzUwxR+dHUyjJnJlnZ4fl3BHkg5DROU8IvXGEp8Br
 WBbmqSgPR9UJK1PFBUfWal91DACjASrGyG5aoeXi/t8MixGwDz9oBL4/gW5lR9c4Na
 e3FOUm4t4JmYA==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 19/24] KVM: arm64: Return guest memory from EL2 via
 dedicated teardown memcache
Date: Thu, 30 Jun 2022 14:57:42 +0100
Message-Id: <20220630135747.26983-20-will@kernel.org>
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

Rather than relying on the host to free the shadow VM pages explicitly
on teardown, introduce a dedicated teardown memcache which allows the
host to reclaim guest memory resources without having to keep track of
all of the allocations made by EL2.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h             |  6 +-----
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 17 +++++++++++------
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |  8 +++++++-
 arch/arm64/kvm/pkvm.c                         | 12 +-----------
 5 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 70a2db91665d..09481268c224 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -175,11 +175,7 @@ struct kvm_smccc_features {
 struct kvm_protected_vm {
 	unsigned int shadow_handle;
 	struct mutex shadow_lock;
-
-	struct {
-		void *pgd;
-		void *shadow;
-	} hyp_donations;
+	struct kvm_hyp_memcache teardown_mc;
 };
 
 struct kvm_arch {
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 36eea31a1c5f..663019992b67 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -76,7 +76,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
 int hyp_pin_shared_mem(void *from, void *to);
 void hyp_unpin_shared_mem(void *from, void *to);
-void reclaim_guest_pages(struct kvm_shadow_vm *vm);
+void reclaim_guest_pages(struct kvm_shadow_vm *vm, struct kvm_hyp_memcache *mc);
 int refill_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages,
 		    struct kvm_hyp_memcache *host_mc);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 5b22bba77e57..bcfdba1881c1 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -260,19 +260,24 @@ int kvm_guest_prepare_stage2(struct kvm_shadow_vm *vm, void *pgd)
 	return 0;
 }
 
-void reclaim_guest_pages(struct kvm_shadow_vm *vm)
+void reclaim_guest_pages(struct kvm_shadow_vm *vm, struct kvm_hyp_memcache *mc)
 {
-	unsigned long nr_pages, pfn;
-
-	nr_pages = kvm_pgtable_stage2_pgd_size(vm->kvm.arch.vtcr) >> PAGE_SHIFT;
-	pfn = hyp_virt_to_pfn(vm->pgt.pgd);
+	void *addr;
 
+	/* Dump all pgtable pages in the hyp_pool */
 	guest_lock_component(vm);
 	kvm_pgtable_stage2_destroy(&vm->pgt);
 	vm->kvm.arch.mmu.pgd_phys = 0ULL;
 	guest_unlock_component(vm);
 
-	WARN_ON(__pkvm_hyp_donate_host(pfn, nr_pages));
+	/* Drain the hyp_pool into the memcache */
+	addr = hyp_alloc_pages(&vm->pool, 0);
+	while (addr) {
+		memset(hyp_virt_to_page(addr), 0, sizeof(struct hyp_page));
+		push_hyp_memcache(mc, addr, hyp_virt_to_phys);
+		WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(addr), 1));
+		addr = hyp_alloc_pages(&vm->pool, 0);
+	}
 }
 
 int __pkvm_prot_finalize(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 114c5565de7d..a4a518b2a43b 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -546,8 +546,10 @@ int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
 
 int __pkvm_teardown_shadow(unsigned int shadow_handle)
 {
+	struct kvm_hyp_memcache *mc;
 	struct kvm_shadow_vm *vm;
 	size_t shadow_size;
+	void *addr;
 	int err;
 
 	/* Lookup then remove entry from the shadow table. */
@@ -569,7 +571,8 @@ int __pkvm_teardown_shadow(unsigned int shadow_handle)
 	hyp_spin_unlock(&shadow_lock);
 
 	/* Reclaim guest pages (including page-table pages) */
-	reclaim_guest_pages(vm);
+	mc = &vm->host_kvm->arch.pkvm.teardown_mc;
+	reclaim_guest_pages(vm, mc);
 	unpin_host_vcpus(vm->shadow_vcpu_states, vm->kvm.created_vcpus);
 
 	/* Push the metadata pages to the teardown memcache */
@@ -577,6 +580,9 @@ int __pkvm_teardown_shadow(unsigned int shadow_handle)
 	hyp_unpin_shared_mem(vm->host_kvm, vm->host_kvm + 1);
 
 	memset(vm, 0, shadow_size);
+	for (addr = vm; addr < (void *)vm + shadow_size; addr += PAGE_SIZE)
+		push_hyp_memcache(mc, addr, hyp_virt_to_phys);
+
 	unmap_donated_memory_noclear(vm, shadow_size);
 	return 0;
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index b4466b31d7c8..b174d6dfde36 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -160,8 +160,6 @@ static int __kvm_shadow_create(struct kvm *kvm)
 
 	/* Store the shadow handle given by hyp for future call reference. */
 	kvm->arch.pkvm.shadow_handle = shadow_handle;
-	kvm->arch.pkvm.hyp_donations.pgd = pgd;
-	kvm->arch.pkvm.hyp_donations.shadow = shadow_addr;
 	return 0;
 
 free_shadow:
@@ -185,20 +183,12 @@ int kvm_shadow_create(struct kvm *kvm)
 
 void kvm_shadow_destroy(struct kvm *kvm)
 {
-	size_t pgd_sz, shadow_sz;
-
 	if (kvm->arch.pkvm.shadow_handle)
 		WARN_ON(kvm_call_hyp_nvhe(__pkvm_teardown_shadow,
 					  kvm->arch.pkvm.shadow_handle));
 
 	kvm->arch.pkvm.shadow_handle = 0;
-
-	shadow_sz = PAGE_ALIGN(KVM_SHADOW_VM_SIZE +
-			       KVM_SHADOW_VCPU_STATE_SIZE * kvm->created_vcpus);
-	pgd_sz = kvm_pgtable_stage2_pgd_size(kvm->arch.vtcr);
-
-	free_pages_exact(kvm->arch.pkvm.hyp_donations.shadow, shadow_sz);
-	free_pages_exact(kvm->arch.pkvm.hyp_donations.pgd, pgd_sz);
+	free_hyp_memcache(&kvm->arch.pkvm.teardown_mc);
 }
 
 int kvm_init_pvm(struct kvm *kvm)
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
