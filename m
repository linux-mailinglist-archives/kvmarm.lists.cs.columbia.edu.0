Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FE2A4647
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 14:26:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE3F4B3B6;
	Tue,  3 Nov 2020 08:26:26 -0500 (EST)
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
	with ESMTP id ChTzAV4bumRU; Tue,  3 Nov 2020 08:26:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F07D4B390;
	Tue,  3 Nov 2020 08:26:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AE9734B36A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 08:26:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wwPglQVIyveI for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Nov 2020 08:26:22 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 863454B353
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 08:26:22 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1AFF0206F9;
 Tue,  3 Nov 2020 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604409981;
 bh=f5lwlpSvP4h9YKCmj3BEycixNCRVIsq8dvVg94jW0mk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n1PRk30wdyubRwsH7ix2osVvReTOpYFkd2vv1UdhkTB3QCv1HAsmMChcohCRRFK30
 htv8JA7f8Uhss6R2VWcAblVt79grk+l7tyOBIFYd69oqWRaGuFneu2CGM5mY1jQ/z9
 OMp6AfOFQusLSQ2ri4sZ+C/C22ijmbG7FPCrmmWY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kZwKI-0079Xg-83; Tue, 03 Nov 2020 13:26:19 +0000
MIME-Version: 1.0
Date: Tue, 03 Nov 2020 13:26:18 +0000
From: Marc Zyngier <maz@kernel.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [RFC] KVM: arm64: Don't force broadcast tlbi when guest is running
In-Reply-To: <18edd19d-15a1-bff2-8349-3f702d4c36c2@hisilicon.com>
References: <1603331829-33879-1-git-send-email-zhangshaokun@hisilicon.com>
 <be1d84d42df6203ad993e8d20d9bd6da@kernel.org>
 <0a7032a7-ff23-b537-fdbd-8189380d4f41@hisilicon.com>
 <65c347bb6442ae003caee28c10467ae1@kernel.org>
 <18edd19d-15a1-bff2-8349-3f702d4c36c2@hisilicon.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9fba5b0e6d3c1b8e217d3b03916b30c7@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 tangnianyao@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2020-11-03 11:31, Shaokun Zhang wrote:

[...]

>>> Further, we consider restricting tlbi broadcast range and make
>>> tlbi more accurate.
>>> One scheme is replacing tlbiis with ipi + tlbi + HCR_EL2.FB=0.
>> 
>> Ah. That old thing again. No, thank you. The right thing to do
>> is to build CPUs and interconnects that properly deals with
>> IS invalidations by not sending DVM messages to places where
>> things don't run (snoop filters?). I also doubt the arm64
>> maintainers would be sympathetic to the idea anyway.
> 
> We also do the same test on intel 6248 and get better result,
> less performance drop in multi-vm case compare to single vm.
> Intel use ipi + flush tlb scenario, do you think this scenario is
> meaningful on Arm architect hardware?

I can't see how you can compare the two architectures: one only
has local TLB invalidation and *must* rely on IPI, while the other
supports broadcast TLB invalidation which can lead to better performance
and lower latencies if the HW is well designed.

>>> Consider I-cache invalidation, KVM also needs to invalid icache
>>> when moving vcpu to a new pcpu.
>>> Do we miss any cases that need HCR_EL2.FB == 1?
>>> Eventually we expect HCR_EL2.FB == 0 if it is possible.
>> 
>> I have no intention to ever set FB to 0, as this would resu> in 
>> over-invalidation in the general case, and worse performance
> 
> The reason that we want to disable FB is that IPI solution
> is needed if it is accepted.

Let me repeat it: setting FB=0 may improve bad implementations, but
has will have a negative impact on *good* HW implementations.
It results in extra TLB and I-cache invalidations in the general case.

You are only considering your narrow use case where vcpus are pinned
to physical CPUs, where you indeed don't need invalidations to be
broadcast. But that's not everybody has your use case.

*IF* you come up with a way to find that a vcpu is pinned and cannot
be migrated, then that's an avenue for optimisation. But otherwise, no.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
