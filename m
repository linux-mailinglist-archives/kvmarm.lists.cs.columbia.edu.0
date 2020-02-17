Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C8160776
	for <lists+kvmarm@lfdr.de>; Mon, 17 Feb 2020 01:14:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 355964AF2D;
	Sun, 16 Feb 2020 19:14:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKkhUp9zTxKm; Sun, 16 Feb 2020 19:14:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DBAB4AF27;
	Sun, 16 Feb 2020 19:14:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D6474AF25
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 19:14:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7KgLUrQqMzv for <kvmarm@lists.cs.columbia.edu>;
 Sun, 16 Feb 2020 19:14:36 -0500 (EST)
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5E2644AED5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 19:14:36 -0500 (EST)
Received: by mail-lf1-f68.google.com with SMTP id y19so10525485lfl.9
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 16:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+IGQ44b8ehFgo9r1oz6MUXO7lMciX3lsO+/mrOD8lKs=;
 b=wNohhz24KyweaPRjF/ZHHazpqKxyZNG6eY/v2jPjEqflMXmdDA87blQaYxRrP52OhY
 oJTM4/wtKG7H+a1O638elj6pNxgX47boYHKawJBnthqWtfiyVZ4wjeYuZUgaNoFf6tmj
 OHix6PBfxoL2v75rtEk7TggEjhdRlnRIJocJs3QyjXC4ZKEUJVV6f2w4afRH/JV620mr
 SiiSqZLcMoPYdi4oHPFYWVKg60WUqtCqSmOsPwK6qz2JQgU5S1H0YqmPMkMU76jDZTYn
 lkP33PSLavtDBMXgIIfm9y3nM9p61Zer7u46FZWlhNRGCPbRQQdDAH4XsABPtGnW60B8
 BE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+IGQ44b8ehFgo9r1oz6MUXO7lMciX3lsO+/mrOD8lKs=;
 b=qkTVLRbvCpM7vPOiymkEK4AUY3QPOTN+yssS21ae9SxSDUyFfCStyAccA9EgAunS55
 99TVeLpLEJHVL/IVxEPsUlIpDH2i9fIt4vdpLMFPk58EP3eH31PVr2CGewJ+NEU11XJk
 jer0sZq1O3zmrxZ1wsHWWckmCZ/kkiFAJyNP7HRln0PiBehAw+MRav8npMmsRlPAL4U5
 JILCxEaXKxinDEDWXEhLJ1FH0AU27MpTfHWo4TYvldOx1LZNwrHyrb4/bD5q3ysYxDyr
 XFtReuZHt5X5fqFZIlElhwjwnPKD63toGZ52ML8F99a5IJ5XpfXj7Erh/3W4rgADEOkM
 i3ew==
X-Gm-Message-State: APjAAAWV0ZAbrygUiRdniC8aI/kA/ihRWqoI4AOhPVv8Pp2ocaWUeApO
 oRjk6Z6l0Zh3BfEKaoGITn6gmzc4ojwTpAxuWZGd4Q==
X-Google-Smtp-Source: APXvYqzsIMSQIv73Gzmo6PpatlAiH1YXLjMsm2KELMYVI69mtO6l3/cej9L7YkzaEFTovPCBl/VZ0ymnuMu8PEaKD0Y=
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr6411681lfq.217.1581898475042; 
 Sun, 16 Feb 2020 16:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20200210141324.21090-1-maz@kernel.org>
In-Reply-To: <20200210141324.21090-1-maz@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Feb 2020 01:14:24 +0100
Message-ID: <CACRpkdYTpuONqYvhe2k7vpbBFRBbG6PVihzj8mKctpQiK4vXTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Removing support for 32bit KVM/arm host
To: Marc Zyngier <maz@kernel.org>
Cc: Anders Berg <anders.berg@lsi.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

> it has been a good prototype for the arm64 version,
> but it suffers a few problems:

Wittgenstein wrote that sometimes an intellectual exercise work like such
that you have to throw away the ladder after you climbed it. It often
happens in engineering.

It also echoes Fred Brooks Mythical Man-Month:
"In most projects, the first system built is barely usable....Hence plan to
throw one away; you will, anyhow."

> To reiterate: 32bit guest support for arm64 stays, of course. Only
> 32bit host goes.

That sounds more useful.

I won't miss it.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
