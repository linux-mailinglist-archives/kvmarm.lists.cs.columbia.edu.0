Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 62732346621
	for <lists+kvmarm@lfdr.de>; Tue, 23 Mar 2021 18:18:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E53064B405;
	Tue, 23 Mar 2021 13:18:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9TPu1KBjiBI; Tue, 23 Mar 2021 13:18:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B52304B39D;
	Tue, 23 Mar 2021 13:18:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60FDF4B37C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Mar 2021 13:17:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fxv6kWM9zdF5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Mar 2021 13:17:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4A9DE4B30C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Mar 2021 13:17:58 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6554C619C0;
 Tue, 23 Mar 2021 17:17:56 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lOkfC-003M1B-94; Tue, 23 Mar 2021 17:17:54 +0000
Date: Tue, 23 Mar 2021 17:17:53 +0000
Message-ID: <87r1k5kcvy.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Yoan Picchi <yoan.picchi@arm.com>
Subject: Re: [PATCH 3/7] KVM: arm64: Add cached_page_invalidated counter for
 kvm_stat
In-Reply-To: <20210319161711.24972-4-yoan.picchi@arm.com>
References: <20210319161711.24972-1-yoan.picchi@arm.com>
 <20210319161711.24972-4-yoan.picchi@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yoan.picchi@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 catalin.marinas@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, 19 Mar 2021 16:17:07 +0000,
Yoan Picchi <yoan.picchi@arm.com> wrote:
> 
> Add some counter for when a dpage get invalidated. The counter isn't
> in the function that actually do it though because it doesn't have
> either a kvm or vcpu argument, so we would have no way to access the
> counters. For this reason, the counter have been added to the calling
> functions instead.
> 
> Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  arch/arm64/kvm/guest.c            | 1 +
>  arch/arm64/kvm/mmu.c              | 5 ++++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 863603285..3609aa89d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -547,6 +547,7 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
>  
>  struct kvm_vm_stat {
>  	ulong remote_tlb_flush;
> +	ulong cached_page_invalidated;
>  };
>  
>  struct kvm_vcpu_stat {
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 1029976ca..f6b1f0b63 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -41,6 +41,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	VCPU_STAT("regular_page_mapped", regular_page_mapped),
>  	VCPU_STAT("huge_page_mapped", huge_page_mapped),
>  	VM_STAT("remote_tlb_flush", remote_tlb_flush),
> +	VM_STAT("cached_page_invalidated", cached_page_invalidated),
>  	VCPU_STAT("exits", exits),
>  	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
>  	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 55d7fe63b..d6ddf5ab8 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -893,8 +893,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (writable)
>  		prot |= KVM_PGTABLE_PROT_W;
>  
> -	if (fault_status != FSC_PERM && !device)
> +	if (fault_status != FSC_PERM && !device) {
>  		clean_dcache_guest_page(pfn, vma_pagesize);
> +		kvm->stat.cached_page_invalidated++;
> +	}
>  
>  	if (exec_fault) {
>  		prot |= KVM_PGTABLE_PROT_X;
> @@ -1166,6 +1168,7 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
>  	 * just like a translation fault and clean the cache to the PoC.
>  	 */
>  	clean_dcache_guest_page(pfn, PAGE_SIZE);
> +	kvm->stat.cached_page_invalidated++;
>  	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pfn);
>  	return 0;
>  }

Given that PoC flushing is only done on translation fault, what are
the odds that this would report a different number than that of
translation faults (assuming it was actually implemented)?

It is also interesting that you attribute the same cost to flushing a
4kB page or a 1GB block. And what does this mean when either FWB or
IDC are available?

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
