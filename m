Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 713165FA9BF
	for <lists+kvmarm@lfdr.de>; Tue, 11 Oct 2022 03:12:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B976D4B090;
	Mon, 10 Oct 2022 21:12:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoEsG1+Me950; Mon, 10 Oct 2022 21:12:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85B9B4B3C0;
	Mon, 10 Oct 2022 21:12:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 41764403FD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:12:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D4aZmnIrceKj for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Oct 2022 21:12:50 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6532A402A9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Oct 2022 21:12:50 -0400 (EDT)
Date: Tue, 11 Oct 2022 01:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1665450768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Smci9Y405ivf2bH8VKuzQURzFPeJEpTQ7/p/5IfFDLY=;
 b=wi7gWFuCuvXZ2pndTXsrP7ftEPXDBJo6oCygbILAwkemEEYc9D2n2+2FxVbiEmYEPwawlo
 GrxVkAjABuAcBELBK9IsXyU+macMBnVt7xRx+awt3Qqm2DqG38M3OocG4KiDs7NjWHNOwr
 388OmcCpxjMFnqs98v6flA7A5Tifv6M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 3/7] KVM: x86: Allow to use bitmap in ring-based dirty
 page tracking
Message-ID: <Y0TDCxfVVme8uPGU@google.com>
References: <20221005004154.83502-1-gshan@redhat.com>
 <20221005004154.83502-4-gshan@redhat.com> <Yz86gEbNflDpC8As@x1n>
 <a5e291b9-e862-7c71-3617-1620d5a7d407@redhat.com>
 <Y0A4VaSwllsSrVxT@x1n> <Y0SoX2/E828mbxuf@google.com>
 <Y0SvexjbHN78XVcq@xz-m1.local> <Y0SxnoT5u7+1TCT+@google.com>
 <Y0S2zY4G7jBxVgpu@xz-m1.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GuCVujXhiBanzTUQ"
Content-Disposition: inline
In-Reply-To: <Y0S2zY4G7jBxVgpu@xz-m1.local>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com, bgardon@google.com,
 kvmarm@lists.linux.dev, pbonzini@redhat.com, zhenyzha@redhat.com,
 shuah@kernel.org, kvmarm@lists.cs.columbia.edu
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
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--GuCVujXhiBanzTUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 10, 2022 at 08:20:29PM -0400, Peter Xu wrote:
> On Mon, Oct 10, 2022 at 11:58:22PM +0000, Oliver Upton wrote:
> > I think this further drives the point home -- there's zero need for the
> > bitmap with dirty ring on x86, so why even support it? The proposal of
> > ALLOW_BITMAP && DIRTY_RING should be arm64-specific. Any other arch that
> > needs to dirty memory outside of a vCPU context can opt-in to the
> > behavior.
> 
> Yeah that sounds working too, but it'll be slightly hackish as then the
> user app will need some "#ifdef ARM64" blocks for e.g. sync dirty bitmap.
> With the new cap the user app can implement the whole ring with generic
> code.

Isn't the current route of exposing ALLOW_BITMAP on other arches for no
reason headed in exactly that direction? Userspace would need to know if
it _really_ needs the dirty bitmap in addition to the dirty ring, which
could take the form of architecture ifdeffery.

OTOH, if the cap is only exposed when it is absolutely necessary, an
arch-generic live migration implementation could enable the cap whenever
it is advertized and scan the bitmap accordingly.

The VMM must know something about the architecture it is running on, as
it calls KVM_DEV_ARM_ITS_SAVE_TABLES after all...

> Also more flexible to expose it as generic cap? E.g., one day x86 can
> enable this too for whatever reason (even though I don't think so..).

I had imagined something like this patch where the arch opts-in to some
generic construct if it *requires* the use of both the ring and bitmap
(very rough sketch).

--
Thanks,
Oliver

--GuCVujXhiBanzTUQ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-KVM-Add-support-for-using-dirty-ring-in-conjuction-w.patch"

From ec2fd1ec35b040ac5446f10b895b72d45e0d2845 Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Tue, 11 Oct 2022 00:57:00 +0000
Subject: [PATCH] KVM: Add support for using dirty ring in conjuction with
 bitmap

Some architectures (such as arm64) need to dirty memory outside of the
context of a vCPU. Of course, this simply doesn't fit with the UAPI of
KVM's per-vCPU dirty ring.

Introduce a new flavor of dirty ring that requires the use of both vCPU
dirty rings and a dirty bitmap. The expectation is that for non-vCPU
sources of dirty memory (such as the GIC ITS on arm64), KVM writes to
the dirty bitmap. Userspace should scan the dirty bitmap before
migrating the VM to the target.

Use an additional capability to advertize this behavior and require
explicit opt-in to avoid breaking the existing dirty ring ABI. And yes,
you can use this with your preferred flavor of DIRTY_RING[_ACQ_REL]. Do
not allow userspace to enable dirty ring if it hasn't also enabled the
ring && bitmap capability, as a VM is likely DOA without the pages
marked in the bitmap.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 include/linux/kvm_host.h |  1 +
 include/uapi/linux/kvm.h |  1 +
 virt/kvm/Kconfig         |  8 ++++++++
 virt/kvm/kvm_main.c      | 16 ++++++++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f4519d3689e1..76a6b1687312 100644
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
index 800f9470e36b..e3b45a5489b6 100644
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
+       bool
+       depends on HAVE_KVM_DIRTY_RING
+
 config HAVE_KVM_EVENTFD
        bool
        select EVENTFD
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5b064dbadaf4..5a99ab973706 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3304,7 +3304,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 
-#ifdef CONFIG_HAVE_KVM_DIRTY_RING
+#if defined(CONFIG_HAVE_KVM_DIRTY_RING) && !defined(CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP)
 	if (WARN_ON_ONCE(!vcpu) || WARN_ON_ONCE(vcpu->kvm != kvm))
 		return;
 #endif
@@ -3313,7 +3313,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-		if (kvm->dirty_ring_size)
+		if (vcpu && kvm->dirty_ring_size)
 			kvm_dirty_ring_push(&vcpu->dirty_ring,
 					    slot, rel_gfn);
 		else
@@ -4488,6 +4488,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #endif
 	case KVM_CAP_BINARY_STATS_FD:
 	case KVM_CAP_SYSTEM_EVENT_DATA:
+#ifdef CONFIG_HAVE_KVM_DIRTY_RING_ENABLE_BITMAP
+	case KVM_CAP_DIRTY_LOG_RING_ENABLE_BITMAP:
+#endif
 		return 1;
 	default:
 		break;
@@ -4499,6 +4502,11 @@ static int kvm_vm_ioctl_enable_dirty_log_ring(struct kvm *kvm, u32 size)
 {
 	int r;
 
+#ifdef CONFIG_HAVE_DIRTY_RING_WITH_BITMAP
+	if (!kvm->dirty_ring_with_bitmap)
+		return -EINVAL;
+#endif
+
 	if (!KVM_DIRTY_LOG_PAGE_OFFSET)
 		return -EINVAL;
 
@@ -4588,6 +4596,10 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 	case KVM_CAP_DIRTY_LOG_RING:
 	case KVM_CAP_DIRTY_LOG_RING_ACQ_REL:
 		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
+	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
+		kvm->dirty_ring_with_bitmap = cap->args[0];
+
+		return 0;
 	default:
 		return kvm_vm_ioctl_enable_cap(kvm, cap);
 	}
-- 
2.38.0.rc1.362.ged0d419d3c-goog


--GuCVujXhiBanzTUQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--GuCVujXhiBanzTUQ--
