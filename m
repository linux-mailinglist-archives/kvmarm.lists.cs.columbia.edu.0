Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 184785E96D9
	for <lists+kvmarm@lfdr.de>; Mon, 26 Sep 2022 01:13:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A2FB4B82A;
	Sun, 25 Sep 2022 19:13:25 -0400 (EDT)
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
	with ESMTP id GEZwF2VO2MtJ; Sun, 25 Sep 2022 19:13:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EA4C4B742;
	Sun, 25 Sep 2022 19:13:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B34864B7A7
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Sep 2022 19:13:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLjida1FHIxz for <kvmarm@lists.cs.columbia.edu>;
 Sun, 25 Sep 2022 19:13:21 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 482824B742
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Sep 2022 19:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664147600;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1xfWTMlNXoCFlCXXQz/TykPklCAqfXl+VLDLyoYFLY=;
 b=YD13DlHK34pIDnFscE8D6/2+WmOYqiucP7kLCK5Kg/fojJv7tYpaAl0L7NrWs3fXS8Nu3E
 Twq0Y7nw5Nx5YobDR0LLGJKfkrPX7AJ70p2SZY5EOdj8sS14ar2Z+nfyofBJLT9RA12Zvn
 +WLrM1FxgZvWG1CmJ0u05y1WWCXkTkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-xLx6aq-wPImWYpBE0jsr5A-1; Sun, 25 Sep 2022 19:13:17 -0400
X-MC-Unique: xLx6aq-wPImWYpBE0jsr5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B153A101A528;
 Sun, 25 Sep 2022 23:13:16 +0000 (UTC)
Received: from [10.64.54.126] (vpn2-54-126.bne.redhat.com [10.64.54.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75BDB40C6EC2;
 Sun, 25 Sep 2022 23:13:11 +0000 (UTC)
Subject: Re: [PATCH v3 3/6] KVM: arm64: Enable ring-based dirty memory tracking
To: Marc Zyngier <maz@kernel.org>
References: <20220922003214.276736-1-gshan@redhat.com>
 <20220922003214.276736-4-gshan@redhat.com> <875yhcikmi.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <80962c69-8294-072b-a4aa-5ce7ac51eaff@redhat.com>
Date: Mon, 26 Sep 2022 09:13:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <875yhcikmi.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, andrew.jones@linux.dev,
 will@kernel.org, shan.gavin@gmail.com, bgardon@google.com, dmatlack@google.com,
 pbonzini@redhat.com, zhenyzha@redhat.com, shuah@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

On 9/25/22 6:27 AM, Marc Zyngier wrote:
> On Thu, 22 Sep 2022 01:32:11 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> This enables the ring-based dirty memory tracking on ARM64. The
>> feature is configured by CONFIG_HAVE_KVM_DIRTY_RING, detected and
>> enabled by KVM_CAP_DIRTY_LOG_RING. A ring buffer is created on every
>> VCPU when the feature is enabled. Each entry in the ring buffer is
>> described by 'struct kvm_dirty_gfn'.
>>
>> A ring buffer entry is pushed when a page becomes dirty on host,
>> and pulled by userspace after the ring buffer is mapped at physical
>> page offset KVM_DIRTY_LOG_PAGE_OFFSET. The specific VCPU is enforced
>> to exit if its ring buffer becomes softly full. Besides, the ring
>> buffer can be reset by ioctl command KVM_RESET_DIRTY_RINGS to release
>> those pulled ring buffer entries.
> 
> I think you can cut this message short. This description was useful
> when the feature was initially merged, but this is only a "plumb the
> damn thing" patch.
> 

Agreed. I will modify the changelog in v4 accordingly, thanks.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   Documentation/virt/kvm/api.rst    | 2 +-
>>   arch/arm64/include/uapi/asm/kvm.h | 1 +
>>   arch/arm64/kvm/Kconfig            | 1 +
>>   arch/arm64/kvm/arm.c              | 8 ++++++++
>>   4 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index abd7c32126ce..19fa1ac017ed 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -8022,7 +8022,7 @@ regardless of what has actually been exposed through the CPUID leaf.
>>   8.29 KVM_CAP_DIRTY_LOG_RING
>>   ---------------------------
>>   
>> -:Architectures: x86
>> +:Architectures: x86, arm64
>>   :Parameters: args[0] - size of the dirty log ring
>>   
>>   KVM is capable of tracking dirty memory using ring buffers that are
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 316917b98707..a7a857f1784d 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -43,6 +43,7 @@
>>   #define __KVM_HAVE_VCPU_EVENTS
>>   
>>   #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
>>   
>>   #define KVM_REG_SIZE(id)						\
>>   	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index 815cc118c675..0309b2d0f2da 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -32,6 +32,7 @@ menuconfig KVM
>>   	select KVM_VFIO
>>   	select HAVE_KVM_EVENTFD
>>   	select HAVE_KVM_IRQFD
>> +	select HAVE_KVM_DIRTY_RING
>>   	select HAVE_KVM_MSI
>>   	select HAVE_KVM_IRQCHIP
>>   	select HAVE_KVM_IRQ_ROUTING
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 2ff0ef62abad..76816f8e082b 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -747,6 +747,14 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>>   
>>   		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>>   			return kvm_vcpu_suspend(vcpu);
>> +
>> +		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
>> +		    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
>> +			kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
>> +			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>> +			trace_kvm_dirty_ring_exit(vcpu);
>> +			return 0;
>> +		}
> 
> This is *very* similar to the x86 code. Could we move it to common
> code? Something like the diff below, to be for most of it squashed
> into patch #1.
> 

Sure, the additional changes make sense to me. I will fold them to
PATCH[v4 1/6].

Thanks,
Gavin

> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 76816f8e082b..93a16cdbe163 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -748,13 +748,8 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>   		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>   			return kvm_vcpu_suspend(vcpu);
>   
> -		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
> -		    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
> -			kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
> -			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> -			trace_kvm_dirty_ring_exit(vcpu);
> +		if (kvm_dirty_ring_check_request(vcpu))
>   			return 0;
> -		}
>   	}
>   
>   	return 1;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index eb7d0d7654bb..48f2519b1db7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10249,11 +10249,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>   
>   	if (kvm_request_pending(vcpu)) {
>   		/* Forbid vmenter if vcpu dirty ring is soft-full */
> -		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
> -		    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
> -			kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
> -			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> -			trace_kvm_dirty_ring_exit(vcpu);
> +		if (kvm_dirty_ring_check_request(vcpu)) {
>   			r = 0;
>   			goto out;
>   		}
> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
> index 8c6755981c9b..6e484220adc0 100644
> --- a/include/linux/kvm_dirty_ring.h
> +++ b/include/linux/kvm_dirty_ring.h
> @@ -64,11 +64,6 @@ static inline void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
>   {
>   }
>   
> -static inline bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
> -{
> -	return true;
> -}
> -
>   #else /* CONFIG_HAVE_KVM_DIRTY_RING */
>   
>   int kvm_cpu_dirty_log_size(void);
> @@ -91,7 +86,7 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset);
>   struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset);
>   
>   void kvm_dirty_ring_free(struct kvm_dirty_ring *ring);
> -bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring);
> +bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu);
>   
>   #endif /* CONFIG_HAVE_KVM_DIRTY_RING */
>   
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 69c8c90d489d..436d7cded5bf 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -26,7 +26,7 @@ static u32 kvm_dirty_ring_used(struct kvm_dirty_ring *ring)
>   	return READ_ONCE(ring->dirty_index) - READ_ONCE(ring->reset_index);
>   }
>   
> -bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
> +static bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
>   {
>   	return kvm_dirty_ring_used(ring) >= ring->soft_limit;
>   }
> @@ -182,3 +182,16 @@ void kvm_dirty_ring_free(struct kvm_dirty_ring *ring)
>   	vfree(ring->dirty_gfns);
>   	ring->dirty_gfns = NULL;
>   }
> +
> +bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
> +	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
> +		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> +		trace_kvm_dirty_ring_exit(vcpu);
> +		return true;
> +	}
> +
> +	return false;
> +}
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
