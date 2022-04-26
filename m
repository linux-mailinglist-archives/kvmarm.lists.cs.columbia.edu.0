Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0878250F717
	for <lists+kvmarm@lfdr.de>; Tue, 26 Apr 2022 11:34:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C0754B19F;
	Tue, 26 Apr 2022 05:34:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YWPfjLDVZP2d; Tue, 26 Apr 2022 05:34:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0BAC4B16F;
	Tue, 26 Apr 2022 05:34:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 52B6A49EE6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 05:34:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rz0ZVcKF88ya for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Apr 2022 05:34:47 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C84E143479
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Apr 2022 05:34:47 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A5923A;
 Tue, 26 Apr 2022 02:34:47 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601563F73B;
 Tue, 26 Apr 2022 02:34:46 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH RESEND 1/2] KVM/arm64: Don't BUG_ON() if emulated register
 table is unsorted
Date: Tue, 26 Apr 2022 10:34:38 +0100
Message-Id: <20220426093439.12159-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426093439.12159-1-alexandru.elisei@arm.com>
References: <20220426093439.12159-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

To emulate a register access, KVM uses a table of registers sorted by
register encoding to speed up queries using binary search.

When Linux boots, KVM checks that the table is sorted and uses a BUG_ON()
statement to let the user know if it's not. The unfortunate side effect is
that an unsorted sysreg table brings down the whole kernel, not just KVM,
even though the rest of the kernel can function just fine without KVM. To
make matters worse, on machines which lack a serial console, the user is
left pondering why the machine is taking so long to boot.

Improve this situation by returning an error from kvm_arch_init() if the
sysreg tables are not in the correct order. The machine is still very much
usable for the user, with the exception of virtualization, who can now
easily determine what went wrong.

A minor typo has also been corrected in the check_sysreg_table() function.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/kvm/arm.c              |  7 +++++--
 arch/arm64/kvm/sys_regs.c         | 33 ++++++++++++++++++-------------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 94a27a7520f4..39ca91cc1f01 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -686,7 +686,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu);
 
 void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
 
-void kvm_sys_reg_table_init(void);
+int kvm_sys_reg_table_init(void);
 
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..8bc38754ac02 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1761,8 +1761,6 @@ static int init_subsystems(void)
 
 	kvm_register_perf_callbacks(NULL);
 
-	kvm_sys_reg_table_init();
-
 out:
 	if (err || !is_protected_kvm_enabled())
 		on_each_cpu(_kvm_arch_hardware_disable, NULL, 1);
@@ -2089,6 +2087,11 @@ int kvm_arch_init(void *opaque)
 		return -ENODEV;
 	}
 
+	if (kvm_sys_reg_table_init()) {
+		kvm_info("Error initializing system register tables");
+		return -EINVAL;
+	}
+
 	in_hyp_mode = is_kernel_in_hyp_mode();
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE) ||
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7b45c040cc27..57302048afd0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2187,25 +2187,24 @@ static const struct sys_reg_desc cp15_64_regs[] = {
 	{ SYS_DESC(SYS_AARCH32_CNTP_CVAL),    access_arch_timer },
 };
 
-static int check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
-			      bool is_32)
+static bool check_sysreg_table(const struct sys_reg_desc *table, unsigned int n,
+			       bool is_32)
 {
 	unsigned int i;
 
 	for (i = 0; i < n; i++) {
 		if (!is_32 && table[i].reg && !table[i].reset) {
-			kvm_err("sys_reg table %p entry %d has lacks reset\n",
-				table, i);
-			return 1;
+			kvm_err("sys_reg table %p entry %d lacks reset\n", table, i);
+			return false;
 		}
 
 		if (i && cmp_sys_reg(&table[i-1], &table[i]) >= 0) {
 			kvm_err("sys_reg table %p out of order (%d)\n", table, i - 1);
-			return 1;
+			return false;
 		}
 	}
 
-	return 0;
+	return true;
 }
 
 int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu)
@@ -2860,18 +2859,22 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 	return write_demux_regids(uindices);
 }
 
-void kvm_sys_reg_table_init(void)
+int kvm_sys_reg_table_init(void)
 {
+	bool valid = true;
 	unsigned int i;
 	struct sys_reg_desc clidr;
 
 	/* Make sure tables are unique and in order. */
-	BUG_ON(check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false));
-	BUG_ON(check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs), true));
-	BUG_ON(check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs), true));
-	BUG_ON(check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), true));
-	BUG_ON(check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs), true));
-	BUG_ON(check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs), false));
+	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);
+	valid &= check_sysreg_table(cp14_regs, ARRAY_SIZE(cp14_regs), true);
+	valid &= check_sysreg_table(cp14_64_regs, ARRAY_SIZE(cp14_64_regs), true);
+	valid &= check_sysreg_table(cp15_regs, ARRAY_SIZE(cp15_regs), true);
+	valid &= check_sysreg_table(cp15_64_regs, ARRAY_SIZE(cp15_64_regs), true);
+	valid &= check_sysreg_table(invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs), false);
+
+	if (!valid)
+		return -EINVAL;
 
 	/* We abuse the reset function to overwrite the table itself. */
 	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
@@ -2894,4 +2897,6 @@ void kvm_sys_reg_table_init(void)
 			break;
 	/* Clear all higher bits. */
 	cache_levels &= (1 << (i*3))-1;
+
+	return 0;
 }
-- 
2.36.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
