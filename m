Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADC374E70F5
	for <lists+kvmarm@lfdr.de>; Fri, 25 Mar 2022 11:14:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E23E24B11C;
	Fri, 25 Mar 2022 06:14:40 -0400 (EDT)
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
	with ESMTP id mXirFYyJeTKq; Fri, 25 Mar 2022 06:14:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A02B4B11A;
	Fri, 25 Mar 2022 06:14:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96FC04B0DF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Mar 2022 06:14:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GTgz0jz5tOAj for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Mar 2022 06:14:36 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6222049F59
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Mar 2022 06:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648203276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MW2R3ZwScMs/e2ATd9gf1x0MyXKZJAhQ19cegQ4o0K0=;
 b=OOiD8r9mdCJz6THyS7OuIIVgFUJhANSOIS2xD8hXyJEOmDJqfkMqpPKiQ2AQ2cawMWJmxh
 1sYzR44wcjIrhreG+I4+Mt1sOsukX7qkCCay6g2rkGh+fpvCMQv0uUfcOHPH1hWO8Ji6e/
 UK+Zploq7CdBYCBDTMgIlxwVD9oTBXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-VUb-p-cFPCWVfZJzHbo_6w-1; Fri, 25 Mar 2022 06:14:32 -0400
X-MC-Unique: VUb-p-cFPCWVfZJzHbo_6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91B31044563;
 Fri, 25 Mar 2022 10:14:31 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC148141DEE9;
 Fri, 25 Mar 2022 10:14:26 +0000 (UTC)
Subject: Re: [PATCH v5 18/22] KVM: arm64: Support SDEI ioctl commands on VM
To: Oliver Upton <oupton@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-19-gshan@redhat.com> <YjtYuk+Jx1dFPQQ9@google.com>
 <eae10132-a02d-b341-bdf5-be1b2096be4c@redhat.com>
 <Yj1wsIy2rsVczmCJ@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <17119a1b-9fb1-2a15-ac19-8f4e128288f5@redhat.com>
Date: Fri, 25 Mar 2022 18:14:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Yj1wsIy2rsVczmCJ@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

On 3/25/22 3:35 PM, Oliver Upton wrote:
> On Fri, Mar 25, 2022 at 02:59:52PM +0800, Gavin Shan wrote:
>>> The PSCI implementation is a great example of how KVM has grown its
>>> implementation in line with a specification, all the while preserving
>>> backwards compatibility.
>>>
>>
>> The only information feed by VMM is the exposed events. The events
>> can't be registered from guest kernel, and raised from host to guest
>> kernel until it's exposed by VMM.
> 
> I would suggest assuming that all SDEI events are exposed by default in
> KVM. We will not require a VMM change to enable events individually.
> 

Ok, it was exactly what I did in v4, but the event is exposed
by VMM in v5. In v6, it will be staticly defined again :)

>> Besides, the exposed events will
>> be defined staticly in host/KVM as we discussed on PATCH[02/22]. We
>> also discussed to eliminate those ioctl commands. So I think we needn't
>> to add KVM_SDEI_CMD_SET_VERSION. Further more, the version is only a
>> concern to host itself if the migration can be done through the
>> firmware pseudo system registers since the migration compatibility
>> is the only concern to VMM (QEMU).
> 
> This all needs to work just like the KVM_REG_ARM_PSCI_VERSION version,
> I'd recommend taking a look at how we handle that register in KVM.
> 

Ok. I will do necessary investigation :)

>> Yes, Currently, 0.1/0.2/1.0 versions are supported by PSCI. 0.1 is
>> picked until VMM asks for 0.2 and 1.0 explicitly. However, it seems
>> QEMU isn't using 1.0 PSCI yet and maybe more patch is needed to enable
>> it.
> 
> As far as how it interacts with KVM, QEMU looks fine. The name of the
> KVM_ARM_VCPU_PSCI_0_2 bit is quite frustrating. It actually implies that
> KVM will enable it highest supported PSCI version. If the feature bit is
> cleared then you only get PSCIv0.1
> 
> However, the DT node that QEMU sets up looks a bit crusty. The
> properties for conveying PSCI function IDs were only ever necessary for
> PSCIv0.1. The only property of interest any more is 'method', to convey
> the SMCCC conduit instruction.
> 

Ok, Thanks again for the further information about PSCI implementation.
I will go through the code when I have free cycyles :)

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
