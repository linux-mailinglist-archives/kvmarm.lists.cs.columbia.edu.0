Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86ADA153F77
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 08:58:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB05C4A7FD;
	Thu,  6 Feb 2020 02:58:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSS6P6kxuhMf; Thu,  6 Feb 2020 02:58:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD1744A7E4;
	Thu,  6 Feb 2020 02:58:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 74C0D4A5BD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 02:58:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xOfNTSWVeei for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 02:58:38 -0500 (EST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A902F4A541
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 02:58:37 -0500 (EST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 08269D722A8D21FE9BA8;
 Thu,  6 Feb 2020 15:58:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 15:58:23 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-kernel@vger.kernel.org>, <maz@kernel.org>
Subject: [PATCH v2 0/6] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
Date: Thu, 6 Feb 2020 15:57:05 +0800
Message-ID: <20200206075711.1275-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: jason@lakedaemon.net, tglx@linutronix.de, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi,

This series contains some cleanups, VPROPBASER field programming fix
and level2 vPE table allocation enhancement, collected while looking
through the GICv4.1 driver one more time.

Hope they will help, thanks!

v1 -> v2:
 - Take into account Marc's comments on patch#3
 - Add one more patch to rename V{PEND,PROP}BASER accessors

Zenghui Yu (6):
  irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
  irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
  irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
  irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
  irqchip/gic-v3-its: Remove superfluous WARN_ON
  irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors

 arch/arm/include/asm/arch_gicv3.h   |  12 +--
 arch/arm64/include/asm/arch_gicv3.h |   8 +-
 drivers/irqchip/irq-gic-v3-its.c    | 118 +++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h  |   2 +-
 4 files changed, 110 insertions(+), 30 deletions(-)

-- 
2.19.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
