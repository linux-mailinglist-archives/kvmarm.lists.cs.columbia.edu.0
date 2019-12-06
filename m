Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E63511504B
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 13:21:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31FF24AF42;
	Fri,  6 Dec 2019 07:21:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRFGlNhtWyWY; Fri,  6 Dec 2019 07:21:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 065124AF3F;
	Fri,  6 Dec 2019 07:21:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E1454AEC4
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 07:21:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75K-Xjy1BtnW for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 07:21:21 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 676294AE9D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 07:21:21 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A225731B;
 Fri,  6 Dec 2019 04:21:20 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 6B6E03F52E; Fri,  6 Dec 2019 04:21:19 -0800 (PST)
Date: Fri, 6 Dec 2019 12:21:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] arm64: KVM: Invoke compute_layout() before
 alternatives are applied
Message-ID: <20191206122117.GE32767@arrakis.emea.arm.com>
References: <20191016165953.o6ogh4fdmsjmd2sw@linutronix.de>
 <ecfbb413-e97e-c3eb-e051-1f218b387edd@arm.com>
 <20191128195805.c2pryug4ohmcoqwd@linutronix.de>
 <20191206115716.GC32767@arrakis.emea.arm.com>
 <41a90c16d6958e70524c1c54b63a7f50@www.loen.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41a90c16d6958e70524c1c54b63a7f50@www.loen.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Fri, Dec 06, 2019 at 12:12:10PM +0000, Marc Zyngier wrote:
> On 2019-12-06 11:57, Catalin Marinas wrote:
> > On Thu, Nov 28, 2019 at 08:58:05PM +0100, Sebastian Andrzej Siewior
> > wrote:
> > > @@ -408,6 +410,8 @@ static void __init hyp_mode_check(void)
> > >  			   "CPU: CPUs started in inconsistent modes");
> > >  	else
> > >  		pr_info("CPU: All CPU(s) started at EL1\n");
> > > +	if (IS_ENABLED(CONFIG_KVM_ARM_HOST))
> > > +		kvm_compute_layout();
> > >  }
> > 
> > It looks like we call this unconditionally here even if the kernel was
> > booted at EL1.
> 
> It has always been the case. My motivation was to be able to debug
> this in a guest, because doing this on the host is... painful! ;-)
> 
> Feel free to condition it on !EL1 though.

I'll leave the patch as is. Thanks for confirming.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
