Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF66C263003
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 16:52:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77CCD4B5CA;
	Wed,  9 Sep 2020 10:52:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zYtsLwlk4Pgv; Wed,  9 Sep 2020 10:52:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 578A84B5C7;
	Wed,  9 Sep 2020 10:52:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1792B4B583
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 10:52:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w+jdjcf1ATew for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Sep 2020 10:52:22 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCCFF4B581
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 10:52:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F3B101E;
 Wed,  9 Sep 2020 07:52:22 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30CDF3F66E;
 Wed,  9 Sep 2020 07:52:21 -0700 (PDT)
Subject: Re: [PATCH v4 21/21] KVM: arm64: Don't constrain maximum IPA size
 based on host configuration
To: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200907152344.12978-1-will@kernel.org>
 <20200907152344.12978-22-will@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <05da664a-7abf-ce13-1201-61b86368933e@arm.com>
Date: Wed, 9 Sep 2020 15:53:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907152344.12978-22-will@kernel.org>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

Hi Will,

On 9/7/20 4:23 PM, Will Deacon wrote:
> Now that the guest stage-2 page-tables are managed independently from
> the host stage-1 page-tables, we can avoid constraining the IPA size
> based on the host and instead limit it only based on the PARange field
> of the ID_AA64MMFR0 register.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/reset.c | 38 +++++---------------------------------
>  1 file changed, 5 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index ee33875c5c2a..471ee9234e40 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -339,7 +339,7 @@ u32 get_kvm_ipa_limit(void)
>  
>  int kvm_set_ipa_limit(void)
>  {
> -	unsigned int ipa_max, pa_max, va_max, parange, tgran_2;
> +	unsigned int parange, tgran_2;
>  	u64 mmfr0;
>  
>  	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> @@ -376,38 +376,10 @@ int kvm_set_ipa_limit(void)
>  		break;
>  	}
>  
> -	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
> -
> -	/* Clamp the IPA limit to the PA size supported by the kernel */
> -	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
> -	/*
> -	 * Since our stage2 table is dependent on the stage1 page table code,
> -	 * we must always honor the following condition:
> -	 *
> -	 *  Number of levels in Stage1 >= Number of levels in Stage2.
> -	 *
> -	 * So clamp the ipa limit further down to limit the number of levels.
> -	 * Since we can concatenate upto 16 tables at entry level, we could
> -	 * go upto 4bits above the maximum VA addressable with the current
> -	 * number of levels.
> -	 */
> -	va_max = PGDIR_SHIFT + PAGE_SHIFT - 3;
> -	va_max += 4;
> -
> -	if (va_max < ipa_max)
> -		ipa_max = va_max;
> -
> -	/*
> -	 * If the final limit is lower than the real physical address
> -	 * limit of the CPUs, report the reason.
> -	 */
> -	if (ipa_max < pa_max)
> -		pr_info("kvm: Limiting the IPA size due to kernel %s Address limit\n",
> -			(va_max < pa_max) ? "Virtual" : "Physical");
> -
> -	WARN(ipa_max < KVM_PHYS_SHIFT,
> -	     "KVM IPA limit (%d bit) is smaller than default size\n", ipa_max);
> -	kvm_ipa_limit = ipa_max;
> +	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
> +	WARN(kvm_ipa_limit < KVM_PHYS_SHIFT,
> +	     "KVM IPA limit (%d bit) is smaller than default size\n",
> +	     kvm_ipa_limit);
>  	kvm_info("IPA Size Limit: %dbits\n", kvm_ipa_limit);

Bikeshedding: the two messages are slightly inconsistent: "IPA limit" vs "IPA Size
Limit" and "%d bit" vs "%dbits. Might be worth using the exact wording to make it
painfully obvious that the messages refer to the same variable, kvm_ipa_limit.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
