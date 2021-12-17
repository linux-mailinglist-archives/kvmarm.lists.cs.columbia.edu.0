Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5B213478DEA
	for <lists+kvmarm@lfdr.de>; Fri, 17 Dec 2021 15:38:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A573E4B352;
	Fri, 17 Dec 2021 09:38:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEF8USiijhAG; Fri, 17 Dec 2021 09:38:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39D8E4B31E;
	Fri, 17 Dec 2021 09:38:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E7D474B310
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Dec 2021 09:38:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnznmNH7AQUO for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Dec 2021 09:38:19 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 81EF94B30D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Dec 2021 09:38:19 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CACEE12FC;
 Fri, 17 Dec 2021 06:38:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3CA3F5A1;
 Fri, 17 Dec 2021 06:38:17 -0800 (PST)
Date: Fri, 17 Dec 2021 14:38:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
Cc: paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
 frederic <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Fri, Dec 17, 2021 at 03:15:29PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2021-12-17 at 13:21 +0000, Mark Rutland wrote:
> > On Fri, Dec 17, 2021 at 12:51:57PM +0100, Nicolas Saenz Julienne wrote:
> > > Hi All,
> > 
> > Hi,
> > 
> > > arm64's guest entry code does the following:
> > > 
> > > int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > > {
> > > 	[...]
> > > 
> > > 	guest_enter_irqoff();
> > > 
> > > 	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
> > > 
> > > 	[...]
> > > 
> > > 	local_irq_enable();
> > > 
> > > 	/*
> > > 	 * We do local_irq_enable() before calling guest_exit() so
> > > 	 * that if a timer interrupt hits while running the guest we
> > > 	 * account that tick as being spent in the guest.  We enable
> > > 	 * preemption after calling guest_exit() so that if we get
> > > 	 * preempted we make sure ticks after that is not counted as
> > > 	 * guest time.
> > > 	 */
> > > 	guest_exit();
> > > 	[...]
> > > }
> > > 
> > > 
> > > On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
> > > state (EQS). Any interrupt happening between local_irq_enable() and
> > > guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers
> > > do the right thing if trggered in this context, but el1's won't. Is it
> > > possible to hit an el1 handler (for example __el1_irq()) there?
> > 
> > I think you're right that the EL1 handlers can trigger here and won't exit the
> > EQS.
> > 
> > I'm not immediately sure what we *should* do here. What does x86 do for an IRQ
> > taken from a guest mode? I couldn't spot any handling of that case, but I'm not
> > familiar enough with the x86 exception model to know if I'm looking in the
> > right place.
> 
> Well x86 has its own private KVM guest context exit function
> 'kvm_guest_exit_irqoff()', which allows it to do the right thing (simplifying
> things):
> 
> 	local_irq_disable();
> 	kvm_guest_enter_irqoff() // Inform CT, enter EQS
> 	__vmx_kvm_run()
> 	kvm_guest_exit_irqoff() // Inform CT, exit EQS, task still marked with PF_VCPU
> 
> 	/*
> 	 * Consume any pending interrupts, including the possible source of
> 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
> 	 * An instruction is required after local_irq_enable() to fully unblock
> 	 * interrupts on processors that implement an interrupt shadow, the
> 	 * stat.exits increment will do nicely.
> 	 */
> 	local_irq_enable();
> 	++vcpu->stat.exits;
> 	local_irq_disable();
> 
> 	/*
> 	 * Wait until after servicing IRQs to account guest time so that any
> 	 * ticks that occurred while running the guest are properly accounted
> 	 * to the guest.  Waiting until IRQs are enabled degrades the accuracy
> 	 * of accounting via context tracking, but the loss of accuracy is
> 	 * acceptable for all known use cases.
> 	 */
> 	vtime_account_guest_exit(); // current->flags &= ~PF_VCPU

I see.

The abstraction's really messy here on x86, and the enter/exit sides aren't
clearly balanced.

For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
elsewhere. Also, guest_enter_irq_off() conditionally calls
rcu_virt_note_context_switch(), but I can't immediately spot anything on the
exit side that corresponded with that, which looks suspicious.

> So I guess we should convert to x86's scheme, and maybe create another generic
> guest_{enter,exit}() flavor for virtualization schemes that run with interrupts
> disabled.

I think we might need to do some preparatory refactoring here so that this is
all clearly balanced even on x86, e.g. splitting the enter/exit steps into
multiple phases.

> > Note that the EL0 handlers *cannot* trigger for an exception taken from a
> > guest. We use separate vectors while running a guest (for both VHE and nVHE
> > modes), and from the main kernel's PoV we return from kvm_call_hyp_ret(). We
> > can ony take IRQ from EL1 *after* that returns.
> > 
> > We *might* need to audit the KVM vector handlers to make sure they're not
> > dependent on RCU protection (I assume they're not, but it's possible something
> > has leaked into the VHE code).
> 
> IIUC in the window between local_irq_enable() and guest_exit() any driver
> interrupt might trigger, isn't it?

Yes, via the EL1 interrupt vectors, which I assume we'll fix in one go above.

Here I was trying to point out that there's another potential issue here if we
do anything in the context of the KVM exception vectors, as those can run C
code in a shallow exeption context, and can either return back into the guest
OR return to the caller of kvm_call_hyp_ret(__kvm_vcpu_run, vcpu).

So even if we fix kvm_arch_vcpu_ioctl_run() we might need to also rework
handlers that run in that shallow exception context, if they rely on RCU for
something.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
