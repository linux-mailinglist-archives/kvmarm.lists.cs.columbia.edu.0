Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17E021E3DA5
	for <lists+kvmarm@lfdr.de>; Wed, 27 May 2020 11:34:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C1434B1F8;
	Wed, 27 May 2020 05:34:16 -0400 (EDT)
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
	with ESMTP id uofv-5OHIAg0; Wed, 27 May 2020 05:34:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B44C4B1D1;
	Wed, 27 May 2020 05:34:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0619E4B130
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 05:34:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zi28cjKDKMcr for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 May 2020 05:34:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A32F94B096
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 05:34:12 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 752EB20890;
 Wed, 27 May 2020 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590572051;
 bh=7Pi5My5nrzsGsUPwd6yUzD0/bg9Bh6OPCq4593K9TBk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WAWjg7T60B2Gikan7es25KIN24d3UnYrPrk01hgFvSxnLQllWeL9RXVuAttD1WpsS
 wQzw505kXGws+pWoXbpVW81ZKXZyfVbiakstUmqJzW3cBEs+GK3YgU9Q3ehbGfvlOM
 3/fhysIll/R99br1U1BtzIKHaqrGiG4ZQlPQ09jA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jdsRt-00Fejs-NL; Wed, 27 May 2020 10:34:09 +0100
MIME-Version: 1.0
Date: Wed, 27 May 2020 10:34:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 26/26] KVM: arm64: Parametrize exception entry with a
 target EL
In-Reply-To: <20200519104457.GA19548@C02TD0UTHF1T.local>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-27-maz@kernel.org>
 <20200519104457.GA19548@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <db34b0fbd58275a0a2a0c9108b9507d6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, Dave.Martin@arm.com, jintack@cs.columbia.edu,
 alexandru.elisei@arm.com, gcherian@marvell.com, prime.zeng@hisilicon.com,
 will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, Will Deacon <will@kernel.org>,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>,
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

HI Mark,

On 2020-05-19 11:44, Mark Rutland wrote:
> On Wed, Apr 22, 2020 at 01:00:50PM +0100, Marc Zyngier wrote:
>> We currently assume that an exception is delivered to EL1, always.
>> Once we emulate EL2, this no longer will be the case. To prepare
>> for this, add a target_mode parameter.
>> 
>> While we're at it, merge the computing of the target PC and PSTATE in
>> a single function that updates both PC and CPSR after saving their
>> previous values in the corresponding ELR/SPSR. This ensures that they
>> are updated in the correct order (a pretty common source of bugs...).
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/kvm/inject_fault.c | 75 
>> ++++++++++++++++++-----------------
>>  1 file changed, 38 insertions(+), 37 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/inject_fault.c 
>> b/arch/arm64/kvm/inject_fault.c
>> index d3ebf8bca4b89..3dbcbc839b9c3 100644
>> --- a/arch/arm64/kvm/inject_fault.c
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -26,28 +26,12 @@ enum exception_type {
>>  	except_type_serror	= 0x180,
>>  };
>> 
>> -static u64 get_except_vector(struct kvm_vcpu *vcpu, enum 
>> exception_type type)
>> -{
>> -	u64 exc_offset;
>> -
>> -	switch (*vcpu_cpsr(vcpu) & (PSR_MODE_MASK | PSR_MODE32_BIT)) {
>> -	case PSR_MODE_EL1t:
>> -		exc_offset = CURRENT_EL_SP_EL0_VECTOR;
>> -		break;
>> -	case PSR_MODE_EL1h:
>> -		exc_offset = CURRENT_EL_SP_ELx_VECTOR;
>> -		break;
>> -	case PSR_MODE_EL0t:
>> -		exc_offset = LOWER_EL_AArch64_VECTOR;
>> -		break;
>> -	default:
>> -		exc_offset = LOWER_EL_AArch32_VECTOR;
>> -	}
>> -
>> -	return vcpu_read_sys_reg(vcpu, VBAR_EL1) + exc_offset + type;
>> -}
>> -
>>  /*
>> + * This performs the exception entry at a given EL (@target_mode), 
>> stashing PC
>> + * and PSTATE into ELR and SPSR respectively, and compute the new 
>> PC/PSTATE.
>> + * The EL passed to this function *must* be a non-secure, privileged 
>> mode with
>> + * bit 0 being set (PSTATE.SP == 1).
>> + *
>>   * When an exception is taken, most PSTATE fields are left unchanged 
>> in the
>>   * handler. However, some are explicitly overridden (e.g. M[4:0]). 
>> Luckily all
>>   * of the inherited bits have the same position in the 
>> AArch64/AArch32 SPSR_ELx
>> @@ -59,10 +43,35 @@ static u64 get_except_vector(struct kvm_vcpu 
>> *vcpu, enum exception_type type)
>>   * Here we manipulate the fields in order of the AArch64 SPSR_ELx 
>> layout, from
>>   * MSB to LSB.
>>   */
>> -static unsigned long get_except64_pstate(struct kvm_vcpu *vcpu)
>> +static void enter_exception(struct kvm_vcpu *vcpu, unsigned long 
>> target_mode,
>> +			    enum exception_type type)
> 
> Since this is all for an AArch64 target, could we keep `64` in the 
> name,
> e.g enter_exception64? That'd mirror the callers below.
> 
>>  {
>> -	unsigned long sctlr = vcpu_read_sys_reg(vcpu, SCTLR_EL1);
>> -	unsigned long old, new;
>> +	unsigned long sctlr, vbar, old, new, mode;
>> +	u64 exc_offset;
>> +
>> +	mode = *vcpu_cpsr(vcpu) & (PSR_MODE_MASK | PSR_MODE32_BIT);
>> +
>> +	if      (mode == target_mode)
>> +		exc_offset = CURRENT_EL_SP_ELx_VECTOR;
>> +	else if ((mode | 1) == target_mode)
>> +		exc_offset = CURRENT_EL_SP_EL0_VECTOR;
> 
> It would be nice if we could add a mnemonic for the `1` here, e.g.
> PSR_MODE_SP0 or PSR_MODE_THREAD_BIT.

I've addressed both comments as follows:

diff --git a/arch/arm64/include/asm/ptrace.h 
b/arch/arm64/include/asm/ptrace.h
index bf57308fcd63..953b6a1ce549 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -35,6 +35,7 @@
  #define GIC_PRIO_PSR_I_SET		(1 << 4)

  /* Additional SPSR bits not exposed in the UABI */
+#define PSR_MODE_THREAD_BIT	(1 << 0)
  #define PSR_IL_BIT		(1 << 20)

  /* AArch32-specific ptrace requests */
diff --git a/arch/arm64/kvm/inject_fault.c 
b/arch/arm64/kvm/inject_fault.c
index 3dbcbc839b9c..ebfdfc27b2bd 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -43,8 +43,8 @@ enum exception_type {
   * Here we manipulate the fields in order of the AArch64 SPSR_ELx 
layout, from
   * MSB to LSB.
   */
-static void enter_exception(struct kvm_vcpu *vcpu, unsigned long 
target_mode,
-			    enum exception_type type)
+static void enter_exception64(struct kvm_vcpu *vcpu, unsigned long 
target_mode,
+			      enum exception_type type)
  {
  	unsigned long sctlr, vbar, old, new, mode;
  	u64 exc_offset;
@@ -53,7 +53,7 @@ static void enter_exception(struct kvm_vcpu *vcpu, 
unsigned long target_mode,

  	if      (mode == target_mode)
  		exc_offset = CURRENT_EL_SP_ELx_VECTOR;
-	else if ((mode | 1) == target_mode)
+	else if ((mode | PSR_MODE_THREAD_BIT) == target_mode)
  		exc_offset = CURRENT_EL_SP_EL0_VECTOR;
  	else if (!(mode & PSR_MODE32_BIT))
  		exc_offset = LOWER_EL_AArch64_VECTOR;
@@ -126,7 +126,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool 
is_iabt, unsigned long addr
  	bool is_aarch32 = vcpu_mode_is_32bit(vcpu);
  	u32 esr = 0;

-	enter_exception(vcpu, PSR_MODE_EL1h, except_type_sync);
+	enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);

  	vcpu_write_sys_reg(vcpu, addr, FAR_EL1);

@@ -156,7 +156,7 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
  {
  	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);

-	enter_exception(vcpu, PSR_MODE_EL1h, except_type_sync);
+	enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);

  	/*
  	 * Build an unknown exception, depending on the instruction


Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
