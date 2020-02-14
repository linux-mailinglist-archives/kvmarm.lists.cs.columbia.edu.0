Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC515DA97
	for <lists+kvmarm@lfdr.de>; Fri, 14 Feb 2020 16:21:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 23A654AEA5;
	Fri, 14 Feb 2020 10:21:15 -0500 (EST)
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
	with ESMTP id XxmivSbuU6ZJ; Fri, 14 Feb 2020 10:21:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13D8D4AEB2;
	Fri, 14 Feb 2020 10:21:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B98EC4A536
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:21:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pj6fRg5EQFdC for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 10:21:10 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CFF004AC6C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 10:21:10 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB4AC2467C;
 Fri, 14 Feb 2020 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581693670;
 bh=OU3i052ZF//Wu4rkWcKgh+KLFM8jnoqZQPBXrJ+hcAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FcIq9xxR596Ms+iMP+w7cYCAq+GGR/SV3k/b6TnemUnUtm/+crWs5BsINrqli26fB
 6A508Us+oDAOvvP/WNocCdoGlSNStsgK4bYcQ0flnrjiBkZYMxNqYz3THWcnuZ0Sza
 qEYHtLiRhRYknoW2EaQvIGNqAdoUwtlOe+C2u1Z4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j2cPq-0057sw-74; Fri, 14 Feb 2020 14:58:02 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/20] KVM: arm64: GICv4.1: Expose HW-based SGIs in debugfs
Date: Fri, 14 Feb 2020 14:57:36 +0000
Message-Id: <20200214145736.18550-21-maz@kernel.org>
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

The vgic-state debugfs file could do with showing the pending state
of the HW-backed SGIs. Plug it into the low-level code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-debug.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
index cc12fe9b2df3..b13a9e3f99dd 100644
--- a/virt/kvm/arm/vgic/vgic-debug.c
+++ b/virt/kvm/arm/vgic/vgic-debug.c
@@ -178,6 +178,8 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 			    struct kvm_vcpu *vcpu)
 {
 	char *type;
+	bool pending;
+
 	if (irq->intid < VGIC_NR_SGIS)
 		type = "SGI";
 	else if (irq->intid < VGIC_NR_PRIVATE_IRQS)
@@ -190,6 +192,16 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 	if (irq->intid ==0 || irq->intid == VGIC_NR_PRIVATE_IRQS)
 		print_header(s, irq, vcpu);
 
+	pending = irq->pending_latch;
+	if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
+		int err;
+
+		err = irq_get_irqchip_state(irq->host_irq,
+					    IRQCHIP_STATE_PENDING,
+					    &pending);
+		WARN_ON_ONCE(err);
+	}
+
 	seq_printf(s, "       %s %4d "
 		      "    %2d "
 		      "%d%d%d%d%d%d%d "
@@ -201,7 +213,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 		      "\n",
 			type, irq->intid,
 			(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
-			irq->pending_latch,
+			pending,
 			irq->line_level,
 			irq->active,
 			irq->enabled,
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
