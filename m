Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E92F0536C87
	for <lists+kvmarm@lfdr.de>; Sat, 28 May 2022 13:38:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 751124B2BF;
	Sat, 28 May 2022 07:38:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pn9hk-mvLh1G; Sat, 28 May 2022 07:38:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F25B4B355;
	Sat, 28 May 2022 07:38:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D3144B332
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fEK6WJUsAfwI for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 May 2022 07:38:39 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB63E4B2B6
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 May 2022 07:38:38 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DCD35B82681;
 Sat, 28 May 2022 11:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43875C36AE3;
 Sat, 28 May 2022 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653737916;
 bh=QuKKir21qzRmp5CkmJnHWo4FnteYTvpMeHGXH+vCKMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QlzVK9oxUAqqSmR4lGP7+xRcAJ/+hOLZffluam+jjw/nguNDMy6f6L5V0umgVFQqF
 uuBmSHi7BfXdn/EhSHRsmm151nCoQtuBFEUj9qM/jMBskp8WZj2NOJVQJsgAhKMPtB
 uG7sIak3JM9bUOEuV2yWufmkdz5YesnPQyXQu5ZTxSeOcokxE/LMzHGA4NIED/B+yI
 magtJWrSixVopQgTnxL82sDjd36jXFDUlsPkOivmuUdPyZO1/uKYA9Iqk34lYckzIu
 +4JqCYFS+BtCApZb5n3dm6ynfdaq0wBnlk1pfd3gR038X3T1maeD7jCHs20/denqB3
 J6jTV2eKfzf6Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nuumA-00EEGh-3t; Sat, 28 May 2022 12:38:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/18] KVM: arm64: Drop FP_FOREIGN_STATE from the hypervisor
 code
Date: Sat, 28 May 2022 12:38:13 +0100
Message-Id: <20220528113829.1043361-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220528113829.1043361-1-maz@kernel.org>
References: <20220528113829.1043361-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, broonie@kernel.org,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>
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

The vcpu KVM_ARM64_FP_FOREIGN_FPSTATE flag tracks the thread's own
TIF_FOREIGN_FPSTATE so that we can evaluate just before running
the vcpu whether it the FP regs contain something that is owned
by the vcpu or not by updating the rest of the FP flags.

We do this in the hypervisor code in order to make sure we're
in a context where we are not interruptible. But we already
have a hook in the run loop to generate this flag. We may as
well update the FP flags directly and save the pointless flag
tracking.

Whilst we're at it, rename update_fp_enabled() to guest_owns_fp_regs()
to indicate what the leftover of this helper actually do.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       |  1 -
 arch/arm64/kvm/fpsimd.c                 | 17 ++++++++++-------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 16 ++--------------
 arch/arm64/kvm/hyp/nvhe/switch.c        |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 026e91b8d00b..9252d71b4ac5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -465,7 +465,6 @@ struct kvm_vcpu_arch {
 
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
-#define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
 #define KVM_ARM64_ON_UNSUPPORTED_CPU	(1 << 15) /* Physical CPU not in supported_cpus */
 #define KVM_ARM64_HOST_SME_ENABLED	(1 << 16) /* SME enabled for EL0 */
 #define KVM_ARM64_WFIT			(1 << 17) /* WFIT instruction trapped */
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 78b3f143a2d0..9ebd89541281 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -107,16 +107,19 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Called just before entering the guest once we are no longer
- * preemptable. Syncs the host's TIF_FOREIGN_FPSTATE with the KVM
- * mirror of the flag used by the hypervisor.
+ * Called just before entering the guest once we are no longer preemptable
+ * and interrupts are disabled. If we have managed to run anything using
+ * FP while we were preemptible (such as off the back of an interrupt),
+ * then neither the host nor the guest own the FP hardware (and it was the
+ * responsibility of the code that used FP to save the existing state).
+ *
+ * Note that not supporting FP is basically the same thing as far as the
+ * hypervisor is concerned (nothing to save).
  */
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
 {
-	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
-		vcpu->arch.flags |= KVM_ARM64_FP_FOREIGN_FPSTATE;
-	else
-		vcpu->arch.flags &= ~KVM_ARM64_FP_FOREIGN_FPSTATE;
+	if (!system_supports_fpsimd() || test_thread_flag(TIF_FOREIGN_FPSTATE))
+		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED | KVM_ARM64_FP_HOST);
 }
 
 /*
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 5d31f6c64c8c..1209248d2a3d 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -37,21 +37,9 @@ struct kvm_exception_table_entry {
 extern struct kvm_exception_table_entry __start___kvm_ex_table;
 extern struct kvm_exception_table_entry __stop___kvm_ex_table;
 
-/* Check whether the FP regs were dirtied while in the host-side run loop: */
-static inline bool update_fp_enabled(struct kvm_vcpu *vcpu)
+/* Check whether the FP regs are owned by the guest */
+static inline bool guest_owns_fp_regs(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * When the system doesn't support FP/SIMD, we cannot rely on
-	 * the _TIF_FOREIGN_FPSTATE flag. However, we always inject an
-	 * abort on the very first access to FP and thus we should never
-	 * see KVM_ARM64_FP_ENABLED. For added safety, make sure we always
-	 * trap the accesses.
-	 */
-	if (!system_supports_fpsimd() ||
-	    vcpu->arch.flags & KVM_ARM64_FP_FOREIGN_FPSTATE)
-		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
-				      KVM_ARM64_FP_HOST);
-
 	return !!(vcpu->arch.flags & KVM_ARM64_FP_ENABLED);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6db801db8f27..a6b9f1186577 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -43,7 +43,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 
 	val = vcpu->arch.cptr_el2;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TAM;
-	if (!update_fp_enabled(vcpu)) {
+	if (!guest_owns_fp_regs(vcpu)) {
 		val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
 		__activate_traps_fpsimd32(vcpu);
 	}
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 969f20daf97a..46f365254e9f 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -55,7 +55,7 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 
 	val |= CPTR_EL2_TAM;
 
-	if (update_fp_enabled(vcpu)) {
+	if (guest_owns_fp_regs(vcpu)) {
 		if (vcpu_has_sve(vcpu))
 			val |= CPACR_EL1_ZEN_EL0EN | CPACR_EL1_ZEN_EL1EN;
 	} else {
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
