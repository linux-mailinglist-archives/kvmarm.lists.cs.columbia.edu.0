Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B47C52555F
	for <lists+kvmarm@lfdr.de>; Tue, 21 May 2019 18:15:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4075B4A508;
	Tue, 21 May 2019 12:15:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1lgm2UYB1Tp; Tue, 21 May 2019 12:15:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE72F4A4FD;
	Tue, 21 May 2019 12:15:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 538C04A4A0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 12:15:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOHXtO3wSVgy for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 May 2019 12:15:27 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF12D4A477
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 12:15:26 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F3C374;
 Tue, 21 May 2019 09:15:26 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8613F718;
 Tue, 21 May 2019 09:15:25 -0700 (PDT)
Subject: Re: [PATCH v7 4/5] arm64: perf: extract chain helper into header
To: andrew.murray@arm.com, christoffer.dall@arm.com, marc.zyngier@arm.com
References: <20190521155228.903-1-andrew.murray@arm.com>
 <20190521155228.903-5-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3061cf77-840e-4197-afc3-ff91a33a9cdf@arm.com>
Date: Tue, 21 May 2019 17:15:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521155228.903-5-andrew.murray@arm.com>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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



On 21/05/2019 16:52, Andrew Murray wrote:
> The ARMv8 Performance Monitors Extension includes an architectural
> event type named CHAIN which allows for chaining counters together.
> 
> Let's extract the test for this event into a header file such that
> other users, such as KVM (for PMU emulation) can make use of.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/include/asm/perf_event.h | 5 +++++
>   arch/arm64/kernel/perf_event.c      | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index c593761ba61c..cd13f3fd1055 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -219,6 +219,11 @@
>   #define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
>   #define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
>   
> +static inline bool armv8pmu_evtype_is_chain(u64 evtype)
> +{
> +	return (evtype == ARMV8_PMUV3_PERFCTR_CHAIN);
> +}
> +
>   #ifdef CONFIG_PERF_EVENTS
>   struct pt_regs;
>   extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 314b1adedf06..265bd835a724 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -879,7 +879,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>   static int armv8pmu_filter_match(struct perf_event *event)
>   {
>   	unsigned long evtype = event->hw.config_base & ARMV8_PMU_EVTYPE_EVENT;
> -	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
> +	return !armv8pmu_evtype_is_chain(evtype);
>   }
>   
>   static void armv8pmu_reset(void *info)
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
