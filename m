Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C0DD7C8
	for <lists+kvmarm@lfdr.de>; Sat, 19 Oct 2019 11:55:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BEC1B4AA61;
	Sat, 19 Oct 2019 05:55:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ItMuz-L1EUBv; Sat, 19 Oct 2019 05:55:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4F214AA78;
	Sat, 19 Oct 2019 05:55:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D8194A948
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Id9xLa3M-Kuc for <kvmarm@lists.cs.columbia.edu>;
 Sat, 19 Oct 2019 05:55:34 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9FA804A988
 for <kvmarm@lists.cs.columbia.edu>; Sat, 19 Oct 2019 05:55:33 -0400 (EDT)
Received: from big-swifty.lan (78.163-31-62.static.virginmediabusiness.co.uk
 [62.31.163.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A153E222C2;
 Sat, 19 Oct 2019 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571478932;
 bh=C+wxLu/WnnwZ3cqp2GHFnfaQZgrXjj31+JCX0m8MeoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mYqx+7UMtpLMaE/KOY3jsL1gUUeMf3s+YgsbRmwJeHNiJhsZhiQnsl7bbhvmNKWrg
 s3seIIPbTqbICqVFLO61SkWTYsh7XposMSxyYa3dW0GZ6V0kOrF7u+0yAl2g0BqYPA
 nrqcyHiWEkARmUq3m6gv36fmahQT1YvI0NELSY5Y=
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: KVM: Reorder system register restoration and
 stage-2 activation
Date: Sat, 19 Oct 2019 10:55:18 +0100
Message-Id: <20191019095521.31722-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019095521.31722-1-maz@kernel.org>
References: <20191019095521.31722-1-maz@kernel.org>
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
index 3d3815020e36..69e10b29cbd0 100644
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
