Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 26FDB3D90EB
	for <lists+kvmarm@lfdr.de>; Wed, 28 Jul 2021 16:51:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 75F4D4A483;
	Wed, 28 Jul 2021 10:51:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lFfEXlJuDQR; Wed, 28 Jul 2021 10:51:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 336E74B081;
	Wed, 28 Jul 2021 10:51:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 67B3D4A483
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 10:51:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lWoOM5TJmPOe for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 10:51:04 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0993340463
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 10:51:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86FDB1042;
 Wed, 28 Jul 2021 07:51:03 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FDC63F70D;
 Wed, 28 Jul 2021 07:51:01 -0700 (PDT)
Subject: Re: [PATCH 01/16] KVM: arm64: Generalise VM features into a set of
 flags
To: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-2-maz@kernel.org>
 <20210727181026.GA19173@willie-the-truck> <875ywuepxv.wl-maz@kernel.org>
From: Steven Price <steven.price@arm.com>
Message-ID: <716fffdb-580a-bc70-478a-a54912a77c82@arm.com>
Date: Wed, 28 Jul 2021 15:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <875ywuepxv.wl-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, linux-kernel@vger.kernel.org,
 Shanker R Donthineni <sdonthineni@nvidia.com>, kvmarm@lists.cs.columbia.edu,
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

On 28/07/2021 10:41, Marc Zyngier wrote:
> On Tue, 27 Jul 2021 19:10:27 +0100,
> Will Deacon <will@kernel.org> wrote:
>>
>> On Thu, Jul 15, 2021 at 05:31:44PM +0100, Marc Zyngier wrote:
>>> We currently deal with a set of booleans for VM features,
>>> while they could be better represented as set of flags
>>> contained in an unsigned long, similarily to what we are
>>> doing on the CPU side.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h | 12 +++++++-----
>>>  arch/arm64/kvm/arm.c              |  5 +++--
>>>  arch/arm64/kvm/mmio.c             |  3 ++-
>>>  3 files changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 41911585ae0c..4add6c27251f 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -122,7 +122,10 @@ struct kvm_arch {
>>>  	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
>>>  	 * supported.
>>>  	 */
>>> -	bool return_nisv_io_abort_to_user;
>>> +#define KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER	0
>>> +	/* Memory Tagging Extension enabled for the guest */
>>> +#define KVM_ARCH_FLAG_MTE_ENABLED			1
>>> +	unsigned long flags;
>>
>> One downside of packing all these together is that updating 'flags' now
>> requires an atomic rmw sequence (i.e. set_bit()). Then again, that's
>> probably for the best anyway given that kvm_vm_ioctl_enable_cap() looks
>> like it doesn't hold any locks.
> 
> That, and these operations are supposed to be extremely rare anyway.
> 
>>
>>>  	/*
>>>  	 * VM-wide PMU filter, implemented as a bitmap and big enough for
>>> @@ -133,9 +136,6 @@ struct kvm_arch {
>>>  
>>>  	u8 pfr0_csv2;
>>>  	u8 pfr0_csv3;
>>> -
>>> -	/* Memory Tagging Extension enabled for the guest */
>>> -	bool mte_enabled;
>>>  };
>>>  
>>>  struct kvm_vcpu_fault_info {
>>> @@ -777,7 +777,9 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
>>>  #define kvm_arm_vcpu_sve_finalized(vcpu) \
>>>  	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
>>>  
>>> -#define kvm_has_mte(kvm) (system_supports_mte() && (kvm)->arch.mte_enabled)
>>> +#define kvm_has_mte(kvm)					\
>>> +	(system_supports_mte() &&				\
>>> +	 test_bit(KVM_ARCH_FLAG_MTE_ENABLED, &(kvm)->arch.flags))
>>
>> Not an issue with this patch, but I just noticed that the
>> system_supports_mte() check is redundant here as we only allow the flag to
>> be set if that's already the case.
> 
> It allows us to save a memory access if system_supports_mte() is false
> (it is eventually implemented as a static key). On the other hand,
> there is so much inlining due to it being a non-final cap that we
> probably lose on that too...

My original logic was that system_supports_mte() checks
IS_ENABLED(CONFIG_ARM64_MTE) - so this enables the code guarded with
kvm_has_mte() to be compiled out if CONFIG_ARM64_MTE is disabled.

Indeed it turns at we currently rely on this (with CONFIG_ARM64_MTE
disabled):

aarch64-linux-gnu-ld: arch/arm64/kvm/mmu.o: in function `sanitise_mte_tags':
/home/stepri01/work/linux/arch/arm64/kvm/mmu.c:887: undefined reference to `mte_clear_page_tags'
aarch64-linux-gnu-ld: arch/arm64/kvm/guest.o: in function `kvm_vm_ioctl_mte_copy_tags':
/home/stepri01/work/linux/arch/arm64/kvm/guest.c:1066: undefined reference to `mte_copy_tags_to_user'
aarch64-linux-gnu-ld: /home/stepri01/work/linux/arch/arm64/kvm/guest.c:1074: undefined reference to `mte_copy_tags_from_user'

Obviously we could pull just the IS_ENABLED() into kvm_has_mte() instead.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
