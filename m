Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1314675F
	for <lists+kvmarm@lfdr.de>; Thu, 23 Jan 2020 12:59:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 261074AF31;
	Thu, 23 Jan 2020 06:59:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6uw14wew8iFJ; Thu, 23 Jan 2020 06:59:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA9334AF25;
	Thu, 23 Jan 2020 06:59:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4D5D4AF00
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jan 2020 06:59:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EXD9T1NikIKO for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Jan 2020 06:59:06 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BAD34AF11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jan 2020 06:59:06 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F466328;
 Thu, 23 Jan 2020 03:59:06 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42C9B3F6C4;
 Thu, 23 Jan 2020 03:59:04 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/3] KVM: arm64: limit PMU version to ARMv8.4
Date: Thu, 23 Jan 2020 11:58:51 +0000
Message-Id: <20200123115852.55595-3-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200123115852.55595-1-andrew.murray@arm.com>
References: <20200123115852.55595-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

ARMv8.5-PMU introduces 64-bit event counters, however KVM doesn't yet
support this. Let's trap the Debug Feature Registers in order to limit
PMUVer/PerfMon in the Debug Feature Registers to PMUv3 for ARMv8.4.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h |  5 +++++
 arch/arm64/kvm/sys_regs.c       | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fafb43d..d969df417f88 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -672,6 +672,11 @@
 #define ID_AA64DFR0_TRACEVER_SHIFT	4
 #define ID_AA64DFR0_DEBUGVER_SHIFT	0
 
+#define ID_DFR0_PERFMON_SHIFT		24
+
+#define ID_DFR0_EL1_PMUVER_8_4		5
+#define ID_AA64DFR0_EL1_PMUVER_8_4	5
+
 #define ID_ISAR5_RDM_SHIFT		24
 #define ID_ISAR5_CRC32_SHIFT		16
 #define ID_ISAR5_SHA2_SHIFT		12
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 9f2165937f7d..028c93a88a51 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1085,6 +1085,17 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_GPI_SHIFT));
+	} else if (id == SYS_ID_AA64DFR0_EL1) {
+		/* Limit guests to PMUv3 for ARMv8.4 */
+		val = cpuid_feature_cap_signed_field_width(val,
+						ID_AA64DFR0_PMUVER_SHIFT,
+						4, ID_AA64DFR0_EL1_PMUVER_8_4);
+	} else if (id == SYS_ID_DFR0_EL1) {
+		/* Limit guests to PMUv3 for ARMv8.4 */
+		val = cpuid_feature_cap_signed_field_width(val,
+						ID_DFR0_PERFMON_SHIFT,
+						4, ID_DFR0_EL1_PMUVER_8_4);
+
 	}
 
 	return val;
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
