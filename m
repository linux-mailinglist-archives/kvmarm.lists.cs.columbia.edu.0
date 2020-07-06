Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 96990215D00
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jul 2020 19:24:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D8004B3DF;
	Mon,  6 Jul 2020 13:24:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id atDlwXDV52Nn; Mon,  6 Jul 2020 13:24:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6EA94B3D1;
	Mon,  6 Jul 2020 13:24:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D13C4B3AE
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 13:24:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kPLerSWpsOrx for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jul 2020 13:24:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 37A194B3A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 13:24:12 -0400 (EDT)
Received: from gaia (unknown [95.146.230.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BA2A2070C;
 Mon,  6 Jul 2020 17:24:08 +0000 (UTC)
Date: Mon, 6 Jul 2020 18:24:06 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 02/17] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200706172405.GI28170@gaia>
References: <20200706125425.1671020-1-maz@kernel.org>
 <20200706125425.1671020-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706125425.1671020-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
 Will Deacon <will@kernel.org>, George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 06, 2020 at 01:54:10PM +0100, Marc Zyngier wrote:
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.
> 
> Let's detect the feature for now. Further patches will implement
> its actual usage.
> 
> Reviewed-by : Suzuki K Polose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It looks like I had a reviewed-by in the other series [1]. Feel free to
add it here as well:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

[1] https://lore.kernel.org/linux-arm-kernel/20200625080314.230-1-yezhenyu2@huawei.com/
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
