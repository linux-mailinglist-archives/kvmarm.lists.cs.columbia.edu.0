Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B71799E2
	for <lists+kvmarm@lfdr.de>; Wed,  4 Mar 2020 21:34:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5341B4AFAE;
	Wed,  4 Mar 2020 15:34:52 -0500 (EST)
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
	with ESMTP id HkXgVJ8R4Q64; Wed,  4 Mar 2020 15:34:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B11844AFD4;
	Wed,  4 Mar 2020 15:34:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49AE34AFC0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Mar 2020 15:34:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id srHWCdpzB1Xp for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Mar 2020 15:34:44 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EBD274AFA7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Mar 2020 15:34:43 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 204DB2465D;
 Wed,  4 Mar 2020 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583354083;
 bh=PUH4gvjgA21o9fb5+3YPbx9Fg5qB5gde4nKP+zU3Z/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dL32XTKw9LNevAq5UBY1jmzQ+sCyO5FkFTx1Jp++JJTTIK3sGRGlOwutkPFO6WUvQ
 OfCvAvlQ4u/p5WycO7BCIxGvCCDoVXtP9D1wM1xrSnA3T5s2vI+PyuAkIUxmoE8Jbz
 oWrsh0h7KlsDoUrIBkyvAkz4oK0mtnY4E+7CCZkM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j9aj3-00A59R-DV; Wed, 04 Mar 2020 20:34:41 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/23] irqchip/gic-v4.1: Ensure mutual exclusion betwen
 invalidations on the same RD
Date: Wed,  4 Mar 2020 20:33:12 +0000
Message-Id: <20200304203330.4967-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304203330.4967-1-maz@kernel.org>
References: <20200304203330.4967-1-maz@kernel.org>
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

The GICv4.1 spec says that it is CONTRAINED UNPREDICTABLE to write to
any of the GICR_INV{LPI,ALL}R registers if GICR_SYNCR.Busy == 1.

To deal with it, we must ensure that only a single invalidation can
happen at a time for a given redistributor. Add a per-RD lock to that
effect and take it around the invalidation/syncr-read to deal with this.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 6 ++++++
 drivers/irqchip/irq-gic-v3.c       | 1 +
 include/linux/irqchip/arm-gic-v3.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c84370245bea..fc5788584df7 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1373,10 +1373,12 @@ static void direct_lpi_inv(struct irq_data *d)
 
 	/* Target the redistributor this LPI is currently routed to */
 	cpu = irq_to_cpuid_lock(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
 	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
 	irq_to_cpuid_unlock(d, flags);
 }
 
@@ -3662,9 +3664,11 @@ static void its_vpe_send_inv(struct irq_data *d)
 		void __iomem *rdbase;
 
 		/* Target the redistributor this VPE is currently known on */
+		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
 		wait_for_syncr(rdbase);
+		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
@@ -3825,10 +3829,12 @@ static void its_vpe_4_1_invall(struct its_vpe *vpe)
 	val |= FIELD_PREP(GICR_INVALLR_VPEID, vpe->vpe_id);
 
 	/* Target the redistributor this vPE is currently known on */
+	raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
 	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVALLR);
 
 	wait_for_syncr(rdbase);
+	raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
 }
 
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 73e87e176d76..ba405becab53 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -835,6 +835,7 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	typer = gic_read_typer(ptr + GICR_TYPER);
 	if ((typer >> 32) == aff) {
 		u64 offset = ptr - region->redist_base;
+		raw_spin_lock_init(&gic_data_rdist()->rd_lock);
 		gic_data_rdist_rd_base() = ptr;
 		gic_data_rdist()->phys_base = region->phys_base + offset;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c29a02678a6f..b28acfa71f82 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -652,6 +652,7 @@
 
 struct rdists {
 	struct {
+		raw_spinlock_t	rd_lock;
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
