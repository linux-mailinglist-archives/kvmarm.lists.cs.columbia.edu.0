Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A938114FE8
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:43:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E136E4AF48;
	Fri,  6 Dec 2019 06:43:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZp6aeEFQ3Ez; Fri,  6 Dec 2019 06:43:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B7E534AF08;
	Fri,  6 Dec 2019 06:43:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DF2E4AF08
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:43:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TA-sjgpOl1bG for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:43:49 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 786EC4AF01
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:43:49 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idC1U-0001s8-GU; Fri, 06 Dec 2019 12:43:48 +0100
To: Jia He <justin.he@arm.com>
Subject: Re: [PATCH] KVM: arm: remove excessive permission check in
 =?UTF-8?Q?kvm=5Farch=5Fprepare=5Fmemory=5Fregion?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 11:43:48 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191206020802.196108-1-justin.he@arm.com>
References: <20191206020802.196108-1-justin.he@arm.com>
Message-ID: <128917a0fe502137f7575932bbf48fd0@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: justin.he@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
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

On 2019-12-06 02:08, Jia He wrote:
> In kvm_arch_prepare_memory_region, arm kvm regards the memory region 
> as
> writable if the flag has no KVM_MEM_READONLY, and the vm is readonly 
> if
> !VM_WRITE.
>
> But there is common usage for setting kvm memory region as follows:
> e.g. qemu side (see the PROT_NONE flag)
> 1. mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>    memory_region_init_ram_ptr()
> 2. re mmap the above area with read/write authority.
>
> Such example is used in virtio-fs qemu codes which hasn't been 
> upstreamed
> [1]. But seems we can't forbid this example.
>
> Without this patch, it will cause an EPERM during 
> kvm_set_memory_region()
> and cause qemu boot crash.
>
> As told by Ard, "the underlying assumption is incorrect, i.e., that 
> the
> value of vm_flags at this point in time defines how the VMA is used
> during its lifetime. There may be other cases where a VMA is created
> with VM_READ vm_flags that are changed to VM_READ|VM_WRITE later, and
> we are currently rejecting this use case as well."
>
> [1]
> 
> https://gitlab.com/virtio-fs/qemu/blob/5a356e/hw/virtio/vhost-user-fs.c#L488
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 38b4c910b6c3..a48994af70b8 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -2301,15 +2301,6 @@ int kvm_arch_prepare_memory_region(struct kvm 
> *kvm,
>  		if (!vma || vma->vm_start >= reg_end)
>  			break;
>
> -		/*
> -		 * Mapping a read-only VMA is only allowed if the
> -		 * memory region is configured as read-only.
> -		 */
> -		if (writable && !(vma->vm_flags & VM_WRITE)) {
> -			ret = -EPERM;
> -			break;
> -		}
> -
>  		/*
>  		 * Take the intersection of this VMA with the memory region
>  		 */

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
