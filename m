Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE93D7A55
	for <lists+kvmarm@lfdr.de>; Tue, 27 Jul 2021 17:59:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4330A4B089;
	Tue, 27 Jul 2021 11:59:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lIBZ+01xUmey; Tue, 27 Jul 2021 11:59:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0997C4A4E5;
	Tue, 27 Jul 2021 11:59:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 66B774A4E5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Jul 2021 11:59:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3wV8D4TVFGL for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Jul 2021 11:59:29 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4364C4A1B0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Jul 2021 11:59:29 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D938A31B;
 Tue, 27 Jul 2021 08:59:28 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A6A3F70D;
 Tue, 27 Jul 2021 08:59:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] KVM: arm64: Avoid mapping size adjustment on
 permission fault
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
References: <20210726153552.1535838-1-maz@kernel.org>
 <20210726153552.1535838-4-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <5216fbb0-1df2-325c-5e4d-98245c7470e6@arm.com>
Date: Tue, 27 Jul 2021 17:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726153552.1535838-4-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com, Sean Christopherson <seanjc@google.com>,
 Matthew Wilcox <willy@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

Hi Marc,

On 7/26/21 4:35 PM, Marc Zyngier wrote:
> Since we only support PMD-sized mappings for THP, getting
> a permission fault on a level that results in a mapping
> being larger than PAGE_SIZE is a sure indication that we have
> already upgraded our mapping to a PMD.
>
> In this case, there is no need to try and parse userspace page
> tables, as the fault information already tells us everything.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 0adc1617c557..ebb28dd4f2c9 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1076,9 +1076,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	 * If we are not forced to use page mapping, check if we are
>  	 * backed by a THP and thus use block mapping if possible.
>  	 */
> -	if (vma_pagesize == PAGE_SIZE && !(force_pte || device))
> -		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva,
> -							   &pfn, &fault_ipa);
> +	if (vma_pagesize == PAGE_SIZE && !(force_pte || device)) {
> +		if (fault_status == FSC_PERM && fault_granule > PAGE_SIZE)
> +			vma_pagesize = fault_granule;
> +		else
> +			vma_pagesize = transparent_hugepage_adjust(kvm, memslot,
> +								   hva, &pfn,
> +								   &fault_ipa);
> +	}

Looks good:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>  
>  	if (fault_status != FSC_PERM && !device && kvm_has_mte(kvm)) {
>  		/* Check the VMM hasn't introduced a new VM_SHARED VMA */
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
