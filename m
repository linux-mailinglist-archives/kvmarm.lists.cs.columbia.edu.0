Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0F343909
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 07:02:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74BE24B437;
	Mon, 22 Mar 2021 02:02:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NAq4Ynq+Bwn2; Mon, 22 Mar 2021 02:02:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 643C24B432;
	Mon, 22 Mar 2021 02:02:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 26B834B3B7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 02:02:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gA0oNBjkEUxW for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 02:02:40 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C6E304B403
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 02:02:39 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F3kP42fgxzNq42;
 Mon, 22 Mar 2021 14:00:08 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 14:02:27 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Eric Auger <eric.auger@redhat.com>, "Will
 Deacon" <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/6] irqchip/gic-v3-its: Drop the setting of PTZ altogether
Date: Mon, 22 Mar 2021 14:01:54 +0800
Message-ID: <20210322060158.1584-3-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210322060158.1584-1-lushenming@huawei.com>
References: <20210322060158.1584-1-lushenming@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>
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

GICv4.1 gives a way to get the VLPI state, which needs to map the
vPE first, and after the state read, we may remap the vPE back while
the VPT is not empty. So we can't assume that the VPT is empty at
the first map. Besides, the optimization of PTZ is probably limited
since the HW should be fairly efficient to parse the empty VPT. Let's
drop the setting of PTZ altogether.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4eb907f65bd0..c8b5a88ac31c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -794,8 +794,16 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 
 	its_encode_alloc(cmd, alloc);
 
-	/* We can only signal PTZ when alloc==1. Why do we have two bits? */
-	its_encode_ptz(cmd, alloc);
+	/*
+	 * We can only signal PTZ when alloc==1. Why do we have two bits?
+	 * GICv4.1 gives a way to get the VLPI state, which needs the vPE
+	 * to be unmapped first, and in this case, we may remap the vPE
+	 * back while the VPT is not empty. So we can't assume that the
+	 * VPT is empty at the first map. Besides, the optimization of PTZ
+	 * is probably limited since the HW should be fairly efficient to
+	 * parse the empty VPT. Let's drop the setting of PTZ altogether.
+	 */
+	its_encode_ptz(cmd, false);
 	its_encode_vconf_addr(cmd, vconf_addr);
 	its_encode_vmapp_default_db(cmd, desc->its_vmapp_cmd.vpe->vpe_db_lpi);
 
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
