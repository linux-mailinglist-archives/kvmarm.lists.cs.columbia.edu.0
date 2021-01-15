Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5827D2F810B
	for <lists+kvmarm@lfdr.de>; Fri, 15 Jan 2021 17:42:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87D2B4B1BC;
	Fri, 15 Jan 2021 11:42:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sm2GZdFpPjgn; Fri, 15 Jan 2021 11:42:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 403774B1AD;
	Fri, 15 Jan 2021 11:42:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC7AE4B175
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 11:42:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ke8+EE+zUUXT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 Jan 2021 11:42:46 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BD6464B155
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 11:42:46 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B538221FE;
 Fri, 15 Jan 2021 16:42:45 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l0SBP-007o67-EU; Fri, 15 Jan 2021 16:42:43 +0000
MIME-Version: 1.0
Date: Fri, 15 Jan 2021 16:42:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 6/6] KVM: arm64: Upgrade PMU support to ARMv8.4
In-Reply-To: <ec06055b-56ad-1589-7a5d-95d9f47466ce@redhat.com>
References: <20210114105633.2558739-1-maz@kernel.org>
 <20210114105633.2558739-7-maz@kernel.org>
 <ec06055b-56ad-1589-7a5d-95d9f47466ce@redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <28dab4367d6ced5a7d7cbc80ee77f68d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, suzuki.poulose@arm.com,
 kernel-team@android.com, james.morse@arm.com, alexandru.elisei@arm.com,
 julien.thierry.kdev@gmail.com
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

Hi Eric,

On 2021-01-15 14:01, Auger Eric wrote:
> Hi Marc,
> 
> On 1/14/21 11:56 AM, Marc Zyngier wrote:
>> Upgrading the PMU code from ARMv8.1 to ARMv8.4 turns out to be
>> pretty easy. All that is required is support for PMMIR_EL1, which
>> is read-only, and for which returning 0 is a valid option.
>> 
>> Let's just do that and adjust what we return to the guest.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 8f79ec1fffa7..2f4ecbd2abfb 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1051,10 +1051,10 @@ static u64 read_id_reg(const struct kvm_vcpu 
>> *vcpu,
>>  		/* Limit debug to ARMv8.0 */
>>  		val &= ~FEATURE(ID_AA64DFR0_DEBUGVER);
>>  		val |= FIELD_PREP(FEATURE(ID_AA64DFR0_DEBUGVER), 6);
>> -		/* Limit guests to PMUv3 for ARMv8.1 */
>> +		/* Limit guests to PMUv3 for ARMv8.4 */
>>  		val = cpuid_feature_cap_perfmon_field(val,
>>  						      ID_AA64DFR0_PMUVER_SHIFT,
>> -						      kvm_vcpu_has_pmu(vcpu) ? ID_AA64DFR0_PMUVER_8_1 : 0);
>> +						      kvm_vcpu_has_pmu(vcpu) ? ID_AA64DFR0_PMUVER_8_4 : 0);
>>  		break;
>>  	case SYS_ID_DFR0_EL1:
>>  		/* Limit guests to PMUv3 for ARMv8.1 */
> what about the debug version in aarch32 state. Is it on purpose that 
> you
> leave it as 8_1?

That's a good point. There is also the fact that we keep reporting
STALL_SLOT as a valid event even in PMCEID0_EL1 despite PMMIR_EL1.SLOTS
always reporting 0.

I'll fix that and resend something next week.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
