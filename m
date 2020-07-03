Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABEBC213162
	for <lists+kvmarm@lfdr.de>; Fri,  3 Jul 2020 04:36:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56BC84B2D3;
	Thu,  2 Jul 2020 22:36:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qq02Y4OJgmZ3; Thu,  2 Jul 2020 22:36:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 614224B297;
	Thu,  2 Jul 2020 22:36:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E41D4B265
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 22:36:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfZZuHTsTbs8 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 22:36:07 -0400 (EDT)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0307D4B212
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 22:36:06 -0400 (EDT)
IronPort-SDR: pzn9NYHPdGw0uvFJbJeMixMX6CYxA9chApCMCWpvGeNg8LmFbgamP0e/e1Jf8qeyt0pSWBk/ie
 WmBymkSKWR9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231938478"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="231938478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 19:36:05 -0700
IronPort-SDR: myyeMp/AEyA7OXQmG9mILHwHzMprfVY9+XX4MnNbM7wePOpLhpVFgo9jxcZVNIJleJVTvLDcyw
 4Zk7+ATmcOyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="278295722"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
 by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:04 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 02/21] KVM: x86/mmu: Consolidate "page" variant of memory
 cache helpers
Date: Thu,  2 Jul 2020 19:35:26 -0700
Message-Id: <20200703023545.8771-3-sean.j.christopherson@intel.com>
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
index 2c62cc1d0353..d6612af6c056 100644
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
