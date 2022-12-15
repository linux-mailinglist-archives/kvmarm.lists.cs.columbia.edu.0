Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67664D4D3
	for <lists+kvmarm@lfdr.de>; Thu, 15 Dec 2022 01:53:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BFEB4B991;
	Wed, 14 Dec 2022 19:53:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jdbIG1N0Zwj; Wed, 14 Dec 2022 19:53:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 089C94B99D;
	Wed, 14 Dec 2022 19:53:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57F0C4B975
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 19:53:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vnwwitp23zfx for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Dec 2022 19:53:40 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D6C1C4B93E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 19:53:40 -0500 (EST)
Date: Thu, 15 Dec 2022 00:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1671065619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQZjLx07NAZDei7fVqCJDqISUKBeZNNlqCXpcnS/UPM=;
 b=cLu7XSIcAnPxl7pEKBbBmfJYTNQPeFa7+JM8d5kk6dqSAvCY1BlWW1h1PHjPL0CLlZnVua
 cRfZ/4ny21BI4OkENOpkc5/bT7pZAU7wioHg4ROhz+RvXSEKA7/TRtxuF1w7OgeGZNHCea
 R6Tv62zgGS4Pmoefap2jEJsLuY6ncd0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v1 01/12] arm64/mm: Add FEAT_LPA2 specific
 ID_AA64MMFR0.TGRAN[2]
Message-ID: <Y5pwD9zr0L6sbBnU@google.com>
References: <20221206135930.3277585-1-ryan.roberts@arm.com>
 <20221206135930.3277585-2-ryan.roberts@arm.com>
 <Y5og+Qy2o8wE1pvD@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5og+Qy2o8wE1pvD@google.com>
X-Migadu-Flow: FLOW_OUT
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 14, 2022 at 07:16:09PM +0000, Oliver Upton wrote:
> On Tue, Dec 06, 2022 at 01:59:19PM +0000, Ryan Roberts wrote:
> > From: Anshuman Khandual <anshuman.khandual@arm.com>
> > 
> > PAGE_SIZE support is tested against possible minimum and maximum values for
> > its respective ID_AA64MMFR0.TGRAN field, depending on whether it is signed
> > or unsigned. But then FEAT_LPA2 implementation needs to be validated for 4K
> > and 16K page sizes via feature specific ID_AA64MMFR0.TGRAN values. Hence it
> > adds FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2] values per ARM ARM (0487G.A).
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 7d301700d1a9..9ad8172eea58 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -673,10 +673,12 @@
> >  
> >  /* id_aa64mmfr0 */
> >  #define ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN	0x0
> > +#define ID_AA64MMFR0_EL1_TGRAN4_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
> >  #define ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX	0x7
> >  #define ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN	0x0
> >  #define ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX	0x7
> >  #define ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN	0x1
> > +#define ID_AA64MMFR0_EL1_TGRAN16_LPA2		ID_AA64MMFR0_EL1_TGRAN16_52_BIT
> >  #define ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX	0xf
> >  
> >  #define ARM64_MIN_PARANGE_BITS		32
> > @@ -684,6 +686,7 @@
> >  #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_DEFAULT	0x0
> >  #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_NONE		0x1
> >  #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MIN		0x2
> > +#define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_LPA2		0x3
> >  #define ID_AA64MMFR0_EL1_TGRAN_2_SUPPORTED_MAX		0x7
> >  
> >  #ifdef CONFIG_ARM64_PA_BITS_52
> > @@ -800,11 +803,13 @@
> >  
> >  #if defined(CONFIG_ARM64_4K_PAGES)
> >  #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_SHIFT
> > +#define ID_AA64MMFR0_EL1_TGRAN_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
> >  #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN
> >  #define ID_AA64MMFR0_EL1_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX
> >  #define ID_AA64MMFR0_EL1_TGRAN_2_SHIFT		ID_AA64MMFR0_EL1_TGRAN4_2_SHIFT
> >  #elif defined(CONFIG_ARM64_16K_PAGES)
> >  #define ID_AA64MMFR0_EL1_TGRAN_SHIFT		ID_AA64MMFR0_EL1_TGRAN16_SHIFT
> > +#define ID_AA64MMFR0_EL1_TGRAN_LPA2		ID_AA64MMFR0_EL1_TGRAN16_52_BIT
> 
> Can you use the 52_BIT suffix instead for these macros? LPA2 can map to
> multiple values (i.e. no support for 4KB granule). Also provides a
> direct description of what feature we're testing for.

Ignore me. I had to educate myself with Ard's series, and I now see that
this pattern is followed there too.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
