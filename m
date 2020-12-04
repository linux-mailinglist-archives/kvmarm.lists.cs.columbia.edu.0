Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDDDD2CE8A2
	for <lists+kvmarm@lfdr.de>; Fri,  4 Dec 2020 08:32:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B4CD4B1FC;
	Fri,  4 Dec 2020 02:32:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVzb3lao-OEp; Fri,  4 Dec 2020 02:32:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1732D4B226;
	Fri,  4 Dec 2020 02:32:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C9FF84B1AC
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 02:32:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2D5Hg80BkAht for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Dec 2020 02:32:23 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 059834B135
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Dec 2020 02:32:23 -0500 (EST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnPXm0T1wzhXvB;
 Fri,  4 Dec 2020 15:31:52 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 15:32:13 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH v3 1/2] clocksource: arm_arch_timer: Use stable count reader
 in erratum sne
Date: Fri, 4 Dec 2020 15:31:25 +0800
Message-ID: <20201204073126.6920-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20201204073126.6920-1-zhukeqian1@huawei.com>
References: <20201204073126.6920-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Alexios Zavras <alexios.zavras@intel.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>
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

In commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter
to access stable counters"), we separate stable and normal count reader to omit
unnecessary overhead on systems that have no timer erratum.

However, in erratum_set_next_event_tval_generic(), count reader becomes normal
reader. This converts it to stable reader.

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6c3e84180146..777d38cb39b0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -396,10 +396,10 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
-		cval = evt + arch_counter_get_cntpct();
+		cval = evt + arch_counter_get_cntpct_stable();
 		write_sysreg(cval, cntp_cval_el0);
 	} else {
-		cval = evt + arch_counter_get_cntvct();
+		cval = evt + arch_counter_get_cntvct_stable();
 		write_sysreg(cval, cntv_cval_el0);
 	}
 
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
