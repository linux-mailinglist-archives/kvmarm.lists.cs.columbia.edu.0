Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78714405B47
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 18:50:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29F254B17D;
	Thu,  9 Sep 2021 12:50:06 -0400 (EDT)
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
	with ESMTP id 55IvDaqDvXlP; Thu,  9 Sep 2021 12:50:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A2764B160;
	Thu,  9 Sep 2021 12:50:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EF734B15B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:50:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWn5lZrpJkbg for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 12:50:02 -0400 (EDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9157F4B0E1
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:50:02 -0400 (EDT)
Received: by mail-yb1-f177.google.com with SMTP id a93so5220003ybi.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pZZOGzt5oKbWLt2jfyo0/YulPHEm4sBwR6royMlN8x0=;
 b=NRaEOqyBM610pgGJsqTqL4Gdbp/NB5GTK4jCV/T1gFFYlvThnghqZylNnYIGe3OXV0
 fN1hbhdX7yXdr7kCCk4Tg2v6p0xlI7I1FEEKIu8mquddRmJ3eb5cwNTsoFUeX3108ilX
 cKRAXjtWECHFTSAm3CtzOPse6OECVtJvbuvPiG6jyJbmivIZB1NqupLU/BkMUN5+mxnu
 CBq4ATdHpCeZAPpoihGvjEVhOSQi/jJT9OksS+A7+Ep+BXpE1duD8YRrQnxRoJ8DJO06
 +T02alyunIml6+cqUxAbq2/82O3P2HKjWqBf/p28vKQGkbylTqKv6OOsXgwV+MzRelnV
 fnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pZZOGzt5oKbWLt2jfyo0/YulPHEm4sBwR6royMlN8x0=;
 b=sXI2g00brG9/+o5KvvLmpNT3Lg9YDyE6Gng89KLvjenYMKEmvqZ8ZGhdjHaltfY8Rp
 ANvxZ8xmvyUGlxG7AcjQ9lJjUedl6fz6F762LXWSdDqXFimUuNW6r2OzjspPege1CBdY
 jQz2k2FExfJEVFiTveCfCoZZTIac20EINfDBRofqYZu8w+mOzlJoK//0Jn4LoUbAkPQu
 /6UL+T5uguZB216nHajxs8dRNd+Qg6Tjp0KSVFsD0h8joDPlRgO7ztBn1xJE8GRMGLJV
 6IhFOQMSGgOluEQU3N5+IzsyaXrCfBxgbSPJDWzz0FJnSNEhemKyspd4+pNFbXO44pXq
 1SyA==
X-Gm-Message-State: AOAM533RZoo5S0JvuPyYDtAnT+VD86NWQusQC0eLGSEHjIMXpAGlGxcA
 CCdRiIF21HZZ57Fq4UJAsrVvcYJmq68QylQjk4MOqw==
X-Google-Smtp-Source: ABdhPJzWGqJzOaqHFiOaZZSFb/gHx+W2eWc2XTLC4gq0ldXwPD5pdi5JVNosEBPqyBM7wbyg4V3MzalTA9vcbJP2inM=
X-Received: by 2002:a25:cd82:: with SMTP id d124mr5134084ybf.491.1631206201951; 
 Thu, 09 Sep 2021 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-5-rananta@google.com>
 <20210909070423.5z4eg7wkmswpdi33@gator>
In-Reply-To: <20210909070423.5z4eg7wkmswpdi33@gator>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 9 Sep 2021 09:49:50 -0700
Message-ID: <CAJHc60yU8ihjS9Y1aPOkjv8MpPy0x7=X7kQxnU2aXUjYTe3M7w@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] KVM: arm64: selftests: Introduce
 ARM64_SYS_KVM_REG
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 9, 2021 at 12:04 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:04AM +0000, Raghavendra Rao Ananta wrote:
> > With the inclusion of sysreg.h, that brings in system register
> > encodings, it would be redundant to re-define register encodings
> > again in processor.h to use it with ARM64_SYS_REG for the KVM
> > functions such as set_reg() or get_reg(). Hence, add helper macro,
> > ARM64_SYS_KVM_REG, that converts SYS_* definitions in sysreg.h
> > into ARM64_SYS_REG definitions.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/include/aarch64/processor.h      | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > index bed4ffa70905..ac8b63f8aab7 100644
> > --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> > @@ -26,6 +26,20 @@
> >
> >  #define ID_AA64DFR0_EL1         3, 0,  0, 5, 0
> >
> > +/*
> > + * ARM64_SYS_KVM_REG(sys_reg_id): Helper macro to convert
> > + * SYS_* register definitions in sysreg.h to use in KVM
> > + * calls such as get_reg() and set_reg().
> > + */
> > +#define ARM64_SYS_KVM_REG(sys_reg_id)                        \
> > +({                                                   \
> > +     ARM64_SYS_REG(sys_reg_Op0(sys_reg_id),          \
> > +                     sys_reg_Op1(sys_reg_id),        \
> > +                     sys_reg_CRn(sys_reg_id),        \
> > +                     sys_reg_CRm(sys_reg_id),        \
> > +                     sys_reg_Op2(sys_reg_id));       \
> > +})
>
>
> I don't think we need the ({ }), do we? Anyway,
>
I guess we don't. Must have left it there while I was trying a few
things. Will clean it up.

Regards,
Raghavendra
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
> Thanks,
> drew
>
> > +
> >  /*
> >   * Default MAIR
> >   *                  index   attribute
> > --
> > 2.33.0.153.gba50c8fa24-goog
> >
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
