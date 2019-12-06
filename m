Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E23D0114FF8
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:46:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77EDA4AF49;
	Fri,  6 Dec 2019 06:46:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGQGDhUk0tss; Fri,  6 Dec 2019 06:46:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5881E4AF3D;
	Fri,  6 Dec 2019 06:46:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D77C14AF28
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:46:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRF+XTNuFpWu for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:46:50 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E42624AE8D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:46:49 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idC4H-0001wz-8n; Fri, 06 Dec 2019 12:46:41 +0100
To: linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH v3] KVM: vgic: Use wrapper function to lock/unlock all
 vcpus in =?UTF-8?Q?kvm=5Fvgic=5Fcreate=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 11:46:41 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <1575081918-11401-1-git-send-email-linmiaohe@huawei.com>
References: <1575081918-11401-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <0e466a9f072a6db275701cb80f59a311@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linmiaohe@huawei.com, pbonzini@redhat.com,
 rkrcmar@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, christoffer.dall@arm.com, catalin.marinas@arm.com,
 eric.auger@redhat.com, gregkh@linuxfoundation.org, will@kernel.org,
 andre.przywara@arm.com, tglx@linutronix.de, steven.price@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com,
 steven.price@arm.com, andre.przywara@arm.com,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 pbonzini@redhat.com, tglx@linutronix.de, will@kernel.org,
 kvmarm@lists.cs.columbia.edu
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

On 2019-11-30 02:45, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Use wrapper function lock_all_vcpus()/unlock_all_vcpus()
> in kvm_vgic_create() to remove duplicated code dealing
> with locking and unlocking all vcpus in a vm.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> -v2:
> 	Fix some spelling mistake in patch title and commit log.
> -v3:
> 	Remove the comment that no longer makes sense.
> ---
>  virt/kvm/arm/vgic/vgic-init.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-init.c 
> b/virt/kvm/arm/vgic/vgic-init.c
> index b3c5de48064c..22ff73ecac80 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -70,7 +70,7 @@ void kvm_vgic_early_init(struct kvm *kvm)
>   */
>  int kvm_vgic_create(struct kvm *kvm, u32 type)
>  {
> -	int i, vcpu_lock_idx = -1, ret;
> +	int i, ret;
>  	struct kvm_vcpu *vcpu;
>
>  	if (irqchip_in_kernel(kvm))
> @@ -86,17 +86,9 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  		!kvm_vgic_global_state.can_emulate_gicv2)
>  		return -ENODEV;
>
> -	/*
> -	 * Any time a vcpu is run, vcpu_load is called which tries to grab 
> the
> -	 * vcpu->mutex.  By grabbing the vcpu->mutex of all VCPUs we ensure
> -	 * that no other VCPUs are run while we create the vgic.
> -	 */
>  	ret = -EBUSY;
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (!mutex_trylock(&vcpu->mutex))
> -			goto out_unlock;
> -		vcpu_lock_idx = i;
> -	}
> +	if (!lock_all_vcpus(kvm))
> +		return ret;
>
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		if (vcpu->arch.has_run_once)
> @@ -125,10 +117,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  		INIT_LIST_HEAD(&kvm->arch.vgic.rd_regions);
>
>  out_unlock:
> -	for (; vcpu_lock_idx >= 0; vcpu_lock_idx--) {
> -		vcpu = kvm_get_vcpu(kvm, vcpu_lock_idx);
> -		mutex_unlock(&vcpu->mutex);
> -	}
> +	unlock_all_vcpus(kvm);
>  	return ret;
>  }

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
