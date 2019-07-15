Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAAF68BF8
	for <lists+kvmarm@lfdr.de>; Mon, 15 Jul 2019 15:48:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDAAE4A53B;
	Mon, 15 Jul 2019 09:48:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mKVSf-WHQPe; Mon, 15 Jul 2019 09:48:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88B064A520;
	Mon, 15 Jul 2019 09:48:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 54D8D4A49C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jul 2019 09:48:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmcEtgdyKPH4 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Jul 2019 09:48:52 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E142F4A3A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jul 2019 09:48:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DBAA28;
 Mon, 15 Jul 2019 06:48:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697233F71F;
 Mon, 15 Jul 2019 06:48:51 -0700 (PDT)
Date: Mon, 15 Jul 2019 14:48:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC] Add virtual SDEI support in qemu
Message-ID: <20190715134848.GI56232@lakrids.cambridge.arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
 <20190715134059.GJ2790@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190715134059.GJ2790@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guoheyi <guoheyi@huawei.com>,
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

On Mon, Jul 15, 2019 at 02:41:00PM +0100, Dave Martin wrote:
> On Sat, Jul 13, 2019 at 05:53:57PM +0800, Guoheyi wrote:
> > Hi folks,
> > 
> > Do it make sense to implement virtual SDEI in qemu? So that we can have the
> > standard way for guest to handle NMI watchdog, RAS events and something else
> > which involves SDEI in a physical ARM64 machine.
> > 
> > My basic idea is like below:
> > 
> > 1. Change a few lines of code in kvm to allow unhandled SMC invocations
> > (like SDEI) to be sent to qemu, with exit reason of KVM_EXIT_HYPERCALL, so
> > we don't need to add new API.
> 
> So long as KVM_EXIT_HYPERCALL reports sufficient information so that
> userspace can identify the cause as an SMC and retrieve the SMC
> immediate field, this seems feasible.
> 
> For its own SMCCC APIs, KVM exclusively uses HVC, so rerouting SMC to
> userspace shouldn't conflict.

Be _very_ careful here! In systems without EL3 (and without NV), SMC
UNDEFs rather than trapping to EL2. Given that, we shouldn't build a
hypervisor ABI that depends on SMC.

I am strongly of the opinion that (for !NV) we should always use HVC
here and have KVM appropriately forward calls to userspace, rather than
trying to use HVC/SMC to distinguish handled-by-kernel and
handled-by-userspace events.

For NV, the first guest hypervisor would use SMC to talk to KVM, all
else being the same.

> This bouncing of SMCs to userspace would need to be opt-in, otherwise
> old userspace would see exits that it doesn't know what to do with.
> 
> > 2. qemu handles supported SDEI calls just as the spec says for what a
> > hypervisor should do for a guest OS.
> > 
> > 3. For interrupts bound to hypervisor, qemu should stop injecting the IRQ to
> > guest through KVM, but jump to the registered event handler directly,
> > including context saving and restoring. Some interrupts like virtual timer
> > are handled by kvm directly, so we may refuse to bind such interrupts to
> > SDEI events.
> 
> Something like that.
> 
> Interactions between SDEI and PSCI would need some thought: for example,
> after PSCI_CPU_ON, the newly online cpu needs to have SDEs masked.
> 
> One option (suggested to me by James Morse) would be to allow userspace
> to disable in the in-kernel PSCI implementation and provide its own
> PSCI to the guest via SMC -- in which case userspace that wants to
> implement SDEI would have to implement PSCI as well.

I think this would be the best approach, since it puts userspace in
charge of everything.

However, this interacts poorly with FW-based mitigations that we
implement in hyp. I suspect we'd probably need a mechanism to delegate
that responsibility back to the kernel, and figure out if that has any
interaction with thigns that got punted to userspace...

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
