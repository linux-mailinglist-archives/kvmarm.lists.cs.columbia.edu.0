Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 25E61500B52
	for <lists+kvmarm@lfdr.de>; Thu, 14 Apr 2022 12:42:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9866F4B279;
	Thu, 14 Apr 2022 06:42:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Axss8aXtI+YS; Thu, 14 Apr 2022 06:42:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E890B4B272;
	Thu, 14 Apr 2022 06:42:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21FC84A500
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 17:23:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rOQEXENDFzx9 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Apr 2022 17:23:12 -0400 (EDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D93B54A014
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 17:23:11 -0400 (EDT)
Received: by mail-lf1-f44.google.com with SMTP id x33so5842676lfu.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Apr 2022 14:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dYAKe9Fpp2p080RFNVrX8nvH48ftci+REg/42hZxgoc=;
 b=nwDnkOa38P1VoIYbkttIE0rGKyT3F3PN9ICR23k5xZJPv7udw9nzhaXDpU2MeS+Q6R
 G7n4BMgGJrU+SgepxYg2qU/L3zAcZp/BR8O7GBZue2XuSjQWbNC5WpD71CukDXO7VS47
 slPyPyCa6ui4Ed2YfQAaCRKSHrWb9O2FF4Ct0wgIMqLCkC9AB0qfeiqL5UIBu1n1nP9g
 2gQgXKMoBYcAVFhLVRXIM8v4hv/fuIDBB7gKVHnxZOuRPz9Xz7i1RNFgQf2/Y824xVNP
 WuIhkLkB31k0g5V7iKS+GKCreRt5g5K0vSauR8kYpYufkFG+dbjlKaP/BJLDeM2L0ZIf
 uBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dYAKe9Fpp2p080RFNVrX8nvH48ftci+REg/42hZxgoc=;
 b=o75iahhjijr6xb6ezNSYZXrod+KjRG+T2Aa2TWMDa6GoeyDAdg0GC7u+PxCnjYAusA
 BEj3WBKbqGA2DIgdkvpBStWcyG/HvwSUxGkgVSV792A4+XoQrPJQhOm4P+fA8wJVZKhg
 bTg968ZUUKY7y0W93G4MFIzmdlXFWoqPeXIDgzMxkOTnsMYkW4qU9HjEGs1CRoTXBEeY
 9ExLDodRLHngUNtZ2ZtNnV3pU5sZIPlkyaA0JVSlLg8BI6Mwilfp8HImSA96uEypkGA6
 vUcPTrXb9nxzM76liwkkbvWWPMExIx1uQbUjrgHMC/NKYEq5WSbqdhgm+Vlzn+TADM5o
 1ZDA==
X-Gm-Message-State: AOAM530eb+vLov7CsCux2yIOOvX9s1cSvIup1ehuQO4fKS/hM2AjncCS
 8+8S3nqIJ2W6BNUhZiX+7sO3G/o0rNvB4z4oUSjt/w==
X-Google-Smtp-Source: ABdhPJzr3FVsm7oEAVBg9PQFhteEP/ns+lhODUER5Jh8hvabbPpL5e0XXIARvqMywuPMVxDtDEKCm0Sos0EVpgJ0wu4=
X-Received: by 2002:a05:6512:21cd:b0:46b:b89e:186c with SMTP id
 d13-20020a05651221cd00b0046bb89e186cmr7223606lft.250.1649884990280; Wed, 13
 Apr 2022 14:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220401175554.1931568-1-dmatlack@google.com>
 <YlRhiF1O71TWQr5r@google.com>
 <CALzav=f_WY7xH_MV8-gJPAVmj1KjE_LvXupL7aA5n-vCjTETNw@mail.gmail.com>
 <YlSLuZphElMyF2sG@google.com>
 <CALzav=fGucZOZjbVE2+9PZVf1p+jP7GBYDpPph5PoU552LELsw@mail.gmail.com>
 <YlTKQz8HVPtyfwKe@google.com>
 <CALzav=dz8rSK6bs8pJ9Vv02Z7aWO+yZ5jAA8+nmLAtJe3SMAsA@mail.gmail.com>
 <YlYhO7GvjKY1cwHr@google.com> <YlcPIYJ0CB2qnfpT@google.com>
 <YlcWP5Z3osvUg0Ia@google.com>
In-Reply-To: <YlcWP5Z3osvUg0Ia@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 13 Apr 2022 14:22:43 -0700
Message-ID: <CALzav=cg32bxLwCJKG0vBfgKRSXoHmeRnA-NOYC0Px7BsMgfGw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] KVM: Extend Eager Page Splitting to the shadow
 MMU
To: Sean Christopherson <seanjc@google.com>
X-Mailman-Approved-At: Thu, 14 Apr 2022 06:42:33 -0400
Cc: Marc Zyngier <maz@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <kvm@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR MIPS \(KVM/mips\)"
 <linux-mips@vger.kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR RISC-V \(KVM/riscv\)"
 <kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Ben Gardon <bgardon@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Peter Feiner <pfeiner@google.com>
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

On Wed, Apr 13, 2022 at 11:28 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Apr 13, 2022, David Matlack wrote:
> > On Wed, Apr 13, 2022 at 01:02:51AM +0000, Sean Christopherson wrote:
> > > There will be one wart due to unsync pages needing @vcpu, but we can pass in NULL
> > > for the split case and assert that @vcpu is non-null since all of the children
> > > should be direct.
> >
> > The NULL vcpu check will be a little gross,
>
> Yeah, I would even call it a lot gross :-)
>
> > but it should never trigger in practice since eager page splitting always
> > requests direct SPs. My preference has been to enforce that in code by
> > splitting out
>
> It still is enforced in code, just at different points.  The split version WARNs
> and continues after finding a page, the below WARNs and rejects _while_ finding
> the page.
>
> Speaking of WARNs, that reminds me... it might be worth adding a WARN in
> kvm_mmu_get_child_sp() to document (and detect, but more to document) that @direct
> should never encounter an page with unsync or unsync_children, e.g.
>
>         union kvm_mmu_page_role role;
>         struct kvm_mmu_page *sp;
>
>         role = kvm_mmu_child_role(sptep, direct, access);
>         sp = kvm_mmu_get_page(vcpu, gfn, role);
>
>         /* Comment goes here about direct pages in shadow MMUs? */
>         WARN_ON(direct && (sp->unsync || sp->unsync_children));
>         return sp;
>
> The indirect walk of FNAME(fetch)() handles unsync_children, but none of the other
> callers do.  Obviously shouldn't happen, but especially in the huge page split
> case it took me a second to understand exactly why it can't happen.

Will do.

>
> > but I can see the advantage of your proposal is that eager page splitting and
> > faults will go through the exact same code path to get a kvm_mmu_page.
> > __kvm_mmu_find_shadow_page(), but I can see the advantage of your
> > proposal is that eager page splitting and faults will go through the
> > exact same code path to get a kvm_mmu_page.
> >
> > >
> > >             if (sp->unsync) {
> > >                     if (WARN_ON_ONCE(!vcpu)) {
> > >                             kvm_mmu_prepare_zap_page(kvm, sp,
> > >                                                      &invalid_list);
> > >                             continue;
> > >                     }
> > >
> > >                     /*
> > >                      * The page is good, but is stale.  kvm_sync_page does
> > >                      * get the latest guest state, but (unlike mmu_unsync_children)
> > >                      * it doesn't write-protect the page or mark it synchronized!
> > >                      * This way the validity of the mapping is ensured, but the
> > >                      * overhead of write protection is not incurred until the
> > >                      * guest invalidates the TLB mapping.  This allows multiple
> > >                      * SPs for a single gfn to be unsync.
> > >                      *
> > >                      * If the sync fails, the page is zapped.  If so, break
> > >                      * in order to rebuild it.
> > >                      */
> > >                     if (!kvm_sync_page(vcpu, sp, &invalid_list))
> > >                             break;
> > >
> > >                     WARN_ON(!list_empty(&invalid_list));
> > >                     kvm_flush_remote_tlbs(kvm);
> > >             }
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
