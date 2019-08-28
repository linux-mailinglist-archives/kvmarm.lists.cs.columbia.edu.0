Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8834FA05E6
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 17:15:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6E04A57C;
	Wed, 28 Aug 2019 11:15:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOO-0Kfzqe0y; Wed, 28 Aug 2019 11:15:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADCA54A561;
	Wed, 28 Aug 2019 11:15:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96A944A540
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 11:15:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5YQp6G5o3+60 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 11:15:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 10E494A53D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 11:15:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9075A28;
 Wed, 28 Aug 2019 08:15:00 -0700 (PDT)
Received: from [10.1.196.217] (e121566-lin.cambridge.arm.com [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D323F59C;
 Wed, 28 Aug 2019 08:14:59 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC PATCH 02/16] arm/arm64: psci: Don't run C
 code without stack or vectors
To: Andrew Jones <drjones@redhat.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
 <1566999511-24916-3-git-send-email-alexandru.elisei@arm.com>
 <20190828144522.qkmckjcmrdayfq7r@kamzik.brq.redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <a2da5efd-b466-3fc2-f8a3-eb9a852f2fdc@arm.com>
Date: Wed, 28 Aug 2019 16:14:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190828144522.qkmckjcmrdayfq7r@kamzik.brq.redhat.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, maz@kernel.org, andre.przywara@arm.com,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On 8/28/19 3:45 PM, Andrew Jones wrote:
> On Wed, Aug 28, 2019 at 02:38:17PM +0100, Alexandru Elisei wrote:
>> The psci test performs a series of CPU_ON/CPU_OFF cycles for CPU 1. This is
>> done by setting the entry point for the CPU_ON call to the physical address
>> of the C function cpu_psci_cpu_die.
>>
>> The compiler is well within its rights to use the stack when generating
>> code for cpu_psci_cpu_die.  However, because no stack initialization has
>> been done, the stack pointer is zero, as set by KVM when creating the VCPU.
>> This causes a data abort without a change in exception level. The VBAR_EL1
>> register is also zero (the KVM reset value for VBAR_EL1), the MMU is off,
>> and we end up trying to fetch instructions from address 0x200.
>>
>> At this point, a stage 2 instruction abort is generated which is taken to
>> KVM. KVM interprets this as an instruction fetch from an I/O region, and
>> injects a prefetch abort into the guest. Prefetch abort is a synchronous
>> exception, and on guest return the VCPU PC will be set to VBAR_EL1 + 0x200,
>> which is...  0x200. The VCPU ends up in an infinite loop causing a prefetch
>> abort while fetching the instruction to service the said abort.
>>
>> cpu_psci_cpu_die is basically a wrapper over the HVC instruction, so
>> provide an assembly implementation for the function which will serve as the
>> entry point for CPU_ON.
>>
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> ---
>>  arm/cstart.S   | 7 +++++++
>>  arm/cstart64.S | 7 +++++++
>>  arm/psci.c     | 5 +++--
>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/arm/cstart.S b/arm/cstart.S
>> index 114726feab82..5d4fe4b1570b 100644
>> --- a/arm/cstart.S
>> +++ b/arm/cstart.S
>> @@ -7,6 +7,7 @@
>>   */
>>  #define __ASSEMBLY__
>>  #include <auxinfo.h>
>> +#include <linux/psci.h>
>>  #include <asm/thread_info.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/ptrace.h>
>> @@ -138,6 +139,12 @@ secondary_entry:
>>  	blx	r0
>>  	b	do_idle
>>  
>> +.global asm_cpu_psci_cpu_die
>> +asm_cpu_psci_cpu_die:
>> +	ldr	r0, =PSCI_0_2_FN_CPU_OFF
>> +	hvc	#0
>> +	b	halt
> Shouldn't we load PSCI_POWER_STATE_TYPE_POWER_DOWN into r1 and
> zero out r2 and r3, as cpu_psci_cpu_die() does? And maybe we
> should just do a 'b .' here instead of 'b halt' in order to
> avoid confusion as to how we ended up in halt(), if the psci
> invocation were to ever fail.

Not really, I'm not really sure where the extra parameter in cpu_psci_cpu_die
comes from. I have looked at ARM DEN 0022D, section 5.1.3, and the CPU_OFFcall
has exactly one parameter, the function id. I've also looked at how KVM handles
this call, and it doesn't use anything else other than the function id. Please
correct me if I missed something.

As for zero'ing the extra registers, this is not part of the SMC calling
convention, this is just something that the C code for psci does. The SMC
calling convention states that registers 0-3 will be modified after the call, so
having 4 arguments to the psci_invoke function will tell the compiler to
save/restore the registers in the caller.

As for doing 'b .' instead of branching to halt, that's a good idea, I'll do
that. But it will only be useful if the last CPU_OFF call fails.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
