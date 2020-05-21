Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD011DC428
	for <lists+kvmarm@lfdr.de>; Thu, 21 May 2020 02:48:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 044444B188;
	Wed, 20 May 2020 20:48:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pd-xwfWV7zRC; Wed, 20 May 2020 20:48:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CCF14B184;
	Wed, 20 May 2020 20:48:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 140C54B179
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 May 2020 20:48:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dd0EBrQxSqkn for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 May 2020 20:48:47 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D1F244B14E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 May 2020 20:48:47 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 534F6D6E;
 Wed, 20 May 2020 17:48:47 -0700 (PDT)
Received: from [10.163.75.69] (unknown [10.163.75.69])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959693F68F;
 Wed, 20 May 2020 17:48:45 -0700 (PDT)
Subject: Re: [PATCH V3] arm64/cpufeature: Validate hypervisor capabilities
 during CPU hotplug
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
References: <1589248647-22925-1-git-send-email-anshuman.khandual@arm.com>
 <158998676494.231372.15074477766045633803.b4-ty@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e2ccbfdd-85ee-f01c-ce02-462d1a76c273@arm.com>
Date: Thu, 21 May 2020 06:18:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <158998676494.231372.15074477766045633803.b4-ty@kernel.org>
Content-Language: en-US
Cc: catalin.marinas@arm.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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



On 05/20/2020 11:24 PM, Will Deacon wrote:
> On Tue, 12 May 2020 07:27:27 +0530, Anshuman Khandual wrote:
>> This validates hypervisor capabilities like VMID width, IPA range for any
>> hot plug CPU against system finalized values. KVM's view of the IPA space
>> is used while allowing a given CPU to come up. While here, it factors out
>> get_vmid_bits() for general use.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
> 
> Applied to arm64 (for-next/cpufeature), thanks!
> 
> [1/1] arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
>       https://git.kernel.org/arm64/c/c73433fc630c
> 
> But please note that I made some changes to verify_hyp_capabilities() so
> that it's (a) static and (b) uses IS_ENABLED to avoid the dummy function
> definition. I also extended the IS_ENABLED_check so that it doesn't
> conflict with the KVM kconfig changes from Fuad. Please shout if you think
> I'm still missing something.

Normally I would have expected get_kvm_ipa_limit() to be unavailable without
CONFIG_KVM_ARM_HOST, causing a build failure. But it does compile correctly.
Probably the compiler does not really look for get_kvm_ipa_limit() definition
after an early check and bailout on !IS_ENABLED(CONFIG_KVM_ARM_HOST).

Nonetheless, changes looks good. Thank you.

- Anshuman
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
