Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8415DD5C
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 16:58:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B25D4A968;
	Fri, 14 Feb 2020 10:58:29 -0500 (EST)
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
	with ESMTP id MA5hMYphUCtx; Fri, 14 Feb 2020 10:58:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F05094AEA4;
	Fri, 14 Feb 2020 10:58:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C8044A968
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:58:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rln9BHyk3Hgu for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 10:58:25 -0500 (EST)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 61EF74A536
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:58:25 -0500 (EST)
Received: by mail-ot1-f68.google.com with SMTP id 59so9566800otp.12
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7bOcfoQZl3F8fqHPhjMMAa503NpXfsD6HMvBw5tSP8s=;
 b=kX2dO2lu3E8rOEoTVvCGYM8nPGoKdlDT8ZvHPHxRs3BzVhUSkxcCw6K24Y5aTtU5si
 +Ux5zL5Msjyx4lSZ/GeC2SApmABaIF5o7Wc2sn5Qi37BFA3bS/8cI9O/dAX9zoVOw6Rk
 tP7Ie6F3omocpszOy7JJPoqv8s7Mr+IYE6Wtf30DD3zw87++2OcYkknPGZLTjz6pIeyc
 jWc2ZI6heV1WH6u0CHC2nW2yYe1YZ/yK4yHg2FP1KqVlCiLhi1MXjQlr6h4I0ICE9pM2
 8I357YnqPF2jqYz8P+jqGhFPLOfuRB8FXsCmq4Xm+moi+nt0eu0jnuhQMyhQeELq3wWP
 GUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7bOcfoQZl3F8fqHPhjMMAa503NpXfsD6HMvBw5tSP8s=;
 b=RDr290X1Uxq2jtYYaQAAywTjJzl/mIlzt/RODNr+y5Q3RzwGQC/RjPtqZiRdqP+CrK
 aVgcG4heBHoAf0cMGARW+VaeDj6P06/JpzuI23lygQG9kT+auQLoQeQbrZJoRbUDy89b
 tuNcEkSYe9hzIRzfx1PgW3wXwG03taMYxoJ7O5gLdn0ak/ERbMlWhsEJzjQ84zezZG4E
 XdVG/E1gkTlsIFkFb6T6e6TU5oESOxIX+aKvXNhh48JPbI4HPj8ntvCXRYOXjNEdeCvs
 UriMoNqzdEDXY+o0tENYpGIm54pJXzwyO07Iyg/5/FFl+ftzw6/bqUnqvh+TfiBSPjL3
 zv1w==
X-Gm-Message-State: APjAAAVeJ/UXQVTVkGCY1bVfYYw1NoP2q9AlDLHIfki86GkzMFZOek5H
 dpVaBtDrdm+JUyyM455b/aYmbjvAJ7qlcSYm3vYChw==
X-Google-Smtp-Source: APXvYqx/d2a81Pp+Cm6kjutLv1Fu5WDfEbx7fVbqijNpFcOhTEbMgyI36CNkD4gkBX+WP0IRrYbqgpVyWl7QA1EJGT0=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2830279otq.135.1581695904754; 
 Fri, 14 Feb 2020 07:58:24 -0800 (PST)
MIME-Version: 1.0
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
In-Reply-To: <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 15:58:13 +0000
Message-ID: <CAFEAcA_yZ55rOD1x+FE9wYO8HXx9seK72ZCmnWjtDVr_95-whg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On Fri, 14 Feb 2020 at 04:23, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 01/28/2020 06:09 PM, Anshuman Khandual wrote:
> > This series is primarily motivated from an adhoc list from Mark Rutland
> > during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> > which does macro replacement for various open bits shift encodings in
> > various CPU ID registers. This series is based on linux-next 20200124.
> >
> > [1] https://patchwork.kernel.org/patch/11287805/
> >
> > Is there anything else apart from these changes which can be accommodated
> > in this series, please do let me know. Thank you.
>
> Just a gentle ping. Any updates, does this series looks okay ? Is there
> anything else related to CPU ID register feature bits, which can be added
> up here. FWIW, the series still applies on v5.6-rc1.

I just ran into some "32-bit KVM doesn't expose all the ID
registers to userspace via the ONE_REG API" issues today.
I don't know if they'd be reasonable as something to include
in this patchset or if they're unrelated.

Anyway, missing stuff I have noticed specifically:
 * MVFR2
 * ID_MMFR4
 * ID_ISAR6

More generally I would have expected all these 32-bit registers
to exist and read-as-zero for the purpose of the ONE_REG APIs,
because that's what the architecture says is supposed to happen
and it means we have compatibility and QEMU doesn't gradually
build up lots of "kernel doesn't support this yet" conditionals...
I think we get this right for 64-bit KVM, but can we do it for
32-bit as well?

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
