Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BF02B3D2183
	for <lists+kvmarm@lfdr.de>; Thu, 22 Jul 2021 12:00:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4559D4B0C1;
	Thu, 22 Jul 2021 06:00:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-ihyigAhn+b; Thu, 22 Jul 2021 06:00:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F24EE4B098;
	Thu, 22 Jul 2021 06:00:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80A864B098
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Jul 2021 06:00:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEdSBh04Jvnw for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Jul 2021 06:00:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 793674A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Jul 2021 06:00:31 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1D2361241;
 Thu, 22 Jul 2021 10:00:28 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m6VVC-000F18-PY; Thu, 22 Jul 2021 11:00:26 +0100
Date: Thu, 22 Jul 2021 11:00:26 +0100
Message-ID: <874kcm3byd.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 00/16] KVM: arm64: MMIO guard PV services
In-Reply-To: <20210721214243.dy6d644yznuopuqx@gator>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210721214243.dy6d644yznuopuqx@gator>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com, vatsa@codeaurora.org,
 sdonthineni@nvidia.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, will@kernel.org,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, linux-kernel@vger.kernel.org,
 Shanker R Donthineni <sdonthineni@nvidia.com>, kernel-team@android.com,
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

On Wed, 21 Jul 2021 22:42:43 +0100,
Andrew Jones <drjones@redhat.com> wrote:
> 
> On Thu, Jul 15, 2021 at 05:31:43PM +0100, Marc Zyngier wrote:
> > KVM/arm64 currently considers that any memory access outside of a
> > memslot is a MMIO access. This so far has served us very well, but
> > obviously relies on the guest trusting the host, and especially
> > userspace to do the right thing.
> > 
> > As we keep on hacking away at pKVM, it becomes obvious that this trust
> > model is not really fit for a confidential computing environment, and
> > that the guest would require some guarantees that emulation only
> > occurs on portions of the address space that have clearly been
> > identified for this purpose.
> 
> This trust model is hard for me to reason about. userspace is trusted to
> control the life cycle of the VM, to prepare the memslots for the VM,
> and [presumably] identify what MMIO ranges are valid, yet it's not
> trusted to handle invalid MMIO accesses. I'd like to learn more about
> this model and the userspace involved.

Imagine the following scenario:

On top of the normal memory described as memslots (which pKVM will
ensure that userspace cannot access), a malicious userspace describes
to the guest another memory region in a firmware table and does not
back it with a memslot.

The hypervisor cannot validate this firmware description (imagine
doing ACPI and DT parsing at EL2...), so the guest starts using this
"memory" for something, and data slowly trickles all the way to EL0.
Not what you wanted.

To ensure that this doesn't happen, we reverse the problem: userspace
(and ultimately the EL1 kernel) doesn't get involved on a translation
fault outside of a memslot *unless* the guest has explicitly asked for
that page to be handled as a MMIO. With that, we have a full
description of the IPA space contained in the S2 page tables:

- memory described via a memslot,
- directly mapped device (GICv2, for exmaple),
- MMIO exposed for emulation

and anything else is an invalid access that results in an abort.

Does this make sense to you?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
