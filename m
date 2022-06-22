Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BCE55555433
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jun 2022 21:27:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B0174B535;
	Wed, 22 Jun 2022 15:27:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0i3JcLEN96vB; Wed, 22 Jun 2022 15:27:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B529D4B536;
	Wed, 22 Jun 2022 15:27:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D58134B445
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jun 2022 15:27:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfHuZ-waVmEP for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jun 2022 15:27:21 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 433624B357
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jun 2022 15:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655926040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiKbqfUUhRGo5YzvopzGYLiqd6xk2vKNFeCsmwuxOPk=;
 b=CEbBcg0kI3AzKZxnLY6qSUuZKz3dWbwaGA5/M4lBqCw7jNepoqUg/3g8OguFioWaWBudkb
 raqKXruC6eEIQgPmXdrV1KW4UCk1kCNiwMozkW5bb6puK1PVgqLCmI9pZRfHnYznS9WgUU
 sw12lMfPujQaLra8EK+MyasVO9aBNcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-EO7jKaghP_K-sBPTx6rTVg-1; Wed, 22 Jun 2022 15:27:18 -0400
X-MC-Unique: EO7jKaghP_K-sBPTx6rTVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3038A801E80;
 Wed, 22 Jun 2022 19:27:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDF5C1410F3B;
 Wed, 22 Jun 2022 19:27:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v7 15/23] KVM: x86/mmu: Decouple rmap_add() and
 link_shadow_page() from kvm_vcpu
Date: Wed, 22 Jun 2022 15:27:02 -0400
Message-Id: <20220622192710.2547152-16-pbonzini@redhat.com>
In-Reply-To: <20220622192710.2547152-1-pbonzini@redhat.com>
References: <20220622192710.2547152-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: maz@kernel.org, jiangshanlai@gmail.com, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, bgardon@google.com, dmatlack@google.com,
 maciej.szmigiero@oracle.com, kvmarm@lists.cs.columbia.edu, pfeiner@google.com
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

From: David Matlack <dmatlack@google.com>

Allow adding new entries to the rmap and linking shadow pages without a
struct kvm_vcpu pointer by moving the implementation of rmap_add() and
link_shadow_page() into inner helper functions.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-16-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 47 ++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 45a4e85c0b2c..a8cdbe2958d9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -673,11 +673,6 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
-static struct pte_list_desc *mmu_alloc_pte_list_desc(struct kvm_vcpu *vcpu)
-{
-	return kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_pte_list_desc_cache);
-}
-
 static void mmu_free_pte_list_desc(struct pte_list_desc *pte_list_desc)
 {
 	kmem_cache_free(pte_list_desc_cache, pte_list_desc);
@@ -832,7 +827,7 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 /*
  * Returns the number of pointers in the rmap chain, not counting the new one.
  */
-static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
+static int pte_list_add(struct kvm_mmu_memory_cache *cache, u64 *spte,
 			struct kvm_rmap_head *rmap_head)
 {
 	struct pte_list_desc *desc;
@@ -843,7 +838,7 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
 		rmap_head->val = (unsigned long)spte;
 	} else if (!(rmap_head->val & 1)) {
 		rmap_printk("%p %llx 1->many\n", spte, *spte);
-		desc = mmu_alloc_pte_list_desc(vcpu);
+		desc = kvm_mmu_memory_cache_alloc(cache);
 		desc->sptes[0] = (u64 *)rmap_head->val;
 		desc->sptes[1] = spte;
 		desc->spte_count = 2;
@@ -855,7 +850,7 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
 		while (desc->spte_count == PTE_LIST_EXT) {
 			count += PTE_LIST_EXT;
 			if (!desc->more) {
-				desc->more = mmu_alloc_pte_list_desc(vcpu);
+				desc->more = kvm_mmu_memory_cache_alloc(cache);
 				desc = desc->more;
 				desc->spte_count = 0;
 				break;
@@ -1556,8 +1551,10 @@ static bool kvm_test_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 
 #define RMAP_RECYCLE_THRESHOLD 1000
 
-static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
-		     u64 *spte, gfn_t gfn)
+static void __rmap_add(struct kvm *kvm,
+		       struct kvm_mmu_memory_cache *cache,
+		       const struct kvm_memory_slot *slot,
+		       u64 *spte, gfn_t gfn)
 {
 	struct kvm_mmu_page *sp;
 	struct kvm_rmap_head *rmap_head;
@@ -1566,15 +1563,23 @@ static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
 	sp = sptep_to_sp(spte);
 	kvm_mmu_page_set_gfn(sp, spte - sp->spt, gfn);
 	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
-	rmap_count = pte_list_add(vcpu, spte, rmap_head);
+	rmap_count = pte_list_add(cache, spte, rmap_head);
 
 	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		kvm_unmap_rmapp(vcpu->kvm, rmap_head, NULL, gfn, sp->role.level, __pte(0));
+		kvm_unmap_rmapp(kvm, rmap_head, NULL, gfn, sp->role.level, __pte(0));
 		kvm_flush_remote_tlbs_with_address(
-				vcpu->kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
+				kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 	}
 }
 
+static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
+		     u64 *spte, gfn_t gfn)
+{
+	struct kvm_mmu_memory_cache *cache = &vcpu->arch.mmu_pte_list_desc_cache;
+
+	__rmap_add(vcpu->kvm, cache, slot, spte, gfn);
+}
+
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool young = false;
@@ -1645,13 +1650,13 @@ static unsigned kvm_page_table_hashfn(gfn_t gfn)
 	return hash_64(gfn, KVM_MMU_HASH_SHIFT);
 }
 
-static void mmu_page_add_parent_pte(struct kvm_vcpu *vcpu,
+static void mmu_page_add_parent_pte(struct kvm_mmu_memory_cache *cache,
 				    struct kvm_mmu_page *sp, u64 *parent_pte)
 {
 	if (!parent_pte)
 		return;
 
-	pte_list_add(vcpu, parent_pte, &sp->parent_ptes);
+	pte_list_add(cache, parent_pte, &sp->parent_ptes);
 }
 
 static void mmu_page_remove_parent_pte(struct kvm_mmu_page *sp,
@@ -2247,8 +2252,8 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
 
-static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
-			     struct kvm_mmu_page *sp)
+static void __link_shadow_page(struct kvm_mmu_memory_cache *cache, u64 *sptep,
+			       struct kvm_mmu_page *sp)
 {
 	u64 spte;
 
@@ -2258,12 +2263,18 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	mmu_spte_set(sptep, spte);
 
-	mmu_page_add_parent_pte(vcpu, sp, sptep);
+	mmu_page_add_parent_pte(cache, sp, sptep);
 
 	if (sp->unsync_children || sp->unsync)
 		mark_unsync(sptep);
 }
 
+static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
+			     struct kvm_mmu_page *sp)
+{
+	__link_shadow_page(&vcpu->arch.mmu_pte_list_desc_cache, sptep, sp);
+}
+
 static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 				   unsigned direct_access)
 {
-- 
2.31.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
