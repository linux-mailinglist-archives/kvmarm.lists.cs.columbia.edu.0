Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3DF48BD5C
	for <lists+kvmarm@lfdr.de>; Wed, 12 Jan 2022 03:39:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 905194B0D7;
	Tue, 11 Jan 2022 21:39:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tN6TNvCJoXWP; Tue, 11 Jan 2022 21:39:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D04F4B0B4;
	Tue, 11 Jan 2022 21:39:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 267CB4ACC9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 21:39:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRA9rqZI7+v7 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jan 2022 21:39:12 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05B474A7FD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jan 2022 21:39:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641955151;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EC8JqTc5p5dOk5517cNTRB8u9r50bke9P1vj8NyUUwE=;
 b=HhhZw5ncid6GvX452d6G8DiDXfixt6/i5nrIAHJrPaE1JVYI7y3UwZDQHlK0Db79APrhip
 N6RqPKecbcyzEFk7T3S4JKU71Dh2H/pe4fVLUkXvMZlp3zrYbw5yrXRPdzxFR6T7FNOyf8
 n/JxZChkM2b269Ym5idSsMQ/78pE8qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-A4nsJXNLPwWmzIuASfxBfg-1; Tue, 11 Jan 2022 21:39:08 -0500
X-MC-Unique: A4nsJXNLPwWmzIuASfxBfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B1B736393;
 Wed, 12 Jan 2022 02:39:07 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87DDD6107E;
 Wed, 12 Jan 2022 02:38:59 +0000 (UTC)
Subject: Re: [PATCH v4 07/21] KVM: arm64: Support SDEI_EVENT_UNREGISTER
 hypercall
To: Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-8-gshan@redhat.com>
 <100a4aa0-6c2d-2fec-6f11-c7e64946ef0b@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <11022feb-16d7-8732-0d3a-12a65a4e39de@redhat.com>
Date: Wed, 12 Jan 2022 10:38:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <100a4aa0-6c2d-2fec-6f11-c7e64946ef0b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On 11/10/21 1:05 AM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> This supports SDEI_EVENT_UNREGISTER hypercall. It's used by the
>> guest to unregister SDEI event. The SDEI event won't be raised to
>> the guest or specific vCPU after it's unregistered successfully.
>> It's notable the SDEI event is disabled automatically on the guest
>> or specific vCPU once it's unregistered successfully.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 61 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index b4162efda470..a3ba69dc91cb 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -308,6 +308,65 @@ static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
>>   	return ret;
>>   }
>>   
>> +static unsigned long kvm_sdei_hypercall_unregister(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
>> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
>> +	struct kvm_sdei_event *kse = NULL;
>> +	struct kvm_sdei_kvm_event *kske = NULL;
>> +	unsigned long event_num = smccc_get_arg1(vcpu);
>> +	int index = 0;
>> +	unsigned long ret = SDEI_SUCCESS;
>> +
>> +	/* Sanity check */
>> +	if (!(ksdei && vsdei)) {
>> +		ret = SDEI_NOT_SUPPORTED;
>> +		goto out;
>> +	}
>> +
>> +	if (!kvm_sdei_is_valid_event_num(event_num)) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto out;
>> +	}
>> +
>> +	/* Check if the KVM event exists */
>> +	spin_lock(&ksdei->lock);
>> +	kske = kvm_sdei_find_kvm_event(kvm, event_num);
>> +	if (!kske) {
>> +		ret = SDEI_INVALID_PARAMETERS;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Check if there is pending events */
>> +	if (kske->state.refcount) {
>> +		ret = SDEI_PENDING;
> don't you want to record the fact the unregistration is outstanding to
> perform subsequent actions? Otherwise nothing will hapen when the
> current executing handlers complete?

It's not necessary. The guest should retry in this case.

>> +		goto unlock;
>> +	}
>> +
>> +	/* Check if it has been registered */
>> +	kse = kske->kse;
>> +	index = (kse->state.type == SDEI_EVENT_TYPE_PRIVATE) ?
>> +		vcpu->vcpu_idx : 0;
> you could have an inline for the above as this is executed in many
> functions. even including the code below.

Ok, it's a good idea.

>> +	if (!kvm_sdei_is_registered(kske, index)) {
>> +		ret = SDEI_DENIED;
>> +		goto unlock;
>> +	}
>> +
>> +	/* The event is disabled when it's unregistered */
>> +	kvm_sdei_clear_enabled(kske, index);
>> +	kvm_sdei_clear_registered(kske, index);
>> +	if (kvm_sdei_empty_registered(kske)) {
> a refcount mechanism would be cleaner I think.

A refcount isn't working well. We need a mapping here because the private
SDEI event can be enabled/registered on multiple vCPUs. We need to know
the exact vCPUs where the private SDEI event is enabled/registered.

>> +		list_del(&kske->link);
>> +		kfree(kske);
>> +	}
>> +
>> +unlock:
>> +	spin_unlock(&ksdei->lock);
>> +out:
>> +	return ret;
>> +}
>> +
>>   int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   {
>>   	u32 func = smccc_get_function(vcpu);
>> @@ -333,6 +392,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
>>   	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
>>   	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
>> +		ret = kvm_sdei_hypercall_unregister(vcpu);
>> +		break;
>>   	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
>>   	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
>>   	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
>>

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
