Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71F45901C
	for <lists+kvmarm@lfdr.de>; Mon, 22 Nov 2021 15:21:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BFFB34B125;
	Mon, 22 Nov 2021 09:21:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6N-pnyh57wFD; Mon, 22 Nov 2021 09:21:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19E6B4B11C;
	Mon, 22 Nov 2021 09:21:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D38A4B0BA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 09:21:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4hEWAVSO0PdV for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Nov 2021 09:21:03 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A8F6C4079A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Nov 2021 09:21:03 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8113960240;
 Mon, 22 Nov 2021 14:21:02 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mpABo-0074Ov-Fq; Mon, 22 Nov 2021 14:21:00 +0000
Date: Mon, 22 Nov 2021 14:21:00 +0000
Message-ID: <871r386zlf.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 4/4] KVM: arm64: Refuse to run VCPU if the PMU doesn't
 match the physical CPU
In-Reply-To: <YZuJIUls8hl85Zia@monolith.localdoman>
References: <20211115165041.194884-1-alexandru.elisei@arm.com>
 <20211115165041.194884-5-alexandru.elisei@arm.com>
 <87bl2ds3ny.wl-maz@kernel.org>
 <YZuJIUls8hl85Zia@monolith.localdoman>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, james.morse@arm.com,
 suzuki.poulose@arm.com, will@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 peter.maydell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 22 Nov 2021 12:12:17 +0000,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> Hi Marc,
> 
> On Sun, Nov 21, 2021 at 07:35:13PM +0000, Marc Zyngier wrote:
> > On Mon, 15 Nov 2021 16:50:41 +0000,
> > Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > > 
> > > Userspace can assign a PMU to a VCPU with the KVM_ARM_VCPU_PMU_V3_SET_PMU
> > > device ioctl. If the VCPU is scheduled on a physical CPU which has a
> > > different PMU, the perf events needed to emulate a guest PMU won't be
> > > scheduled in and the guest performance counters will stop counting. Treat
> > > it as an userspace error and refuse to run the VCPU in this situation.
> > > 
> > > The VCPU is flagged as being scheduled on the wrong CPU in vcpu_load(), but
> > > the flag is cleared when the KVM_RUN enters the non-preemptible section
> > > instead of in vcpu_put(); this has been done on purpose so the error
> > > condition is communicated as soon as possible to userspace, otherwise
> > > vcpu_load() on the wrong CPU followed by a vcpu_put() could clear the flag.
> > 
> > Can we make this something orthogonal to the PMU, and get userspace to
> > pick an affinity mask independently of instantiating a PMU? I can
> > imagine this would also be useful for SPE on asymmetric systems.
> 
> I actually went this way for the latest version of the SPE series [1] and
> dropped the explicit userspace ioctl in favor of this mechanism.
> 
> The expectation is that userspace already knows which CPUs are associated
> with the chosen PMU (or SPE) when setting the PMU for the VCPU, and having
> userspace set it explicitely via an ioctl looks like an unnecessary step to
> me. I don't see other usecases of an explicit ioctl outside of the above
> two situation (if userspace wants a VCPU to run only on specific CPUs, it
> can use thread affinity for that), so I decided to drop it.

My problem with that is that if you have (for whatever reason) a set
of affinities that are not strictly identical for both PMU and SPE,
and expose both of these to a guest, what do you choose?

As long as you have a single affinity set to take care of, you're
good. It is when you have several ones that it becomes ugly (as with
anything involving asymmetric CPUs).

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
