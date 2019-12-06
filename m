Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A9C39114EC2
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 11:11:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 356E04AF46;
	Fri,  6 Dec 2019 05:11:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSFKowSYT6ju; Fri,  6 Dec 2019 05:11:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E26AC4AF3F;
	Fri,  6 Dec 2019 05:10:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F0694AF08
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 05:10:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCCdavbBgjge for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 05:10:57 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49F154ACE6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 05:10:57 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E175DDA7;
 Fri,  6 Dec 2019 02:10:56 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3713F718;
 Fri,  6 Dec 2019 02:10:54 -0800 (PST)
Subject: Re: [PATCH] KVM: arm: get rid of unused arg in cpu_init_hyp_mode()
To: linmiaohe <linmiaohe@huawei.com>, "maz@kernel.org" <maz@kernel.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "will@kernel.org" <will@kernel.org>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
References: <8efe4ab7f8c44c48a70378247c511edc@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <11f06523-54ce-7025-a6ba-58c29769da60@arm.com>
Date: Fri, 6 Dec 2019 10:10:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8efe4ab7f8c44c48a70378247c511edc@huawei.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 30/11/2019 07:20, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> As arg dummy is not really needed, there's no need to pass NULL when calling cpu_init_hyp_mode(). So clean it up.

It looks like the requirement for this dummy arg was removed in
67f691976662 ("arm64: kvm: allows kvm cpu hotplug"). FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>> virt/kvm/arm/arm.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c index 86c6aa1cb58e..a5470f1b1a19 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1315,7 +1315,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>> 	}
>> }
>>
>> -static void cpu_init_hyp_mode(void *dummy)
>> +static void cpu_init_hyp_mode(void)
>> {
>> 	phys_addr_t pgd_ptr;
>> 	unsigned long hyp_stack_ptr;
>> @@ -1349,7 +1349,7 @@ static void cpu_hyp_reinit(void)
>> 	if (is_kernel_in_hyp_mode())
>> 		kvm_timer_init_vhe();
>> 	else
>> -		cpu_init_hyp_mode(NULL);
>> +		cpu_init_hyp_mode();
>>
>> 	kvm_arm_init_debug();
>>
> friendly ping ...
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
