Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03560351203
	for <lists+kvmarm@lfdr.de>; Thu,  1 Apr 2021 11:28:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 998624B628;
	Thu,  1 Apr 2021 05:28:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GgRkoNYixWph; Thu,  1 Apr 2021 05:28:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A59004B626;
	Thu,  1 Apr 2021 05:28:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00FDA4B491
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 12:41:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N8ltjuozVoXy for <kvmarm@lists.cs.columbia.edu>;
 Wed, 31 Mar 2021 12:41:26 -0400 (EDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B37E84B47F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 12:41:26 -0400 (EDT)
Received: by mail-pf1-f182.google.com with SMTP id m11so14939192pfc.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iR0wTKyQqrCYG4Q831SOK/hJxQXD0DTeg7JGIplTxaE=;
 b=pDOL/AXp1YZDHSJM55VWmMHEXRZyEKHoWUfLiwu43sQHWLgrvb2clWRDjjyCUh0dsJ
 bNDMyWcbeueU/GKG4kOjx3b7egix4+sMYZfIS9I0MmjVVx1rcp5WszmjK7+6YeQKCfOM
 2FXvSyhaSnZkWSZYBa+Zf13p0L3I/egR0XklyggIPr+PefBGDyB7ynzXrNWFqXB2lvPg
 VgGQ2uiEQdyQFwKIAdbJTxKQSwskTj3uIlVQzOZzPoiS3tMYr2MmjzSdDZfHyKUb7IXo
 nUd7C6HDGQOQomM2rO6UOTojM3AlSltwg6FTYiW5B9h7N+cvmdJr9MHgjJMW5v34nPiS
 VoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iR0wTKyQqrCYG4Q831SOK/hJxQXD0DTeg7JGIplTxaE=;
 b=nf9fmYtW3G9xecvC+Iyz5vO2UY+yfEkhrmDdX+zZCALsnsZbMZLPUoGHpF3QPB78u5
 0weXfHZIcJdE/KahNgrJKsG3ME3kWnpPr5v2tyQ33JWcMXNphdw2onWSeeuDeCCt2vNr
 S7V3MA2dL++HgES7y0btuOy7qI5OX1mKNyak+3pr3UKx36HsDumnGBGhquWokNNsLglI
 b1MIc6oR64feoT+EVhCj9qt7DNbWGaLnbmuRZnVC8d0V1bST9AeZ1lXFJbUxgqW2fpNX
 COgxlqbYvVhhTPXkdi8m+UQ117hm2adReW6E7Z0AZBQG810glKRl94o4jiGs6L7FAYEn
 5JgQ==
X-Gm-Message-State: AOAM532vqRJXvhUDWbjg0qNA4eZH1uzYx6PBTQ4ByDocCD1K/s1HeUas
 F0eO3WNJ/eOQ6n3S5Pu63OzY/w==
X-Google-Smtp-Source: ABdhPJwZrE+nqFXUOYwl468wAhlBPq8DZI8v9hc2mHxYO0VlQq5depEehdtkJEVYztZyBSLt0lNXHA==
X-Received: by 2002:aa7:86c1:0:b029:203:900:2813 with SMTP id
 h1-20020aa786c10000b029020309002813mr3647646pfo.35.1617208885458; 
 Wed, 31 Mar 2021 09:41:25 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com.
 [35.247.111.240])
 by smtp.gmail.com with ESMTPSA id a13sm2933328pgm.43.2021.03.31.09.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 09:41:24 -0700 (PDT)
Date: Wed, 31 Mar 2021 16:41:21 +0000
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 16/18] KVM: Don't take mmu_lock for range invalidation
 unless necessary
Message-ID: <YGSmMeSOPcjxRwf6@google.com>
References: <20210326021957.1424875-1-seanjc@google.com>
 <20210326021957.1424875-17-seanjc@google.com>
 <6e7dc7d0-f5dc-85d9-1c50-d23b761b5ff3@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e7dc7d0-f5dc-85d9-1c50-d23b761b5ff3@redhat.com>
X-Mailman-Approved-At: Thu, 01 Apr 2021 05:28:17 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Ben Gardon <bgardon@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

On Wed, Mar 31, 2021, Paolo Bonzini wrote:
> On 26/03/21 03:19, Sean Christopherson wrote:
> > +	/*
> > +	 * Reset the lock used to prevent memslot updates between MMU notifier
> > +	 * range_start and range_end.  At this point no more MMU notifiers will
> > +	 * run, but the lock could still be held if KVM's notifier was removed
> > +	 * between range_start and range_end.  No threads can be waiting on the
> > +	 * lock as the last reference on KVM has been dropped.  If the lock is
> > +	 * still held, freeing memslots will deadlock.
> > +	 */
> > +	init_rwsem(&kvm->mmu_notifier_slots_lock);
> 
> I was going to say that this is nasty,

Heh, I still think it's nasty.

> then I noticed that
> mmu_notifier_unregister uses SRCU to ensure completion of concurrent calls
> to the MMU notifier.  So I guess it's fine, but it's better to point it out:
> 
> 	/*
> 	 * At this point no more MMU notifiers will run and pending
> 	 * calls to range_start have completed, but the lock would
> 	 * still be held and never released if the MMU notifier was
> 	 * removed between range_start and range_end.  Since the last
> 	 * reference to the struct kvm has been dropped, no threads can
> 	 * be waiting on the lock, but we might still end up taking it
> 	 * when freeing memslots in kvm_arch_destroy_vm.  Reset the lock
> 	 * to avoid deadlocks.
> 	 */
> 
> That said, the easiest way to avoid this would be to always update
> mmu_notifier_count.

Updating mmu_notifier_count requires taking mmu_lock, which would defeat the
purpose of these shenanigans.  I think it could be made atomic, since mmu_lock
would be taken before the elevated count _must_ be visible, but that would
break the mmu_notifier_range_{start,end} optimization that was recently added.

Or did I completely misunderstand what you're suggesting?

> I don't mind the rwsem, but at least I suggest that you
> split the patch in two---the first one keeping the mmu_notifier_count update
> unconditional, and the second one introducing the rwsem and the on_lock
> function kvm_inc_notifier_count.  Please document the new lock in
> Documentation/virt/kvm/locking.rst too.

Note, will update docs.

> Also, related to the first part of the series, perhaps you could structure
> the series in a slightly different way:
> 
> 1) introduce the HVA walking API in common code, complete with on_lock and
> patch 15, so that you can use on_lock to increase mmu_notifier_seq
> 
> 2) then migrate all architectures including x86 to the new API
> 
> IOW, first half of patch 10 and all of patch 15; then the second half of
> patch 10; then patches 11-14.
> 
> > +#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> > +	down_write(&kvm->mmu_notifier_slots_lock);
> > +#endif
> >  	rcu_assign_pointer(kvm->memslots[as_id], slots);
> > +#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> > +	up_write(&kvm->mmu_notifier_slots_lock);
> > +#endif
> 
> Please do this unconditionally, the cost is minimal if the rwsem is not
> contended (as is the case if the architecture doesn't use MMU notifiers at
> all).

It's not the cost, it's that mmu_notifier_slots_lock doesn't exist.  That's an
easily solved problem, but then the lock wouldn't be initialized since
kvm_init_mmu_notifier() is a nop.  That's again easy to solve, but IMO would
look rather weird.  I guess the counter argument is that __kvm_memslots()
wouldn't need #ifdeffery.

These are the to ideas I've come up with:

Option 1:
	static int kvm_init_mmu_notifier(struct kvm *kvm)
	{
		init_rwsem(&kvm->mmu_notifier_slots_lock);

	#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
		kvm->mmu_notifier.ops = &kvm_mmu_notifier_ops;
		return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
	#else
		return 0;
	#endif
	}


Option 2:
	kvm_mmu_notifier_lock(kvm);
	rcu_assign_pointer(kvm->memslots[as_id], slots);
	kvm_mmu_notifier_unlock(kvm);




_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
