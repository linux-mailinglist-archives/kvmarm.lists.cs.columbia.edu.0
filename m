Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C720B34475
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 12:35:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B7244A506;
	Tue,  4 Jun 2019 06:35:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZGEdLLpZ15w; Tue,  4 Jun 2019 06:35:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACF194A4A0;
	Tue,  4 Jun 2019 06:35:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A0D0B4A4A0
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 06:35:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3r6fD7AMUFtD for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 06:35:17 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B4E54A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 06:35:17 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6032980D;
 Tue,  4 Jun 2019 03:35:16 -0700 (PDT)
Received: from [10.37.8.2] (unknown [10.37.8.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E1A3F246;
 Tue,  4 Jun 2019 03:35:13 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-4-julien.grall@arm.com>
 <20190603162534.GF63283@arrakis.emea.arm.com>
 <20190603212104.mhz7vvj7afb2p3yr@mbp>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <5c159919-d220-f8dc-d609-b1b1b2844d4b@arm.com>
Date: Tue, 4 Jun 2019 11:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603212104.mhz7vvj7afb2p3yr@mbp>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, ard.biesheuvel@linaro.org,
 marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Catalin,

On 6/3/19 10:21 PM, Catalin Marinas wrote:
> On Mon, Jun 03, 2019 at 05:25:34PM +0100, Catalin Marinas wrote:
>> On Tue, May 21, 2019 at 06:21:39PM +0100, Julien Grall wrote:
>>> Since a softirq is supposed to check may_use_simd() anyway before
>>> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
>>> disabled when touching the FPSIMD/SVE context. Instead, we can simply
>>> disable preemption and mark the FPSIMD/SVE context as in use by setting
>>> CPU's fpsimd_context_busy flag.
>> [...]
>>> +static void get_cpu_fpsimd_context(void)
>>> +{
>>> +	preempt_disable();
>>> +	__get_cpu_fpsimd_context();
>>> +}
>>
>> Is there anything that prevents a softirq being invoked between
>> preempt_disable() and __get_cpu_fpsimd_context()?
> 
> Actually, it shouldn't matter as the softirq finishes using the fpsimd
> before the thread is resumed.

If the softirqs is handled in a thread (i.e ksoftirqd), then 
preempt_disable() will prevent them to run.

For softirq running on return from interrupt context, they will finish 
before using fpsimd before the thread is resumed.

Softirq running after __get_cpu_fpsimd_context() is called will not be 
able to use FPSIMD (may_use_simd() returns false).

Cheers,

-- 
Julien Grall
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
