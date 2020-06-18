Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB2EF1FEFD0
	for <lists+kvmarm@lfdr.de>; Thu, 18 Jun 2020 12:44:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44E5E4B150;
	Thu, 18 Jun 2020 06:44:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9eEUI1Kf3J1; Thu, 18 Jun 2020 06:44:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 099204B14B;
	Thu, 18 Jun 2020 06:44:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E7C044B13C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 06:44:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7q8qZdDka55 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Jun 2020 06:44:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C425E4B086
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Jun 2020 06:44:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A7E1045;
 Thu, 18 Jun 2020 03:44:00 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432363F6CF;
 Thu, 18 Jun 2020 03:43:57 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] arm64: kvm: Save/restore MTE registers
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200617123844.29960-2-steven.price@arm.com> <20200617140546.GE5388@gaia>
From: Steven Price <steven.price@arm.com>
Message-ID: <313f5656-b306-72bb-5804-40d20a2cba1e@arm.com>
Date: Thu, 18 Jun 2020 11:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617140546.GE5388@gaia>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dave P Martin <Dave.Martin@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 17/06/2020 15:05, Catalin Marinas wrote:
> On Wed, Jun 17, 2020 at 01:38:43PM +0100, Steven Price wrote:
>> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
>> index 75b1925763f1..6ecee1528566 100644
>> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
>> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
>> @@ -26,6 +26,12 @@
>>   static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>>   {
>>   	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
>> +	if (system_supports_mte()) {
>> +		ctxt->sys_regs[RGSR_EL1] = read_sysreg_s(SYS_RGSR_EL1);
>> +		ctxt->sys_regs[GCR_EL1] = read_sysreg_s(SYS_GCR_EL1);
>> +		ctxt->sys_regs[TFSRE0_EL1] = read_sysreg_s(SYS_TFSRE0_EL1);
>> +		ctxt->sys_regs[TFSR_EL1] = read_sysreg_s(SYS_TFSR_EL1);
>> +	}
> 
> TFSR_EL1 is not a common register as we have the TFSR_EL2 as well. So
> you'd have to access it as read_sysreg_el1(SYS_TFSR) so that, in the VHE
> case, it generates TFSR_EL12, otherwise you just save the host register.

Ah, thanks for pointing that out - I'd got myself confused with the 
whole VHE _EL12 registers. I'd managed to miss that TFSR is banked.

> Also, since TFSR*_EL1 can be set asynchronously, I think we need to set
> the SCTLR_EL2.ITFSB bit so that the register update is synchronised on
> entry to EL2. With VHE we get this automatically as part of
> SCTLR_EL1_SET but it turns out that we have another SCTLR_ELx_FLAGS
> macro for the non-VHE case (why not calling this SCTLR_EL2_* I have no
> idea).

I hadn't noticed that there was a different set for the non-VHE case 
which was missing ITFSB - I'll update that.

Thanks,

Steve

>>   	/*
>>   	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
>> @@ -99,6 +105,12 @@ NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
>>   static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>>   {
>>   	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
>> +	if (system_supports_mte()) {
>> +		write_sysreg_s(ctxt->sys_regs[RGSR_EL1], SYS_RGSR_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[GCR_EL1], SYS_GCR_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[TFSRE0_EL1], SYS_TFSRE0_EL1);
>> +		write_sysreg_s(ctxt->sys_regs[TFSR_EL1], SYS_TFSR_EL1);
>> +	}
> 
> Similarly here, you override the TFSR_EL2 with VHE enabled.
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
