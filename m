Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A9C126BD87
	for <lists+kvmarm@lfdr.de>; Wed, 17 Jul 2019 15:45:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A7A0C4A563;
	Wed, 17 Jul 2019 09:45:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hn93T3uEKKxJ; Wed, 17 Jul 2019 09:45:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 541D14A561;
	Wed, 17 Jul 2019 09:45:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9247D4A53B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 09:45:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14Vn5BrKWpoQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Jul 2019 09:45:03 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E00424A52D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Jul 2019 09:45:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 645C5337;
 Wed, 17 Jul 2019 06:45:03 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33683F71A;
 Wed, 17 Jul 2019 06:45:01 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Assign pmc->idx before
 kvm_pmu_stop_counter()
To: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <01fa98c1-8274-445c-5e04-219372920ba2@arm.com>
Date: Wed, 17 Jul 2019 14:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1563366019-31200-1-git-send-email-yuzenghui@huawei.com>
Content-Language: en-US
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org
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

Hi Zenghui,

On 17/07/2019 13:20, Zenghui Yu wrote:
> We use "pmc->idx" and the "chained" bitmap to determine if the pmc is
> chained, in kvm_pmu_pmc_is_chained().  But idx might be uninitialized
> (and random) when we doing this decision, through a KVM_ARM_VCPU_INIT
> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this random
> idx will potentially hit a KASAN BUG [1].
> 
> Fix it by moving the assignment of idx before kvm_pmu_stop_counter().
> 
> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
> 
> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
> Suggested-by: Andrew Murray <andrew.murray@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>> ---
>  virt/kvm/arm/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 3dd8238..521bfdd 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -225,8 +225,8 @@ void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
>  
>  	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++) {
> -		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
>  		pmu->pmc[i].idx = i;

Yes, this is kind of a static property that should really be part of a
"kvm_pmu_vcpu_init()" or "kvm_pmu_vcpu_create()" and is not expected to
be modified across resets...

There is no such function at the time and I'm unsure whether this
warrants creating that separate function (I would still suggest creating
it to make things clearer).

> +		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);

Whatever other opinions are on splitting pmu_vcpu_init/reset, that
change makes sense and fixes the issue:

Acked-by: Julien Thierry <julien.thierry@arm.com>

>  	}
>  
>  	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
> 

Cheers,

-- 
Julien Thierry
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
