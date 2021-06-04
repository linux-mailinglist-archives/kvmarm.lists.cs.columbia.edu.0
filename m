Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 992E039BA6D
	for <lists+kvmarm@lfdr.de>; Fri,  4 Jun 2021 16:01:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F7294B0DA;
	Fri,  4 Jun 2021 10:01:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RLauoYnEJn89; Fri,  4 Jun 2021 10:01:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9FECB4B0D8;
	Fri,  4 Jun 2021 10:01:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B5DC4B0D8
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:01:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMMY-8I9HUnM for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Jun 2021 10:01:28 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB2B54B09E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 10:01:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706D82B;
 Fri,  4 Jun 2021 07:01:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.6.137])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27BBE3F774;
 Fri,  4 Jun 2021 07:01:24 -0700 (PDT)
Date: Fri, 4 Jun 2021 15:01:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/4] KVM: arm64: Ignore 'kvm-arm.mode=protected' when
 using VHE
Message-ID: <20210604140117.GA69333@C02TD0UTHF1T.local>
References: <20210603183347.1695-1-will@kernel.org>
 <20210603183347.1695-2-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603183347.1695-2-will@kernel.org>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Thu, Jun 03, 2021 at 07:33:44PM +0100, Will Deacon wrote:
> Ignore 'kvm-arm.mode=protected' when using VHE so that kvm_get_mode()
> only returns KVM_MODE_PROTECTED on systems where the feature is available.

IIUC, since the introduction of the idreg-override code, and the
mutate_to_vhe stuff, passing 'kvm-arm.mode=protected' should make the
kernel stick to EL1, right? So this should only affect M1 (or other HW
with a similar impediment).

One minor comment below; otherwise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> 
> Cc: David Brazdil <dbrazdil@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  1 -
>  arch/arm64/kernel/cpufeature.c                  | 10 +---------
>  arch/arm64/kvm/arm.c                            |  6 +++++-
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..e85dbdf1ee8e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2300,7 +2300,6 @@
>  
>  			protected: nVHE-based mode with support for guests whose
>  				   state is kept private from the host.
> -				   Not valid if the kernel is running in EL2.
>  
>  			Defaults to VHE/nVHE based on hardware support.
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index efed2830d141..dc1f2e747828 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1773,15 +1773,7 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  #ifdef CONFIG_KVM
>  static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, int __unused)
>  {
> -	if (kvm_get_mode() != KVM_MODE_PROTECTED)
> -		return false;
> -
> -	if (is_kernel_in_hyp_mode()) {
> -		pr_warn("Protected KVM not available with VHE\n");
> -		return false;
> -	}
> -
> -	return true;
> +	return kvm_get_mode() == KVM_MODE_PROTECTED;
>  }
>  #endif /* CONFIG_KVM */
>  
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 1cb39c0803a4..8d5e23198dfd 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2121,7 +2121,11 @@ static int __init early_kvm_mode_cfg(char *arg)
>  		return -EINVAL;
>  
>  	if (strcmp(arg, "protected") == 0) {
> -		kvm_mode = KVM_MODE_PROTECTED;
> +		if (!is_kernel_in_hyp_mode())
> +			kvm_mode = KVM_MODE_PROTECTED;
> +		else
> +			pr_warn_once("Protected KVM not available with VHE\n");

... assuming this is only for M1, it might be better to say:

	Protected KVM not available on this hardware

... since that doesn't suggest that other VHE-capable HW is also not
PKVM-capable.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
