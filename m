Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3414487A61
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jan 2022 17:31:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30BD84B274;
	Fri,  7 Jan 2022 11:31:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.912
X-Spam-Level: 
X-Spam-Status: No, score=0.912 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_BLOCKED=0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qhLTETgkQ+xh; Fri,  7 Jan 2022 11:31:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F37014B29A;
	Fri,  7 Jan 2022 11:31:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EBCDF4B281
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:31:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W0EVkHGVAzTr for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jan 2022 11:31:38 -0500 (EST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CAE364B274
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:31:38 -0500 (EST)
Received: by mail-pg1-f169.google.com with SMTP id a22so1467150pgd.6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 07 Jan 2022 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8x5aau+9GId4X1fkS/Ix8Wi9zq+PLZoxIQ2oHrW+IM8=;
 b=L9AJlkClDBCQp2d0qcZIwYZbbM0UJrWK7mAnAs7XoHi5p3eXECQk/DT7ZPdJL6dOLF
 jIWwg4D0FCWGc+KY752pSLb0iqOUgyV4ueCX1tRs0iyIihUOfu+/nrN1UnQgQtHzU6Q9
 E2bh0Vzff3Bi2MgEvD6x1btKH7Hj+ZDktF1TswaiGXH2itZ6sMNFH0eff2bzCSZIUzPx
 Ljeu9mMpDh9SifesE99f/y4hFJusqSEbqQ+3QYY58RlPh7erzlf6CgVoHjBTmnzEr0gg
 cXvZjK196zShjNX+a2OopX31KfOYlHQPnp5tpCH8PJpwA4n+VcXTb4X9AGr99mUZ2sKJ
 dpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8x5aau+9GId4X1fkS/Ix8Wi9zq+PLZoxIQ2oHrW+IM8=;
 b=LxqHpU5aEoGNcXNIy8Kx7j9V/HlYFMIKGz0tU41TI8H0IcDpbNhuq39txGlkAgnGuy
 kbZA+ak7gDw6rgJEkhfWtHvlpZEpA3j2L1VhBbXx3wuhbUeFtVda40y0JiaWrgckx8Ao
 KKmtHW1BxsyrsX7hpGNNs0FC/CQ3dnndXniXgjlCLdfgK7TQOD0kbsGMIbW+ZkXf8NqN
 hAeBuSuichOah57gbPFh4bk+avRYVClRKNdayC8oCuTBC5VupW7peWjCNOHSZ5tquT6V
 kBJIK/5GGUAqoDCYmAzYV98YzaZ/nz0lkI8ynmSEiixQMlM1+U4wXzDXwBih8Clg2FfV
 Gfyw==
X-Gm-Message-State: AOAM5326LJhlVulgYxBPIweLPDju+RMyeez7WqnuU5M7dQCY2S1iL7r7
 2xU8Mhj8xrAgO4wtexQHMfaJjQ==
X-Google-Smtp-Source: ABdhPJzgG47GKpuKWTf6oJSn9E2fBwBv84lP3oKIaE8NOaZd04A6CCABm5d7mq013onV7fWVKolFbQ==
X-Received: by 2002:a63:3f88:: with SMTP id m130mr5233049pga.413.1641573097689; 
 Fri, 07 Jan 2022 08:31:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id v128sm4290920pfc.36.2022.01.07.08.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jan 2022 08:31:37 -0800 (PST)
Date: Fri, 7 Jan 2022 16:31:33 +0000
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v5 4/4] KVM: mmu: remove over-aggressive warnings
Message-ID: <Ydhq5aHW+JFo15UF@google.com>
References: <20211129034317.2964790-1-stevensd@google.com>
 <20211129034317.2964790-5-stevensd@google.com>
 <Yc4G23rrSxS59br5@google.com>
 <CAD=HUj5Q6rW8UyxAXUa3o93T0LBqGQb7ScPj07kvuM3txHMMrQ@mail.gmail.com>
 <YdXrURHO/R82puD4@google.com> <YdXvUaBUvaRPsv6m@google.com>
 <CAD=HUj736L5oxkzeL2JoPV8g1S6Rugy_TquW=PRt73YmFzP6Jw@mail.gmail.com>
 <YdcpIQgMZJrqswKU@google.com>
 <CAD=HUj5v37wZ9NuNC4QBDvCGO2SyNG2KAiTc9Jxfg=R7neCuTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=HUj5v37wZ9NuNC4QBDvCGO2SyNG2KAiTc9Jxfg=R7neCuTw@mail.gmail.com>
Cc: Chia-I Wu <olv@chromium.org>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
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

On Fri, Jan 07, 2022, David Stevens wrote:
> > > These are the type of pages which KVM is currently rejecting. Is this
> > > something that KVM can support?
> >
> > I'm not opposed to it.  My complaint is that this series is incomplete in that it
> > allows mapping the memory into the guest, but doesn't support accessing the memory
> > from KVM itself.  That means for things to work properly, KVM is relying on the
> > guest to use the memory in a limited capacity, e.g. isn't using the memory as
> > general purpose RAM.  That's not problematic for your use case, because presumably
> > the memory is used only by the vGPU, but as is KVM can't enforce that behavior in
> > any way.
> >
> > The really gross part is that failures are not strictly punted to userspace;
> > the resulting error varies significantly depending on how the guest "illegally"
> > uses the memory.
> >
> > My first choice would be to get the amdgpu driver "fixed", but that's likely an
> > unreasonable request since it sounds like the non-KVM behavior is working as intended.
> >
> > One thought would be to require userspace to opt-in to mapping this type of memory
> > by introducing a new memslot flag that explicitly states that the memslot cannot
> > be accessed directly by KVM, i.e. can only be mapped into the guest.  That way,
> > KVM has an explicit ABI with respect to how it handles this type of memory, even
> > though the semantics of exactly what will happen if userspace/guest violates the
> > ABI are not well-defined.  And internally, KVM would also have a clear touchpoint
> > where it deliberately allows mapping such memslots, as opposed to the more implicit
> > behavior of bypassing ensure_pfn_ref().
> 
> Is it well defined when KVM needs to directly access a memslot?

Not really, there's certainly no established rule.

> At least for x86, it looks like most of the use cases are related to nested
> virtualization, except for the call in emulator_cmpxchg_emulated.

The emulator_cmpxchg_emulated() will hopefully go away in the nearish future[*].
Paravirt features that communicate between guest and host via memory is the other
case that often maps a pfn into KVM.

> Without being able to specifically state what should be avoided, a flag like
> that would be difficult for userspace to use.

Yeah :-(  I was thinking KVM could state the flag would be safe to use if and only
if userspace could guarantee that the guest would use the memory for some "special"
use case, but hadn't actually thought about how to word things.

The best thing to do is probably to wait for for kvm_vcpu_map() to be eliminated,
as described in the changelogs for commits:

  357a18ad230f ("KVM: Kill kvm_map_gfn() / kvm_unmap_gfn() and gfn_to_pfn_cache")
  7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")

Once that is done, everything in KVM will either access guest memory through the
userspace hva, or via a mechanism that is tied into the mmu_notifier, at which
point accessing non-refcounted struct pages is safe and just needs to worry about
not corrupting _refcount.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
