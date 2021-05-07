Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6113762FE
	for <lists+kvmarm@lfdr.de>; Fri,  7 May 2021 11:44:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10E794B57D;
	Fri,  7 May 2021 05:44:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RbTogymSKdUP; Fri,  7 May 2021 05:44:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 045204B57B;
	Fri,  7 May 2021 05:44:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D5A24B576
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 05:44:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xt5DsbX0WAu for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 May 2021 05:44:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CC8F4B570
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 05:44:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF03C106F;
 Fri,  7 May 2021 02:44:40 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 534693F718;
 Fri,  7 May 2021 02:44:38 -0700 (PDT)
Subject: Re: [PATCH v11 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-6-steven.price@arm.com>
 <20210427175844.GB17872@arm.com>
 <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com> <YJGIBTor+blelKKT@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <25c85740-0119-549e-6ddb-aea69c5efc76@arm.com>
Date: Fri, 7 May 2021 10:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJGIBTor+blelKKT@arm.com>
Content-Language: en-GB
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On 04/05/2021 18:44, Catalin Marinas wrote:
> On Thu, Apr 29, 2021 at 05:06:07PM +0100, Steven Price wrote:
>> On 27/04/2021 18:58, Catalin Marinas wrote:
>>> On Fri, Apr 16, 2021 at 04:43:08PM +0100, Steven Price wrote:
>>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>>>> index 24223adae150..2b85a047c37d 100644
>>>> --- a/arch/arm64/include/uapi/asm/kvm.h
>>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>>>> @@ -184,6 +184,20 @@ struct kvm_vcpu_events {
>>>>    	__u32 reserved[12];
>>>>    };
>>>> +struct kvm_arm_copy_mte_tags {
>>>> +	__u64 guest_ipa;
>>>> +	__u64 length;
>>>> +	union {
>>>> +		void __user *addr;
>>>> +		__u64 padding;
>>>> +	};
>>>> +	__u64 flags;
>>>> +	__u64 reserved[2];
>>>> +};
> [...]
>>> Maybe add the two reserved
>>> values to the union in case we want to store something else in the
>>> future.
>>
>> I'm not sure what you mean here. What would the reserved fields be unioned
>> with? And surely they are no longer reserved in that case?
> 
> In case you want to keep the structure size the same for future
> expansion and the expansion only happens via the union, you'd add some
> padding in there just in case. We do this for struct siginfo with an
> _si_pad[] array in the union.
> 

Ah I see what you mean. In this case "padding" is just a sizer to ensure 
that flags is always the same alignment - it's not intended to be used. 
As I noted previously though it's completely pointless as this only on 
arm64 and even 32 bit Arm would naturally align the following __u64.

reserved[] is for expansion and I guess we could have a union over the 
whole struct (like siginfo) but I think it's generally clearer to just 
spell out the reserved fields at the end of the struct.

TLDR; the union will be gone along with "padding" in the next version. 
"reserved" remains at the end of the struct for future use.

Thanks,

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
