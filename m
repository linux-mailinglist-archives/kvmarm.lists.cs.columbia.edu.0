Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDF41E48D
	for <lists+kvmarm@lfdr.de>; Fri,  1 Oct 2021 01:02:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3B0F4B09C;
	Thu, 30 Sep 2021 19:02:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linutronix.de
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(invalid, unsupported algorithm ed25519-sha256)
	header.i=@linutronix.de
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzSufDTeYD-3; Thu, 30 Sep 2021 19:02:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A6354A534;
	Thu, 30 Sep 2021 19:02:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 67E764A19F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Sep 2021 19:02:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zGDFt7-kUPOy for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Sep 2021 19:02:26 -0400 (EDT)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E82754079A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Sep 2021 19:02:25 -0400 (EDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1633042944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aleerACiGlPLwzVtk/B1tjYHOmPxqoYPlz9VPbhU1zg=;
 b=f3YZlCl+ncZJeCnHbUAMI3Hly6FBQOrY5J+xmZRee/mK0xXN6dudy2ijkNTJTVxJs2DVy2
 khFPSZX3W3b9S4hx5UAkiQZjupSAExQoDooa3nW9b5pchM7hlGp+93kgeOOjP7vudaz/mF
 QW0Mt/uKXqjrenRCjxz/dNm7lHGRRcedvJFOdKfoUHINmzxksTGwbZlmFAN6L348BjT6oY
 EZJNetMjQEhPvxNweE/BEt2D72KWmPlc1YG4yNAEKmAZxo2Bk1HRiGkHW1qwOibT8jxNUJ
 zyRvpzf3oYcj499+e2CCR5nAlsAl+v/n3ALy417XYr10mEFPzXHaisWWudWtEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1633042944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aleerACiGlPLwzVtk/B1tjYHOmPxqoYPlz9VPbhU1zg=;
 b=ytW4IkUve0WFFt51OHnVUbHpXv6lmIXT/DHOOBVcEd2tZGV9DLSz9/pD2iXSuLznusAwPx
 WCNi8N5j86kaJXDQ==
To: Marcelo Tosatti <mtosatti@redhat.com>, Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v8 4/7] KVM: x86: Report host tsc and realtime values in
 KVM_GET_CLOCK
In-Reply-To: <20210930192107.GB19068@fuller.cnet>
References: <20210916181538.968978-1-oupton@google.com>
 <20210916181538.968978-5-oupton@google.com>
 <20210929185629.GA10933@fuller.cnet> <20210930192107.GB19068@fuller.cnet>
Date: Fri, 01 Oct 2021 01:02:23 +0200
Message-ID: <871r557jls.ffs@tglx>
MIME-Version: 1.0
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Marcelo,

On Thu, Sep 30 2021 at 16:21, Marcelo Tosatti wrote:
> On Wed, Sep 29, 2021 at 03:56:29PM -0300, Marcelo Tosatti wrote:
>> On Thu, Sep 16, 2021 at 06:15:35PM +0000, Oliver Upton wrote:
>> 
>> Thomas, CC'ed, has deeper understanding of problems with 
>> forward time jumps than I do. Thomas, any comments?
>
> Based on the earlier discussion about the problems of synchronizing
> the guests clock via a notification to the NTP/Chrony daemon 
> (where there is a window where applications can read the stale
> value of the clock), a possible solution would be triggering
> an NMI on the destination (so that it runs ASAP, with higher
> priority than application/kernel).
>
> What would this NMI do, exactly?

Nothing. You cannot do anything time related in an NMI.

You might queue irq work which handles that, but that would still not
prevent user space or kernel space from observing the stale time stamp
depending on the execution state from where it resumes.

>> As a note: this makes it not OK to use KVM_CLOCK_REALTIME flag 
>> for either vm pause / vm resume (well, if paused for long periods of time) 
>> or savevm / restorevm.
>
> Maybe with the NMI above, it would be possible to use
> the realtime clock as a way to know time elapsed between
> events and advance guest clock without the current 
> problematic window.

As much duct tape you throw at the problem, it cannot be solved ever
because it's fundamentally broken. All you can do is to make the
observation windows smaller, but that's just curing the symptom.

The problem is that the guest is paused/resumed without getting any
information about that and the execution of the guest is stopped at an
arbitrary instruction boundary from which it resumes after migration or
restore. So there is no way to guarantee that after resume all vCPUs are
executing in a state which can handle that.

But even if that would be the case, then what prevents the stale time
stamps to be visible? Nothing:

T0:    t = now();
         -> pause
         -> resume
         -> magic "fixup"
T1:    dostuff(t);

But that's not a fundamental problem because every preemptible or
interruptible code has the same issue:

T0:    t = now();
         -> preemption or interrupt
T1:    dostuff(t);

Which is usually not a problem, but It becomes a problem when T1 - T0 is
greater than the usual expectations which can obviously be trivially
achieved by guest migration or a savevm, restorevm cycle.

But let's go a step back and look at the clocks and their expectations:

CLOCK_MONOTONIC:

  Monotonically increasing clock which counts unless the system
  is in suspend. On resume it continues counting without jumping
  forward.

  That's the reference clock for everything else and therefore it
  is important that it does _not_ jump around.

  The reasons why CLOCK_MONOTONIC stops during suspend is
  historical and any attempt to change that breaks the world and
  some more because making it jump forward will trigger all sorts
  of timeouts, watchdogs and whatever. The last attempt to make
  CLOCK_MONOTONIC behave like CLOCK_BOOTTIME was reverted within 3
  weeks. It's not going to be attempted again. See a3ed0e4393d6
  ("Revert: Unify CLOCK_MONOTONIC and CLOCK_BOOTTIME") for
  details.

  Now the proposed change is creating exactly the same problem:

  >> > +	if (data.flags & KVM_CLOCK_REALTIME) {
  >> > +		u64 now_real_ns = ktime_get_real_ns();
  >> > +
  >> > +		/*
  >> > +		 * Avoid stepping the kvmclock backwards.
  >> > +		 */
  >> > +		if (now_real_ns > data.realtime)
  >> > +			data.clock += now_real_ns - data.realtime;
  >> > +	}

  IOW, it takes the time between pause and resume into account and
  forwards the underlying base clock which makes CLOCK_MONOTONIC
  jump forward by exactly that amount of time.

  So depending on the size of the delta you are running into exactly the
  same problem as the final failed attempt to unify CLOCK_MONOTONIC and
  CLOCK_BOOTTIME which btw. would have been a magic cure for virt.

  Too bad, not going to happen ever unless you fix all affected user
  space and kernel side issues.


CLOCK_BOOTTIME:

  CLOCK_MONOTONIC + time spent in suspend


CLOCK_REALTIME/TAI:

  CLOCK_MONOTONIC + offset

  The offset is established by reading RTC at boot time and can be
  changed by clock_settime(2) and adjtimex(2). The latter is used
  by NTP/PTP.

  Any user of CLOCK_REALTIME has to be prepared for it to jump in
  both directions, but of course NTP/PTP daemons have expectations
  vs. such time jumps.

  They rightfully assume on a properly configured and administrated
  system that there are only two things which can make CLOCK_REALTIME
  jump:

  1) NTP/PTP daemon controlled
  2) Suspend/resume related updates by the kernel


Just for the record, these assumptions predate virtualization.

So now virt came along and created a hard to solve circular dependency
problem:

   - If CLOCK_MONOTONIC stops for too long then NTP/PTP gets out of
     sync, but everything else is happy.
     
   - If CLOCK_MONOTONIC jumps too far forward, then all hell breaks
     lose, but NTP/PTP is happy.

IOW, you are up a creek without a paddle and you have to chose one evil.

That's simply a design fail because there has been no design for this
from day one. But I'm not surprised at all by that simply because
virtualization followed the hardware design fails vs. time and
timekeeping which keep us entertained for the past 20 years on various
architectures but most prominently on X86 which is the uncontended
master of disaster in that regard.

Of course virt follows the same approach of hardware by ignoring the
problem and coming up with more duct tape and the assumption that lack
of design can be "fixed in software". Just the timeframe is slightly
different: We're discussing this only for about 10 years now.

Seriously? All you folks can come up with in 10 years is piling duct
tape on duct tape instead of sitting down and fixing the underlying root
cause once and forever?

I'm aware that especially chrony has tried to deal with this nonsense
more gracefully, but that still does not make it great and it still gets
upset.

The reason why suspend/resume works perfectly fine is that it's fully
coordinated and NTP state is cleared on resume which makes it easy for
the deamon to accomodate.

So again and I'm telling this for a decade now:

 1) Stop pretending that you can fix the lack of design with duct tape
    engineering

 2) Accept the fundamental properties of Linux time keeping as they are
    not going to change as explained above

 3) Either accept that CLOCK_REALTIME is off and jumping around which
    confuses NTP/PTP or get your act together and design and implement a
    proper synchronization mechanism for this:

    - Notify the guest about the intended "pause" or "savevm" event

    - Let the guest go into a lightweight freeze similar to S2IDLE

    - Save the VM for later resume or migrate the saved state

    - Watch everything working as expected on resume

    - Have the benefit that pause/resume and savevm/restorevm have
      exactly the same behaviour

That won't solve the problem for frankenkernels and !paravirt setups,
but that's unsolvable and you can keep the pieces by chosing one of two
evils. While I do not care at all, I still recommend to chose
CLOCK_MONOTONIC correctness for obvious reasons.

The frankenkernel/legacy problem aside, I know you are going to tell me
that this is too much overhead and has VM customer visible impact. It's
your choice, really:

  Either you chose correctness or you decide to ignore correctness for
  whatever reason.

  There is no middle ground simply because you _cannot_ guarantee that
  your migration time is within the acceptable limits of the
  CLOCK_MONOTONIC or the CLOCK_REALTIME expectations.

  You can limit the damage somehow by making some arbitrary cutoff of
  how much you forward CLOCK_MONOTONIC, but don't ask me about the right
  value.

If you decide that correctness is overrated, then please document it
clearly instead of trying to pretend being correct.

I'm curious whether the hardware people or the virt folks come to senses
first, but honestly I'm not expecting this to happen before I retire.

Thanks,

        tglx


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
