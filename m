Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89934AB6
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 16:46:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9B44A519;
	Tue,  4 Jun 2019 10:46:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIzUb-WyLguS; Tue,  4 Jun 2019 10:46:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 456B74A512;
	Tue,  4 Jun 2019 10:46:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 45F744A4E5
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1WPAIJ8bn3f for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 10:46:22 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 678C94A418
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:22 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC93C341;
 Tue,  4 Jun 2019 07:46:21 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41CE73F690;
 Tue,  4 Jun 2019 07:46:20 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 0/6] KVM: arm64: Account host/guest SError more precisely
 (Neoverse-N1 #1349291)
Date: Tue,  4 Jun 2019 15:45:45 +0100
Message-Id: <20190604144551.188107-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

Hello!

v1? Yes: I intend to repost this with/without the last two patches
depending on whether anyone thinks they are needed, and should be considered
as part of this series, or separate.

This series started as a workaround for Neoverse-N1 #1349291, but has
become an improvement in RAS error accounting for KVM on arm64.

Neoverse-N1 affected by #1349291 may report an Uncontained RAS Errors
as Unrecoverable. [0] This is the difference between killing the thread and
killing the machine.
The workaround is to treat all Unrecoverable SError as Uncontained.
The arch code's SError handling already does this, due to its nascent
kernel-first support.

So only KVM needs some work as it has its own SError handling as we want
KVM to handle guest:SError and the host to handle host:SError.


Instead of working around the errata in KVM, we account SError as precisely
as we can instead. This means moving the ESB-instruction into the guest-exit
vectors, and deferring guest-entry if there is an SError pending. (so that the
host's existing handling takes it).

This is all good stuff, but it comes with the cost of a dsb in the
world-switch code. It's the non-RAS non-VHE systems that will see this
as costly. Benchmarked using kvm-ws-tests's do_hvc [1] on Seattle:

| v5.2-rc1            mean:4339 stddev:33
| v5.2-rc1+patches1-4 mean:4476 stddev: 2
| with series 3.15% slower


Patch 5 replaces this dsb with a nop if the system doesn't have v8.2
as these systems are unlikely to report errors in a way that we can
handle.

| 5.2-rc1+patches1-5 mean:4405 stddev:31
| with series 1.53% slower


Patch 6 applies the same ISR_EL1 trick to avoid unmasking SError on
guest-exit, which avoids a pstate-write and more system register reads.
I'm aware 'vaxorcism' isn't an english word...)

After all this:
| v5.2-rc1+patches1-6 mean:4309 stddev:26
| with series 0.69% faster


So for hardware that doesn't benefit from the extra work, we are back where
we started.

If the performance-game is valid, I intend to squash patch 5 into patch 3,
and post patch 6 independently. I don't think patch 6 should be backported,
but patch 5 would be fair game if its squashed in.


Thanks,

James

[0] account-required: https://developer.arm.com/docs/sden885747/latest/arm-neoverse-n1-mp050-software-developer-errata-notice
[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvm-ws-tests.git/

James Morse (6):
  KVM: arm64: Abstract the size of the HYP vectors pre-amble
  KVM: arm64: Consume pending SError as early as possible
  KVM: arm64: Defer guest entry when an asynchronous exception is
    pending
  arm64: Update silicon-errata.txt for Neoverse-N1 #1349291
  KVM: arm64: nop out dsb in __guest_enter() unless we have v8.2 RAS
  KVM: arm64: Skip more of the SError vaxorcism

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/include/asm/kvm_asm.h       |  6 +++++
 arch/arm64/kernel/traps.c              |  4 ++++
 arch/arm64/kvm/hyp/entry.S             | 33 ++++++++++++++++++++------
 arch/arm64/kvm/hyp/hyp-entry.S         | 12 +++++++++-
 arch/arm64/kvm/va_layout.c             |  7 +++---
 6 files changed, 51 insertions(+), 12 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
