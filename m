Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6726229C17D
	for <lists+kvmarm@lfdr.de>; Tue, 27 Oct 2020 18:26:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6264B49C;
	Tue, 27 Oct 2020 13:26:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cbwzwBw8pySL; Tue, 27 Oct 2020 13:26:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F303B4B4F3;
	Tue, 27 Oct 2020 13:26:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05A3D4B4B2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:26:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id prPrUO+ubSJR for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Oct 2020 13:26:25 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34CA54B3F3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Oct 2020 13:26:24 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63C0139F;
 Tue, 27 Oct 2020 10:26:23 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2F873F719;
 Tue, 27 Oct 2020 10:26:22 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH v3 07/16] KVM: arm64: Define SPE data structure for each
 VCPU
Date: Tue, 27 Oct 2020 17:26:56 +0000
Message-Id: <20201027172705.15181-8-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027172705.15181-1-alexandru.elisei@arm.com>
References: <20201027172705.15181-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: maz@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Andrew Murray <andrew.murray@arm.com>, will@kernel.org
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

Define basic struct for supporting SPE for guest VCPUs.

[Andrew M: Add irq_level, rename irq to irq_num for kvm_spe ]
[Alexandru E: Reworked patch ]

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 include/kvm/arm_spe.h             | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 43eee197764f..5b68c06930c6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_pmu.h>
+#include <kvm/arm_spe.h>
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
@@ -329,6 +330,7 @@ struct kvm_vcpu_arch {
 	struct vgic_cpu vgic_cpu;
 	struct arch_timer_cpu timer_cpu;
 	struct kvm_pmu pmu;
+	struct kvm_spe_cpu spe_cpu;
 
 	/*
 	 * Anything that is not used directly from assembly code goes
diff --git a/include/kvm/arm_spe.h b/include/kvm/arm_spe.h
index db51ef15bf45..46ec447ed013 100644
--- a/include/kvm/arm_spe.h
+++ b/include/kvm/arm_spe.h
@@ -12,8 +12,17 @@ static inline bool kvm_arm_supports_spe(void)
 	return cpus_have_final_cap(ARM64_SPE);
 }
 
+struct kvm_spe_cpu {
+	int irq_num; 		/* Guest visibile INTID */
+	bool irq_level; 	/* 'true' if interrupt is asserted to the VGIC */
+	bool initialized; 	/* Feature is initialized on VCPU */
+};
+
 #else
 #define kvm_arm_supports_spe()	false
 
+struct kvm_spe_cpu {
+};
+
 #endif /* CONFIG_KVM_ARM_SPE */
 #endif /* __ASM_ARM_KVM_SPE_H */
-- 
2.29.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
