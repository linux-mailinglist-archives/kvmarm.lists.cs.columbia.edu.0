Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 068D62E942B
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 12:38:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7EF3F4B09F;
	Mon,  4 Jan 2021 06:38:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SnqWu36Bi0rZ; Mon,  4 Jan 2021 06:38:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A7B84B082;
	Mon,  4 Jan 2021 06:38:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DF7814A4CD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 06:38:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2XEuvv2vuY7 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 06:38:50 -0500 (EST)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E8344A4A3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 06:38:49 -0500 (EST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400;
 MF=shannon.zhao@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UKgV1wg_1609760324; 
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com
 fp:SMTPD_---0UKgV1wg_1609760324) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 04 Jan 2021 19:38:44 +0800
From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
To: kvmarm@lists.cs.columbia.edu, maz@kernel.org, will@kernel.org,
 anshuman.khandual@arm.com, suzuki.poulose@arm.com
Subject: [PATCH] arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST
Date: Mon,  4 Jan 2021 19:38:44 +0800
Message-Id: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Commit d82755b2e781 ("KVM: arm64: Kill off CONFIG_KVM_ARM_HOST") deletes
CONFIG_KVM_ARM_HOST option, it should use CONFIG_KVM instead.

Just remove CONFIG_KVM_ARM_HOST here.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ffb5f1..e99edde 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2568,7 +2568,7 @@ static void verify_hyp_capabilities(void)
 	int parange, ipa_max;
 	unsigned int safe_vmid_bits, vmid_bits;
 
-	if (!IS_ENABLED(CONFIG_KVM) || !IS_ENABLED(CONFIG_KVM_ARM_HOST))
+	if (!IS_ENABLED(CONFIG_KVM))
 		return;
 
 	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
