Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24B2EAC94
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 15:04:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 064464B28A;
	Tue,  5 Jan 2021 09:04:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQ5Rjq24B024; Tue,  5 Jan 2021 09:04:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 342B04B32E;
	Tue,  5 Jan 2021 09:04:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 411374B28A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 09:04:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LUkUUady+bbp for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 09:04:39 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0CA974B26E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 09:04:39 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3B2422AAE;
 Tue,  5 Jan 2021 14:04:37 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwmwt-005RZD-Ps; Tue, 05 Jan 2021 14:04:35 +0000
MIME-Version: 1.0
Date: Tue, 05 Jan 2021 14:04:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] KVM: arm64: Remove spurious semicolon in reg_to_encoding()
In-Reply-To: <7a5b86e3-a470-a2e0-71b9-177c6c15ecfd@arm.com>
References: <20201231150936.4013764-1-maz@kernel.org>
 <7a5b86e3-a470-a2e0-71b9-177c6c15ecfd@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a65b85fc0531f37263d16b3d67d1b2c4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On 2021-01-05 13:54, Alexandru Elisei wrote:
> Hi Marc,
> 
> On 12/31/20 3:09 PM, Marc Zyngier wrote:
>> Although not a problem right now, it flared up while working
>> on some other aspects of the code-base. Remove the useless
>> semicolon.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index d46e7f706cb0..42ccc27fb684 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -923,7 +923,7 @@ static bool access_pmuserenr(struct kvm_vcpu 
>> *vcpu, struct sys_reg_params *p,
>> 
>>  #define reg_to_encoding(x)						\
>>  	sys_reg((u32)(x)->Op0, (u32)(x)->Op1,				\
>> -		(u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2);
>> +		(u32)(x)->CRn, (u32)(x)->CRm, (u32)(x)->Op2)
> 
> Macro's shouldn't really end with a semicolon, otherwise code might 
> break
> unexpectedly:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> I skimmed over the code and the macro is used like a function. Do you 
> think it's
> worth turning it into a function to gain type checking for the
> argument (which is
> expected to be sys_reg_desc) and for the return value?

Not quite.

This macro takes indifferently a sys_reg_desc or a sys_reg_params,
making it impossible to turn into a function. Is it disgusting and
makes you want to pull your eyes out? Yes.

The whole params/desc duality dates back to the early 32bit code,
and I blame Rusty Russell for it. Just saying... ;-)

That's one of things I always wanted to refactor...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
