Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D639211E08C
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 10:26:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 874A14A511;
	Fri, 13 Dec 2019 04:26:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cT9gcdgcE+45; Fri, 13 Dec 2019 04:26:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77D0B4A7FD;
	Fri, 13 Dec 2019 04:26:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 122D34A52C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 04:26:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id McyKVtXlBVk3 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 04:26:36 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E79864A511
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 04:26:35 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64CA41FB;
 Fri, 13 Dec 2019 01:26:35 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE99F3F52E;
 Fri, 13 Dec 2019 01:26:34 -0800 (PST)
Date: Fri, 13 Dec 2019 10:26:33 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/3] KVM: arm/arm64: Drop spurious message when faulting
 on a non-existent mapping
Message-ID: <20191213092633.GD28840@e113682-lin.lund.arm.com>
References: <20191211165651.7889-1-maz@kernel.org>
 <20191211165651.7889-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211165651.7889-4-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Wed, Dec 11, 2019 at 04:56:50PM +0000, Marc Zyngier wrote:
> Should userspace unmap memory whilst the guest is running, we exit
> with a -EFAULT, but also having spat a useless message on the console.
> 
> Get rid of it.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  virt/kvm/arm/mmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index f73393f5ddb7..fbfdffb8fe8e 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1696,7 +1696,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	down_read(&current->mm->mmap_sem);
>  	vma = find_vma_intersection(current->mm, hva, hva + 1);
>  	if (unlikely(!vma)) {
> -		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
>  		up_read(&current->mm->mmap_sem);
>  		return -EFAULT;
>  	}
> -- 
> 2.20.1
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
