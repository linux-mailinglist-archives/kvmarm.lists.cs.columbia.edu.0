Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51A21571B
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jul 2020 14:15:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1F104B3A4;
	Mon,  6 Jul 2020 08:15:24 -0400 (EDT)
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
	with ESMTP id FdmG93P7SQV7; Mon,  6 Jul 2020 08:15:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FA6E4B3AC;
	Mon,  6 Jul 2020 08:15:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3662E4B392
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 08:15:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wvY6ajbtOML for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jul 2020 08:15:21 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E259E4B1FA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 08:15:20 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2C61206F5;
 Mon,  6 Jul 2020 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594037719;
 bh=Ln+M2VEKf+2mtxon2h+buvSO35oHmKw8UDIzRkCs7sA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=saieF4wXnaKrbWcQ5wO2kfilaGu99az6f3JpECUt5GG3aTMC2oGsFBTUettThgzPo
 3SKUHtcXYqY5+H9rHbd8VcoaBwyNyWMMvaKddoHl9Vrb/WbcauHdy9jXJcqGk+M5hs
 xj8axU4pzxZSt0bkqp09RKxTIR0kqec2TsGaT8xc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jsQ1m-009Rbc-6A; Mon, 06 Jul 2020 13:15:18 +0100
MIME-Version: 1.0
Date: Mon, 06 Jul 2020 13:15:18 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 06/17] KVM: arm64: Introduce accessor for ctxt->sys_reg
In-Reply-To: <a9c3a43e-7850-e74d-5383-905885721ab4@arm.com>
References: <20200615132719.1932408-1-maz@kernel.org>
 <20200615132719.1932408-7-maz@kernel.org>
 <a9c3a43e-7850-e74d-5383-905885721ab4@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <2595cd556bcb8bd996f60ef527b512ef@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, andre.przywara@arm.com, christoffer.dall@arm.com,
 Dave.Martin@arm.com, jintack@cs.columbia.edu, gcherian@marvell.com,
 prime.zeng@hisilicon.com, ascull@google.com, will@kernel.org,
 catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Alex,

On 2020-06-26 16:39, Alexandru Elisei wrote:
> Hi,
> 
> On 6/15/20 2:27 PM, Marc Zyngier wrote:
>> In order to allow the disintegration of the per-vcpu sysreg array,
>> let's introduce a new helper (ctxt_sys_reg()) that returns the
>> in-memory copy of a system register, picked from a given context.
>> 
>> __vcpu_sys_reg() is rewritten to use this helper.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/include/asm/kvm_host.h | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h 
>> b/arch/arm64/include/asm/kvm_host.h
>> index e7fd03271e52..5314399944e7 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -405,12 +405,17 @@ struct kvm_vcpu_arch {
>>  #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
>> 
>>  /*
>> - * Only use __vcpu_sys_reg if you know you want the memory backed 
>> version of a
>> - * register, and not the one most recently accessed by a running 
>> VCPU.  For
>> - * example, for userspace access or for system registers that are 
>> never context
>> - * switched, but only emulated.
>> + * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
>> + * memory backed version of a register, and not the one most recently
>> + * accessed by a running VCPU.  For example, for userspace access or
>> + * for system registers that are never context switched, but only
>> + * emulated.
>>   */
>> -#define __vcpu_sys_reg(v,r)	((v)->arch.ctxt.sys_regs[(r)])
>> +#define __ctxt_sys_reg(c,r)	(&(c)->sys_regs[(r)])
>> +
>> +#define ctxt_sys_reg(c,r)	(*__ctxt_sys_reg(c,r))
>> +
>> +#define __vcpu_sys_reg(v,r)	(ctxt_sys_reg(&(v)->arch.ctxt, (r)))
> 
> This is confusing - __vcpu_sys_reg() returns the value, but 
> __ctxt_sys_reg()
> return a pointer to the value. Because of that, I made the mistake of 
> thinking
> that __vcpu_sys_reg() returns a pointer when reviewing the next patch 
> in the
> series, and I got really worried that stuff was seriously broken (it 
> was not).

This is intentional (the behaviour, not the confusing aspect... ;-), as
__ctx_sys_reg() gets further rewritten as such:

-#define __ctxt_sys_reg(c,r)	(&(c)->sys_regs[(r)])
+static inline u64 *__ctxt_sys_reg(const struct kvm_cpu_context *ctxt, 
int r)
+{
+	if (unlikely(r >= __VNCR_START__ && ctxt->vncr_array))
+		return &ctxt->vncr_array[r - __VNCR_START__];
+
+	return (u64 *)&ctxt->sys_regs[r];
+}

to deal with the VNCR page (depending on whether you use nesting or not,
the sysreg is backed by the VNCR page or the usual sysreg array).

To be clear, there shouldn't be much use of __ctxt_sys_reg (there is 
only
3 in the current code), all for good reasons (core_reg_addr definitely
wants the address of a register).

> I'm not sure what the reasonable solution is, or even if there is one.
> 
> Some thoughts: we could have just one macro, ctxt_sys_reg() and 
> dereference that
> when we want the value; we could keep both and swap the macro 
> definitions; or we
> could encode the fact that a macro returns a pointer in the macro name 
> (so we
> would end up with __ctxt_sys_reg() -> __ctxt_sys_regp() and 
> ctxt_sys_reg ->
> __ctxt_sys_reg()).
> 
> What do you think?

I'm not opposed to any of this, provided that it doesn't create
unnecessary churn and additional confusion. I'll keep it as such
in the meantime, but I'm definitely willing to take a patch going
over this if you think this is necessary.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
