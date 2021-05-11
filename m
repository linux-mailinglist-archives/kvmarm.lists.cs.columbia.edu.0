Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 316B737A1AA
	for <lists+kvmarm@lfdr.de>; Tue, 11 May 2021 10:23:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B9F784B499;
	Tue, 11 May 2021 04:23:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ShE4cF2DGLi2; Tue, 11 May 2021 04:23:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 982EF4B490;
	Tue, 11 May 2021 04:23:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05FFF4B3BC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 04:23:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C+jRyL+om3s2 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 May 2021 04:23:14 -0400 (EDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CFB6B4B396
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 04:23:14 -0400 (EDT)
Received: by mail-oi1-f180.google.com with SMTP id i81so18334719oif.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=045C15kVflz7mRdOnafmMq48e1iREZTBgktY8+UlBLQ=;
 b=usBH1qyQQe6ZPzFOrrb23X7llSmuVyi8/ugogrn0DiiqOcFmN5N23A+vwiQzhraS8I
 hDBFZmOD7bPeKqMqZo8QrZdYiEYJr1dbhBe6sko2QRH/zx40XZY3GPkkwPl9UxjZFfn4
 0KdaSoHhakKATnZ5BycuKM7nP2yysbq/lXMJKS17VMx+LyOE4cGhILRdTMmMrIFtAVYt
 yLBpIZWcHgRzF08cwsvWrAiAKGtuftRwOnihWAWz5XF1DSmZR9uz8gd1yhW/ry9sz9L8
 Fmf4BSKwOUGW2fBXegpREPe1+1QFb/nQomxM6kms+RmBvRLY5QXpBdgbdcBRgL89xVHx
 oBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=045C15kVflz7mRdOnafmMq48e1iREZTBgktY8+UlBLQ=;
 b=Cz0hdx9SqsFGoitmZOuQcuTh7kRvR0XE1cSh2HlO7wAMuQcGL0N744GRKZFIYH6bHz
 J3nbsHGmfX1GXsFwfjqc5SOR+y/qNu+AzxMIzUqWH/YPTOB2cuKAV/qwZRCb0iPqAfpR
 lKbGCye9T0Ow96MlM0OMkfj3Dvy91KQJnCT184AM1NtrkSRbNDCN14ItlMKRHcH96Y3a
 a68HNgszKsd7lgJB1kOBakWW/hKMlCDYAfX53brikYoChZdAAqSZmU1Xy/MUe4RC51nU
 Jc8fdvSbJ+K173wSepYdVa6KG16viPWJnsyq5XBEZxWjqyQmiQM9X9r0Rr4gVG3zaQO1
 JGMA==
X-Gm-Message-State: AOAM531joj3R+8/NYF3i0T7OMzTFDFGn8Q8DVCJlpYOJIqHW7jWAKIEf
 46jL9WQNUj9jnwTlA/atuO6r6R4RFjq0dq3MIbEtNw==
X-Google-Smtp-Source: ABdhPJzIB4t03lWKbmxy3jCJsw9fAeIDQrCq1mc5kl0akqAeREBctE/IihK/+/BJ2lGPo6x8xW+oBaVTt8h+WzRQsHw=
X-Received: by 2002:aca:f5c7:: with SMTP id t190mr2559324oih.67.1620721393989; 
 Tue, 11 May 2021 01:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210510094915.1909484-1-maz@kernel.org>
 <20210510094915.1909484-3-maz@kernel.org>
 <CA+EHjTzcfmt4mxh05a_P+nheQ_A2FuXhpgvKXuV5__pZP0SxkA@mail.gmail.com>
 <871radvg9n.wl-maz@kernel.org>
In-Reply-To: <871radvg9n.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 11 May 2021 09:22:37 +0100
Message-ID: <CA+EHjTzoWYhgVjURzi9V8nGQO5DOimgGKv7gQcfrRgd-Gf2j2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Commit pending PC adjustemnts before
 returning to userspace
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Marc,


On Tue, May 11, 2021 at 9:14 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Fuad,
>
> On Tue, 11 May 2021 09:03:40 +0100,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > Hi Marc,
> >
> > > KVM: arm64: Commit pending PC adjustemnts before returning to userspace
> >
> > s/adjustments/adjustments
>
> Looks like Gmail refuses to let you mimic my spelling mistakes! :D
>
> >
> > On Mon, May 10, 2021 at 10:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > KVM currently updates PC (and the corresponding exception state)
> > > using a two phase approach: first by setting a set of flags,
> > > then by converting these flags into a state update when the vcpu
> > > is about to enter the guest.
> > >
> > > However, this creates a disconnect with userspace if the vcpu thread
> > > returns there with any exception/PC flag set. In this case, the exposed
> > > context is wrong, as userpsace doesn't have access to these flags
> > > (they aren't architectural). It also means that these flags are
> > > preserved across a reset, which isn't expected.
> > >
> > > To solve this problem, force an explicit synchronisation of the
> > > exception state on vcpu exit to userspace. As an optimisation
> > > for nVHE systems, only perform this when there is something pending.
> >
> > I've tested this with a few nvhe and vhe tests that exercise both
> > __kvm_adjust_pc call paths (__kvm_vcpu_run and
> > kvm_arch_vcpu_ioctl_run), and the tests ran as expected.  I'll do the
> > same for v2 when you send it out.
>
> Ah, that's interesting. Do you have tests that actually fail when
> hitting this bug? Given that this is pretty subtle, it'd be good to
> have a way to make sure it doesn't crop up again.

Nothing that fails, just code that generates exceptions or emulates
instructions at various points. That said, I think it should be
straightforward to write a selftest for this. I'll give it a go.

/fuad

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
