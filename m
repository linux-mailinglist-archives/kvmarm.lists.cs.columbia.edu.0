Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80C84DE2
	for <lists+kvmarm@lfdr.de>; Wed,  7 Aug 2019 15:51:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 009E54A56D;
	Wed,  7 Aug 2019 09:51:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4JxwREf3P0+e; Wed,  7 Aug 2019 09:51:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0F0B4A56A;
	Wed,  7 Aug 2019 09:51:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ADF14A4F7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Aug 2019 09:51:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apm3pDRbWnap for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Aug 2019 09:51:18 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 726044A4F5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Aug 2019 09:51:18 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D9F228;
 Wed,  7 Aug 2019 06:51:18 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D77E03F706; Wed,  7 Aug 2019 06:51:16 -0700 (PDT)
Subject: Re: [PATCH 6/9] KVM: arm64: Provide a PV_TIME device to user space
To: Steven Price <steven.price@arm.com>
References: <20190802145017.42543-1-steven.price@arm.com>
 <20190802145017.42543-7-steven.price@arm.com> <20190803135113.6cdf500c@why>
 <20190803183335.149e0113@why> <5aa54066-b9f6-22d1-fa2b-ce5cbf244ab5@arm.com>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <9c416f28-d078-4575-8095-8b4cccfe40ec@kernel.org>
Date: Wed, 7 Aug 2019 14:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5aa54066-b9f6-22d1-fa2b-ce5cbf244ab5@arm.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 07/08/2019 14:39, Steven Price wrote:
> On 03/08/2019 18:34, Marc Zyngier wrote:
>> On Sat, 3 Aug 2019 13:51:13 +0100
>> Marc Zyngier <maz@kernel.org> wrote:
>>
>> [forgot that one]
>>
>>> On Fri,  2 Aug 2019 15:50:14 +0100
>>> Steven Price <steven.price@arm.com> wrote:
>>
>> [...]
>>
>>>> +static int __init kvm_pvtime_init(void)
>>>> +{
>>>> +	kvm_register_device_ops(&pvtime_ops, KVM_DEV_TYPE_ARM_PV_TIME);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +late_initcall(kvm_pvtime_init);
>>
>> Why is it an initcall? So far, the only initcall we've used is the one
>> that initializes KVM itself. Can't we just the device_ops just like we
>> do for the vgic?
> 
> So would you prefer a direct call from init_subsystems() in
> virt/kvm/arm/arm.c?

Yes. Consistency is important.

> The benefit of initcall is just that it keeps the code self-contained.
> In init_subsystems() I'd either need a #ifdef CONFIG_ARM64 or a dummy
> function for arm.

Having a dummy function for 32bit ARM is fine. Most of the code we add
to the 32bit port is made of empty stubs anyway.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
