Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C14AC31B
	for <lists+kvmarm@lfdr.de>; Mon,  7 Feb 2022 16:25:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 473DC49EF4;
	Mon,  7 Feb 2022 10:25:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hmx20sSRYMEI; Mon,  7 Feb 2022 10:25:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A4C6549ED7;
	Mon,  7 Feb 2022 10:25:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AE0849E43
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:25:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nvVICgZJtHv for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Feb 2022 10:25:03 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD6B249EFD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Feb 2022 10:25:02 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 43EC261035;
 Mon,  7 Feb 2022 15:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CEAC340F1;
 Mon,  7 Feb 2022 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644247501;
 bh=3CVajAIAdTOdfvfZ82kEgNvR06jRolq6At9bUSWFRwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rbfdop78Wtk6VDPiyaNvJ3DWupwb9ONyvU+gNt/zNLKMgKC8cWtkeWaeT2FwUZHos
 3yYZAcL58Kd9bfr8pkWu23L61/DV4ZPMG2KLaAbLP90W9BF10TD1gHE5lvc9A0prum
 rl9cdZAdYEzq6uKM6n+yD6fwvPPv941Rs0/6hIHAZdaaRZh/YdochRv5R8oqROK5tF
 jHMN0iVATPYTDnN9pgZ4hX3CrKf2WnT9mTQJAkdwG2xbm9ceECHim1bY7H7XtzZupl
 3fHTlv8RXepvtIYg3zFZxf3m0aHn5cDmkqyclqNQo7CpCU5+MXTltTTOHRED0h7IMD
 +J+Z7oFvDTmEg==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v11 28/40] KVM: arm64: Handle SME host state when running
 guests
Date: Mon,  7 Feb 2022 15:20:57 +0000
Message-Id: <20220207152109.197566-29-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207152109.197566-1-broonie@kernel.org>
References: <20220207152109.197566-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4057; h=from:subject;
 bh=3CVajAIAdTOdfvfZ82kEgNvR06jRolq6At9bUSWFRwk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiATjaipvlQdnfuu2rF6eRpP9SEhn4zU4bLewdFWFr
 /0NnPgmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYgE42gAKCRAk1otyXVSH0Dy5B/
 4rEGOOj9JPsqWlDxw24euatve7GECKjYpWRjRj3kjxgCgFn59JnZvczsuHHn8mfvp1KjrJsRfAh7UY
 UvhtZPVXHLA15nIHtw67wtCSklYXkYnA9dYrGSyVHX1sYo2NTKDo7uwOU3RJDX82BRsOWUfxMPT6Fx
 g0sFs9zFEIgSTkDvLZtb2M7Wk4J2JRE4HKPKvVrhjztM6KTpvz8aEi2ye03LHOKbNGPSn7FsrE2++q
 huLlw6xIJ+Q5dub+nALFDNnCdFIC2eew6Y5PkG/XILvMHa+rA3tlYCw6rfOTuXNWzS/RJQik/si3Rn
 XdCgCo2Hl6IRxNVDU1ycK+HSBhC/3B
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

While we don't currently support SME in guests we do currently support it
for the host system so we need to take care of SME's impact, including
the floating point register state, when running guests. Simiarly to SVE
we need to manage the traps in CPACR_RL1, what is new is the handling of
streaming mode and ZA.

Normally we defer any handling of the floating point register state until
the guest first uses it however if the system is in streaming mode FPSIMD
and SVE operations may generate SME traps which we would need to distinguish
from actual attempts by the guest to use SME. Rather than do this for the
time being if we are in streaming mode when entering the guest we force
the floating point state to be saved immediately and exit streaming mode,
meaning that the guest won't generate SME traps for supported operations.

We could handle ZA in the access trap similarly to the FPSIMD/SVE state
without the disruption caused by streaming mode but for simplicity
handle it the same way as streaming mode for now.

This will be revisited when we support SME for guests (hopefully before SME
hardware becomes available), for now it will only incur additional cost on
systems with SME and even there only if streaming mode or ZA are enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/fpsimd.c           | 36 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7dc85d5a6552..404b7358ba96 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -438,6 +438,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
 #define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
+#define KVM_ARM64_HOST_SME_ENABLED	(1 << 15) /* SME enabled for EL0 */
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 338733ac63f8..1c585553d74f 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -82,6 +82,26 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
+
+	/*
+	 * We don't currently support SME guests but if we leave
+	 * things in streaming mode then when the guest starts running
+	 * FPSIMD or SVE code it may generate SME traps so as a
+	 * special case if we are in streaming mode we force the host
+	 * state to be saved now and exit streaming mode so that we
+	 * don't have to handle any SME traps for valid guest
+	 * operations. Do this for ZA as well for now for simplicity.
+	 */
+	if (system_supports_sme()) {
+		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
+			vcpu->arch.flags |= KVM_ARM64_HOST_SME_ENABLED;
+
+		if (read_sysreg_s(SYS_SVCR_EL0) &
+		    (SYS_SVCR_EL0_SM_MASK | SYS_SVCR_EL0_ZA_MASK)) {
+			vcpu->arch.flags &= ~KVM_ARM64_FP_HOST;
+			fpsimd_save_and_flush_cpu_state();
+		}
+	}
 }
 
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
@@ -129,6 +149,22 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
+	/*
+	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
+	 * CPACR_EL1_DEFAULT and we need to reenable SME.
+	 */
+	if (has_vhe() && system_supports_sme()) {
+		/* Also restore EL0 state seen on entry */
+		if (vcpu->arch.flags & KVM_ARM64_HOST_SME_ENABLED)
+			sysreg_clear_set(CPACR_EL1, 0,
+					 CPACR_EL1_SMEN_EL0EN |
+					 CPACR_EL1_SMEN_EL1EN);
+		else
+			sysreg_clear_set(CPACR_EL1,
+					 CPACR_EL1_SMEN_EL0EN,
+					 CPACR_EL1_SMEN_EL1EN);
+	}
+
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
