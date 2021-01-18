Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EBD802FA61C
	for <lists+kvmarm@lfdr.de>; Mon, 18 Jan 2021 17:28:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79F1C4B2D1;
	Mon, 18 Jan 2021 11:28:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id om0e+9Jv3t-9; Mon, 18 Jan 2021 11:28:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 519BA4B2CC;
	Mon, 18 Jan 2021 11:28:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 392894B1AD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 11:28:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTueNXlAM-Dp for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Jan 2021 11:28:15 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1AF464B199
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Jan 2021 11:28:15 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB96F206D8;
 Mon, 18 Jan 2021 16:28:13 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l1XNz-008YJ7-L2; Mon, 18 Jan 2021 16:28:11 +0000
MIME-Version: 1.0
Date: Mon, 18 Jan 2021 16:28:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: Drop workaround for broken 'S' constraint with GCC
 4.9
In-Reply-To: <20210118162604.GB4483@gaia>
References: <20210118130129.2875949-1-maz@kernel.org>
 <20210118162604.GB4483@gaia>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <5e62b07d348a0210f82be5d101c3b109@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
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

On 2021-01-18 16:26, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 01:01:29PM +0000, Marc Zyngier wrote:
>> Since GCC < 5.1 has been shown to be unsuitable for the arm64 kernel,
>> let's drop the workaround for the 'S' asm constraint that GCC 4.9
>> doesn't always grok.
>> 
>> This is effectively a revert of 9fd339a45be5 ("arm64: Work around
>> broken GCC 4.9 handling of "S" constraint").
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> It looks like I merged this fix in -rc1. Do you want me to merge the
> revert as well or you'll handle it?

It'd make sense if it went via the arm64 tree as well.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
