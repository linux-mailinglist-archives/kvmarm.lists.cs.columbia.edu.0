Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CA1D226DB23
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 14:09:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F8934B3F2;
	Thu, 17 Sep 2020 08:09:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTMjdRAXKvDG; Thu, 17 Sep 2020 08:09:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 745564B3D7;
	Thu, 17 Sep 2020 08:09:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A9544B1C1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 08:09:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9BL95wXKpJq for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Sep 2020 08:09:48 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DD7694B3D7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 08:09:47 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AB8C3B84A314242F4F9B;
 Thu, 17 Sep 2020 20:09:44 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:09:38 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [RFC v2 4/7] kvm: arm64: introduce check_user
Date: Thu, 17 Sep 2020 20:00:58 +0800
Message-ID: <20200917120101.3438389-5-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917120101.3438389-1-liangpeng10@huawei.com>
References: <20200917120101.3438389-1-liangpeng10@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.104.175]
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

Currently, if we need to check the value of the register defined by user
space, we should check it in set_user.  However, some system registers
may use the same set_user (for example, almost all ID registers), which
make it difficult to validate the value defined by user space.

Introduce check_user to solve the problem.  And apply check_user before
set_user to make sure that the value of register is valid.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 arch/arm64/kvm/sys_regs.c | 7 +++++++
 arch/arm64/kvm/sys_regs.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2b0fa8d5ac62..86ebb8093c3c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2684,6 +2684,7 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 {
 	const struct sys_reg_desc *r;
 	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+	int err;
 
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
 		return demux_c15_set(reg->id, uaddr);
@@ -2699,6 +2700,12 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if (sysreg_hidden_from_user(vcpu, r))
 		return -ENOENT;
 
+	if (r->check_user) {
+		err = (r->check_user)(vcpu, r, reg, uaddr);
+		if (err)
+			return err;
+	}
+
 	if (r->set_user)
 		return (r->set_user)(vcpu, r, reg, uaddr);
 
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 5a6fc30f5989..9bce5e9a3490 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -53,6 +53,12 @@ struct sys_reg_desc {
 			const struct kvm_one_reg *reg, void __user *uaddr);
 	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			const struct kvm_one_reg *reg, void __user *uaddr);
+	/*
+	 * Check the value userspace passed.  It should return 0 on success and
+	 * otherwise on failure.
+	 */
+	int (*check_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+			  const struct kvm_one_reg *reg, void __user *uaddr);
 
 	/* Return mask of REG_* runtime visibility overrides */
 	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
