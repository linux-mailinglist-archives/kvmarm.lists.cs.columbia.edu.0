Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C95ED2AD2FD
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 11:01:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 679D84B7C5;
	Tue, 10 Nov 2020 05:01:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vHvq5qURzZWY; Tue, 10 Nov 2020 05:01:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4617A4B7BA;
	Tue, 10 Nov 2020 05:01:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F0C94B741
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:01:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u+FckugWBVzj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 05:01:20 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F2A044B73F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:01:19 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6BA9205CA;
 Tue, 10 Nov 2020 10:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605002478;
 bh=MpYOqpfrkwMeRZHEzlIP04lGoaO0Nbgm2RSKublJQ1I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=U/y1gcA/cMKkNo7E7KkcZpSJMwUYIzi72RorNUsPfOlEtHUk71qt+xVWr0H9C7Zcg
 2bpClkgIUABwQH2O8KyHqgjv+mbxUOXpheziOOtyJWE1AO9AdMv26yLNzHyizQGdpL
 Og/S97nF8WVcHsPZhOvGZhCaxE7o4YLGp0iNmFPk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcQSi-009PMa-8c; Tue, 10 Nov 2020 10:01:16 +0000
MIME-Version: 1.0
Date: Tue, 10 Nov 2020 10:01:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/8] KVM: arm64: Move AArch32 exceptions over to AArch64
 sysregs
In-Reply-To: <58942c6b-9cf2-a0d7-3ba5-2fc42aeef779@arm.com>
References: <20201102191609.265711-1-maz@kernel.org>
 <20201102191609.265711-2-maz@kernel.org>
 <58942c6b-9cf2-a0d7-3ba5-2fc42aeef779@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <99e4733efb9ec810b52662597e61b92b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.morse@arm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

On 2020-11-03 18:29, James Morse wrote:
> Hi Marc,
> 
> On 02/11/2020 19:16, Marc Zyngier wrote:
>> The use of the AArch32-specific accessors have always been a bit
>> annoying on 64bit, and it is time for a change.
>> 
>> Let's move the AArch32 exception injection over to the AArch64 
>> encoding,
>> which requires us to split the two halves of FAR_EL1 into DFAR and 
>> IFAR.
>> This enables us to drop the preempt_disable() games on VHE, and to 
>> kill
>> the last user of the vcpu_cp15() macro.
> 
> Hurrah!
> 
> 
>> diff --git a/arch/arm64/kvm/inject_fault.c 
>> b/arch/arm64/kvm/inject_fault.c
>> index e2a2e48ca371..975f65ba6a8b 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -100,39 +81,36 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
>>   * Modelled after TakeDataAbortException() and 
>> TakePrefetchAbortException
>>   * pseudocode.
>>   */
>> -static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
>> -			 unsigned long addr)
>> +static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 
>> addr)
>>  {
>> -	u32 *far, *fsr;
>> -	bool is_lpae;
>> -	bool loaded;
>> +	u64 far;
>> +	u32 fsr;
> 
> 
>> +	/* Give the guest an IMPLEMENTATION DEFINED exception */
>> +	if (__vcpu_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
> 
> With VHE, won't __vcpu_sys_reg() read the potentially stale copy in
> the sys_reg array?
> 
> vcpu_read_sys_reg()?

Of course you are right. Now fixed.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
