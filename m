Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBBA5BCEC5
	for <lists+kvmarm@lfdr.de>; Mon, 19 Sep 2022 16:30:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64A8E4B6F0;
	Mon, 19 Sep 2022 10:30:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6zin3fmo1TX; Mon, 19 Sep 2022 10:30:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C2C224B6E9;
	Mon, 19 Sep 2022 10:30:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 693BE4B63F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Sep 2022 10:30:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Ld0Mc1DwlbD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Sep 2022 10:30:10 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 988C94B601
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Sep 2022 10:30:09 -0400 (EDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWRm40twvzMn0m;
 Mon, 19 Sep 2022 22:25:24 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 22:30:04 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 22:30:03 +0800
Subject: Re: [kvm-unit-tests PATCH v4 07/12] arm: pmu: Basic event counter
 Tests
To: Eric Auger <eric.auger@redhat.com>
References: <20200403071326.29932-1-eric.auger@redhat.com>
 <20200403071326.29932-8-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8fa32eeb-f629-6c27-3b5f-a9a81656a679@huawei.com>
Date: Mon, 19 Sep 2022 22:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200403071326.29932-8-eric.auger@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, andrew.murray@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

Hi Eric,

A few comments when looking through the PMU test code (2 years after
the series was merged).

On 2020/4/3 15:13, Eric Auger wrote:
> Adds the following tests:
> - event-counter-config: test event counter configuration
> - basic-event-count:
>   - programs counters #0 and #1 to count 2 required events
>   (resp. CPU_CYCLES and INST_RETIRED). Counter #0 is preset
>   to a value close enough to the 32b
>   overflow limit so that we check the overflow bit is set
>   after the execution of the asm loop.
> - mem-access: counts MEM_ACCESS event on counters #0 and #1
>   with and without 32-bit overflow.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

[...]

> diff --git a/arm/pmu.c b/arm/pmu.c
> index 8c49e50..45dccf7 100644
> --- a/arm/pmu.c
> +++ b/arm/pmu.c
> @@ -38,6 +43,7 @@
>  #define SW_INCR			0x0
>  #define INST_RETIRED		0x8
>  #define CPU_CYCLES		0x11
> +#define MEM_ACCESS		0x13
>  #define INST_PREC		0x1B

The spec spells event 0x001B as INST_SPEC.

>  #define STALL_FRONTEND		0x23
>  #define STALL_BACKEND		0x24

[...]

> @@ -175,6 +188,11 @@ static inline void precise_instrs_loop(int loop, uint32_t pmcr)
>  }
>  
>  #define PMCEID1_EL0 sys_reg(3, 3, 9, 12, 7)
> +#define PMCNTENSET_EL0 sys_reg(3, 3, 9, 12, 1)
> +#define PMCNTENCLR_EL0 sys_reg(3, 3, 9, 12, 2)
> +
> +#define PMEVTYPER_EXCLUDE_EL1 BIT(31)

Unused macro.

> +#define PMEVTYPER_EXCLUDE_EL0 BIT(30)
>  
>  static bool is_event_supported(uint32_t n, bool warn)
>  {
> @@ -228,6 +246,224 @@ static void test_event_introspection(void)
>  	report(required_events, "Check required events are implemented");
>  }
>  
> +/*
> + * Extra instructions inserted by the compiler would be difficult to compensate
> + * for, so hand assemble everything between, and including, the PMCR accesses
> + * to start and stop counting. isb instructions are inserted to make sure
> + * pmccntr read after this function returns the exact instructions executed
> + * in the controlled block. Loads @loop times the data at @address into x9.
> + */
> +static void mem_access_loop(void *addr, int loop, uint32_t pmcr)
> +{
> +asm volatile(
> +	"       msr     pmcr_el0, %[pmcr]\n"
> +	"       isb\n"
> +	"       mov     x10, %[loop]\n"
> +	"1:     sub     x10, x10, #1\n"
> +	"       ldr	x9, [%[addr]]\n"
> +	"       cmp     x10, #0x0\n"
> +	"       b.gt    1b\n"
> +	"       msr     pmcr_el0, xzr\n"
> +	"       isb\n"
> +	:
> +	: [addr] "r" (addr), [pmcr] "r" (pmcr), [loop] "r" (loop)
> +	: "x9", "x10", "cc");
> +}
> +
> +static void pmu_reset(void)
> +{
> +	/* reset all counters, counting disabled at PMCR level*/
> +	set_pmcr(pmu.pmcr_ro | PMU_PMCR_LC | PMU_PMCR_C | PMU_PMCR_P);
> +	/* Disable all counters */
> +	write_sysreg_s(ALL_SET, PMCNTENCLR_EL0);
> +	/* clear overflow reg */
> +	write_sysreg(ALL_SET, pmovsclr_el0);
> +	/* disable overflow interrupts on all counters */
> +	write_sysreg(ALL_SET, pmintenclr_el1);
> +	isb();
> +}
> +
> +static void test_event_counter_config(void)
> +{
> +	int i;
> +
> +	if (!pmu.nb_implemented_counters) {
> +		report_skip("No event counter, skip ...");
> +		return;
> +	}
> +
> +	pmu_reset();
> +
> +	/*
> +	 * Test setting through PMESELR/PMXEVTYPER and PMEVTYPERn read,

s/PMESELR/PMSELR/ ?

> +	 * select counter 0
> +	 */
> +	write_sysreg(1, PMSELR_EL0);
> +	/* program this counter to count unsupported event */
> +	write_sysreg(0xEA, PMXEVTYPER_EL0);
> +	write_sysreg(0xdeadbeef, PMXEVCNTR_EL0);
> +	report((read_regn_el0(pmevtyper, 1) & 0xFFF) == 0xEA,
> +		"PMESELR/PMXEVTYPER/PMEVTYPERn");

Ditto

> +	report((read_regn_el0(pmevcntr, 1) == 0xdeadbeef),
> +		"PMESELR/PMXEVCNTR/PMEVCNTRn");

Ditto

> +
> +	/* try to configure an unsupported event within the range [0x0, 0x3F] */
> +	for (i = 0; i <= 0x3F; i++) {
> +		if (!is_event_supported(i, false))
> +			break;
> +	}
> +	if (i > 0x3F) {
> +		report_skip("pmevtyper: all events within [0x0, 0x3F] are supported");
> +		return;
> +	}
> +
> +	/* select counter 0 */
> +	write_sysreg(0, PMSELR_EL0);
> +	/* program this counter to count unsupported event */

We get the unsupported event number *i* but don't program it into
PMXEVTYPER_EL0 (or PMEVTYPER0_EL0). Is it intentional?

> +	write_sysreg(i, PMXEVCNTR_EL0);
> +	/* read the counter value */
> +	read_sysreg(PMXEVCNTR_EL0);
> +	report(read_sysreg(PMXEVCNTR_EL0) == i,
> +		"read of a counter programmed with unsupported event");
> +
> +}

[...]

> +
> +static void test_mem_access(void)
> +{
> +	void *addr = malloc(PAGE_SIZE);

*addr* isn't freed at the end of test_mem_access(). The same in
test_chain_promotion() and test_overflow_interrupt().

Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
