Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D129D212428
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 15:09:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 596D24B61A;
	Thu,  2 Jul 2020 09:09:01 -0400 (EDT)
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
	with ESMTP id 19m5Igvwg7ie; Thu,  2 Jul 2020 09:09:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4102B4B605;
	Thu,  2 Jul 2020 09:09:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F19D34B5FF
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:08:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gIKYto2PHlM9 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 09:08:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 79D4E4B5FD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 09:08:57 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B401207CD;
 Thu,  2 Jul 2020 13:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593695336;
 bh=wzZQY7bA/hVY2XqRItqhXuqM8/KSi7U3zQpAD19GvME=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=U3Ep6pAGs+trXcdrVcDE0GJ6S1lm4ZKfCN6X7qA4jo3nic152rvF0aTn+WVCkmxtt
 ZvBQzUOH12AYzzqdeCFM+n8rHqQSbVuedg3p3hSaywJkUqPJh1uWP+W5tcFQyQaBNN
 6OxpNl+6i1tx7Y6XcDU01woX+eb4Tzlu0odJDujI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jqyxS-008PNJ-Sj; Thu, 02 Jul 2020 14:08:55 +0100
MIME-Version: 1.0
Date: Thu, 02 Jul 2020 14:08:54 +0100
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/8] arm64: microbench: gic: Add gicv4.1
 support for ipi latency test.
In-Reply-To: <087ef371-5e7b-e0b2-900f-67b2eacb4e0f@redhat.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-4-wangjingyi11@huawei.com>
 <087ef371-5e7b-e0b2-900f-67b2eacb4e0f@redhat.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <05a3da5fa35568606e55eb6428ce91d8@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, wangjingyi11@huawei.com,
 drjones@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On 2020-07-02 13:57, Auger Eric wrote:
> Hi Jingyi,
> 
> On 7/2/20 5:01 AM, Jingyi Wang wrote:
>> If gicv4.1(sgi hardware injection) supported, we test ipi injection
>> via hw/sw way separately.
>> 
>> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
>> ---
>>  arm/micro-bench.c    | 45 
>> +++++++++++++++++++++++++++++++++++++++-----
>>  lib/arm/asm/gic-v3.h |  3 +++
>>  lib/arm/asm/gic.h    |  1 +
>>  3 files changed, 44 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arm/micro-bench.c b/arm/micro-bench.c
>> index fc4d356..80d8db3 100644
>> --- a/arm/micro-bench.c
>> +++ b/arm/micro-bench.c
>> @@ -91,9 +91,40 @@ static void gic_prep_common(void)
>>  	assert(irq_ready);
>>  }
>> 
>> -static void ipi_prep(void)
>> +static bool ipi_prep(void)
> Any reason why the bool returned value is preferred over the standard 
> int?
>>  {
>> +	u32 val;
>> +
>> +	val = readl(vgic_dist_base + GICD_CTLR);
>> +	if (readl(vgic_dist_base + GICD_TYPER2) & GICD_TYPER2_nASSGIcap) {
>> +		val &= ~GICD_CTLR_ENABLE_G1A;
>> +		val &= ~GICD_CTLR_nASSGIreq;
>> +		writel(val, vgic_dist_base + GICD_CTLR);
>> +		val |= GICD_CTLR_ENABLE_G1A;
>> +		writel(val, vgic_dist_base + GICD_CTLR);
> Why do we need this G1A dance?

Because it isn't legal to change the SGI behaviour when groups are 
enabled.
Yes, it is described in this bit of documentation nobody has access to.

And this code needs to track RWP on disabling Group-1.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
