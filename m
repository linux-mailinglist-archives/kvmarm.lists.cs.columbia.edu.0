Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02B393CE012
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 17:56:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8882B4A319;
	Mon, 19 Jul 2021 11:56:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wZQCN-zUQQZ; Mon, 19 Jul 2021 11:56:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 465FD4A1B0;
	Mon, 19 Jul 2021 11:56:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47A0249F8F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 11:56:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TAU+nVkwMAB for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 11:56:37 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4EB6540895
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 11:56:37 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 033F6601FD;
 Mon, 19 Jul 2021 15:56:36 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m5VdC-00EGXH-BP; Mon, 19 Jul 2021 16:56:34 +0100
MIME-Version: 1.0
Date: Mon, 19 Jul 2021 16:56:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Narrow PMU sysreg reset values to
 architectural requirements
In-Reply-To: <171cca9d-2a6e-248c-8502-feba8ebbe55e@arm.com>
References: <20210719123902.1493805-1-maz@kernel.org>
 <20210719123902.1493805-2-maz@kernel.org>
 <171cca9d-2a6e-248c-8502-feba8ebbe55e@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <171834f3198b898d5c2aefa0270b65f2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandre.chartre@oracle.com, robin.murphy@arm.com, drjones@redhat.com,
 linux@arm.linux.org.uk, kernel-team@android.com, rmk+kernel@armlinux.org.uk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Russell King <linux@arm.linux.org.uk>, Robin Murphy <robin.murphy@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2021-07-19 16:55, Alexandru Elisei wrote:
> Hi Marc,
> 
> On 7/19/21 1:38 PM, Marc Zyngier wrote:
>> A number of the PMU sysregs expose reset values that are not
>> compliant with the architecture (set bits in the RES0 ranges,
>> for example).
>> 
>> This in turn has the effect that we need to pointlessly mask
>> some register fields when using them.
>> 
>> Let's start by making sure we don't have illegal values in the
>> shadow registers at reset time. This affects all the registers
>> that dedicate one bit per counter, the counters themselves,
>> PMEVTYPERn_EL0 and PMSELR_EL0.
>> 
>> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/kvm/sys_regs.c | 43 
>> ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 40 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index f6f126eb6ac1..96bdfa0e68b2 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -603,6 +603,41 @@ static unsigned int pmu_visibility(const struct 
>> kvm_vcpu *vcpu,
>>  	return REG_HIDDEN;
>>  }
>> 
>> +static void reset_pmu_reg(struct kvm_vcpu *vcpu, const struct 
>> sys_reg_desc *r)
>> +{
>> +	u64 n, mask = BIT(ARMV8_PMU_CYCLE_IDX);
>> +
>> +	/* No PMU available, any PMU reg may UNDEF... */
>> +	if (!kvm_arm_support_pmu_v3())
>> +		return;
>> +
>> +	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
>> +	n &= ARMV8_PMU_PMCR_N_MASK;
>> +	if (n)
>> +		mask |= GENMASK(n - 1, 0);
> 
> Hm... seems to be missing the cycle counter.

Check the declaration for 'mask'... :-)

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
