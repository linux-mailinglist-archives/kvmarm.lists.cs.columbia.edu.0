Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BE30770C
	for <lists+kvmarm@lfdr.de>; Thu, 28 Jan 2021 14:28:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E51794B19D;
	Thu, 28 Jan 2021 08:28:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttkgk-1kyZmi; Thu, 28 Jan 2021 08:28:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1899F4B1A0;
	Thu, 28 Jan 2021 08:28:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3807B4B199
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 08:28:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsrhRVMsGYgR for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Jan 2021 08:28:20 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6EC14B187
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 08:28:20 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F391396;
 Thu, 28 Jan 2021 05:28:20 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D31C3F719;
 Thu, 28 Jan 2021 05:28:19 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Correct spelling of DBGDIDR register
Date: Thu, 28 Jan 2021 13:28:23 +0000
Message-Id: <20210128132823.35067-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.30.0
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

The aarch32 debug ID register is called DBG*D*IDR (emphasis added), not
DBGIDR, use the correct spelling.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Found while reviewing Marc's PMU and debug register fixes [1]. The patch
was created on top of that series and v5.11-rc3.

[1] https://lore.kernel.org/kvmarm/20210125122638.2947058-1-maz@kernel.org/

 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0434e1672810..56f08e9f48c6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1714,7 +1714,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x700 },
 };
 
-static bool trap_dbgidr(struct kvm_vcpu *vcpu,
+static bool trap_dbgdidr(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
 {
@@ -1761,8 +1761,8 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
  * guest. Revisit this one day, would this principle change.
  */
 static const struct sys_reg_desc cp14_regs[] = {
-	/* DBGIDR */
-	{ Op1( 0), CRn( 0), CRm( 0), Op2( 0), trap_dbgidr },
+	/* DBGDIDR */
+	{ Op1( 0), CRn( 0), CRm( 0), Op2( 0), trap_dbgdidr },
 	/* DBGDTRRXext */
 	{ Op1( 0), CRn( 0), CRm( 0), Op2( 2), trap_raz_wi },
 
-- 
2.30.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
