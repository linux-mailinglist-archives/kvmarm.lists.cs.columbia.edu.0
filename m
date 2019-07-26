Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0E774C0
	for <lists+kvmarm@lfdr.de>; Sat, 27 Jul 2019 00:58:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8488D4A55D;
	Fri, 26 Jul 2019 18:58:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cn2tkvd8uf3q; Fri, 26 Jul 2019 18:58:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EF014A541;
	Fri, 26 Jul 2019 18:58:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E5EC4A52F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 18:58:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xschhcOfC7hM for <kvmarm@lists.cs.columbia.edu>;
 Fri, 26 Jul 2019 18:58:47 -0400 (EDT)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F2CB24A51C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 18:58:46 -0400 (EDT)
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1hr9Ad-00042J-5J; Sat, 27 Jul 2019 00:58:40 +0200
Date: Sat, 27 Jul 2019 00:58:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: KVM Arm64 and Linux-RT issues
In-Reply-To: <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
Message-ID: <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
References: <b9867c43-7fe3-5d64-9939-b1a7ab7f1061@arm.com>
 <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 Julien Grall <julien.grall@arm.com>, anna-maria@linutronix.de,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On Wed, 24 Jul 2019, Marc Zyngier wrote:
> On 23/07/2019 18:58, Julien Grall wrote:
> It really feels like a change in hrtimer_cancel semantics. From what I
> understand, this is used to avoid racing against the softirq, but boy it
> breaks things.
> 
> If this cannot be avoided, this means we can't cancel the background
> timer (which is used to emulate the vcpu timer while it is blocked
> waiting for an interrupt), then we must move this canceling to the point
> where the vcpu is unblocked (instead of scheduled), which may have some
> side effects -- I'll have a look.
> 
> But that's not the only problem: We also have hrtimers used to emulate
> timers while the vcpu is running, and these timers are canceled in
> kvm_timer_vcpu_put(), which is also called from a preempt notifier.
> Unfortunately, I don't have a reasonable solution for that (other than
> putting this hrtimer_cancel in a workqueue and start chasing the
> resulting races).

The fix is simple. See below. We'll add that to the next RT release. That
will take a while as I'm busy with posting RT stuff for upstream :)

Thanks,

	tglx

8<------------
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -80,7 +80,7 @@ static inline bool userspace_irqchip(str
 static void soft_timer_start(struct hrtimer *hrt, u64 ns)
 {
 	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns),
-		      HRTIMER_MODE_ABS);
+		      HRTIMER_MODE_ABS_HARD);
 }
 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
