Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B646A34AC1
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 16:46:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6419B4A51B;
	Tue,  4 Jun 2019 10:46:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNwsiLj1MUJy; Tue,  4 Jun 2019 10:46:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AAC64A528;
	Tue,  4 Jun 2019 10:46:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEBF84A52E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQ6Mg7BsZGWz for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 10:46:37 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 75B444A51C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:37 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 206B815A2;
 Tue,  4 Jun 2019 07:46:37 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A42A3F690;
 Tue,  4 Jun 2019 07:46:35 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 6/6] KVM: arm64: Skip more of the SError vaxorcism
Date: Tue,  4 Jun 2019 15:45:51 +0100
Message-Id: <20190604144551.188107-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604144551.188107-1-james.morse@arm.com>
References: <20190604144551.188107-1-james.morse@arm.com>
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

Now that we've taken isr_el1 out of the box, there are a few more places
we could use it. During __guest_exit() we need to consume any SError left
pending by the guest so it doesn't contaminate the host. With v8.2 we use
the ESB-instruction. For systems without v8.2, we use dsb+isb and unmask
SError. We do this on every guest exit.

Use the same dsb+isr_el1 trick, this lets us know if an SError is pending
after the dsb, allowing us to skip the isb and self-synchronising PSTATE
write if its not.

This means SError remains masked during KVM's world-switch, so any SError
that occurs during this time is reported by the host, instead of causing
a hyp-panic.

As we're benchmarking this code lets polish the layout. If you give gcc
likely()/unlikely() hints in an if() condition, it shuffles the generated
assembly so that the likely case is immediately after the branch. Lets
do the same here.

Signed-off-by: James Morse <james.morse@arm.com>
---
Tested on A57 with v5.2-rc1, do_hvc from [0]
v5.2-rc1            mean:4339 stddev:33
v5.2-rc1+patches1-6 mean:4309 stddev:26
with series 0.69% faster
[0] https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvm-ws-tests.git/

 arch/arm64/kvm/hyp/entry.S | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index a5a4254314a1..c2de1a1faaf4 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -161,18 +161,24 @@ alternative_if ARM64_HAS_RAS_EXTN
 	orr	x0, x0, #(1<<ARM_EXIT_WITH_SERROR_BIT)
 1:	ret
 alternative_else
-	// If we have a pending asynchronous abort, now is the
-	// time to find out. From your VAXorcist book, page 666:
+	dsb	sy		// Synchronize against in-flight ld/st
+	mrs	x2, isr_el1
+	and	x2, x2, #(1<<8)	// ISR_EL1.A
+	cbnz	x2, 2f
+	ret
+
+2:
+	// We know we have a pending asynchronous abort, now is the
+	// time to flush it out. From your VAXorcist book, page 666:
 	// "Threaten me not, oh Evil one!  For I speak with
 	// the power of DEC, and I command thee to show thyself!"
 	mrs	x2, elr_el2
+alternative_endif
 	mrs	x3, esr_el2
 	mrs	x4, spsr_el2
 	mov	x5, x0
 
-	dsb	sy		// Synchronize against in-flight ld/st
 	msr	daifclr, #4	// Unmask aborts
-alternative_endif
 
 	// This is our single instruction exception window. A pending
 	// SError is guaranteed to occur at the earliest when we unmask
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
