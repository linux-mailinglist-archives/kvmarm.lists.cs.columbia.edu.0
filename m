Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C191FAF784
	for <lists+kvmarm@lfdr.de>; Wed, 11 Sep 2019 10:16:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4334B4A5E6;
	Wed, 11 Sep 2019 04:16:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tw2lgzdCMTzR; Wed, 11 Sep 2019 04:16:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0164E4A5E1;
	Wed, 11 Sep 2019 04:16:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B31AA4A522
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Sep 2019 04:16:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rAfH++wsV3g for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Sep 2019 04:16:09 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6918F4A445
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Sep 2019 04:16:09 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13EF1000;
 Wed, 11 Sep 2019 01:16:08 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E57173F67D;
 Wed, 11 Sep 2019 01:16:07 -0700 (PDT)
Date: Wed, 11 Sep 2019 09:16:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH kvm-unit-tests] arm: prevent compiler from using
 unaligned accesses
Message-ID: <20190911091604.380c6df9@donnerap.cambridge.arm.com>
In-Reply-To: <d41649bc-5061-3c65-146c-d7dff3f086e7@redhat.com>
References: <20190905171502.215183-1-andre.przywara@arm.com>
 <d41649bc-5061-3c65-146c-d7dff3f086e7@redhat.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Tue, 10 Sep 2019 20:15:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

Hi,

> On 05/09/2019 19.15, Andre Przywara wrote:
> > The ARM architecture requires all accesses to device memory to be
> > naturally aligned[1][2]. Normal memory does not have this strict
> > requirement, and in fact many systems do ignore unaligned accesses
> > (by the means of clearing the A bit in SCTLR and accessing normal
> > memory). So the default behaviour of GCC assumes that unaligned accesses
> > are fine, at least if happening on the stack.
> > 
> > Now kvm-unit-tests runs some C code with the MMU off, which degrades the
> > whole system memory to device memory. Now every unaligned access will
> > fault, regardless of the A bit.
> > In fact there is at least one place in lib/printf.c where GCC merges
> > two consecutive char* accesses into one "strh" instruction, writing to
> > a potentially unaligned address.
> > This can be reproduced by configuring kvm-unit-tests for kvmtool, but
> > running it on QEMU, which triggers an early printf that exercises this
> > particular code path.
> > 
> > Add the -mstrict-align compiler option to the arm64 CFLAGS to fix this
> > problem. Also add the respective -mno-unaligned-access flag for arm.
> > 
> > Thanks to Alexandru for helping debugging this.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > [1] ARMv8 ARM DDI 0487E.a, B2.5.2
> > [2] ARMv7 ARM DDI 0406C.d, A3.2.1
> > ---
> >  arm/Makefile.arm   | 1 +
> >  arm/Makefile.arm64 | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/arm/Makefile.arm b/arm/Makefile.arm
> > index a625267..43b4be1 100644
> > --- a/arm/Makefile.arm
> > +++ b/arm/Makefile.arm
> > @@ -12,6 +12,7 @@ KEEP_FRAME_POINTER := y
> >  
> >  CFLAGS += $(machine)
> >  CFLAGS += -mcpu=$(PROCESSOR)
> > +CFLAGS += -mno-unaligned-access
> >  
> >  arch_LDFLAGS = -Ttext=40010000
> >  
> > diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
> > index 02c24e8..35de5ea 100644
> > --- a/arm/Makefile.arm64
> > +++ b/arm/Makefile.arm64
> > @@ -7,6 +7,7 @@ bits = 64
> >  ldarch = elf64-littleaarch64
> >  
> >  arch_LDFLAGS = -pie -n
> > +CFLAGS += -mstrict-align  
> 
> Instead of adding it to both, Makefile.arm and Makefile.arm64, you could
> also simply add it to Makefile.common instead.

But the arguments are not the same (admittedly against intuition)?
I thought about defining arch_CFLAGS in both files, then adding that to Makefile.common, but didn't see the advantage over this straightforward approach here.

Cheers,
Andre.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
