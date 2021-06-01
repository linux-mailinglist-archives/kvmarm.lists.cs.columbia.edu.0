Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 278433971AC
	for <lists+kvmarm@lfdr.de>; Tue,  1 Jun 2021 12:40:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6AF94086C;
	Tue,  1 Jun 2021 06:40:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cckWPlD7vCpS; Tue,  1 Jun 2021 06:40:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9BEB84A023;
	Tue,  1 Jun 2021 06:40:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 543AC407EF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 06:40:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nz34E6Q1CW+Q for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Jun 2021 06:40:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0B3B940212
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Jun 2021 06:40:15 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5712613B1;
 Tue,  1 Jun 2021 10:40:14 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lo1oj-004nNs-3j; Tue, 01 Jun 2021 11:40:13 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 4/9] KVM: arm64: vgic: Let an interrupt controller
 advertise lack of HW deactivation
Date: Tue,  1 Jun 2021 11:40:00 +0100
Message-Id: <20210601104005.81332-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601104005.81332-1-maz@kernel.org>
References: <20210601104005.81332-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, eric.auger@redhat.com, marcan@marcan.st,
 mark.rutland@arm.com, yuzenghui@huawei.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Hector Martin <marcan@marcan.st>
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

The vGIC, as architected by ARM, allows a virtual interrupt to
trigger the deactivation of a physical interrupt. This allows
the following interrupt to be delivered without requiring an exit.

However, some implementations have choosen not to implement this,
meaning that we will need some unsavoury workarounds to deal with this.

On detecting such a case, taint the kernel and spit a nastygram.
We'll deal with this in later patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c       | 10 ++++++++++
 include/kvm/arm_vgic.h                |  3 +++
 include/linux/irqchip/arm-vgic-info.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 6752d084934d..340c51d87677 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -532,6 +532,16 @@ int kvm_vgic_hyp_init(void)
 		return -ENXIO;
 	}
 
+	/*
+	 * If we get one of these oddball non-GICs, taint the kernel,
+	 * as we have no idea of how they *really* behave.
+	 */
+	if (gic_kvm_info->no_hw_deactivation) {
+		kvm_info("Non-architectural vgic, tainting kernel\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+		kvm_vgic_global_state.no_hw_deactivation = true;
+	}
+
 	switch (gic_kvm_info->type) {
 	case GIC_V2:
 		ret = vgic_v2_probe(gic_kvm_info);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index ec621180ef09..e45b26e8d479 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -72,6 +72,9 @@ struct vgic_global {
 	bool			has_gicv4;
 	bool			has_gicv4_1;
 
+	/* Pseudo GICv3 from outer space */
+	bool			no_hw_deactivation;
+
 	/* GIC system register CPU interface */
 	struct static_key_false gicv3_cpuif;
 
diff --git a/include/linux/irqchip/arm-vgic-info.h b/include/linux/irqchip/arm-vgic-info.h
index 7c0d08ebb82c..a75b2c7de69d 100644
--- a/include/linux/irqchip/arm-vgic-info.h
+++ b/include/linux/irqchip/arm-vgic-info.h
@@ -32,6 +32,8 @@ struct gic_kvm_info {
 	bool		has_v4;
 	/* rvpeid support */
 	bool		has_v4_1;
+	/* Deactivation impared, subpar stuff */
+	bool		no_hw_deactivation;
 };
 
 #ifdef CONFIG_KVM
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
