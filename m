Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B75C6159722
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 18:53:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D7C44AEFE;
	Tue, 11 Feb 2020 12:53:04 -0500 (EST)
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
	with ESMTP id ksNcltt8o-+x; Tue, 11 Feb 2020 12:53:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 145704AF00;
	Tue, 11 Feb 2020 12:53:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A507D4AE95
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:53:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4mHfIMGmrFzr for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 12:53:00 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A522340456
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:52:59 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D83FE20578;
 Tue, 11 Feb 2020 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581443579;
 bh=uSp/qawlZOx/68y9N8aqpzHmqTR1tge0KqerXZ4jmX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1BBe8VosogcMLhIH1Cxow3e5tH7Wwclup3MQxlYhoLyks6Vq13UX5mWOjZRxZm6z5
 coSjZmrZOD2IAtKdQTCTgeha/vBa5ose381LtQ1g+87ETGSrL5mZHc0a/jEt/M607O
 53oOuEhj3X7V3/1Jl7MerCrqY3ORuFVMAlPQKoco=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j1Zfp-004O7k-OW; Tue, 11 Feb 2020 17:50:13 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 35/94] KVM: arm64: Check advertised Stage-2 page size
 capability
Date: Tue, 11 Feb 2020 17:48:39 +0000
Message-Id: <20200211174938.27809-36-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211174938.27809-1-maz@kernel.org>
References: <20200211174938.27809-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, Dave.Martin@arm.com, jintack@cs.columbia.edu,
 alexandru.elisei@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <andre.przywara@arm.com>, Dave Martin <Dave.Martin@arm.com>
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

With ARMv8.5-GTG, the hardware (or more likely a hypervisor) can
advertise the supported Stage-2 page sizes.

Let's check this at boot time.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/kvm_mmu.h    |  2 +-
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kernel/cpufeature.c    |  8 +++++++
 arch/arm64/kvm/reset.c            | 39 ++++++++++++++++++++++++++++---
 virt/kvm/arm/arm.c                |  4 +---
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 0d84d50bf9ba..053a5f434b3e 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -418,7 +418,7 @@ static inline int hyp_map_aux_data(void)
 
 #define kvm_phys_to_vttbr(addr)		(addr)
 
-static inline void kvm_set_ipa_limit(void) {}
+static inline int kvm_set_ipa_limit(void) { return 0; }
 
 static __always_inline u64 kvm_get_vttbr(struct kvm *kvm)
 {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1bda11cc0f39..87ccceb9f5d8 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -734,7 +734,7 @@ static inline int kvm_arm_have_ssbd(void)
 void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu);
 void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
 
-void kvm_set_ipa_limit(void);
+int kvm_set_ipa_limit(void);
 
 #define __KVM_HAVE_ARCH_VM_ALLOC
 struct kvm *kvm_arch_alloc_vm(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f0e58450eb16..157700590aa8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -205,6 +205,14 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
+	/*
+	 * Page size not being supported at Stage-2 are not fatal. You
+	 * just give up KVM if PAGE_SIZE isn't supported there. Go fix
+	 * your favourite nesting hypervisor.
+	 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_2_SHIFT, 4, 1),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_2_SHIFT, 4, 1),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_2_SHIFT, 4, 1),
 	/*
 	 * We already refuse to boot CPUs that don't support our configured
 	 * page size, so we can only detect mismatches for a page size other
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5c50df274239..038765d1e60d 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -348,11 +348,42 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-void kvm_set_ipa_limit(void)
+int kvm_set_ipa_limit(void)
 {
-	unsigned int ipa_max, pa_max, va_max, parange;
+	unsigned int ipa_max, pa_max, va_max, parange, tgran_2;
+	u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
 
-	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
+	/*
+	 * Check with ARMv8.5-GTG that our PAGE_SIZE is supported at
+	 * Stage-2. If not, things will stop very quickly.
+	 */
+	switch (PAGE_SIZE) {
+	default:
+	case SZ_4K:
+		tgran_2 = ID_AA64MMFR0_TGRAN4_2_SHIFT;
+		break;
+	case SZ_16K:
+		tgran_2 = ID_AA64MMFR0_TGRAN16_2_SHIFT;
+		break;
+	case SZ_64K:
+		tgran_2 = ID_AA64MMFR0_TGRAN64_2_SHIFT;
+		break;
+	}
+
+	switch (FIELD_GET(0xFUL << tgran_2, mmfr0)) {
+	default:
+	case 1:
+		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
+		return -EINVAL;
+	case 0:
+		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
+		break;
+	case 2:
+		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
+		break;
+	}
+
+	parange = mmfr0 & 0x7;
 	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
 
 	/* Clamp the IPA limit to the PA size supported by the kernel */
@@ -386,6 +417,8 @@ void kvm_set_ipa_limit(void)
 	     "KVM IPA limit (%d bit) is smaller than default size\n", ipa_max);
 	kvm_ipa_limit = ipa_max;
 	kvm_info("IPA Size Limit: %dbits\n", kvm_ipa_limit);
+
+	return 0;
 }
 
 /*
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index d65a0faa46d8..d1359b2079df 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1421,9 +1421,7 @@ static inline void hyp_cpu_pm_exit(void)
 
 static int init_common_resources(void)
 {
-	kvm_set_ipa_limit();
-
-	return 0;
+	return kvm_set_ipa_limit();
 }
 
 static int init_subsystems(void)
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
