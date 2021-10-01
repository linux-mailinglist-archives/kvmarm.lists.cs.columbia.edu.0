Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC941E998
	for <lists+kvmarm@lfdr.de>; Fri,  1 Oct 2021 11:27:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DF164B0D7;
	Fri,  1 Oct 2021 05:27:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJXF2lVGskH6; Fri,  1 Oct 2021 05:27:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B2434B0B6;
	Fri,  1 Oct 2021 05:27:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B160249DE3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 05:27:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzvyYTrhhRsc for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Oct 2021 05:27:21 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7FE540630
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 05:27:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D24101E;
 Fri,  1 Oct 2021 02:27:21 -0700 (PDT)
Received: from [10.57.72.173] (unknown [10.57.72.173])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4CA3F70D;
 Fri,  1 Oct 2021 02:27:19 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: Allow KVM to be disabled from the command line
To: Marc Zyngier <maz@kernel.org>
References: <20210903091652.985836-1-maz@kernel.org>
 <5bc623f2-e4c1-cc9c-683c-2f95648f1a68@arm.com> <87a6jutkyq.wl-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e80b2454-45c3-19a3-7a96-dcb484f9e2f5@arm.com>
Date: Fri, 1 Oct 2021 10:27:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87a6jutkyq.wl-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 30/09/2021 11:29, Marc Zyngier wrote:
> On Wed, 29 Sep 2021 11:35:46 +0100,
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 03/09/2021 10:16, Marc Zyngier wrote:
>>> Although KVM can be compiled out of the kernel, it cannot be disabled
>>> at runtime. Allow this possibility by introducing a new mode that
>>> will prevent KVM from initialising.
>>>
>>> This is useful in the (limited) circumstances where you don't want
>>> KVM to be available (what is wrong with you?), or when you want
>>> to install another hypervisor instead (good luck with that).
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt |  3 +++
>>>    arch/arm64/include/asm/kvm_host.h               |  1 +
>>>    arch/arm64/kernel/idreg-override.c              |  1 +
>>>    arch/arm64/kvm/arm.c                            | 14 +++++++++++++-
>>>    4 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 91ba391f9b32..cc5f68846434 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2365,6 +2365,9 @@
>>>    	kvm-arm.mode=
>>>    			[KVM,ARM] Select one of KVM/arm64's modes of operation.
>>>    +			none: Forcefully disable KVM and run in nVHE
>>> mode,
>>> +			      preventing KVM from ever initialising.
>>> +
>>>    			nvhe: Standard nVHE-based mode, without support for
>>>    			      protected guests.
>>>    diff --git a/arch/arm64/include/asm/kvm_host.h
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index f8be56d5342b..019490c67976 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -58,6 +58,7 @@
>>>    enum kvm_mode {
>>>    	KVM_MODE_DEFAULT,
>>>    	KVM_MODE_PROTECTED,
>>> +	KVM_MODE_NONE,
>>>    };
>>>    enum kvm_mode kvm_get_mode(void);
>>>    diff --git a/arch/arm64/kernel/idreg-override.c
>>> b/arch/arm64/kernel/idreg-override.c
>>> index d8e606fe3c21..57013c1b6552 100644
>>> --- a/arch/arm64/kernel/idreg-override.c
>>> +++ b/arch/arm64/kernel/idreg-override.c
>>> @@ -95,6 +95,7 @@ static const struct {
>>>    	char	alias[FTR_ALIAS_NAME_LEN];
>>>    	char	feature[FTR_ALIAS_OPTION_LEN];
>>>    } aliases[] __initconst = {
>>> +	{ "kvm-arm.mode=none",		"id_aa64mmfr1.vh=0" },
>>>    	{ "kvm-arm.mode=nvhe",		"id_aa64mmfr1.vh=0" },
>>>    	{ "kvm-arm.mode=protected",	"id_aa64mmfr1.vh=0" },
>>>    	{ "arm64.nobti",		"id_aa64pfr1.bt=0" },
>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>> index fe102cd2e518..cdc70e238316 100644
>>> --- a/arch/arm64/kvm/arm.c
>>> +++ b/arch/arm64/kvm/arm.c
>>> @@ -2064,6 +2064,11 @@ int kvm_arch_init(void *opaque)
>>>    		return -ENODEV;
>>>    	}
>>>    +	if (kvm_get_mode() == KVM_MODE_NONE) {
>>> +		kvm_info("KVM disabled from command line\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>>    	in_hyp_mode = is_kernel_in_hyp_mode();
>>>      	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE)
>>> ||
>>> @@ -2137,8 +2142,15 @@ static int __init early_kvm_mode_cfg(char *arg)
>>>    		return 0;
>>>    	}
>>>    -	if (strcmp(arg, "nvhe") == 0 &&
>>> !WARN_ON(is_kernel_in_hyp_mode()))
>>> +	if (strcmp(arg, "nvhe") == 0 && !WARN_ON(is_kernel_in_hyp_mode())) {
>>> +		kvm_mode = KVM_MODE_DEFAULT;
>>>    		return 0;
>>> +	}
>>> +
>>> +	if (strcmp(arg, "none") == 0 && !WARN_ON(is_kernel_in_hyp_mode())) {
>>
>> nit: Does this really need to WARN here ? Unlike the "nvhe" case, if the
>> user wants to keep the KVM out of the picture for, say debugging
>> something, it is perfectly Ok to allow the kernel to be running at EL2
>> without having to change the Firmware to alter the landing EL for the
>> kernel ?
> 
> Well, the doc says "run in nVHE mode" and the option forces
> id_aa64mmfr1.vh=0. The WARN_ON() will only fires on broken^Wfruity HW
> that is VHE only. Note that this doesn't rely on any firmware change
> (we drop from EL2 to EL1 and stay there).

Ah, ok. So the "none" is in fact "nvhe + no-kvm". Thats the bit I
missed. TBH, that name to me sounds like "no KVM" at all, which is what
we want. The question is, do we really need "none" to force vh == 0 ? I
understand this is only a problem on a rare set of HWs. But the generic
option looks deceiving.

That said, I am happy to leave this as is and the doc says so.

> 
> We could add another option (none-vhe?) that stays at EL2 and still
> disables KVM if there is an appetite for it.

Na. Don't think that is necessary.

> 
>> Otherwise,
>>
>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
