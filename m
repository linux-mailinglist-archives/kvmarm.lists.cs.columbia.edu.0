Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BE1F62D7
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jun 2020 09:42:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 647424B1BA;
	Thu, 11 Jun 2020 03:42:45 -0400 (EDT)
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
	with ESMTP id k-6qd56t81D3; Thu, 11 Jun 2020 03:42:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C84154B1C3;
	Thu, 11 Jun 2020 03:42:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 48F3D4B1B0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 03:42:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51mt9SatgIy7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jun 2020 03:42:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 406034B196
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 03:42:38 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 293AD2072F;
 Thu, 11 Jun 2020 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591861357;
 bh=gKJMd5utUWukaitgLZGRza7ui70C0kpqMr9sxdjD8/c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KFqoZB/lJU4/f4epVDrDHxmP+O9tSVmWZ9vwm72Y2fn4eZGAMXQWihXl2JAI4FS72
 UqbCTonXJ0Ycg0aPDpTrq2bK/znskSWa72A+cKKnHvHHm+0q+A2Ze1gBPrDX5T95DW
 zyqKCImV0KfIgaDkJAgPptVndfnb+CFq3aZUfJQ8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jjHr9-0021J7-Lk; Thu, 11 Jun 2020 08:42:35 +0100
MIME-Version: 1.0
Date: Thu, 11 Jun 2020 08:42:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 14/21] KVM: Move x86's version of struct
 kvm_mmu_memory_cache to common code
In-Reply-To: <20200605213853.14959-15-sean.j.christopherson@intel.com>
References: <20200605213853.14959-1-sean.j.christopherson@intel.com>
 <20200605213853.14959-15-sean.j.christopherson@intel.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <f57fc7237ffba4f22042b42efb18d2e4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sean.j.christopherson@intel.com, paulus@ozlabs.org,
 borntraeger@de.ibm.com, frankja@linux.ibm.com, pbonzini@redhat.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com,
 vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, pfeiner@google.com,
 pshier@google.com, junaids@google.com, bgardon@google.com,
 christoffer.dall@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Ben Gardon <bgardon@google.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Janosch Frank <frankja@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Junaid Shahid <junaids@google.com>, kvm-ppc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Shier <pshier@google.com>,
 linux-mips@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Feiner <pfeiner@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Sean,

On 2020-06-05 22:38, Sean Christopherson wrote:
> Move x86's 'struct kvm_mmu_memory_cache' to common code in anticipation
> of moving the entire x86 implementation code to common KVM and reusing
> it for arm64 and MIPS.  Add a new architecture specific asm/kvm_types.h
> to control the existence and parameters of the struct.  The new header
> is needed to avoid a chicken-and-egg problem with asm/kvm_host.h as all
> architectures define instances of the struct in their vCPU structs.
> 
> Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/arm64/include/asm/kvm_types.h   |  6 ++++++
>  arch/mips/include/asm/kvm_types.h    |  5 +++++
>  arch/powerpc/include/asm/kvm_types.h |  5 +++++
>  arch/s390/include/asm/kvm_types.h    |  5 +++++
>  arch/x86/include/asm/kvm_host.h      | 13 -------------
>  arch/x86/include/asm/kvm_types.h     |  7 +++++++
>  include/linux/kvm_types.h            | 19 +++++++++++++++++++
>  7 files changed, 47 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_types.h
>  create mode 100644 arch/mips/include/asm/kvm_types.h
>  create mode 100644 arch/powerpc/include/asm/kvm_types.h
>  create mode 100644 arch/s390/include/asm/kvm_types.h
>  create mode 100644 arch/x86/include/asm/kvm_types.h
> 
> diff --git a/arch/arm64/include/asm/kvm_types.h
> b/arch/arm64/include/asm/kvm_types.h
> new file mode 100644
> index 000000000000..d0987007d581
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_types.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_KVM_TYPES_H
> +#define _ASM_ARM64_KVM_TYPES_H
> +
> +#endif /* _ASM_ARM64_KVM_TYPES_H */
> +
> diff --git a/arch/mips/include/asm/kvm_types.h
> b/arch/mips/include/asm/kvm_types.h
> new file mode 100644
> index 000000000000..5efeb32a5926
> --- /dev/null
> +++ b/arch/mips/include/asm/kvm_types.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_MIPS_KVM_TYPES_H
> +#define _ASM_MIPS_KVM_TYPES_H
> +
> +#endif /* _ASM_MIPS_KVM_TYPES_H */
> diff --git a/arch/powerpc/include/asm/kvm_types.h
> b/arch/powerpc/include/asm/kvm_types.h
> new file mode 100644
> index 000000000000..f627eceaa314
> --- /dev/null
> +++ b/arch/powerpc/include/asm/kvm_types.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_KVM_TYPES_H
> +#define _ASM_POWERPC_KVM_TYPES_H
> +
> +#endif /* _ASM_POWERPC_KVM_TYPES_H */
> diff --git a/arch/s390/include/asm/kvm_types.h
> b/arch/s390/include/asm/kvm_types.h
> new file mode 100644
> index 000000000000..b66a81f8a354
> --- /dev/null
> +++ b/arch/s390/include/asm/kvm_types.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_KVM_TYPES_H
> +#define _ASM_S390_KVM_TYPES_H
> +
> +#endif /* _ASM_S390_KVM_TYPES_H */

Instead of carrying an empty include file for at least two of the 
architectures
(s390 and Power), how about having it in asm-generic, and updating
arch/$ARCH/include/asm/Kbuild to point to the generic one?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
