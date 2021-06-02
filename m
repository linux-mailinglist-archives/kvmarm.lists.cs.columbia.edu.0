Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1A3987B1
	for <lists+kvmarm@lfdr.de>; Wed,  2 Jun 2021 13:08:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 68B5540162;
	Wed,  2 Jun 2021 07:08:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xv05BlWMkDvK; Wed,  2 Jun 2021 07:08:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35C7F49E8C;
	Wed,  2 Jun 2021 07:08:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F53A402DB
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 07:08:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqflPkCyfUuB for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Jun 2021 07:07:58 -0400 (EDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2AECD40162
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Jun 2021 07:07:58 -0400 (EDT)
Received: by mail-wr1-f46.google.com with SMTP id m18so1883588wrv.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Jun 2021 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QwU7eNpnhcnSNsCtdIpNIwPgvGDGJ4+rnF5GomWdPmY=;
 b=v1ylLqjAdoNf/H7w9k6hQe7WHAc3a2ZesvC3IRvLPZ1+tQRZac+5ne5v5FaCWj+y5C
 BxBVdNM5skbbGmZhDCRSWRz3Xt0A5h6zb4DZsNKbWib3299MD2oicnmoT1z9oz0cjrJ3
 8kR2BfFD3YvzWy5mEPYEPl1uy4R86YjGrT17a/Puup3fQvY8kdPiuiv5h2H48v/v6dA/
 3FCz/EIjFp6BEePGVBUNTN6mngT9AhytfCRfcCjE0KXsPUsm5AoALDbB/jCiNoTbie29
 OU2SyFWidQIIf65c44G8BW8zwbZe0H26U29sc2qkBI0unDdkQd9/SpRNhyyJzVXsPmI1
 qi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QwU7eNpnhcnSNsCtdIpNIwPgvGDGJ4+rnF5GomWdPmY=;
 b=OG+GPLRVxHyopdO/lMrAf8fg2ihlxaCdbTIH8qLqpyzkV0raTCnQf37CKRYC/TUQVt
 xcK88SBPgpHpNYoGNXiBmQ9N9s6VRRrojYRyj15jr76h9QOlL2OXIq/UHeT2ASIn4AYk
 h9XXsuePJSI60y5lYAkFN1UnfJ8ZwoLbUKMcbeX0LGMc4MVnzNev2hTZ9ZP0MW47Jzre
 po41UfXjhYjzf/ojzDoPhDjMVyp5mrBFZWvH83zWHPQmIqGx7Mfz4daoFpso8QENoIfx
 I37APitVFoXIQ4T4XWrH1NuX+rtzjaad09RF2VEEbxQOUJyRVuUjmSPYKsWr7cqpGk0Q
 HDGg==
X-Gm-Message-State: AOAM5310+97cdpP3q5eJkHAG20DlGMu9lnSmz/DrBI98rXM+MGIZDWnZ
 PetCKLZsriReYDlw63FMpOGj+w==
X-Google-Smtp-Source: ABdhPJyaYUKxfSrgwNdRYacXMtN7kPQKgVxIk8ZpqN9TTX1nHz6hbmS6x6ztsX9uQZdAVXxWRyaxEg==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr7244022wrt.209.1622632076964; 
 Wed, 02 Jun 2021 04:07:56 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com.
 [35.195.168.105])
 by smtp.gmail.com with ESMTPSA id z11sm6213182wrs.7.2021.06.02.04.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 04:07:56 -0700 (PDT)
Date: Wed, 2 Jun 2021 11:07:53 +0000
From: Quentin Perret <qperret@google.com>
To: Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 6/6] KVM: arm64: Distinguish cases of memcache
 allocations completely
Message-ID: <YLdmiTfgz1EqBsJd@google.com>
References: <20210415115032.35760-1-wangyanan55@huawei.com>
 <20210415115032.35760-7-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210415115032.35760-7-wangyanan55@huawei.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Thursday 15 Apr 2021 at 19:50:32 (+0800), Yanan Wang wrote:
> With a guest translation fault, the memcache pages are not needed if KVM
> is only about to install a new leaf entry into the existing page table.
> And with a guest permission fault, the memcache pages are also not needed
> for a write_fault in dirty-logging time if KVM is only about to update
> the existing leaf entry instead of collapsing a block entry into a table.
> 
> By comparing fault_granule and vma_pagesize, cases that require allocations
> from memcache and cases that don't can be distinguished completely.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/mmu.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index aa536392b308..9e35aa5d29f2 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -895,19 +895,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	gfn = fault_ipa >> PAGE_SHIFT;
>  	mmap_read_unlock(current->mm);
>  
> -	/*
> -	 * Permission faults just need to update the existing leaf entry,
> -	 * and so normally don't require allocations from the memcache. The
> -	 * only exception to this is when dirty logging is enabled at runtime
> -	 * and a write fault needs to collapse a block entry into a table.
> -	 */
> -	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
> -		ret = kvm_mmu_topup_memory_cache(memcache,
> -						 kvm_mmu_cache_min_pages(kvm));
> -		if (ret)
> -			return ret;
> -	}
> -
>  	mmu_seq = vcpu->kvm->mmu_notifier_seq;
>  	/*
>  	 * Ensure the read of mmu_notifier_seq happens before we call
> @@ -970,6 +957,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	else if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))
>  		prot |= KVM_PGTABLE_PROT_X;
>  
> +	/*
> +	 * Allocations from the memcache are required only when granule of the
> +	 * lookup level where the guest fault happened exceeds vma_pagesize,
> +	 * which means new page tables will be created in the fault handlers.
> +	 */
> +	if (fault_granule > vma_pagesize) {
> +		ret = kvm_mmu_topup_memory_cache(memcache,
> +						 kvm_mmu_cache_min_pages(kvm));
> +		if (ret)
> +			return ret;
> +	}

You're now doing the top-up in the kvm->mmu_lock critical section. Isn't
this more or less what we try to avoid by using a memory cache?

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
