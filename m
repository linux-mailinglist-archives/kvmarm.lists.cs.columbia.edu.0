Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBE4E5DC5
	for <lists+kvmarm@lfdr.de>; Thu, 24 Mar 2022 05:07:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA43849F44;
	Thu, 24 Mar 2022 00:07:56 -0400 (EDT)
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
	with ESMTP id b6waKfEQj00m; Thu, 24 Mar 2022 00:07:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3667E49F1D;
	Thu, 24 Mar 2022 00:07:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5FAED49ED7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Mar 2022 00:07:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I3p+5cf5pusv for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Mar 2022 00:07:52 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F31740FF0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Mar 2022 00:07:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648094871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fkEZc+cdXddFpyjDOTE5EXhIOuXdRohucX74uCvG4U=;
 b=di2RXBPlLzC20KLR9fuLj7oA7uwsFMVYo/ztXC4RT9wROfWA+6Z7iU1wAWOsmQ3UStmFGr
 57qG8QtZQzzkqeBLERQg8pmk/7IgHdHeDGB8jQmWXM3Qtp3AyC3C6Q353kkzV7JxeSS4CQ
 oqlMOYEY65DIy5+qIxJRrvE/iKr1rH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-jdGNZksWNH6DvdDpEFU2Hw-1; Thu, 24 Mar 2022 00:07:46 -0400
X-MC-Unique: jdGNZksWNH6DvdDpEFU2Hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55A9D185A7B2;
 Thu, 24 Mar 2022 04:07:46 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE4B2166B2D;
 Thu, 24 Mar 2022 04:07:37 +0000 (UTC)
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
To: Oliver Upton <oupton@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com> <YjoPxLAMIPobBzS0@google.com>
 <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
 <YjtLVqBbL0jyFFZy@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <6f217836-45fb-8833-7bb1-5dc822826f56@redhat.com>
Date: Thu, 24 Mar 2022 12:07:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjtLVqBbL0jyFFZy@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Oliver,

On 3/24/22 12:31 AM, Oliver Upton wrote:
> On Wed, Mar 23, 2022 at 08:46:40PM +0800, Gavin Shan wrote:
>> On 3/23/22 2:04 AM, Oliver Upton wrote:
>>> On Tue, Mar 22, 2022 at 04:06:51PM +0800, Gavin Shan wrote:
>>>> This supports SDEI_VERSION hypercall by returning v1.1, which is
>>>> the specification version we're following. The vendor is set to
>>>> 'KVM'.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    arch/arm64/kvm/sdei.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>>>> index 8a9b477b8977..5a3a64cd6e84 100644
>>>> --- a/arch/arm64/kvm/sdei.c
>>>> +++ b/arch/arm64/kvm/sdei.c
>>>> @@ -118,6 +118,14 @@ static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
>>>>    	return pending;
>>>>    }
>>>> +static unsigned long hypercall_version(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +	/* v1.1 and the vendor is KVM */
>>>> +	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
>>>> +	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
>>>> +	       0x4b564d;
>>>
>>> It looks like the SDEI specification states that the vendor-defined
>>> version number is 32 bits. Could we just use one of the
>>> ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_{0,3} values instead?
>>>
>>> ASCII 'KVM' is neat, but in reality guest software will just throw it in
>>> a macro regardless. Might as well use one of the values we've already
>>> trained it to use :-)
>>>
>>> Also, it would appear that guest discovery of SDEI relies upon KVM
>>> reporting a valid SDEI version. IMO, this patch should come at the very
>>> end when KVM actually implements SDEI.
>>>
>>
>> Yeah, I was sticky to the pattern of "KVM". However, I think it's good
>> to reuse the existing one. Lets use ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
>> if you agree. Its first two characters are "VM" at least.
> 
> Sounds fine to me. The only other nit I'd say is we should define a
> macro for it too, something like:
> 
>    #define KVM_SDEI_VENDOR	ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
> 

Agreed, and the macro will be put into arch/arm64/include/asm/kvm_sdei.h.
arch/arm64/include/uapi/asm/kvm_sdei_state.h isn't the right place because
the dependent macro ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 isn't exposed by
ABI.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
