Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9896B50C875
	for <lists+kvmarm@lfdr.de>; Sat, 23 Apr 2022 10:57:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F6344B1F2;
	Sat, 23 Apr 2022 04:57:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8Ixp0IQk01z; Sat, 23 Apr 2022 04:57:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AC4D4B2CA;
	Sat, 23 Apr 2022 04:57:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EA614A193
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 17:06:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AAVlnb1fFDMz for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Apr 2022 17:06:20 -0400 (EDT)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0E2D940C31
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 17:06:20 -0400 (EDT)
Received: by mail-pl1-f202.google.com with SMTP id
 e18-20020a17090301d200b00158faee4449so5382441plh.21
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Apr 2022 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=AokhUPI0w8x0YtojIWxDMCet7uQDG5b+eiidLmmEvGw=;
 b=LhtF+x5GT2s+QDOONs7fKAv3klJirfq1E+v9o0whKKGLAbQq1FM3tOZBTdaIvvK7+L
 TzIQqqo1+sUXr7JMRYt48OzS5nc57m+foZQJ4+tWk6n0ghhE5vbbzvlQtshHIvnC6B21
 71FG+NJEuVyObMrdlcGXMpNRdY52UEqJNJKVcJNqrxmYDakOYXjMZLONxo6IXQ8BaYQQ
 S26vPuFCFSNjvTbFxh3fzJt6BM1vtEwSchoRN/WM4JlWMUurXqyT7unrHIaMm9oosAu8
 jNtTkaR9TqwkcD7OwIDvUeWGCHL8ZB+QAZ5mdwzIArWYtR/XPKgG2NBnEry2tlN/sx4K
 ZpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=AokhUPI0w8x0YtojIWxDMCet7uQDG5b+eiidLmmEvGw=;
 b=k9206RpRQZreQanvuAOCjJHx57G86P0PyWnUDP0NKEAgEaCRwGLwmHHP2gqn+Wx0Ju
 Wn1NIlqK4IGj0U1hGJuk7c1B9A7puYW/XQkAourdvUgdF1ZGMBquml1x7FVqxphinaAv
 CXR5dzT+MsT+s14C2tdjN0Z4RmazNGTdoViLcghF9hSRi2E/sLNwFlsRcPsQPZ+SdSs7
 mTiKfF0dRQ937W63ZtHbT9lX3tP7dTT9FV47VKS8X/f//0BVh9Yu8UNAyQhgnJC0uM0Y
 CAwOyJX5753xY+N5B4w7fJaw1Q8nMY4De0u/RYoxxw4efIhpHYSkjrFFNm0Rubw9uM4y
 LWFg==
X-Gm-Message-State: AOAM5333VvxjU+uWO82m+b5IGDD0hkd6TbIUP9GBOuerP6g4N0lzpdgA
 Nn2ER9l9tMTWuV/s4S6tDbx9dz3YFycKtw==
X-Google-Smtp-Source: ABdhPJxHVFmIWyEEslp8lfnPYbT/7EtrSdKmonQmeUAkEv1kyEMdkBMNSlhDn9mjvTBGmUngHH899Dm8lUOMxA==
X-Received: from dmatlack-heavy.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:19cd])
 (user=dmatlack job=sendgmr) by 2002:a17:902:edc5:b0:156:68e4:416 with SMTP id
 q5-20020a170902edc500b0015668e40416mr6461850plk.87.1650661579256; Fri, 22 Apr
 2022 14:06:19 -0700 (PDT)
Date: Fri, 22 Apr 2022 21:05:45 +0000
In-Reply-To: <20220422210546.458943-1-dmatlack@google.com>
Message-Id: <20220422210546.458943-20-dmatlack@google.com>
Mime-Version: 1.0
References: <20220422210546.458943-1-dmatlack@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 19/20] KVM: Allow for different capacities in
 kvm_mmu_memory_cache structs
From: David Matlack <dmatlack@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailman-Approved-At: Sat, 23 Apr 2022 04:57:06 -0400
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <linux-mips@vger.kernel.org>, David Matlack <dmatlack@google.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR RISC-V \(KVM/riscv\)"
 <kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ben Gardon <bgardon@google.com>, maciej.szmigiero@oracle.com,
 "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Peter Feiner <pfeiner@google.com>
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

Allow the capacity of the kvm_mmu_memory_cache struct to be chosen at
declaration time rather than being fixed for all declarations. This will
be used in a follow-up commit to declare an cache in x86 with a capacity
of 512+ objects without having to increase the capacity of all caches in
KVM.

This change requires each cache now specify its capacity at runtime,
since the cache struct itself no longer has a fixed capacity known at
compile time. To protect against someone accidentally defining a
kvm_mmu_memory_cache struct directly (without the extra storage), this
commit includes a WARN_ON() in kvm_mmu_topup_memory_cache().

In order to support different capacities, this commit changes the
objects pointer array to be dynamically allocated the first time the
cache is topped-up.

An alternative would be to lay out the objects array after the
kvm_mmu_memory_cache struct, which can be done at compile time. But that
change, unfortunately, adds some grottiness to arm64 and riscv, which
uses a function-local (i.e.  stack-allocated) kvm_mmu_memory_cache
struct. Since C does not allow anonymous structs in functions, the new
wrapper struct that contains kvm_mmu_memory_cache and the objects
pointer array, must be named, which means dealing with an outer and
inner struct. The outer struct can't be dropped since then there would
be no guarantee the kvm_mmu_memory_cache struct and objects array would
be laid out consecutively on the stack.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 arch/arm64/kvm/arm.c      |  1 +
 arch/arm64/kvm/mmu.c      |  5 ++++-
 arch/mips/kvm/mips.c      |  2 ++
 arch/riscv/kvm/mmu.c      | 14 +++++++-------
 arch/riscv/kvm/vcpu.c     |  1 +
 arch/x86/kvm/mmu/mmu.c    |  9 +++++++++
 include/linux/kvm_types.h |  9 +++++++--
 virt/kvm/kvm_main.c       | 20 ++++++++++++++++++--
 8 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..66f6706a1037 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -320,6 +320,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.target = -1;
 	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
 
+	vcpu->arch.mmu_page_cache.capacity = KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
 	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
 
 	/* Set up the timer */
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 53ae2c0640bc..2f2ef6b60ff4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -764,7 +764,10 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 {
 	phys_addr_t addr;
 	int ret = 0;
-	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
+	struct kvm_mmu_memory_cache cache = {
+		.capacity = KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE,
+		.gfp_zero = __GFP_ZERO,
+	};
 	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
 				     KVM_PGTABLE_PROT_R |
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a25e0b73ee70..45c7179144dc 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -387,6 +387,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		goto out_free_gebase;
 
+	vcpu->arch.mmu_page_cache.capacity = KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
+
 	return 0;
 
 out_free_gebase:
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index f80a34fbf102..0e042f40d737 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -347,10 +347,10 @@ static int stage2_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	int ret = 0;
 	unsigned long pfn;
 	phys_addr_t addr, end;
-	struct kvm_mmu_memory_cache pcache;
-
-	memset(&pcache, 0, sizeof(pcache));
-	pcache.gfp_zero = __GFP_ZERO;
+	struct kvm_mmu_memory_cache cache = {
+		.capacity = KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE,
+		.gfp_zero = __GFP_ZERO,
+	};
 
 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(hpa);
@@ -361,12 +361,12 @@ static int stage2_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 		if (!writable)
 			pte = pte_wrprotect(pte);
 
-		ret = kvm_mmu_topup_memory_cache(&pcache, stage2_pgd_levels);
+		ret = kvm_mmu_topup_memory_cache(&cache.cache, stage2_pgd_levels);
 		if (ret)
 			goto out;
 
 		spin_lock(&kvm->mmu_lock);
-		ret = stage2_set_pte(kvm, 0, &pcache, addr, &pte);
+		ret = stage2_set_pte(kvm, 0, &cache.cache, addr, &pte);
 		spin_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -375,7 +375,7 @@ static int stage2_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	}
 
 out:
-	kvm_mmu_free_memory_cache(&pcache);
+	kvm_mmu_free_memory_cache(&cache.cache);
 	return ret;
 }
 
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 6785aef4cbd4..bbcb9d4a04fb 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -94,6 +94,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	/* Mark this VCPU never ran */
 	vcpu->arch.ran_atleast_once = false;
+	vcpu->arch.mmu_page_cache.capacity = KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
 	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
 
 	/* Setup ISA features available to VCPU */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5961c17eb36..5b1458b911ab 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5719,12 +5719,21 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
 	int ret;
 
+	vcpu->arch.mmu_pte_list_desc_cache.capacity =
+		KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
 	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
 	vcpu->arch.mmu_pte_list_desc_cache.gfp_zero = __GFP_ZERO;
 
+	vcpu->arch.mmu_page_header_cache.capacity =
+		KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
 	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
 	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
 
+	vcpu->arch.mmu_shadowed_info_cache.capacity =
+		KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
+
+	vcpu->arch.mmu_shadow_page_cache.capacity =
+		KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE;
 	vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index ac1ebb37a0ff..549103a4f7bc 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -83,14 +83,19 @@ struct gfn_to_pfn_cache {
  * MMU flows is problematic, as is triggering reclaim, I/O, etc... while
  * holding MMU locks.  Note, these caches act more like prefetch buffers than
  * classical caches, i.e. objects are not returned to the cache on being freed.
+ *
+ * The storage for the cache object pointers is allocated dynamically when the
+ * cache is topped-up. The capacity field defines the number of object pointers
+ * available after the struct.
  */
 struct kvm_mmu_memory_cache {
 	int nobjs;
+	int capacity;
 	gfp_t gfp_zero;
 	struct kmem_cache *kmem_cache;
-	void *objects[KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE];
+	void **objects;
 };
-#endif
+#endif /* KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE */
 
 #define HALT_POLL_HIST_COUNT			32
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dfb7dabdbc63..29f84d7c1950 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -371,12 +371,23 @@ static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
 
 int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 {
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	void *obj;
 
 	if (mc->nobjs >= min)
 		return 0;
-	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
-		obj = mmu_memory_cache_alloc_obj(mc, GFP_KERNEL_ACCOUNT);
+
+	if (WARN_ON(mc->capacity == 0))
+		return -EINVAL;
+
+	if (!mc->objects) {
+		mc->objects = kvmalloc_array(sizeof(void *), mc->capacity, gfp);
+		if (!mc->objects)
+			return -ENOMEM;
+	}
+
+	while (mc->nobjs < mc->capacity) {
+		obj = mmu_memory_cache_alloc_obj(mc, gfp);
 		if (!obj)
 			return mc->nobjs >= min ? 0 : -ENOMEM;
 		mc->objects[mc->nobjs++] = obj;
@@ -397,6 +408,11 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
 		else
 			free_page((unsigned long)mc->objects[--mc->nobjs]);
 	}
+
+	kvfree(mc->objects);
+
+	/* Note, must set to NULL to avoid use-after-free in the next top-up. */
+	mc->objects = NULL;
 }
 
 void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
