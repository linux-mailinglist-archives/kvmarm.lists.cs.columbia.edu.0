Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E7843114FF9
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:46:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9787B4AF3D;
	Fri,  6 Dec 2019 06:46:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XldxqO5o4Oy5; Fri,  6 Dec 2019 06:46:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70DAA4AF42;
	Fri,  6 Dec 2019 06:46:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 775724AF29
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:46:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bt9g3cPaZ8pJ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:46:52 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 107DD4AF40
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:46:52 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B23831B;
 Fri,  6 Dec 2019 03:46:51 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4565B3F52E; Fri,  6 Dec 2019 03:46:50 -0800 (PST)
Date: Fri, 6 Dec 2019 11:46:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] arm64: KVM: Invoke compute_layout() before
 alternatives are applied
Message-ID: <20191206114647.GB32767@arrakis.emea.arm.com>
References: <20191016165953.o6ogh4fdmsjmd2sw@linutronix.de>
 <ecfbb413-e97e-c3eb-e051-1f218b387edd@arm.com>
 <20191128195805.c2pryug4ohmcoqwd@linutronix.de>
 <5aae0e8248df45c3f4c08a8bb5aabe06@www.loen.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5aae0e8248df45c3f4c08a8bb5aabe06@www.loen.fr>
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

On Fri, Dec 06, 2019 at 11:22:02AM +0000, Marc Zyngier wrote:
> On 2019-11-28 19:58, Sebastian Andrzej Siewior wrote:
> > compute_layout() is invoked as part of an alternative fixup under
> > stop_machine(). This function invokes get_random_long() which acquires a
> > sleeping lock on -RT which can not be acquired in this context.
> > 
> > Rename compute_layout() to kvm_compute_layout() and invoke it before
> > stop_machine() applies the alternatives. Add a __init prefix to
> > kvm_compute_layout() because the caller has it, too (and so the code can
> > be
> > discarded after boot).
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> I think this should go via the arm64 tree, so I'll let Catalin
> and Will pick this up (unless they think otherwise).

I can pick this up. Thanks.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
