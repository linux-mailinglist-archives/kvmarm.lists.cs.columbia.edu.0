Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3549041F69D
	for <lists+kvmarm@lfdr.de>; Fri,  1 Oct 2021 23:03:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 80C234B0D7;
	Fri,  1 Oct 2021 17:03:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sX172XkoVATv; Fri,  1 Oct 2021 17:03:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21B444B0E2;
	Fri,  1 Oct 2021 17:03:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A57CB4B0C3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 17:03:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oUgSSWjYyqUb for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Oct 2021 17:03:50 -0400 (EDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5770B4048B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 17:03:50 -0400 (EDT)
Received: by mail-lf1-f54.google.com with SMTP id b20so43767874lfv.3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 01 Oct 2021 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=US7THjs9q8+dC6lBnfN2W9f1a9lLVsXtHL76JHwld78=;
 b=LEHHXQQrqHueraWXN4QJAj9D834jvqNGLG7RicSBdHd9m2si5c+mnQn40cjGjWM3t4
 ZpFeMi4i5i3rpTiH3hSI/M/2Zm3I08Dm6clnPWH1yBvFjvLfu132ub7eTqs4YpM10V7a
 lTTc9ffz0ryonTNmL/nAJg8f1EBpmFlhmTGHuFMlm7picAw5bafsvoB1TQzM/Y7zt0jW
 wCpZYgm8Nt739gBMaAX8Yb06Sp1bUjR5lGxvvUFf9cGYRh6FYwCRxNfmUdDVpwvG6z7a
 8KT60fu7tEv8nCbjPx44+D+6j2dj0EzazJ3JRD49too+EAFLxHSIar0SaJvMdKCbvS39
 uoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=US7THjs9q8+dC6lBnfN2W9f1a9lLVsXtHL76JHwld78=;
 b=YFgk9C5rphTS4BP/1HdHBa6vvxdAMToInu0mfEP1Zqf4pS15RTzhsB3dUpepFARciV
 C6FiamBnJtODO19IUchJVS4wiH50vCascHWXaXPMFEkaIbRhisxFqdjoqDb7umMSfgcO
 1JRv4oZI/GFqg+VtE9Bzlw3jxn8GwCuoAP9sHrZ2ZNN++N/23TUAWoiRJI6exTMbTcoz
 +3juxi8IMBns6fXDiYNfO516jpF17bimDqNLXruoJM065RVNw6wWyMsFge7f3ZNYtvRV
 mBdtdoVW1r5N1+qq3y/Ii0YiAZrQVT148VR3xX6g61Qu64XnN+gBf0t2p0sV0VHFyxIf
 AMFw==
X-Gm-Message-State: AOAM530WU3LLq7zxTGqEae8S3zroyOCNkhkSMSH5TdoruXwRLUkHC/+Z
 LbCQdIXTxtolkqq1NdgEgMtmkfINoCGB+mxYgwimZw==
X-Google-Smtp-Source: ABdhPJznCcQb+ccwGsDLyERyb3W3qjFR7Oa5Aa/Z4+L5spmUTbANL6wSIlWbkIDv6JUkIXl+ke4fitW2VkDiMn4VEeU=
X-Received: by 2002:a2e:5c88:: with SMTP id q130mr189882ljb.170.1633122228750; 
 Fri, 01 Oct 2021 14:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210916181538.968978-1-oupton@google.com>
 <20210916181538.968978-5-oupton@google.com>
 <20210929185629.GA10933@fuller.cnet> <20210930192107.GB19068@fuller.cnet>
 <871r557jls.ffs@tglx> <20211001120527.GA43086@fuller.cnet>
 <87ilyg4iu9.ffs@tglx>
In-Reply-To: <87ilyg4iu9.ffs@tglx>
From: Oliver Upton <oupton@google.com>
Date: Fri, 1 Oct 2021 14:03:37 -0700
Message-ID: <CAOQ_Qsgq9t3syQkQaorszBvg07XOhOmWJeMF=bQN8HqMPo4ADQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] KVM: x86: Report host tsc and realtime values in
 KVM_GET_CLOCK
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Peter Shier <pshier@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

Hi Thomas,

On Fri, Oct 1, 2021 at 12:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Marcelo,
>
> On Fri, Oct 01 2021 at 09:05, Marcelo Tosatti wrote:
> > On Fri, Oct 01, 2021 at 01:02:23AM +0200, Thomas Gleixner wrote:
> >> But even if that would be the case, then what prevents the stale time
> >> stamps to be visible? Nothing:
> >>
> >> T0:    t = now();
> >>          -> pause
> >>          -> resume
> >>          -> magic "fixup"
> >> T1:    dostuff(t);
> >
> > Yes.
> >
> > BTW, you could have a userspace notification (then applications
> > could handle this if desired).
>
> Well, we have that via timerfd with TFD_TIMER_CANCEL_ON_SET for
> CLOCK_REALTIME. That's what applications which are sensitive to clock
> REALTIME jumps use today.
>
> >>   Now the proposed change is creating exactly the same problem:
> >>
> >>   >> > +     if (data.flags & KVM_CLOCK_REALTIME) {
> >>   >> > +             u64 now_real_ns = ktime_get_real_ns();
> >>   >> > +
> >>   >> > +             /*
> >>   >> > +              * Avoid stepping the kvmclock backwards.
> >>   >> > +              */
> >>   >> > +             if (now_real_ns > data.realtime)
> >>   >> > +                     data.clock += now_real_ns - data.realtime;
> >>   >> > +     }
> >>
> >>   IOW, it takes the time between pause and resume into account and
> >>   forwards the underlying base clock which makes CLOCK_MONOTONIC
> >>   jump forward by exactly that amount of time.
> >
> > Well, it is assuming that the
> >
> >  T0:    t = now();
> >  T1:    pause vm()
> >  T2:  finish vm migration()
> >  T3:    dostuff(t);
> >
> > Interval between T1 and T2 is small (and that the guest
> > clocks are synchronized up to a given boundary).
>
> Yes, I understand that, but it's an assumption and there is no boundary
> for the time jump in the proposed patches, which rings my alarm bells :)
>
> > But i suppose adding a limit to the forward clock advance
> > (in the migration case) is useful:
> >
> >       1) If migration (well actually, only the final steps
> >          to finish migration, the time between when guest is paused
> >          on source and is resumed on destination) takes too long,
> >          then too bad: fix it to be shorter if you want the clocks
> >          to have close to zero change to realtime on migration.
> >
> >       2) Avoid the other bugs in case of large forward advance.
> >
> > Maybe having it configurable, with a say, 1 minute maximum by default
> > is a good choice?
>
> Don't know what 1 minute does in terms of applications etc. You have to
> do some experiments on that.

I debated quite a bit on what the absolute limit should be for
advancing the KVM clock, and settled on doing no checks in the kernel
besides the monotonicity invariant. End of the day, userspace can
ignore all of the rules that KVM will try to enforce on the kvm
clock/TSC and jump it as it sees fit (both are already directly
writable). But I agree that there has to be some reason around what is
acceptable. We have an absolute limit on how far forward we will yank
the KVM clock and TSC in our userspace, but of course it has a TOCTOU
problem for whatever madness can come in between userspace and the
time the kernel actually services the ioctl.

--
Thanks,
Oliver


> > An alternative would be to advance only the guests REALTIME clock, from
> > data about how long steps T1-T2 took.
>
> Yes, that's what would happen in the cooperative S2IDLE or S3 case when
> the guest resumes.
>
> >> So now virt came along and created a hard to solve circular dependency
> >> problem:
> >>
> >>    - If CLOCK_MONOTONIC stops for too long then NTP/PTP gets out of
> >>      sync, but everything else is happy.
> >>
> >>    - If CLOCK_MONOTONIC jumps too far forward, then all hell breaks
> >>      lose, but NTP/PTP is happy.
> >
> > One must handle the
> >
> >  T0:    t = now();
> >           -> pause
> >           -> resume
> >           -> magic "fixup"
> >  T1:    dostuff(t);
> >
> > fact if one is going to use savevm/restorevm anyway, so...
> > (it is kind of unfixable, unless you modify your application
> > to accept notifications to redo any computation based on t, isnt it?).
>
> Well yes, but what applications can deal with is CLOCK_REALTIME jumping
> because that's a property of it. Not so much the CLOCK_MONOTONIC part.
>
> >> If you decide that correctness is overrated, then please document it
> >> clearly instead of trying to pretend being correct.
> >
> > Based on the above, advancing only CLOCK_REALTIME (and not CLOCK_MONOTONIC)
> > would be correct, right? And its probably not very hard to do.
>
> Time _is_ hard to get right.
>
> So you might experiment with something like this as a stop gap:
>
>   Provide the guest something like this:
>
>           u64              migration_seq;
>           u64              realtime_delta_ns;
>
>   in the shared clock page
>
>   Do not forward jump clock MONOTONIC.
>
>   On resume kick an IPI where the guest handler does:
>
>          if (clock_data->migration_seq == migration_seq)
>                 return;
>
>          migration_seq = clock_data->migration_seq;
>
>          ts64 = { 0, 0 };
>          timespec64_add_ns(&ts64, clock_data->realtime_delta_ns);
>          timekeeping_inject_sleeptime64(&ts64);
>
>   Make sure that the IPI completes before you migrate the guest another
>   time or implement it slightly smarter, but you get the idea :)
>
> That's what we use for suspend time injection, but it should just work
> without frozen tasks as well. It will forward clock REALTIME by the
> amount of time spent during migration. It'll also modify the BOOTTIME
> offset by the same amount, but that's not a tragedy.
>
> The function will also reset NTP state so the NTP/PTP daemon knows that
> there was a kernel initiated time jump and it can work out easily what
> to do like it does on resume from an actual suspend. It will also
> invoke clock_was_set() which makes all the other time related updates
> trigger and wakeup tasks which have a timerfd with
> TFD_TIMER_CANCEL_ON_SET armed.
>
> This will obviously not work when the guest is in S2IDLE or S3, but for
> initial experimentation you can ignore that and just avoid to do that in
> the guest. :)
>
> That still is worse than a cooperative S2IDLE/S3, but it's way more
> sensible than the other two evils you have today.
>
> > Thanks very much for the detailed information! Its a good basis
> > for the document you ask.
>
> I volunteer to review that documentation once it materializes :)
>
> Thanks,
>
>         tglx
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
