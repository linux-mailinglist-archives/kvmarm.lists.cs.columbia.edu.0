Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB765BD70
	for <lists+kvmarm@lfdr.de>; Tue,  3 Jan 2023 10:50:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05C914BB34;
	Tue,  3 Jan 2023 04:50:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgrJOjOQheBz; Tue,  3 Jan 2023 04:50:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAE224BB89;
	Tue,  3 Jan 2023 04:50:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 19EA34BB11
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 04:50:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZw81r1wlgIZ for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Jan 2023 04:50:51 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 407D140FBB
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Jan 2023 04:50:50 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id AC3EACE0FED;
 Tue,  3 Jan 2023 09:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB6C43396;
 Tue,  3 Jan 2023 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672739441;
 bh=LnbPmwBFwRROsH14ElnGWhQ/uokKwoNdvE7Mu57CUW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g/1Lt9wY022EX/9bDOLcEczP2G1XtOC8yV+cAWjmsb0VHhszxYOnyAkFNiYHf27HC
 sur0mUwSGRZNXrMKVGP8zvO8ppzI0YGrmQ64TO6L/uzmUx8Y0IB6wrmNejxZsovdWO
 jnoyPhNQHgMIf0Og3/B9p8E14y8PpDb22e9J/lsmKohPHQSkv8RM79d42iNrsZAxdV
 7ALMvk1CWTFSpIyUBaYKYsG76Fk/M7EMkQGAk1ThpHBjAz4DOLNGl/KAvWi6/LV+m9
 2HMlKVDcoV1WCTxlU8gnJmtoxNw8IUcJmZZLWQwssedPkddaojICuXNJOX4P3WFDVi
 8fF6SzreYk0Sw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1pCdwN-00GTcP-Ts;
 Tue, 03 Jan 2023 09:50:40 +0000
From: Marc Zyngier <maz@kernel.org>
To: <kvmarm@lists.cs.columbia.edu>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH 3/3] irqchip/apple-aic: Register vgic maintenance interrupt
 with KVM
Date: Tue,  3 Jan 2023 09:50:22 +0000
Message-Id: <20230103095022.3230946-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103095022.3230946-1-maz@kernel.org>
References: <20230103095022.3230946-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
 marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, tglx@linutronix.de,
 will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org, Sven Peter <sven@svenpeter.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

In order to deliver vgic maintenance interrupts that Nested Virt
requires, hook it into the FIQ space, even if it is delivered
as an IRQ (we don't distinguish between the two anyway).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 55 +++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index ae3437f03e6c..09fd52d91e45 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -210,7 +210,6 @@
 				 FIELD_PREP(AIC_EVENT_NUM, x))
 #define AIC_HWIRQ_IRQ(x)	FIELD_GET(AIC_EVENT_NUM, x)
 #define AIC_HWIRQ_DIE(x)	FIELD_GET(AIC_EVENT_DIE, x)
-#define AIC_NR_FIQ		6
 #define AIC_NR_SWIPI		32
 
 /*
@@ -222,11 +221,18 @@
  * running at EL2 (with VHE). When the kernel is running at EL1, the
  * mapping differs and aic_irq_domain_translate() performs the remapping.
  */
-
-#define AIC_TMR_EL0_PHYS	AIC_TMR_HV_PHYS
-#define AIC_TMR_EL0_VIRT	AIC_TMR_HV_VIRT
-#define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
-#define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
+enum fiq_hwirq {
+	/* Must be ordered as in apple-aic.h */
+	AIC_TMR_EL0_PHYS	= AIC_TMR_HV_PHYS,
+	AIC_TMR_EL0_VIRT	= AIC_TMR_HV_VIRT,
+	AIC_TMR_EL02_PHYS	= AIC_TMR_GUEST_PHYS,
+	AIC_TMR_EL02_VIRT	= AIC_TMR_GUEST_VIRT,
+	AIC_CPU_PMU_Effi	= AIC_CPU_PMU_E,
+	AIC_CPU_PMU_Perf	= AIC_CPU_PMU_P,
+	/* No need for this to be discovered from DT */
+	AIC_VGIC_MI,
+	AIC_NR_FIQ
+};
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 
@@ -384,14 +390,20 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 
 	/*
 	 * vGIC maintenance interrupts end up here too, so we need to check
-	 * for them separately. This should never trigger if KVM is working
-	 * properly, because it will have already taken care of clearing it
-	 * on guest exit before this handler runs.
+	 * for them separately. It should however only trigger when NV is
+	 * in use, and be cleared when coming back from the handler.
 	 */
-	if (is_kernel_in_hyp_mode() && (read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
-		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
-		pr_err_ratelimited("vGIC IRQ fired and not handled by KVM, disabling.\n");
-		sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
+	if (is_kernel_in_hyp_mode() &&
+	    (read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
+	    read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  AIC_FIQ_HWIRQ(AIC_VGIC_MI));
+
+		if (unlikely((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
+			     read_sysreg_s(SYS_ICH_MISR_EL2))) {
+			pr_err_ratelimited("vGIC IRQ fired and not handled by KVM, disabling.\n");
+			sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
+		}
 	}
 }
 
@@ -1178,6 +1190,23 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
 
+	if (is_kernel_in_hyp_mode()) {
+		struct irq_fwspec mi = {
+			.fwnode		= of_node_to_fwnode(node),
+			.param_count	= 3,
+			.param		= {
+				[0]	= AIC_FIQ, /* This is a lie */
+				[1]	= AIC_VGIC_MI,
+				[2]	= IRQ_TYPE_LEVEL_HIGH,
+			},
+		};
+
+		vgic_info.maint_irq = irq_domain_alloc_irqs(irqc->hw_domain,
+							    1, NUMA_NO_NODE,
+							    &mi);
+		WARN_ON(!vgic_info.maint_irq);
+	}
+
 	vgic_set_kvm_info(&vgic_info);
 
 	pr_info("Initialized with %d/%d IRQs * %d/%d die(s), %d FIQs, %d vIPIs",
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
