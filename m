Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0969A161948
	for <lists+kvmarm@lfdr.de>; Mon, 17 Feb 2020 19:00:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 836B44AF4C;
	Mon, 17 Feb 2020 13:00:16 -0500 (EST)
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
	with ESMTP id PVoSdLmZjZ4F; Mon, 17 Feb 2020 13:00:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 627AA4AF50;
	Mon, 17 Feb 2020 13:00:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E17BA4AF47
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 13:00:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHRjamFUmh6p for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Feb 2020 13:00:13 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 05CA34A2E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 13:00:13 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DBAA3207FD;
 Mon, 17 Feb 2020 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581962412;
 bh=N4IaW7dJRmwJgdZkZ+ORETnJlyDW9qtyXif08JJnFaE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=A9vcyWM1I1hyR8h+F9be43m2NDJdYDzfr3Jk4E16UwflHq2bKAnqUpqKSYDCrKPVt
 ZY3sUGVq+MJmJdKQ00JDoYLChTZjbH2TSbRsZWR7X23+jjZkbtDvkoSl1/pdmgw4Mm
 67Dhpm+aIyl38XH+/zeiiGveb6jsacMbcxINtsCI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j3kgk-005z8z-1d; Mon, 17 Feb 2020 18:00:10 +0000
MIME-Version: 1.0
Date: Mon, 17 Feb 2020 18:00:10 +0000
From: Marc Zyngier <maz@kernel.org>
To: Tomasz Nowicki <tnowicki@marvell.com>
Subject: Re: [PATCH 0/2] KVM: arm/arm64: Fixes for scheudling htimer of
 emulated timers
In-Reply-To: <20200217145438.23289-1-tnowicki@marvell.com>
References: <20200217145438.23289-1-tnowicki@marvell.com>
Message-ID: <f70d41fd006319e3d62224c410d62e20@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tnowicki@marvell.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 gkulkarni@marvell.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: gkulkarni@marvell.com, kvm@vger.kernel.org, rrichter@marvell.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On 2020-02-17 14:54, Tomasz Nowicki wrote:
> This small series contains two fixes which were found while testing
> Marc's ARM NV patch set, where we are going to have at most 4 timers
> and the two are purely emulated.

What are these patches fixing? the NV series? or mainline?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
