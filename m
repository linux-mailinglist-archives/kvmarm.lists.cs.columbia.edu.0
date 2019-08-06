Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 644BA82DD0
	for <lists+kvmarm@lfdr.de>; Tue,  6 Aug 2019 10:35:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86BE94A567;
	Tue,  6 Aug 2019 04:35:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mouRfObH2OVu; Tue,  6 Aug 2019 04:35:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55D8D4A563;
	Tue,  6 Aug 2019 04:35:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71C444A531
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Aug 2019 04:35:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYjZ4pnV9Ot0 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Aug 2019 04:35:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A9734A4E6
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Aug 2019 04:35:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8EB3337;
 Tue,  6 Aug 2019 01:35:52 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DF5A73F706; Tue,  6 Aug 2019 01:35:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: arm64: Don't write junk to sysregs on reset
To: Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20190805121555.130897-1-maz@kernel.org>
 <20190805121555.130897-2-maz@kernel.org>
 <01b74492-c59f-dfd9-e439-752e6b1c53dc@huawei.com>
From: Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <7b36f1dd-e44f-af75-0e51-8f6e705e81f6@kernel.org>
Date: Tue, 6 Aug 2019 09:35:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <01b74492-c59f-dfd9-e439-752e6b1c53dc@huawei.com>
Content-Language: en-US
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

On 06/08/2019 07:29, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2019/8/5 20:15, Marc Zyngier wrote:
>> At the moment, the way we reset system registers is mildly insane:
>> We write junk to them, call the reset functions, and then check that
>> we have something else in them.
>>
>> The "fun" thing is that this can happen while the guest is running
>> (PSCI, for example). If anything in KVM has to evaluate the state
>> of a system register while junk is in there, bad thing may happen.
>>
>> Let's stop doing that. Instead, we track that we have called a
>> reset function for that register, and assume that the reset
>> function has done something. This requires fixing a couple of
>> sysreg refinition in the trap table.
>>
>> In the end, the very need of this reset check is pretty dubious,
>> as it doesn't check everything (a lot of the sysregs leave outside of
>> the sys_regs[] array). It may well be axed in the near future.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> (Regardless of whether this check is needed or not,) I tested this patch
> with kvm-unit-tests:
> 
> for i in {1..100}; do QEMU=/path/to/qemu-system-aarch64 accel=kvm 
> arch=arm64 ./run_tests.sh; done
> 
> And all the tests passed!

Great! Can I take this as a 'Tested-by:'?

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
