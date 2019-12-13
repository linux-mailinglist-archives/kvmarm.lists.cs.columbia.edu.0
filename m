Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8889111E299
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 12:14:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 222654A4A9;
	Fri, 13 Dec 2019 06:14:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PeBZnUkbqsAI; Fri, 13 Dec 2019 06:14:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B0654A7E4;
	Fri, 13 Dec 2019 06:14:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D66C24A4CD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 06:14:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNv40UXFmTbc for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 06:14:02 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 669684A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 06:14:02 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B231FB;
 Fri, 13 Dec 2019 03:14:01 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656FC3F718;
 Fri, 13 Dec 2019 03:14:01 -0800 (PST)
Date: Fri, 13 Dec 2019 12:14:00 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/3] KVM: arm/arm64: Properly handle faulting of device
 mappings
Message-ID: <20191213111400.GI28840@e113682-lin.lund.arm.com>
References: <20191211165651.7889-1-maz@kernel.org>
 <20191211165651.7889-2-maz@kernel.org>
 <20191213082920.GA28840@e113682-lin.lund.arm.com>
 <7f86824f4cbd17cd75ef347473e34278@www.loen.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f86824f4cbd17cd75ef347473e34278@www.loen.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Fri, Dec 13, 2019 at 09:28:59AM +0000, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On 2019-12-13 08:29, Christoffer Dall wrote:
> > Hi Marc,
> > 
> > On Wed, Dec 11, 2019 at 04:56:48PM +0000, Marc Zyngier wrote:
> > > A device mapping is normally always mapped at Stage-2, since there
> > > is very little gain in having it faulted in.
> > 
> > It is actually becoming less clear to me what the real benefits of
> > pre-populating the stage 2 page table are, especially given that we can
> > provoke a situation where they're faulted in anyhow.  Do you recall if
> > we had any specific case that motivated us to pre-fault in the pages?
> 
> It's only a minor performance optimization that was introduced by Ard in
> 8eef91239e57d. Which makes sense for platform devices that have a single
> fixed location in memory. It makes slightly less sense for PCI, where
> you can move things around.

User space could still decide to move things around in its VA map even
if the device is fixed.

Anyway, I was thinking more if there was some sort of device, like a
frambuffer, which for example crosses page boundaries and where it would
be visible to the user that there's a sudden performance drop while
operating the device over page boundaries.  Anything like that?

> 
> > > Nonetheless, it is possible to end-up in a situation where the
> > > device
> > > mapping has been removed from Stage-2 (userspace munmaped the VFIO
> > > region, and the MMU notifier did its job), but present in a
> > > userspace
> > > mapping (userpace has mapped it back at the same address). In such
> > > a situation, the device mapping will be demand-paged as the guest
> > > performs memory accesses.
> > > 
> > > This requires to be careful when dealing with mapping size, cache
> > > management, and to handle potential execution of a device mapping.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  virt/kvm/arm/mmu.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > > index a48994af70b8..0b32a904a1bb 100644
> > > --- a/virt/kvm/arm/mmu.c
> > > +++ b/virt/kvm/arm/mmu.c
> > > @@ -38,6 +38,11 @@ static unsigned long io_map_base;
> > >  #define KVM_S2PTE_FLAG_IS_IOMAP		(1UL << 0)
> > >  #define KVM_S2_FLAG_LOGGING_ACTIVE	(1UL << 1)
> > > 
> > > +static bool is_iomap(unsigned long flags)
> > > +{
> > > +	return flags & KVM_S2PTE_FLAG_IS_IOMAP;
> > > +}
> > > +
> > 
> > nit: I'm not really sure this indirection makes the code more readable,
> > but I guess that's a matter of taste.
> > 
> > >  static bool memslot_is_logging(struct kvm_memory_slot *memslot)
> > >  {
> > >  	return memslot->dirty_bitmap && !(memslot->flags &
> > > KVM_MEM_READONLY);
> > > @@ -1698,6 +1703,7 @@ static int user_mem_abort(struct kvm_vcpu
> > > *vcpu, phys_addr_t fault_ipa,
> > > 
> > >  	vma_pagesize = vma_kernel_pagesize(vma);
> > >  	if (logging_active ||
> > > +	    (vma->vm_flags & VM_PFNMAP) ||
> > 
> > WHat is actually the rationale for this?
> > 
> > Why is a huge mapping not permitted to device memory?
> > 
> > Are we guaranteed that VM_PFNMAP on the vma results in device mappings?
> > I'm not convinced this is the case, and it would be better if we can
> > stick to a single primitive (either kvm_is_device_pfn, or VM_PFNMAP) to
> > detect device mappings.
> 
> For now, I've tried to keep the two paths that deal with mapping devices
> (or rather, things that we interpret as devices) as close as possible.
> If we drop the "eager" mapping, then we're at liberty to restructure
> this in creative ways.
> 
> This includes potential huge mappings, but I'm not sure the rest of the
> kernel uses them for devices anyway (I need to find out).
> 
> > As a subsequent patch, I'd like to make sure that at the very least our
> > memslot prepare function follows the exact same logic for mapping device
> > memory as a fault-in approach does, or that we simply always fault pages
> > in.
> 
> As far as I can see, the two approach are now identical. Am I missing
> something?
> And yes, getting rid of the eager mapping works for me.
> 

As far as I can tell, our user_mem_abort() uses gfn_to_pfn_prot() which
goes doesn a long trail which ends up at hva_to_pfn_remapped(), which
might result in doing the same offset calculation that we do in
kvm_arch_prepare_memory_region(), but it also considers other scenarios.

Even if we analyze all that and convince oursleves it's always all the
same on arm64, the two code paths could change, leading to really hard
to debug differing behavior, and nobody will actively keep the two paths
in sync.  I'd be fine with keeping the performance optimization if we
have good grounds for that though, and using the same translation
mechanism for VM_PFNMAP as user_mem_abort.

Am I missing something?

> > 
> > >  	    !fault_supports_stage2_huge_mapping(memslot, hva,
> > > vma_pagesize)) {
> > >  		force_pte = true;
> > >  		vma_pagesize = PAGE_SIZE;
> > > @@ -1760,6 +1766,9 @@ static int user_mem_abort(struct kvm_vcpu
> > > *vcpu, phys_addr_t fault_ipa,
> > >  			writable = false;
> > >  	}
> > > 
> > > +	if (exec_fault && is_iomap(flags))
> > > +		return -ENOEXEC;
> > > +
> > 
> > nit: why don't you just do this when checking kvm_is_device_pfn() and
> > avoid having logic in two places to deal with this case?
> 
> Good point. I've already sent the PR, but that could be a further cleanup.
> 

Sure, I can have a look when we agree on the above.

> > 
> > >  	spin_lock(&kvm->mmu_lock);
> > >  	if (mmu_notifier_retry(kvm, mmu_seq))
> > >  		goto out_unlock;
> > > @@ -1781,7 +1790,7 @@ static int user_mem_abort(struct kvm_vcpu
> > > *vcpu, phys_addr_t fault_ipa,
> > >  	if (writable)
> > >  		kvm_set_pfn_dirty(pfn);
> > > 
> > > -	if (fault_status != FSC_PERM)
> > > +	if (fault_status != FSC_PERM && !is_iomap(flags))
> > >  		clean_dcache_guest_page(pfn, vma_pagesize);
> > > 
> > >  	if (exec_fault)
> > > @@ -1948,9 +1957,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu
> > > *vcpu, struct kvm_run *run)
> > >  	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> > >  		if (is_iabt) {
> > >  			/* Prefetch Abort on I/O address */
> > > -			kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> > > -			ret = 1;
> > > -			goto out_unlock;
> > > +			ret = -ENOEXEC;
> > > +			goto out;
> > >  		}
> > > 
> > >  		/*
> > > @@ -1992,6 +2000,11 @@ int kvm_handle_guest_abort(struct kvm_vcpu
> > > *vcpu, struct kvm_run *run)
> > >  	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
> > >  	if (ret == 0)
> > >  		ret = 1;
> > > +out:
> > > +	if (ret == -ENOEXEC) {
> > > +		kvm_inject_pabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> > > +		ret = 1;
> > > +	}
> > >  out_unlock:
> > >  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > >  	return ret;
> > > --
> > > 2.20.1
> > > 
> > 
> > I can't seem to decide for myself if I think there's a sematic
> > difference between trying to execute from somewhere the VMM has
> > explicitly told us is device memory and from somewhere which we happen
> > to have mapped with VM_PFNMAP from user space.  But I also can't seem to
> > really fault it (pun intended).  Thoughts?
> 
> The issue is that the VMM never really tells us whether something is a
> device mapping or not (the only exception being the GICv2 cpuif). Even
> with PFNMAP, we guess it (it could well be memory that lives outside
> of the linear mapping). I don't see a way to lift this ambiguity.
> 
> Ideally, faulting on executing a non-mapping should be offloaded to
> userspace for emulation, in line with your patches that offload
> non-emulated data accesses. That'd be a new ABI, and I can't imagine
> anyone willing to deal with it.

So what I was asking was if it makes sense to report the Prefetch Abort
in the case where the VMM has already told us that it doesn't want to
register anything backing the IPA (no memslot), and instead return an
error to user space, so that it can make a decision (for example inject
an external abort, which may have been the right thing to do in the
former case as well, but that could be considered ABI now, so let's not
kick that hornet's nest).

In any case, no strong feelings here, I just have a vague feeling that
injecting more prefetch aborts on execute-from-some-device is not
necessarily the right thing to do.


Thanks,

    Christoffer
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
