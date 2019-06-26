Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A3561B6
	for <lists+kvmarm@lfdr.de>; Wed, 26 Jun 2019 07:31:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 93A294A4FC;
	Wed, 26 Jun 2019 01:31:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s00BOdAEl0gZ; Wed, 26 Jun 2019 01:31:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 394C54A50C;
	Wed, 26 Jun 2019 01:31:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 09BAD4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jun 2019 01:31:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RRHlAbpYh8kB for <kvmarm@lists.cs.columbia.edu>;
 Wed, 26 Jun 2019 01:31:15 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 168A54A4BE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 26 Jun 2019 01:31:15 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F592B;
 Tue, 25 Jun 2019 22:31:14 -0700 (PDT)
Received: from [10.37.8.13] (unknown [10.37.8.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5A33F246;
 Tue, 25 Jun 2019 22:33:01 -0700 (PDT)
Subject: Re: [PATCH 26/59] KVM: arm64: nv: Respect the virtual HCR_EL2.NV bit
 setting
To: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
References: <20190621093843.220980-1-marc.zyngier@arm.com>
 <20190621093843.220980-27-marc.zyngier@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <8ad1b436-9325-2abb-648d-2cd3a3c9b113@arm.com>
Date: Wed, 26 Jun 2019 06:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190621093843.220980-27-marc.zyngier@arm.com>
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



On 06/21/2019 10:38 AM, Marc Zyngier wrote:
> From: Jintack Lim <jintack.lim@linaro.org>
> 
> Forward traps due to HCR_EL2.NV bit to the virtual EL2 if they are not
> coming from the virtual EL2 and the virtual HCR_EL2.NV bit is set.
> 
> In addition to EL2 register accesses, setting NV bit will also make EL12
> register accesses trap to EL2. To emulate this for the virtual EL2,
> forword traps due to EL12 register accessses to the virtual EL2 if the
> virtual HCR_EL2.NV bit is set.
> 
> This is for recursive nested virtualization.
> 
> Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
> [Moved code to emulate-nested.c]
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h    |  1 +
>  arch/arm64/include/asm/kvm_nested.h |  2 ++
>  arch/arm64/kvm/emulate-nested.c     | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kvm/handle_exit.c        |  6 ++++++
>  arch/arm64/kvm/sys_regs.c           | 18 ++++++++++++++++++
>  5 files changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 48e15af2bece..d21486274eeb 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -24,6 +24,7 @@
>  
>  /* Hyp Configuration Register (HCR) bits */
>  #define HCR_FWB		(UL(1) << 46)
> +#define HCR_NV		(UL(1) << 42)
>  #define HCR_API		(UL(1) << 41)
>  #define HCR_APK		(UL(1) << 40)
>  #define HCR_TEA		(UL(1) << 37)
> diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
> index 645e5e11b749..61e71d0d2151 100644
> --- a/arch/arm64/include/asm/kvm_nested.h
> +++ b/arch/arm64/include/asm/kvm_nested.h
> @@ -11,5 +11,7 @@ static inline bool nested_virt_in_use(const struct kvm_vcpu *vcpu)
>  }
>  
>  int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
> +extern bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit);
> +extern bool forward_nv_traps(struct kvm_vcpu *vcpu);
>  
>  #endif /* __ARM64_KVM_NESTED_H */
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index f829b8b04dc8..c406fd688b9f 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -24,6 +24,27 @@
>  
>  #include "trace.h"
>  
> +bool forward_traps(struct kvm_vcpu *vcpu, u64 control_bit)

Should this one be static?

> +{
> +	bool control_bit_set;
> +
> +	if (!nested_virt_in_use(vcpu))
> +		return false;
> +
> +	control_bit_set = __vcpu_sys_reg(vcpu, HCR_EL2) & control_bit;
> +	if (!vcpu_mode_el2(vcpu) && control_bit_set) {
> +		kvm_inject_nested_sync(vcpu, kvm_vcpu_get_hsr(vcpu));
> +		return true;
> +	}
> +	return false;
> +}
> +
> +bool forward_nv_traps(struct kvm_vcpu *vcpu)
> +{
> +	return forward_traps(vcpu, HCR_NV);
> +}
> +
> +
>  /* This is borrowed from get_except_vector in inject_fault.c */
>  static u64 get_el2_except_vector(struct kvm_vcpu *vcpu,
>  		enum exception_type type)
> @@ -55,6 +76,13 @@ void kvm_emulate_nested_eret(struct kvm_vcpu *vcpu)
>  	u64 spsr, elr, mode;
>  	bool direct_eret;
>  
> +	/*
> +	 * Forward this trap to the virtual EL2 if the virtual
> +	 * HCR_EL2.NV bit is set and this is coming from !EL2.
> +	 */
> +	if (forward_nv_traps(vcpu))
> +		return;
> +
>  	/*
>  	 * Going through the whole put/load motions is a waste of time
>  	 * if this is a VHE guest hypervisor returning to its own
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 39602a4c1d61..7e8b1ec1d251 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -72,6 +72,12 @@ static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
>  	int ret;
>  
> +	/*
> +	 * Forward this trapped smc instruction to the virtual EL2.
> +	 */
> +	if ((vcpu_read_sys_reg(vcpu, HCR_EL2) & HCR_TSC) && forward_nv_traps(vcpu))

Not sure I understand why this would be only when the guest hyp also has
NV set.

If the guest hyp requested to trap smc instructions and that we received
one while in vel1, shouldn't we always forward it to the guest hyp to
let it implement the smc response the way it wants?

Cheers,

Julien
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
