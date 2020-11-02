Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D13802A3001
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 17:41:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86C2D4B4B2;
	Mon,  2 Nov 2020 11:41:13 -0500 (EST)
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
	with ESMTP id TdyxPUI5Y+m8; Mon,  2 Nov 2020 11:41:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0513E4B466;
	Mon,  2 Nov 2020 11:41:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ADEE4B3B3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 11:41:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rhlf-U5efLEo for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 11:41:08 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D25C14B3F3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 11:41:07 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDB54222B9;
 Mon,  2 Nov 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604335267;
 bh=BJ2l4DSkz4y9V8f94u85OpZYHHp9SSM0jeiRHjoar9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUFKYN6ya7F7bktYpKAg2HFe6Qczk7CZKxcfI8hl7s+UUGFC2f/S8asPoXh100cZD
 R03Xg9Mnaczc+Iy6cmP8tyl7wWUTJLY/3cFC5+IOLB5hDthZraAf2eLNKmWOxm/u+K
 hY9a4Dk6Ly89nXReP5QimCTMxoviXRhsKUVyVWmw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kZctF-006jJf-4g; Mon, 02 Nov 2020 16:41:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 02/11] KVM: arm64: Move kvm_vcpu_trap_il_is32bit into
 kvm_skip_instr32()
Date: Mon,  2 Nov 2020 16:40:36 +0000
Message-Id: <20201102164045.264512-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102164045.264512-1-maz@kernel.org>
References: <20201102164045.264512-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, ascull@google.com,
 will@kernel.org, mark.rutland@arm.com, qperret@google.com, dbrazdil@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>
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

There is no need to feed the result of kvm_vcpu_trap_il_is32bit()
to kvm_skip_instr(), as only AArch32 has a variable length ISA, and
this helper can equally be called from kvm_skip_instr32(), reducing
the complexity at all the call sites.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h | 8 ++++----
 arch/arm64/kvm/handle_exit.c         | 6 +++---
 arch/arm64/kvm/hyp/aarch32.c         | 4 ++--
 arch/arm64/kvm/mmio.c                | 2 +-
 arch/arm64/kvm/mmu.c                 | 2 +-
 arch/arm64/kvm/sys_regs.c            | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 5ef2669ccd6c..0864f425547d 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -26,7 +26,7 @@ unsigned long vcpu_read_spsr32(const struct kvm_vcpu *vcpu);
 void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v);
 
 bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
-void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr);
+void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_vabt(struct kvm_vcpu *vcpu);
@@ -472,10 +472,10 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 	return data;		/* Leave LE untouched */
 }
 
-static __always_inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
+static __always_inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_mode_is_32bit(vcpu)) {
-		kvm_skip_instr32(vcpu, is_wide_instr);
+		kvm_skip_instr32(vcpu);
 	} else {
 		*vcpu_pc(vcpu) += 4;
 		*vcpu_cpsr(vcpu) &= ~PSR_BTYPE_MASK;
@@ -494,7 +494,7 @@ static __always_inline void __kvm_skip_instr(struct kvm_vcpu *vcpu)
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
 	vcpu_gp_regs(vcpu)->pstate = read_sysreg_el2(SYS_SPSR);
 
-	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+	kvm_skip_instr(vcpu);
 
 	write_sysreg_el2(vcpu_gp_regs(vcpu)->pstate, SYS_SPSR);
 	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 79a720657c47..30bf8e22df54 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -61,7 +61,7 @@ static int handle_smc(struct kvm_vcpu *vcpu)
 	 * otherwise return to the same address...
 	 */
 	vcpu_set_reg(vcpu, 0, ~0UL);
-	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+	kvm_skip_instr(vcpu);
 	return 1;
 }
 
@@ -100,7 +100,7 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu)
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 	}
 
-	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+	kvm_skip_instr(vcpu);
 
 	return 1;
 }
@@ -221,7 +221,7 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu)
 	 * that fail their condition code check"
 	 */
 	if (!kvm_condition_valid(vcpu)) {
-		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+		kvm_skip_instr(vcpu);
 		handled = 1;
 	} else {
 		exit_handle_fn exit_handler;
diff --git a/arch/arm64/kvm/hyp/aarch32.c b/arch/arm64/kvm/hyp/aarch32.c
index ae56d8a4b382..f98cbe2626a1 100644
--- a/arch/arm64/kvm/hyp/aarch32.c
+++ b/arch/arm64/kvm/hyp/aarch32.c
@@ -123,13 +123,13 @@ static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
  * kvm_skip_instr - skip a trapped instruction and proceed to the next
  * @vcpu: The vcpu pointer
  */
-void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
+void kvm_skip_instr32(struct kvm_vcpu *vcpu)
 {
 	u32 pc = *vcpu_pc(vcpu);
 	bool is_thumb;
 
 	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_AA32_T_BIT);
-	if (is_thumb && !is_wide_instr)
+	if (is_thumb && !kvm_vcpu_trap_il_is32bit(vcpu))
 		pc += 2;
 	else
 		pc += 4;
diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index 6a2826f1bf5e..7e8eb32ae7d2 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -115,7 +115,7 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
 	 * The MMIO instruction is emulated and should not be re-executed
 	 * in the guest.
 	 */
-	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+	kvm_skip_instr(vcpu);
 
 	return 0;
 }
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 57972bdb213a..0bec07cf8d06 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1014,7 +1014,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * cautious, and skip the instruction.
 		 */
 		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
-			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+			kvm_skip_instr(vcpu);
 			ret = 1;
 			goto out_unlock;
 		}
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index fb12d3ef423a..1232a814ca7f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2199,7 +2199,7 @@ static void perform_access(struct kvm_vcpu *vcpu,
 
 	/* Skip instruction if instructed so */
 	if (likely(r->access(vcpu, params, r)))
-		kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+		kvm_skip_instr(vcpu);
 }
 
 /*
-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
