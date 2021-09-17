Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C922840F344
	for <lists+kvmarm@lfdr.de>; Fri, 17 Sep 2021 09:29:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D03B4B0B4;
	Fri, 17 Sep 2021 03:29:43 -0400 (EDT)
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
	with ESMTP id w5A-d6HJQ1VR; Fri, 17 Sep 2021 03:29:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC4E74B090;
	Fri, 17 Sep 2021 03:29:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7781D4A2E5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Sep 2021 03:29:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ml1A6-7QDdgr for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Sep 2021 03:29:36 -0400 (EDT)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C3BD64A198
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Sep 2021 03:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=17mkqfuKdfnPg9YSAeGWHc/O4GLOFEnsaFTJ4hUb1Qc=; b=R175PzEhjMPDTuiig9T+/8FvBN
 wCwITbQjI86keC2UZcKL3oHklcXqScPxlhfsprjzgtQHXNUwlN8OYqdLQ7ztxGmPqLPGGL1HvK5TW
 8un1CwadAtDZMXP8kHm7KJ60CKQlzq6kBsXmSOCidcFaqUG49FGQ/Q91WQSCSzrudnHUpN1n/dtAK
 3oCiHTPea1eYl35kiZcqB3afHwTSqwkSRYpje8CyTQKsMtTXOUjDfhQXOeCpbGDLw3jXUuiLQwU+o
 fpmbPjE5lGD64IJe7KimQfKhdgCV7/TWkKj798HvtN0fT0soP/DzPI91f4RdvEreoDEx02Cp2qq0O
 NM1LgiIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR8Ig-003p42-0g; Fri, 17 Sep 2021 07:28:46 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64E5430031A;
 Fri, 17 Sep 2021 09:28:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id EBC3F2B27F98D; Fri, 17 Sep 2021 09:28:41 +0200 (CEST)
Date: Fri, 17 Sep 2021 09:28:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
Message-ID: <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828201336.GD4353@worktop.programming.kicks-ass.net>
 <YUO5J/jTMa2KGbsq@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUO5J/jTMa2KGbsq@google.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-csky@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Like Xu <like.xu.linux@gmail.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Kashkanov <artem.kashkanov@intel.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Juergen Gross <jgross@suse.com>, Nick Hu <nickhu@andestech.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Thu, Sep 16, 2021 at 09:37:43PM +0000, Sean Christopherson wrote:
> On Sat, Aug 28, 2021, Peter Zijlstra wrote:

> Argh, sorry, I somehow managed to miss all of your replies.  I'll get back to
> this series next week.  Thanks for the quick response!
> 
> > Lets keep the whole intel_pt crud inside x86...
> 
> In theory, I like the idea of burying intel_pt inside x86 (and even in
> Intel+VMX code for the most part), but the actual implementation is a
> bit gross.  Because of the whole "KVM can be a module" thing,

ARGH!! we should really fix that. I've heard other archs have made much
better choices here.

> either
> the static call and __static_call_return0 would need to be exported,
> or a new register/unregister pair would have to be exported.

So I don't mind exporting __static_call_return0, but exporting a raw
static_call is much like exporting a function pointer :/

> The unregister path would also need its own synchronize_rcu().  In general, I
> don't love duplicating the logic, but it's not the end of the world.
> 
> Either way works for me.  Paolo or Peter, do either of you have a preference?

Can we de-feature kvm as a module and only have this PT functionality
when built-in? :-)


> > ---
> > Index: linux-2.6/arch/x86/events/core.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/events/core.c
> > +++ linux-2.6/arch/x86/events/core.c
> > @@ -92,7 +92,7 @@ DEFINE_STATIC_CALL_RET0(x86_pmu_guest_ge
> >  
> >  DEFINE_STATIC_CALL_RET0(x86_guest_state, *(perf_guest_cbs->state));
> >  DEFINE_STATIC_CALL_RET0(x86_guest_get_ip, *(perf_guest_cbs->get_ip));
> > -DEFINE_STATIC_CALL_RET0(x86_guest_handle_intel_pt_intr, *(perf_guest_cbs->handle_intel_pt_intr));
> > +DEFINE_STATIC_CALL_RET0(x86_guest_handle_intel_pt_intr, unsigned int (*)(void));
> 
> FWIW, the param needs to be a raw function, not a function pointer. 

Yeah, I keep making that mistake.. and I wrote the bloody thing :/

I have a 'fix' for that, but I need to finish that and also flag-day
change :-(

  https://lkml.kernel.org/r/YS+0eIeAJsRRArk4@hirez.programming.kicks-ass.net
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
