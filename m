Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD438A610
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 12:23:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AF7A4B74F;
	Thu, 20 May 2021 06:23:16 -0400 (EDT)
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
	with ESMTP id XorPoefKCdWW; Thu, 20 May 2021 06:23:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DB8B4B70F;
	Thu, 20 May 2021 06:23:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 070DF4B6B7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 06:23:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 96B3gjvoXe0O for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 06:23:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D4F114B712
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 06:23:12 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1B6661074;
 Thu, 20 May 2021 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621506191;
 bh=2YKqGnbeqmRaMmYTVRZcjpfhdmGfiF6XZkVGxWDYqAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WOW96q1t50EutysvjFgjjl2wPym5EePWGB7q42GlOket+E52dnr7iEr0wpmdhFhGP
 ClA1IrrAhmgJLVKjD1hecTdNj3L+OvtlAaXFJGG3gLNyh06vs6EL3NUDWNI52PpozG
 SrB46nRfG9y0ZV+J+0n0tium96nsPsstIqJk4PtLWcW5LUolDFdNjFhkcsdpGKmHxW
 nPFT8LwzI94BoJBwbVwjPET00riJAvJSAIB8tiikX9qKaY03DNej2bi77Psx+ck0cH
 /1Nyz79k7WLiiKq+2gRtVxsqBxypYBwRpl1refUGwJi3WU4WCt2y4uRV1af9gak/N8
 G+ugYXMQEucxw==
Date: Thu, 20 May 2021 11:23:07 +0100
From: Will Deacon <will@kernel.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH] KVM: arm64: Fix typo in a comment
Message-ID: <20210520102307.GB10065@willie-the-truck>
References: <1621482089-11182-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1621482089-11182-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Thu, May 20, 2021 at 11:41:29AM +0800, Shaokun Zhang wrote:
> Fix typo 'kvm_pgtable_stage2_flush_range' -> 'kvm_pgtable_stage2_flush'
> 
> Cc: Quentin Perret <qperret@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index c3674c47d48c..25589cc71599 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -386,7 +386,7 @@ int kvm_pgtable_stage2_relax_perms(struct kvm_pgtable *pgt, u64 addr,
>  bool kvm_pgtable_stage2_is_young(struct kvm_pgtable *pgt, u64 addr);
>  
>  /**
> - * kvm_pgtable_stage2_flush_range() - Clean and invalidate data cache to Point
> + * kvm_pgtable_stage2_flush() - Clean and invalidate data cache to Point
>   * 				      of Coherency for guest stage-2 address
>   *				      range.
>   * @pgt:	Page-table structure initialised by kvm_pgtable_stage2_init*().

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
