Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 394321813E5
	for <lists+kvmarm@lfdr.de>; Wed, 11 Mar 2020 10:03:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C37944A7E4;
	Wed, 11 Mar 2020 05:03:54 -0400 (EDT)
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
	with ESMTP id 2jRGM1wVoeWT; Wed, 11 Mar 2020 05:03:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C6564A578;
	Wed, 11 Mar 2020 05:03:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB8044A51E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 05:03:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OSkWAShYO0A7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Mar 2020 05:03:51 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 90E2D4A389
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 05:03:51 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C1A520873;
 Wed, 11 Mar 2020 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583917430;
 bh=ibkYfT8H8iwwHnGO0guecciLLSfXPKRIswI7WrzOsAU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fqXpF49MGci3+/2P1nx05RN+C8Q7kAwE1N+DvnF1cM+9+DQmXANQlSecX4bDgB5Te
 UDGPbYKaFfd2wiuPtW52npjmWKskS+tC8pOAhkN0jD6YwZ7mSbLGwNgsWmNSMaq6dH
 Al/hCcA5OZoMyq9ueqOAbRQv/roYKcq5MtGN7tiQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jBxHI-00BrMA-Ow; Wed, 11 Mar 2020 09:03:48 +0000
MIME-Version: 1.0
Date: Wed, 11 Mar 2020 09:03:48 +0000
From: Marc Zyngier <maz@kernel.org>
To: Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH v3 03/32] irqchip/gic-v3: Workaround Cavium TX1 erratum
 when reading GICD_TYPER2
In-Reply-To: <20200311084515.5vbfudbls3cj2cre@rric.localdomain>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-4-maz@kernel.org>
 <20200309221137.5pjh4vkc62ft3h2a@rric.localdomain>
 <b1b7db1f0e1c47b7d9e2dfbbe3409b77@kernel.org>
 <20200311084515.5vbfudbls3cj2cre@rric.localdomain>
Message-ID: <74682a83c75bc8e517462d181e6c24c7@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rrichter@marvell.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de,
 jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com,
 yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 Andrew Murray <Andrew.Murray@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
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

Hi Robert,

On 2020-03-11 08:45, Robert Richter wrote:
> Hi Marc,
> 
> On 10.03.20 11:41:09, Marc Zyngier wrote:
>> On 2020-03-09 22:11, Robert Richter wrote:
>> > On 24.12.19 11:10:26, Marc Zyngier wrote:
> 
>> > > @@ -1502,6 +1512,12 @@ static const struct gic_quirk gic_quirks[] = {
>> > >  		.mask	= 0xffffffff,
>> > >  		.init	= gic_enable_quirk_hip06_07,
>> > >  	},
>> > > +	{
>> > > +		.desc	= "GICv3: Cavium TX1 GICD_TYPER2 erratum",
>> >
>> > There is no errata number yet.
>> 
>> Please let me know when/if you obtain one.
> 
> GIC-38539: GIC faults when accessing reserved GICD_TYPER2 register
> 
> Applies to (covered with iidr mask below):
> 
>  ThunderX: CN88xx
>  OCTEON TX: CN83xx, CN81xx
>  OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
> 
> Issue: Access to GIC reserved registers results in an exception.
> Notes:
> 1) This applies to other reserved registers too.
> 2) The errata number is unique over all IP blocks, so a macro
>    CAVIUM_ERRATUM_38539 is ok.

Great, thanks a lot for chasing this. One question though: does this
apply to the distributor only? Or to all reserved registers regardless
of the architectural block they are in?

It won't change the workaround for now, but knowing the scope of the
erratum will help future developments.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
