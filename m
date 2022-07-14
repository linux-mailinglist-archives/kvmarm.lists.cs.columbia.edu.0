Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9621057519D
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jul 2022 17:20:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1003E4C57C;
	Thu, 14 Jul 2022 11:20:38 -0400 (EDT)
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
	with ESMTP id 1UzP3ucTde7a; Thu, 14 Jul 2022 11:20:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EEA54C5CF;
	Thu, 14 Jul 2022 11:20:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C856A4C582
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukHomNe6ucKJ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jul 2022 11:20:32 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C0424C50B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 11:20:32 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E031B8267F;
 Thu, 14 Jul 2022 15:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE7C3411C;
 Thu, 14 Jul 2022 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657812029;
 bh=yGSVikAXh6ko/ezJVylV7qAjLHhhOOv5IiRN+ELb77E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ac24+hD2HQEFFJtr8b9wUBmVL9h8Ze8IF3btoS5nqIWErv483eCVX85UHBsrYXtge
 h5o2R7/siwfwecIn82GaWjUsnbZKDNKSEDkfJnMh+8Emy7cUOdtxBVy20uRh2U/QSi
 +l+56s2LWfsa6Ksq3Z9MNiv+l4hmmZNDkFXwsPd3QX2tLXg6AXlAzgWP0BwOtBlpai
 Fo05f6nQNJNAtyi3dtnLTYJjf4ab8hswi4dB37a2MyedSxzRLy2A3vGleCyrhukW9Y
 rJkuIxFAUbSALoVrJ029hCeY2EapXjinLSTkrtJ5S/8JzELTmIIGSDoW/xbPH4PbFt
 8x0+0JK8G5B4Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oC0df-007UVL-Rq;
 Thu, 14 Jul 2022 16:20:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/20] KVM: arm64: Add get_reg_by_id() as a sys_reg_desc
 retrieving helper
Date: Thu, 14 Jul 2022 16:20:05 +0100
Message-Id: <20220714152024.1673368-2-maz@kernel.org>
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

find_reg_by_id() requires a sys_reg_param as input, which most
users provide as a on-stack variable, but don't make any use of
the result.

Provide a helper that doesn't have this requirement and simplify
the callers (all but one).

Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c        | 28 +++++++++++++++++-----------
 arch/arm64/kvm/sys_regs.h        |  4 ++++
 arch/arm64/kvm/vgic-sys-reg-v3.c |  8 ++------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c06c0477fab5..1f410283c592 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2650,21 +2650,29 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 	return find_reg(params, table, num);
 }
 
+const struct sys_reg_desc *get_reg_by_id(u64 id,
+					 const struct sys_reg_desc table[],
+					 unsigned int num)
+{
+	struct sys_reg_params params;
+
+	if (!index_to_params(id, &params))
+		return NULL;
+
+	return find_reg(&params, table, num);
+}
+
 /* Decode an index value, and find the sys_reg_desc entry. */
 static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
 						    u64 id)
 {
 	const struct sys_reg_desc *r;
-	struct sys_reg_params params;
 
 	/* We only do sys_reg for now. */
 	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
 		return NULL;
 
-	if (!index_to_params(id, &params))
-		return NULL;
-
-	r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+	r = get_reg_by_id(id, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 
 	/* Not saved in the sys_reg array and not otherwise accessible? */
 	if (r && !(r->reg || r->get_user))
@@ -2723,11 +2731,10 @@ static int reg_to_user(void __user *uaddr, const u64 *val, u64 id)
 
 static int get_invariant_sys_reg(u64 id, void __user *uaddr)
 {
-	struct sys_reg_params params;
 	const struct sys_reg_desc *r;
 
-	r = find_reg_by_id(id, &params, invariant_sys_regs,
-			   ARRAY_SIZE(invariant_sys_regs));
+	r = get_reg_by_id(id, invariant_sys_regs,
+			  ARRAY_SIZE(invariant_sys_regs));
 	if (!r)
 		return -ENOENT;
 
@@ -2736,13 +2743,12 @@ static int get_invariant_sys_reg(u64 id, void __user *uaddr)
 
 static int set_invariant_sys_reg(u64 id, void __user *uaddr)
 {
-	struct sys_reg_params params;
 	const struct sys_reg_desc *r;
 	int err;
 	u64 val = 0; /* Make sure high bits are 0 for 32-bit regs */
 
-	r = find_reg_by_id(id, &params, invariant_sys_regs,
-			   ARRAY_SIZE(invariant_sys_regs));
+	r = get_reg_by_id(id, invariant_sys_regs,
+			  ARRAY_SIZE(invariant_sys_regs));
 	if (!r)
 		return -ENOENT;
 
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index aee8ea054f0d..ce30ed9566ae 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -195,6 +195,10 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 					  const struct sys_reg_desc table[],
 					  unsigned int num);
 
+const struct sys_reg_desc *get_reg_by_id(u64 id,
+					 const struct sys_reg_desc table[],
+					 unsigned int num);
+
 #define AA32(_x)	.aarch32_map = AA32_##_x
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
diff --git a/arch/arm64/kvm/vgic-sys-reg-v3.c b/arch/arm64/kvm/vgic-sys-reg-v3.c
index 07d5271e9f05..644acda33c7c 100644
--- a/arch/arm64/kvm/vgic-sys-reg-v3.c
+++ b/arch/arm64/kvm/vgic-sys-reg-v3.c
@@ -263,14 +263,10 @@ static const struct sys_reg_desc gic_v3_icc_reg_descs[] = {
 int vgic_v3_has_cpu_sysregs_attr(struct kvm_vcpu *vcpu, bool is_write, u64 id,
 				u64 *reg)
 {
-	struct sys_reg_params params;
 	u64 sysreg = (id & KVM_DEV_ARM_VGIC_SYSREG_MASK) | KVM_REG_SIZE_U64;
 
-	params.regval = *reg;
-	params.is_write = is_write;
-
-	if (find_reg_by_id(sysreg, &params, gic_v3_icc_reg_descs,
-			      ARRAY_SIZE(gic_v3_icc_reg_descs)))
+	if (get_reg_by_id(sysreg, gic_v3_icc_reg_descs,
+			  ARRAY_SIZE(gic_v3_icc_reg_descs)))
 		return 0;
 
 	return -ENXIO;
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
