Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D191603082
	for <lists+kvmarm@lfdr.de>; Tue, 18 Oct 2022 18:07:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A3D54B899;
	Tue, 18 Oct 2022 12:07:29 -0400 (EDT)
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
	with ESMTP id FN4NHfMUZ5Y9; Tue, 18 Oct 2022 12:07:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4F7A4B89E;
	Tue, 18 Oct 2022 12:07:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D098C4B892
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Oct 2022 12:07:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjFWidHLaE1u for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Oct 2022 12:07:25 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E84E4B898
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Oct 2022 12:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666109245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/4IezTDpOGm63hAFsqKlrBOErBQ6OQknUCltFLqInLY=;
 b=ErLPy0L7FKhuWlvE5yPAaWRxgA9Si628zErVOH6e8xesOa/sKGb7KzPfu8wLa2t0W/BWck
 larNLdq5ZhS/Lq58Gj2PiG5/qdkus+CjFjnoj8LYcwB3j7046lmhjs/nK3LzKt8DbCIyJY
 DWUF8Bb5p4YxrqyUQwwME525AZgwQkM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-hh-KlZE-M2-xyskiKND5qw-1; Tue, 18 Oct 2022 12:07:23 -0400
X-MC-Unique: hh-KlZE-M2-xyskiKND5qw-1
Received: by mail-io1-f69.google.com with SMTP id
 w16-20020a6b4a10000000b006a5454c789eso10094584iob.20
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Oct 2022 09:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4IezTDpOGm63hAFsqKlrBOErBQ6OQknUCltFLqInLY=;
 b=YPJOgPf212tyPmIFAxgwkGuc0YZuVc9qtKQhHq5YCc5sPbfL7lxVe3BlEsc+ByYnTt
 K6PsJfCuext2VHiAclH3LJ61jlp+i/uRzkYFc1Ze8qbtuiRE+YLugeVQKwpI6+6GhfXm
 vhtWaPiNedpdmcdl5HkqSa3AnlHoo9XmG1TpgnZarFITYVIvD03aMRVvhMHl9N4mI/M2
 CwlcDKlP012ysf9aQuzfNxqCXs17bB7lAQFVRVyqnq8bEFeq18UIThu2hJAXXqqpFA8F
 e8KhDnODGcFQBFfhhbpbp6XVtVFWyiv6PYxMH//IvPCDTupFWNJaiTRtmzTiPFDrgt/f
 mDHg==
X-Gm-Message-State: ACrzQf2vCQ8RXmFcyO54rDJDqZ3mEKTjFx4/cuRJp0I0lSZ6Dn3MOa9e
 z71x1Lj9l4GEm2f4JGhg5MH2fW2T0cF+Yc4chE37VaZktWVms6M1tEph9BDldc5HnKw6ZYAa6gH
 tcXnyH7JA6xdDXb3DRg6gQ3PJ
X-Received: by 2002:a92:cb88:0:b0:2fc:1695:df02 with SMTP id
 z8-20020a92cb88000000b002fc1695df02mr2164724ilo.92.1666109242439; 
 Tue, 18 Oct 2022 09:07:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4JMp+NNWugpIxINcZnJ2HYFLuIOtSi/1KF/IuFRvtuSHgkXjV+PGM4bGNzO0SrMQyJgpkn3A==
X-Received: by 2002:a92:cb88:0:b0:2fc:1695:df02 with SMTP id
 z8-20020a92cb88000000b002fc1695df02mr2164698ilo.92.1666109241979; 
 Tue, 18 Oct 2022 09:07:21 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca.
 [70.31.27.79]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00363faa1ea9asm1194738jap.15.2022.10.18.09.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 09:07:21 -0700 (PDT)
Date: Tue, 18 Oct 2022 12:07:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 3/8] KVM: Add support for using dirty ring in
 conjunction with bitmap
Message-ID: <Y07PNJZ+RJrWxDUP@x1n>
References: <20221011061447.131531-1-gshan@redhat.com>
 <20221011061447.131531-4-gshan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221011061447.131531-4-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shuah@kernel.org, kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, dmatlack@google.com, shan.gavin@gmail.com,
 catalin.marinas@arm.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Tue, Oct 11, 2022 at 02:14:42PM +0800, Gavin Shan wrote:
> Some architectures (such as arm64) need to dirty memory outside of the
> context of a vCPU. Of course, this simply doesn't fit with the UAPI of
> KVM's per-vCPU dirty ring.
> 
> Introduce a new flavor of dirty ring that requires the use of both vCPU
> dirty rings and a dirty bitmap. The expectation is that for non-vCPU
> sources of dirty memory (such as the GIC ITS on arm64), KVM writes to
> the dirty bitmap. Userspace should scan the dirty bitmap before
> migrating the VM to the target.
> 
> Use an additional capability to advertize this behavior and require
> explicit opt-in to avoid breaking the existing dirty ring ABI. And yes,
> you can use this with your preferred flavor of DIRTY_RING[_ACQ_REL]. Do
> not allow userspace to enable dirty ring if it hasn't also enabled the
> ring && bitmap capability, as a VM is likely DOA without the pages
> marked in the bitmap.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst | 17 ++++++++---------
>  include/linux/kvm_dirty_ring.h |  6 ++++++
>  include/linux/kvm_host.h       |  1 +
>  include/uapi/linux/kvm.h       |  1 +
>  virt/kvm/Kconfig               |  8 ++++++++
>  virt/kvm/dirty_ring.c          |  5 +++++
>  virt/kvm/kvm_main.c            | 34 +++++++++++++++++++++++++---------
>  7 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 32427ea160df..09fa6c491c1b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8019,8 +8019,8 @@ guest according to the bits in the KVM_CPUID_FEATURES CPUID leaf
>  (0x40000001). Otherwise, a guest may use the paravirtual features
>  regardless of what has actually been exposed through the CPUID leaf.
>  
> -8.29 KVM_CAP_DIRTY_LOG_RING/KVM_CAP_DIRTY_LOG_RING_ACQ_REL
> -----------------------------------------------------------
> +8.29 KVM_CAP_DIRTY_LOG_{RING, RING_ACQ_REL, RING_WITH_BITMAP}

Shall we open a new section for RING_WITH_BITMAP?  Otherwise here it still
looks like these are three options for the rings.

Perhaps RING_WITH_BITMAP doesn't worth a section at all, so we can avoid
mentioning it here to avoid confusing.

> +-------------------------------------------------------------
>  
>  :Architectures: x86
>  :Parameters: args[0] - size of the dirty log ring
> @@ -8104,13 +8104,6 @@ flushing is done by the KVM_GET_DIRTY_LOG ioctl).  To achieve that, one
>  needs to kick the vcpu out of KVM_RUN using a signal.  The resulting
>  vmexit ensures that all dirty GFNs are flushed to the dirty rings.
>  
> -NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
> -ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctls
> -KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling
> -KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual
> -machine will switch to ring-buffer dirty page tracking and further
> -KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
> -
>  NOTE: KVM_CAP_DIRTY_LOG_RING_ACQ_REL is the only capability that
>  should be exposed by weakly ordered architecture, in order to indicate
>  the additional memory ordering requirements imposed on userspace when
> @@ -8119,6 +8112,12 @@ Architecture with TSO-like ordering (such as x86) are allowed to
>  expose both KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>  to userspace.
>  
> +NOTE: There is no running vcpu and available vcpu dirty ring when pages

IMHO it'll be great to start with something like below to describe the
userspace's responsibility to proactively detect the WITH_BITMAP cap:

  Before using the dirty rings, the userspace needs to detect the cap of
  KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring structures
  need to be backed by per-slot bitmaps.

  When KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP returns 1, it means the arch can
  dirty guest pages without vcpu/ring context, so that some of the dirty
  information will still be maintained in the bitmap structure.

  Note that the bitmap here is only a backup of the ring structure, and it
  doesn't need to be collected until the final switch-over of migration
  process.  Normally the bitmap should only contain a very small amount of
  dirty pages only, which needs to be transferred during VM downtime.

  To collect dirty bits in the backup bitmap, the userspace can use the
  same KVM_GET_DIRTY_LOG ioctl.  Since it's always the last phase of
  migration that needs the fetching of dirty bitmap, KVM_CLEAR_DIRTY_LOG
  ioctl should not be needed in this case and its behavior undefined.

That's how I understand this new cap, but let me know if you think any of
above is inproper.

> +becomes dirty in some cases. One example is to save arm64's vgic/its
> +tables during migration.

Nit: it'll be great to mention the exact arm ioctl here just in case anyone
would like to further reference the code.

> The dirty bitmap is still used to track those
> +dirty pages, indicated by KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP. The ditry
> +bitmap is visited by KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG ioctls.
> +
>  8.30 KVM_CAP_XEN_HVM
>  --------------------
>  
> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> index fe5982b46424..23b2b466aa0f 100644
> --- a/include/linux/kvm_dirty_ring.h
> +++ b/include/linux/kvm_dirty_ring.h
> @@ -28,6 +28,11 @@ struct kvm_dirty_ring {
>  };
>  
>  #ifndef CONFIG_HAVE_KVM_DIRTY_RING
> +static inline bool kvm_dirty_ring_exclusive(struct kvm *kvm)
> +{
> +	return false;
> +}
> +
>  /*
>   * If CONFIG_HAVE_HVM_DIRTY_RING not defined, kvm_dirty_ring.o should
>   * not be included as well, so define these nop functions for the arch.
> @@ -66,6 +71,7 @@ static inline void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
>  
>  #else /* CONFIG_HAVE_KVM_DIRTY_RING */
>  
> +bool kvm_dirty_ring_exclusive(struct kvm *kvm);
>  int kvm_cpu_dirty_log_size(void);
>  u32 kvm_dirty_ring_get_rsvd_entries(void);
>  int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring, int index, u32 size);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 53fa3134fee0..a3fae111f25c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -780,6 +780,7 @@ struct kvm {
>  	pid_t userspace_pid;
>  	unsigned int max_halt_poll_ns;
>  	u32 dirty_ring_size;
> +	bool dirty_ring_with_bitmap;
>  	bool vm_bugged;
>  	bool vm_dead;
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 0d5d4419139a..c87b5882d7ae 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1178,6 +1178,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_ZPCI_OP 221
>  #define KVM_CAP_S390_CPU_TOPOLOGY 222
>  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
> +#define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 224
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 800f9470e36b..228be1145cf3 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -33,6 +33,14 @@ config HAVE_KVM_DIRTY_RING_ACQ_REL
>         bool
>         select HAVE_KVM_DIRTY_RING
>  
> +# Only architectures that need to dirty memory outside of a vCPU
> +# context should select this, advertising to userspace the
> +# requirement to use a dirty bitmap in addition to the vCPU dirty
> +# ring.
> +config HAVE_KVM_DIRTY_RING_WITH_BITMAP
> +	bool
> +	depends on HAVE_KVM_DIRTY_RING
> +
>  config HAVE_KVM_EVENTFD
>         bool
>         select EVENTFD
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index f68d75026bc0..9cc60af291ef 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -11,6 +11,11 @@
>  #include <trace/events/kvm.h>
>  #include "kvm_mm.h"
>  
> +bool kvm_dirty_ring_exclusive(struct kvm *kvm)
> +{
> +	return kvm->dirty_ring_size && !kvm->dirty_ring_with_bitmap;
> +}
> +
>  int __weak kvm_cpu_dirty_log_size(void)
>  {
>  	return 0;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5b064dbadaf4..8915dcefcefd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1617,7 +1617,7 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>  			new->dirty_bitmap = NULL;
>  		else if (old && old->dirty_bitmap)
>  			new->dirty_bitmap = old->dirty_bitmap;
> -		else if (!kvm->dirty_ring_size) {
> +		else if (!kvm_dirty_ring_exclusive(kvm)) {
>  			r = kvm_alloc_dirty_bitmap(new);
>  			if (r)
>  				return r;
> @@ -2060,8 +2060,8 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
>  	unsigned long n;
>  	unsigned long any = 0;
>  
> -	/* Dirty ring tracking is exclusive to dirty log tracking */
> -	if (kvm->dirty_ring_size)
> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
> +	if (kvm_dirty_ring_exclusive(kvm))
>  		return -ENXIO;
>  
>  	*memslot = NULL;
> @@ -2125,8 +2125,8 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
>  	unsigned long *dirty_bitmap_buffer;
>  	bool flush;
>  
> -	/* Dirty ring tracking is exclusive to dirty log tracking */
> -	if (kvm->dirty_ring_size)
> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
> +	if (kvm_dirty_ring_exclusive(kvm))
>  		return -ENXIO;
>  
>  	as_id = log->slot >> 16;
> @@ -2237,8 +2237,8 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  	unsigned long *dirty_bitmap_buffer;
>  	bool flush;
>  
> -	/* Dirty ring tracking is exclusive to dirty log tracking */
> -	if (kvm->dirty_ring_size)
> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
> +	if (kvm_dirty_ring_exclusive(kvm))
>  		return -ENXIO;
>  
>  	as_id = log->slot >> 16;
> @@ -3305,15 +3305,20 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>  	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>  
>  #ifdef CONFIG_HAVE_KVM_DIRTY_RING
> -	if (WARN_ON_ONCE(!vcpu) || WARN_ON_ONCE(vcpu->kvm != kvm))
> +	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
>  		return;
> +
> +#ifndef CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP
> +	if (WARN_ON_ONCE(!vcpu))
> +		return;
> +#endif
>  #endif
>  
>  	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
>  		unsigned long rel_gfn = gfn - memslot->base_gfn;
>  		u32 slot = (memslot->as_id << 16) | memslot->id;
>  
> -		if (kvm->dirty_ring_size)
> +		if (vcpu && kvm->dirty_ring_size)
>  			kvm_dirty_ring_push(&vcpu->dirty_ring,
>  					    slot, rel_gfn);
>  		else
> @@ -4485,6 +4490,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
>  #else
>  		return 0;
> +#endif
> +#ifdef CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP
> +	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
>  #endif
>  	case KVM_CAP_BINARY_STATS_FD:
>  	case KVM_CAP_SYSTEM_EVENT_DATA:
> @@ -4499,6 +4507,11 @@ static int kvm_vm_ioctl_enable_dirty_log_ring(struct kvm *kvm, u32 size)
>  {
>  	int r;
>  
> +#ifdef CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP
> +	if (!kvm->dirty_ring_with_bitmap)
> +		return -EINVAL;
> +#endif
> +
>  	if (!KVM_DIRTY_LOG_PAGE_OFFSET)
>  		return -EINVAL;
>  
> @@ -4588,6 +4601,9 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
>  	case KVM_CAP_DIRTY_LOG_RING:
>  	case KVM_CAP_DIRTY_LOG_RING_ACQ_REL:
>  		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
> +	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
> +		kvm->dirty_ring_with_bitmap = true;

IIUC what Oliver wanted to suggest is we can avoid enabling of this cap,
then we don't need dirty_ring_with_bitmap field but instead we can check
against CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP when needed.

I think that'll make sense, because without the bitmap the ring won't work
with arm64, so not valid to not enable it at all.  But good to double check
with Oliver too.

The rest looks good to me, thanks,

> +		return 0;
>  	default:
>  		return kvm_vm_ioctl_enable_cap(kvm, cap);
>  	}
> -- 
> 2.23.0
> 

-- 
Peter Xu

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
