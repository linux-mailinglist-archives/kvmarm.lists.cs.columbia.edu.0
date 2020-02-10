Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C18CE157EC8
	for <lists+kvmarm@lfdr.de>; Mon, 10 Feb 2020 16:32:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3854A4A59B;
	Mon, 10 Feb 2020 10:32:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@lixom-net.20150623.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A+JbgA8OKlIk; Mon, 10 Feb 2020 10:32:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F2B44A946;
	Mon, 10 Feb 2020 10:32:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D7AE4A551
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 10:32:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1rirN8aOIl6p for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Feb 2020 10:32:00 -0500 (EST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 626A84A50F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 10:32:00 -0500 (EST)
Received: by mail-il1-f194.google.com with SMTP id p8so523757iln.12
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rJKu0curXNDiIv07BXA7ZVrF2bICC0+Hs2nUqvpWWBE=;
 b=CAXc09ubXS9ZFxUmd/SbvlfA3zsu6fw84nPAia6Y37IBnkkixzVnQQ1DvPc4gVvSDy
 W6Uq5WrNvmHIM9pR9ez7FYUhIv6XdEX9GEwY2rJl2vY33gTufoWhbjwUcACu+BIPxG5G
 bAgK1f8xNqN/VhPHCmGFF+SDEbTzUji36h+YGdbhQmDJdX3HrBJ3fQ7RFH6TSmczTUaI
 l8Lh7ZdUVtAyloybvuqg1r1VSaZqNUt/8vLmi/SyTQGmfdOyC29Tgxf2X4u9kYNOUF8c
 D8wdvnGGssR7+hgN4BP19DR9Am1ylWfvoMD4pA/mEq3/e3yQTNmVwZHuB6JEdy2D62Br
 iXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rJKu0curXNDiIv07BXA7ZVrF2bICC0+Hs2nUqvpWWBE=;
 b=C5XYGF+cRpTa0ul1WYP6hk3PzE9hDNJKt++1ylZqSCU+JiRVmCo46EaZTpWhvxbpPh
 a3bpKNzjURHwyPLB3EAScT779eYdtmIDiVn0FC95g+1iIEA72UGcgRDO6QcC1dpdKBH6
 we5G2B6Iv/jawWlZ7lfb+3YX5leZOBJ9KRnCDYHpn8dumFC61O+Yg1ioayZvMJUs1GP5
 84p6a1UcM9yVdfe+VYa1DTq2KxSkNY2+AW4nBwh/455EJ/iGosQxsPOrXzkky3zyGtBR
 QnIRKmFe45MqctewQvKPminOojsQ5st5GtwucR0M6eu65ejRfhJ00TuYg41cQWJ91+r0
 yGOw==
X-Gm-Message-State: APjAAAWMCelrI5m86Fk+8VWs36UJ23kyqBZQXY05PCPJADnzMZ4Q1aTT
 Co+CSqVh1ysSdEPfVJmCPAYuok1KxRDS6Cn+ZBv98A==
X-Google-Smtp-Source: APXvYqxYx29kgSFceIBbFGWRItTIbjo6m8Fbpp5JsPt65w5bFXVn9ceiixXHhUS3KHfAZHhdKoQKoj4ONXPF4oZheGk=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr1986348ili.72.1581348719752; 
 Mon, 10 Feb 2020 07:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20200210141324.21090-1-maz@kernel.org>
In-Reply-To: <20200210141324.21090-1-maz@kernel.org>
From: Olof Johansson <olof@lixom.net>
Date: Mon, 10 Feb 2020 16:21:42 +0100
Message-ID: <CAOesGMhHkez-5vxwWuzXc2Rm=dYYWjMX9C8AewVy9GDWuZcwMw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Removing support for 32bit KVM/arm host
To: Marc Zyngier <maz@kernel.org>
Cc: Anders Berg <anders.berg@lsi.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Mon, Feb 10, 2020 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> KVM/arm was merged just over 7 years ago, and has lived a very quiet
> life so far. It mostly works if you're prepared to deal with its
> limitations, it has been a good prototype for the arm64 version,
> but it suffers a few problems:
>
> - It is incomplete (no debug support, no PMU)
> - It hasn't followed any of the architectural evolutions
> - It has zero users (I don't count myself here)
> - It is more and more getting in the way of new arm64 developments
>
> So here it is: unless someone screams and shows that they rely on
> KVM/arm to be maintained upsteam, I'll remove 32bit host support
> form the tree. One of the reasons that makes me confident nobody is
> using it is that I never receive *any* bug report. Yes, it is perfect.
> But if you depend on KVM/arm being available in mainline, please shout.
>
> To reiterate: 32bit guest support for arm64 stays, of course. Only
> 32bit host goes. Once this is merged, I plan to move virt/kvm/arm to
> arm64, and cleanup all the now unnecessary abstractions.
>
> The patches have been generated with the -D option to avoid spamming
> everyone with huge diffs, and there is a kvm-arm/goodbye branch in
> my kernel.org repository.
>
> Marc Zyngier (5):
>   arm: Unplug KVM from the build system
>   arm: Remove KVM from config files
>   arm: Remove 32bit KVM host support
>   arm: Remove HYP/Stage-2 page-table support
>   arm: Remove GICv3 vgic compatibility macros

Since I'm generally happy to drop legacy code that has no users, with
the "if there are any significant users that speak up, I'll revoke my
support" caveat:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
