Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A320648C26
	for <lists+kvmarm@lfdr.de>; Sat, 10 Dec 2022 02:07:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EBD24B8D2;
	Fri,  9 Dec 2022 20:07:49 -0500 (EST)
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
	with ESMTP id fGJvpbFDrxtu; Fri,  9 Dec 2022 20:07:49 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 023E24B8D8;
	Fri,  9 Dec 2022 20:07:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 579624B8D2
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Dec 2022 20:07:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wpXXeQHQO+0P for <kvmarm@lists.cs.columbia.edu>;
 Fri,  9 Dec 2022 20:07:45 -0500 (EST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 228434B845
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Dec 2022 20:07:45 -0500 (EST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-3b10392c064so73967407b3.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 09 Dec 2022 17:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2GE1P9MKB5IEXA78EjWjeGIw+fkI4b001mr77BECX4=;
 b=Zz3MbiPPY1SHgc009qCyxMWHtFmspb6G3A0xzYMbttsp31nw0tSX4tppfrsPzNCIF6
 D7iZa+LTmezBYiYDtrAmYb1oC/fxxbCFXDl2x8spANHzzlsqXtea4DYwT5ZwgelbohYZ
 089wInVCX/E1aq3PKr5hxN9tOHp0A9lXSiHrUb2tvZFE38B1gNZClvkVFMpcr2O4jVlr
 9bJlXy7+oFG62lvofRFDdTYYtZ7NVMOdXK6E5CeH1XdzyTgiFtvIInk1zIkAc8vPoxQI
 9f4u+ARi+JH2GcPIweLO4Jw0BwgiylZumo9BqAOOnhTCwihz86Bnx7mwqeF8hZA9e/Yn
 C+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2GE1P9MKB5IEXA78EjWjeGIw+fkI4b001mr77BECX4=;
 b=ZQzMZ0pofmJGYR4L8HMbBcE+QH0LXPihVPOqfVZRWcShBiQrdPxNLhVedponTJbSk/
 AWUyN46pDsyiu+rWGKyAXx5otYX9FsCH/xkLYwo0/C2AbdJklAJ+oE96wfE1DPbMnmHc
 uPH/w9W3R6jnKeJMPorlKSDg20W6HU4b4nFfsw7eY7Pj+29mKjixrQXgusFyCK1vkQu0
 yrdm0t6Tw0mE1Vve67xoqs0rSWIKa9tbHlwNRon3SGPMiCRr44tci8IR4hFwRHnTUvfH
 VL9DMZabUgyurZS41OOXgkdq534TbLtAfpjw9+MVo+xP19HpxhkOgmmUmBbJE66q1L5z
 UdfA==
X-Gm-Message-State: ANoB5plKbwXZQlwunTrNTf0efX/nQdUfNjoE2XpTB2u5dv5ljkzOxRA6
 uFj4p2rhOus76h0TzRL/Zaf6hacukAIsTXeUHhJusQ==
X-Google-Smtp-Source: AA0mqf7NPTsewklw8WtJjMQ5b4Z4DLLXvnPd6MTLSGVUxVce2NMxMIFrAkSkhyQdcwqQG9PUK7aUBAXAR0abljqhaUo=
X-Received: by 2002:a81:1401:0:b0:3b0:b9aa:46eb with SMTP id
 1-20020a811401000000b003b0b9aa46ebmr2248873ywu.150.1670634464404; Fri, 09 Dec
 2022 17:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20221208193857.4090582-1-dmatlack@google.com>
 <Y5OHVzBSHPmAq2FO@google.com>
In-Reply-To: <Y5OHVzBSHPmAq2FO@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 9 Dec 2022 17:07:18 -0800
Message-ID: <CALzav=c328M1jgApAEEnz5B6h_pr5w07VpcMx0kSg0MtJjAf2w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/37] KVM: Refactor the KVM/x86 TDP MMU into common
 code
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Hugh Dickins <hughd@google.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Nadav Amit <namit@vmware.com>, Ben Gardon <bgardon@google.com>,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 Yu Zhao <yuzhao@google.com>, xu xin <cgel.zte@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mingwei Zhang <mizhang@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, kvm@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, kvmarm@lists.linux.dev,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 Colin Cross <ccross@google.com>, kvm-riscv@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Fri, Dec 9, 2022 at 11:07 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> On Thu, Dec 08, 2022 at 11:38:20AM -0800, David Matlack wrote:
>
> >    Also do we want to keep "TDP" or switch
> >    to something more familiar across architectures (e.g. ARM and RISC-V
> >    both use "Stage-2")?
>
> As it relates to guest memory management I don't see much of an issue
> with it, TBH. It is sufficiently arch-generic and gets the point across.
>
> Beyond that I think it really depends on the scope of the common code.
>
> To replace the arm64 table walkers we will need to use it for stage-1
> tables.

Speaking of, have ARM folks ever discussed deduplicating the KVM/ARM
stage-1 code with the Linux stage-1 table code (<linux/pgtable.h>),
which is already architecture-neutral? It seems backwards for us to
build out an architecture-neutral stage-1 walker in KVM when one
already exists.

For example, arch/arm64/kvm/mmu.c:get_user_mapping_size() looks like
it could be reimplemented using <linux/pgtable.h>, rather than using
KVM code. In fact that's what we do for walking stage-1 page tables in
KVM/x86. Take a look at
arch/x86/kvm/mmu/mmu.c:host_pfn_mapping_level(). I bet we could move
that somewhere in mm/ so that it could be shared across KVM/x86 and
KVM/ARM.

> I'm only hand-waving at the cover letter and need to do more
> reading, but is it possible to accomplish some division:
>
>  - A set of generic table walkers that implement common operations, like
>    map and unmap. Names and types at this layer wouldn't be
>    virt-specific.
>
>  - Memory management for KVM guests that uses the table walker library,
>    which we can probably still call the TDP MMU.
>
> Certainly this doesn't need to be addressed in the first series, as the x86
> surgery is enough on its own. Nonetheless, it is probably worthwhile to
> get the conversation started about how this code can actually be used by
> the other arches.

Yup, we'll need some sort of split like that in order to integrate
with KVM/ARM, since the hyp can't access struct kvm, work_queues, etc.
in tdp_mmu.c. I don't think we'll need that split for KVM/RISC-V
though. So for the sake of incremental progress I'm not planning on
doing any of that refactoring preemptively. Plus it should be possible
to keep the TDP MMU API constant when the internal implementation
eventually gets split up. i.e. I don't forsee it creating a bunch of
churn down the road.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
