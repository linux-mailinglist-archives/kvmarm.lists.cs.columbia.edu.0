Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17C35ABDC
	for <lists+kvmarm@lfdr.de>; Sat, 10 Apr 2021 10:17:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 61ACB4B780;
	Sat, 10 Apr 2021 04:17:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6frWt7lKyUk; Sat, 10 Apr 2021 04:17:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19BA64B767;
	Sat, 10 Apr 2021 04:17:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 644804B745
 for <kvmarm@lists.cs.columbia.edu>; Sat, 10 Apr 2021 04:17:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngwzKqqMKkom for <kvmarm@lists.cs.columbia.edu>;
 Sat, 10 Apr 2021 04:17:10 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B8254B735
 for <kvmarm@lists.cs.columbia.edu>; Sat, 10 Apr 2021 04:17:10 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHSTm4d6tz9xYS;
 Sat, 10 Apr 2021 16:14:52 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 16:16:58 +0800
From: Shaokun Zhang <zhangshaokun@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC] KVM: arm64: Support FEAT_CCIDX
Date: Sat, 10 Apr 2021 16:16:37 +0800
Message-ID: <1618042597-59294-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Marc Zyngier <maz@kernel.org>
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

CCSIDR_EL1 can be implemented as 64-bit format inferred by CCIDX field
in ID_AA64MMFR2_EL1. The bits of Numsets and Associativity are different
from the 32-bit format. Let's support this feature.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 52fdb9a015a4..0dc822cef20b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -18,6 +18,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kvm_arm.h>
@@ -95,9 +96,9 @@ static u32 cache_levels;
 #define CSSELR_MAX 14
 
 /* Which cache CCSIDR represents depends on CSSELR value. */
-static u32 get_ccsidr(u32 csselr)
+static u64 get_ccsidr(u32 csselr)
 {
-	u32 ccsidr;
+	u64 ccsidr;
 
 	/* Make sure noone else changes CSSELR during this! */
 	local_irq_disable();
@@ -1275,12 +1276,16 @@ static bool access_csselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 			  const struct sys_reg_desc *r)
 {
-	u32 csselr;
+	u32 csselr, ccidx;
+	u64 mmfr2;
 
 	if (p->is_write)
 		return write_to_read_only(vcpu, p, r);
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
+	mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
+	ccidx = cpuid_feature_extract_unsigned_field(mmfr2,
+						     ID_AA64MMFR2_CCIDX_SHIFT);
 	p->regval = get_ccsidr(csselr);
 
 	/*
@@ -1295,8 +1300,13 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	 * geometry (which is not permitted by the architecture), they would
 	 * only do so for virtually indexed caches.]
 	 */
-	if (!(csselr & 1)) // data or unified cache
-		p->regval &= ~GENMASK(27, 3);
+	if (!(csselr & 1)) { // data or unified cache
+		if (ccidx)
+			p->regval &= ~(GENMASK(23, 3) | GENMASK(55, 32));
+		else
+			p->regval &= ~GENMASK(27, 3);
+	}
+
 	return true;
 }
 
@@ -2521,7 +2531,7 @@ static bool is_valid_cache(u32 val)
 static int demux_c15_get(u64 id, void __user *uaddr)
 {
 	u32 val;
-	u32 __user *uval = uaddr;
+	u64 __user *uval = uaddr;
 
 	/* Fail if we have unknown bits set. */
 	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
@@ -2545,8 +2555,9 @@ static int demux_c15_get(u64 id, void __user *uaddr)
 
 static int demux_c15_set(u64 id, void __user *uaddr)
 {
-	u32 val, newval;
-	u32 __user *uval = uaddr;
+	u32 val;
+	u64 newval;
+	u64 __user *uval = uaddr;
 
 	/* Fail if we have unknown bits set. */
 	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
