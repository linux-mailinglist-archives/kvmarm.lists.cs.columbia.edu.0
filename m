Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E02323E5BAA
	for <lists+kvmarm@lfdr.de>; Tue, 10 Aug 2021 15:31:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BFB74AC78;
	Tue, 10 Aug 2021 09:31:20 -0400 (EDT)
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
	with ESMTP id rjHS005gsg0j; Tue, 10 Aug 2021 09:31:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A87D84A524;
	Tue, 10 Aug 2021 09:31:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F0764A003
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 09:31:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynStNqb+iCfj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Aug 2021 09:31:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A3C7F407A0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Aug 2021 09:31:09 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA4B601FA;
 Tue, 10 Aug 2021 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628602268;
 bh=9g4KB3k94i74QQB7YFvE+KdRAouTAqYyabRWaS73qHo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sNbpVUkI4h4ekQjr8OZvCUrNa439HxRQDf1YrgH0BSrOMTQh167nBFQEttr0HQNWa
 l6ActKSc2gtRf4JUjjMaNt7sYRIJuboAN4kbL+T2RF9fwpZygNsxiHE8oPTaGQn1IE
 SN8DtbNtGEAsBRhS+Zge5jTT4vLbgqDLhiZYYnmHUql8TFfz5pYnL7DUMPXZ7KoBjt
 5I2ujVcAuFUNComKlstjLlrqHcjwdeOIMro/WBQVrAS9LbjWKWmqRuoF8ORGPr+h3n
 iJpfbsH/11gPiFt+dqvklsTM0JKT0uP6U7O96Y4TzakkIeM5/t1SutIiTT1d2EXOwS
 Lx75xYrfpy5eQ==
Date: Tue, 10 Aug 2021 14:31:01 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64/perf: Replace '0xf' instances with
 ID_AA64DFR0_PMUVER_IMP_DEF
Message-ID: <20210810133101.GD2946@willie-the-truck>
References: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, Aug 10, 2021 at 10:36:38AM +0530, Anshuman Khandual wrote:
> ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
> actually gets used although there are '0xf' instances scattered all around.
> Just do the macro replacement to improve readability.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.14-rc5
> 
>  arch/arm64/include/asm/cpufeature.h | 2 +-
>  arch/arm64/kernel/perf_event.c      | 2 +-
>  arch/arm64/kvm/perf.c               | 2 +-
>  arch/arm64/kvm/pmu-emul.c           | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

Please can you split this with the KVM parts in their own patch?

Thanks,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
