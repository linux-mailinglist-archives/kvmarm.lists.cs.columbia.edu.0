Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AF238296DAE
	for <lists+kvmarm@lfdr.de>; Fri, 23 Oct 2020 13:29:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 20F134B899;
	Fri, 23 Oct 2020 07:29:35 -0400 (EDT)
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
	with ESMTP id YTTDM9DED+2i; Fri, 23 Oct 2020 07:29:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C36BA4B88E;
	Fri, 23 Oct 2020 07:29:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E15D4B643
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Oct 2020 07:29:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVGghMbWmt+U for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Oct 2020 07:29:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 00DE34B63F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Oct 2020 07:29:31 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2F46208B3;
 Fri, 23 Oct 2020 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603452570;
 bh=bQCvdwuGEkGFz0WHYf1HXg6LejBaqMQdjfFY6Wki64E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=0hRdmcfm0Aburvhe2bvLDQDOYFyL/GecR5rClT+Z+KeG2BA+xrPldyzm1iGGd7y5S
 otZJPzOKD7uVPrvknIfvyTlqNIpyxLh+d49O3E4Ta9e3LKneymhwxrRoUJOMB3aGXG
 2n7L5C7G5CHD4p7dLX8+zh1mEbghPrEdBYe345jk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kVvGC-003YWJ-K8; Fri, 23 Oct 2020 12:29:28 +0100
MIME-Version: 1.0
Date: Fri, 23 Oct 2020 12:29:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: Santosh Shukla <sashukla@nvidia.com>
Subject: Re: [PATCH] KVM: arm64: Correctly handle the mmio faulting
In-Reply-To: <1603297010-18787-1-git-send-email-sashukla@nvidia.com>
References: <1603297010-18787-1-git-send-email-sashukla@nvidia.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0a239ac4481fa01c8d09cf2e56dfdabe@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sashukla@nvidia.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, cjia@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: cjia@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

Hi Santosh,

Thanks for this.

On 2020-10-21 17:16, Santosh Shukla wrote:
> The Commit:6d674e28 introduces a notion to detect and handle the
> device mapping. The commit checks for the VM_PFNMAP flag is set
> in vma->flags and if set then marks force_pte to true such that
> if force_pte is true then ignore the THP function check
> (/transparent_hugepage_adjust()).
> 
> There could be an issue with the VM_PFNMAP flag setting and checking.
> For example consider a case where the mdev vendor driver register's
> the vma_fault handler named vma_mmio_fault(), which maps the
> host MMIO region in-turn calls remap_pfn_range() and maps
> the MMIO's vma space. Where, remap_pfn_range implicitly sets
> the VM_PFNMAP flag into vma->flags.
> 
> Now lets assume a mmio fault handing flow where guest first access
> the MMIO region whose 2nd stage translation is not present.
> So that results to arm64-kvm hypervisor executing guest abort handler,
> like below:
> 
> kvm_handle_guest_abort() -->
>  user_mem_abort()--> {
> 
>     ...
>     0. checks the vma->flags for the VM_PFNMAP.
>     1. Since VM_PFNMAP flag is not yet set so force_pte _is_ false;
>     2. gfn_to_pfn_prot() -->
>         __gfn_to_pfn_memslot() -->
>             fixup_user_fault() -->
>                 handle_mm_fault()-->
>                     __do_fault() -->
>                        vma_mmio_fault() --> // vendor's mdev fault 
> handler
>                         remap_pfn_range()--> // Here sets the VM_PFNMAP
> 						flag into vma->flags.
>     3. Now that force_pte is set to false in step-2),
>        will execute transparent_hugepage_adjust() func and
>        that lead to Oops [4].
>  }

Hmmm. Nice. Any chance you could provide us with an actual reproducer?

> 
> The proposition is to check is_iomap flag before executing the THP
> function transparent_hugepage_adjust().
> 
> [4] THP Oops:
>> pc: kvm_is_transparent_hugepage+0x18/0xb0
>> ...
>> ...
>> user_mem_abort+0x340/0x9b8
>> kvm_handle_guest_abort+0x248/0x468
>> handle_exit+0x150/0x1b0
>> kvm_arch_vcpu_ioctl_run+0x4d4/0x778
>> kvm_vcpu_ioctl+0x3c0/0x858
>> ksys_ioctl+0x84/0xb8
>> __arm64_sys_ioctl+0x28/0x38
> 
> Tested on Huawei Kunpeng Taishan-200 arm64 server, Using VFIO-mdev 
> device.
> Linux tip: 583090b1
> 
> Fixes: 6d674e28 ("KVM: arm/arm64: Properly handle faulting of device 
> mappings")
> Signed-off-by: Santosh Shukla <sashukla@nvidia.com>
> ---
>  arch/arm64/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3d26b47..ff15357 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1947,7 +1947,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
> phys_addr_t fault_ipa,
>  	 * If we are not forced to use page mapping, check if we are
>  	 * backed by a THP and thus use block mapping if possible.
>  	 */
> -	if (vma_pagesize == PAGE_SIZE && !force_pte)
> +	if (vma_pagesize == PAGE_SIZE && !force_pte && !is_iomap(flags))
>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>  							   &pfn, &fault_ipa);
>  	if (writable)

Why don't you directly set force_pte to true at the point where we 
update
the flags? It certainly would be a bit more readable:

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 3d26b47a1343..7a4ad984d54e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1920,6 +1920,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, 
phys_addr_t fault_ipa,
  	if (kvm_is_device_pfn(pfn)) {
  		mem_type = PAGE_S2_DEVICE;
  		flags |= KVM_S2PTE_FLAG_IS_IOMAP;
+		force_pte = true;
  	} else if (logging_active) {
  		/*
  		 * Faults on pages in a memslot with logging enabled

and almost directly applies to what we have queued for 5.10.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
