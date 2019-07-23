Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6E713EC
	for <lists+kvmarm@lfdr.de>; Tue, 23 Jul 2019 10:26:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D3104A576;
	Tue, 23 Jul 2019 04:26:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd-GShqTDLwu; Tue, 23 Jul 2019 04:26:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 17BAB4A55D;
	Tue, 23 Jul 2019 04:26:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DAAC14A54B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jul 2019 04:26:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v1kPJdaDbATP for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Jul 2019 04:26:08 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9F63A4A535
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jul 2019 04:26:08 -0400 (EDT)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1hpq7Z-0006kD-Aa; Tue, 23 Jul 2019 10:26:05 +0200
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2] KVM: arm/arm64: Introduce =?UTF-8?Q?kvm=5Fpmu=5Fvc?=
 =?UTF-8?Q?pu=5Finit=28=29=20to=20setup=20PMU=20counter=20idx?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Tue, 23 Jul 2019 09:26:04 +0100
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <f3f6f9a9-9735-e253-7b5b-3ccf97619a16@arm.com>
References: <1563437710-30756-1-git-send-email-yuzenghui@huawei.com>
 <f3f6f9a9-9735-e253-7b5b-3ccf97619a16@arm.com>
Message-ID: <d5c0d757232935c6446aeaca9afe4416@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: julien.thierry@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
 linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
 andrew.murray@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

On 2019-07-23 09:17, Julien Thierry wrote:
> Hi Zenghui,
>
> On 18/07/2019 09:15, Zenghui Yu wrote:
>> We use "pmc->idx" and the "chained" bitmap to determine if the pmc 
>> is
>> chained, in kvm_pmu_pmc_is_chained().  But idx might be 
>> uninitialized
>> (and random) when we doing this decision, through a 
>> KVM_ARM_VCPU_INIT
>> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this 
>> random
>> idx will potentially hit a KASAN BUG [1].
>>
>> In general, idx is the static property of a PMU counter that is not
>> expected to be modified across resets, as suggested by Julien.  It
>> looks more reasonable if we can setup the PMU counter idx for a vcpu
>> in its creation time. Introduce a new function - kvm_pmu_vcpu_init()
>> for this basic setup. Oh, and the KASAN BUG will get fixed this way.
>>
>> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
>>
>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>> Suggested-by: Andrew Murray <andrew.murray@arm.com>
>> Suggested-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> Changes since v1:
>>  - Introduce kvm_pmu_vcpu_init() in vcpu's creation time, move the
>>    assignment of pmc->idx into it.
>>  - Thus change the subject. The old one is "KVM: arm/arm64: Assign
>>    pmc->idx before kvm_pmu_stop_counter()".
>>
>> Julien, I haven't collected your Acked-by into this version. If 
>> you're
>> still happy with the change, please Ack again. Thanks!
>>
>
> Thanks for making the change. This looks good to me:
>
> Acked-by: Julien Thierry <julien.thierry@arm.com>

Applied, thanks both.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
