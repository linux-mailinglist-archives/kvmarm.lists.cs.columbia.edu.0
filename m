Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE148BEF4
	for <lists+kvmarm@lfdr.de>; Wed, 12 Jan 2022 08:22:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E3274B1E0;
	Wed, 12 Jan 2022 02:22:43 -0500 (EST)
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
	with ESMTP id AVFVr-7CnmyP; Wed, 12 Jan 2022 02:22:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 430384B1CC;
	Wed, 12 Jan 2022 02:22:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A20DA4B1BF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jan 2022 02:22:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EjYz8vGy4qwK for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 Jan 2022 02:22:39 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B23434B178
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jan 2022 02:22:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641972159;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SozMMaXUKHvJpCmWVV67dCSZEl8d23MxU5rvzgWoya8=;
 b=BtruB1xBqo+1/G9/aEXoqEGGuJtovSH4hlRJGzECDtcCJh7s2Cytj/9hTSnFaGGSeqrimr
 UUo1UaURwSNNU1jKuKquooUWXlJI8baw154/Ye2SajRLLG8mam0TK/CyRXocoy28CF7fsT
 zXG64LSiLeDnPAj3f5HNZMmX4HlGVTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-9c7H-I3-PXyJH_JF4GvA4Q-1; Wed, 12 Jan 2022 02:20:52 -0500
X-MC-Unique: 9c7H-I3-PXyJH_JF4GvA4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EFB100C611;
 Wed, 12 Jan 2022 07:20:51 +0000 (UTC)
Received: from [10.72.12.204] (ovpn-12-204.pek2.redhat.com [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F363A5E4B7;
 Wed, 12 Jan 2022 07:20:47 +0000 (UTC)
Subject: Re: [PATCH v4 20/21] KVM: arm64: Export SDEI capability
To: Eric Auger <eauger@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-21-gshan@redhat.com>
 <90fd5226-0889-6a7c-1586-732015943863@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <29ff20b5-2395-2f2e-3c5c-6061c9a00716@redhat.com>
Date: Wed, 12 Jan 2022 15:20:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <90fd5226-0889-6a7c-1586-732015943863@redhat.com>
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

On 11/10/21 9:55 PM, Eric Auger wrote:
> On 8/15/21 2:13 AM, Gavin Shan wrote:
>> The SDEI functionality is ready to be exported so far. This adds
>> new capability (KVM_CAP_ARM_SDEI) and exports it.
> 
> Need to be documented in
> kvm/api.rst
> as the rest of the API
> 

Ok, Thanks, Eric :)


>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/arm.c     | 3 +++
>>   include/uapi/linux/kvm.h | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 215cdbeb272a..7d9bbc888ae5 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -278,6 +278,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_ARM_PTRAUTH_GENERIC:
>>   		r = system_has_full_ptr_auth();
>>   		break;
>> +	case KVM_CAP_ARM_SDEI:
>> +		r = 1;
>> +		break;
>>   	default:
>>   		r = 0;
>>   	}
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 8cf41fd4bf86..2aa748fd89c7 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_BINARY_STATS_FD 203
>>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>>   #define KVM_CAP_ARM_MTE 205
>> +#define KVM_CAP_ARM_SDEI 206
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>>
> Eric
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
