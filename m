Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09150612E54
	for <lists+kvmarm@lfdr.de>; Mon, 31 Oct 2022 01:38:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CA6A4BAD3;
	Sun, 30 Oct 2022 20:38:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTnNxrSR7WjZ; Sun, 30 Oct 2022 20:38:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C9D234BAB9;
	Sun, 30 Oct 2022 20:38:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 837A84BAAB
 for <kvmarm@lists.cs.columbia.edu>; Sun, 30 Oct 2022 20:38:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckStTrNS7lpE for <kvmarm@lists.cs.columbia.edu>;
 Sun, 30 Oct 2022 20:38:34 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BF8E4BA59
 for <kvmarm@lists.cs.columbia.edu>; Sun, 30 Oct 2022 20:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667176713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujIUXWeFWzOovk7/XIyv6uEbFn+FdjaHXLz6Pf3fpbU=;
 b=GNbTwSsdqS+QUlRFXztv0/JFg5cAg0Oa/h8eniv6pcihq4C5LdmF+8krHwVHcoz8C/5A3q
 oGLs/nFjDSRSD4jeHYoCyUEYtOU6VEIN+q5cFBJkwTW8A4iPKR/NslHMxVdtA4yBjrm4eN
 O8VPfk9pn3G5dxtKWwas38rL30PTCmE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-s9OzFTavNn6wd1ZUPRxYMQ-1; Sun, 30 Oct 2022 20:38:27 -0400
X-MC-Unique: s9OzFTavNn6wd1ZUPRxYMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91E785A583;
 Mon, 31 Oct 2022 00:38:26 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-151.bne.redhat.com [10.64.54.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 884AB40C6F9F;
 Mon, 31 Oct 2022 00:38:18 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
Subject: [PATCH v7 4/9] KVM: Support dirty ring in conjunction with bitmap
Date: Mon, 31 Oct 2022 08:36:16 +0800
Message-Id: <20221031003621.164306-5-gshan@redhat.com>
In-Reply-To: <20221031003621.164306-1-gshan@redhat.com>
References: <20221031003621.164306-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: shuah@kernel.org, catalin.marinas@arm.com, kvm@vger.kernel.org,
 maz@kernel.org, andrew.jones@linux.dev, shan.gavin@gmail.com,
 bgardon@google.com, dmatlack@google.com, pbonzini@redhat.com,
 zhenyzha@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

ARM64 needs to dirty memory outside of a VCPU context when VGIC/ITS is
enabled. It's conflicting with that ring-based dirty page tracking always
requires a running VCPU context.

Introduce a new flavor of dirty ring that requires the use of both VCPU
dirty rings and a dirty bitmap. The expectation is that for non-VCPU
sources of dirty memory (such as the VGIC/ITS on arm64), KVM writes to
the dirty bitmap. Userspace should scan the dirty bitmap before migrating
the VM to the target.

Use an additional capability to advertise this behavior. The newly added
capability (KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP) can't be enabled before
KVM_CAP_DIRTY_LOG_RING_ACQ_REL on ARM64. In this way, the newly added
capability is treated as an extension of KVM_CAP_DIRTY_LOG_RING_ACQ_REL.

Suggested-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Peter Xu <peterx@redhat.com>
Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/virt/kvm/api.rst | 31 ++++++++++++++++++++++++-------
 include/linux/kvm_dirty_ring.h |  6 ++++++
 include/linux/kvm_host.h       |  1 +
 include/uapi/linux/kvm.h       |  1 +
 virt/kvm/Kconfig               |  8 ++++++++
 virt/kvm/dirty_ring.c          |  5 +++++
 virt/kvm/kvm_main.c            | 31 ++++++++++++++++++++++---------
 7 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index eee9f857a986..4d4eeb5c3c5a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8003,13 +8003,6 @@ flushing is done by the KVM_GET_DIRTY_LOG ioctl).  To achieve that, one
 needs to kick the vcpu out of KVM_RUN using a signal.  The resulting
 vmexit ensures that all dirty GFNs are flushed to the dirty rings.
 
-NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
-ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctls
-KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling
-KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual
-machine will switch to ring-buffer dirty page tracking and further
-KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
-
 NOTE: KVM_CAP_DIRTY_LOG_RING_ACQ_REL is the only capability that
 should be exposed by weakly ordered architecture, in order to indicate
 the additional memory ordering requirements imposed on userspace when
@@ -8018,6 +8011,30 @@ Architecture with TSO-like ordering (such as x86) are allowed to
 expose both KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL
 to userspace.
 
+After using the dirty rings, the userspace needs to detect the capability
+of KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring structures
+need to be backed by per-slot bitmaps. With this capability advertised
+and supported, it means the architecture can dirty guest pages without
+vcpu/ring context, so that some of the dirty information will still be
+maintained in the bitmap structure.
+
+Note that the bitmap here is only a backup of the ring structure, and
+normally should only contain a very small amount of dirty pages, which
+needs to be transferred during VM downtime. Collecting the dirty bitmap
+should be the very last thing that the VMM does before transmitting state
+to the target VM. VMM needs to ensure that the dirty state is final and
+avoid missing dirty pages from another ioctl ordered after the bitmap
+collection.
+
+To collect dirty bits in the backup bitmap, the userspace can use the
+same KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG shouldn't be needed
+and its behavior is undefined since collecting the dirty bitmap always
+happens in the last phase of VM's migration.
+
+NOTE: One example of using the backup bitmap is saving arm64 vgic/its
+tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
+KVM device "kvm-arm-vgic-its" during VM's migration.
+
 8.30 KVM_CAP_XEN_HVM
 --------------------
 
diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
index 04290eda0852..b08b9afd8bdb 100644
--- a/include/linux/kvm_dirty_ring.h
+++ b/include/linux/kvm_dirty_ring.h
@@ -37,6 +37,11 @@ static inline u32 kvm_dirty_ring_get_rsvd_entries(void)
 	return 0;
 }
 
+static inline bool kvm_use_dirty_bitmap(struct kvm *kvm)
+{
+	return true;
+}
+
 static inline int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring,
 				       int index, u32 size)
 {
@@ -66,6 +71,7 @@ static inline void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
 #else /* CONFIG_HAVE_KVM_DIRTY_RING */
 
 int kvm_cpu_dirty_log_size(void);
+bool kvm_use_dirty_bitmap(struct kvm *kvm);
 u32 kvm_dirty_ring_get_rsvd_entries(void);
 int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring, int index, u32 size);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 648d663f32c4..db83f63f4e61 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -779,6 +779,7 @@ struct kvm {
 	pid_t userspace_pid;
 	unsigned int max_halt_poll_ns;
 	u32 dirty_ring_size;
+	bool dirty_ring_with_bitmap;
 	bool vm_bugged;
 	bool vm_dead;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 0d5d4419139a..c87b5882d7ae 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1178,6 +1178,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_ZPCI_OP 221
 #define KVM_CAP_S390_CPU_TOPOLOGY 222
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
+#define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 224
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 800f9470e36b..228be1145cf3 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -33,6 +33,14 @@ config HAVE_KVM_DIRTY_RING_ACQ_REL
        bool
        select HAVE_KVM_DIRTY_RING
 
+# Only architectures that need to dirty memory outside of a vCPU
+# context should select this, advertising to userspace the
+# requirement to use a dirty bitmap in addition to the vCPU dirty
+# ring.
+config HAVE_KVM_DIRTY_RING_WITH_BITMAP
+	bool
+	depends on HAVE_KVM_DIRTY_RING
+
 config HAVE_KVM_EVENTFD
        bool
        select EVENTFD
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 6091e1403bc8..7ce6a5f81c98 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -21,6 +21,11 @@ u32 kvm_dirty_ring_get_rsvd_entries(void)
 	return KVM_DIRTY_RING_RSVD_ENTRIES + kvm_cpu_dirty_log_size();
 }
 
+bool kvm_use_dirty_bitmap(struct kvm *kvm)
+{
+	return !kvm->dirty_ring_size || kvm->dirty_ring_with_bitmap;
+}
+
 static u32 kvm_dirty_ring_used(struct kvm_dirty_ring *ring)
 {
 	return READ_ONCE(ring->dirty_index) - READ_ONCE(ring->reset_index);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 91cf51a25394..0351c8fb41b9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1617,7 +1617,7 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 			new->dirty_bitmap = NULL;
 		else if (old && old->dirty_bitmap)
 			new->dirty_bitmap = old->dirty_bitmap;
-		else if (!kvm->dirty_ring_size) {
+		else if (kvm_use_dirty_bitmap(kvm)) {
 			r = kvm_alloc_dirty_bitmap(new);
 			if (r)
 				return r;
@@ -2060,8 +2060,8 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
 	unsigned long n;
 	unsigned long any = 0;
 
-	/* Dirty ring tracking is exclusive to dirty log tracking */
-	if (kvm->dirty_ring_size)
+	/* Dirty ring tracking may be exclusive to dirty log tracking */
+	if (!kvm_use_dirty_bitmap(kvm))
 		return -ENXIO;
 
 	*memslot = NULL;
@@ -2125,8 +2125,8 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
-	/* Dirty ring tracking is exclusive to dirty log tracking */
-	if (kvm->dirty_ring_size)
+	/* Dirty ring tracking may be exclusive to dirty log tracking */
+	if (!kvm_use_dirty_bitmap(kvm))
 		return -ENXIO;
 
 	as_id = log->slot >> 16;
@@ -2237,8 +2237,8 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
 	unsigned long *dirty_bitmap_buffer;
 	bool flush;
 
-	/* Dirty ring tracking is exclusive to dirty log tracking */
-	if (kvm->dirty_ring_size)
+	/* Dirty ring tracking may be exclusive to dirty log tracking */
+	if (!kvm_use_dirty_bitmap(kvm))
 		return -ENXIO;
 
 	as_id = log->slot >> 16;
@@ -3305,7 +3305,10 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 
 #ifdef CONFIG_HAVE_KVM_DIRTY_RING
-	if (WARN_ON_ONCE(!vcpu) || WARN_ON_ONCE(vcpu->kvm != kvm))
+	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
+		return;
+
+	if (WARN_ON_ONCE(!kvm->dirty_ring_with_bitmap && !vcpu))
 		return;
 #endif
 
@@ -3313,7 +3316,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-		if (kvm->dirty_ring_size)
+		if (kvm->dirty_ring_size && vcpu)
 			kvm_dirty_ring_push(vcpu, slot, rel_gfn);
 		else
 			set_bit_le(rel_gfn, memslot->dirty_bitmap);
@@ -4482,6 +4485,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
 #else
 		return 0;
+#endif
+#ifdef CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP
+	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
 #endif
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
@@ -4588,6 +4594,13 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 			return -EINVAL;
 
 		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
+	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
+		if (!IS_ENABLED(CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP) ||
+		    !kvm->dirty_ring_size)
+			return -EINVAL;
+
+		kvm->dirty_ring_with_bitmap = true;
+		return 0;
 	default:
 		return kvm_vm_ioctl_enable_cap(kvm, cap);
 	}
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
