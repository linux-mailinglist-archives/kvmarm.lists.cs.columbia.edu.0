Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADD17F6CA
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 12:54:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 338894A5A0;
	Tue, 10 Mar 2020 07:54:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97Q1xDFAHtK3; Tue, 10 Mar 2020 07:54:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 014614A534;
	Tue, 10 Mar 2020 07:54:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F63A4A4A0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 07:54:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJjdPKFJJslj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 07:54:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DD094A1B0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 07:54:52 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49D5B2464B;
 Tue, 10 Mar 2020 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583841291;
 bh=oHt26cI0evbqGQu3N7YOlcKoUwgoa88DrVqzHJqkdEw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j3UGAoUogik5p9i5EPRsvGFc8i4r+/KdQnG9teAjKg3+Ld3RyOoDWINtKMATN8Z9k
 kZ1UniPntVhawKyyaOl0XqSyHRs1u016YYBMkpBKfVXVZ82CFWwQRJlWU3vPvA6akY
 00fJiFeTZYd2IGtSz1+9hLWDFvkvESMmIdfjsvl0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jBdTF-00BYBZ-DK; Tue, 10 Mar 2020 11:54:49 +0000
MIME-Version: 1.0
Date: Tue, 10 Mar 2020 11:54:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: Document PMU filtering API
In-Reply-To: <7943c896-013b-d9cb-ba89-2040b46437fe@redhat.com>
References: <20200309124837.19908-1-maz@kernel.org>
 <20200309124837.19908-3-maz@kernel.org>
 <7943c896-013b-d9cb-ba89-2040b46437fe@redhat.com>
Message-ID: <07f4ef9b5ff6c6c5086c9723c64c035f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, robin.murphy@arm.com,
 mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-03-09 18:17, Auger Eric wrote:
> Hi Marc,
> 
> On 3/9/20 1:48 PM, Marc Zyngier wrote:
>> Add a small blurb describing how the event filtering API gets used.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  Documentation/virt/kvm/devices/vcpu.rst | 40 
>> +++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/Documentation/virt/kvm/devices/vcpu.rst 
>> b/Documentation/virt/kvm/devices/vcpu.rst
>> index 9963e680770a..7262c0469856 100644
>> --- a/Documentation/virt/kvm/devices/vcpu.rst
>> +++ b/Documentation/virt/kvm/devices/vcpu.rst
>> @@ -55,6 +55,46 @@ Request the initialization of the PMUv3.  If using 
>> the PMUv3 with an in-kernel
>>  virtual GIC implementation, this must be done after initializing the 
>> in-kernel
>>  irqchip.
>> 
>> +1.3 ATTRIBUTE: KVM_ARM_VCPU_PMU_V3_FILTER
>> +---------------------------------------
>> +
>> +:Parameters: in kvm_device_attr.addr the address for a PMU event 
>> filter is a
>> +             pointer to a struct kvm_pmu_event_filter
>> +
>> +:Returns:
>> +
>> +	 =======  ======================================================
>> +	 -ENODEV: PMUv3 not supported or GIC not initialized
>> +	 -ENXIO:  PMUv3 not properly configured or in-kernel irqchip not
>> +	 	  configured as required prior to calling this attribute
>> +	 -EBUSY:  PMUv3 already initialized
> maybe document -EINVAL?

Yup, definitely.

>> +	 =======  ======================================================
>> +
>> +Request the installation of a PMU event filter describe as follows:
> s/describe/described
>> +
>> +struct kvm_pmu_event_filter {
>> +	__u16	base_event;
>> +	__u16	nevents;
>> +
>> +#define KVM_PMU_EVENT_ALLOW	0
>> +#define KVM_PMU_EVENT_DENY	1
>> +
>> +	__u8	action;
>> +	__u8	pad[3];
>> +};
>> +
>> +A filter range is defined as the range [@base_event, @base_event + 
>> @nevents[,
>> +together with an @action (KVM_PMU_EVENT_ALLOW or KVM_PMU_EVENT_DENY). 
>> The
>> +first registered range defines the global policy (global ALLOW if the 
>> first
>> +@action is DENY, global DENY if the first @action is ALLOW). Multiple 
>> ranges
>> +can be programmed, and must fit within the 16bit space defined by the 
>> ARMv8.1
>> +PMU architecture.
> what about before 8.1 where the range was 10 bits? Should it be tested
> in the code?

It's a good point. We could test that upon installing the filter and 
limit
the bitmap allocation to the minimum.

> nitpicking: It is not totally obvious what does happen if the user 
> space
> sets a deny filter on a range and then an allow filter on the same
> range. it is supported but may be worth telling so? Also explain the 
> the
> default filtering remains "allow" by default?

Overlapping filters are easy: the last one wins. And yes, no filter 
means
just that: no filter.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
