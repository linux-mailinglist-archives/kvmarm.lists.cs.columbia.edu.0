Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B32D5405DDF
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 22:06:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BDBC4B1A3;
	Thu,  9 Sep 2021 16:06:50 -0400 (EDT)
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
	with ESMTP id HEDgI5-1XHnX; Thu,  9 Sep 2021 16:06:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A020C4B1AC;
	Thu,  9 Sep 2021 16:06:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE9A4B192
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 16:06:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qdyzJK5DpyFy for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 16:06:43 -0400 (EDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com
 [209.85.219.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DA2754B191
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 16:06:43 -0400 (EDT)
Received: by mail-yb1-f172.google.com with SMTP id q70so6288915ybg.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tO7FQvr77frYJi3nZmu6+pwHGzzGpRLOFUZlxjTtI1U=;
 b=Oy8ce1O5/wmCpWya7nBN8qiLzyBclFRFa2r5eAlAZU84jaC9rRJqZj+6BkGTdfIpgW
 Xo43sUbTTRgBrpwz5atoMw8WujebQDagPIFYaWoWcjBinCeRRovpaAoErPviwwGktYxP
 2IzfCacZM2oMqC39Ot+/X5X/Dm9DDMIjRuU6S0+QBgx2AmPIUXBsbIFrNplp1T8lCRh8
 yi+d82k1py9m7Zw1jRBRnzaBMTHpxNDk1JlsO3SBLSBfCH36zQGB1BjjhcxRxp10WXKe
 5KDRIbkrpMER8mwxPbVPhljAg1QG2K6yLR41eqOBWjdb0KAOLc1agFTWxfHGFr2zJmrQ
 svJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tO7FQvr77frYJi3nZmu6+pwHGzzGpRLOFUZlxjTtI1U=;
 b=WTSvkAHIF9ZJypumnPdNfeKPXwlP7oizicCne/xM4h4bg5lDpA5ag8DweVOo56/nRq
 Zwgxugpbaz23RCLcuNBlY/v2JqpN/yoAVS5KKdnEAjm3k70iSuSfgDjjqiJ2pmpKRZyr
 vH+CrEKTN8JdTanTy9cUMnlSJMAS1iXmCrZx424IwG2ji51GDY4AWa+tv0aR7v2afB3t
 6dlpKbgVJXzpqiUi6K5sgkZ0N4pGSgzZ5gbDm9YG+WegasksFbKEBRealqwkXc+DDHEo
 EbKJLROhvqJ8iiRw+ncNfjrzaAIgOo8VaSl7EuJ5cFvqtE5ptiHBcLHxV3TLIAEBHOWi
 ri0Q==
X-Gm-Message-State: AOAM531Eh/g2fm3mcvq1X1YZMeOWYiknZZ/RoAAx/nGL3Vlt1NGy2afc
 vS3zZjaMP4nob1VumINylcK6jsmHsNCslijx8Eefqw==
X-Google-Smtp-Source: ABdhPJy5AGrEZidGvl3dQRB0sKLB1qGhBQdOWzBR63cYYp97lf+k7MCv+e5P0N+q7y2PLgyyxkEQheVKlXRUYFUqZyY=
X-Received: by 2002:a25:8093:: with SMTP id n19mr6441809ybk.414.1631218003111; 
 Thu, 09 Sep 2021 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-3-rananta@google.com>
 <20210909171755.GF5176@sirena.org.uk>
In-Reply-To: <20210909171755.GF5176@sirena.org.uk>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 9 Sep 2021 13:06:31 -0700
Message-ID: <CAJHc60yJ6621=TezncgsMR+DdYxzXY1oF-QLeARwq8HowH6sVQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] KVM: arm64: selftests: Add sysreg.h
To: Mark Brown <broonie@kernel.org>
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

On Thu, Sep 9, 2021 at 10:18 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:02AM +0000, Raghavendra Rao Ananta wrote:
> > Bring-in the kernel's arch/arm64/include/asm/sysreg.h
> > into selftests to make use of all the standard
> > register definitions in consistence with the kernel.
>
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/include/aarch64/sysreg.h    | 1278 +++++++++++++++++
> >  1 file changed, 1278 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/include/aarch64/sysreg.h
>
> Can we arrange to copy this at build time rather than having a duplicate
> copy we need to keep in sync?  We have some stuff to do this for uapi
> headers already.

That's a great idea actually (I wasn't aware of it). But, probably
should've mentioned it earlier, I had a hard time compiling the header
as is so I modified it a little bit and made the definitions of
[write|read]_sysreg_s() similar to the ones in kvm-unit-tests.
I'll try my best to get the original format working and try to
implement your idea if it works.

Regards,
Raghavendra
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
