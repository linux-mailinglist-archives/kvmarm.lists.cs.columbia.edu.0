Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 888782D5E3E
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 15:45:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 122B24B1B9;
	Thu, 10 Dec 2020 09:45:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OL4XdR+ru09V; Thu, 10 Dec 2020 09:45:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79AD54B1B3;
	Thu, 10 Dec 2020 09:45:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B72F4B124
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:45:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id seomdrqmXir7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 09:45:51 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E985E4B119
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 09:45:50 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9666C1FB;
 Thu, 10 Dec 2020 06:45:50 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD18C3F718;
 Thu, 10 Dec 2020 06:45:49 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 08/10] arm/arm64: gic: Split check_acked()
 into two functions
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com
References: <20201125155113.192079-1-alexandru.elisei@arm.com>
 <20201125155113.192079-9-alexandru.elisei@arm.com>
 <0eb98cb0-835c-e257-484e-8210f1279f2c@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <2b8d774e-9398-e24b-6989-8643f5dd2492@arm.com>
Date: Thu, 10 Dec 2020 14:45:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <0eb98cb0-835c-e257-484e-8210f1279f2c@redhat.com>
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

On 12/3/20 1:39 PM, Auger Eric wrote:
>
> On 11/25/20 4:51 PM, Alexandru Elisei wrote:
>> check_acked() has several peculiarities: is the only function among the
>> check_* functions which calls report() directly, it does two things
>> (waits for interrupts and checks for misfired interrupts) and it also
>> mixes printf, report_info and report calls.
>>
>> check_acked() also reports a pass and returns as soon all the target CPUs
>> have received interrupts, However, a CPU not having received an interrupt
>> *now* does not guarantee not receiving an eroneous interrupt if we wait
> erroneous
>> long enough.
>>
>> Rework the function by splitting it into two separate functions, each with
>> a single responsability: wait_for_interrupts(), which waits for the
>> expected interrupts to fire, and check_acked() which checks that interrupts
>> have been received as expected.
>>
>> wait_for_interrupts() also waits an extra 100 milliseconds after the
>> expected interrupts have been received in an effort to make sure we don't
>> miss misfiring interrupts.
>>
>> Splitting check_acked() into two functions will also allow us to
>> customize the behavior of each function in the future more easily
>> without using an unnecessarily long list of arguments for check_acked().
>>
>> CC: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  arm/gic.c | 73 +++++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 47 insertions(+), 26 deletions(-)
>>
>> diff --git a/arm/gic.c b/arm/gic.c
>> index 544c283f5f47..dcdab7d5f39a 100644
>> --- a/arm/gic.c
>> +++ b/arm/gic.c
>> @@ -62,41 +62,42 @@ static void stats_reset(void)
>>  	}
>>  }
>>  
>> -static void check_acked(const char *testname, cpumask_t *mask)
>> +static void wait_for_interrupts(cpumask_t *mask)
>>  {
>> -	int missing = 0, extra = 0, unexpected = 0;
>>  	int nr_pass, cpu, i;
>> -	bool bad = false;
>>  
>>  	/* Wait up to 5s for all interrupts to be delivered */
>> -	for (i = 0; i < 50; ++i) {
>> +	for (i = 0; i < 50; i++) {
>>  		mdelay(100);
>>  		nr_pass = 0;
>>  		for_each_present_cpu(cpu) {
>> +			/*
>> +			 * A CPU having receied more than one interrupts will
> received
>> +			 * show up in check_acked(), and no matter how long we
>> +			 * wait it cannot un-receive it. Consier at least one
> consider

Will fix all three typos, thanks.

>> +			 * interrupt as a pass.
>> +			 */
>>  			nr_pass += cpumask_test_cpu(cpu, mask) ?
>> -				acked[cpu] == 1 : acked[cpu] == 0;
>> -			smp_rmb(); /* pairs with smp_wmb in ipi_handler */
>> -
>> -			if (bad_sender[cpu] != -1) {
>> -				printf("cpu%d received IPI from wrong sender %d\n",
>> -					cpu, bad_sender[cpu]);
>> -				bad = true;
>> -			}
>> -
>> -			if (bad_irq[cpu] != -1) {
>> -				printf("cpu%d received wrong irq %d\n",
>> -					cpu, bad_irq[cpu]);
>> -				bad = true;
>> -			}
>> +				acked[cpu] >= 1 : acked[cpu] == 0;
>>  		}
>> +
>>  		if (nr_pass == nr_cpus) {
>> -			report(!bad, "%s", testname);
>>  			if (i)
>> -				report_info("took more than %d ms", i * 100);
>> +				report_info("interrupts took more than %d ms", i * 100);
>> +			mdelay(100);
>>  			return;
>>  		}
>>  	}
>>  
>> +	report_info("interrupts timed-out (5s)");
>> +}
>> +
>> +static bool check_acked(cpumask_t *mask)
>> +{
>> +	int missing = 0, extra = 0, unexpected = 0;
>> +	bool pass = true;
>> +	int cpu;
>> +
>>  	for_each_present_cpu(cpu) {
>>  		if (cpumask_test_cpu(cpu, mask)) {
>>  			if (!acked[cpu])
>> @@ -107,11 +108,28 @@ static void check_acked(const char *testname, cpumask_t *mask)
>>  			if (acked[cpu])
>>  				++unexpected;
>>  		}
>> +		smp_rmb(); /* pairs with smp_wmb in ipi_handler */
>> +
>> +		if (bad_sender[cpu] != -1) {
>> +			report_info("cpu%d received IPI from wrong sender %d",
>> +					cpu, bad_sender[cpu]);
>> +			pass = false;
>> +		}
>> +
>> +		if (bad_irq[cpu] != -1) {
>> +			report_info("cpu%d received wrong irq %d",
>> +					cpu, bad_irq[cpu]);
>> +			pass = false;
>> +		}
>> +	}
>> +
>> +	if (missing || extra || unexpected) {
>> +		report_info("ACKS: missing=%d extra=%d unexpected=%d",
>> +				missing, extra, unexpected);
>> +		pass = false;
>>  	}
>>  
>> -	report(false, "%s", testname);
>> -	report_info("Timed-out (5s). ACKS: missing=%d extra=%d unexpected=%d",
>> -		    missing, extra, unexpected);
>> +	return pass;
>>  }
>>  
>>  static void check_spurious(void)
>> @@ -300,7 +318,8 @@ static void ipi_test_self(void)
>>  	cpumask_clear(&mask);
>>  	cpumask_set_cpu(smp_processor_id(), &mask);
>>  	gic->ipi.send_self();
>> -	check_acked("IPI: self", &mask);
>> +	wait_for_interrupts(&mask);
>> +	report(check_acked(&mask), "Interrupts received");
>>  	report_prefix_pop();
>>  }
>>  
>> @@ -315,7 +334,8 @@ static void ipi_test_smp(void)
>>  	for (i = smp_processor_id() & 1; i < nr_cpus; i += 2)
>>  		cpumask_clear_cpu(i, &mask);
>>  	gic_ipi_send_mask(IPI_IRQ, &mask);
>> -	check_acked("IPI: directed", &mask);
>> +	wait_for_interrupts(&mask);
>> +	report(check_acked(&mask), "Interrupts received");
> both ipi_test_smp and ipi_test_self are called from the same test so
> better to use different error messages like it was done originally.

I used the same error message because the tests have a different prefix
("target-list" versus "broadcast"). Do you think there are cases where that's not
enough?

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
