Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93120F03B
	for <lists+kvmarm@lfdr.de>; Tue, 30 Jun 2020 10:15:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CC834B224;
	Tue, 30 Jun 2020 04:15:22 -0400 (EDT)
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
	with ESMTP id l1THNeuC9D6q; Tue, 30 Jun 2020 04:15:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5EFA4B212;
	Tue, 30 Jun 2020 04:15:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 660D14B20B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jun 2020 04:15:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Svgheevh8pqG for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Jun 2020 04:15:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7BFD24B208
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Jun 2020 04:15:18 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60EE32063A;
 Tue, 30 Jun 2020 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593504917;
 bh=6MvI1kwQRvqXSFwW4TcUTcCJg2JKBioRMbSAFmaGKqw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MPdPcHXMaQJKTqvCDJY1G+HKx0cCCfKOdleJrs3Dx8UxkElPXscVdXeUrri5GlsdS
 HSg+3aaq8dkuDf2MleZez9L2vy5+0+JHFBNTjJrb0rrcMokhTHNnZF1aUSdhCE3QMx
 Y6ezKbaxlPSa9hijszx9sOPEoVEtqjLzMZfTXr94=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jqBQB-007gTZ-S3; Tue, 30 Jun 2020 09:15:15 +0100
MIME-Version: 1.0
Date: Tue, 30 Jun 2020 09:15:15 +0100
From: Marc Zyngier <maz@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
In-Reply-To: <20200629213321.2953022-2-robh@kernel.org>
References: <20200629213321.2953022-1-robh@kernel.org>
 <20200629213321.2953022-2-robh@kernel.org>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <bfe3f27495152e4888f2ab2c02dd13a4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robh@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
 julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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

Hi Rob,

On 2020-06-29 22:33, Rob Herring wrote:
> On Cortex-A77 r0p0 and r1p0, a sequence of a non-cacheable or device 
> load
> and a store exclusive or PAR_EL1 read can cause a deadlock.
> 
> The workaround requires a DMB SY before and after a PAR_EL1 register 
> read
> and the disabling of KVM. KVM must be disabled to prevent the 
> problematic
> sequence in guests' EL1. This workaround also depends on a firmware
> counterpart to enable the h/w to insert DMB SY after load and store
> exclusive instructions. See the errata document SDEN-1152370 v10 [1] 
> for
> more information.
> 

This seems a bit extreme. Given that this CPU is most likely
used in big-little systems, there is still a bunch of CPUs
on which we could reliably execute guests. It is also likely
that people could run trusted guests.

I would suggest printing a big fat warning and taining the
kernel with TAINT_CPU_OUT_OF_SPEC, together with the required
DSBs in the KVM code.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
