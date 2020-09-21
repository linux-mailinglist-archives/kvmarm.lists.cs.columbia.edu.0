Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 10CC7272702
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 16:29:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB4A4B5A9;
	Mon, 21 Sep 2020 10:29:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIC83chApnuE; Mon, 21 Sep 2020 10:29:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 672824B4FC;
	Mon, 21 Sep 2020 10:29:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 532294B4BE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 10:29:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNfyfApoVohH for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 10:29:28 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E4164B4BD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 10:29:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02F41476;
 Mon, 21 Sep 2020 07:29:27 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31A003F718;
 Mon, 21 Sep 2020 07:29:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: arm64: Match PMU error code descriptions with
 error conditions
To: Andrew Jones <drjones@redhat.com>
References: <20200921130838.37296-1-alexandru.elisei@arm.com>
 <20200921130838.37296-3-alexandru.elisei@arm.com>
 <20200921141713.dr6l6po2luqyodjx@kamzik.brq.redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <cafbf0c7-1fed-3188-3f73-50611263fc2c@arm.com>
Date: Mon, 21 Sep 2020 15:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921141713.dr6l6po2luqyodjx@kamzik.brq.redhat.com>
Content-Language: en-US
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi Andrew,

Thank you for having a look at this.

On 9/21/20 3:17 PM, Andrew Jones wrote:

> On Mon, Sep 21, 2020 at 02:08:38PM +0100, Alexandru Elisei wrote:
>> Update the description of the PMU KVM_{GET, SET}_DEVICE_ATTR error codes
>> to be a better match for the code that returns them.
>>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  Documentation/virt/kvm/devices/vcpu.rst | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
>> index 96d6cf77cb1e..5b8db30c61db 100644
>> --- a/Documentation/virt/kvm/devices/vcpu.rst
>> +++ b/Documentation/virt/kvm/devices/vcpu.rst
>> @@ -26,8 +26,8 @@ Returns:
>>  	 =======  ========================================================
>>  	 -EBUSY   The PMU overflow interrupt is already set
>>  	 -EFAULT  Error reading interrupt number
>> -	 -ENXIO   The overflow interrupt not set when attempting to get it
>> -	 -ENODEV  PMUv3 not supported
>> +	 -ENXIO   PMUv3 not supported
> I think -ENXIO matched the code better before the change.

KVM_SET_DEVICE_ATTR for KVM_ARM_VCPU_PMU_V3_IRQ returns -ENXIO if
CONFIG_KVM_ARM_PMU is not set (in include/kvm/arm_pmu.h).

But I think I understand what you mean, you're referring to
kvm_arm_pmu_v3_get_attr(), which returns -ENXIO if the irq number was not set. I
can change the description to "PMUv3 not supported or the overflow interrupt not
set when attempting to get it", what do you think?

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
