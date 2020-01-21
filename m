Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC5CA143CF0
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 13:34:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E9EE4B007;
	Tue, 21 Jan 2020 07:34:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3VIzuj3WpkM; Tue, 21 Jan 2020 07:34:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E98ED4B010;
	Tue, 21 Jan 2020 07:34:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6A0A4AFA0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:34:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BnkuposDET15 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 07:34:08 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBC764AF88
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:34:08 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F5DD30E;
 Tue, 21 Jan 2020 04:34:08 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4FF3F6C4;
 Tue, 21 Jan 2020 04:34:07 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/2] KVM: arm: fix DFSR setting for non-LPAE aarch32 guests
Date: Tue, 21 Jan 2020 12:33:55 +0000
Message-Id: <20200121123356.203000-2-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121123356.203000-1-james.morse@arm.com>
References: <20200121123356.203000-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>
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

Beata reports that KVM_SET_VCPU_EVENTS doesn't inject the expected
exception to a non-LPAE aarch32 guest.

The host intends to inject DFSR.FS=0x14 "IMPLEMENTATION DEFINED fault
(Lockdown fault)", but the guest receives DFSR.FS=0x04 "Fault on
instruction cache maintenance". This fault is hooked by
do_translation_fault() since ARMv6, which goes on to silently 'handle'
the exception, and restart the faulting instruction.

It turns out, when TTBCR.EAE is clear DFSR is split, and FS[4] has
to shuffle up to DFSR[10].

As KVM only does this in one place, fix up the static values. We
now get the expected:
| Unhandled fault: lock abort (0x404) at 0x9c800f00

Reported-by: Beata Michalska <beata.michalska@linaro.org>
Fixes: 74a64a981662a ("KVM: arm/arm64: Unify 32bit fault injection")
Signed-off-by: James Morse <james.morse@arm.com>
---
 virt/kvm/arm/aarch32.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/aarch32.c b/virt/kvm/arm/aarch32.c
index c4c57ba99e90..942108b62cd3 100644
--- a/virt/kvm/arm/aarch32.c
+++ b/virt/kvm/arm/aarch32.c
@@ -90,10 +90,12 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt,
 
 	/* Give the guest an IMPLEMENTATION DEFINED exception */
 	is_lpae = (vcpu_cp15(vcpu, c2_TTBCR) >> 31);
-	if (is_lpae)
+	if (is_lpae) {
 		*fsr = 1 << 9 | 0x34;
-	else
-		*fsr = 0x14;
+	} else {
+		/* Surprise! DFSR's FS[4] lives in bit 10 */
+		*fsr = BIT(10) | 0x4; /* 0x14 */
+	}
 }
 
 void kvm_inject_dabt32(struct kvm_vcpu *vcpu, unsigned long addr)
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
