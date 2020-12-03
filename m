Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E92CD688
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 14:20:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 430214B1B0;
	Thu,  3 Dec 2020 08:20:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnO3Uc2ifXlx; Thu,  3 Dec 2020 08:20:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D91DB4B19D;
	Thu,  3 Dec 2020 08:20:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99F524B1A7
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 08:20:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mv97kWC-F1Y for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 08:20:35 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 218444B19A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 08:20:35 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC80E11D4;
 Thu,  3 Dec 2020 05:20:34 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3B1E3F718;
 Thu,  3 Dec 2020 05:20:33 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 05/10] arm/arm64: gic: Use correct memory
 ordering for the IPI test
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
 <20201125155113.192079-6-alexandru.elisei@arm.com>
 <89585694-e188-9f8c-de71-29f8baa89dd7@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <7bb38de0-e06a-085c-98d2-cbce62ba31b3@arm.com>
Date: Thu, 3 Dec 2020 13:21:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <89585694-e188-9f8c-de71-29f8baa89dd7@redhat.com>
Content-Language: en-US
Cc: andre.przywara@arm.com
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

Hi Eric,

On 12/3/20 1:10 PM, Auger Eric wrote:
> Hi Alexandru,
>
> On 11/25/20 4:51 PM, Alexandru Elisei wrote:
>> The IPI test works by sending IPIs to even numbered CPUs from the
>> IPI_SENDER CPU (CPU1), and then checking that the other CPUs received the
>> interrupts as expected. The check is done in check_acked() by the
>> IPI_SENDER CPU with the help of three arrays:
>>
>> - acked, where acked[i] == 1 means that CPU i received the interrupt.
>> - bad_irq, where bad_irq[i] == -1 means that the interrupt received by CPU
>>   i had the expected interrupt number (IPI_IRQ).
>> - bad_sender, where bad_sender[i] == -1 means that the interrupt received
>>   by CPU i was from the expected sender (IPI_SENDER, GICv2 only).
>>
>> The assumption made by check_acked() is that if a CPU acked an interrupt,
>> then bad_sender and bad_irq have also been updated. This is a common
>> inter-thread communication pattern called message passing.  For message
>> passing to work correctly on weakly consistent memory model architectures,
>> like arm and arm64, barriers or address dependencies are required. This is
>> described in ARM DDI 0487F.b, in "Armv7 compatible approaches for ordering,
>> using DMB and DSB barriers" (page K11-7993), in the section with a single
>> observer, which is in our case the IPI_SENDER CPU.
>>
>> The IPI test attempts to enforce the correct ordering using memory
>> barriers, but it's not enough. For example, the program execution below is
>> valid from an architectural point of view:
>>
>> 3 online CPUs, initial state (from stats_reset()):
>>
>> acked[2] = 0;
>> bad_sender[2] = -1;
>> bad_irq[2] = -1;
>>
>> CPU1 (in check_acked())		| CPU2 (in ipi_handler())
>> 				|
>> smp_rmb() // DMB ISHLD		| acked[2]++;
>> read 1 from acked[2]		|
>> nr_pass++ // nr_pass = 3	|
>> read -1 from bad_sender[2]	|
>> read -1 from bad_irq[2]		|
>> 				| // in check_ipi_sender()
>> 				| bad_sender[2] = <bad ipi sender>
>> 				| // in check_irqnr()
>> 				| bad_irq[2] = <bad irq number>
>> 				| smp_wmb() // DMB ISHST
>> nr_pass == nr_cpus, return	|
>>
>> In this scenario, CPU1 will read the updated acked value, but it will read
>> the initial bad_sender and bad_irq values. This is permitted because the
>> memory barriers do not create a data dependency between the value read from
>> acked and the values read from bad_rq and bad_sender on CPU1, respectively
>> between the values written to acked, bad_sender and bad_irq on CPU2.
>>
>> To avoid this situation, let's reorder the barriers and accesses to the
>> arrays to create the needed dependencies that ensure that message passing
>> behaves as expected.
>>
>> In the interrupt handler, the writes to bad_sender and bad_irq are
>> reordered before the write to acked and a smp_wmb() barrier is added. This
>> ensures that if other PEs observe the write to acked, then they will also
>> observe the writes to the other two arrays.
>>
>> In check_acked(), put the smp_rmb() barrier after the read from acked to
>> ensure that the subsequent reads from bad_sender, respectively bad_irq,
>> aren't reordered locally by the PE.
>>
>> With these changes, the expected ordering of accesses is respected and we
>> end up with the pattern described in the Arm ARM and also in the Linux
>> litmus test MP+fencewmbonceonce+fencermbonceonce.litmus from
>> tools/memory-model/litmus-tests. More examples and explanations can be
>> found in the Linux source tree, in Documentation/memory-barriers.txt, in
>> the sections "SMP BARRIER PAIRING" and "READ MEMORY BARRIERS VS LOAD
>> SPECULATION".
>>
>> For consistency with ipi_handler(), the array accesses in
>> ipi_clear_active_handler() have also been reordered. This shouldn't affect
>> the functionality of that test.
>>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  arm/gic.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/arm/gic.c b/arm/gic.c
>> index 7befda2a8673..bcb834406d23 100644
>> --- a/arm/gic.c
>> +++ b/arm/gic.c
>> @@ -73,9 +73,9 @@ static void check_acked(const char *testname, cpumask_t *mask)
>>  		mdelay(100);
>>  		nr_pass = 0;
>>  		for_each_present_cpu(cpu) {
>> -			smp_rmb();
>>  			nr_pass += cpumask_test_cpu(cpu, mask) ?
>>  				acked[cpu] == 1 : acked[cpu] == 0;
>> +			smp_rmb(); /* pairs with smp_wmb in ipi_handler */
>>  
>>  			if (bad_sender[cpu] != -1) {
>>  				printf("cpu%d received IPI from wrong sender %d\n",
>> @@ -118,7 +118,6 @@ static void check_spurious(void)
>>  {
>>  	int cpu;
>>  
>> -	smp_rmb();
> this change is not documented in the commit msg.

You are right. I think this is a rebasing mistake and should actually be part of
#7 ("arm/arm64: gic: Wait for writes to acked or spurious to complete") where I
remove the smp_wmb() when updating spurious in ipi_handler.

>>  	for_each_present_cpu(cpu) {
>>  		if (spurious[cpu])
>>  			report_info("WARN: cpu%d got %d spurious interrupts",
>> @@ -156,10 +155,10 @@ static void ipi_handler(struct pt_regs *regs __unused)
>>  		 */
>>  		if (gic_version() == 2)
>>  			smp_rmb();
>> -		++acked[smp_processor_id()];
>>  		check_ipi_sender(irqstat);
>>  		check_irqnr(irqnr);
>> -		smp_wmb(); /* pairs with rmb in check_acked */
>> +		smp_wmb(); /* pairs with smp_rmb in check_acked */
>> +		++acked[smp_processor_id()];
>>  	} else {
>>  		++spurious[smp_processor_id()];
>>  		smp_wmb();
> I guess this one was paired with check_spurious one?
>> @@ -383,8 +382,8 @@ static void ipi_clear_active_handler(struct pt_regs *regs __unused)
>>  
>>  		writel(val, base + GICD_ICACTIVER);
>>  
>> -		++acked[smp_processor_id()];
>>  		check_irqnr(irqnr);
>> +		++acked[smp_processor_id()];
> This change is not really needed, isn't it?

It's not needed, yes. It's explained in the commit message, it's there for
consistency with ipi_handler.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
