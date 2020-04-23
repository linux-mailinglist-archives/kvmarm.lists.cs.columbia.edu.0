Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7EE1B57F1
	for <lists+kvmarm@lfdr.de>; Thu, 23 Apr 2020 11:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D44BC4B169;
	Thu, 23 Apr 2020 05:19:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AerJ8RSmlfJt; Thu, 23 Apr 2020 05:19:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB4794B165;
	Thu, 23 Apr 2020 05:19:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 594FA4B163
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 05:19:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgEF44TThVrM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Apr 2020 05:19:26 -0400 (EDT)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 45F6A4B0B6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 05:19:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IF166yOm7z3m4Fk7SSrrLKAwHCMS4Qf9u239M1AvMd0=; b=NEv7cR+rgqIf2XOBxiAU9RR9Vs
 ihCjSWBaJbsum5B6R4ENT5uYOyV4ul60eCJwViQD3oNK2ivAZU/N3oEgK/n9xN8K9f9CW43fHfkgt
 hgxpQoU30ckQi9kJaAbADimpDHIBwLydqXpm8O3ccaLXNZiGOkA4tZsBPW4MyC+00xsks27Szn1AK
 pHzaKGgvAQDmJ4WQisG8qDpEdmU00Otf7jMekdWZwrjboExbQQh5ZyYCtxI5ZmGv+2cREn059gQhK
 amR13oJQKxMRq6inLqNxgqb/K5+1yN631HrSBA9pSYmVXLrrUdQTJHxpq1WaGbtJx5db0XSohzk/Q
 9aPAUTZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRY0n-0003XN-Qx; Thu, 23 Apr 2020 09:19:13 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CA4330257C;
 Thu, 23 Apr 2020 11:19:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 469F520C02CD2; Thu, 23 Apr 2020 11:19:11 +0200 (CEST)
Date: Thu, 23 Apr 2020 11:19:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] kvm: Replace vcpu->swait with rcuwait
Message-ID: <20200423091911.GP20730@hirez.programming.kicks-ass.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
 <20200422040739.18601-5-dave@stgolabs.net>
 <20200423094140.69909bbb@why>
 <f07f6f55-9339-04b0-3877-d3240abd6d9c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f07f6f55-9339-04b0-3877-d3240abd6d9c@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org,
 Davidlohr Bueso <dbueso@suse.de>, Marc Zyngier <maz@kernel.org>,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 will@kernel.org, joel@joelfernandes.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, kvmarm@lists.cs.columbia.edu
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

On Thu, Apr 23, 2020 at 10:57:57AM +0200, Paolo Bonzini wrote:
> On 23/04/20 10:41, Marc Zyngier wrote:
> >>  
> >> -	if (swait_active(kvm_arch_vcpu_wq(vcpu)))
> >> +	if (rcu_dereference(kvm_arch_vpu_get_wait(vcpu)) != NULL)
> > This doesn't compile (wrong function name, and rcu_dereference takes a
> > variable). But whatever it would do if we fixed it looks dodgy. it isn't
> > the rcuwait structure that you want to dereference, but rcuwait->task
> > (we are checking whether we are called because we are blocking or being
> > preempted).
> > 
> 
> Yes, I agree.  Replacing swait with rcuwait is all good, but please make
> the API look the same first.  Just like you added prepare_to_rcuwait and
> finish_rcuwait, let's add rcuwait_active as well.
> 
> Actually let's do it like this:
> 
> 1) Davidlohr, please post only patches 1-3 to "equalize" the swait and
> rcuwait APIs.
> 
> 2) Peter, please prepare a topic branch for those, or provide Acked-by

I don't think I have anything that conflicts with this, so sure, take
the whole thing through KVM.

For 1-3 (and I'll send a small niggle for 3 right after this):

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'll keep 5 as it is unrelated.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
