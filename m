Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1362B66959
	for <lists+kvmarm@lfdr.de>; Fri, 12 Jul 2019 10:51:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 857B64A53D;
	Fri, 12 Jul 2019 04:51:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3es4AXReXXU; Fri, 12 Jul 2019 04:51:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA8164A516;
	Fri, 12 Jul 2019 04:51:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27CBC4A4C1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 04:51:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n54OnlO2+j2S for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Jul 2019 04:51:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 095E74A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 04:51:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0EB28;
 Fri, 12 Jul 2019 01:51:10 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 BE0363F59C; Fri, 12 Jul 2019 01:51:09 -0700 (PDT)
Subject: Re: [PATCH kvm-unit-tests] arm: Add PL031 test
To: Alexander Graf <graf@amazon.com>, kvm@vger.kernel.org
References: <20190710132724.28350-1-graf@amazon.com>
 <212cc76d-0d67-cb75-5f7f-d707778bbeff@arm.com>
 <d2c7d9e4-c6e2-8437-66ae-b7d221090b5f@amazon.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <4e6fd752-23d5-bf5f-3a9d-e5c301f588ee@arm.com>
Date: Fri, 12 Jul 2019 09:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d2c7d9e4-c6e2-8437-66ae-b7d221090b5f@amazon.com>
Content-Language: en-US
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On 12/07/2019 09:29, Alexander Graf wrote:
> 
> 
> On 10.07.19 16:25, Marc Zyngier wrote:
>> Hi Alex,
>>
>> I don't know much about pl031, so my comments are pretty general...
>>
>> On 10/07/2019 14:27, Alexander Graf wrote:
>>> This patch adds a unit test for the PL031 RTC that is used in the virt machine.
>>> It just pokes basic functionality. I've mostly written it to familiarize myself
>>> with the device, but I suppose having the test around does not hurt, as it also
>>> exercises the GIC SPI interrupt path.
>>>
>>> Signed-off-by: Alexander Graf <graf@amazon.com>
>>> ---
>>>   arm/Makefile.common |   1 +
>>>   arm/pl031.c         | 227 ++++++++++++++++++++++++++++++++++++++++++++
>>>   lib/arm/asm/gic.h   |   1 +
>>>   3 files changed, 229 insertions(+)
>>>   create mode 100644 arm/pl031.c
>>>
>>> diff --git a/arm/Makefile.common b/arm/Makefile.common
>>> index f0c4b5d..b8988f2 100644
>>> --- a/arm/Makefile.common
>>> +++ b/arm/Makefile.common
>>> @@ -11,6 +11,7 @@ tests-common += $(TEST_DIR)/pmu.flat
>>>   tests-common += $(TEST_DIR)/gic.flat
>>>   tests-common += $(TEST_DIR)/psci.flat
>>>   tests-common += $(TEST_DIR)/sieve.flat
>>> +tests-common += $(TEST_DIR)/pl031.flat
>>>   
>>>   tests-all = $(tests-common) $(tests)
>>>   all: directories $(tests-all)
>>> diff --git a/arm/pl031.c b/arm/pl031.c
>>> new file mode 100644
>>> index 0000000..a364a1a
>>> --- /dev/null
>>> +++ b/arm/pl031.c
>>> @@ -0,0 +1,227 @@
>>> +/*
>>> + * Verify PL031 functionality
>>> + *
>>> + * This test verifies whether the emulated PL031 behaves correctly.
>>> + *
>>> + * Copyright 2019 Amazon.com, Inc. or its affiliates.
>>> + * Author: Alexander Graf <graf@amazon.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU LGPL, version 2.
>>> + */
>>> +#include <libcflat.h>
>>> +#include <asm/processor.h>
>>> +#include <asm/io.h>
>>> +#include <asm/gic.h>
>>> +
>>> +static u32 cntfrq;
>>> +
>>> +#define PL031_BASE 0x09010000
>>> +#define PL031_IRQ 2
>>
>> Does the unit test framework have a way to extract this from the firmware tables?
>> That'd be much nicer...
> 
> It does, I've moved it to that now :).
> 
>>
>>> +
>>> +struct pl031_regs {
>>> +	uint32_t dr;	/* Data Register */
>>> +	uint32_t mr;	/* Match Register */
>>> +	uint32_t lr;	/* Load Register */
>>> +	union {
>>> +		uint8_t cr;	/* Control Register */
>>> +		uint32_t cr32;
>>> +	};
>>> +	union {
>>> +		uint8_t imsc;	/* Interrupt Mask Set or Clear register */
>>> +		uint32_t imsc32;
>>> +	};
>>> +	union {
>>> +		uint8_t ris;	/* Raw Interrupt Status */
>>> +		uint32_t ris32;
>>> +	};
>>> +	union {
>>> +		uint8_t mis;	/* Masked Interrupt Status */
>>> +		uint32_t mis32;
>>> +	};
>>> +	union {
>>> +		uint8_t icr;	/* Interrupt Clear Register */
>>> +		uint32_t icr32;
>>> +	};
>>> +	uint32_t reserved[1008];
>>> +	uint32_t periph_id[4];
>>> +	uint32_t pcell_id[4];
>>> +};
>>> +
>>> +static struct pl031_regs *pl031 = (void*)PL031_BASE;
>>> +static void *gic_ispendr;
>>> +static void *gic_isenabler;
>>> +static bool irq_triggered;
>>> +
>>> +static int check_id(void)
>>> +{
>>> +	uint32_t id[] = { 0x31, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(id); i++)
>>> +		if (id[i] != readl(&pl031->periph_id[i]))
>>> +			return 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int check_ro(void)
>>> +{
>>> +	uint32_t offs[] = { offsetof(struct pl031_regs, ris),
>>> +			    offsetof(struct pl031_regs, mis),
>>> +			    offsetof(struct pl031_regs, periph_id[0]),
>>> +			    offsetof(struct pl031_regs, periph_id[1]),
>>> +			    offsetof(struct pl031_regs, periph_id[2]),
>>> +			    offsetof(struct pl031_regs, periph_id[3]),
>>> +			    offsetof(struct pl031_regs, pcell_id[0]),
>>> +			    offsetof(struct pl031_regs, pcell_id[1]),
>>> +			    offsetof(struct pl031_regs, pcell_id[2]),
>>> +			    offsetof(struct pl031_regs, pcell_id[3]) };
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(offs); i++) {
>>> +		uint32_t before32;
>>> +		uint16_t before16;
>>> +		uint8_t before8;
>>> +		void *addr = (void*)pl031 + offs[i];
>>> +		uint32_t poison = 0xdeadbeefULL;
>>> +
>>> +		before8 = readb(addr);
>>> +		before16 = readw(addr);
>>> +		before32 = readl(addr);
>>> +
>>> +		writeb(poison, addr);
>>> +		writew(poison, addr);
>>> +		writel(poison, addr);
>>> +
>>> +		if (before8 != readb(addr))
>>> +			return 1;
>>> +		if (before16 != readw(addr))
>>> +			return 1;
>>> +		if (before32 != readl(addr))
>>> +			return 1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int check_rtc_freq(void)
>>> +{
>>> +	uint32_t seconds_to_wait = 2;
>>> +	uint32_t before = readl(&pl031->dr);
>>> +	uint64_t before_tick = read_sysreg(cntpct_el0);
>>
>> Hmmm. See below.
>>
>>> +	uint64_t target_tick = before_tick + (cntfrq * seconds_to_wait);
>>> +
>>> +	/* Wait for 2 seconds */
>>> +	while (read_sysreg(cntpct_el0) < target_tick) ;
>>
>> Careful here. The control dependency saves you, but in general we want
>> to guarantee some stronger ordering when it comes to the counter. The
>> Linux kernel has the following:
>>
>> /*
>>   * Ensure that reads of the counter are treated the same as memory reads
>>   * for the purposes of ordering by subsequent memory barriers.
>>   *
>>   * This insanity brought to you by speculative system register reads,
>>   * out-of-order memory accesses, sequence locks and Thomas Gleixner.
>>   *
>>   * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
>>   */
>> #define arch_counter_enforce_ordering(val) do {                         \
>>          u64 tmp, _val = (val);                                          \
>>                                                                          \
>>          asm volatile(                                                   \
>>          "       eor     %0, %1, %1\n"                                   \
>>          "       add     %0, sp, %0\n"                                   \
>>          "       ldr     xzr, [%0]"                                      \
>>          : "=r" (tmp) : "r" (_val));                                     \
>> } while (0)
>>
>> static __always_inline u64 __arch_counter_get_cntpct_stable(void)
>> {
>>          u64 cnt;
>>
>>          isb();
>>          cnt = arch_timer_reg_read_stable(cntpct_el0);
>>          arch_counter_enforce_ordering(cnt);
>>          return cnt;
>> }
>>
>> The initial ISB prevents the counter read from being reordered with earlier
>> instructions, while the fake memory dependency enforces ordering with
>> subsequent memory accesses. You're welcome ;-).
> 
> Do we really care enough in this case? It seems a bit overkill. The 
> worst thing that happens is that we wiggle around the 2 second mark a 
> bit and don't hit it right on the spot, no?

Well, on a highly speculative core, you should be able to get about any
timing you can imagine if you don't have actual synchronization. At
least the ISB should definitely be there.

> 
>>
>>> +
>>> +	if (readl(&pl031->dr) != before + seconds_to_wait)
>>> +		return 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static bool gic_irq_pending(void)
>>> +{
>>> +	return readl(gic_ispendr + 4) & (1 << (SPI(PL031_IRQ) - 32));
>>
>> nit: you may want to make the offset depend on the interrupt itself...
> 
> Yes, definitely :).
> 
>>
>>> +}
>>> +
>>> +static void gic_irq_unmask(void)
>>> +{
>>> +	writel(1 << (SPI(PL031_IRQ) - 32), gic_isenabler + 4);
>>> +}
>>> +
>>> +static void irq_handler(struct pt_regs *regs)
>>> +{
>>> +	u32 irqstat = gic_read_iar();
>>
>> GICv3 requires a DSB SY after reading IAR. Is that included in gic_read_iar()?
> 
> Looks like it:
> 
> static inline u32 gicv3_read_iar(void)
> {
>          u64 irqstat;
>          asm volatile("mrs_s %0, " xstr(ICC_IAR1_EL1) : "=r" (irqstat));
>          dsb(sy);
>          return (u64)irqstat;
> }
> 
> Looks like Andre reviewed the code that introduced the GIC logic well :).

Well, I haven't read the GIC code in kvm-unit-tests, hence my questions...

> 
>>
>>> +	u32 irqnr = gic_iar_irqnr(irqstat);
>>> +
>>> +	if (irqnr != GICC_INT_SPURIOUS)
>>> +		gic_write_eoir(irqstat);
>>
>> You can always EOI spurious. Are you guaranteed to be in EOImode==0?
>> If not, you'd need an extra write to DIR. Also, this needs an ISB
> 
> I copied that bit from the timer test. I'll be happy to remove the 
> spurious check though.
> 
> We have the following in gicv3_enable_defaults() which IIUC clears the 
> EOImode bit, right?
> 
>          writel(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | 
> GICD_CTLR_ENABLE_G1,
>                 dist + GICD_CTLR);

OK then.

>> for GICv3.
> 
> The ISB is there already:
> 
> static inline void gicv3_write_eoir(u32 irq)
> {
>          asm volatile("msr_s " xstr(ICC_EOIR1_EL1) ", %0" : : "r" 
> ((u64)irq));
>          isb();
> }

Good.

> 
>>
>>> +
>>> +	if (irqnr == SPI(PL031_IRQ)) {
>>> +		report("  RTC RIS == 1", readl(&pl031->ris) == 1);
>>> +		report("  RTC MIS == 1", readl(&pl031->mis) == 1);
>>> +
>>> +		/* Writing any value should clear IRQ status */
>>> +		writel(0x80000000ULL, &pl031->icr);
>>> +
>>> +		report("  RTC RIS == 0", readl(&pl031->ris) == 0);
>>> +		report("  RTC MIS == 0", readl(&pl031->mis) == 0);
>>> +		irq_triggered = true;
>>> +	} else {
>>> +		report_info("Unexpected interrupt: %d\n", irqnr);
>>> +		return;
>>> +	}
>>> +}
>>> +
>>> +static int check_rtc_irq(void)
>>> +{
>>> +	uint32_t seconds_to_wait = 1;
>>> +	uint32_t before = readl(&pl031->dr);
>>> +	uint64_t before_tick = read_sysreg(cntpct_el0);
>>
>> Same problem as above.
>>
>>> +	uint64_t target_tick = before_tick + (cntfrq * (seconds_to_wait + 1));
>>> +
>>> +	report_info("Checking IRQ trigger (MR)");
>>> +
>>> +	irq_triggered = false;
>>> +
>>> +	/* Fire IRQ in 1 second */
>>> +	writel(before + seconds_to_wait, &pl031->mr);
>>> +
>>> +	install_irq_handler(EL1H_IRQ, irq_handler);
>>> +
>>> +	/* Wait until 2 seconds are over */
>>> +	while (read_sysreg(cntpct_el0) < target_tick) ;
>>> +
>>> +	report("  RTC IRQ not delivered without mask", !gic_irq_pending());
>>> +
>>> +	/* Mask the IRQ so that it gets delivered */
>>> +	writel(1, &pl031->imsc);
>>> +	report("  RTC IRQ pending now", gic_irq_pending());
>>> +
>>> +	/* Enable retrieval of IRQ */
>>> +	gic_irq_unmask();
>>> +	local_irq_enable();
>>> +
>>> +	report("  IRQ triggered", irq_triggered);
>>> +	report("  RTC IRQ not pending anymore", !gic_irq_pending());
>>> +	if (!irq_triggered) {
>>> +		report_info("  RTC RIS: %x", readl(&pl031->ris));
>>> +		report_info("  RTC MIS: %x", readl(&pl031->mis));
>>> +		report_info("  RTC IMSC: %x", readl(&pl031->imsc));
>>> +		report_info("  GIC IRQs pending: %08x %08x", readl(gic_ispendr), readl(gic_ispendr + 4));
>>> +	}
>>> +
>>> +	local_irq_disable();
>>> +	return 0;
>>> +}
>>> +
>>> +static void rtc_irq_init(void)
>>> +{
>>> +	gic_enable_defaults();
>>> +
>>> +	switch (gic_version()) {
>>> +	case 2:
>>> +		gic_ispendr = gicv2_dist_base() + GICD_ISPENDR;
>>> +		gic_isenabler = gicv2_dist_base() + GICD_ISENABLER;
>>> +		break;
>>> +	case 3:
>>> +		gic_ispendr = gicv3_sgi_base() + GICD_ISPENDR;
>>> +		gic_isenabler = gicv3_sgi_base() + GICD_ISENABLER;
>>
>> This only points to SGIs and PPIs. How does it work on GICv3?
>> Let me guess: you haven't tested it... ;-)
> 
> I tested it, then it failed, then I forgot about it :)
> 
> I take it that on GICv3, SPIs live somewhere else?

They live in the distributor, just like on GICv2. Only the cpu-private
interrupts are located in the redistributors.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
