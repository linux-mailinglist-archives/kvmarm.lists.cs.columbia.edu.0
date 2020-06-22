Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63720411B
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 22:09:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9744B0EE;
	Mon, 22 Jun 2020 16:09:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rq5hJPBaeokJ; Mon, 22 Jun 2020 16:09:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 403464B0F5;
	Mon, 22 Jun 2020 16:09:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 051804B0AC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 16:09:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6cmY7N1qgjGa for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 16:09:09 -0400 (EDT)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D3B7D4B0B3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 16:09:08 -0400 (EDT)
IronPort-SDR: PlMQPT5CQGigdB9QEvieqrjh/hpP7X1XE7YPVFwQ+0HRy6JVmDJ0qVugtKnwVPrMhvT82RfmTL
 gkMOCIY8i+MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142921251"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="142921251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 13:09:08 -0700
IronPort-SDR: 4vP0a9q4nxZFk3rk42UsXufD0AczURJ+JRz1vqb7fFaJalN7ANpprmJLw0sGyZ0iHy1s5bBTV0
 F9hQHC595V1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="318877047"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 13:09:07 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/21] KVM: x86/mmu: Consolidate "page" variant of memory
 cache helpers
Date: Mon, 22 Jun 2020 13:08:03 -0700
Message-Id: <20200622200822.4426-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
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

Drop the "page" variants of the topup/free memory cache helpers, using
the existence of an associated kmem_cache to select the correct alloc
or free routine.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0830c195c9ed..cbc101663a89 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1067,7 +1067,10 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
+		if (cache->kmem_cache)
+			obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
+		else
+			obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!obj)
 			return cache->nobjs >= min ? 0 : -ENOMEM;
 		cache->objects[cache->nobjs++] = obj;
@@ -1082,30 +1085,12 @@ static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
 
 static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
 {
-	while (mc->nobjs)
-		kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
-}
-
-static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
-				       int min)
-{
-	void *page;
-
-	if (cache->nobjs >= min)
-		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
-		if (!page)
-			return cache->nobjs >= min ? 0 : -ENOMEM;
-		cache->objects[cache->nobjs++] = page;
+	while (mc->nobjs) {
+		if (mc->kmem_cache)
+			kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
+		else
+			free_page((unsigned long)mc->objects[--mc->nobjs]);
 	}
-	return 0;
-}
-
-static void mmu_free_memory_cache_page(struct kvm_mmu_memory_cache *mc)
-{
-	while (mc->nobjs)
-		free_page((unsigned long)mc->objects[--mc->nobjs]);
 }
 
 static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
@@ -1116,7 +1101,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 				   8 + PTE_PREFETCH_NUM);
 	if (r)
 		goto out;
-	r = mmu_topup_memory_cache_page(&vcpu->arch.mmu_page_cache, 8);
+	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
 	if (r)
 		goto out;
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
@@ -1127,7 +1112,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
 	mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
-	mmu_free_memory_cache_page(&vcpu->arch.mmu_page_cache);
+	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 	mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
-- 
2.26.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
