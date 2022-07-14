Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F3D835751A3
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jul 2022 17:20:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7617C4C5E1;
	Thu, 14 Jul 2022 11:20:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RovtjQz4xg1l; Thu, 14 Jul 2022 11:20:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B731D4C5E5;
	Thu, 14 Jul 2022 11:20:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F4804C543
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9Te7CNWt6Ag for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jul 2022 11:20:32 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 72FB94C557
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:32 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 353FCB82680;
 Thu, 14 Jul 2022 15:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862FCC341CD;
 Thu, 14 Jul 2022 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657812030;
 bh=QK7xzqKdzwM9026W5LMc0VeA/B0uD3neG+lH8W/qYlA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RrxZk6AR6gI+fT+CoVuxjXbDiggzAKBPv5exN6EGQBmDMKVdVBCzxYFIoK8tF9ND2
 DBek05/tNNmpG4+iAt38UtPkqyRnWza1csNvbjiCA8+9tXWsRbC2mWnr1jOyY274XW
 SC7FR3ng12Isbkr3cPZtJyaXguaic1kVdt/4sToE5p59il+rKQrhpulwlYXMUx0vdy
 3OpJkBwOV0VJ91QBTJc67F4aqBFQeY4JMFS/UOM9y24rzeT8uJ7e1lVCVloi+1XunW
 EO4IV8ordMY8f0YIW9kxFH5xhFdEZp5KQn7hlLui+GXGqZcl7FSA+tMtN5ljCXmZWn
 aYzgUJwZ4c1RQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oC0dg-007UVL-Me;
 Thu, 14 Jul 2022 16:20:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/20] KVM: arm64: Consolidate sysreg userspace accesses
Date: Thu, 14 Jul 2022 16:20:09 +0100
Message-Id: <20220714152024.1673368-6-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714152024.1673368-1-maz@kernel.org>
References: <20220714152024.1673368-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 reijiw@google.com, schspa@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Schspa Shi <schspa@gmail.com>, kernel-team@android.com,
 Oliver Upton <oliver.upton@linux.dev>
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

Until now, the .set_user and .get_user callbacks have to implement
(directly or not) the userspace memory accesses. Although this gives
us maximem flexibility, this is also a maintenance burden, making it
hard to audit, and I'd feel much better if it was all located in
a single place.

So let's do just that, simplifying most of the function signatures
in the process (the callbacks are now only concerned with the
data itself, and not with userspace).

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 160 ++++++++++++++------------------------
 arch/arm64/kvm/sys_regs.h |   4 +-
 2 files changed, 61 insertions(+), 103 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5dbe0f4b8167..526798524697 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -321,16 +321,8 @@ static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
 }
 
 static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			 const struct kvm_one_reg *reg, void __user *uaddr)
+			 u64 val)
 {
-	u64 id = sys_reg_to_index(rd);
-	u64 val;
-	int err;
-
-	err = reg_from_user(&val, uaddr, id);
-	if (err)
-		return err;
-
 	/*
 	 * The only modifiable bit is the OSLK bit. Refuse the write if
 	 * userspace attempts to change any other bit in the register.
@@ -451,22 +443,16 @@ static bool trap_bvr(struct kvm_vcpu *vcpu,
 }
 
 static int set_bvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bvr[rd->CRm];
-
-	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	vcpu->arch.vcpu_debug_state.dbg_bvr[rd->CRm] = val;
 	return 0;
 }
 
 static int get_bvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-	const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 *val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bvr[rd->CRm];
-
-	if (copy_to_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	*val = vcpu->arch.vcpu_debug_state.dbg_bvr[rd->CRm];
 	return 0;
 }
 
@@ -493,23 +479,16 @@ static bool trap_bcr(struct kvm_vcpu *vcpu,
 }
 
 static int set_bcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bcr[rd->CRm];
-
-	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
-
+	vcpu->arch.vcpu_debug_state.dbg_bcr[rd->CRm] = val;
 	return 0;
 }
 
 static int get_bcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-	const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 *val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_bcr[rd->CRm];
-
-	if (copy_to_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	*val = vcpu->arch.vcpu_debug_state.dbg_bcr[rd->CRm];
 	return 0;
 }
 
@@ -537,22 +516,16 @@ static bool trap_wvr(struct kvm_vcpu *vcpu,
 }
 
 static int set_wvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wvr[rd->CRm];
-
-	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	vcpu->arch.vcpu_debug_state.dbg_wvr[rd->CRm] = val;
 	return 0;
 }
 
 static int get_wvr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-	const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 *val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wvr[rd->CRm];
-
-	if (copy_to_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	*val = vcpu->arch.vcpu_debug_state.dbg_wvr[rd->CRm];
 	return 0;
 }
 
@@ -579,22 +552,16 @@ static bool trap_wcr(struct kvm_vcpu *vcpu,
 }
 
 static int set_wcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wcr[rd->CRm];
-
-	if (copy_from_user(r, uaddr, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	vcpu->arch.vcpu_debug_state.dbg_wcr[rd->CRm] = val;
 	return 0;
 }
 
 static int get_wcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-	const struct kvm_one_reg *reg, void __user *uaddr)
+		   u64 *val)
 {
-	__u64 *r = &vcpu->arch.vcpu_debug_state.dbg_wcr[rd->CRm];
-
-	if (copy_to_user(uaddr, r, KVM_REG_SIZE(reg->id)) != 0)
-		return -EFAULT;
+	*val = vcpu->arch.vcpu_debug_state.dbg_wcr[rd->CRm];
 	return 0;
 }
 
@@ -1227,16 +1194,9 @@ static unsigned int sve_visibility(const struct kvm_vcpu *vcpu,
 
 static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 			       const struct sys_reg_desc *rd,
-			       const struct kvm_one_reg *reg, void __user *uaddr)
+			       u64 val)
 {
-	const u64 id = sys_reg_to_index(rd);
 	u8 csv2, csv3;
-	int err;
-	u64 val;
-
-	err = reg_from_user(&val, uaddr, id);
-	if (err)
-		return err;
 
 	/*
 	 * Allow AA64PFR0_EL1.CSV2 to be set from userspace as long as
@@ -1262,7 +1222,7 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	vcpu->kvm->arch.pfr0_csv2 = csv2;
-	vcpu->kvm->arch.pfr0_csv3 = csv3 ;
+	vcpu->kvm->arch.pfr0_csv3 = csv3;
 
 	return 0;
 }
@@ -1275,27 +1235,17 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
  * to be changed.
  */
 static int __get_id_reg(const struct kvm_vcpu *vcpu,
-			const struct sys_reg_desc *rd, void __user *uaddr,
+			const struct sys_reg_desc *rd, u64 *val,
 			bool raz)
 {
-	const u64 id = sys_reg_to_index(rd);
-	const u64 val = read_id_reg(vcpu, rd, raz);
-
-	return reg_to_user(uaddr, &val, id);
+	*val = read_id_reg(vcpu, rd, raz);
+	return 0;
 }
 
 static int __set_id_reg(const struct kvm_vcpu *vcpu,
-			const struct sys_reg_desc *rd, void __user *uaddr,
+			const struct sys_reg_desc *rd, u64 val,
 			bool raz)
 {
-	const u64 id = sys_reg_to_index(rd);
-	int err;
-	u64 val;
-
-	err = reg_from_user(&val, uaddr, id);
-	if (err)
-		return err;
-
 	/* This is what we mean by invariant: you can't change it. */
 	if (val != read_id_reg(vcpu, rd, raz))
 		return -EINVAL;
@@ -1304,47 +1254,37 @@ static int __set_id_reg(const struct kvm_vcpu *vcpu,
 }
 
 static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      const struct kvm_one_reg *reg, void __user *uaddr)
+		      u64 *val)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, rd);
 
-	return __get_id_reg(vcpu, rd, uaddr, raz);
+	return __get_id_reg(vcpu, rd, val, raz);
 }
 
 static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      const struct kvm_one_reg *reg, void __user *uaddr)
+		      u64 val)
 {
 	bool raz = sysreg_visible_as_raz(vcpu, rd);
 
-	return __set_id_reg(vcpu, rd, uaddr, raz);
+	return __set_id_reg(vcpu, rd, val, raz);
 }
 
 static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			  const struct kvm_one_reg *reg, void __user *uaddr)
+			  u64 val)
 {
-	return __set_id_reg(vcpu, rd, uaddr, true);
+	return __set_id_reg(vcpu, rd, val, true);
 }
 
 static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		       const struct kvm_one_reg *reg, void __user *uaddr)
+		       u64 *val)
 {
-	const u64 id = sys_reg_to_index(rd);
-	const u64 val = 0;
-
-	return reg_to_user(uaddr, &val, id);
+	*val = 0;
+	return 0;
 }
 
 static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-		      const struct kvm_one_reg *reg, void __user *uaddr)
+		      u64 val)
 {
-	int err;
-	u64 val;
-
-	/* Perform the access even if we are going to ignore the value */
-	err = reg_from_user(&val, uaddr, sys_reg_to_index(rd));
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -2850,17 +2790,26 @@ static int demux_c15_set(u64 id, void __user *uaddr)
 int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 			 const struct sys_reg_desc table[], unsigned int num)
 {
-	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
+	u64 val;
+	int ret;
 
 	r = id_to_sys_reg_desc(vcpu, reg->id, table, num);
 	if (!r)
 		return -ENOENT;
 
-	if (r->get_user)
-		return (r->get_user)(vcpu, r, reg, uaddr);
+	if (r->get_user) {
+		ret = (r->get_user)(vcpu, r, &val);
+	} else {
+		val = __vcpu_sys_reg(vcpu, r->reg);
+		ret = 0;
+	}
+
+	if (!ret)
+		ret = put_user(val, uaddr);
 
-	return reg_to_user(uaddr, &__vcpu_sys_reg(vcpu, r->reg), reg->id);
+	return ret;
 }
 
 int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -2882,17 +2831,26 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 			 const struct sys_reg_desc table[], unsigned int num)
 {
-	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
+	u64 val;
+	int ret;
+
+	if (get_user(val, uaddr))
+		return -EFAULT;
 
 	r = id_to_sys_reg_desc(vcpu, reg->id, table, num);
 	if (!r)
 		return -ENOENT;
 
-	if (r->set_user)
-		return (r->set_user)(vcpu, r, reg, uaddr);
+	if (r->set_user) {
+		ret = (r->set_user)(vcpu, r, val);
+	} else {
+		__vcpu_sys_reg(vcpu, r->reg) = val;
+		ret = 0;
+	}
 
-	return reg_from_user(&__vcpu_sys_reg(vcpu, r->reg), uaddr, reg->id);
+	return ret;
 }
 
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 4fb6d59e7874..b8b576a2af2b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -75,9 +75,9 @@ struct sys_reg_desc {
 
 	/* Custom get/set_user functions, fallback to generic if NULL */
 	int (*get_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			const struct kvm_one_reg *reg, void __user *uaddr);
+			u64 *val);
 	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
-			const struct kvm_one_reg *reg, void __user *uaddr);
+			u64 val);
 
 	/* Return mask of REG_* runtime visibility overrides */
 	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
