Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EDA605F517
	for <lists+kvmarm@lfdr.de>; Thu,  4 Jul 2019 11:05:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 630454A483;
	Thu,  4 Jul 2019 05:05:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QVBsELin6QFt; Thu,  4 Jul 2019 05:05:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D8784A331;
	Thu,  4 Jul 2019 05:05:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBF2C40A52
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jul 2019 05:05:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1kah6b9+vSw for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Jul 2019 05:04:59 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DC9C4005D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jul 2019 05:04:59 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3024344;
 Thu,  4 Jul 2019 02:04:58 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875E33F703;
 Thu,  4 Jul 2019 02:04:57 -0700 (PDT)
Subject: Re: [PATCH 52/59] KVM: arm64: nv: vgic: Allow userland to set VGIC
 maintenance IRQ
To: Andre Przywara <andre.przywara@arm.com>
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-53-marc.zyngier@arm.com>
 <23223923-125c-4d9b-eee9-071a4cf3de2a@arm.com>
 <20190704100117.7bba090b@donnerap.cambridge.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <a49b9148-ea4f-124e-9ea8-12a0bf733157@arm.com>
Date: Thu, 4 Jul 2019 10:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704100117.7bba090b@donnerap.cambridge.arm.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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



On 04/07/2019 10:01, Andre Przywara wrote:
> On Thu, 4 Jul 2019 08:38:20 +0100
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>> On 21/06/2019 10:38, Marc Zyngier wrote:
>>> From: Andre Przywara <andre.przywara@arm.com>
>>>
>>> The VGIC maintenance IRQ signals various conditions about the LRs, when
>>> the GIC's virtualization extension is used.
>>> So far we didn't need it, but nested virtualization needs to know about
>>> this interrupt, so add a userland interface to setup the IRQ number.
>>> The architecture mandates that it must be a PPI, on top of that this code
>>> only exports a per-device option, so the PPI is the same on all VCPUs.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> [added some bits of documentation]
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  .../virtual/kvm/devices/arm-vgic-v3.txt       |  9 ++++++++
>>>  arch/arm/include/uapi/asm/kvm.h               |  1 +
>>>  arch/arm64/include/uapi/asm/kvm.h             |  1 +
>>>  include/kvm/arm_vgic.h                        |  3 +++
>>>  virt/kvm/arm/vgic/vgic-kvm-device.c           | 22 +++++++++++++++++++
>>>  5 files changed, 36 insertions(+)
>>>
>>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>> index ff290b43c8e5..c70e8f2e0c9c 100644
>>> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>> @@ -249,3 +249,12 @@ Groups:
>>>    Errors:
>>>      -EINVAL: vINTID is not multiple of 32 or
>>>       info field is not VGIC_LEVEL_INFO_LINE_LEVEL
>>> +
>>> +  KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ
>>> +    The attr field of kvm_device_attr encodes the following values:
>>> +    bits:     | 31   ....    5 | 4  ....  0 |
>>> +    values:   |      RES0      |   vINTID   |
>>> +
>>> +    The vINTID specifies which interrupt is generated when the vGIC
>>> +    must generate a maintenance interrupt. This must be a PPI.
>>> +  
>>
>> Something seems off. The documentation suggests that the value of the
>> attribute will be between 0-15 (and other values will be masked down to
>> a value between 0 and 15).
> 
> Where does that happen? The mask is [4:0], so 5 bits, that should be enough for PPIs as well.
> We could add a line to the documentation to stress that this is an interrupt ID as seen by the virtual GIC, if that helps.
> 

You're right, I misread the length of the vINTID field.

Nevermind then!

Thanks,

-- 
Julien Thierry
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
