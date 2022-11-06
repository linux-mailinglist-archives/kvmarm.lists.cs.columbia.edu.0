Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1661E69E
	for <lists+kvmarm@lfdr.de>; Sun,  6 Nov 2022 22:41:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A34334B845;
	Sun,  6 Nov 2022 16:41:08 -0500 (EST)
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
	with ESMTP id 3gKi0i38-Qmb; Sun,  6 Nov 2022 16:41:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C02324B8BC;
	Sun,  6 Nov 2022 16:41:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C47E4B8B6
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 16:41:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dr7fb41GFr43 for <kvmarm@lists.cs.columbia.edu>;
 Sun,  6 Nov 2022 16:41:04 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EEDD4B8B5
 for <kvmarm@lists.cs.columbia.edu>; Sun,  6 Nov 2022 16:41:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667770864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/sUPTfrPCYaU9zT0hketoq5E3JtcXoIAyKwFdOjhvs=;
 b=OvTQHC/RWZLuWlTj3tUR2w5q4EyM0VtUcHgK0q7kQyL+EVHieMAM2Aa02krAff4P3hoDdS
 0HBIXGUoHHC1BAfLalx9EebvcFOAQfpSPKzwXHKsPaD7VMXFB+UlXdUa/SkZhG6dSmpE1O
 wwxWfWgOfZyb6dJtzuPdK3Yx6HAl4JE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-fauUv8zMN2Web--7K_9zyA-1; Sun, 06 Nov 2022 16:40:58 -0500
X-MC-Unique: fauUv8zMN2Web--7K_9zyA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E7903C0E211;
 Sun,  6 Nov 2022 21:40:58 +0000 (UTC)
Received: from [10.64.54.78] (vpn2-54-78.bne.redhat.com [10.64.54.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6734B3FC7;
 Sun,  6 Nov 2022 21:40:51 +0000 (UTC)
Subject: Re: [PATCH v8 3/7] KVM: Support dirty ring in conjunction with bitmap
To: Marc Zyngier <maz@kernel.org>
References: <20221104234049.25103-1-gshan@redhat.com>
 <20221104234049.25103-4-gshan@redhat.com> <87o7tkf5re.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <0f685682-ba39-53d4-766c-cc2b44ad48dc@redhat.com>
Date: Mon, 7 Nov 2022 05:40:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87o7tkf5re.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com, bgardon@google.com,
 kvmarm@lists.linux.dev, pbonzini@redhat.com, zhenyzha@redhat.com,
 shuah@kernel.org, kvmarm@lists.cs.columbia.edu, ajones@ventanamicro.com
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Marc,

On 11/6/22 11:43 PM, Marc Zyngier wrote:
> On Fri, 04 Nov 2022 23:40:45 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> ARM64 needs to dirty memory outside of a VCPU context when VGIC/ITS is
>> enabled. It's conflicting with that ring-based dirty page tracking always
>> requires a running VCPU context.
>>
>> Introduce a new flavor of dirty ring that requires the use of both VCPU
>> dirty rings and a dirty bitmap. The expectation is that for non-VCPU
>> sources of dirty memory (such as the VGIC/ITS on arm64), KVM writes to
>> the dirty bitmap. Userspace should scan the dirty bitmap before migrating
>> the VM to the target.
>>
>> Use an additional capability to advertise this behavior. The newly added
>> capability (KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP) can't be enabled before
>> KVM_CAP_DIRTY_LOG_RING_ACQ_REL on ARM64. In this way, the newly added
>> capability is treated as an extension of KVM_CAP_DIRTY_LOG_RING_ACQ_REL.
>>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
>> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> ---
>>   Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++-----
>>   include/linux/kvm_dirty_ring.h |  7 +++++
>>   include/linux/kvm_host.h       |  1 +
>>   include/uapi/linux/kvm.h       |  1 +
>>   virt/kvm/Kconfig               |  8 ++++++
>>   virt/kvm/dirty_ring.c          | 10 +++++++
>>   virt/kvm/kvm_main.c            | 49 +++++++++++++++++++++++++++-------
>>   7 files changed, 93 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index eee9f857a986..2ec32bd41792 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -8003,13 +8003,6 @@ flushing is done by the KVM_GET_DIRTY_LOG ioctl).  To achieve that, one
>>   needs to kick the vcpu out of KVM_RUN using a signal.  The resulting
>>   vmexit ensures that all dirty GFNs are flushed to the dirty rings.
>>   
>> -NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
>> -ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctls
>> -KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling
>> -KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual
>> -machine will switch to ring-buffer dirty page tracking and further
>> -KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
>> -
>>   NOTE: KVM_CAP_DIRTY_LOG_RING_ACQ_REL is the only capability that
>>   should be exposed by weakly ordered architecture, in order to indicate
>>   the additional memory ordering requirements imposed on userspace when
>> @@ -8018,6 +8011,32 @@ Architecture with TSO-like ordering (such as x86) are allowed to
>>   expose both KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>>   to userspace.
>>   
>> +After using the dirty rings, the userspace needs to detect the capability
> 
> using? or enabling? What comes after suggest the latter.
> 

s/using/enabling in next revision :)

>> +of KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring structures
>> +need to be backed by per-slot bitmaps. With this capability advertised
>> +and supported, it means the architecture can dirty guest pages without
> 
> If it is advertised, it is supported, right?
> 

Yes, s/advertised and supported/advertised in next revision.

>> +vcpu/ring context, so that some of the dirty information will still be
>> +maintained in the bitmap structure. KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP
>> +can't be enabled until the capability of KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>> +has been enabled.
>> +
>> +Note that the bitmap here is only a backup of the ring structure, and
>> +normally should only contain a very small amount of dirty pages, which
> 
> I don't think we can claim this. It is whatever amount of memory is
> dirtied outside of a vcpu context, and we shouldn't make any claim
> regarding the number of dirty pages.
> 

It's the pre-requisite to use the backup bitmap. Otherwise, the guest
will experience long down-time during migration, as mentioned by Peter
in another thread. So it's appropriate to mention the limit of dirty
pages here.

>> +needs to be transferred during VM downtime. Collecting the dirty bitmap
>> +should be the very last thing that the VMM does before transmitting state
>> +to the target VM. VMM needs to ensure that the dirty state is final and
>> +avoid missing dirty pages from another ioctl ordered after the bitmap
>> +collection.
>> +
>> +To collect dirty bits in the backup bitmap, the userspace can use the
>> +same KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG shouldn't be needed
>> +and its behavior is undefined since collecting the dirty bitmap always
>> +happens in the last phase of VM's migration.
> 
> It isn't clear to me why KVM_CLEAR_DIRTY_LOG should be called out. If
> you have multiple devices that dirty the memory, such as multiple
> ITSs, why shouldn't userspace be allowed to snapshot the dirty state
> multiple time? This doesn't seem like a reasonable restriction, and I
> really dislike the idea of undefined behaviour here.
> 

It was actually documenting the expected QEMU's usage. With QEMU
excluded, KVM_CLEAR_DIRTY_LOG can be used as usual. Undefined behavior
seems not precise here. We can improve it like below, to avoid talking
about 'undefined behaviour'.

   To collect dirty bits in the backup bitmap, the userspace can use the
   same KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG shouldn't be needed
   since collecting the dirty bitmap always happens in the last phase of
   VM's migration.

>> +
>> +NOTE: One example of using the backup bitmap is saving arm64 vgic/its
>> +tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
>> +KVM device "kvm-arm-vgic-its" during VM's migration.
> 
> It would be good to have something about this in the ITS
> documentation. Something along these lines:
> 
> diff --git a/Documentation/virt/kvm/devices/arm-vgic-its.rst b/Documentation/virt/kvm/devices/arm-vgic-its.rst
> index d257eddbae29..e053124f77c4 100644
> --- a/Documentation/virt/kvm/devices/arm-vgic-its.rst
> +++ b/Documentation/virt/kvm/devices/arm-vgic-its.rst
> @@ -52,7 +52,10 @@ KVM_DEV_ARM_VGIC_GRP_CTRL
>   
>       KVM_DEV_ARM_ITS_SAVE_TABLES
>         save the ITS table data into guest RAM, at the location provisioned
> -      by the guest in corresponding registers/table entries.
> +      by the guest in corresponding registers/table entries. Should userspace
> +      require a form of dirty tracking to identify which pages are modified
> +      by the saving process, it should use a bitmap even if using another
> +      mechanism to track the memory dirtied by the vCPUs.
>   
>         The layout of the tables in guest memory defines an ABI. The entries
>         are laid out in little endian format as described in the last paragraph.
> 

Sure, I will have it in next revision.

> 
>> +
>>   8.30 KVM_CAP_XEN_HVM
>>   --------------------
>>   
>> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
>> index 199ead37b104..4862c98d80d3 100644
>> --- a/include/linux/kvm_dirty_ring.h
>> +++ b/include/linux/kvm_dirty_ring.h
>> @@ -37,6 +37,11 @@ static inline u32 kvm_dirty_ring_get_rsvd_entries(void)
>>   	return 0;
>>   }
>>   
>> +static inline bool kvm_use_dirty_bitmap(struct kvm *kvm)
>> +{
>> +	return true;
>> +}
>> +
>>   static inline int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring,
>>   				       int index, u32 size)
>>   {
>> @@ -67,6 +72,8 @@ static inline void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
>>   #else /* CONFIG_HAVE_KVM_DIRTY_RING */
>>   
>>   int kvm_cpu_dirty_log_size(void);
>> +bool kvm_use_dirty_bitmap(struct kvm *kvm);
>> +bool kvm_arch_allow_write_without_running_vcpu(struct kvm *kvm);
>>   u32 kvm_dirty_ring_get_rsvd_entries(void);
>>   int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring, int index, u32 size);
>>   
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 6fab55e58111..f51eb9419bfc 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -779,6 +779,7 @@ struct kvm {
>>   	pid_t userspace_pid;
>>   	unsigned int max_halt_poll_ns;
>>   	u32 dirty_ring_size;
>> +	bool dirty_ring_with_bitmap;
>>   	bool vm_bugged;
>>   	bool vm_dead;
>>   
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 0d5d4419139a..c87b5882d7ae 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1178,6 +1178,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_S390_ZPCI_OP 221
>>   #define KVM_CAP_S390_CPU_TOPOLOGY 222
>>   #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
>> +#define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 224
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index 800f9470e36b..228be1145cf3 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -33,6 +33,14 @@ config HAVE_KVM_DIRTY_RING_ACQ_REL
>>          bool
>>          select HAVE_KVM_DIRTY_RING
>>   
>> +# Only architectures that need to dirty memory outside of a vCPU
>> +# context should select this, advertising to userspace the
>> +# requirement to use a dirty bitmap in addition to the vCPU dirty
>> +# ring.
>> +config HAVE_KVM_DIRTY_RING_WITH_BITMAP
>> +	bool
>> +	depends on HAVE_KVM_DIRTY_RING
>> +
>>   config HAVE_KVM_EVENTFD
>>          bool
>>          select EVENTFD
>> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
>> index fecbb7d75ad2..758679724447 100644
>> --- a/virt/kvm/dirty_ring.c
>> +++ b/virt/kvm/dirty_ring.c
>> @@ -21,6 +21,16 @@ u32 kvm_dirty_ring_get_rsvd_entries(void)
>>   	return KVM_DIRTY_RING_RSVD_ENTRIES + kvm_cpu_dirty_log_size();
>>   }
>>   
>> +bool kvm_use_dirty_bitmap(struct kvm *kvm)
>> +{
>> +	return !kvm->dirty_ring_size || kvm->dirty_ring_with_bitmap;
>> +}
>> +
>> +bool __weak kvm_arch_allow_write_without_running_vcpu(struct kvm *kvm)
>> +{
>> +	return false;
>> +}
>> +
>>   static u32 kvm_dirty_ring_used(struct kvm_dirty_ring *ring)
>>   {
>>   	return READ_ONCE(ring->dirty_index) - READ_ONCE(ring->reset_index);
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index c865d7d82685..746133b23a66 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1617,7 +1617,7 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
>>   			new->dirty_bitmap = NULL;
>>   		else if (old && old->dirty_bitmap)
>>   			new->dirty_bitmap = old->dirty_bitmap;
>> -		else if (!kvm->dirty_ring_size) {
>> +		else if (kvm_use_dirty_bitmap(kvm)) {
>>   			r = kvm_alloc_dirty_bitmap(new);
>>   			if (r)
>>   				return r;
>> @@ -2060,8 +2060,8 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
>>   	unsigned long n;
>>   	unsigned long any = 0;
>>   
>> -	/* Dirty ring tracking is exclusive to dirty log tracking */
>> -	if (kvm->dirty_ring_size)
>> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
>> +	if (!kvm_use_dirty_bitmap(kvm))
>>   		return -ENXIO;
>>   
>>   	*memslot = NULL;
>> @@ -2125,8 +2125,8 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
>>   	unsigned long *dirty_bitmap_buffer;
>>   	bool flush;
>>   
>> -	/* Dirty ring tracking is exclusive to dirty log tracking */
>> -	if (kvm->dirty_ring_size)
>> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
>> +	if (!kvm_use_dirty_bitmap(kvm))
>>   		return -ENXIO;
>>   
>>   	as_id = log->slot >> 16;
>> @@ -2237,8 +2237,8 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
>>   	unsigned long *dirty_bitmap_buffer;
>>   	bool flush;
>>   
>> -	/* Dirty ring tracking is exclusive to dirty log tracking */
>> -	if (kvm->dirty_ring_size)
>> +	/* Dirty ring tracking may be exclusive to dirty log tracking */
>> +	if (!kvm_use_dirty_bitmap(kvm))
>>   		return -ENXIO;
>>   
>>   	as_id = log->slot >> 16;
>> @@ -3305,7 +3305,10 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>>   	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
>>   
>>   #ifdef CONFIG_HAVE_KVM_DIRTY_RING
>> -	if (WARN_ON_ONCE(!vcpu) || WARN_ON_ONCE(vcpu->kvm != kvm))
>> +	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
>> +		return;
>> +
>> +	if (WARN_ON_ONCE(!kvm_arch_allow_write_without_running_vcpu(kvm) && !vcpu))
>>   		return;
>>   #endif
>>   
>> @@ -3313,7 +3316,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>>   		unsigned long rel_gfn = gfn - memslot->base_gfn;
>>   		u32 slot = (memslot->as_id << 16) | memslot->id;
>>   
>> -		if (kvm->dirty_ring_size)
>> +		if (kvm->dirty_ring_size && vcpu)
>>   			kvm_dirty_ring_push(vcpu, slot, rel_gfn);
>>   		else
>>   			set_bit_le(rel_gfn, memslot->dirty_bitmap);
>> @@ -4482,6 +4485,9 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>   		return KVM_DIRTY_RING_MAX_ENTRIES * sizeof(struct kvm_dirty_gfn);
>>   #else
>>   		return 0;
>> +#endif
>> +#ifdef CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP
>> +	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP:
>>   #endif
>>   	case KVM_CAP_BINARY_STATS_FD:
>>   	case KVM_CAP_SYSTEM_EVENT_DATA:
>> @@ -4588,6 +4594,31 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
>>   			return -EINVAL;
>>   
>>   		return kvm_vm_ioctl_enable_dirty_log_ring(kvm, cap->args[0]);
>> +	case KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP: {
>> +		struct kvm_memslots *slots;
>> +		int r = -EINVAL;
>> +
>> +		if (!IS_ENABLED(CONFIG_HAVE_KVM_DIRTY_RING_WITH_BITMAP) ||
>> +		    !kvm->dirty_ring_size)
>> +			return r;
>> +
>> +		mutex_lock(&kvm->slots_lock);
>> +
>> +		slots = kvm_memslots(kvm);
>> +
>> +		/*
>> +		 * Avoid a race between memslot creation and enabling the ring +
>> +		 * bitmap capability to guarantee that no memslots have been
>> +		 * created without a bitmap.
> 
> It should be called out in the documentation that this capability must
> be enabled before any memslot is created.
> 

Right, Will do in next revision.

>> +		 */
>> +		if (kvm_memslots_empty(slots)) {
>> +			kvm->dirty_ring_with_bitmap = cap->args[0];
>> +			r = 0;
>> +		}
>> +
>> +		mutex_unlock(&kvm->slots_lock);
>> +		return r;
>> +	}
>>   	default:
>>   		return kvm_vm_ioctl_enable_cap(kvm, cap);
>>   	}

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
