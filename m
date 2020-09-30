Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DB88F27E8AA
	for <lists+kvmarm@lfdr.de>; Wed, 30 Sep 2020 14:36:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74A864B405;
	Wed, 30 Sep 2020 08:36:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3K5jEEs85sa; Wed, 30 Sep 2020 08:36:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4243B4B3E0;
	Wed, 30 Sep 2020 08:36:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BB244B1B2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 08:36:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HnJmVaEsPmjo for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Sep 2020 08:36:49 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D2B444B1B1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Sep 2020 08:36:49 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FFC530E;
 Wed, 30 Sep 2020 05:36:49 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EF553F6CF;
 Wed, 30 Sep 2020 05:36:47 -0700 (PDT)
Subject: Re: [PATCH v7 5/7] KVM: arm64: pmu: Make overflow handler NMI safe
To: Will Deacon <will@kernel.org>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
 <20200924110706.254996-6-alexandru.elisei@arm.com>
 <20200928175725.GB11792@willie-the-truck>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <6b1ecdef-3a42-c428-2309-753b1470e3de@arm.com>
Date: Wed, 30 Sep 2020 13:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928175725.GB11792@willie-the-truck>
Content-Language: en-US
Cc: sumit.garg@linaro.org, kvm@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, maz@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
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

Hi Will,

On 9/28/20 6:57 PM, Will Deacon wrote:

> On Thu, Sep 24, 2020 at 12:07:04PM +0100, Alexandru Elisei wrote:
>> From: Julien Thierry <julien.thierry@arm.com>
>>
>> kvm_vcpu_kick() is not NMI safe. When the overflow handler is called from
>> NMI context, defer waking the vcpu to an irq_work queue.
>>
>> A vcpu can be freed while it's not running by kvm_destroy_vm(). Prevent
>> running the irq_work for a non-existent vcpu by calling irq_work_sync() on
>> the PMU destroy path.
>>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
>> Cc: kvm@vger.kernel.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
>> [Alexandru E.: Added irq_work_sync()]
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>> I suggested in v6 that I will add an irq_work_sync() to
>> kvm_pmu_vcpu_reset(). It turns out it's not necessary: a vcpu reset is done
>> by the vcpu being reset with interrupts enabled, which means all the work
>> has had a chance to run before the reset takes place.
> I don't understand this ^^

Marc had the same comment, I replied in his email. I thought about it and you're
right, it doesn't make much sense.

>
> But the patch itself looks good, so I'm going to queue this lot anyway!

Thank you for picking up the series!

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
