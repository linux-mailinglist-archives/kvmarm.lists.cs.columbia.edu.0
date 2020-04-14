Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C71531A7EF7
	for <lists+kvmarm@lfdr.de>; Tue, 14 Apr 2020 15:57:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CE3B4B1E0;
	Tue, 14 Apr 2020 09:57:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scbjMrNrASVX; Tue, 14 Apr 2020 09:57:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C3A04B1D3;
	Tue, 14 Apr 2020 09:57:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 589AE4B1C3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 09:57:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SXfZROxdkWE for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Apr 2020 09:57:17 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1868A4B1C1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Apr 2020 09:57:17 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF22620656;
 Tue, 14 Apr 2020 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586872636;
 bh=n9zV/CUm5fQ6kJG9xx9uBNkS1o6bnb2V/CMUwlWKrf0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=b/kuN0mMrGpZr4ilxxpfussBIw4+VR3Qlk9Sl3WR2i289CFIIqOtaL7p7RASlKDZ9
 vfPpAOPXooK8inL7i2YwIB/rSjj0cncaL/gt2OX7jThO1ap0y36WURbAwnGgHOf4ut
 fLSxAyZq70gzsRO490XT4UfNLbRwPP3L1RQSmHh0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jOM3u-003AqO-B3; Tue, 14 Apr 2020 14:57:14 +0100
Date: Tue, 14 Apr 2020 14:57:12 +0100
From: Marc Zyngier <maz@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: kvm: Delete duplicated label: in invalid_vector
Message-ID: <20200414145712.603e37d5@why>
In-Reply-To: <CAKwvOdn35v5LkvhWugfLmK_FjVsd0RdPtBCRSqVaM9EP_1KU7w@mail.gmail.com>
References: <20200413231016.250737-1-maskray@google.com>
 <CAKwvOdn35v5LkvhWugfLmK_FjVsd0RdPtBCRSqVaM9EP_1KU7w@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ndesaulniers@google.com, maskray@google.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 clang-built-linux@googlegroups.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Fangrui Song <maskray@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Nick,

On Mon, 13 Apr 2020 16:37:10 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Mon, Apr 13, 2020 at 4:10 PM Fangrui Song <maskray@google.com> wrote:
> >
> > SYM_CODE_START defines \label , so it is redundant to define \label again.
> > A redefinition at the same place is accepted by GNU as
> > (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=159fbb6088f17a341bcaaac960623cab881b4981)
> > but rejected by the clang integrated assembler.
> >
> > Fixes: 617a2f392c92 ("arm64: kvm: Annotate assembly using modern annoations")  
> 
> Thanks for the patch!  I think a more accurate Fixes tag would be:
> Fixes: 2b28162cf65a ("arm64: KVM: HYP mode entry points")

I'm not sure this commit is accurate. At that time, there was no other
declaration for \label and dropping it would simply break compilation.
I believe that Fangrui is correct in his analysis that 617a2f392c92 is
the first broken commit.

> With this patch applied, and your other arm64 integrated assembler
> patch (https://lore.kernel.org/linux-arm-kernel/20200413033811.75074-1-maskray@google.com/T/#u),
> I can now assemble arch/arm64/kvm/.

Progress! ;-)

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/988
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > ---
> >  arch/arm64/kvm/hyp/hyp-entry.S | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> > index c2a13ab3c471..9c5cfb04170e 100644
> > --- a/arch/arm64/kvm/hyp/hyp-entry.S
> > +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> > @@ -198,7 +198,6 @@ SYM_CODE_END(__hyp_panic)
> >  .macro invalid_vector  label, target = __hyp_panic
> >         .align  2
> >  SYM_CODE_START(\label)
> > -\label:
> >         b \target
> >  SYM_CODE_END(\label)
> >  .endm
> > --
> > 2.26.0.110.g2183baf09c-goog
> >  
> 
> 

I'll pick this up as soon as we've sorted the queue with the rest of
the fixes.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
