Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8C3370EF
	for <lists+kvmarm@lfdr.de>; Thu, 11 Mar 2021 12:15:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66B514B61F;
	Thu, 11 Mar 2021 06:15:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FbEtl+5KrzWN; Thu, 11 Mar 2021 06:15:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32CB24B5C0;
	Thu, 11 Mar 2021 06:15:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34EE24B51E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 06:15:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPEaotXy2W7M for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Mar 2021 06:15:16 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D1204B4FA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 06:15:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615461316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HLjJbWr4BucAiEq+UPFMlG+jYewhjm6x9TggCNo+wzk=;
 b=P7luaMEOg9x45dfQzDju/XGYYPDFYCkVnxF0rd9jAilnz4AW2gG4bOuB7MWYv4DoaT8xA6
 BS8XbwoLyhbHZDfN3b2b4/vjVN58Y1Q9ekDGVSc2+Iz9+mpLAF6/CCXG9UTXOD6BWweFrF
 9sTbpgd3ZSzb/NseOreiYE6h93OTI5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-u3Nb2-jMM2qT9pMPrj0aJg-1; Thu, 11 Mar 2021 06:15:12 -0500
X-MC-Unique: u3Nb2-jMM2qT9pMPrj0aJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48E8118460E1;
 Thu, 11 Mar 2021 11:15:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BDC950D38;
 Thu, 11 Mar 2021 11:15:03 +0000 (UTC)
Date: Thu, 11 Mar 2021 12:15:00 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 2/2] KVM: arm64: Fix exclusive limit for IPA size
Message-ID: <20210311111500.uqy4lolxtp7t4xd4@kamzik.brq.redhat.com>
References: <20210311100016.3830038-1-maz@kernel.org>
 <20210311100016.3830038-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311100016.3830038-3-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kernel-team@android.com, kvm@vger.kernel.org, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Mar 11, 2021 at 10:00:16AM +0000, Marc Zyngier wrote:
> When registering a memslot, we check the size and location of that
> memslot against the IPA size to ensure that we can provide guest
> access to the whole of the memory.
> 
> Unfortunately, this check rejects memslot that end-up at the exact
> limit of the addressing capability for a given IPA size. For example,
> it refuses the creation of a 2GB memslot at 0x8000000 with a 32bit
> IPA space.
> 
> Fix it by relaxing the check to accept a memslot reaching the
> limit of the IPA space.
> 
> Fixes: e55cac5bf2a9 ("kvm: arm/arm64: Prepare for VM specific stage2 translations")

Isn't this actually fixing commit c3058d5da222 ("arm/arm64: KVM: Ensure
memslots are within KVM_PHYS_SIZE") ?

> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 77cb2d28f2a4..8711894db8c2 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1312,8 +1312,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  	 * Prevent userspace from creating a memory region outside of the IPA
>  	 * space addressable by the KVM guest IPA space.
>  	 */
> -	if (memslot->base_gfn + memslot->npages >=
> -	    (kvm_phys_size(kvm) >> PAGE_SHIFT))
> +	if ((memslot->base_gfn + memslot->npages) > (kvm_phys_size(kvm) >> PAGE_SHIFT))
>  		return -EFAULT;
>  
>  	mmap_read_lock(current->mm);
> -- 
> 2.29.2
> 

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
