Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D81804D0
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 18:30:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F7054A551;
	Tue, 10 Mar 2020 13:30:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AW4omvlsaRIS; Tue, 10 Mar 2020 13:30:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C5E84A4C0;
	Tue, 10 Mar 2020 13:30:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 808394A32E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 13:30:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jn0Vj2eJjU2f for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 13:30:39 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 838F940A52
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 13:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583861439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6RWW66Auc2Rk/GNuUgSAGvLduNQwWlqc2HkVeIS1zc=;
 b=VSFUNLqW/O9LJUofrtIlTkuYYbhqffy23fquzBQjQK9Yr1xQ6EyLq8rXHCvcqU/4bCaAB/
 Tug8NcmqVTtgXiZKd7WTcVpWkwPHeeafRVOoVlhiM/oR8dmeAp++vZdUsZUKW0hLn5H1v2
 kyJHUePkVR6u4h22Gs0waMGTvb0P6LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-4H-srkrCPfWDrBsXlrJ0_w-1; Tue, 10 Mar 2020 13:30:35 -0400
X-MC-Unique: 4H-srkrCPfWDrBsXlrJ0_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FEE107ACC4;
 Tue, 10 Mar 2020 17:30:33 +0000 (UTC)
Received: from [10.36.117.85] (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14EF110013A1;
 Tue, 10 Mar 2020 17:30:30 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] KVM: arm64: Document PMU filtering API
To: Marc Zyngier <maz@kernel.org>
References: <20200309124837.19908-1-maz@kernel.org>
 <20200309124837.19908-3-maz@kernel.org>
 <7943c896-013b-d9cb-ba89-2040b46437fe@redhat.com>
 <07f4ef9b5ff6c6c5086c9723c64c035f@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <867c7926-df43-7ab0-d20a-211a59d7612d@redhat.com>
Date: Tue, 10 Mar 2020 18:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <07f4ef9b5ff6c6c5086c9723c64c035f@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, kvmarm@lists.cs.columbia.edu
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Marc,

On 3/10/20 12:54 PM, Marc Zyngier wrote:
> On 2020-03-09 18:17, Auger Eric wrote:
>> Hi Marc,
>>
>> On 3/9/20 1:48 PM, Marc Zyngier wrote:
>>> Add a small blurb describing how the event filtering API gets used.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>> =A0Documentation/virt/kvm/devices/vcpu.rst | 40 +++++++++++++++++++++++=
++
>>> =A01 file changed, 40 insertions(+)
>>>
>>> diff --git a/Documentation/virt/kvm/devices/vcpu.rst
>>> b/Documentation/virt/kvm/devices/vcpu.rst
>>> index 9963e680770a..7262c0469856 100644
>>> --- a/Documentation/virt/kvm/devices/vcpu.rst
>>> +++ b/Documentation/virt/kvm/devices/vcpu.rst
>>> @@ -55,6 +55,46 @@ Request the initialization of the PMUv3.=A0 If using
>>> the PMUv3 with an in-kernel
>>> =A0virtual GIC implementation, this must be done after initializing the
>>> in-kernel
>>> =A0irqchip.
>>>
>>> +1.3 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_FILTER
>>> +---------------------------------------
>>> +
>>> +:Parameters: in kvm_device_attr.addr the address for a PMU event
>>> filter is a
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pointer to a struct kvm_pmu_event=
_filter
>>> +
>>> +:Returns:
>>> +
>>> +=A0=A0=A0=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +=A0=A0=A0=A0 -ENODEV: PMUv3 not supported or GIC not initialized
>>> +=A0=A0=A0=A0 -ENXIO:=A0 PMUv3 not properly configured or in-kernel irq=
chip not
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 configured as required prior to calling=
 this attribute
>>> +=A0=A0=A0=A0 -EBUSY:=A0 PMUv3 already initialized
>> maybe document -EINVAL?
> =

> Yup, definitely.
> =

>>> +=A0=A0=A0=A0 =3D=3D=3D=3D=3D=3D=3D=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +Request the installation of a PMU event filter describe as follows:
>> s/describe/described
>>> +
>>> +struct kvm_pmu_event_filter {
>>> +=A0=A0=A0 __u16=A0=A0=A0 base_event;
>>> +=A0=A0=A0 __u16=A0=A0=A0 nevents;
>>> +
>>> +#define KVM_PMU_EVENT_ALLOW=A0=A0=A0 0
>>> +#define KVM_PMU_EVENT_DENY=A0=A0=A0 1
>>> +
>>> +=A0=A0=A0 __u8=A0=A0=A0 action;
>>> +=A0=A0=A0 __u8=A0=A0=A0 pad[3];
>>> +};
>>> +
>>> +A filter range is defined as the range [@base_event, @base_event +
>>> @nevents[,
>>> +together with an @action (KVM_PMU_EVENT_ALLOW or
>>> KVM_PMU_EVENT_DENY). The
>>> +first registered range defines the global policy (global ALLOW if
>>> the first
>>> +@action is DENY, global DENY if the first @action is ALLOW).
>>> Multiple ranges
>>> +can be programmed, and must fit within the 16bit space defined by
>>> the ARMv8.1
>>> +PMU architecture.
>> what about before 8.1 where the range was 10 bits? Should it be tested
>> in the code?
> =

> It's a good point. We could test that upon installing the filter and limit
> the bitmap allocation to the minimum.
> =

>> nitpicking: It is not totally obvious what does happen if the user space
>> sets a deny filter on a range and then an allow filter on the same
>> range. it is supported but may be worth telling so? Also explain the the
>> default filtering remains "allow" by default?
> =

> Overlapping filters are easy: the last one wins. And yes, no filter means
> just that: no filter.
Actually the point I wanted to put forward is
1) set allow filter on range [0-a] -> default setting is deny and allow
[0-a] only
2) deny deny filter on rang [0-a] -> there is no "real" active filtering
anymore but default behavior still is deny. ie. you do not destroy the
bitmap on the last filter removal but on the VM removal.

Thanks

Eric

> =

> Thanks,
> =

> =A0=A0=A0=A0=A0=A0=A0 M.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
