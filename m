Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EE2AD3BF
	for <lists+kvmarm@lfdr.de>; Tue, 10 Nov 2020 11:28:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E2024B7E2;
	Tue, 10 Nov 2020 05:28:00 -0500 (EST)
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
	with ESMTP id WJ86nZZ4PvEY; Tue, 10 Nov 2020 05:28:00 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 353204B7C5;
	Tue, 10 Nov 2020 05:27:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 950594B7C4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:27:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzAGC-v05sYZ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Nov 2020 05:27:57 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DE3A4B7B5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Nov 2020 05:27:57 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C2DB2065E;
 Tue, 10 Nov 2020 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605004076;
 bh=D3N2w77caH1nYigrEDNdwjkhF7FpCY8XFDb/gocrMa8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Hj26FxjUNkLRi3cKIBD4rWIWjygPQlwedqys+fCn298MmcaTG8DOu2B6UTAwegBnL
 yU9tXavYxFEWLIG/IwxKkTwvUIaYyIuA+BIL9cn8GUgxRC6HEjJMrM+UN4hJBumC/v
 xyDNwz7//3R+a8O1v6PxPxDkeLFCl8sUqjzvnPuY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kcQsU-009PvQ-37; Tue, 10 Nov 2020 10:27:54 +0000
MIME-Version: 1.0
Date: Tue, 10 Nov 2020 10:27:54 +0000
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 4/8] KVM: arm64: Map AArch32 cp14 register to AArch64
 sysregs
In-Reply-To: <1830d62e-ac47-9b84-6375-baed62f8486e@arm.com>
References: <20201102191609.265711-1-maz@kernel.org>
 <20201102191609.265711-5-maz@kernel.org>
 <1830d62e-ac47-9b84-6375-baed62f8486e@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3a8a34dc2aa45c5cb6acbc9debd65691@kernel.org>
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
>> Similarly to what has been done on the cp15 front, repaint the
>> debug registers to use their AArch64 counterparts. This results
>> in some simplification as we can remove the 32bit-specific
>> accessors.
> 
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 137818793a4a..c41e7ca60c8c 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -361,26 +361,30 @@ static bool trap_debug_regs(struct kvm_vcpu 
>> *vcpu,
>> -#define DBGBXVR(n)							\
>> -	{ Op1( 0), CRn( 1), CRm((n)), Op2( 1), trap_xvr, NULL, n }
>> +#define DBG_BCR_BVR_WCR_WVR(n)						      \
>> +	/* DBGBVRn */							      \
>> +	{ AA32(LO), Op1( 0), CRn( 0), CRm((n)), Op2( 4), trap_bvr, NULL, n 
>> }, \
> 
> Just to check I understand what is going on here: This BVR AA32(LO) is
> needed because the
> dbg_bvr array is shared with the DBGBXVR registers...
> 
> 
>> +	/* DBGBCRn */							      \
>> +	{ AA32(LO), Op1( 0), CRn( 0), CRm((n)), Op2( 5), trap_bcr, NULL, n 
>> }, \
>> +	/* DBGWVRn */							      \
>> +	{ AA32(LO), Op1( 0), CRn( 0), CRm((n)), Op2( 6), trap_wvr, NULL, n 
>> }, \
>> +	/* DBGWCRn */							      \
>> +	{ AA32(LO), Op1( 0), CRn( 0), CRm((n)), Op2( 7), trap_wcr, NULL, n }
> 
> ... these don't have an alias, but its harmless.

This is a bug-for-bug translation of the original code. I guess I'll 
drop
that altogether.

> 
> [...]
> 
>> @@ -1931,7 +1896,9 @@ static const struct sys_reg_desc cp15_regs[] = {
>>  	/* DFSR */
>>  	{ Op1( 0), CRn( 5), CRm( 0), Op2( 0), access_vm_reg, NULL, ESR_EL1 
>> },
>>  	{ Op1( 0), CRn( 5), CRm( 0), Op2( 1), access_vm_reg, NULL, 
>> IFSR32_EL2 },
>> +	/* ADFSR */
>>  	{ Op1( 0), CRn( 5), CRm( 1), Op2( 0), access_vm_reg, NULL, AFSR0_EL1 
>> },
>> +	/* AIFSR */
>>  	{ Op1( 0), CRn( 5), CRm( 1), Op2( 1), access_vm_reg, NULL, AFSR1_EL1 
>> },
>>  	/* DFAR */
>>  	{ AA32(LO), Op1( 0), CRn( 6), CRm( 0), Op2( 0), access_vm_reg, NULL, 
>> FAR_EL1 },
> 
> I guess these were meant for the previous patch.

Yup, I'll move that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
