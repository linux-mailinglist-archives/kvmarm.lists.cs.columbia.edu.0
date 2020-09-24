Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E827773A
	for <lists+kvmarm@lfdr.de>; Thu, 24 Sep 2020 18:52:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C2A334B184;
	Thu, 24 Sep 2020 12:52:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8Pw2FjTAKHQ; Thu, 24 Sep 2020 12:52:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AD89E4B156;
	Thu, 24 Sep 2020 12:52:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 312DA4B132
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 12:52:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KcKahNqdMinD for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Sep 2020 12:52:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 121F54B100
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 12:52:56 -0400 (EDT)
Received: from gaia (unknown [31.124.44.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ACECF21D20;
 Thu, 24 Sep 2020 16:52:53 +0000 (UTC)
Date: Thu, 24 Sep 2020 17:52:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
Message-ID: <20200924165250.GE28591@gaia>
References: <20200924134853.2696503-1-robh@kernel.org>
 <20200924134853.2696503-2-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924134853.2696503-2-robh@kernel.org>
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

On Thu, Sep 24, 2020 at 07:48:53AM -0600, Rob Herring wrote:
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
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I'll leave these patches to Will for 5.10.

Thanks.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
