Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5526921315F
	for <lists+kvmarm@lfdr.de>; Fri,  3 Jul 2020 04:36:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 028994B25A;
	Thu,  2 Jul 2020 22:36:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OiXE8Ij7NcgM; Thu,  2 Jul 2020 22:36:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 181BF4B28F;
	Thu,  2 Jul 2020 22:36:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FCE64B268
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 22:36:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fXgHVuHX0BKY for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 22:36:07 -0400 (EDT)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 293164B219
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 22:36:07 -0400 (EDT)
IronPort-SDR: 3Z3o3pu9YnH3pjCyhasRBNDQa91wKWHtmS5dhfpEzCg3wSicGkTwTI52FJTtgLT/P/BHH6COA7
 B+GVksv03WTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231938480"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="231938480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 19:36:05 -0700
IronPort-SDR: lq5xZUJFLbh93fPrxLG2HJCQFj4oIO5T+45h0TGZZxmJ+ksUWk2qwMwBdEwk9ZCIUVHF7gL3lU
 8NZduWuw+fAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="278295725"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
 by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:04 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 03/21] KVM: x86/mmu: Use consistent "mc" name for
 kvm_mmu_memory_cache locals
Date: Thu,  2 Jul 2020 19:35:27 -0700
Message-Id: <20200703023545.8771-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Junaid Shahid <junaids@google.com>,
 Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
 linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ben Gardon <bgardon@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Peter Feiner <pfeiner@google.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

Use "mc" for local variables to shorten line lengths and provide
consistent names, which will be especially helpful when some of the
helpers are moved to common KVM code in future patches.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d6612af6c056..b6df4525e86c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1060,27 +1060,27 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 {
 	void *obj;
 
-	if (cache->nobjs >= min)
+	if (mc->nobjs >= min)
 		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		if (cache->kmem_cache)
-			obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
+	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
+		if (mc->kmem_cache)
+			obj = kmem_cache_zalloc(mc->kmem_cache, GFP_KERNEL_ACCOUNT);
 		else
 			obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!obj)
-			return cache->nobjs >= min ? 0 : -ENOMEM;
-		cache->objects[cache->nobjs++] = obj;
+			return mc->nobjs >= min ? 0 : -ENOMEM;
+		mc->objects[mc->nobjs++] = obj;
 	}
 	return 0;
 }
 
-static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
+static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *mc)
 {
-	return cache->nobjs;
+	return mc->nobjs;
 }
 
 static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
@@ -1395,10 +1395,10 @@ static struct kvm_rmap_head *gfn_to_rmap(struct kvm *kvm, gfn_t gfn,
 
 static bool rmap_can_add(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu_memory_cache *cache;
+	struct kvm_mmu_memory_cache *mc;
 
-	cache = &vcpu->arch.mmu_pte_list_desc_cache;
-	return mmu_memory_cache_free_objects(cache);
+	mc = &vcpu->arch.mmu_pte_list_desc_cache;
+	return mmu_memory_cache_free_objects(mc);
 }
 
 static int rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
-- 
2.26.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
