Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8748BE9C
	for <lists+kvmarm@lfdr.de>; Wed, 12 Jan 2022 07:35:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B8894B1B0;
	Wed, 12 Jan 2022 01:35:05 -0500 (EST)
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
	with ESMTP id 5ZJZvqZ-S7qK; Wed, 12 Jan 2022 01:35:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E08924B187;
	Wed, 12 Jan 2022 01:35:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C5B449F2F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jan 2022 01:35:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GWquGYVJZapF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 Jan 2022 01:35:02 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2708D49F29
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jan 2022 01:35:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641969301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1z83hJO+HnY0jnMCoreYTDUsNFy5zyg+TrY2m14oOE=;
 b=GPTCHPYQmkkGEzNfeG7YaWlmM1q1VdmTJi1QoEYme+rDsYbNhS9OQwds4ZixpYMukR3n2e
 zQfHDaDIbyj0tHfJ3E0D7v9PaSESkRBpyLldENUUD7fuJJ2zPjV/4QSHVN+B6u5ruXwysK
 /1xf1iUq7eUmNIQUBchc5ASTF9q9XVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-08llcZ5POhO_IXuM-CXU9g-1; Wed, 12 Jan 2022 01:34:55 -0500
X-MC-Unique: 08llcZ5POhO_IXuM-CXU9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 146B181CCB6;
 Wed, 12 Jan 2022 06:34:54 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F9935E49B;
 Wed, 12 Jan 2022 06:34:49 +0000 (UTC)
Subject: Re: [PATCH v4 13/21] KVM: arm64: Impment SDEI event delivery
To: Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-14-gshan@redhat.com>
 <74c5f170-fb08-56a7-ff87-9a51ecfda989@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <61768711-a68d-db9a-f049-61fa25808183@redhat.com>
Date: Wed, 12 Jan 2022 14:34:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <74c5f170-fb08-56a7-ff87-9a51ecfda989@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: maz@kernel.org, pbonzini@redhat.com, will@kernel.org,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com
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

On 11/10/21 6:58 PM, Eric Auger wrote:
> s/Impment/Implement in the commit title
> 
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This implement kvm_sdei_deliver() to support SDEI event delivery.
>> The function is called when the request (KVM_REQ_SDEI) is raised.
>> The following rules are taken according to the SDEI specification:
>>
>>     * x0 - x17 are saved. All of them are cleared except the following
>>       registered:
> s/registered/registers
>>       x0: number SDEI event to be delivered
> s/number SDEI event/SDEI event number
>>       x1: parameter associated with the SDEI event
> user arg?

The commit log will be improved in next respin.

>>       x2: PC of the interrupted context
>>       x3: PState of the interrupted context
>>
>>     * PC is set to the handler of the SDEI event, which was provided
>>       during its registration. PState is modified accordingly.
>>
>>     * SDEI event with critical priority can preempt those with normal
>>       priority.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/include/asm/kvm_host.h |  1 +
>>   arch/arm64/include/asm/kvm_sdei.h |  1 +
>>   arch/arm64/kvm/arm.c              |  3 ++
>>   arch/arm64/kvm/sdei.c             | 84 +++++++++++++++++++++++++++++++
>>   4 files changed, 89 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index aedf901e1ec7..46f363aa6524 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -47,6 +47,7 @@
>>   #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>>   #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>>   #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
>> +#define KVM_REQ_SDEI		KVM_ARCH_REQ(6)
>>   
>>   #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>>   				     KVM_DIRTY_LOG_INITIALLY_SET)
>> diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
>> index b0abc13a0256..7f5f5ad689e6 100644
>> --- a/arch/arm64/include/asm/kvm_sdei.h
>> +++ b/arch/arm64/include/asm/kvm_sdei.h
>> @@ -112,6 +112,7 @@ KVM_SDEI_FLAG_FUNC(enabled)
>>   void kvm_sdei_init_vm(struct kvm *kvm);
>>   void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu);
>> +void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
>>   void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
>>   void kvm_sdei_destroy_vm(struct kvm *kvm);
>>   
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 2f021aa41632..0c3db1ef1ba9 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -689,6 +689,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
>>   		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
>>   			kvm_reset_vcpu(vcpu);
>>   
>> +		if (kvm_check_request(KVM_REQ_SDEI, vcpu))
>> +			kvm_sdei_deliver(vcpu);
>> +
>>   		/*
>>   		 * Clear IRQ_PENDING requests that were made to guarantee
>>   		 * that a VCPU sees new virtual interrupts.
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index 62efee2b67b8..b5d6d1ed3858 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -671,6 +671,90 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   	return 1;
>>   }
>>   
>> +void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	struct kvm_sdei_vcpu_event *ksve = NULL;
>> +	struct kvm_sdei_vcpu_regs *regs = NULL;
>> +	unsigned long pstate;
>> +	int index = 0;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei))
>> +		return;
>> +
>> +	/* The critical event can't be preempted */
> move the comment after the spin_lock

Ok.

>> +	spin_lock(&vsdei->lock);
>> +	if (vsdei->critical_event)
>> +		goto unlock;
>> +
>> +	/*
>> +	 * The normal event can be preempted by the critical event.
>> +	 * However, the normal event can't be preempted by another
>> +	 * normal event.
>> +	 */
>> +	ksve = list_first_entry_or_null(&vsdei->critical_events,
>> +			struct kvm_sdei_vcpu_event, link);
>> +	if (!ksve && !vsdei->normal_event) {
>> +		ksve = list_first_entry_or_null(&vsdei->normal_events,
>> +				struct kvm_sdei_vcpu_event, link);
>> +	}
> At this stage of the review the struct kvm_sdei_vcpu_event lifecycle is
> not known.
> 

The object (kvm_sdei_vcpu_event) is queued to the target vCPU for dispatch.
The multiple and same SDEI events can be queued to one target vCPU. In this
case, the objecct is reused.

>>From the dispatcher pseudocode I understand you check
> 
> ((IsCriticalEvent(E) and !CriticalEventRunning(P, C)) ||
> (!IsCriticalEvent(E) and !EventRunning(P, C)))
> 
> but I can't check you take care of
> IsEnabled(E) and
> IsEventTarget(E, P)
> IsUnmasked(P)
> 
> Either you should shash with 18/21 or at least you should add comments.

The additional conditions are checked when the event is injected in PATCH[v4 18/21].
I think it's good idead to squash them.

>> +
>> +	if (!ksve)
>> +		goto unlock;
>> +
>> +	kske = ksve->kske;
>> +	kse = kske->kse;
>> +	if (kse->state.priority == SDEI_EVENT_PRIORITY_CRITICAL) {
>> +		vsdei->critical_event = ksve;
>> +		vsdei->state.critical_num = ksve->state.num;
>> +		regs = &vsdei->state.critical_regs;
>> +	} else {
>> +		vsdei->normal_event = ksve;
>> +		vsdei->state.normal_num = ksve->state.num;
>> +		regs = &vsdei->state.normal_regs;
>> +	}
>> +
>> +	/* Save registers: x0 -> x17, PC, PState */
>> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
>> +		regs->regs[index] = vcpu_get_reg(vcpu, index);
>> +
>> +	regs->pc = *vcpu_pc(vcpu);
>> +	regs->pstate = *vcpu_cpsr(vcpu);
>> +
>> +	/*
>> +	 * Inject SDEI event: x0 -> x3, PC, PState. We needn't take lock
>> +	 * for the KVM event as it can't be destroyed because of its
>> +	 * reference count.
>> +	 */
>> +	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
>> +		vcpu_set_reg(vcpu, index, 0);
>> +
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
>> +	vcpu_set_reg(vcpu, 0, kske->state.num);
>> +	vcpu_set_reg(vcpu, 1, kske->state.params[index]);
>> +	vcpu_set_reg(vcpu, 2, regs->pc);
>> +	vcpu_set_reg(vcpu, 3, regs->pstate);
>> +
>> +	pstate = regs->pstate;
>> +	pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT);
>> +	pstate &= ~PSR_MODE_MASK;
>> +	pstate |= PSR_MODE_EL1h;
>> +	pstate &= ~PSR_MODE32_BIT;
>> +
>> +	vcpu_write_sys_reg(vcpu, regs->pstate, SPSR_EL1);
>> +	*vcpu_cpsr(vcpu) = pstate;
>> +	*vcpu_pc(vcpu) = kske->state.entries[index];
>> +
>> +unlock:
>> +	spin_unlock(&vsdei->lock);
>> +}
>> +
>>   void kvm_sdei_init_vm(struct kvm *kvm)
>>   {
>>   	struct kvm_sdei_kvm *ksdei;
>>

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
