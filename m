Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B52F02A2393
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 04:37:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C0E44B589;
	Sun,  1 Nov 2020 22:37:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QczkZ9JbHS3R; Sun,  1 Nov 2020 22:37:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 620B04B4E8;
	Sun,  1 Nov 2020 22:37:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EE0C4B4CF
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6nKjzbHmNeCV for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Nov 2020 22:37:35 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D20D74B4F7
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:34 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CPds712PwzhbC2;
 Mon,  2 Nov 2020 11:37:31 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 11:37:20 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [RFC v3 08/12] kvm: arm64: Make ID_DFR0_EL1 configurable
Date: Mon, 2 Nov 2020 11:34:18 +0800
Message-ID: <20201102033422.657391-9-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102033422.657391-1-liangpeng10@huawei.com>
References: <20201102033422.657391-1-liangpeng10@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org
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

Except that each ID field should be not greater than that of host,
PerfMon must be 0b0100 (PMUv3 for Armv8.1).

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 arch/arm64/kvm/sys_regs.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2ea165d09c7b..aac62f6fa846 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1323,6 +1323,32 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	return __set_id_reg(vcpu, rd, uaddr, true);
 }
 
+static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
+		const struct sys_reg_desc *rd,
+		const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	u32 reg_id = sys_reg((u32)rd->Op0, (u32)rd->Op1, (u32)rd->CRn,
+			     (u32)rd->CRm, (u32)rd->Op2);
+	int err;
+	u64 val;
+
+	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
+	if (err)
+		return err;
+
+	err = check_features(reg_id, val);
+	if (err)
+		return err;
+
+	/* Limit guests to PMUv3 for ARMv8.1 */
+	if (cpuid_feature_extract_signed_field(val, ID_DFR0_PERFMON_SHIFT) !=
+	    ID_DFR0_PERFMON_8_1)
+		return -EINVAL;
+
+	__vcpu_sys_reg(vcpu, ID_REG_INDEX(reg_id)) = val;
+	return 0;
+}
+
 static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 		const struct sys_reg_desc *rd,
 		const struct kvm_one_reg *reg, void __user *uaddr)
@@ -1642,7 +1668,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	/* CRm=1 */
 	ID_SANITISED(ID_PFR0_EL1),
 	ID_SANITISED(ID_PFR1_EL1),
-	ID_SANITISED(ID_DFR0_EL1),
+	{ SYS_DESC(SYS_ID_DFR0_EL1), access_id_reg, .get_user = get_id_reg, .set_user = set_id_dfr0_el1 },
 	ID_HIDDEN(ID_AFR0_EL1),
 	ID_SANITISED(ID_MMFR0_EL1),
 	ID_SANITISED(ID_MMFR1_EL1),
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
