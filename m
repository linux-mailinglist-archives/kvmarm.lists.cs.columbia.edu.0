Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE695E96D6
	for <lists+kvmarm@lfdr.de>; Mon, 26 Sep 2022 01:09:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D962E4B82E;
	Sun, 25 Sep 2022 19:09:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TFWerZI1es7; Sun, 25 Sep 2022 19:09:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79C1A4B81B;
	Sun, 25 Sep 2022 19:09:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 201CB4B7A7
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Sep 2022 19:09:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AYUhxHKfCT-h for <kvmarm@lists.cs.columbia.edu>;
 Sun, 25 Sep 2022 19:09:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B36B34B643
 for <kvmarm@lists.cs.columbia.edu>; Sun, 25 Sep 2022 19:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664147389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IW1g6WDrq/4l4r2f8avVv1mAAh4KMUV/pSn5otI3ocI=;
 b=MQ8EtiiQvjtX2HmRa+eU04yMqoeFOq9YuHgTN+fs8u5AD96txC5KTuk9Hhb4reRF6NMN66
 8fHPGBVwliWEq6/T+RlHESS+v0XwIbQ4ecCXHD+3Rhi0Z2g2MpNrNW3Umr183Balw0dkwR
 vaqFPqA+3P36Yp84nRkyMRD2ZKGRZbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-3i_M6GaLNHCbihdAzr9C5A-1; Sun, 25 Sep 2022 19:09:44 -0400
X-MC-Unique: 3i_M6GaLNHCbihdAzr9C5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41A0681172A;
 Sun, 25 Sep 2022 23:09:44 +0000 (UTC)
Received: from [10.64.54.126] (vpn2-54-126.bne.redhat.com [10.64.54.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADA662166B26;
 Sun, 25 Sep 2022 23:09:38 +0000 (UTC)
Subject: Re: [PATCH v3 2/6] KVM: x86: Move declaration of
 kvm_cpu_dirty_log_size() to kvm_dirty_ring.h
To: Marc Zyngier <maz@kernel.org>
References: <20220922003214.276736-1-gshan@redhat.com>
 <20220922003214.276736-3-gshan@redhat.com> <877d1sio31.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <b226886c-3fc3-8f31-2e91-c4a6e1865097@redhat.com>
Date: Mon, 26 Sep 2022 09:09:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <877d1sio31.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 9/25/22 5:12 AM, Marc Zyngier wrote:
> On Thu, 22 Sep 2022 01:32:10 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> Not all architectures like ARM64 need to override the function. Move
>> its declaration to kvm_dirty_ring.h to avoid the following compiling
>> warning on ARM64 when the feature is enabled.
>>
>>    arch/arm64/kvm/../../../virt/kvm/dirty_ring.c:14:12:        \
>>    warning: no previous prototype for 'kvm_cpu_dirty_log_size' \
>>    [-Wmissing-prototypes]                                      \
>>    int __weak kvm_cpu_dirty_log_size(void)
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/x86/include/asm/kvm_host.h | 2 --
>>   arch/x86/kvm/mmu/mmu.c          | 2 ++
>>   include/linux/kvm_dirty_ring.h  | 1 +
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 2c96c43c313a..4c0fd517282b 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -2082,8 +2082,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
>>   #define GET_SMSTATE(type, buf, offset)		\
>>   	(*(type *)((buf) + (offset) - 0x7e00))
>>   
>> -int kvm_cpu_dirty_log_size(void);
>> -
>>   int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
>>   
>>   #define KVM_CLOCK_VALID_FLAGS						\
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index e418ef3ecfcb..b3eb6a3627ec 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -1349,10 +1349,12 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>>   		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
>>   }
>>   
>> +#ifdef CONFIG_HAVE_KVM_DIRTY_RING
> 
> I think you can drop the ifdeffery, as HAVE_KVM_DIRTY_RING is
> unconditionally selected by the arch Kconfig.
> 

Yeah, I think so. Lets drop it in v4, which will be rebased on top
of your v2 series.

>>   int kvm_cpu_dirty_log_size(void)
>>   {
>>   	return kvm_x86_ops.cpu_dirty_log_size;
>>   }
>> +#endif
>>   
>>   bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
>>   				    struct kvm_memory_slot *slot, u64 gfn,
>> diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
>> index 906f899813dc..8c6755981c9b 100644
>> --- a/include/linux/kvm_dirty_ring.h
>> +++ b/include/linux/kvm_dirty_ring.h
>> @@ -71,6 +71,7 @@ static inline bool kvm_dirty_ring_soft_full(struct kvm_dirty_ring *ring)
>>   
>>   #else /* CONFIG_HAVE_KVM_DIRTY_RING */
>>   
>> +int kvm_cpu_dirty_log_size(void);
>>   u32 kvm_dirty_ring_get_rsvd_entries(void);
>>   int kvm_dirty_ring_alloc(struct kvm_dirty_ring *ring, int index, u32 size);
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
