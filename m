Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0246B1D6749
	for <lists+kvmarm@lfdr.de>; Sun, 17 May 2020 12:11:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5A444B0DA;
	Sun, 17 May 2020 06:11:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SE1t39KcSpIH; Sun, 17 May 2020 06:11:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A840E4B0E6;
	Sun, 17 May 2020 06:11:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FE894B0E2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 17 May 2020 06:11:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1NyYyYqaNc6E for <kvmarm@lists.cs.columbia.edu>;
 Sun, 17 May 2020 06:11:26 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 30EBA4B0DA
 for <kvmarm@lists.cs.columbia.edu>; Sun, 17 May 2020 06:11:26 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0DC9D623E945004D26DF;
 Sun, 17 May 2020 18:11:24 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.173.222.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sun, 17 May 2020 18:11:16 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <drjones@redhat.com>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <wangjingyi11@huawei.com>
Subject: [kvm-unit-tests PATCH 4/6] arm64: its: Handle its command queue
 wrapping
Date: Sun, 17 May 2020 18:08:58 +0800
Message-ID: <20200517100900.30792-5-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200517100900.30792-1-wangjingyi11@huawei.com>
References: <20200517100900.30792-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.173.222.58]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org
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

Because micro-bench may send a large number of ITS commands, we
should handle ITS command queue wrapping as kernel instead of just
failing the test.

Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 lib/arm64/gic-v3-its-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/arm64/gic-v3-its-cmd.c b/lib/arm64/gic-v3-its-cmd.c
index 2c208d1..34574f7 100644
--- a/lib/arm64/gic-v3-its-cmd.c
+++ b/lib/arm64/gic-v3-its-cmd.c
@@ -164,8 +164,9 @@ static struct its_cmd_block *its_allocate_entry(void)
 {
 	struct its_cmd_block *cmd;
 
-	assert((u64)its_data.cmd_write < (u64)its_data.cmd_base + SZ_64K);
 	cmd = its_data.cmd_write++;
+	if ((u64)its_data.cmd_write  == (u64)its_data.cmd_base + SZ_64K)
+		its_data.cmd_write = its_data.cmd_base;
 	return cmd;
 }
 
-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
