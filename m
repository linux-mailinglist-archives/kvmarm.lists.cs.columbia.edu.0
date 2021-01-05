Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2180B2EB033
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 17:37:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA48A4B297;
	Tue,  5 Jan 2021 11:37:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHLD+dZqckM4; Tue,  5 Jan 2021 11:37:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 617434B34F;
	Tue,  5 Jan 2021 11:37:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2AE54B31F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 11:37:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7Y91e8qe02X for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 11:37:05 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A89B4B334
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 11:37:05 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505A41396;
 Tue,  5 Jan 2021 08:37:05 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709E23F70D;
 Tue,  5 Jan 2021 08:37:03 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v5 3/5] ARM: implement support for SMCCC TRNG entropy source
Date: Tue,  5 Jan 2021 16:36:50 +0000
Message-Id: <20210105163652.23646-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105163652.23646-1-andre.przywara@arm.com>
References: <20210105163652.23646-1-andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Ard Biesheuvel <ardb@kernel.org>

Implement arch_get_random_seed_*() for ARM based on the firmware
or hypervisor provided entropy source described in ARM DEN0098.

This will make the kernel's random number generator consume entropy
provided by this interface, at early boot, and periodically at
runtime when reseeding.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
[Andre: rework to be initialised by the SMCCC firmware driver]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                  |  4 ++
 arch/arm/include/asm/archrandom.h | 64 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 138248999df7..bfe642510b0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1644,6 +1644,10 @@ config STACKPROTECTOR_PER_TASK
 	  Enable this option to switch to a different method that uses a
 	  different canary value for each task.
 
+config ARCH_RANDOM
+	def_bool y
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/include/asm/archrandom.h b/arch/arm/include/asm/archrandom.h
index a8e84ca5c2ee..f3e96a5b65f8 100644
--- a/arch/arm/include/asm/archrandom.h
+++ b/arch/arm/include/asm/archrandom.h
@@ -2,9 +2,73 @@
 #ifndef _ASM_ARCHRANDOM_H
 #define _ASM_ARCHRANDOM_H
 
+#ifdef CONFIG_ARCH_RANDOM
+
+#include <linux/arm-smccc.h>
+#include <linux/kernel.h>
+
+#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
+
+extern bool smccc_trng_available;
+
+static inline bool __init smccc_probe_trng(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
+	if ((s32)res.a0 < 0)
+		return false;
+	if (res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION) {
+		/* double check that the 32-bit flavor is available */
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
+				     ARM_SMCCC_TRNG_RND32,
+				     &res);
+		if ((s32)res.a0 >= 0)
+			return true;
+	}
+
+	return false;
+}
+
+static inline bool __must_check arch_get_random_long(unsigned long *v)
+{
+	return false;
+}
+
+static inline bool __must_check arch_get_random_int(unsigned int *v)
+{
+	return false;
+}
+
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
+{
+	struct arm_smccc_res res;
+
+	if (smccc_trng_available) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
+
+		if (res.a0 != 0)
+			return false;
+
+		*v = res.a3;
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
+{
+	return arch_get_random_seed_long((unsigned long *)v);
+}
+
+
+#else /* !CONFIG_ARCH_RANDOM */
+
 static inline bool __init smccc_probe_trng(void)
 {
 	return false;
 }
 
+#endif /* CONFIG_ARCH_RANDOM */
 #endif /* _ASM_ARCHRANDOM_H */
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
