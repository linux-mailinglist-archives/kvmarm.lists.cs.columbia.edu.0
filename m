Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C8462179
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:06:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFB254B125;
	Mon, 29 Nov 2021 15:06:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9gibdKp6YW7S; Mon, 29 Nov 2021 15:06:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B70E4B168;
	Mon, 29 Nov 2021 15:06:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A84F64B129
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ODPWsG6U9KXc for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:06:10 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F383B49F8F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:09 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id EF2CFCE13DE;
 Mon, 29 Nov 2021 20:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667B5C53FC7;
 Mon, 29 Nov 2021 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216366;
 bh=aXOmQCoo+3BavrCGq7viBjKwLUX5oZCvjH/YTIoVHFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZkYMQdIGxDYCyy5+mmC80aKxvFcXXV125SCOG8IFKgyo34KHmrzb5/KSdyZXQdyI3
 +PfVnkIlSfCOFBI/32NUyLZZgPCc0j62ujrWFv1q5Hrnz/JLpyxz10Bivr1Nedximl
 Q1hEIQyUdDWjVcYmJxnDSat+Z3h+nILWOLDaiaHOlHmF+hRfCXgVlpWIdCAzC/vdqw
 IUwZgjlhr7HySNT1EVMuAKC3q5lD3hJO/d1paPIBaNvHX+dBBuG7UL/KmIL2gUUNXN
 clBlz3oH60CQxXOujIU9/FvWiiXqiOHT/rdtr1RQvAX7Io+igapwYx4ifd9vXPbAxS
 epVzE7vExqYgA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmrI-008gvR-NK; Mon, 29 Nov 2021 20:02:40 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 67/69] KVM: arm64: nv: Enable ARMv8.4-NV support
Date: Mon, 29 Nov 2021 20:01:48 +0000
Message-Id: <20211129200150.351436-68-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129200150.351436-1-maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

As all the VNCR-capable system registers are nicely separated
from the rest of the crowd, let's set HCR_EL2.NV2 on and let
the ball rolling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h     |  1 +
 arch/arm64/include/asm/kvm_emulate.h | 23 +++++++++++++----------
 arch/arm64/include/asm/sysreg.h      |  1 +
 arch/arm64/kvm/hyp/vhe/switch.c      | 14 +++++++++++++-
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b603466803d2..18c35446249f 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -20,6 +20,7 @@
 #define HCR_AMVOFFEN	(UL(1) << 51)
 #define HCR_FIEN	(UL(1) << 47)
 #define HCR_FWB		(UL(1) << 46)
+#define HCR_NV2		(UL(1) << 45)
 #define HCR_AT		(UL(1) << 44)
 #define HCR_NV1		(UL(1) << 43)
 #define HCR_NV		(UL(1) << 42)
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 1664430be698..f282997e4a4c 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -245,21 +245,24 @@ static inline bool is_hyp_ctxt(const struct kvm_vcpu *vcpu)
 
 static inline u64 __fixup_spsr_el2_write(struct kvm_cpu_context *ctxt, u64 val)
 {
-	if (!__vcpu_el2_e2h_is_set(ctxt)) {
-		/*
-		 * Clear the .M field when writing SPSR to the CPU, so that we
-		 * can detect when the CPU clobbered our SPSR copy during a
-		 * local exception.
-		 */
-		val &= ~0xc;
-	}
+	struct kvm_vcpu *vcpu = container_of(ctxt, struct kvm_vcpu, arch.ctxt);
+
+	if (enhanced_nested_virt_in_use(vcpu) || __vcpu_el2_e2h_is_set(ctxt))
+		return val;
 
-	return val;
+	/*
+	 * Clear the .M field when writing SPSR to the CPU, so that we
+	 * can detect when the CPU clobbered our SPSR copy during a
+	 * local exception.
+	 */
+	return val &= ~0xc;
 }
 
 static inline u64 __fixup_spsr_el2_read(const struct kvm_cpu_context *ctxt, u64 val)
 {
-	if (__vcpu_el2_e2h_is_set(ctxt))
+	struct kvm_vcpu *vcpu = container_of(ctxt, struct kvm_vcpu, arch.ctxt);
+
+	if (enhanced_nested_virt_in_use(vcpu) || __vcpu_el2_e2h_is_set(ctxt))
 		return val;
 
 	/*
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 71e6a0410e7c..5de90138d0a4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -550,6 +550,7 @@
 #define SYS_TCR_EL2			sys_reg(3, 4, 2, 0, 2)
 #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
 #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
+#define SYS_VNCR_EL2			sys_reg(3, 4, 2, 2, 0)
 
 #define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
 #define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index ef4488db6dc1..5cadda79089a 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -45,7 +45,13 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 			 * the EL1 virtual memory control register accesses
 			 * as well as the AT S1 operations.
 			 */
-			hcr |= HCR_TVM | HCR_TRVM | HCR_AT | HCR_TTLB | HCR_NV1;
+			if (enhanced_nested_virt_in_use(vcpu)) {
+				hcr &= ~HCR_TVM;
+			} else {
+				hcr |= HCR_TVM | HCR_TRVM | HCR_TTLB;
+			}
+
+			hcr |= HCR_AT | HCR_NV1;
 		} else {
 			/*
 			 * For a guest hypervisor on v8.1 (VHE), allow to
@@ -79,6 +85,12 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
 			if (!vcpu_el2_tge_is_set(vcpu))
 				hcr |= HCR_AT | HCR_TTLB;
 		}
+
+		if (enhanced_nested_virt_in_use(vcpu)) {
+			hcr |= HCR_AT | HCR_TTLB | HCR_NV2;
+			write_sysreg_s(vcpu->arch.ctxt.vncr_array,
+				       SYS_VNCR_EL2);
+		}
 	} else if (nested_virt_in_use(vcpu)) {
 		u64 vhcr_el2 = __vcpu_sys_reg(vcpu, HCR_EL2);
 
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
