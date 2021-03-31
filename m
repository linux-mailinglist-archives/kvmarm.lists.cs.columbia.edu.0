Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83E76347B1D
	for <lists+kvmarm@lfdr.de>; Wed, 24 Mar 2021 15:49:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 06F594B2D4;
	Wed, 24 Mar 2021 10:49:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M+0GQobu+rcw; Wed, 24 Mar 2021 10:49:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BCE4F4B3A8;
	Wed, 24 Mar 2021 10:49:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B8E1C4B3A8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 10:49:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJxhL5OOlZVR for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Mar 2021 10:49:40 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 686CF4B119
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Mar 2021 10:49:40 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14571FB;
 Wed, 24 Mar 2021 07:49:39 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C4793F7D7;
 Wed, 24 Mar 2021 07:49:38 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] arm: pmu: Fix failing PMU test when no PMU
 is available
To: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20210324143856.2079220-1-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <23046a95-5876-e7a2-e4a4-6012a760815d@arm.com>
Date: Wed, 24 Mar 2021 14:50:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324143856.2079220-1-maz@kernel.org>
Content-Language: en-US
Cc: Andrew Walbran <qwandor@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kernel-team@android.com
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

Thank you for the patch! I have already sent a patch for this [1], which was
queued by Drew [2], but apparently has not landed in master yet.

[1] https://www.spinics.net/lists/kvm-arm/msg44084.html
[2]
https://gitlab.com/rhdrjones/kvm-unit-tests/-/commit/241dac4cadfd7d7ace8c8c3f0613376311b4e785


Thanks,

Alex

On 3/24/21 2:38 PM, Marc Zyngier wrote:
> The PMU unit tests fail with an UNDEF exception when no PMU
> is available (although KVM hasn't been totally consistent
> with that in the past).
>
> This is caused by PMCR_EL0 being read *before* ID_AA64DFR0_EL1
> is checked for the PMU version.
>
> Move the PMCR_EL0 access to a reasonable place, which allows the
> test to soft-fail gracefully.
>
> Fixes: 784ee933fa5f ("arm: pmu: Introduce defines for PMU versions")
> Reported-by: Andrew Walbran <qwandor@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arm/pmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arm/pmu.c b/arm/pmu.c
> index cc959e6..15c542a 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -988,7 +988,7 @@ static void pmccntr64_test(void)
>  /* Return FALSE if no PMU found, otherwise return TRUE */
>  static bool pmu_probe(void)
>  {
> -	uint32_t pmcr = get_pmcr();
> +	uint32_t pmcr;
>  	uint8_t implementer;
>  
>  	pmu.version = get_pmu_version();
> @@ -997,6 +997,7 @@ static bool pmu_probe(void)
>  
>  	report_info("PMU version: 0x%x", pmu.version);
>  
> +	pmcr = get_pmcr();
>  	implementer = (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK;
>  	report_info("PMU implementer/ID code: %#"PRIx32"(\"%c\")/%#"PRIx32,
>  		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
