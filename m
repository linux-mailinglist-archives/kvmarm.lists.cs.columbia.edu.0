Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9E310A2A
	for <lists+kvmarm@lfdr.de>; Fri,  5 Feb 2021 12:23:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9559E4B3D5;
	Fri,  5 Feb 2021 06:23:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQmM46lNomRp; Fri,  5 Feb 2021 06:23:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5689E4B3C7;
	Fri,  5 Feb 2021 06:23:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 16C284B3C3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 06:23:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6ECEH4jxzVY for <kvmarm@lists.cs.columbia.edu>;
 Fri,  5 Feb 2021 06:23:42 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CB3FA4B3A6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  5 Feb 2021 06:23:41 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7ABB264DB2;
 Fri,  5 Feb 2021 11:23:40 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l7zD8-00CFsF-2x; Fri, 05 Feb 2021 11:23:38 +0000
MIME-Version: 1.0
Date: Fri, 05 Feb 2021 11:23:37 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v17 1/7] arm/arm64: Probe for the presence of KVM
 hypervisor
In-Reply-To: <20210205111921.GA22109@willie-the-truck>
References: <20210202141204.3134855-1-maz@kernel.org>
 <20210202141204.3134855-2-maz@kernel.org>
 <d5765ade-7199-2d1e-6d59-d3de6a52c6ce@arm.com>
 <20210205111921.GA22109@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <29f8b6f5faf33472b74ab5f2406c6081@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, steven.price@arm.com,
 netdev@vger.kernel.org, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, pbonzini@redhat.com, seanjc@google.com,
 richardcochran@gmail.com, Mark.Rutland@arm.com, suzuki.poulose@arm.com,
 Andre.Przywara@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, Steve.Capper@arm.com, justin.he@arm.com,
 jianyong.wu@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: justin.he@arm.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org,
 Andre.Przywara@arm.com, john.stultz@linaro.org, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, kernel-team@android.com,
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

On 2021-02-05 11:19, Will Deacon wrote:
> On Fri, Feb 05, 2021 at 09:11:00AM +0000, Steven Price wrote:
>> On 02/02/2021 14:11, Marc Zyngier wrote:
>> > diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/kvm_guest.c
>> > new file mode 100644
>> > index 000000000000..23ce1ded88b4
>> > --- /dev/null
>> > +++ b/drivers/firmware/smccc/kvm_guest.c
>> > @@ -0,0 +1,51 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +#define pr_fmt(fmt) "smccc: KVM: " fmt
>> > +
>> > +#include <linux/init.h>
>> > +#include <linux/arm-smccc.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/string.h>
>> > +
>> > +static DECLARE_BITMAP(__kvm_arm_hyp_services, ARM_SMCCC_KVM_NUM_FUNCS) __ro_after_init = { };
>> > +
>> > +void __init kvm_init_hyp_services(void)
>> > +{
>> > +	int i;
>> > +	struct arm_smccc_res res;
>> > +
>> > +	if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_HVC)
>> > +		return;
>> > +
>> > +	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
>> > +	if (res.a0 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0 ||
>> > +	    res.a1 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1 ||
>> > +	    res.a2 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 ||
>> > +	    res.a3 != ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3)
>> > +		return;
>> > +
>> > +	memset(&res, 0, sizeof(res));
>> > +	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID, &res);
>> > +	for (i = 0; i < 32; ++i) {
>> > +		if (res.a0 & (i))
>> > +			set_bit(i + (32 * 0), __kvm_arm_hyp_services);
>> > +		if (res.a1 & (i))
>> > +			set_bit(i + (32 * 1), __kvm_arm_hyp_services);
>> > +		if (res.a2 & (i))
>> > +			set_bit(i + (32 * 2), __kvm_arm_hyp_services);
>> > +		if (res.a3 & (i))
>> > +			set_bit(i + (32 * 3), __kvm_arm_hyp_services);
>> 
>> The bit shifts are missing, the tests should be of the form:
>> 
>> 	if (res.a0 & (1 << i))
>> 
>> Or indeed using a BIT() macro.
> 
> Maybe even test_bit()?

yeah. I'll fix that up, thanks for pointing this out.

       M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
