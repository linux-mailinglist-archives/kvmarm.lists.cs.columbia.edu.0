Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6555C91869
	for <lists+kvmarm@lfdr.de>; Sun, 18 Aug 2019 19:42:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 782B04A5C4;
	Sun, 18 Aug 2019 13:42:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5SR04a+7x15; Sun, 18 Aug 2019 13:42:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64FBE4A5BA;
	Sun, 18 Aug 2019 13:42:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7ED154A5B3
 for <kvmarm@lists.cs.columbia.edu>; Sun, 18 Aug 2019 13:42:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TTWULTtDKAg0 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 18 Aug 2019 13:42:47 -0400 (EDT)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 511504A5AB
 for <kvmarm@lists.cs.columbia.edu>; Sun, 18 Aug 2019 13:42:47 -0400 (EDT)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why)
 by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
 (Exim 4.80) (envelope-from <maz@kernel.org>)
 id 1hzPCU-0007Qm-QH; Sun, 18 Aug 2019 19:42:43 +0200
Date: Sun, 18 Aug 2019 18:42:40 +0100
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64/kvm: remove VMID rollover I-cache maintenance
Message-ID: <20190818184240.507e0716@why>
In-Reply-To: <1dca0489-9e85-cb8f-b846-b6da65f41773@arm.com>
References: <20190806155737.39307-1-mark.rutland@arm.com>
 <1dca0489-9e85-cb8f-b846-b6da65f41773@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: james.morse@arm.com, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
 christoffer.dall@arm.com, kvmarm@lists.cs.columbia.edu,
 julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Fri, 16 Aug 2019 14:39:31 +0100
James Morse <james.morse@arm.com> wrote:

> Hi Mark,
> 
> On 06/08/2019 16:57, Mark Rutland wrote:
> > For VPIPT I-caches, we need I-cache maintenance on VMID rollover to
> > avoid an ABA problem. Consider a single vCPU VM, with a pinned stage-2,
> > running with an idmap VA->IPA and idmap IPA->PA. If we don't do
> > maintenance on rollover:
> > 
> >         // VMID A
> >         Writes insn X to PA 0xF
> >         Invalidates PA 0xF (for VMID A)
> > 
> >         I$ contains [{A,F}->X]
> > 
> >         [VMID ROLLOVER]
> > 
> >         // VMID B
> >         Writes insn Y to PA 0xF
> >         Invalidates PA 0xF (for VMID B)
> > 
> >         I$ contains [{A,F}->X, {B,F}->Y]
> > 
> >         [VMID ROLLOVER]
> > 
> >         // VMID A
> >         I$ contains [{A,F}->X, {B,F}->Y]
> > 
> >         Unexpectedly hits stale I$ line {A,F}->X.
> > 
> > However, for PIPT and VIPT I-caches, the VMID doesn't affect lookup or
> > constrain maintenance. Given the VMID doesn't affect PIPT and VIPT
> > I-caches, and given VMID rollover is independent of changes to stage-2
> > mappings, I-cache maintenance cannot be necessary on VMID rollover for
> > PIPT or VIPT I-caches.
> > 
> > This patch removes the maintenance on rollover for VIPT and PIPT
> > I-caches. At the same time, the unnecessary colons are removed from the
> > asm statement to make it more legible.  
> 
> Makes sense!
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Queued for 5.4. Thanks both.

	M.
-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
