Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7444D127CA8
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 15:30:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 244454AE8D;
	Fri, 20 Dec 2019 09:30:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-XqQcVcoBxC; Fri, 20 Dec 2019 09:30:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A33684AEA1;
	Fri, 20 Dec 2019 09:30:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8424F4AC68
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 09:30:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4SmWZq0qIiT for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 09:30:41 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DF6B4A531
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 09:30:41 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1304311FB;
 Fri, 20 Dec 2019 06:30:41 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39E3A3F718;
 Fri, 20 Dec 2019 06:30:39 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 04/18] arm64: KVM: add SPE system registers to sys_reg_descs
Date: Fri, 20 Dec 2019 14:30:11 +0000
Message-Id: <20191220143025.33853-5-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191220143025.33853-1-andrew.murray@arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Sudeep Holla <sudeep.holla@arm.com>

Add the Statistical Profiling Extension(SPE) Profiling Buffer controls
registers such that we can provide initial register values and use the
sys_regs structure as a store for our SPE context.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[ Reword commit, remove access/reset handlers, defer kvm_arm_support_spe_v1 ]
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++++++++++
 arch/arm64/kvm/sys_regs.c         | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f5dcff912645..9eb85f14df90 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -145,6 +145,18 @@ enum vcpu_sysreg {
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 	DISR_EL1,	/* Deferred Interrupt Status Register */
 
+	/* Statistical Profiling Extension Registers */
+	PMSCR_EL1,
+	PMSICR_EL1,
+	PMSIRR_EL1,
+	PMSFCR_EL1,
+	PMSEVFR_EL1,
+	PMSLATFR_EL1,
+	PMSIDR_EL1,
+	PMBLIMITR_EL1,
+	PMBPTR_EL1,
+	PMBSR_EL1,
+
 	/* Performance Monitors Registers */
 	PMCR_EL0,	/* Control Register */
 	PMSELR_EL0,	/* Event Counter Selection Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 46822afc57e0..955b157f9cc5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1506,6 +1506,17 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 
+	{ SYS_DESC(SYS_PMSCR_EL1), NULL, reset_val, PMSCR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSICR_EL1), NULL, reset_val, PMSICR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSIRR_EL1), NULL, reset_val, PMSIRR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSFCR_EL1), NULL, reset_val, PMSFCR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSEVFR_EL1), NULL, reset_val, PMSEVFR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSLATFR_EL1), NULL, reset_val, PMSLATFR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSIDR_EL1), NULL, reset_val, PMSIDR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBLIMITR_EL1), NULL, reset_val, PMBLIMITR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBPTR_EL1), NULL, reset_val, PMBPTR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBSR_EL1), NULL, reset_val, PMBSR_EL1, 0 },
+
 	{ SYS_DESC(SYS_PMINTENSET_EL1), access_pminten, reset_unknown, PMINTENSET_EL1 },
 	{ SYS_DESC(SYS_PMINTENCLR_EL1), access_pminten, NULL, PMINTENSET_EL1 },
 
-- 
2.21.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
