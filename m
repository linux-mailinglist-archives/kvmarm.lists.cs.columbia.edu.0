Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6F48D2FE
	for <lists+kvmarm@lfdr.de>; Thu, 13 Jan 2022 08:39:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44D764B125;
	Thu, 13 Jan 2022 02:39:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBat2RchV1QG; Thu, 13 Jan 2022 02:39:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6EFA4A1D9;
	Thu, 13 Jan 2022 02:39:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AB804A1D9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 02:39:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 83kX+kvARXRU for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Jan 2022 02:39:01 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E791949F28
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Jan 2022 02:39:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642059541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdLpJvNEkB5EtIgJu5Fk+IznHpl1+RfhPzWuZl70/Hw=;
 b=QWQgYhXSWbDIOP8mkSdExQOpDZB3eAfwmTPNd4ZP4M/RRZOa2HsUUVJeZFfTm/H5rxPezH
 G7NF63byRn9V3yIf9R3HvNikrI6Gb2ragx/oTzmX4JoOzZOHc/rbMje1J+yzEvBDqD1y+l
 cMdz9H+rQEswhmeB1nlEMb4fhYf37uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-b7TpizchPdur0bTQEXW4CQ-1; Thu, 13 Jan 2022 02:38:55 -0500
X-MC-Unique: b7TpizchPdur0bTQEXW4CQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7CD100C61F;
 Thu, 13 Jan 2022 07:38:54 +0000 (UTC)
Received: from [10.72.13.202] (ovpn-13-202.pek2.redhat.com [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 366B44EC7F;
 Thu, 13 Jan 2022 07:38:46 +0000 (UTC)
Subject: Re: [PATCH v4 02/15] KVM: async_pf: Add helper function to check
 completion queue
To: Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815005947.83699-1-gshan@redhat.com>
 <20210815005947.83699-3-gshan@redhat.com>
 <56d8dbec-a8fd-b109-0c0f-b01c1aef4741@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <2543ace0-444a-7777-460b-c3eab9eb612a@redhat.com>
Date: Thu, 13 Jan 2022 15:38:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <56d8dbec-a8fd-b109-0c0f-b01c1aef4741@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org
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

Hi Eric,

On 11/10/21 11:37 PM, Eric Auger wrote:
> On 8/15/21 2:59 AM, Gavin Shan wrote:
>> This adds inline helper kvm_check_async_pf_completion_queue() to
>> check if there are pending completion in the queue. The empty stub
>> is also added on !CONFIG_KVM_ASYNC_PF so that the caller needn't
>> consider if CONFIG_KVM_ASYNC_PF is enabled.
>>
>> All checks on the completion queue is done by the newly added inline
>> function since list_empty() and list_empty_careful() are interchangeable.
> why is it interchangeable?
>

I think the commit log is misleading. list_empty_careful() is more strict
than list_empty(). In this patch, we replace list_empty() with list_empty_careful().
I will correct the commit log in next respin like below:

    All checks on the completion queue is done by the newly added inline
    function where list_empty_careful() instead of list_empty() is used.
  
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/x86/kvm/x86.c       |  2 +-
>>   include/linux/kvm_host.h | 10 ++++++++++
>>   virt/kvm/async_pf.c      | 10 +++++-----
>>   virt/kvm/kvm_main.c      |  4 +---
>>   4 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index e5d5c5ed7dd4..7f35d9324b99 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -11591,7 +11591,7 @@ static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
>>   
>>   static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
>>   {
>> -	if (!list_empty_careful(&vcpu->async_pf.done))
>> +	if (kvm_check_async_pf_completion_queue(vcpu))
>>   		return true;
>>   
>>   	if (kvm_apic_has_events(vcpu))
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 85b61a456f1c..a5f990f6dc35 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -339,12 +339,22 @@ struct kvm_async_pf {
>>   	bool				notpresent_injected;
>>   };
>>   
>> +static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
>> +{
>> +	return !list_empty_careful(&vcpu->async_pf.done);
>> +}
>> +
>>   void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
>>   void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
>>   bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>>   			unsigned long hva, struct kvm_arch_async_pf *arch);
>>   int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>>   #else
>> +static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
>> +
>>   static inline void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu) { }
>>   #endif
>>   
>> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
>> index dd777688d14a..d145a61a046a 100644
>> --- a/virt/kvm/async_pf.c
>> +++ b/virt/kvm/async_pf.c
>> @@ -70,7 +70,7 @@ static void async_pf_execute(struct work_struct *work)
>>   		kvm_arch_async_page_present(vcpu, apf);
>>   
>>   	spin_lock(&vcpu->async_pf.lock);
>> -	first = list_empty(&vcpu->async_pf.done);
>> +	first = !kvm_check_async_pf_completion_queue(vcpu);
>>   	list_add_tail(&apf->link, &vcpu->async_pf.done);
>>   	apf->vcpu = NULL;
>>   	spin_unlock(&vcpu->async_pf.lock);
>> @@ -122,7 +122,7 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
>>   		spin_lock(&vcpu->async_pf.lock);
>>   	}
>>   
>> -	while (!list_empty(&vcpu->async_pf.done)) {
>> +	while (kvm_check_async_pf_completion_queue(vcpu)) {
> this is replaced by a stronger check. Please can you explain why is it
> equivalent?

Access to the completion queue is protected by spinlock. So the additional
check in list_empty_careful() to verify the head's prev/next are modified
on the fly shouldn't happen. It means they're same in our case.

>>   		struct kvm_async_pf *work =
>>   			list_first_entry(&vcpu->async_pf.done,
>>   					 typeof(*work), link);
>> @@ -138,7 +138,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
>>   {
>>   	struct kvm_async_pf *work;
>>   
>> -	while (!list_empty_careful(&vcpu->async_pf.done) &&
>> +	while (kvm_check_async_pf_completion_queue(vcpu) &&
>>   	      kvm_arch_can_dequeue_async_page_present(vcpu)) {
>>   		spin_lock(&vcpu->async_pf.lock);
>>   		work = list_first_entry(&vcpu->async_pf.done, typeof(*work),
>> @@ -205,7 +205,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu)
>>   	struct kvm_async_pf *work;
>>   	bool first;
>>   
>> -	if (!list_empty_careful(&vcpu->async_pf.done))
>> +	if (kvm_check_async_pf_completion_queue(vcpu))
>>   		return 0;
>>   
>>   	work = kmem_cache_zalloc(async_pf_cache, GFP_ATOMIC);
>> @@ -216,7 +216,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu)
>>   	INIT_LIST_HEAD(&work->queue); /* for list_del to work */
>>   
>>   	spin_lock(&vcpu->async_pf.lock);
>> -	first = list_empty(&vcpu->async_pf.done);
>> +	first = !kvm_check_async_pf_completion_queue(vcpu);
>>   	list_add_tail(&work->link, &vcpu->async_pf.done);
>>   	spin_unlock(&vcpu->async_pf.lock);
>>   
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index b50dbe269f4b..8795503651b1 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3282,10 +3282,8 @@ static bool vcpu_dy_runnable(struct kvm_vcpu *vcpu)
>>   	if (kvm_arch_dy_runnable(vcpu))
>>   		return true;
>>   
>> -#ifdef CONFIG_KVM_ASYNC_PF
>> -	if (!list_empty_careful(&vcpu->async_pf.done))
>> +	if (kvm_check_async_pf_completion_queue(vcpu))
>>   		return true;
>> -#endif
>>   
>>   	return false;
>>   }
>>

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
