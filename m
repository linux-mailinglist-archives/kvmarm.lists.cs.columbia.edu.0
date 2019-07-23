Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA96471831
	for <lists+kvmarm@lfdr.de>; Tue, 23 Jul 2019 14:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AE7E4A54F;
	Tue, 23 Jul 2019 08:25:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2ifdsXqEssL; Tue, 23 Jul 2019 08:25:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D15F94A55D;
	Tue, 23 Jul 2019 08:25:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93E354A535
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jul 2019 08:25:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U+dZWjtOUbRq for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Jul 2019 08:25:51 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 852E84A523
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jul 2019 08:25:51 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7035F300CB0E;
 Tue, 23 Jul 2019 12:25:50 +0000 (UTC)
Received: from [10.36.117.239] (ovpn-117-239.ams2.redhat.com [10.36.117.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4BB21001DE1;
 Tue, 23 Jul 2019 12:25:45 +0000 (UTC)
Subject: Re: [PATCH v2 4/9] KVM: arm/arm64: vgic-its: Invalidate MSI-LPI
 translation cache on specific commands
To: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20190611170336.121706-1-marc.zyngier@arm.com>
 <20190611170336.121706-5-marc.zyngier@arm.com>
 <9ff329a3-44f2-1de3-b6cc-58ed38a63665@redhat.com>
 <1a78d52c-7a31-8981-230b-abe85d11b8ec@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8b5e029c-a08f-b86b-7021-5d68ec05d3bd@redhat.com>
Date: Tue, 23 Jul 2019 14:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1a78d52c-7a31-8981-230b-abe85d11b8ec@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 23 Jul 2019 12:25:50 +0000 (UTC)
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>, "Saidi,
 Ali" <alisaidi@amazon.com>
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

Hi Marc,

On 7/22/19 12:54 PM, Marc Zyngier wrote:
> Hi Eric,
> 
> On 01/07/2019 13:38, Auger Eric wrote:
>> Hi Marc,
>>
>> On 6/11/19 7:03 PM, Marc Zyngier wrote:
>>> The LPI translation cache needs to be discarded when an ITS command
>>> may affect the translation of an LPI (DISCARD and MAPD with V=0) or
>>> the routing of an LPI to a redistributor with disabled LPIs (MOVI,
>>> MOVALL).
>>>
>>> We decide to perform a full invalidation of the cache, irrespective
>>> of the LPI that is affected. Commands are supposed to be rare enough
>>> that it doesn't matter.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  virt/kvm/arm/vgic/vgic-its.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>>> index 9b6b66204b97..5254bb762e1b 100644
>>> --- a/virt/kvm/arm/vgic/vgic-its.c
>>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>>> @@ -733,6 +733,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
>>>  		 * don't bother here since we clear the ITTE anyway and the
>>>  		 * pending state is a property of the ITTE struct.
>>>  		 */
>>> +		vgic_its_invalidate_cache(kvm);
>>> +
>>>  		its_free_ite(kvm, ite);
>>>  		return 0;
>>>  	}
>>> @@ -768,6 +770,8 @@ static int vgic_its_cmd_handle_movi(struct kvm *kvm, struct vgic_its *its,
>>>  	ite->collection = collection;
>>>  	vcpu = kvm_get_vcpu(kvm, collection->target_addr);
>>>  
>>> +	vgic_its_invalidate_cache(kvm);
>>> +
>>>  	return update_affinity(ite->irq, vcpu);
>>>  }
>>>  
>>> @@ -996,6 +1000,8 @@ static void vgic_its_free_device(struct kvm *kvm, struct its_device *device)
>>>  	list_for_each_entry_safe(ite, temp, &device->itt_head, ite_list)
>>>  		its_free_ite(kvm, ite);
>>>  
>>> +	vgic_its_invalidate_cache(kvm);
>>> +
>>>  	list_del(&device->dev_list);
>>>  	kfree(device);
>>>  }
>>> @@ -1249,6 +1255,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
>>>  		vgic_put_irq(kvm, irq);
>>>  	}
>>>  
>>> +	vgic_its_invalidate_cache(kvm);
>> All the commands are executed with the its_lock held. Now we don't take
>> it anymore on the fast cache injection path. Don't we have a window
>> where the move has been applied at table level and the cache is not yet
>> invalidated? Same question for vgic_its_free_device().
> 
> There is definitely a race, but that race is invisible from the guest's
> perspective. The guest can only assume that the command has taken effect
> once a SYNC command has been executed, and it cannot observe that the
> SYNC command has been executed before we have invalidated the cache.
> 
> Does this answer your question?

OK make sense. Thank you for the clarification

Another question, don't we need to invalidate the cache on  MAPC V=0 as
well? Removing the mapping of the collection results in interrupts
belonging to that collection being ignored. If we don't flush the
pending bit will be set?

Thanks

Eric
> 
> Thanks,
> 
> 	M.
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
