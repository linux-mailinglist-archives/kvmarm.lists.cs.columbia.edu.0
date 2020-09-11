Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5C26621E
	for <lists+kvmarm@lfdr.de>; Fri, 11 Sep 2020 17:28:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F4C84B345;
	Fri, 11 Sep 2020 11:28:17 -0400 (EDT)
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
	with ESMTP id 9xNO+kQVYLuK; Fri, 11 Sep 2020 11:28:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFDE64B2E1;
	Fri, 11 Sep 2020 11:28:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C7C54B286
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 11:28:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqtmiKmwlpYF for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Sep 2020 11:28:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5316F4B285
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Sep 2020 11:28:13 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB642221EB;
 Fri, 11 Sep 2020 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599838092;
 bh=6cV2mWJIcsvc3E4AksrgeSByklmLHYWmlJOjYI4CUKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KVOG6+zeqb4cOuFAtx6ydb9KHxbI96sEBa1KRey3btHR6BMrcIgOrFIYNaNAOaMY5
 3QuiLd96i5FgCPS2X2FHF/c7/0Iec/YVLmRMj875HcwzkE3a8IWGqbFkl+25fTUeMm
 zTacF6ylhQu4ESuYxO/iCwyC8iookf0LGExWOcHs=
Date: Fri, 11 Sep 2020 16:28:07 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 2/2] arm64: Add workaround for Arm Cortex-A77 erratum
 1508412
Message-ID: <20200911152807.GA20527@willie-the-truck>
References: <20200909231310.3297400-1-robh@kernel.org>
 <20200909231310.3297400-2-robh@kernel.org>
 <20200911103714.GA4094@gaia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911103714.GA4094@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Fri, Sep 11, 2020 at 11:37:14AM +0100, Catalin Marinas wrote:
> On Wed, Sep 09, 2020 at 05:13:10PM -0600, Rob Herring wrote:
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 554a7e8ecb07..55dfff8ca466 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -943,6 +943,7 @@
> >  
> >  #include <linux/build_bug.h>
> >  #include <linux/types.h>
> > +#include <asm/alternative.h>
> >  
> >  #define __DEFINE_MRS_MSR_S_REGNUM				\
> >  "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
> > @@ -1024,6 +1025,17 @@
> >  		write_sysreg(__scs_new, sysreg);			\
> >  } while (0)
> >  
> > +#define read_sysreg_par() ({						\
> > +	unsigned long flags;						\
> > +	u64 par;							\
> > +	local_irq_save(flags);						\
> > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > +	par = read_sysreg(par_el1);					\
> > +	asm(ALTERNATIVE("nop", "dmb sy", ARM64_WORKAROUND_1508412));	\
> > +	local_irq_restore(flags);					\
> > +	par;								\
> > +})
> 
> As an alternative to local_irq_save/restore, we could have added a dmb
> in the kernel_exit macro. The minor nit here is that we always disable
> interrupts even when the erratum doesn't apply.
> 
> The EL1 code accessing PAR_EL1 already runs with interrupts disabled
> (which covers the prior AT instruction). If that's the case for KVM as
> well, we could drop the local_irq_* entirely and just leave the DMB in
> the exit to guest code.

I wonder if that's actually a more robust approach in the case of psuedo
NMIs using ARM64_HAS_IRQ_PRIO_MASKING?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
