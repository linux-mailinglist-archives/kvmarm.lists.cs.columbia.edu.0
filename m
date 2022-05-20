Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4572352EFC5
	for <lists+kvmarm@lfdr.de>; Fri, 20 May 2022 17:55:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 776034B380;
	Fri, 20 May 2022 11:55:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tL3vmndJrbK9; Fri, 20 May 2022 11:55:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FAF54B374;
	Fri, 20 May 2022 11:55:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB9A04B365
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 May 2022 11:55:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ksTI2w2TCgQM for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 May 2022 11:55:42 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AF21F4B20F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 May 2022 11:55:42 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7801480;
 Fri, 20 May 2022 08:55:41 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A884A3F73D;
 Fri, 20 May 2022 08:55:38 -0700 (PDT)
Date: Fri, 20 May 2022 16:55:51 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 03/89] KVM: arm64: Return error from kvm_arch_init_vm()
 on allocation failure
Message-ID: <Yoe6BxKzJPIaZ+pk@monolith.localdoman>
References: <20220519134204.5379-1-will@kernel.org>
 <20220519134204.5379-4-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519134204.5379-4-will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, kernel-team@android.com,
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

Hi,

On Thu, May 19, 2022 at 02:40:38PM +0100, Will Deacon wrote:
> If we fail to allocate the 'supported_cpus' cpumask in kvm_arch_init_vm()
> then be sure to return -ENOMEM instead of success (0) on the failure
> path.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kvm/arm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 523bc934fe2f..775b52871b51 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -146,8 +146,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	if (ret)
>  		goto out_free_stage2_pgd;
>  
> -	if (!zalloc_cpumask_var(&kvm->arch.supported_cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&kvm->arch.supported_cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
>  		goto out_free_stage2_pgd;
> +	}
>  	cpumask_copy(kvm->arch.supported_cpus, cpu_possible_mask);
>  
>  	kvm_vgic_early_init(kvm);

Thank you for the fix:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

This can go in independent of the series. I can send it after rc1 if you
prefer to focus on something else.

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
