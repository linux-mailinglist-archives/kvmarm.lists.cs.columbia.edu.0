Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD59B405B1A
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 18:42:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 472824B167;
	Thu,  9 Sep 2021 12:42:31 -0400 (EDT)
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
	with ESMTP id U9hIGX72678L; Thu,  9 Sep 2021 12:42:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47C954B126;
	Thu,  9 Sep 2021 12:42:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AAC1B4066E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:42:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1n1Ab7SenpNA for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 12:42:27 -0400 (EDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com
 [209.85.219.176])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9799C405A6
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 12:42:27 -0400 (EDT)
Received: by mail-yb1-f176.google.com with SMTP id c6so5113322ybm.10
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrZuPjCWVQei2hd5TDze97f6NPaJL6ui4tNC7eiVKwg=;
 b=jGcmb5hbR4l+02tTppChZrB5upTNg//Nka7dpsrOEijk0J1X2X+D/NqH66FmMzewXT
 OJWjExeSkG1Hy6H9vzjhlErhjmpKe4y83gbr20jwrR6r7dlISolwMNML2hd5PNE1uBuD
 bQ4X3mgbfSsVUu8/hAY3BY6plretWRWi7U8EzbkxjEC+BZ6Yr5GDLDGi4OEYBQkj0fxZ
 WhBGCoX3mtKxn8yDhth/YJVISfiBUVOBHrSiZWG8RLsb64wBybXnoEzboBQ+fkNngvZZ
 s7kq04sSh9lLJpbBWPoRRkuIDnniaDVgXZQEP7A5TwEimgeeRN6ZIhq1ZhRK61BwF1lK
 sZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrZuPjCWVQei2hd5TDze97f6NPaJL6ui4tNC7eiVKwg=;
 b=RL0fiQPorDPys90/TEXBu2OfMqJGtUFmr+SbT5gH93Nn4VKTcDw6RgnQsKR/Pucu6q
 fiELBRopt4x358Jw/HOcffukgRgOEYQXKYqHMwk8A9avXySyDYCK44LlNLXvex+BmPPZ
 x+TgrgkIJc2+OrXURJ7gCkdjMYby1DUW7nKAsAV8KzcU0XjilRvvG0b+Ts7qwoWe7J7Y
 GNbMVDEEjBziI1PbBrju3jFbcBUx0TzsU2aaWeDO+wJS7r/Tj/HUe9HgwlfX2duip2ep
 fWNBc6BGADEkAD9GHADTypWVG+tUu9gvj6ochcgCwY68INs688PWR4WXWu6EuG93Koy0
 vh6A==
X-Gm-Message-State: AOAM531jG3uYkF3m8rJgF/QHpFbwbQHGR6QRIf3zokTT9GNROEjhSet8
 wU1RSGojsUIJkc7g8d+5N/dlKUmStQiDbQ3WapDHHg==
X-Google-Smtp-Source: ABdhPJxUfv2OiYmJzLbjvFvpiM3on92xSiPiWN63qMNZXpuT/lL9Yvzo1kzzotX3Jfc71OoRLpnPsZqr+apdMwCxiAk=
X-Received: by 2002:a25:424a:: with SMTP id p71mr5281009yba.243.1631205747023; 
 Thu, 09 Sep 2021 09:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-3-rananta@google.com>
 <CAOQ_Qsh=F-tTre_ojiLXUfAriH-coTF_gXCcLyRb3kKM+LLhQA@mail.gmail.com>
 <20210909065338.ulh32fqi4e6gnh2o@gator>
In-Reply-To: <20210909065338.ulh32fqi4e6gnh2o@gator>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 9 Sep 2021 09:42:15 -0700
Message-ID: <CAJHc60zoCVpG+zx_G8fSCcg+wXaigFZFGA=wLZCAsETag+YJfA@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] KVM: arm64: selftests: Add sysreg.h
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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

On Wed, Sep 8, 2021 at 11:53 PM Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Sep 08, 2021 at 10:47:31PM -0400, Oliver Upton wrote:
> > Hi Raghu,
> >
> > On Wed, Sep 8, 2021 at 9:38 PM Raghavendra Rao Ananta
> > <rananta@google.com> wrote:
> > >
> > > Bring-in the kernel's arch/arm64/include/asm/sysreg.h
> > > into selftests to make use of all the standard
> > > register definitions in consistence with the kernel.
> > >
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > ---
> > >  .../selftests/kvm/include/aarch64/sysreg.h    | 1278 +++++++++++++++++
> > >  1 file changed, 1278 insertions(+)
> > >  create mode 100644 tools/testing/selftests/kvm/include/aarch64/sysreg.h
> >
> > This belongs in tools/arch/arm64/include/asm/sysreg.h, I believe.
> >
>
> Yes, that's also where I expected it to land.
>
Sure, that makes sense. I'll move it there.

Regards,
Raghavendra
> Thanks,
> drew
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
