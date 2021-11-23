Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 710B845996C
	for <lists+kvmarm@lfdr.de>; Tue, 23 Nov 2021 01:52:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D22524B17B;
	Mon, 22 Nov 2021 19:52:04 -0500 (EST)
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
	with ESMTP id 3f11dPgvf8qQ; Mon, 22 Nov 2021 19:52:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90E9D4B172;
	Mon, 22 Nov 2021 19:52:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 485004B16C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 19:52:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SCSQBKNqd8P2 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Nov 2021 19:52:01 -0500 (EST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1F38B49DE7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 19:52:01 -0500 (EST)
Received: by mail-pf1-f176.google.com with SMTP id i12so17689399pfd.6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 16:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U8wVUqAGerxKdyql8K3cQpZeIXWsZUSoHk+rQSQu8dQ=;
 b=lGN8M+8oQF0Hjs4njXU12qJ0QTEbrLTpdd9PGYmqJsG+hVHBDnY0wLf/3ow5s17ApQ
 4p0nPHvvB49y+9AC6f3x7F9CqWBJW7GLmN42yml1mvQ5ItTxYmEtSugGIKSyAe/jLLKl
 j0qtH2g1/MkWlltsehxN3jKJyhXaGg85cNQaJEX5onIL59dJqtEjl7vJbvxzcWpAKBMf
 C07Tez1lwA1jq4p8ZoaP8CwwXJHAOIIC4F57STxdUDow6OVt0esTkiVGAuG9If4uZyOd
 H4YYvSM87+z6xufGwEmMFxTWljQDXtDoyKkS2FqS00upycbkwBAxMPy7KMeGtX+yGhCn
 i+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U8wVUqAGerxKdyql8K3cQpZeIXWsZUSoHk+rQSQu8dQ=;
 b=jdgr71gyLF6G0jFaOUXk2AL5WdhL9j1p5VpmY51x0iAGSqy7CHLIgHrXN2ah9RPcVo
 D+bFiSp//vUpUHT5BprOuu0JRdoBCDXa5KvkadxRtCBecc97h4yrkTtQXWTKMksJK1GO
 PyX1Bl2hDq+9ZwuWy42B5OcJPd6/ggH0Zv4SrfOzbh4i0x2FJWGRP2RweYFlhWLp6s0A
 CG5WQsYq31vBdMUCeokaT180MWDdjatQimJN4FjpsFT0C3Ja97Ji+CG/3U0YCY4YFbEy
 TWEV5fGpvplFou3VUK93sgryyj2//OPGZhiHMoKtzCTRpS2tiV1GsccgYr93fdovJ5c1
 kkEg==
X-Gm-Message-State: AOAM530LPdFkqgrm14dTfD7oxw+PXtwUDez4IK74VsokjMVdpmGbQLI9
 RL47u3QGatwwqKsHQOOCZl5AwT+A3kFboVT5SeKpdg==
X-Google-Smtp-Source: ABdhPJyubfAEVgA+QQrnFhtEtO0iS8FLlQEPm5gaAFwunjtCJUIDZnMl618fjlYHTqqeIy4H0Mr1zygLiMBuKOx1xWU=
X-Received: by 2002:a63:6ec7:: with SMTP id j190mr855827pgc.395.1637628719955; 
 Mon, 22 Nov 2021 16:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
 <20211117064359.2362060-2-reijiw@google.com>
 <87mtlxsn1l.wl-maz@kernel.org>
In-Reply-To: <87mtlxsn1l.wl-maz@kernel.org>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 22 Nov 2021 16:51:44 -0800
Message-ID: <CAAeT=Fy2XudkVuLJwwvDop7cWeXdaMevjbCAyMd5O6Y5DcHwcg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/29] KVM: arm64: Add has_reset_once flag for vcpu
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Sun, Nov 21, 2021 at 4:36 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 17 Nov 2021 06:43:31 +0000,
> Reiji Watanabe <reijiw@google.com> wrote:
> >
> > Introduce 'has_reset_once' flag in kvm_vcpu_arch, which indicates
> > if the vCPU reset has been done once, for later use.
>
> It would be nice if you could at least hint at what this flag is going
> to be used for, as being able to reset a vcpu as often as userspace
> wants it is part of the KVM ABI.

I will update the description.


> > Signed-off-by: Reiji Watanabe <reijiw@google.com>
> > Reviewed-by: Oliver Upton <oupton@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 2 ++
> >  arch/arm64/kvm/reset.c            | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 2a5f7f38006f..edbe2cb21947 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -385,6 +385,7 @@ struct kvm_vcpu_arch {
> >               u64 last_steal;
> >               gpa_t base;
> >       } steal;
> > +     bool has_reset_once;
>
> Why can't this be a new flag (part of the vcpu->arch.flags set) rather
> than a discrete bool?

Thank you for the suggestion ! I will fix it to use vcpu->arch.flags.

Regards,
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
