Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 36E68606B63
	for <lists+kvmarm@lfdr.de>; Fri, 21 Oct 2022 00:42:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 156564B9A0;
	Thu, 20 Oct 2022 18:42:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHHJfDf9qn-Q; Thu, 20 Oct 2022 18:42:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C86B4B974;
	Thu, 20 Oct 2022 18:42:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AB254B85A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 18:42:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 518TKA9AhXqQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 18:42:48 -0400 (EDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 998B24B7AA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 18:42:48 -0400 (EDT)
Received: by mail-pg1-f179.google.com with SMTP id e129so863869pgc.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FDFfzkE5dBJ5m6UqarnXclPiOYRM3ZnuG29aeElkJZ8=;
 b=UFyoF3/kPlkt8lmbdzCeNxrtN54Gvnzwlm6/jKsU5K/Mx+Zi+HwDfQ7UxBuccJHjwT
 FF/O/U0LJ81NbHXU1XqFIpc5LF3JCSeveqIRBGPN03THEGBU4v57rGEqKUjuVjhcB1i/
 p0uQl3N+4jVpvxyO3cDiPD12xRWdu5W4a5xnP0NwL7l2oJaStOFKIxqjNsbuxfb4EaN1
 y2EOtpNLG1rHsf1+Fd85K3EDV2HwKToEaOhhJAy/ivRAnwpSGtWhvw7BEQmNr0xUuPFT
 JCUJ8U+wO6kVeTWgjt+2elG8nTCDckhpxTG5vHstj5zWaeyb7w5k3EEwqOijwfqC5N2a
 bSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDFfzkE5dBJ5m6UqarnXclPiOYRM3ZnuG29aeElkJZ8=;
 b=QLnAn2EqCig/s5Nuqv5qL4+cjLHWeEg6vvMDXIPSr8MBIStzJoaZfmeg1+MhNP3O4A
 5HlwBZtwG4qd09rBmlaLgH4YSZC2oZrdDPA3Gx6bPZKgD4+Pd00gRAxa5AL3Eg4PhbnF
 v6cjO4qxRaffuljGYrZvFu/tHFUHbmAWWp6h3CYoL00G49MpKvQ2WBTE+bX1KuYuTRvU
 gFCOiyIOpsiBqbv79wbOifk0D6YbOjNM60F/9a2lfmsenex9ssfGnY035HNF/lWCXimm
 RuoUnRjtJx5XHynuUKr6fljD5stcKMyISxhQlFB3IEH3Tv2V5U3rPa1UxfMBiq9akGYj
 cgQw==
X-Gm-Message-State: ACrzQf2qoM8I0F7MdZR9VYF58j/aXfSeo0AQklLozmyUPV5NE07GPAHV
 O+w4mKbI1LPxsYGAXw/KRTWQNA==
X-Google-Smtp-Source: AMsMyM4JQIqv54X7L2VMODIVQcxLu8cn0BAcxLq2cfv7QyfUO4ao734HP8s0sZIrch8ZWhhpsUlCGA==
X-Received: by 2002:a63:854a:0:b0:46e:af42:ed12 with SMTP id
 u71-20020a63854a000000b0046eaf42ed12mr2502242pgd.510.1666305767257; 
 Thu, 20 Oct 2022 15:42:47 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 m9-20020a63ed49000000b0043c7996f7f0sm12182415pgk.58.2022.10.20.15.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 15:42:46 -0700 (PDT)
Date: Thu, 20 Oct 2022 22:42:43 +0000
From: Sean Christopherson <seanjc@google.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 1/8] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
Message-ID: <Y1HO46UCyhc9M6nM@google.com>
References: <20221011061447.131531-1-gshan@redhat.com>
 <20221011061447.131531-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221011061447.131531-2-gshan@redhat.com>
Cc: shuah@kernel.org, kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, dmatlack@google.com, shan.gavin@gmail.com,
 catalin.marinas@arm.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Tue, Oct 11, 2022, Gavin Shan wrote:
> This adds KVM_REQ_RING_SOFT_FULL, which is raised when the dirty

"This" is basically "This patch", which is generally frowned upon.  Just state
what changes are being made.

> ring of the specific VCPU becomes softly full in kvm_dirty_ring_push().
> The VCPU is enforced to exit when the request is raised and its
> dirty ring is softly full on its entrance.
> 
> The event is checked and handled in the newly introduced helper
> kvm_dirty_ring_check_request(). With this, kvm_dirty_ring_soft_full()
> becomes a private function.

None of this captures why the request is being added.  I'm guessing Marc's
motivation is to avoid having to check ring on every entry, though there might
also be a correctness issue too?

It'd also be helpful to explain that KVM re-queues the request to maintain KVM's
existing uABI, which enforces the soft_limit even if no entries have been added
to the ring since the last KVM_EXIT_DIRTY_RING_FULL exit.

And maybe call out the alternative(s) that was discussed in v2[*]?

[*] https://lore.kernel.org/all/87illlkqfu.wl-maz@kernel.org

> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/x86.c             | 15 ++++++---------
>  include/linux/kvm_dirty_ring.h |  8 ++------
>  include/linux/kvm_host.h       |  1 +
>  virt/kvm/dirty_ring.c          | 19 ++++++++++++++++++-
>  4 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b0c47b41c264..0dd0d32073e7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10260,16 +10260,13 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>  	bool req_immediate_exit = false;
>  
> -	/* Forbid vmenter if vcpu dirty ring is soft-full */
> -	if (unlikely(vcpu->kvm->dirty_ring_size &&
> -		     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
> -		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> -		trace_kvm_dirty_ring_exit(vcpu);
> -		r = 0;
> -		goto out;
> -	}
> -
>  	if (kvm_request_pending(vcpu)) {
> +		/* Forbid vmenter if vcpu dirty ring is soft-full */

Eh, I'd drop the comment, pretty obvious what the code is doing

> +		if (kvm_dirty_ring_check_request(vcpu)) {

I think it makes to move this check below at KVM_REQ_VM_DEAD.  I doubt it will
ever matter in practice, but conceptually VM_DEAD is a higher priority event.

I'm pretty sure the check can be moved to the very end of the request checks,
e.g. to avoid an aborted VM-Enter attempt if one of the other request triggers
KVM_REQ_RING_SOFT_FULL.

Heh, this might actually be a bug fix of sorts.  If anything pushes to the ring
after the check at the start of vcpu_enter_guest(), then without the request, KVM
would enter the guest while at or above the soft limit, e.g. record_steal_time()
can dirty a page, and the big pile of stuff that's behind KVM_REQ_EVENT can
certainly dirty pages.

> +			r = 0;
> +			goto out;
> +		}
> +
>  		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
>  			r = -EIO;
>  			goto out;

> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -157,6 +157,7 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQ_VM_DEAD           (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_UNBLOCK           2
>  #define KVM_REQ_UNHALT            3

UNHALT is gone, the new request can use '3'.

> +#define KVM_REQ_RING_SOFT_FULL    4

Any objection to calling this KVM_REQ_DIRTY_RING_SOFT_FULL?  None of the users
are in danger of having too long lines, and at first glance it's not clear that
this is specifically for the dirty ring.

It'd also give us an excuse to replace spaces with tabs in the above alignment :-)

#define KVM_REQ_TLB_FLUSH		(0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
#define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
#define KVM_REQ_UNBLOCK			2
#define KVM_REQ_DIRTY_RING_SOFT_FULL	3
#define KVM_REQUEST_ARCH_BASE		8

> @@ -149,6 +149,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
>  
>  void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
>  {
> +	struct kvm_vcpu *vcpu = container_of(ring, struct kvm_vcpu, dirty_ring);
>  	struct kvm_dirty_gfn *entry;
>  
>  	/* It should never get full */
> @@ -166,6 +167,22 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
>  	kvm_dirty_gfn_set_dirtied(entry);
>  	ring->dirty_index++;
>  	trace_kvm_dirty_ring_push(ring, slot, offset);
> +
> +	if (kvm_dirty_ring_soft_full(ring))
> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);

Would it make sense to clear the request in kvm_dirty_ring_reset()?  I don't care
about the overhead of having to re-check the request, the goal would be to help
document what causes the request to go away.

E.g. modify kvm_dirty_ring_reset() to take @vcpu and then do:

	if (!kvm_dirty_ring_soft_full(ring))
		kvm_clear_request(KVM_REQ_RING_SOFT_FULL, vcpu);

> +}
> +
> +bool kvm_dirty_ring_check_request(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
> +		kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {

Align please,

	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {

> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);

A comment would be helpful to explain (a) why KVM needs to re-check on the next
KVM_RUN and (b) why this won't indefinitely prevent KVM from entering the guest.
For pretty every other request I can think of, re-queueing a request like this
will effectively hang the vCPU, i.e. this looks wrong at first glance.

> +		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> +		trace_kvm_dirty_ring_exit(vcpu);
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset)
> -- 
> 2.23.0
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
