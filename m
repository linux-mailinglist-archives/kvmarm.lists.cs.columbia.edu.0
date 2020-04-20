Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE21B112A
	for <lists+kvmarm@lfdr.de>; Mon, 20 Apr 2020 18:10:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1D7D4B125;
	Mon, 20 Apr 2020 12:10:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p5ImsPnyUfoI; Mon, 20 Apr 2020 12:10:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C0364B121;
	Mon, 20 Apr 2020 12:10:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C56284B107
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 12:10:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H0dSGCQal8pb for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Apr 2020 12:10:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E8684B101
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Apr 2020 12:10:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D1531B;
 Mon, 20 Apr 2020 09:10:33 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6BFC3F73D;
 Mon, 20 Apr 2020 09:10:32 -0700 (PDT)
Subject: Re: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset
 when S2FWB is supported
To: Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200415072835.1164-1-yuzenghui@huawei.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
Date: Mon, 20 Apr 2020 17:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415072835.1164-1-yuzenghui@huawei.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>
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

Hi,

On 4/15/20 8:28 AM, Zenghui Yu wrote:
> stage2_unmap_vm() was introduced to unmap user RAM region in the stage2
> page table to make the caches coherent. E.g., a guest reboot with stage1
> MMU disabled will access memory using non-cacheable attributes. If the
> RAM and caches are not coherent at this stage, some evicted dirty cache
> line may go and corrupt guest data in RAM.
>
> Since ARMv8.4, S2FWB feature is mandatory and KVM will take advantage
> of it to configure the stage2 page table and the attributes of memory
> access. So we ensure that guests always access memory using cacheable
> attributes and thus, the caches always be coherent.
>
> So on CPUs that support S2FWB, we can safely reset the vcpu without a
> heavy stage2 unmapping.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>
> If this is correct, there should be a great performance improvement on
> a guest reboot (or reset) on systems support S2FWB. But I'm afraid that
> I've missed some points here, so please comment!
>
> The commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
> was merged about six years ago and I failed to track its histroy and
> intention. Instead of a whole stage2 unmapping, something like
> stage2_flush_vm() looks enough to me. But again, I'm unsure...
>
> Thanks for having a look!

I had a chat with Christoffer about stage2_unmap_vm, and as I understood it, the
purpose was to make sure that any changes made by userspace were seen by the guest
while the MMU is off. When a stage 2 fault happens, we do clean+inval on the
dcache, or inval on the icache if it was an exec fault. This means that whatever
the host userspace writes while the guest is shut down and is still in the cache,
the guest will be able to read/execute.

This can be relevant if the guest relocates the kernel and overwrites the original
image location, and userspace copies the original kernel image back in before
restarting the vm.

>
>  virt/kvm/arm/arm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 48d0ec44ad77..e6378162cdef 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>  	/*
>  	 * Ensure a rebooted VM will fault in RAM pages and detect if the
>  	 * guest MMU is turned off and flush the caches as needed.
> +	 *
> +	 * S2FWB enforces all memory accesses to RAM being cacheable, we
> +	 * ensure that the cache is always coherent.
>  	 */
> -	if (vcpu->arch.has_run_once)
> +	if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))

I think userspace does not invalidate the icache when loading a new kernel image,
and if the guest patched instructions, they could potentially still be in the
icache. Should the icache be invalidated if FWB is present?

Thanks,
Alex
>  		stage2_unmap_vm(vcpu->kvm);
>  
>  	vcpu_reset_hcr(vcpu);
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
