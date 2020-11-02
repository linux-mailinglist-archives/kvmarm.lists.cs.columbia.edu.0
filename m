Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF12A2B7D
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 14:29:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF9564B4A9;
	Mon,  2 Nov 2020 08:29:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GeiEM4aDTlxM; Mon,  2 Nov 2020 08:29:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F6C64B4B5;
	Mon,  2 Nov 2020 08:29:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D1FE4B482
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 08:29:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mh3vl0tgEzRi for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 08:29:08 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF9A54B34F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 08:29:08 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66E8030E;
 Mon,  2 Nov 2020 05:29:08 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3973F66E;
 Mon,  2 Nov 2020 05:29:07 -0800 (PST)
Subject: Re: [PATCH 2/8] KVM: arm64: Remove leftover kern_hyp_va() in nVHE TLB
 invalidation
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20201026095116.72051-1-maz@kernel.org>
 <20201026095116.72051-3-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <4ba97fdf-3b62-a414-2f34-ee7c3fe22808@arm.com>
Date: Mon, 2 Nov 2020 13:30:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201026095116.72051-3-maz@kernel.org>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com
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

On 10/26/20 9:51 AM, Marc Zyngier wrote:
> The new calling convention says that pointers coming from the SMCCC
> interface are turned into their HYP version in the host HVC handler.
> However, there is still a stray kern_hyp_va() in the TLB invalidation
> code, which could result in a corrupted pointer.
>
> Drop the spurious conversion.
>
> Fixes: a071261d9318 ("KVM: arm64: nVHE: Fix pointers during SMCCC convertion")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/tlb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
> index 39ca71ab8866..fbde89a2c6e8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/tlb.c
> +++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
> @@ -128,7 +128,6 @@ void __kvm_tlb_flush_local_vmid(struct kvm_s2_mmu *mmu)
>  	struct tlb_inv_context cxt;
>  
>  	/* Switch to requested VMID */
> -	mmu = kern_hyp_va(mmu);
>  	__tlb_switch_to_guest(mmu, &cxt);
>  
>  	__tlbi(vmalle1);

Looks fine to me, the function handle_host_hcall() already does the required
transformation when handling the __kvm_tlb_flush_local_vmid function id:

case KVM_HOST_SMCCC_FUNC(__kvm_tlb_flush_local_vmid): { unsigned long r1 =
host_ctxt->regs.regs[1]; struct kvm_s2_mmu *mmu = (struct kvm_s2_mmu *)r1;
__kvm_tlb_flush_local_vmid(kern_hyp_va(mmu)); break; }

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
