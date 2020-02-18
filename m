Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D1A78162D9D
	for <lists+kvmarm@lfdr.de>; Tue, 18 Feb 2020 19:01:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 618BE4AF50;
	Tue, 18 Feb 2020 13:01:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f7hFWVEsX9y1; Tue, 18 Feb 2020 13:01:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39A294AF48;
	Tue, 18 Feb 2020 13:01:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 600234AF29
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 13:01:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DS+Pz2YFhRps for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Feb 2020 13:01:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E5384AED5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Feb 2020 13:01:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDFA331B;
 Tue, 18 Feb 2020 10:01:15 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADC4E3F68F;
 Tue, 18 Feb 2020 10:01:14 -0800 (PST)
Subject: Re: [PATCH 1/5] KVM: arm64: Fix missing RES1 in emulation of DBGBIDR
To: James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20200216185324.32596-1-maz@kernel.org>
 <20200216185324.32596-2-maz@kernel.org>
 <c1bd5c57-666e-0d54-1e7c-e45d0535ffe3@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a02252f6-1e9a-2a35-9944-f23e161583ab@arm.com>
Date: Tue, 18 Feb 2020 18:01:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c1bd5c57-666e-0d54-1e7c-e45d0535ffe3@arm.com>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On 18/02/2020 5:43 pm, James Morse wrote:
> Hi Marc,
> 
> $subject typo: ~/DBGBIDR/DBGDIDR/
> 
> On 16/02/2020 18:53, Marc Zyngier wrote:
>> The AArch32 CP14 DBGDIDR has bit 15 set to RES1, which our current
>> emulation doesn't set. Just add the missing bit.
> 
> So it does.
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 3e909b117f0c..da82c4b03aab 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1658,7 +1658,7 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
>>   		p->regval = ((((dfr >> ID_AA64DFR0_WRPS_SHIFT) & 0xf) << 28) |
>>   			     (((dfr >> ID_AA64DFR0_BRPS_SHIFT) & 0xf) << 24) |
>>   			     (((dfr >> ID_AA64DFR0_CTX_CMPS_SHIFT) & 0xf) << 20)
>> -			     | (6 << 16) | (el3 << 14) | (el3 << 12));
>> +			     | (6 << 16) | (1 << 15) | (el3 << 14) | (el3 << 12));
> 
> Hmmm, where el3 is:
> | u32 el3 = !!cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR0_EL3_SHIFT);
> 
> Aren't we depending on the compilers 'true' being 1 here?

Pretty much, but thankfully the only compilers we support are C compilers:

"The result of the logical negation operator ! is 0 if the value of its 
operand compares unequal to 0, 1 if the value of its operand compares 
equal to 0. The result has type int."

And now I have you to thank for flashbacks to bitwise logical operators 
in Visual Basic... :P

Robin.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
