Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D70C434ABD
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 16:46:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 822724A517;
	Tue,  4 Jun 2019 10:46:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FvR520equ304; Tue,  4 Jun 2019 10:46:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A044E4A52A;
	Tue,  4 Jun 2019 10:46:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DA3C4A4FF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EMsSIluxLnvx for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 10:46:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 029B34A4FA
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 10:46:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF3F341;
 Tue,  4 Jun 2019 07:46:30 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114473F690;
 Tue,  4 Jun 2019 07:46:28 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v1 3/6] KVM: arm64: Defer guest entry when an asynchronous
 exception is pending
Date: Tue,  4 Jun 2019 15:45:48 +0100
Message-Id: <20190604144551.188107-4-james.morse@arm.com>
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

SError that occur during world-switch's entry to the guest will be
accounted to the guest, as the exception is masked until we enter the
guest... but we want to attribute the SError as precisely as possible.

Reading DISR_EL1 before guest entry requires free registers, and using
ESB+DISR_EL1 to consume and read back the ESR would leave KVM holding
a host SError... We would rather leave the SError pending and let the
host take it once we exit world-switch. To do this, we need to defer
guest-entry if an SError is pending.

Read the ISR to see if SError (or an IRQ) is pending. If so fake an
exit. Place this check between __guest_enter()'s save of the host
registers, and restore of the guest's. SError that occur between
here and the eret into the guest must have affected the guest's
registers, which we can naturally attribute to the guest.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kvm/hyp/entry.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 7863ec5266e2..fa39899fe3d0 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -63,6 +63,16 @@ ENTRY(__guest_enter)
 	// Store the host regs
 	save_callee_saved_regs x1
 
+	// Now the host state is stored if we have a pending RAS SError it must
+	// affect the host. If any asynchronous exception is pending we defer
+	// the guest entry.
+	dsb	nshst
+	mrs	x1, isr_el1
+	cbz	x1,  1f
+	mov	x0, #ARM_EXCEPTION_IRQ
+	ret
+
+1:
 	add	x18, x0, #VCPU_CONTEXT
 
 	// Macro ptrauth_switch_to_guest format:
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
