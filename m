Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8755047A078
	for <lists+kvmarm@lfdr.de>; Sun, 19 Dec 2021 13:12:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B47F4B2D8;
	Sun, 19 Dec 2021 07:12:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WpW3tLxbnX8S; Sun, 19 Dec 2021 07:12:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47A234B303;
	Sun, 19 Dec 2021 07:12:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D209B4B316
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Dec 2021 12:47:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LkL5qT0TiIqe for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Dec 2021 12:47:32 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 75C854B30A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Dec 2021 12:47:32 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id DC50DCE2413;
 Fri, 17 Dec 2021 17:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1637DC36AE8;
 Fri, 17 Dec 2021 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639763246;
 bh=wGI+t0gS/hdl+/rz+vVaZZWkZGtQrHWcAbdHNmxiEVw=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=qfeFqtNSoGdqKHEWsC1tOxLxD+nqSLNiEA7cVVH/qW1sLgxx/GqTADt/k6kekO2vn
 JvwkmrEPf4UQFnx4d5DPI9igP5hDgepKos+O1+8041yZRIPfr8od/MTJDJYS1Y/1r1
 nqzR6L7w97ibIzzL8vJIVTz0z7nfwr53oFoGkFm9moA6AsvPJYbUqwsOUYKv/QEWN1
 wYvMeu5o04gOKboPV5El3dTNl1c6fNYkAZPUjcHP0nU2GT+eBUXb2c1KtFMwqiYVOb
 KSZbDouSbIpovqGusvbPBFJCNl9KzDsAXifpCHuQQ24at3BqtZM6mWjFpoyc7PthCb
 U5KN3B1GEhdyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id C078B5C0610; Fri, 17 Dec 2021 09:47:25 -0800 (PST)
Date: Fri, 17 Dec 2021 09:47:25 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Message-ID: <20211217174725.GX641268@paulmck-ThinkPad-P17-Gen-1>
References: <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
 <f3d6095a-70aa-3da0-08a6-3caff2638809@redhat.com>
 <20211217164535.GU641268@paulmck-ThinkPad-P17-Gen-1>
 <4c369ca2-2ad0-4a02-90e9-2d82df6c289d@redhat.com>
 <20211217171218.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <24268298-c51f-afcd-72e2-22c39eb002b5@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24268298-c51f-afcd-72e2-22c39eb002b5@redhat.com>
X-Mailman-Approved-At: Sun, 19 Dec 2021 07:12:12 -0500
Cc: maz <maz@kernel.org>, frederic <frederic@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvmarm@lists.cs.columbia.edu,
 rcu <rcu@vger.kernel.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: paulmck@kernel.org
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

On Fri, Dec 17, 2021 at 06:23:32PM +0100, Paolo Bonzini wrote:
> On 12/17/21 18:12, Paul E. McKenney wrote:
> > On Fri, Dec 17, 2021 at 06:02:23PM +0100, Paolo Bonzini wrote:
> > > On 12/17/21 17:45, Paul E. McKenney wrote:
> > > > On Fri, Dec 17, 2021 at 05:34:04PM +0100, Paolo Bonzini wrote:
> > > > > On 12/17/21 17:07, Paul E. McKenney wrote:
> > > > > > > rcu_note_context_switch() is a point-in-time notification; it's not strictly
> > > > > > > necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> > > > > > > from the RCU subsystem.
> > > > > > > 
> > > > > > > There's no benefit from doing it when you're back from the guest, because at
> > > > > > > that point the CPU is just running normal kernel code.
> > > > > > 
> > > > > > Do scheduling-clock interrupts from guest mode have the "user" parameter
> > > > > > set?  If so, that would keep RCU happy.
> > > > > 
> > > > > No, thread is in supervisor mode.  But after every interrupt (timer tick or
> > > > > anything), one of three things can happen:
> > > > > 
> > > > > * KVM will go around the execution loop and invoke rcu_note_context_switch()
> > > > > again
> > > > > 
> > > > > * or KVM will go back to user space
> > > > 
> > > > Here "user space" is a user process as opposed to a guest OS?
> > > 
> > > Yes, that code runs from ioctl(KVM_RUN) and the ioctl will return to the
> > > calling process.
> > 
> > Intriguing.  A user process within the guest OS or a user process outside
> > of any guest OS, that is, within the host?
> 
> A user process on the host.  The guest vCPU is nothing special: it's just a
> user thread that occasionally lets the guest run by invoking the KVM_RUN
> ioctl.  Hopefully, KVM_RUN will be where that user thread will spend most of
> the time so the guest runs at full steam.  KVM_RUN is the place where you
> have the code that Nicolas and Mark were discussing.
> 
> From the point of view of the kernel however the thread is always in kernel
> mode when it runs the guest, because any interrupt will be recognized while
> still in the ioctl.
> 
> (I'll add that from the point of view of the scheduler, there's no
> difference between a CPU-bound guest and a "normal" CPU-bound process on the
> host, e.g. wasting time with "for(;;)" or calculating digits of PI is the
> same no matter if you're doing it in the guest or in the host. Likewise for
> I/O-bound guests; e.g. doing "hlt" or "wfi" constantly in the guest looks
> exactly the same to the scheduler as a process that spends its time in the
> poll() system call).

Thank you for the explanation!

							Thanx, Paul
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
