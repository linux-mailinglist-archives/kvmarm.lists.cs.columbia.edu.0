Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5DD2F50E6
	for <lists+kvmarm@lfdr.de>; Wed, 13 Jan 2021 18:18:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1809B4B1C9;
	Wed, 13 Jan 2021 12:18:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oMwx7ZDUIfto; Wed, 13 Jan 2021 12:18:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE7094B1BF;
	Wed, 13 Jan 2021 12:18:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A67304B122
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Jan 2021 12:18:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OA7nZruL3WXb for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Jan 2021 12:18:27 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C3C074B1AA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Jan 2021 12:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610558307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5hNzXnRtBLkRY+uChUouzv6yCzi7yuTb2zBLYxeP94=;
 b=YbWdM2eD9DenxP+kRBf2G/UeRlyZ9doqpw+HipumUVCu5YvDBAO9rOxxwO2E9iEgj2RFaf
 TQfCKBoneRr92Kf2DjXCeIO4mw1VR7WL1bOFKG7DE4bZLA6ve69mcv9aYmj3HO7nPKUqLD
 w4jk28bi0JhSoyPL+1uL2MQhMrEFMa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-CS-aG-nUM0mMe2mBZ18P1A-1; Wed, 13 Jan 2021 12:18:23 -0500
X-MC-Unique: CS-aG-nUM0mMe2mBZ18P1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F62380A5C0;
 Wed, 13 Jan 2021 17:18:22 +0000 (UTC)
Received: from [10.36.114.165] (ovpn-114-165.ams2.redhat.com [10.36.114.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4581074AA9;
 Wed, 13 Jan 2021 17:18:19 +0000 (UTC)
Subject: Re: [PATCH 6/9] docs: kvm: devices/arm-vgic-v3: enhance
 KVM_DEV_ARM_VGIC_CTRL_INIT doc
To: Alexandru Elisei <alexandru.elisei@arm.com>, eric.auger.pro@gmail.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com
References: <20201212185010.26579-1-eric.auger@redhat.com>
 <20201212185010.26579-7-eric.auger@redhat.com>
 <4c0b3988-904c-a922-d0be-87a354c3203c@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0f6f4848-b7df-9e9f-8b25-5009a5650350@redhat.com>
Date: Wed, 13 Jan 2021 18:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4c0b3988-904c-a922-d0be-87a354c3203c@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shuah@kernel.org, pbonzini@redhat.com
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

Hi Alexandru,

On 1/12/21 4:39 PM, Alexandru Elisei wrote:
> Hi Eric,
> 
> On 12/12/20 6:50 PM, Eric Auger wrote:
>> kvm_arch_vcpu_precreate() returns -EBUSY if the vgic is
>> already initialized. So let's document that KVM_DEV_ARM_VGIC_CTRL_INIT
>> must be called after all vcpu creations.
> 
> Checked and this is indeed the case,
> kvm_vm_ioctl_create_vcpu()->kvm_arch_vcpu_precreate() returns -EBUSY is
> vgic_initialized() is true.
thanks!
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  Documentation/virt/kvm/devices/arm-vgic-v3.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/arm-vgic-v3.rst b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
>> index 5dd3bff51978..322de6aebdec 100644
>> --- a/Documentation/virt/kvm/devices/arm-vgic-v3.rst
>> +++ b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
>> @@ -228,7 +228,7 @@ Groups:
>>  
>>      KVM_DEV_ARM_VGIC_CTRL_INIT
>>        request the initialization of the VGIC, no additional parameter in
>> -      kvm_device_attr.addr.
>> +      kvm_device_attr.addr. Must be called after all vcpu creations.
> 
> Nitpick here: the document writes VCPU with all caps. This also sounds a bit
> weird, I think something like "Must be called after all VCPUs have been created"
> is clearer.
I took your suggestion.

Thanks

Eric
> 
> Thanks,
> Alex
>>      KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
>>        save all LPI pending bits into guest RAM pending tables.
>>  
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
