Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 956B629E83C
	for <lists+kvmarm@lfdr.de>; Thu, 29 Oct 2020 11:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1672C4B4B4;
	Thu, 29 Oct 2020 06:05:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YsWP7UTlHTK; Thu, 29 Oct 2020 06:04:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C83E34B1FF;
	Thu, 29 Oct 2020 06:04:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F5084B1ED
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 06:04:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3IHXJjfssr8S for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Oct 2020 06:04:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B813E4B164
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 06:04:55 -0400 (EDT)
Received: from gaia (unknown [95.145.162.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A6342076E;
 Thu, 29 Oct 2020 10:04:52 +0000 (UTC)
Date: Thu, 29 Oct 2020 10:04:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/2] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
Message-ID: <20201029100450.GA10776@gaia>
References: <20201028182839.166037-1-robh@kernel.org>
 <20201028182839.166037-2-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028182839.166037-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Wed, Oct 28, 2020 at 01:28:39PM -0500, Rob Herring wrote:
> On Cortex-A77 r0p0 and r1p0, a sequence of a non-cacheable or device load
> and a store exclusive or PAR_EL1 read can cause a deadlock.
> 
> The workaround requires a DMB SY before and after a PAR_EL1 register
> read. In addition, it's possible an interrupt (doing a device read) or
> KVM guest exit could be taken between the DMB and PAR read, so we
> also need a DMB before returning from interrupt and before returning to
> a guest.
> 
> A deadlock is still possible with the workaround as KVM guests must also
> have the workaround. IOW, a malicious guest can deadlock an affected
> systems.
> 
> This workaround also depends on a firmware counterpart to enable the h/w
> to insert DMB SY after load and store exclusive instructions. See the
> errata document SDEN-1152370 v10 [1] for more information.
> 
> [1] https://static.docs.arm.com/101992/0010/Arm_Cortex_A77_MP074_Software_Developer_Errata_Notice_v10.pdf
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

I thought I reviewed the v6 already and that's just a rebase. Here it is
again:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
