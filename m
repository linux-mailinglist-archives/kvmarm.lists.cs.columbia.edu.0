Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 142C8529A36
	for <lists+kvmarm@lfdr.de>; Tue, 17 May 2022 09:02:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4AE04B291;
	Tue, 17 May 2022 03:02:35 -0400 (EDT)
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
	with ESMTP id MIU7ERKKx5P4; Tue, 17 May 2022 03:02:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A69E4B2DF;
	Tue, 17 May 2022 03:02:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AE274B1F2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 May 2022 19:21:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1blXcUWowJCD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 May 2022 19:21:49 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0B69F4B1ED
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 May 2022 19:21:48 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 v10-20020a17090a0c8a00b001c7a548e4f7so418202pja.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 May 2022 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=JU0bK1sUIpQL38IBTXiEnP/+CIToYShJ1OO8fCGNqfU=;
 b=A3uu4J8ypmriZSqCOGtA5rrPZnC7nGBSZ4frFzm4Ha3leFOavAFv4s9OteC/iwQTMS
 tkP0NvucK4VvndYETF6BGyq92dSpvUObBZ8CZSi62uKBGRmRfOmXrLGJsg1cVxOOqc0Z
 KLTduCJf9VjunQrAVADAfeoVdbozSs+g/S/F0/uf1TGBQPCpPJGVF3Ut4q3V5DsJrQp1
 iKIBOQij1k2VYMql031/3jE54lNNgfAY9GQqpttEYA7hiT08AJrZ0gDXmbJYWO+eefZZ
 +dYd6rNPwoPvhW+JXM/CCX4ZkQZnTx91rreVde1AL4leXPo7qMmCSpMRwIyUUs3W7+cy
 8vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=JU0bK1sUIpQL38IBTXiEnP/+CIToYShJ1OO8fCGNqfU=;
 b=Osx3bClCz2L1d3IvN9o4rThihCHDssRPvj038JgGQPp2KWkZ51MR3W6GV4HuGNEWCl
 vayTAQOil6JIC8FxN/Vjw8vbb5sU6SsJYglf/JoaMIJFqt7/+BtT/2ONxhGC4+FSoWGm
 TUS7U5nIS16RBnCedjqSXLdu10EDQ4zU+L+F5Zy3ugnEPDRGiylI4I9vm2lFe0x1rRnI
 a4gEfT1flMvr5qKHnfFpgnl+bZWuoY/TSSPLb8mCXdscB8pD+qzcNGtkN09GTojbf2l7
 jz/OyzJd0ciId1aZ9mb0SWGyZBRnYieUDHkxUMYDeNjJtwsRf4SLl0GSL2PuqUKHbWYk
 aO8g==
X-Gm-Message-State: AOAM531HtjJrMn0XK6fVBH1Dv4TFMTu+GrWK7DFcftljkF0lrjJasydu
 e40afjK3BqEPW5BWi5emsyS6dB4GiaPCBg==
X-Google-Smtp-Source: ABdhPJzeCkDiTT4b5P3w3Su2Nx/eey2BJ4FYYsjwqNwyHbKD1SFHKQm37HIzr3+JS2MRqktWEiFxuE5IMUtmtQ==
X-Received: from dmatlack-heavy.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:19cd])
 (user=dmatlack job=sendgmr) by 2002:a17:903:248:b0:155:e660:b774 with SMTP id
 j8-20020a170903024800b00155e660b774mr19637380plh.174.1652743308180; Mon, 16
 May 2022 16:21:48 -0700 (PDT)
Date: Mon, 16 May 2022 23:21:20 +0000
In-Reply-To: <20220516232138.1783324-1-dmatlack@google.com>
Message-Id: <20220516232138.1783324-5-dmatlack@google.com>
Mime-Version: 1.0
References: <20220516232138.1783324-1-dmatlack@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v6 04/22] KVM: x86/mmu: Derive shadow MMU page role from parent
From: David Matlack <dmatlack@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailman-Approved-At: Tue, 17 May 2022 03:02:25 -0400
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
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

Instead of computing the shadow page role from scratch for every new
page, derive most of the information from the parent shadow page.  This
eliminates the dependency on the vCPU root role to allocate shadow page
tables, and reduces the number of parameters to kvm_mmu_get_page().

Preemptively split out the role calculation to a separate function for
use in a following commit.

Note that when calculating the MMU root role, we can take
@role.passthrough, @role.direct, and @role.access directly from
@vcpu->arch.mmu->root_role. Only @role.level and @role.quadrant still
must be overridden for PAE page directories.

No functional change intended.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 98 +++++++++++++++++++++++-----------
 arch/x86/kvm/mmu/paging_tmpl.h |  9 ++--
 2 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a9d28bcabcbb..515e0b33144a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2019,33 +2019,15 @@ static void clear_sp_write_flooding_count(u64 *spte)
 	__clear_sp_write_flooding_count(sptep_to_sp(spte));
 }
 
-static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
-					     gfn_t gfn,
-					     gva_t gaddr,
-					     unsigned level,
-					     bool direct,
-					     unsigned int access)
+static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu, gfn_t gfn,
+					     union kvm_mmu_page_role role)
 {
-	union kvm_mmu_page_role role;
 	struct hlist_head *sp_list;
-	unsigned quadrant;
 	struct kvm_mmu_page *sp;
 	int ret;
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu->root_role;
-	role.level = level;
-	role.direct = direct;
-	role.access = access;
-	if (role.has_4_byte_gpte) {
-		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
-		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
-		role.quadrant = quadrant;
-	}
-	if (level <= vcpu->arch.mmu->cpu_role.base.level)
-		role.passthrough = 0;
-
 	sp_list = &vcpu->kvm->arch.mmu_page_hash[kvm_page_table_hashfn(gfn)];
 	for_each_valid_sp(vcpu->kvm, sp, sp_list) {
 		if (sp->gfn != gfn) {
@@ -2063,7 +2045,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			 * Unsync pages must not be left as is, because the new
 			 * upper-level page will be write-protected.
 			 */
-			if (level > PG_LEVEL_4K && sp->unsync)
+			if (role.level > PG_LEVEL_4K && sp->unsync)
 				kvm_mmu_prepare_zap_page(vcpu->kvm, sp,
 							 &invalid_list);
 			continue;
@@ -2104,14 +2086,14 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 
 	++vcpu->kvm->stat.mmu_cache_miss;
 
-	sp = kvm_mmu_alloc_page(vcpu, direct);
+	sp = kvm_mmu_alloc_page(vcpu, role.direct);
 
 	sp->gfn = gfn;
 	sp->role = role;
 	hlist_add_head(&sp->hash_link, sp_list);
 	if (sp_has_gptes(sp)) {
 		account_shadowed(vcpu->kvm, sp);
-		if (level == PG_LEVEL_4K && kvm_vcpu_write_protect_gfn(vcpu, gfn))
+		if (role.level == PG_LEVEL_4K && kvm_vcpu_write_protect_gfn(vcpu, gfn))
 			kvm_flush_remote_tlbs_with_address(vcpu->kvm, gfn, 1);
 	}
 	trace_kvm_mmu_get_page(sp, true);
@@ -2123,6 +2105,55 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	return sp;
 }
 
+static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct, u32 access)
+{
+	struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
+	union kvm_mmu_page_role role;
+
+	role = parent_sp->role;
+	role.level--;
+	role.access = access;
+	role.direct = direct;
+	role.passthrough = 0;
+
+	/*
+	 * If the guest has 4-byte PTEs then that means it's using 32-bit,
+	 * 2-level, non-PAE paging. KVM shadows such guests with PAE paging
+	 * (i.e. 8-byte PTEs). The difference in PTE size means that KVM must
+	 * shadow each guest page table with multiple shadow page tables, which
+	 * requires extra bookkeeping in the role.
+	 *
+	 * Specifically, to shadow the guest's page directory (which covers a
+	 * 4GiB address space), KVM uses 4 PAE page directories, each mapping
+	 * 1GiB of the address space. @role.quadrant encodes which quarter of
+	 * the address space each maps.
+	 *
+	 * To shadow the guest's page tables (which each map a 4MiB region), KVM
+	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
+	 * @role.quadrant encodes which half of the region they map.
+	 *
+	 * Note, the 4 PAE page directories are pre-allocated and the quadrant
+	 * assigned in mmu_alloc_root(). So only page tables need to be handled
+	 * here.
+	 */
+	if (role.has_4_byte_gpte) {
+		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
+		role.quadrant = (sptep - parent_sp->spt) % 2;
+	}
+
+	return role;
+}
+
+static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
+						 u64 *sptep, gfn_t gfn,
+						 bool direct, u32 access)
+{
+	union kvm_mmu_page_role role;
+
+	role = kvm_mmu_child_role(sptep, direct, access);
+	return kvm_mmu_get_page(vcpu, gfn, role);
+}
+
 static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
 					struct kvm_vcpu *vcpu, hpa_t root,
 					u64 addr)
@@ -2965,8 +2996,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (is_shadow_present_pte(*it.sptep))
 			continue;
 
-		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-				      it.level - 1, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
 
 		link_shadow_page(vcpu, it.sptep, sp);
 		if (fault->is_tdp && fault->huge_page_disallowed &&
@@ -3369,13 +3399,18 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 	return ret;
 }
 
-static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
+static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 			    u8 level)
 {
-	bool direct = vcpu->arch.mmu->root_role.direct;
+	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
 	struct kvm_mmu_page *sp;
 
-	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
+	role.level = level;
+
+	if (role.has_4_byte_gpte)
+		role.quadrant = quadrant;
+
+	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
 
 	return __pa(sp->spt);
@@ -3409,8 +3444,8 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL);
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
 		}
@@ -3579,8 +3614,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL);
+		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index db80f7ccaa4e..fd73c857af90 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -648,8 +648,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn = gw->table_gfn[it.level - 2];
 			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_page(vcpu, table_gfn, fault->addr,
-					      it.level-1, false, access);
+			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
+						  false, access);
+
 			/*
 			 * We must synchronize the pagetable before linking it
 			 * because the guest doesn't need to flush tlb when
@@ -705,8 +706,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		drop_large_spte(vcpu, it.sptep);
 
 		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, fault->addr,
-					      it.level - 1, true, direct_access);
+			sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
+						  true, direct_access);
 			link_shadow_page(vcpu, it.sptep, sp);
 			if (fault->huge_page_disallowed &&
 			    fault->req_level >= it.level)
-- 
2.36.0.550.gb090851708-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
