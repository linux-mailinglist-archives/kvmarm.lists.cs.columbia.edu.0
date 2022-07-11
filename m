Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B851C568F5E
	for <lists+kvmarm@lfdr.de>; Wed,  6 Jul 2022 18:43:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 335704BEA1;
	Wed,  6 Jul 2022 12:43:21 -0400 (EDT)
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
	with ESMTP id pzUbPIJ4A74v; Wed,  6 Jul 2022 12:43:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 494CE4BEB4;
	Wed,  6 Jul 2022 12:43:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E0FF44BEA1
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 12:43:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWGWl5h2N9oX for <kvmarm@lists.cs.columbia.edu>;
 Wed,  6 Jul 2022 12:43:14 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 64C0A4BE8D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  6 Jul 2022 12:43:14 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C4C7761DB2;
 Wed,  6 Jul 2022 16:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED85C341CB;
 Wed,  6 Jul 2022 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657125793;
 bh=zvkQPryqhyVOgAevsdQb5PWNWLx+6RcCLsRBZnS/7j0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mu6gRHyjlJx84co+Y2cNMRQY4tZAOTXSkyO+0G8whMzwWeUkkquJWSl480KJnzQYV
 ++zJVHSZVq6RZM+ATQMdWQJEapCRBMCj2qKAYLf1vlMegOOLaGytvFifbNNIbFRjQs
 ysJVelbnrCgO+klMzR+cKmZz/rfqSkKyz6UARRdc/yBqbZ1+CRsj9wbungrqbAmIs7
 QMo80yFH43OTGwNbT1uvhMqIElgcHaB3tVHG1FJszTrocRqCLSL+/f5PDCZVnPMtn9
 2zOc7/ZbwWdc1S5Rll+DGlvWpNShMMBttB82GhiN1An9BZ5pwuWqHdFFTtcLubFhPa
 B180jh2PaSnNQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1o987L-005h9i-9S;
 Wed, 06 Jul 2022 17:43:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/19] KVM: arm64: Introduce generic get_user/set_user helpers
 for system registers
Date: Wed,  6 Jul 2022 17:42:48 +0100
Message-Id: <20220706164304.1582687-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706164304.1582687-1-maz@kernel.org>
References: <20220706164304.1582687-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 schspa@gmail.com, kernel-team@android.com
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

The userspace access to the system registers is done using helpers
that hardcode the table that is looked up. extract some generic
helpers from this, moving the handling of hidden sysregs into
the core code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 60 +++++++++++++++++++++++++--------------
 arch/arm64/kvm/sys_regs.h |  6 ++++
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 9291cb94c2e4..0fbdb21a3600 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2663,8 +2663,10 @@ const struct sys_reg_desc *get_reg_by_id(u64 id,
 }
 
 /* Decode an index value, and find the sys_reg_desc entry. */
-static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
-						    u64 id)
+static const struct sys_reg_desc *
+id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
+		   const struct sys_reg_desc table[], unsigned int num)
+
 {
 	const struct sys_reg_desc *r;
 
@@ -2672,10 +2674,10 @@ static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
 		return NULL;
 
-	r = get_reg_by_id(id, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = get_reg_by_id(id, table, num);
 
 	/* Not saved in the sys_reg array and not otherwise accessible? */
-	if (r && !(r->reg || r->get_user))
+	if (r && (!(r->reg || r->get_user) || sysreg_hidden(vcpu, r)))
 		r = NULL;
 
 	return r;
@@ -2845,9 +2847,24 @@ static int demux_c15_set(u64 id, void __user *uaddr)
 	}
 }
 
-int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
 {
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
+
+	r = id_to_sys_reg_desc(vcpu, reg->id, table, num);
+	if (!r)
+		return -ENOENT;
+
+	if (r->get_user)
+		return (r->get_user)(vcpu, r, reg, uaddr);
+
+	return reg_to_user(uaddr, &__vcpu_sys_reg(vcpu, r->reg), reg->id);
+}
+
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
 	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
 	int err;
 
@@ -2861,21 +2878,28 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if (err != -ENOENT)
 		return err;
 
-	r = index_to_sys_reg_desc(vcpu, reg->id);
+	return kvm_sys_reg_get_user(vcpu, reg,
+				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+}
 
-	/* Check for regs disabled by runtime config */
-	if (!r || sysreg_hidden(vcpu, r))
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+	const struct sys_reg_desc *r;
+
+	r = id_to_sys_reg_desc(vcpu, reg->id, table, num);
+	if (!r)
 		return -ENOENT;
 
-	if (r->get_user)
-		return (r->get_user)(vcpu, r, reg, uaddr);
+	if (r->set_user)
+		return (r->set_user)(vcpu, r, reg, uaddr);
 
-	return reg_to_user(uaddr, &__vcpu_sys_reg(vcpu, r->reg), reg->id);
+	return reg_from_user(&__vcpu_sys_reg(vcpu, r->reg), uaddr, reg->id);
 }
 
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
-	const struct sys_reg_desc *r;
 	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
 	int err;
 
@@ -2889,16 +2913,8 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if (err != -ENOENT)
 		return err;
 
-	r = index_to_sys_reg_desc(vcpu, reg->id);
-
-	/* Check for regs disabled by runtime config */
-	if (!r || sysreg_hidden(vcpu, r))
-		return -ENOENT;
-
-	if (r->set_user)
-		return (r->set_user)(vcpu, r, reg, uaddr);
-
-	return reg_from_user(&__vcpu_sys_reg(vcpu, r->reg), uaddr, reg->id);
+	return kvm_sys_reg_set_user(vcpu, reg,
+				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 }
 
 static unsigned int num_demux_regs(void)
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index ce30ed9566ae..4fb6d59e7874 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -199,6 +199,12 @@ const struct sys_reg_desc *get_reg_by_id(u64 id,
 					 const struct sys_reg_desc table[],
 					 unsigned int num);
 
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num);
+
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num);
+
 #define AA32(_x)	.aarch32_map = AA32_##_x
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
