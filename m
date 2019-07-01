Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EEA414E8FE
	for <lists+kvmarm@lfdr.de>; Fri, 21 Jun 2019 15:24:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E8064A4E9;
	Fri, 21 Jun 2019 09:24:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RTJclV0HIF2U; Fri, 21 Jun 2019 09:24:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A1874A4C0;
	Fri, 21 Jun 2019 09:24:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6CB04A47A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 09:24:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8SIHurE2euy for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Jun 2019 09:24:52 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 61B2B4A319
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Jun 2019 09:24:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA09344;
 Fri, 21 Jun 2019 06:24:52 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BF863F246;
 Fri, 21 Jun 2019 06:24:49 -0700 (PDT)
Subject: Re: [PATCH 06/59] KVM: arm64: nv: Allow userspace to set PSR_MODE_EL2x
To: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-7-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <7f8a9d76-6087-b8d9-3571-074a08d08ec8@arm.com>
Date: Fri, 21 Jun 2019 14:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190621093843.220980-7-marc.zyngier@arm.com>
Content-Language: en-US
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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



On 21/06/2019 10:37, Marc Zyngier wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> We were not allowing userspace to set a more privileged mode for the VCPU
> than EL1, but we should allow this when nested virtualization is enabled
> for the VCPU.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kvm/guest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 3ae2f82fca46..4c35b5d51e21 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -37,6 +37,7 @@
>  #include <asm/kvm_emulate.h>
>  #include <asm/kvm_coproc.h>
>  #include <asm/kvm_host.h>
> +#include <asm/kvm_nested.h>
>  #include <asm/sigcontext.h>
>  
>  #include "trace.h"
> @@ -194,6 +195,11 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  			if (vcpu_el1_is_32bit(vcpu))
>  				return -EINVAL;
>  			break;
> +		case PSR_MODE_EL2h:
> +		case PSR_MODE_EL2t:
> +			if (vcpu_el1_is_32bit(vcpu) || !nested_virt_in_use(vcpu))

This condition reads a bit weirdly. Why do we care about anything else
than !nested_virt_in_use() ?

If nested virt is not in use then obviously we return the error.

If nested virt is in use then why do we care about EL1? Or should this
test read as "highest_el_is_32bit" ?

Thanks,

-- 
Julien Thierry
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
