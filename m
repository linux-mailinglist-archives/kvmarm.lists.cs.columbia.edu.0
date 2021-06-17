Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2121A3AB357
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 14:13:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A4764A98B;
	Thu, 17 Jun 2021 08:13:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2MTqzZ5z2I1; Thu, 17 Jun 2021 08:13:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B51F4A7FD;
	Thu, 17 Jun 2021 08:13:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 051A04A2E5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 08:13:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZLq-oXjLTtd for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 08:13:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C50064A1A7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 08:13:28 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C580D610EA;
 Thu, 17 Jun 2021 12:13:24 +0000 (UTC)
Date: Thu, 17 Jun 2021 13:13:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v15 0/7] MTE support for KVM guest
Message-ID: <20210617121322.GC6314@arm.com>
References: <20210614090525.4338-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210614090525.4338-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Mon, Jun 14, 2021 at 10:05:18AM +0100, Steven Price wrote:
> I realise there are still open questions[1] around the performance of
> this series (the 'big lock', tag_sync_lock, introduced in the first
> patch). But there should be no impact on non-MTE workloads and until we
> get real MTE-enabled hardware it's hard to know whether there is a need
> for something more sophisticated or not. Peter Collingbourne's patch[3]
> to clear the tags at page allocation time should hide more of the impact
> for non-VM cases. So the remaining concern is around VM startup which
> could be effectively serialised through the lock.
[...]
> [1]: https://lore.kernel.org/r/874ke7z3ng.wl-maz%40kernel.org

Start-up, VM resume, migration could be affected by this lock, basically
any time you fault a page into the guest. As you said, for now it should
be fine as long as the hardware doesn't support MTE or qemu doesn't
enable MTE in guests. But the problem won't go away.

We have a partial solution with an array of locks to mitigate against
this but there's still the question of whether we should actually bother
for something that's unlikely to happen in practice: MAP_SHARED memory
in guests (ignoring the stage 1 case for now).

If MAP_SHARED in guests is not a realistic use-case, we have the vma in
user_mem_abort() and if the VM_SHARED flag is set together with MTE
enabled for guests, we can reject the mapping.

We can discuss the stage 1 case separately from this series.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
