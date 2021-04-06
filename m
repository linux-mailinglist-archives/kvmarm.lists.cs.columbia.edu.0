Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02E96355495
	for <lists+kvmarm@lfdr.de>; Tue,  6 Apr 2021 15:10:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98F864B9BD;
	Tue,  6 Apr 2021 09:10:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gg3kTgTRumTZ; Tue,  6 Apr 2021 09:09:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 839C54B9DD;
	Tue,  6 Apr 2021 09:09:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A4384B8E7
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Apr 2021 08:21:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xXQOU5C4O28Z for <kvmarm@lists.cs.columbia.edu>;
 Tue,  6 Apr 2021 08:21:05 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A1B1B4B64D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  6 Apr 2021 08:21:05 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF65S1DsFzkhLv;
 Tue,  6 Apr 2021 20:19:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 20:20:43 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <maz@kernel.org>, <james.morse@arm.com>, <alexandru.elisei@arm.com>,
 <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
 <dbrazdil@google.com>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] KVM: arm64: Fix error return code in init_hyp_mode()
Date: Tue, 6 Apr 2021 12:17:59 +0000
Message-ID: <20210406121759.5407-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 06 Apr 2021 09:09:56 -0400
Cc: rui.xiang@huawei.com
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

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: eeeee7193df0 ("KVM: arm64: Bootstrap PSCI SMC handler in nVHE EL2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/arm64/kvm/arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 76a7de1..41e0b2a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1877,8 +1877,10 @@ static int init_hyp_mode(void)
 	if (is_protected_kvm_enabled()) {
 		init_cpu_logical_map();
 
-		if (!init_psci_relay())
+		if (!init_psci_relay()) {
+			err = -ENODEV;
 			goto out_err;
+		}
 	}
 
 	if (is_protected_kvm_enabled()) {
-- 
2.9.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
