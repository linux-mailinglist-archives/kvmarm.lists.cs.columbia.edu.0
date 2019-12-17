Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A7408123778
	for <lists+kvmarm@lfdr.de>; Tue, 17 Dec 2019 21:40:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C7EA4A98A;
	Tue, 17 Dec 2019 15:40:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ieu4ReBbnnw1; Tue, 17 Dec 2019 15:40:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0A8F4AC88;
	Tue, 17 Dec 2019 15:40:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 315FC4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 15:40:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yZM9HbaHuwWe for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Dec 2019 15:40:45 -0500 (EST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 014C24A586
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 15:40:44 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 12:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; d="scan'208";a="389952609"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by orsmga005.jf.intel.com with ESMTP; 17 Dec 2019 12:40:43 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 12/19] KVM: Move memslot deletion to helper function
Date: Tue, 17 Dec 2019 12:40:34 -0800
Message-Id: <20191217204041.10815-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217204041.10815-1-sean.j.christopherson@intel.com>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org, Wanpeng Li <wanpengli@tencent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

Move memslot deletion into its own routine so that the success path for
other memslot updates does not need to use kvm_free_memslot(), i.e. can
explicitly destroy the dirty bitmap when necessary.  This paves the way
for dropping @dont from kvm_free_memslot(), i.e. all callers now pass
NULL for @dont.

Add a comment above the code to make a copy of the existing memslot
prior to deletion, it is not at all obvious that the pointer will become
stale during sorting and/or installation of new memslots.

Note, kvm_arch_commit_memory_region() allows an architecture to free
resources when moving a memslot or changing its flags, e.g. x86 frees
its arch specific memslot metadata during commit_memory_region().

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Tested-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 virt/kvm/kvm_main.c | 73 +++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index acf52fa16500..50e5aec0c15c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1046,6 +1046,27 @@ static int kvm_set_memslot(struct kvm *kvm,
 	return r;
 }
 
+static int kvm_delete_memslot(struct kvm *kvm,
+			      const struct kvm_userspace_memory_region *mem,
+			      struct kvm_memory_slot *old, int as_id)
+{
+	struct kvm_memory_slot new;
+	int r;
+
+	if (!old->npages)
+		return -EINVAL;
+
+	memset(&new, 0, sizeof(new));
+	new.id = old->id;
+
+	r = kvm_set_memslot(kvm, mem, old, &new, as_id, KVM_MR_DELETE);
+	if (r)
+		return r;
+
+	kvm_free_memslot(kvm, old, NULL);
+	return 0;
+}
+
 /*
  * Allocate some memory and give it an address in the guest physical address
  * space.
@@ -1095,7 +1116,15 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (npages > KVM_MEM_MAX_NR_PAGES)
 		return -EINVAL;
 
-	new = old = *slot;
+	/*
+	 * Make a full copy of the old memslot, the pointer will become stale
+	 * when the memslots are re-sorted by update_memslots().
+	 */
+	old = *slot;
+	if (!mem->memory_size)
+		return kvm_delete_memslot(kvm, mem, &old, as_id);
+
+	new = old;
 
 	new.id = id;
 	new.base_gfn = base_gfn;
@@ -1103,29 +1132,20 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	new.flags = mem->flags;
 	new.userspace_addr = mem->userspace_addr;
 
-	if (npages) {
-		if (!old.npages)
-			change = KVM_MR_CREATE;
-		else { /* Modify an existing slot. */
-			if ((new.userspace_addr != old.userspace_addr) ||
-			    (npages != old.npages) ||
-			    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
-				return -EINVAL;
-
-			if (base_gfn != old.base_gfn)
-				change = KVM_MR_MOVE;
-			else if (new.flags != old.flags)
-				change = KVM_MR_FLAGS_ONLY;
-			else /* Nothing to change. */
-				return 0;
-		}
-	} else {
-		if (!old.npages)
+	if (!old.npages) {
+		change = KVM_MR_CREATE;
+	} else { /* Modify an existing slot. */
+		if ((new.userspace_addr != old.userspace_addr) ||
+		    (npages != old.npages) ||
+		    ((new.flags ^ old.flags) & KVM_MEM_READONLY))
 			return -EINVAL;
 
-		change = KVM_MR_DELETE;
-		new.base_gfn = 0;
-		new.flags = 0;
+		if (base_gfn != old.base_gfn)
+			change = KVM_MR_MOVE;
+		else if (new.flags != old.flags)
+			change = KVM_MR_FLAGS_ONLY;
+		else /* Nothing to change. */
+			return 0;
 	}
 
 	if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
@@ -1148,17 +1168,12 @@ int __kvm_set_memory_region(struct kvm *kvm,
 			return r;
 	}
 
-	/* actual memory is freed via old in kvm_free_memslot below */
-	if (change == KVM_MR_DELETE) {
-		new.dirty_bitmap = NULL;
-		memset(&new.arch, 0, sizeof(new.arch));
-	}
-
 	r = kvm_set_memslot(kvm, mem, &old, &new, as_id, change);
 	if (r)
 		goto out_bitmap;
 
-	kvm_free_memslot(kvm, &old, &new);
+	if (old.dirty_bitmap && !new.dirty_bitmap)
+		kvm_destroy_dirty_bitmap(&old);
 	return 0;
 
 out_bitmap:
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
