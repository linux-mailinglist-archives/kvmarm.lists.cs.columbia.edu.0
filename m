Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 91B1E3A98A7
	for <lists+kvmarm@lfdr.de>; Wed, 16 Jun 2021 13:03:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E1DB64B0AD;
	Wed, 16 Jun 2021 07:03:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HO4x-OZVqhtf; Wed, 16 Jun 2021 07:03:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B0F8A4B097;
	Wed, 16 Jun 2021 07:03:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C0164A523
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Jun 2021 07:03:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F6SyN37bncsd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Jun 2021 07:03:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D59B34A4A3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Jun 2021 07:03:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1F26610A3;
 Wed, 16 Jun 2021 11:03:13 +0000 (UTC)
Received: from [185.219.108.64] (helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1ltTKA-007vgz-En; Wed, 16 Jun 2021 12:03:11 +0100
Date: Wed, 16 Jun 2021 12:03:08 +0100
Message-ID: <87k0mum5qr.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Aman Priyadarshi <apeureka@amazon.de>
Subject: Re: KVM: arm64: pmu: Reset sample period on overflow handling
In-Reply-To: <094d40a0e7f5389ce5a13d96b96d4b7588c71d74.camel@amazon.de>
References: <322843db2f986f418d4175ca9c10e0904aa81d7a.camel@amazon.de>
 <87lf7bhxcf.wl-maz@kernel.org>
 <131663dbe335646ac952c55d6271022a42fa382f.camel@amazon.de>
 <87lf7am77t.wl-maz@kernel.org>
 <094d40a0e7f5389ce5a13d96b96d4b7588c71d74.camel@amazon.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: apeureka@amazon.de, kvmarm@lists.cs.columbia.edu,
 graf@amazon.com, alisaidi@amazon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Alexander Graf <graf@amazon.com>, kvmarm@lists.cs.columbia.edu, Ali
 Saidi <alisaidi@amazon.com>
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

On Wed, 16 Jun 2021 11:52:42 +0100,
Aman Priyadarshi <apeureka@amazon.de> wrote:
> 
> On Wed, 2021-06-16 at 11:31 +0100, Marc Zyngier wrote:
> > 
> > Hi Aman,
> > 
> > On Wed, 16 Jun 2021 10:17:28 +0100,
> > Aman Priyadarshi <apeureka@amazon.de> wrote:
> > > 
> > > Hi Marc,
> > > 
> > > On Tue, 2021-06-15 at 18:05 +0100, Marc Zyngier wrote:
> > > > 
> > > > Can you reproduce the issue with vanilla guest kernels? It'd be
> > > > interesting to understand what makes it work on the guest side. Can
> > > > you please bisect it?
> > > > 
> > > 
> > > yes, I was able to narrow it down to the commit 0cbb058be904 ("arm64:
> > > perf:
> > > Disable PMU while processing counter overflows"), which fixes the
> > > problem
> > > on the guest side.
> > 
> > Which is 3cce50dfec4a5b0414c974190940f47dd32c6dee in mainline. This
> > doesn't seem to have ever been backported before 4.18. So I don't know
> > why your 4.15 kernel was correctly behaving, but it could be that the
> > distro had randomly picked up the correct patch!
> 
> Yes. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836117

Right. I guess that's their "value add".

> > You may want to backport it to 4.14.y and let Greg know about that.
> > 
> 
> Ack.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
