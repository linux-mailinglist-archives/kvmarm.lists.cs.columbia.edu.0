Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB661A5FA
	for <lists+kvmarm@lfdr.de>; Sat,  5 Nov 2022 00:41:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 390F740B8F;
	Fri,  4 Nov 2022 19:41:21 -0400 (EDT)
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
	with ESMTP id s1gLjOAf2l8m; Fri,  4 Nov 2022 19:41:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C9AFB49A51;
	Fri,  4 Nov 2022 19:41:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3113640BD9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 19:41:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01mUn-AyGDXP for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 19:41:16 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E98D640B8F
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 19:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667605275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nt53tpwPVyBFHMzcqpLAA0Ut9xiuM9O3j01X9AL9dCY=;
 b=QW1dnkNyvDC7FdFp8yjcr45C5UZZ32H6ldMJbXArOxOGKqqAklYg3WnTAV35DQzWrdEF3M
 /0ffaU74UlYA1i0msyoJEuaKBZOiJHGLQ0/V24gGbUt/FtSDmei2FH4VtGEedBnfUifI1w
 8KJCedhZsCZ210UTP4y0c7yI/f89OTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-6BUw8oaiPt-99EwAPRySZg-1; Fri, 04 Nov 2022 19:41:12 -0400
X-MC-Unique: 6BUw8oaiPt-99EwAPRySZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B645585A59D;
 Fri,  4 Nov 2022 23:41:11 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-78.bne.redhat.com [10.64.54.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99A404A927A;
 Fri,  4 Nov 2022 23:41:02 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
Subject: [PATCH v8 1/7] KVM: x86: Introduce KVM_REQ_DIRTY_RING_SOFT_FULL
Date: Sat,  5 Nov 2022 07:40:43 +0800
Message-Id: <20221104234049.25103-2-gshan@redhat.com>
In-Reply-To: <20221104234049.25103-1-gshan@redhat.com>
References: <20221104234049.25103-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: maz@kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com,
 andrew.jones@linux.dev, will@kernel.org, shan.gavin@gmail.com,
 bgardon@google.com, dmatlack@google.com, pbonzini@redhat.com,
 zhenyzha@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
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

The VCPU isn't expected to be runnable when the dirty ring becomes soft
full, until the dirty pages are harvested and the dirty ring is reset
from userspace. So there is a check in each guest's entrace to see if
the dirty ring is soft full or not. The VCPU is stopped from running if
its dirty ring has been soft full. The similar check will be needed when
the feature is going to be supported on ARM64. As Marc Zyngier suggested,
a new event will avoid pointless overhead to check the size of the dirty
ring ('vcpu->kvm->dirty_ring_size') in each guest's entrance.

Add KVM_REQ_DIRTY_RING_SOFT_FULL. The event is raised when the dirty ring
becomes soft full in kvm_dirty_ring_push(). The event is only cleared in
the check, done in the newly added helper kvm_dirty_ring_check_request().
Since the VCPU is not runnable when the dirty ring becomes soft full, the
KVM_REQ_DIRTY_RING_SOFT_FULL event is always set to prevent the VCPU from
running until the dirty pages are harvested and the dirty ring is reset by
userspace.

kvm_dirty_ring_soft_full() becomes a private function with the newly added
helper kvm_dirty_ring_check_request(). The alignment for the various event
definitions in kvm_host.h is changed to tab character by the way. In order
to avoid using 'container_of()', the argument @ring is replaced by @vcpu
in kvm_dirty_ring_push().

Link: https://lore.kernel.org/kvmarm/87lerkwtm5.wl-maz@kernel.org
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c             | 15 ++++++---------
 include/linux/kvm_dirty_ring.h | 12 ++++--------
 include/linux/kvm_host.h       |  9 +++++----
 virt/kvm/dirty_ring.c          | 32 ++++++++++++++++++++++++++++++--
 virt/kvm/kvm_main.c            |  3 +--
 5 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 521b433f978c..fd3347e31f5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10512,20 +10512,17 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	bool req_immediate_exit = false;
 
-	/* Forbid vmenter if vcpu dirty ring is soft-full */
-	if (unlikely(vcpu->kvm->dirty_ring_size &&
-		     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
-		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
-		trace_kvm_dirty_ring_exit(vcpu);
-		r = 0;
-		goto out;
-	}
-
 	if (kvm_request_pending(vcpu)) {
 		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
 			r = -EIO;
 			goto out;
 		}
+
+		if (kvm_dirty_ring_check_request(vcpu)) {
+			r = 0;
+			goto out;
+		}
+
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
 				r = 0;
diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
index 906f899813dc..9c13c4c3d30c 100644
--- a/include/linux/kvm_dirty_ring.h
+++ b/include/linux/kvm_dirty_ring.h
@@ -49,7 +49,7 @@ static inline int kvm_dirty_ring_reset(struct kvm *kvm,
 	return 0;
 }
 
-static inline void kvm_dirty_ring_push(struct kvm_dirty_ring *ring,
+static inline void kvm_dirty_ring_push(struct kvm_vcpu *vcpu,
 				       u32 slot, u64 offset)
 {
 }
@@ -64,11 +64,6 @@ static inline void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
 {
 }
 
-static inline bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
-{
-	return true;
-}
-
 #else /* CONFIG_HAVE_KVM_DIRTY_RING */
 
 u32 kvm_dirty_ring_get_rsvd_entries(void);
@@ -84,13 +79,14 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring);
  * returns =0: successfully pushed
  *         <0: unable to push, need to wait
  */
-void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset);
+void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset);
+
+bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu);
 
 /* for use in vm_operations_struct */
 struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset);
 
 void kvm_dirty_ring_free(struct kvm_dirty_ring *ring);
-bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring);
 
 #endif /* CONFIG_HAVE_KVM_DIRTY_RING */
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 18592bdf4c1b..6fab55e58111 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -153,10 +153,11 @@ static inline bool is_error_page(struct page *page)
  * Architecture-independent vcpu->requests bit members
  * Bits 3-7 are reserved for more arch-independent bits.
  */
-#define KVM_REQ_TLB_FLUSH         (0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-#define KVM_REQ_VM_DEAD           (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
-#define KVM_REQ_UNBLOCK           2
-#define KVM_REQUEST_ARCH_BASE     8
+#define KVM_REQ_TLB_FLUSH		(0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_UNBLOCK			2
+#define KVM_REQ_DIRTY_RING_SOFT_FULL	3
+#define KVM_REQUEST_ARCH_BASE		8
 
 /*
  * KVM_REQ_OUTSIDE_GUEST_MODE exists is purely as way to force the vCPU to
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index d6fabf238032..fecbb7d75ad2 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -26,7 +26,7 @@ static u32 kvm_dirty_ring_used(struct kvm_dirty_ring *ring)
 	return READ_ONCE(ring->dirty_index) - READ_ONCE(ring->reset_index);
 }
 
-bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
+static bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
 {
 	return kvm_dirty_ring_used(ring) >= ring->soft_limit;
 }
@@ -142,13 +142,19 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
 
 	kvm_reset_dirty_gfn(kvm, cur_slot, cur_offset, mask);
 
+	/*
+	 * The request KVM_REQ_DIRTY_RING_SOFT_FULL will be cleared
+	 * by the VCPU thread next time when it enters the guest.
+	 */
+
 	trace_kvm_dirty_ring_reset(ring);
 
 	return count;
 }
 
-void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
+void kvm_dirty_ring_push(struct kvm_vcpu *vcpu, u32 slot, u64 offset)
 {
+	struct kvm_dirty_ring *ring = &vcpu->dirty_ring;
 	struct kvm_dirty_gfn *entry;
 
 	/* It should never get full */
@@ -166,6 +172,28 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
 	kvm_dirty_gfn_set_dirtied(entry);
 	ring->dirty_index++;
 	trace_kvm_dirty_ring_push(ring, slot, offset);
+
+	if (kvm_dirty_ring_soft_full(ring))
+		kvm_make_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu);
+}
+
+bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The VCPU isn't runnable when the dirty ring becomes soft full.
+	 * The KVM_REQ_DIRTY_RING_SOFT_FULL event is always set to prevent
+	 * the VCPU from running until the dirty pages are harvested and
+	 * the dirty ring is reset by userspace.
+	 */
+	if (kvm_check_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu) &&
+	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
+		kvm_make_request(KVM_REQ_DIRTY_RING_SOFT_FULL, vcpu);
+		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
+		trace_kvm_dirty_ring_exit(vcpu);
+		return true;
+	}
+
+	return false;
 }
 
 struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 25d7872b29c1..c865d7d82685 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3314,8 +3314,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
 		if (kvm->dirty_ring_size)
-			kvm_dirty_ring_push(&vcpu->dirty_ring,
-					    slot, rel_gfn);
+			kvm_dirty_ring_push(vcpu, slot, rel_gfn);
 		else
 			set_bit_le(rel_gfn, memslot->dirty_bitmap);
 	}
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
