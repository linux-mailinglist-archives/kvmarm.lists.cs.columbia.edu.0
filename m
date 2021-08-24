Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 31F343F61E9
	for <lists+kvmarm@lfdr.de>; Tue, 24 Aug 2021 17:44:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A81754B210;
	Tue, 24 Aug 2021 11:44:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9VSTaKLTMA23; Tue, 24 Aug 2021 11:44:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B885F4B1F5;
	Tue, 24 Aug 2021 11:44:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 29BD04B1E7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 11:44:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sD+E4sVrI81 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Aug 2021 11:44:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A6274B1DB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Aug 2021 11:44:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A040231B;
 Tue, 24 Aug 2021 08:44:13 -0700 (PDT)
Received: from monolith.cable.virginm.net (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 227D53F766;
 Tue, 24 Aug 2021 08:44:11 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 broonie@kernel.org
Subject: [PATCH v2] arm64: Do not trap PMSNEVFR_EL1
Date: Tue, 24 Aug 2021 16:45:23 +0100
Message-Id: <20210824154523.906270-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.33.0
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

Commit 31c00d2aeaa2 ("arm64: Disable fine grained traps on boot") zeroed
the fine grained trap registers to prevent unwanted register traps from
occuring. However, for the PMSNEVFR_EL1 register, the corresponding
HDFG{R,W}TR_EL2.nPMSNEVFR_EL1 fields must be 1 to disable trapping. Set
both fields to 1 if FEAT_SPEv1p2 is detected to disable read and write
traps.

Fixes: 31c00d2aeaa2 ("arm64: Disable fine grained traps on boot")
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Based on v5.14-rc7. Tested on the model, using boot-wrapper built from
commit 5cd6238ec4ef ("aarch32: fix .globl replacement"). Without this
patch, in NVHE mode, the model freezes when I try to access PMSNEVFR_EL1.
With this patch, the model doesn't hang anymore.

Changes since v1:

* Set the corresponding bit in HDFGWRTR_EL2 to also disable write traps. My
  thanks to Mark for pointing it out.

 arch/arm64/include/asm/el2_setup.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b83fb24954b7..3198acb2aad8 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -149,8 +149,17 @@
 	ubfx	x1, x1, #ID_AA64MMFR0_FGT_SHIFT, #4
 	cbz	x1, .Lskip_fgt_\@
 
-	msr_s	SYS_HDFGRTR_EL2, xzr
-	msr_s	SYS_HDFGWTR_EL2, xzr
+	mov	x0, xzr
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
+	cmp	x1, #3
+	b.lt	.Lset_fgt_\@
+	/* Disable PMSNEVFR_EL1 read and write traps */
+	orr	x0, x0, #(1 << 62)
+
+.Lset_fgt_\@:
+	msr_s	SYS_HDFGRTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x0
 	msr_s	SYS_HFGRTR_EL2, xzr
 	msr_s	SYS_HFGWTR_EL2, xzr
 	msr_s	SYS_HFGITR_EL2, xzr
-- 
2.33.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
