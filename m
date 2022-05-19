Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65A52D482
	for <lists+kvmarm@lfdr.de>; Thu, 19 May 2022 15:45:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36F8C4B435;
	Thu, 19 May 2022 09:45:51 -0400 (EDT)
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
	with ESMTP id k3rsLwkQRMaq; Thu, 19 May 2022 09:45:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 737864B429;
	Thu, 19 May 2022 09:45:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8AE64B3A4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CMLz+ia00My2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 May 2022 09:45:46 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3F1924B428
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:46 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E6893B824AA;
 Thu, 19 May 2022 13:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE9C385B8;
 Thu, 19 May 2022 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652967943;
 bh=asJoncPL+c6dfZ/3VORJ/alvAWHNYckJGw8PqP4+tBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L9Orza4KSbC9vQrWJ3Tdpkf5OTTU93Oo1gTMd1dI63A9fHRNnEu5loZB782PADBIL
 cvCVl0O91yfYB6H6MhLOJmWdDLj283djRcWJXVOFt7ItkAtU0vXHKnOYfVVeHUEEZF
 LGr5iuxb9bzHP4LkFZec4BpH9SxlV5R4jD3h1mUvIcOB4x1nWaq+5EL6S6B4OSq5ej
 4CR0+hOzax7kpQLq+Ts7beEvTrmd5FLccgxmyXBI5kiL9y/uLPYs0TFwiZokdI7Bwg
 YcMIwoiK3UuNs1UAWGmTTHQaHhNBGh1Z2lVEKRxcckcwWleWstBmiSvS/z6+oDx43V
 FUrKMus3wzSWg==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 50/89] KVM: arm64: Ensure that TLBs and I-cache are private to
 each vcpu
Date: Thu, 19 May 2022 14:41:25 +0100
Message-Id: <20220519134204.5379-51-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220519134204.5379-1-will@kernel.org>
References: <20220519134204.5379-1-will@kernel.org>
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

From: Fuad Tabba <tabba@google.com>

Guarantee that both TLBs and I-cache are private to each vcpu.
Flush the CPU context if a different vcpu from the same vm is
loaded on the same physical CPU.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  9 +++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c     | 17 ++++++++++++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c         | 34 ++++++++++++++++++++++++--
 arch/arm64/kvm/pkvm.c                  | 20 +++++++++++----
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 343d87877aa2..da8de2b7afb4 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -45,6 +45,9 @@ struct kvm_shadow_vm {
 	/* The total size of the donated shadow area. */
 	size_t shadow_area_size;
 
+	/* The total size of the donated area for last_ran. */
+	size_t last_ran_size;
+
 	struct kvm_pgtable pgt;
 	struct kvm_pgtable_mm_ops mm_ops;
 	struct hyp_pool pool;
@@ -78,8 +81,10 @@ static inline bool vcpu_is_protected(struct kvm_vcpu *vcpu)
 }
 
 void hyp_shadow_table_init(void *tbl);
-int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
-		       size_t shadow_size, unsigned long pgd_hva);
+int __pkvm_init_shadow(struct kvm *kvm,
+		       unsigned long shadow_hva, size_t shadow_size,
+		       unsigned long pgd_hva,
+		       unsigned long last_ran_hva, size_t last_ran_size);
 int __pkvm_teardown_shadow(unsigned int shadow_handle);
 
 struct kvm_shadow_vcpu_state *
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 86dff0dc05f3..229ef890d459 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -145,6 +145,7 @@ static void handle___pkvm_vcpu_load(struct kvm_cpu_context *host_ctxt)
 	DECLARE_REG(u64, hcr_el2, host_ctxt, 3);
 	struct kvm_shadow_vcpu_state *shadow_state;
 	struct kvm_vcpu *shadow_vcpu;
+	int *last_ran;
 
 	if (!is_protected_kvm_enabled())
 		return;
@@ -155,6 +156,17 @@ static void handle___pkvm_vcpu_load(struct kvm_cpu_context *host_ctxt)
 
 	shadow_vcpu = &shadow_state->shadow_vcpu;
 
+	/*
+	 * Guarantee that both TLBs and I-cache are private to each vcpu. If a
+	 * vcpu from the same VM has previously run on the same physical CPU,
+	 * nuke the relevant contexts.
+	 */
+	last_ran = &shadow_vcpu->arch.hw_mmu->last_vcpu_ran[hyp_smp_processor_id()];
+	if (*last_ran != shadow_vcpu->vcpu_id) {
+		__kvm_flush_cpu_context(shadow_vcpu->arch.hw_mmu);
+		*last_ran = shadow_vcpu->vcpu_id;
+	}
+
 	if (shadow_state_is_protected(shadow_state)) {
 		/* Propagate WFx trapping flags, trap ptrauth */
 		shadow_vcpu->arch.hcr_el2 &= ~(HCR_TWE | HCR_TWI |
@@ -436,9 +448,12 @@ static void handle___pkvm_init_shadow(struct kvm_cpu_context *host_ctxt)
 	DECLARE_REG(unsigned long, host_shadow_va, host_ctxt, 2);
 	DECLARE_REG(size_t, shadow_size, host_ctxt, 3);
 	DECLARE_REG(unsigned long, pgd, host_ctxt, 4);
+	DECLARE_REG(unsigned long, last_ran, host_ctxt, 5);
+	DECLARE_REG(size_t, last_ran_size, host_ctxt, 6);
 
 	cpu_reg(host_ctxt, 1) = __pkvm_init_shadow(host_kvm, host_shadow_va,
-						   shadow_size, pgd);
+						   shadow_size, pgd,
+						   last_ran, last_ran_size);
 }
 
 static void handle___pkvm_teardown_shadow(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index f18f622336b8..c0403416ce1d 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -338,6 +338,8 @@ static int set_host_vcpus(struct kvm_shadow_vcpu_state *shadow_vcpu_states,
 
 static int init_shadow_structs(struct kvm *kvm, struct kvm_shadow_vm *vm,
 			       struct kvm_vcpu **vcpu_array,
+			       int *last_ran,
+			       size_t last_ran_size,
 			       unsigned int nr_vcpus)
 {
 	int i;
@@ -345,6 +347,9 @@ static int init_shadow_structs(struct kvm *kvm, struct kvm_shadow_vm *vm,
 	vm->host_kvm = kvm;
 	vm->kvm.created_vcpus = nr_vcpus;
 	vm->kvm.arch.vtcr = host_kvm.arch.vtcr;
+	vm->kvm.arch.mmu.last_vcpu_ran = last_ran;
+	vm->last_ran_size = last_ran_size;
+	memset(vm->kvm.arch.mmu.last_vcpu_ran, -1, sizeof(int) * hyp_nr_cpus);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		struct kvm_shadow_vcpu_state *shadow_vcpu_state = &vm->shadow_vcpu_states[i];
@@ -471,6 +476,15 @@ static int check_shadow_size(unsigned int nr_vcpus, size_t shadow_size)
 	return 0;
 }
 
+/*
+ * Check whether the size of the area donated by the host is sufficient for
+ * tracking the last vcpu that has run a physical cpu on this vm.
+ */
+static int check_last_ran_size(size_t size)
+{
+	return size >= (hyp_nr_cpus * sizeof(int)) ? 0 : -ENOMEM;
+}
+
 static void *map_donated_memory_noclear(unsigned long host_va, size_t size)
 {
 	void *va = (void *)kern_hyp_va(host_va);
@@ -530,6 +544,10 @@ static void unmap_donated_memory_noclear(void *va, size_t size)
  * pgd_hva: The host va of the area being donated for the stage-2 PGD for
  *	    the VM. Must be page aligned. Its size is implied by the VM's
  *	    VTCR.
+ * last_ran_hva: The host va of the area being donated for hyp to use to track
+ *		 the most recent physical cpu on which each vcpu has run.
+ * last_ran_size: The size of the area being donated at last_ran_hva.
+ *	          Must be a multiple of the page size.
  * Note: An array to the host KVM VCPUs (host VA) is passed via the pgd, as to
  *	 not to be dependent on how the VCPU's are layed out in struct kvm.
  *
@@ -537,9 +555,11 @@ static void unmap_donated_memory_noclear(void *va, size_t size)
  * negative error code on failure.
  */
 int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
-		       size_t shadow_size, unsigned long pgd_hva)
+		       size_t shadow_size, unsigned long pgd_hva,
+		       unsigned long last_ran_hva, size_t last_ran_size)
 {
 	struct kvm_shadow_vm *vm = NULL;
+	void *last_ran = NULL;
 	unsigned int nr_vcpus;
 	size_t pgd_size = 0;
 	void *pgd = NULL;
@@ -555,12 +575,20 @@ int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
 	if (ret)
 		goto err_unpin_kvm;
 
+	ret = check_last_ran_size(last_ran_size);
+	if (ret)
+		goto err_unpin_kvm;
+
 	ret = -ENOMEM;
 
 	vm = map_donated_memory(shadow_hva, shadow_size);
 	if (!vm)
 		goto err_remove_mappings;
 
+	last_ran = map_donated_memory(last_ran_hva, last_ran_size);
+	if (!last_ran)
+		goto err_remove_mappings;
+
 	pgd_size = kvm_pgtable_stage2_pgd_size(host_kvm.arch.vtcr);
 	pgd = map_donated_memory_noclear(pgd_hva, pgd_size);
 	if (!pgd)
@@ -570,7 +598,7 @@ int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
 	if (ret)
 		goto err_remove_mappings;
 
-	ret = init_shadow_structs(kvm, vm, pgd, nr_vcpus);
+	ret = init_shadow_structs(kvm, vm, pgd, last_ran, last_ran_size, nr_vcpus);
 	if (ret < 0)
 		goto err_unpin_host_vcpus;
 
@@ -595,6 +623,7 @@ int __pkvm_init_shadow(struct kvm *kvm, unsigned long shadow_hva,
 	unpin_host_vcpus(vm->shadow_vcpu_states, nr_vcpus);
 err_remove_mappings:
 	unmap_donated_memory(vm, shadow_size);
+	unmap_donated_memory(last_ran, last_ran_size);
 	unmap_donated_memory_noclear(pgd, pgd_size);
 err_unpin_kvm:
 	hyp_unpin_shared_mem(kvm, kvm + 1);
@@ -636,6 +665,7 @@ int __pkvm_teardown_shadow(unsigned int shadow_handle)
 	shadow_size = vm->shadow_area_size;
 	hyp_unpin_shared_mem(vm->host_kvm, vm->host_kvm + 1);
 
+	unmap_donated_memory(vm->kvm.arch.mmu.last_vcpu_ran, vm->last_ran_size);
 	memset(vm, 0, shadow_size);
 	for (addr = vm; addr < (void *)vm + shadow_size; addr += PAGE_SIZE)
 		push_hyp_memcache(mc, addr, hyp_virt_to_phys);
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 40e5490ef453..67aad91dc3e5 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -111,8 +111,8 @@ static int __kvm_shadow_create(struct kvm *kvm)
 {
 	struct kvm_vcpu *vcpu, **vcpu_array;
 	unsigned int shadow_handle;
-	size_t pgd_sz, shadow_sz;
-	void *pgd, *shadow_addr;
+	size_t pgd_sz, shadow_sz, last_ran_sz;
+	void *pgd, *shadow_addr, *last_ran;
 	unsigned long idx;
 	int ret;
 
@@ -138,6 +138,14 @@ static int __kvm_shadow_create(struct kvm *kvm)
 		goto free_pgd;
 	}
 
+	/* Allocate memory to donate to hyp for tracking mmu->last_vcpu_ran. */
+	last_ran_sz = PAGE_ALIGN(num_possible_cpus() * sizeof(int));
+	last_ran = alloc_pages_exact(last_ran_sz, GFP_KERNEL_ACCOUNT);
+	if (!last_ran) {
+		ret = -ENOMEM;
+		goto free_shadow;
+	}
+
 	/* Stash the vcpu pointers into the PGD */
 	BUILD_BUG_ON(KVM_MAX_VCPUS > (PAGE_SIZE / sizeof(u64)));
 	vcpu_array = pgd;
@@ -145,7 +153,7 @@ static int __kvm_shadow_create(struct kvm *kvm)
 		/* Indexing of the vcpus to be sequential starting at 0. */
 		if (WARN_ON(vcpu->vcpu_idx != idx)) {
 			ret = -EINVAL;
-			goto free_shadow;
+			goto free_last_ran;
 		}
 
 		vcpu_array[idx] = vcpu;
@@ -153,9 +161,9 @@ static int __kvm_shadow_create(struct kvm *kvm)
 
 	/* Donate the shadow memory to hyp and let hyp initialize it. */
 	ret = kvm_call_hyp_nvhe(__pkvm_init_shadow, kvm, shadow_addr, shadow_sz,
-				pgd);
+				pgd, last_ran, last_ran_sz);
 	if (ret < 0)
-		goto free_shadow;
+		goto free_last_ran;
 
 	shadow_handle = ret;
 
@@ -163,6 +171,8 @@ static int __kvm_shadow_create(struct kvm *kvm)
 	kvm->arch.pkvm.shadow_handle = shadow_handle;
 	return 0;
 
+free_last_ran:
+	free_pages_exact(last_ran, last_ran_sz);
 free_shadow:
 	free_pages_exact(shadow_addr, shadow_sz);
 free_pgd:
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
