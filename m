Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 88985351F6D
	for <lists+kvmarm@lfdr.de>; Thu,  1 Apr 2021 21:17:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE3434B717;
	Thu,  1 Apr 2021 15:17:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ly0kgBWwASyv; Thu,  1 Apr 2021 15:17:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50FC74B714;
	Thu,  1 Apr 2021 15:17:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 246E24B70B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Apr 2021 15:17:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQXY3XTq4XLZ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Apr 2021 15:17:09 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E52094B709
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Apr 2021 15:17:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617304629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sXsEpyuLPqPsJXizrEkDnBgF4FIEnwsiOddG5WaZg4=;
 b=IZbFUxusdNVmfD5o0JX9WKc2QoF7fds3Nj4R+eG5FfhUgCUMx8eBFeNhMJhJH0/iSwL6MM
 KHOlZ4Fc6q+N1fKTiuTcphZM/ku9Xez96xIdQmu4pTRLrT8Y1bSM+WwVTW+M8K4k9Ol7is
 caHslEmLcJ06+yKE/onsPP540+UqmcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-xlEWW-Z2PBmzqhsqwv00_g-1; Thu, 01 Apr 2021 15:16:59 -0400
X-MC-Unique: xlEWW-Z2PBmzqhsqwv00_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427361018F70;
 Thu,  1 Apr 2021 19:16:58 +0000 (UTC)
Received: from [10.36.112.13] (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73F266F130;
 Thu,  1 Apr 2021 19:16:55 +0000 (UTC)
Subject: Re: [PATCH v4 7/8] KVM: arm64: vgic-v3: Expose GICR_TYPER.Last for
 userspace
To: Marc Zyngier <maz@kernel.org>
References: <20210401085238.477270-1-eric.auger@redhat.com>
 <20210401085238.477270-8-eric.auger@redhat.com>
 <87tuoqp1du.wl-maz@kernel.org>
 <b2458147-cd53-8712-9120-7ee9b84152aa@redhat.com>
 <87ft09gbeo.wl-maz@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b913bde9-9f63-919f-3895-973c62452653@redhat.com>
Date: Thu, 1 Apr 2021 21:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87ft09gbeo.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On 4/1/21 7:30 PM, Marc Zyngier wrote:
> On Thu, 01 Apr 2021 18:03:25 +0100,
> Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Marc,
>>
>> On 4/1/21 3:42 PM, Marc Zyngier wrote:
>>> Hi Eric,
>>>
>>> On Thu, 01 Apr 2021 09:52:37 +0100,
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> Commit 23bde34771f1 ("KVM: arm64: vgic-v3: Drop the
>>>> reporting of GICR_TYPER.Last for userspace") temporarily fixed
>>>> a bug identified when attempting to access the GICR_TYPER
>>>> register before the redistributor region setting, but dropped
>>>> the support of the LAST bit.
>>>>
>>>> Emulating the GICR_TYPER.Last bit still makes sense for
>>>> architecture compliance though. This patch restores its support
>>>> (if the redistributor region was set) while keeping the code safe.
>>>>
>>>> We introduce a new helper, vgic_mmio_vcpu_rdist_is_last() which
>>>> computes whether a redistributor is the highest one of a series
>>>> of redistributor contributor pages.
>>>>
>>>> The spec says "Indicates whether this Redistributor is the
>>>> highest-numbered Redistributor in a series of contiguous
>>>> Redistributor pages."
>>>>
>>>> The code is a bit convulated since there is no guarantee
>>>
>>> nit: convoluted
>>>
>>>> redistributors are added in a given reditributor region in
>>>> ascending order. In that case the current implementation was
>>>> wrong. Also redistributor regions can be contiguous
>>>> and registered in non increasing base address order.
>>>>
>>>> So the index of redistributors are stored in an array within
>>>> the redistributor region structure.
>>>>
>>>> With this new implementation we do not need to have a uaccess
>>>> read accessor anymore.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> This patch also hurt my head, a lot more than the first one.  See
>>> below.
>>>
>>>> ---
>>>>  arch/arm64/kvm/vgic/vgic-init.c    |  7 +--
>>>>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 97 ++++++++++++++++++++----------
>>>>  arch/arm64/kvm/vgic/vgic.h         |  1 +
>>>>  include/kvm/arm_vgic.h             |  3 +
>>>>  4 files changed, 73 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
>>>> index cf6faa0aeddb2..61150c34c268c 100644
>>>> --- a/arch/arm64/kvm/vgic/vgic-init.c
>>>> +++ b/arch/arm64/kvm/vgic/vgic-init.c
>>>> @@ -190,6 +190,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
>>>>  	int i;
>>>>  
>>>>  	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
>>>> +	vgic_cpu->index = vcpu->vcpu_id;
>>>
>>> Is it so that vgic_cpu->index is always equal to vcpu_id? If so, why
>>> do we need another field? We can always get to the vcpu using a
>>> container_of().
>>>
>>>>  
>>>>  	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
>>>>  	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
>>>> @@ -338,10 +339,8 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
>>>>  	dist->vgic_dist_base = VGIC_ADDR_UNDEF;
>>>>  
>>>>  	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
>>>> -		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list) {
>>>> -			list_del(&rdreg->list);
>>>> -			kfree(rdreg);
>>>> -		}
>>>> +		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list)
>>>> +			vgic_v3_free_redist_region(rdreg);
>>>
>>> Consider moving the introduction of vgic_v3_free_redist_region() into
>>> a separate patch. On its own, that's a good readability improvement.
>>>
>>>>  		INIT_LIST_HEAD(&dist->rd_regions);
>>>>  	} else {
>>>>  		dist->vgic_cpu_base = VGIC_ADDR_UNDEF;
>>>> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>>>> index 987e366c80008..f6a7eed1d6adb 100644
>>>> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>>>> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>>>> @@ -251,45 +251,57 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
>>>>  		vgic_enable_lpis(vcpu);
>>>>  }
>>>>  
>>>> +static bool vgic_mmio_vcpu_rdist_is_last(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +	struct vgic_dist *vgic = &vcpu->kvm->arch.vgic;
>>>> +	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>>> +	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
>>>> +
>>>> +	if (!rdreg)
>>>> +		return false;
>>>> +
>>>> +	if (rdreg->count && vgic_cpu->rdreg_index == (rdreg->count - 1)) {
>>>> +		/* check whether there is no other contiguous rdist region */
>>>> +		struct list_head *rd_regions = &vgic->rd_regions;
>>>> +		struct vgic_redist_region *iter;
>>>> +
>>>> +		list_for_each_entry(iter, rd_regions, list) {
>>>> +			if (iter->base == rdreg->base + rdreg->count * KVM_VGIC_V3_REDIST_SIZE &&
>>>> +				iter->free_index > 0) {
>>>> +			/* check the first rdist index of this region, if any */
>>>> +				if (vgic_cpu->index < iter->rdist_indices[0])
>>>> +					return false;
>>>
>>> rdist_indices[] contains the vcpu_id of the vcpu associated with a
>>> given RD in the region. At this stage, you have established that there
>>> is another region that is contiguous with the one associated with our
>>> vcpu. You also know that this adjacent region has a vcpu mapped in
>>> (free_index isn't 0). Isn't that enough to declare that our vcpu isn't
>>> last?  I definitely don't understand what the index comparison does
>>> here.
>> Assume the following case:
>> 2 RDIST region
>> region #0 contains rdist 1, 2, 4
>> region #1, adjacent to #0 contains rdist 3
>>
>> Spec days:
>> "Indicates whether this Redistributor is the
>> highest-numbered Redistributor in a series of contiguous
>> Redistributor pages."
>>
>> To me 4 is last and 3 is last too.
> 
> No, only 3 is last, assuming that region 0 is full. I think the
> phrasing in the spec is just really bad. What this describes is that
> at the end of a set of contiguous set of RDs, that last RD has Last
> set. If two regions are contiguous, that's undistinguishable from a
> single, larger region.
> 
> There is no such thing as a "redistributor number" anyway. The closest
> thing there is would be "processor number", but that has nothing to do
> with the RD itself.

Hum OK. That's a different understanding of the spec wording indeed. For
me redistributor number was the index of the vcpu.

But well, you're understanding is definitively simpler to implement and
also matches what was implemented for single RDIST region.

> 
>>
>>
>>>
>>> It also seem to me that some of the complexity could be eliminated if
>>> the regions were kept ordered at list insertion time.
>> yes
>>>
>>>> +			}
>>>> +		}
>>>> +	} else if (vgic_cpu->rdreg_index < rdreg->free_index - 1) {
>>>> +		/* look at the index of next rdist */
>>>> +		int next_rdist_index = rdreg->rdist_indices[vgic_cpu->rdreg_index + 1];
>>>> +
>>>> +		if (vgic_cpu->index < next_rdist_index)
>>>> +			return false;
>>>
>>> Same thing here. We are in the middle of the allocated part of a
>>> region, which means we cannot be last. I still don't get the index
>>> check.
>> Because within a region, nothing hinders rdist from being allocated in
>> non ascending order. I exercise those cases in the kvmselftests
>>
>> one single RDIST region with the following rdists allocated there:
>> 1, 3, 2
>>
>> 3 and 2 are "last", right? Or did I miss something. Yes that's totally
>> not natural to do that kind of allocation but the API allows to do that.
> 
> No, only 2 is last. I think you got tripped by the bizarre language in
> the spec, and the behaviour of this Last bit is much simpler than what
> you ended up with.


OK, I will respin according to your suggestion then.

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
