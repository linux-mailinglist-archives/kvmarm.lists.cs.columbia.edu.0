Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5915D9E3
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 15:57:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11FBC4AEB1;
	Fri, 14 Feb 2020 09:57:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PISlx2LdZDPl; Fri, 14 Feb 2020 09:57:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 581F74A95D;
	Fri, 14 Feb 2020 09:57:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 35E734A7E4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 09:57:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0SOW5XdQjs3 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 09:57:49 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 011544AE9E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 09:57:49 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2B27724681;
 Fri, 14 Feb 2020 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581692268;
 bh=kNgwkIvSiUh1x+liaoEQl3asDxJlp/aCxRuXoHWWqqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sbFhWqEp8X34b79OW7oH8jWuOYk5kXzxD/xQgaHIfDqorH999nikEFwJERhM1vMWr
 flKE8V+pXqLDmhhBM2UVeSjGOqGXj0A7krKTBEVCBuZSKER6xgm/O1PyrdkoQiyBEz
 Kx1eW/csCx5LVyj6fxLTVrYqzXA3O4T1/lrAyfxM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j2cPa-0057sw-HN; Fri, 14 Feb 2020 14:57:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/20] irqchip/gic-v3: Use SGIs without active state if
 offered
Date: Fri, 14 Feb 2020 14:57:18 +0000
Message-Id: <20200214145736.18550-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214145736.18550-1-maz@kernel.org>
References: <20200214145736.18550-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 rrichter@marvell.com, tglx@linutronix.de, yuzenghui@huawei.com,
 eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

To allow the direct injection of SGIs into a guest, the GICv4.1
architecture has to sacrifice the Active state so that SGIs look
a lot like LPIs (they are injected by the same mechanism).

In order not to break existing software, the architecture gives
offers guests OSs the choice: SGIs with or without an active
state. It is the hypervisors duty to honor the guest's choice.

For this, the architecture offers a discovery bit indicating whether
the GIC supports GICv4.1 SGIs (GICD_TYPER2.nASSGIcap), and another
bit indicating whether the guest wants Active-less SGIs or not
(controlled by GICD_CTLR.nASSGIreq).

A hypervisor not supporting GICv4.1 SGIs would leave nASSGIcap
clear, and a guest not knowing about GICv4.1 SGIs (or definitely
wanting an Active state) would leave nASSGIreq clear (both being
thankfully backward compatible with oler revisions of the GIC).

Since Linux is perfectly happy without an active state on SGIs,
inform the hypervisor that we'll use that if offered.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 10 ++++++++--
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cd76435c4a31..73e87e176d76 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -724,6 +724,7 @@ static void __init gic_dist_init(void)
 	unsigned int i;
 	u64 affinity;
 	void __iomem *base = gic_data.dist_base;
+	u32 val;
 
 	/* Disable the distributor */
 	writel_relaxed(0, base + GICD_CTLR);
@@ -756,9 +757,14 @@ static void __init gic_dist_init(void)
 	/* Now do the common stuff, and wait for the distributor to drain */
 	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
 
+	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
+	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
+		pr_info("Enabling SGIs without active state\n");
+		val |= GICD_CTLR_nASSGIreq;
+	}
+
 	/* Enable distributor with ARE, Group1 */
-	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
-		       base + GICD_CTLR);
+	writel_relaxed(val, base + GICD_CTLR);
 
 	/*
 	 * Set all global interrupts to the boot CPU only. ARE must be
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 83439bfb6c5b..c29a02678a6f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -57,6 +57,7 @@
 #define GICD_SPENDSGIR			0x0F20
 
 #define GICD_CTLR_RWP			(1U << 31)
+#define GICD_CTLR_nASSGIreq		(1U << 8)
 #define GICD_CTLR_DS			(1U << 6)
 #define GICD_CTLR_ARE_NS		(1U << 4)
 #define GICD_CTLR_ENABLE_G1A		(1U << 1)
@@ -90,6 +91,7 @@
 #define GICD_TYPER_ESPIS(typer)						\
 	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
+#define GICD_TYPER2_nASSGIcap		(1U << 8)
 #define GICD_TYPER2_VIL			(1U << 7)
 #define GICD_TYPER2_VID			GENMASK(4, 0)
 
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
