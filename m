Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7F165F81
	for <lists+kvmarm@lfdr.de>; Thu, 20 Feb 2020 15:12:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0D794AF45;
	Thu, 20 Feb 2020 09:12:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsZICP7PUFy5; Thu, 20 Feb 2020 09:12:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BADA04AF34;
	Thu, 20 Feb 2020 09:12:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D9EFE4AEF0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 09:12:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EsfGjYC+gHog for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Feb 2020 09:12:48 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B92BB4AEE9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 09:12:48 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F74E31B;
 Thu, 20 Feb 2020 06:12:48 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAF363F6CF;
 Thu, 20 Feb 2020 06:12:47 -0800 (PST)
Date: Thu, 20 Feb 2020 14:12:44 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/5] KVM: arm64: Refactor filtering of ID registers
Message-ID: <20200220141244.353ec1d7@donnerap.cambridge.arm.com>
In-Reply-To: <20200216185324.32596-3-maz@kernel.org>
References: <20200216185324.32596-1-maz@kernel.org>
 <20200216185324.32596-3-maz@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

On Sun, 16 Feb 2020 18:53:21 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> Our current ID register filtering is starting to be a mess of if()
> statements, and isn't going to get any saner.
> 
> Let's turn it into a switch(), which has a chance of being more
> readable.

Indeed, much better now.

> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  arch/arm64/kvm/sys_regs.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index da82c4b03aab..682fedd7700f 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -9,6 +9,7 @@
>   *          Christoffer Dall <c.dall@virtualopensystems.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bsearch.h>
>  #include <linux/kvm_host.h>
>  #include <linux/mm.h>
> @@ -1070,6 +1071,8 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +#define FEATURE(x)	(GENMASK_ULL(x##_SHIFT + 3, x##_SHIFT))
> +
>  /* Read a sanitised cpufeature ID register by sys_reg_desc */
>  static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  		struct sys_reg_desc const *r, bool raz)
> @@ -1078,13 +1081,18 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
>  	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
>  
> -	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
> -		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> -	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
> -		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
> -			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> -			 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> -			 (0xfUL << ID_AA64ISAR1_GPI_SHIFT));
> +	switch (id) {
> +	case SYS_ID_AA64PFR0_EL1:
> +		if (!vcpu_has_sve(vcpu))
> +			val &= ~FEATURE(ID_AA64PFR0_SVE);
> +		break;
> +	case SYS_ID_AA64ISAR1_EL1:
> +		if (!vcpu_has_ptrauth(vcpu))
> +			val &= ~(FEATURE(ID_AA64ISAR1_APA) |
> +				 FEATURE(ID_AA64ISAR1_API) |
> +				 FEATURE(ID_AA64ISAR1_GPA) |
> +				 FEATURE(ID_AA64ISAR1_GPI));
> +		break;
>  	}
>  
>  	return val;

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
