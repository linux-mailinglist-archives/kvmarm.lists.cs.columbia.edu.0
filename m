Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA3BDCE5
	for <lists+kvmarm@lfdr.de>; Wed, 25 Sep 2019 13:20:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A7084A6B5;
	Wed, 25 Sep 2019 07:20:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJMY8Va0C8op; Wed, 25 Sep 2019 07:20:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 26BE74A6CA;
	Wed, 25 Sep 2019 07:20:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E9D7D4A663
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Sep 2019 07:19:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3BSxjnty083O for <kvmarm@lists.cs.columbia.edu>;
 Wed, 25 Sep 2019 07:19:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE0654A6BD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 25 Sep 2019 07:19:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EADC1597;
 Wed, 25 Sep 2019 04:19:58 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31C243F694;
 Wed, 25 Sep 2019 04:19:57 -0700 (PDT)
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 2/5] arm64: KVM: Reorder system register restoration and
 stage-2 activation
Date: Wed, 25 Sep 2019 12:19:38 +0100
Message-Id: <20190925111941.88103-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190925111941.88103-1-maz@kernel.org>
References: <20190925111941.88103-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

In order to prepare for handling erratum 1319367, we need to make
sure that all system registers (and most importantly the registers
configuring the virtual memory) are set before we enable stage-2
translation.

This results in a minor reorganisation of the load sequence, without
any functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index a15baca9aca0..e6adb90c12ae 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -605,18 +605,23 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 
 	__sysreg_save_state_nvhe(host_ctxt);
 
-	__activate_vm(kern_hyp_va(vcpu->kvm));
-	__activate_traps(vcpu);
-
-	__hyp_vgic_restore_state(vcpu);
-	__timer_enable_traps(vcpu);
-
 	/*
 	 * We must restore the 32-bit state before the sysregs, thanks
 	 * to erratum #852523 (Cortex-A57) or #853709 (Cortex-A72).
+	 *
+	 * Also, and in order to be able to deal with erratum #1319537 (A57)
+	 * and #1319367 (A72), we must ensure that all VM-related sysreg are
+	 * restored before we enable S2 translation.
 	 */
 	__sysreg32_restore_state(vcpu);
 	__sysreg_restore_state_nvhe(guest_ctxt);
+
+	__activate_vm(kern_hyp_va(vcpu->kvm));
+	__activate_traps(vcpu);
+
+	__hyp_vgic_restore_state(vcpu);
+	__timer_enable_traps(vcpu);
+
 	__debug_switch_to_guest(vcpu);
 
 	__set_guest_arch_workaround_state(vcpu);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
