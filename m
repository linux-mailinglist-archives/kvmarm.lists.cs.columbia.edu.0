Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD081CCA27
	for <lists+kvmarm@lfdr.de>; Sun, 10 May 2020 12:17:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 536B44B2C9;
	Sun, 10 May 2020 06:17:07 -0400 (EDT)
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
	with ESMTP id uCxy3HlP4c3m; Sun, 10 May 2020 06:17:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CBF664B2EF;
	Sun, 10 May 2020 06:17:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 701DC4B2CA
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 May 2020 06:17:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KrOZJxTqr1y3 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 10 May 2020 06:17:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 488844B2C9
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 May 2020 06:17:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DEB8206A3;
 Sun, 10 May 2020 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589105821;
 bh=+0kDXWCp+FqkNWlLvZ+TWB7dPSP/xtLz8CjN8Au1pfY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SCq/ffd0ndynT5J+/zSojwIXSnyvVOS5dyJf7h09dTyq1QpTCh1IlWOSMK7ZB9CGA
 T7V0luZDjAb7hyGAp4OehAahjoR6e5a9lVercD0SZuQK8TWjodALDgPRombn1SJcL0
 MIabkHSZA8F1SerF0Mb9pV99Ragti8oDB1tsI+gg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jXj11-00B1Pu-20; Sun, 10 May 2020 11:16:59 +0100
Date: Sun, 10 May 2020 11:16:54 +0100
Message-ID: <871rns14dl.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 02/15] arm64: kvm: Formalize host-hyp hypcall ABI
In-Reply-To: <20200507133320.GA16899@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-3-dbrazdil@google.com>
 <87d07fj3g9.wl-maz@kernel.org> <20200507133320.GA16899@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 EasyPG/1.0.0 Emacs/26
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qperret@google.com, dbrazdil@google.com,
 catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

Hi Quentin,

On Thu, 07 May 2020 14:33:20 +0100,
Quentin Perret <qperret@google.com> wrote:
> 
> Hey Marc,
> 
> On Thursday 07 May 2020 at 14:10:30 (+0100), Marc Zyngier wrote:
> > Hi David, Quentin,

[...]

> > > +#define __KVM_HOST_HCALL_TABLE_IDX___vgic_v3_save_aprs		13
> > > +__KVM_HOST_HCALL(__vgic_v3_save_aprs)
> > > +
> > > +#define __KVM_HOST_HCALL_TABLE_IDX_SIZE				14
> > 
> > This whole thing screams "enum" into my ears. Having to maintain these
> > as #defines feels like a pain, specially if the numbers are never used
> > in assembly code. (and for that, we have asm-offset.h).
> 
> This is essentially inspired from the various 'unistd.h' files we have
> in the kernel, e.g. include/uapi/asm-generic/unistd.h, which have
> exactly this type of construct. So, this was really just for consistency,
> but no strong opinion from me.

I think part of the of the reason for not using an enum in the syscall
code is that part of is is (was?) used from assembly code. In our
case, I'm pretty sure we won't go back to handling calls from asm any
time soon, so a generated enum (and associated function pointer array)
would be better.

> 
> > 
> > > +
> > > +/* XXX - Arbitrary offset for KVM-related hypercalls */
> > > +#define __KVM_HOST_HCALL_BASE_SHIFT 8
> > > +#define __KVM_HOST_HCALL_BASE (1ULL << __KVM_HOST_HCALL_BASE_SHIFT)
> > > +#define __KVM_HOST_HCALL_END (__KVM_HOST_HCALL_BASE + \
> > > +			      __KVM_HOST_HCALL_TABLE_IDX_SIZE)
> > 
> > I don't really get what is this offset for. It is too small to be used
> > to skip the stub hypercalls (you'd need to start at 0x1000).
> 
> Oh, OK. I assumed anything above HVC_STUB_HCALL_NR would be fine. But
> yes, this offset is really arbitrary, so if 0x1000 is better then that
> totally works. For my education, where is that 0x1000 coming from ?

We assumed that we wouldn't get a function pointer in the first 4kB,
and documented as such in hyp.S. I would say that either we keep the
current convention of leaving the first 4k function codes for the
hyp-stubs, or we drop any sort of gap.

Another thing to consider is that there is at least *one* external
hypervisor (Jailhouse) that uses the stubs, so I'd like to make sure
we don't break that (even if we made no promise whatsoever in that
respect).

> 
> > Given
> > that you store the whole thing in an array, you're wasting some
> > memory. I'm sure you have a good story for it though! ;-)
> 
> Note that the array's length is __KVM_HOST_HCALL_TABLE_IDX_SIZE, which
> doesn't include the offset, so we shouldn't be wasting memory here.

Ah, you're right. I got confused between _SIZE and _END.

> 
> > > +
> > > +/* Hypercall number = kvm offset + table idx */
> > > +#define KVM_HOST_HCALL_NR(name) (__KVM_HOST_HCALL_TABLE_IDX_##name + \
> > > +				 __KVM_HOST_HCALL_BASE)
> > > diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> > > index 8c9880783839..29e2b2cd2fbc 100644
> > > --- a/arch/arm64/kvm/hyp/Makefile
> > > +++ b/arch/arm64/kvm/hyp/Makefile
> > > @@ -9,7 +9,7 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
> > >  obj-$(CONFIG_KVM) += hyp.o
> > >  
> > >  hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o sysreg-sr.o \
> > > -	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
> > > +	 debug-sr.o entry.o switch.o fpsimd.o tlb.o host_hypercall.o hyp-entry.o
> > >  
> > >  # KVM code is run at a different exception code with a different map, so
> > >  # compiler instrumentation that inserts callbacks or checks into the code may
> > > diff --git a/arch/arm64/kvm/hyp/host_hypercall.c b/arch/arm64/kvm/hyp/host_hypercall.c
> > > new file mode 100644
> > > index 000000000000..6b31310f36a8
> > > --- /dev/null
> > > +++ b/arch/arm64/kvm/hyp/host_hypercall.c
> > > @@ -0,0 +1,22 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2020 Google, inc
> > > + */
> > > +
> > > +#include <asm/kvm_hyp.h>
> > > +
> > > +typedef long (*kvm_hcall_fn_t)(void);
> > > +
> > > +static long __hyp_text kvm_hc_ni(void)
> > > +{
> > > +       return -ENOSYS;
> > > +}
> > > +
> > > +#undef __KVM_HOST_HCALL
> > > +#define __KVM_HOST_HCALL(name) \
> > > +	[__KVM_HOST_HCALL_TABLE_IDX_##name] = (long (*)(void))name,
> > > +
> > > +const kvm_hcall_fn_t kvm_hcall_table[__KVM_HOST_HCALL_TABLE_IDX_SIZE] = {
> > > +	[0 ... __KVM_HOST_HCALL_TABLE_IDX_SIZE-1] = kvm_hc_ni,
> > > +#include <asm/kvm_host_hypercalls.h>
> > > +};
> > 
> > Cunning. At the same time, if you can do this once, you can do it
> > twice, and generating the __KVM_HOST_HCALL_TABLE_IDX_* as an enum
> > should be pretty easy, and could live in its own include file.
> 
> Right, and that again is inspired from the arm64 syscall table (see
> arch/arm64/kernel/sys.c). So the first intention was to keep things
> consistent. But again, no strong opinion :)

So let's try to build it with an enum instead, and see if it works. If
it doesn't, at least we will know why.

[...]

> > > +	/* Find hcall function pointer in the table */
> > > +	ldr	x10, =kvm_hcall_table
> > > +	ksym_hyp_va	x10, x9
> > 
> > Can't kvm_hcall_table be referenced with adr or adr_l? It'd certainly
> > be nice to avoid the extra load for something that is essentially a
> > build-time constant.
> 
> In fact David already has a nice patch that transforms the whole thing
> in a jump table, which is much nicer. I'll let him share the details
> :)

Ah! Looking forward to reviewing it then!

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
