Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 659BA2D60B9
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 17:00:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC0044B239;
	Thu, 10 Dec 2020 11:00:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AeqqGKdQ+eWJ; Thu, 10 Dec 2020 11:00:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DB6DE4B1E2;
	Thu, 10 Dec 2020 11:00:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5980D4B126
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:00:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IEdl3UU5XwmF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 11:00:32 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 134D14B17A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:00:32 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E29C23D56;
 Thu, 10 Dec 2020 16:00:31 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1knOMm-0008Di-Ny; Thu, 10 Dec 2020 16:00:29 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 01/66] arm64: Add ARM64_HAS_NESTED_VIRT cpufeature
Date: Thu, 10 Dec 2020 15:58:57 +0000
Message-Id: <20201210160002.1407373-2-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160002.1407373-1-maz@kernel.org>
References: <20201210160002.1407373-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, alexandru.elisei@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com, jintack.lim@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Jintack Lim <jintack.lim@linaro.org>
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

From: Jintack Lim <jintack.lim@linaro.org>

Add a new ARM64_HAS_NESTED_VIRT feature to indicate that the
CPU has the ARMv8.3 nested virtualization capability.

This will be used to support nested virtualization in KVM.

Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/arm64/include/asm/cpucaps.h              |  1 +
 arch/arm64/kernel/cpufeature.c                | 25 +++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ee9f13776388..727e49640124 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2285,6 +2285,10 @@
 			[KVM,ARM] Allow use of GICv4 for direct injection of
 			LPIs.
 
+	kvm-arm.nested=
+			[KVM,ARM] Allow nested virtualization in KVM/ARM.
+			Default is 0 (disabled)
+
 	kvm_cma_resv_ratio=n [PPC]
 			Reserves given percentage from system memory area for
 			contiguous memory allocation for KVM hash pagetable
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b77d997b173b..6c5b84692a01 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -16,6 +16,7 @@
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
 #define ARM64_HAS_NO_HW_PREFETCH		8
+#define ARM64_HAS_NESTED_VIRT			9
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
 #define ARM64_HAS_32BIT_EL0			13
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d96f4554282d..eaeea8a88292 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1577,6 +1577,21 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 	if (!alternative_is_applied(ARM64_HAS_VIRT_HOST_EXTN))
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
+
+static bool nested_param;
+static bool has_nested_virt_support(const struct arm64_cpu_capabilities *cap,
+				    int scope)
+{
+	return has_cpuid_feature(cap, scope) &&
+		nested_param;
+}
+
+static int __init kvmarm_nested_cfg(char *buf)
+{
+	return strtobool(buf, &nested_param);
+}
+
+early_param("kvm-arm.nested", kvmarm_nested_cfg);
 #endif
 
 static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
@@ -1790,6 +1805,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = runs_at_el2,
 		.cpu_enable = cpu_copy_el2regs,
 	},
+	{
+		.desc = "Nested Virtualization Support",
+		.capability = ARM64_HAS_NESTED_VIRT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_nested_virt_support,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR2_NV_SHIFT,
+		.min_field_value = 1,
+	},
 #endif	/* CONFIG_ARM64_VHE */
 	{
 		.desc = "32-bit EL0 Support",
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
