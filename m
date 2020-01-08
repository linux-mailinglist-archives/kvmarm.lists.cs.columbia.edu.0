Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94F61134D45
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 21:27:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4995A4B12B;
	Wed,  8 Jan 2020 15:27:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CyYXZTCDBodl; Wed,  8 Jan 2020 15:27:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 979824B173;
	Wed,  8 Jan 2020 15:27:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBF1A4B146
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cecrvIZFyhe for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 15:27:07 -0500 (EST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AE2B44B13D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 15:27:07 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 12:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; d="scan'208";a="211658380"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 12:27:06 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 08/14] KVM: x86/mmu: Drop level optimization from
 fast_page_fault()
Date: Wed,  8 Jan 2020 12:24:42 -0800
Message-Id: <20200108202448.9669-9-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>,
 linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
 Barret Rhoden <brho@google.com>, kvm-ppc@vger.kernel.org,
 Liran Alon <liran.alon@oracle.com>, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jason Zeng <jason.zeng@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

Remove fast_page_fault()'s optimization to stop the shadow walk if the
iterator level drops below the intended map level.  The intended map
level is only acccurate for HugeTLB mappings (THP mappings are detected
after fast_page_fault()), i.e. it's not required for correctness, and
a future patch will also move HugeTLB mapping detection to after
fast_page_fault().

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4bd7f745b56d..7d78d1d996ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3593,7 +3593,7 @@ static bool is_access_allowed(u32 fault_err_code, u64 spte)
  * - true: let the vcpu to access on the same address again.
  * - false: let the real page fault path to fix it.
  */
-static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, int level,
+static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    u32 error_code)
 {
 	struct kvm_shadow_walk_iterator iterator;
@@ -3611,8 +3611,7 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, int level,
 		u64 new_spte;
 
 		for_each_shadow_entry_lockless(vcpu, cr2_or_gpa, iterator, spte)
-			if (!is_shadow_present_pte(spte) ||
-			    iterator.level < level)
+			if (!is_shadow_present_pte(spte))
 				break;
 
 		sp = page_header(__pa(iterator.sptep));
@@ -4223,7 +4222,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (level > PT_PAGE_TABLE_LEVEL)
 		gfn &= ~(KVM_PAGES_PER_HPAGE(level) - 1);
 
-	if (fast_page_fault(vcpu, gpa, level, error_code))
+	if (fast_page_fault(vcpu, gpa, error_code))
 		return RET_PF_RETRY;
 
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
