Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 223F026886A
	for <lists+kvmarm@lfdr.de>; Mon, 14 Sep 2020 11:32:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 981724B54B;
	Mon, 14 Sep 2020 05:32:17 -0400 (EDT)
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
	with ESMTP id Kly+Tfo0m0XE; Mon, 14 Sep 2020 05:32:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 432754B537;
	Mon, 14 Sep 2020 05:32:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0178A4B4BF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 05:32:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9DkPXwcNsBo for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Sep 2020 05:32:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C06784B4B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 05:32:13 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9114320719;
 Mon, 14 Sep 2020 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600075932;
 bh=1BSQE18mOLeieZIEJX3nhtUEcdSn/Db67JaorMfQvkI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rgwL2w94by8v2vjHBHSfnnk1h3eRTmmv2oVRaG5JPa357oKa8QSu22LQoeMME7+2T
 D7qlSk95YZo7Ab275csCMuuWwWM8p2F2kO9gsjmQcHxUVmYaMeYb313zZ+cowrKh/3
 Y766p789qlNpw9QUd5FjzQs5gLNi4/RC0aX0I6pA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kHkqI-00BdtE-Kf; Mon, 14 Sep 2020 10:32:10 +0100
MIME-Version: 1.0
Date: Mon, 14 Sep 2020 10:32:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Assume write fault on S1PTW permission fault
 on instruction fetch
In-Reply-To: <20200911155912.GB20527@willie-the-truck>
References: <20200909210527.1926996-1-maz@kernel.org>
 <20200911155912.GB20527@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <edbb56d954913bbe8422c9f32aee9c76@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
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

On 2020-09-11 16:59, Will Deacon wrote:
> On Wed, Sep 09, 2020 at 10:05:27PM +0100, Marc Zyngier wrote:
>> KVM currently assumes that an instruction abort can never be a write.
>> This is in general true, except when the abort is triggered by
>> a S1PTW on instruction fetch that tries to update the S1 page tables
>> (to set AF, for example).
>> 
>> This can happen if the page tables have been paged out and brought
>> back in without seeing a direct write to them (they are thus marked
>> read only), and the fault handling code will make the PT executable(!)
>> instead of writable. The guest gets stuck forever.
>> 
>> In these conditions, the permission fault must be considered as
>> a write so that the Stage-1 update can take place. This is essentially
>> the I-side equivalent of the problem fixed by 60e21a0ef54c ("arm64: 
>> KVM:
>> Take S1 walks into account when determining S2 write faults").
>> 
>> Update both kvm_is_write_fault() to return true on IABT+S1PTW, as well
>> as kvm_vcpu_trap_is_iabt() to return false in the same conditions.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>> This could do with some cleanup (kvm_vcpu_dabt_iss1tw has nothing to 
>> do
>> with data aborts), but I've chosen to keep the patch simple in order 
>> to
>> ease backporting.
>> 
>>  arch/arm64/include/asm/kvm_emulate.h | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h 
>> b/arch/arm64/include/asm/kvm_emulate.h
>> index d21676409a24..33d7e16edaa3 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -480,7 +480,8 @@ static __always_inline u8 
>> kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
>> 
>>  static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
>>  {
>> -	return kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW;
>> +	return (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_IABT_LOW &&
>> +		!kvm_vcpu_dabt_iss1tw(vcpu));
>>  }
>> 
>>  static __always_inline u8 kvm_vcpu_trap_get_fault(const struct 
>> kvm_vcpu *vcpu)
>> @@ -520,6 +521,9 @@ static __always_inline int 
>> kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
>> 
>>  static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
>>  {
>> +	if (kvm_vcpu_dabt_iss1tw(vcpu))
>> +		return true;
>> +
> 
> Hmm, I'm a bit uneasy about the interaction of this with
> kvm_handle_guest_abort() if we take an S1PTW fault on instruction fetch
> with our page-tables sitting in a read-only memslot. In this case, I
> think we'll end up injecting a data abort into the guest instead of an
> instruction abort. It hurts my brain thinking about it though.

Good point.

> 
> Overall, I'd be inclined to:
> 
>   1. Rename kvm_vcpu_dabt_iss1tw() to kvm_vcpu_abt_iss1tw()
> 
>   2. Introduce something like kvm_is_exec_fault() as:
> 
> 	return kvm_vcpu_trap_is_iabt() && !kvm_vcpu_abt_iss1tw();
> 
>   3. Use that new function in user_mem_abort() to assign 'exec_fault'
> 
>   4. Hack kvm_is_write_fault() as you have done above.
> 
> Which I _think_ should work (famous last words)...

That's what I initially had, but went for ease of backporting instead...
Back to square one.

> The only nasty bit is that we then duplicate the kvm_vcpu_dabt_iss1tw()
> check in both kvm_is_write_fault() and kvm_vcpu_dabt_iswrite(). Perhaps
> we could remove the latter function in favour of the first? Anyway,
> obviously this sort of cleanup isn't for stable.

I've had a look, and I believe this is safe. We always check for S1PTW
*before* using kvm_vcpu_dabt_iswrite() anyway. I'll add that as a second
patch that we can merge later if required.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
