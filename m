Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6093B3440B7
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 13:19:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D73BB4B3B0;
	Mon, 22 Mar 2021 08:19:44 -0400 (EDT)
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
	with ESMTP id 7Tti-Cdnse1i; Mon, 22 Mar 2021 08:19:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96DD34B37C;
	Mon, 22 Mar 2021 08:19:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BA6114B32E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 08:19:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNFIRGm6byrK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 08:19:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B12EF4B2B6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 08:19:41 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA2561931;
 Mon, 22 Mar 2021 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616415580;
 bh=zxvtl3PRlnpYihKBjGGbYEnphB4RPLOnR1v6ZTzVfpw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VfH7sTai0KRWXoYiOFlksoJNw2XBUTqCsY5sDJ57R/rIs8d8BzPDnd1zjO+7LhXfy
 xEr4VQVWnMUbPpwjhlNewaBCrJzcJtRCjVn7QxsW8c0SHdelUCqgJaN6wcwXV42ZGm
 PE0VViNDkQIL5F+jt3Uqz+8ifWlxrGPA0BIX+wNS9P8OBZaipqo2zu+uCh1Iijbkn0
 CqYlZFhG4HVQormI3akb+jctDHE5rWt7+pQtPDj41pVNDgnZH4RqnGtljpkwFxvyU8
 6WBAKVnmHYuBAlecMcHswKfQzTCtYNTt2JuMGIFUc9orDb5ZWXOr32lj0t1HfVxf2n
 q2Obv5gOY9Gzg==
Date: Mon, 22 Mar 2021 12:19:34 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v6 32/38] KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB
 stage 2 flag
Message-ID: <20210322121934.GE10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-33-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-33-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Fri, Mar 19, 2021 at 10:01:40AM +0000, Quentin Perret wrote:
> In order to further configure stage 2 page-tables, pass flags to the
> init function using a new enum.
> 
> The first of these flags allows to disable FWB even if the hardware
> supports it as we will need to do so for the host stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h  | 43 +++++++++++++-------
>  arch/arm64/include/asm/pgtable-prot.h |  4 +-
>  arch/arm64/kvm/hyp/pgtable.c          | 56 +++++++++++++++------------
>  3 files changed, 62 insertions(+), 41 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 9a65fb528110..079f4e9a3e84 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -71,10 +71,10 @@ extern bool arm64_use_ng_mappings;
>  #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
>  #define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
>  
> -#define PAGE_S2_MEMATTR(attr)						\
> +#define PAGE_S2_MEMATTR(attr, has_fwb)					\
>  	({								\
>  		u64 __val;						\
> -		if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))		\
> +		if (has_fwb)						\
>  			__val = PTE_S2_MEMATTR(MT_S2_FWB_ ## attr);	\
>  		else							\
>  			__val = PTE_S2_MEMATTR(MT_S2_ ## attr);		\

Given that this isn't used outside of pgtable.c, I wonder if we should move
it in there, as it's a pretty low-level thing to do now that it takes the
'has_fwb' parameter.

But regardless,

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
