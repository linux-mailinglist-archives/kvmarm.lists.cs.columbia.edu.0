Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9527D48C
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 19:34:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E88404B232;
	Tue, 29 Sep 2020 13:34:17 -0400 (EDT)
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
	with ESMTP id 4+GqYlyb5J6y; Tue, 29 Sep 2020 13:34:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2A724B21E;
	Tue, 29 Sep 2020 13:34:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8441E4B1B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 13:34:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSuzXQK287iB for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 13:34:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 972DB4B1B1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 13:34:14 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2BD42075F;
 Tue, 29 Sep 2020 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601400853;
 bh=j0fCGiLcbnkITaxQRT0Ke2lzkcknLm9OTwR/cvXL0XE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e/6aevJ8x5eLSFiTmIwukWzyhkAbSNY5IS3lu9gBeiCTqp3Deya4iQV85YYPrPNR+
 uITte911QYHvItarSn0LYoaR4TvndgCdpIsTrblTpxrHXZsFbZQLiQwAOS7SQqNv4m
 4wxmWcDhYBM7gDR4fQcBa4vnb8E/ha/kp8TvnAcQ=
Date: Tue, 29 Sep 2020 18:34:07 +0100
From: Will Deacon <will@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v4 05/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200929173407.GC14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-6-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-6-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, kernel-team@android.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, Sep 22, 2020 at 09:49:05PM +0100, David Brazdil wrote:
> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
> because they always needed to use TPIDR_EL2 for base, while
> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
> _EL1 based on VHE/nVHE.
> 
> Simplify this now that the hyp mode case can be handled using the
> __KVM_VHE/NVHE_HYPERVISOR__ macros.
> 
> Acked-by: Andrew Scull <ascull@google.com>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++----------
>  arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
>  arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
>  3 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 54d181177656..86e0ef79a799 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,6 +218,23 @@ lr	.req	x30		// link register
>  	str	\src, [\tmp, :lo12:\sym]
>  	.endm
>  
> +	/*
> +	 * @dst: destination register (32 or 64 bit wide)

nit: this comment is wrong as I don't think mrs can take a W register
as the destination argument. I'm assuming Marc can fix that up.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
