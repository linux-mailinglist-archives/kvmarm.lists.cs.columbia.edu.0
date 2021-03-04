Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5546132DA91
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 20:50:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 381C24B675;
	Thu,  4 Mar 2021 14:50:06 -0500 (EST)
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
	with ESMTP id 5-+mgZHO1Zeg; Thu,  4 Mar 2021 14:50:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15CC34B662;
	Thu,  4 Mar 2021 14:50:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43A5F4B3D2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:50:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VrHQFuX1R3MQ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 14:50:02 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 50DCB4B388
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:50:02 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1A1864EAE;
 Thu,  4 Mar 2021 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614887399;
 bh=rbJBnbip++59oMvemPv0UgOnN48fZ3mavVDtdREo3QA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZWQ7DETmHFsQA6lwmTnfoOa+Q9Irkf5q2C4UmWvL/JHQ1qcalcbNorvEw35hz+pFK
 8xBYECCDmudPwtzgrAmwgJM01RAx6E/LJrB2j63eeVfozezpMjmEejrdIhwI+mz06e
 qsFZL2Nj05tgwwnuoSr4OPQ5L/9dAWEu0qqofN63+Cm+yortNfPgFTx8VFc22FRZ7m
 KCHjHuhj3rMY3nnoJHdPABwMUgycCUR8/7oHbr9fLK7JwX5Ha5qPzrWEtyNZvLnj03
 tBTrUyvzjKvOqBWZzxTVyBfXPVc9km+IZFr70JkBQs5FvYSeXGeKq5Cwf/5Ar3MXBa
 fZNKsLB56KILg==
Date: Thu, 4 Mar 2021 19:49:53 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 24/32] KVM: arm64: Reserve memory for host stage 2
Message-ID: <20210304194953.GD21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-25-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-25-qperret@google.com>
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

On Tue, Mar 02, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
> Extend the memory pool allocated for the hypervisor to include enough
> pages to map all of memory at page granularity for the host stage 2.
> While at it, also reserve some memory for device mappings.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h | 23 ++++++++++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++++
>  arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index ac0f7fcffd08..411a35db949c 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -53,7 +53,7 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
>  	return total;
>  }
>  
> -static inline unsigned long hyp_s1_pgtable_pages(void)
> +static inline unsigned long __hyp_pgtable_total_pages(void)
>  {
>  	unsigned long res = 0, i;
>  
> @@ -63,9 +63,30 @@ static inline unsigned long hyp_s1_pgtable_pages(void)
>  		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
>  	}
>  
> +	return res;
> +}
> +
> +static inline unsigned long hyp_s1_pgtable_pages(void)
> +{
> +	unsigned long res;
> +
> +	res = __hyp_pgtable_total_pages();
> +
>  	/* Allow 1 GiB for private mappings */
>  	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
>  
>  	return res;
>  }
> +
> +static inline unsigned long host_s2_mem_pgtable_pages(void)
> +{
> +	return __hyp_pgtable_total_pages() + 16;

Is this 16 due to the possibility of a concatenated pgd? If so, please add
a comment to that effect.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
