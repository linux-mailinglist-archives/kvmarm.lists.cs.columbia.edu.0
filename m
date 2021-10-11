Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 789D0428BA5
	for <lists+kvmarm@lfdr.de>; Mon, 11 Oct 2021 12:57:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 254E04B0A3;
	Mon, 11 Oct 2021 06:57:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQBdbTmVwTYA; Mon, 11 Oct 2021 06:57:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D00F4B0CC;
	Mon, 11 Oct 2021 06:57:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF5DC49DE3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 06:57:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a50tgsFHFsxC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 Oct 2021 06:57:17 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A6B4A407F1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 06:57:17 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5765B11D4;
 Mon, 11 Oct 2021 03:57:17 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16853F66F;
 Mon, 11 Oct 2021 03:57:15 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 drjones@redhat.com
Subject: [PATCH v2 2/3] KVM: arm64: Use get_raz_reg() for userspace reads of
 PMSWINC_EL0
Date: Mon, 11 Oct 2021 11:58:39 +0100
Message-Id: <20211011105840.155815-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011105840.155815-1-alexandru.elisei@arm.com>
References: <20211011105840.155815-1-alexandru.elisei@arm.com>
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

PMSWINC_EL0 is a write-only register and was initially part of the VCPU
register state, but was later removed in commit 7a3ba3095a32 ("KVM:
arm64: Remove PMSWINC_EL0 shadow register"). To prevent regressions, the
register was kept accessible from userspace as Read-As-Zero (RAZ).

The read function that is used to handle userspace reads of this
register is get_raz_id_reg(), which, while technically correct, as it
returns 0, it is not semantically correct, as PMSWINC_EL0 is not an ID
register as the function name suggests.

Add a new function, get_raz_reg(), to use it as the accessor for
PMSWINC_EL0, as to not conflate get_raz_id_reg() to handle other types
of registers.

No functional change intended.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4adda8bf3168..1be827740f87 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1285,6 +1285,15 @@ static int set_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	return __set_id_reg(vcpu, rd, uaddr, true);
 }
 
+static int get_raz_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
+		       const struct kvm_one_reg *reg, void __user *uaddr)
+{
+	const u64 id = sys_reg_to_index(rd);
+	const u64 val = 0;
+
+	return reg_to_user(uaddr, &val, id);
+}
+
 static int set_wi_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 		      const struct kvm_one_reg *reg, void __user *uaddr)
 {
@@ -1647,7 +1656,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	 * previously (and pointlessly) advertised in the past...
 	 */
 	{ PMU_SYS_REG(SYS_PMSWINC_EL0),
-	  .get_user = get_raz_id_reg, .set_user = set_wi_reg,
+	  .get_user = get_raz_reg, .set_user = set_wi_reg,
 	  .access = access_pmswinc, .reset = NULL },
 	{ PMU_SYS_REG(SYS_PMSELR_EL0),
 	  .access = access_pmselr, .reset = reset_pmselr, .reg = PMSELR_EL0 },
-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
