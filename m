Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5327A1EE48B
	for <lists+kvmarm@lfdr.de>; Thu,  4 Jun 2020 14:37:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B502F4B2BE;
	Thu,  4 Jun 2020 08:37:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGS4cfmUhwaV; Thu,  4 Jun 2020 08:37:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8CD2F4B2A2;
	Thu,  4 Jun 2020 08:37:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6981F4B17D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 08:37:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unJjGkHCuirp for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Jun 2020 08:37:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 69F6F4B10A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Jun 2020 08:37:53 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B85320772;
 Thu,  4 Jun 2020 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591274272;
 bh=6QcxAAL4gwrmylDybKVl57ya4Pza/LF9BD4toLBn6FQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hzi9UJiP7c5oXHJcbTdiMCNjjcwkY7jnEaR2Hgs0ss/GmeSeNMJsjyLd/AcykyvyV
 /p+4SyrAc0+3kHkLVT+Ad1GEqGvD0OW2B0OXvSzTPuq6IrCLn6ARIm1vTyij8HQthM
 Ega5NoTgtCP9nMpTjQazQmoEgGyK4hrJHgHMIsE4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jgp82-000FJI-Hz; Thu, 04 Jun 2020 13:37:50 +0100
MIME-Version: 1.0
Date: Thu, 04 Jun 2020 13:37:50 +0100
From: Marc Zyngier <maz@kernel.org>
To: Janne Karhunen <janne.karhunen@gmail.com>
Subject: Re: randomly firing kvm_arch_timer_handler
In-Reply-To: <CAE=Ncrb80uS5wtAu6e1Gctnu8tjcBEpWd7zHJv7aHdEkipe2FQ@mail.gmail.com>
References: <CAE=Ncrb80uS5wtAu6e1Gctnu8tjcBEpWd7zHJv7aHdEkipe2FQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <7d05e422cb61296fe372e0de3f1602b2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: janne.karhunen@gmail.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Janne,

On 2020-06-04 12:21, Janne Karhunen wrote:
> Hi,
> 
> I have an issue on one particular hardware with gicv3 and the old
> stable (4.9.22x) kernel where the timer interrupt randomly leaks to
> the host after the guest exit and the kvm_arch_timer_handler gets
> triggered. The guest does run, but the whine (unexpected interrupt) is
> annoying and it seems to be hindering the performance drastically - of
> both the host and the guest. This behavior can even lead to the host
> watchdog biting as the firing timer prevents the progress, especially
> during the very early boot when the guest is doing heavy paging
> anyway.

The only system I witnessed this was a Cavium TX1. It seems incredibly
bad at retiring an interrupt that has been masked at the source.
Which hardware is that?

> Based on the comment in the latest code the fundamental issue is that
> the interrupt controller does not recognize the timer disable fast
> enough on guest exit.
> 
> Has anyone worked on a proper fix for the issue
> for the old stable series? 5+ kernels seem to have quite a drastic
> rework on this front. Plain 'isb' did not seem to do the trick after
> the timer disable...

ISB really has no bearing on how an interrupt gets retired from the
redistributor. The flow we use on mainline these days makes it less
susceptible to this kind of brokenness, but it is still possible to
hit it.

In general, 4.9 is getting pretty old, and only gets things like
security fixes. Quality of emulation issues are definitely not
getting backported.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
