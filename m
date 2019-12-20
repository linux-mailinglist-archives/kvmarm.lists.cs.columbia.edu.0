Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D1D74127A2B
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 12:43:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 652214ACC4;
	Fri, 20 Dec 2019 06:43:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmtvC1caaXsG; Fri, 20 Dec 2019 06:43:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E7EB54A830;
	Fri, 20 Dec 2019 06:43:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0D0D4A51E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 06:43:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DT9V2NL2lP8w for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 06:43:54 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 723BB4A50F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 06:43:54 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0555B30E;
 Fri, 20 Dec 2019 03:43:54 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 228E83F719;
 Fri, 20 Dec 2019 03:43:52 -0800 (PST)
Subject: Re: [PATCH 1/5] KVM: arm64: Document PV-lock interface
To: yezengruan <yezengruan@huawei.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
 <20191217135549.3240-2-yezengruan@huawei.com>
 <20191217142138.GA38811@arm.com>
 <49120a3c-405d-d2e3-2a88-ba590feccbcc@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <e326cd81-7e22-72a8-7b80-8258e8f6a5c6@arm.com>
Date: Fri, 20 Dec 2019 11:43:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <49120a3c-405d-d2e3-2a88-ba590feccbcc@huawei.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On 19/12/2019 11:45, yezengruan wrote:
> Hi Steve,
> 
> On 2019/12/17 22:21, Steven Price wrote:
>> On Tue, Dec 17, 2019 at 01:55:45PM +0000, yezengruan@huawei.com wrote:
>>> From: Zengruan Ye <yezengruan@huawei.com>
>>>
>>> Introduce a paravirtualization interface for KVM/arm64 to obtain the vcpu
>>> is currently running or not.
>>>
>>> A hypercall interface is provided for the guest to interrogate the
>>> hypervisor's support for this interface and the location of the shared
>>> memory structures.
>>>
>>> Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
>>> ---
>>>  Documentation/virt/kvm/arm/pvlock.rst | 31 +++++++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>  create mode 100644 Documentation/virt/kvm/arm/pvlock.rst
>>>
>>> diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
>>> new file mode 100644
>>> index 000000000000..eec0c36edf17
>>> --- /dev/null
>>> +++ b/Documentation/virt/kvm/arm/pvlock.rst
>>> @@ -0,0 +1,31 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +Paravirtualized lock support for arm64
>>> +======================================
>>> +
>>> +KVM/arm64 provids some hypervisor service calls to support a paravirtualized
>>> +guest obtaining the vcpu is currently running or not.
>>> +
>>> +Two new SMCCC compatible hypercalls are defined:
>>> +
>>> +* PV_LOCK_FEATURES:   0xC5000040
>>> +* PV_LOCK_PREEMPTED:  0xC5000041
>>
>> These values are in the "Standard Hypervisor Service Calls" section of
>> SMCCC - so is there a document that describes this features such that
>> other OSes or hypervisors can implement it? I'm also not entirely sure
>> of the process of ensuring that the IDs picked are non-conflicting.
>>
>> Otherwise if this is a KVM specific interface this should probably
>> belong within the "Vendor Specific Hypervisor Service Calls" section
>> along with some probing that the hypervisor is actually KVM. Although I
>> don't see anything KVM specific.
> 
> Thanks for pointing it out to me! Actually, I also don't see any documents
> or KVM specific that describes this features. The values in the "Vendor
> Specific Hypervisor Service Calls" section may be more appropriate, such as
> the following
> 
> * PV_LOCK_FEATURES:   0xC6000020
> * PV_LOCK_PREEMPTED:  0xC6000021
> 
> Please let me know if you have any suggestions.

I don't have strong feelings on whether this should be KVM-specific or
generic. I'm not familiar with whether there are competing solutions to
this problem - it's obviously ideal if all hypervisors can make use of
the same interface if possible, but maybe that ship has sailed already?

However if this going to be KVM-specific then you'll need to add the
probing logic for checking whether the hypervisor is KVM or not. Will
has a couple of patches on a branch which do this [1] and [2]. Then you
can use kvm_arm_hyp_services_available() as the first step to probe
whether the hypervisor is KVM.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=kvm/hvc&id=464f5a1741e5959c3e4d2be1966ae0093b4dce06

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=kvm/hvc&id=6597490e005d0eeca8ed8c1c1d7b4318ee014681

Steve

>>
>>> +
>>> +The existence of the PV_LOCK hypercall should be probed using the SMCCC 1.1
>>> +ARCH_FEATURES mechanism before calling it.
>>> +
>>> +PV_LOCK_FEATURES
>>> +    ============= ========    ==========
>>> +    Function ID:  (uint32)    0xC5000040
>>> +    PV_call_id:   (uint32)    The function to query for support.
>>> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
>>> +                              PV-lock feature is supported by the hypervisor.
>>> +    ============= ========    ==========
>>> +
>>> +PV_LOCK_PREEMPTED
>>> +    ============= ========    ==========
>>> +    Function ID:  (uint32)    0xC5000041
>>> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the IPA of
>>> +                              this vcpu's pv data structure is configured by
>>> +                              the hypervisor.
>>> +    ============= ========    ==========
>>
>> >From the code it looks like there's another argument for this SMC - the
>> physical address (or IPA) of a struct pvlock_vcpu_state. This structure
>> also needs to be described as it is part of the ABI.
> 
> Will update.
> 
>>
>> Steve
>>
>> .
>>
> 
> Thanks,
> 
> Zengruan
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
