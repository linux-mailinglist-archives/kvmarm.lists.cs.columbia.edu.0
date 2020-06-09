Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 544FD1F339C
	for <lists+kvmarm@lfdr.de>; Tue,  9 Jun 2020 07:50:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3A114B324;
	Tue,  9 Jun 2020 01:50:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHgZhhK8+sgP; Tue,  9 Jun 2020 01:50:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 882F64B323;
	Tue,  9 Jun 2020 01:50:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ED074B1E6
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 01:50:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U1FHOBYV+IFs for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Jun 2020 01:50:04 -0400 (EDT)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 782334B1E1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jun 2020 01:50:04 -0400 (EDT)
Received: by mail-lj1-f195.google.com with SMTP id z9so23416529ljh.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 08 Jun 2020 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ah+aeQSeEg5P4OMAYacjb8+q3xAvNvQ9olw2DrYoaAU=;
 b=MypTK4vB6YrUsHDK25PEjJZfnQJeszo1CcmFwXWsUie961BemDwBxuO/4YA4uU+l8X
 bohRLRY4YR0noKJT1usbkgu7htphqeAwSmMkGqdkKPb5z2rdVLdKTkLuAoYxF3ymjG5s
 lhpVjqOu0A16AFYkGPBNJUEd9lUIuCvmcDRtIAzLJAgYgfzcjdFtJVqRPKnVSql9inDd
 N87+hupQqXl3AO5T3jAoqg8yIS08Cc5reSdlhysN6KEi0IdlcgHy0Qul7XbgjGdQMLOw
 nFNUeC+XCdy0IeydEIGH7qLnDRe7d0WWsixG6i6nr/DYJTfM+s0vypN6BPsZxnPFzt6v
 MhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ah+aeQSeEg5P4OMAYacjb8+q3xAvNvQ9olw2DrYoaAU=;
 b=iU5YY9ZfHJZw24P9n4YUGgJBeJEZMBGR6ET+CLsPIuqS1obLmnhqMYpDRYdymvPtiS
 lQvkt2zjbhbyF+HKDpNayD+aFx7c7ftnuYvq2hzmLOrlB2MSFECDohgDKFxadm1qCIQL
 +3jx8o1pJ035S/jKfFTPtAI4VsM7/0PzsS3GNU6PW6RaGyQK3mtVplOJJd5sZrNTHtxf
 uaTvygtbXPSkqdebAlnlwNhrRP72DuQ/5gVh6om3+q2rV2veNVnDH6M7in4ky5TLTEHk
 3nA++Jx+b1RWu74S4KvjcMbA+PvRjAWzE9TZUmjAxnXbOJNFW6+H0BkXQGoYMc5TyQfZ
 TTVQ==
X-Gm-Message-State: AOAM533Ijs+1YUncWj6VIHpUAEQnmY8XgwIs2H7wrFCmi9EUV17dvTZ7
 5pSFVYjqvu2Y8BniOc/kkI1jFVhnyjZ2PuQmGiw=
X-Google-Smtp-Source: ABdhPJwFnmc6C/4VIDhIDt/D05CzgBc/RihqA8NJFyU7GjDiuGlWV5JlwrrVOjPkirGzJpKlNb1msirFNnXoCUgb/eg=
X-Received: by 2002:a2e:800c:: with SMTP id j12mr11939278ljg.218.1591681802924; 
 Mon, 08 Jun 2020 22:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=Ncrb80uS5wtAu6e1Gctnu8tjcBEpWd7zHJv7aHdEkipe2FQ@mail.gmail.com>
 <7d05e422cb61296fe372e0de3f1602b2@kernel.org>
In-Reply-To: <7d05e422cb61296fe372e0de3f1602b2@kernel.org>
From: Janne Karhunen <janne.karhunen@gmail.com>
Date: Tue, 9 Jun 2020 08:49:51 +0300
Message-ID: <CAE=Ncrbx+2tJEAZryLLchgyiCBWuVeSCTFv4rSz=RsKvMAP6aw@mail.gmail.com>
Subject: Re: randomly firing kvm_arch_timer_handler
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.cs.columbia.edu
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

On Thu, Jun 4, 2020 at 3:37 PM Marc Zyngier <maz@kernel.org> wrote:

> > I have an issue on one particular hardware with gicv3 and the old
> > stable (4.9.22x) kernel where the timer interrupt randomly leaks to
> > the host after the guest exit and the kvm_arch_timer_handler gets
> > triggered. The guest does run, but the whine (unexpected interrupt) is
> > annoying and it seems to be hindering the performance drastically - of
> > both the host and the guest. This behavior can even lead to the host
> > watchdog biting as the firing timer prevents the progress, especially
> > during the very early boot when the guest is doing heavy paging
> > anyway.
>
> The only system I witnessed this was a Cavium TX1. It seems incredibly
> bad at retiring an interrupt that has been masked at the source.

Looks like something like this works as a workaround. On guest exit
lift the timer value prior to turning it off (setting happens
atomically even if the timer retire does not) and then backport the
irq disable logic from the newer kernels into the host irq handler:

+       if (kvm_timer_should_fire(vcpu))
+               kvm_timer_update_irq(vcpu, true);
+
+       timer = &vcpu->arch.timer_cpu;
+       if (timer->irq.level)
+               disable_percpu_irq(irq);
+       else
+               enable_percpu_irq(irq, 0);

Now the hits are still happening, but very, very rarely.


--
Janne
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
