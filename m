Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0671FA1C5
	for <lists+kvmarm@lfdr.de>; Mon, 15 Jun 2020 22:39:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B5124B0CE;
	Mon, 15 Jun 2020 16:39:09 -0400 (EDT)
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
	with ESMTP id wSF4KGMj1jHS; Mon, 15 Jun 2020 16:39:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 891814B0A3;
	Mon, 15 Jun 2020 16:39:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D39E24B09B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 16:39:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J9PQtHJ-dCn5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Jun 2020 16:39:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BC9404ACC9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Jun 2020 16:39:05 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D9142078E;
 Mon, 15 Jun 2020 20:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592253544;
 bh=G3kx7gmxUbYjMZujOdTgVsLt+bvnDQ4dZNfve9RFnlk=;
 h=From:To:Cc:Subject:Date:From;
 b=hbeSjzVU1xGOS4JUuRdRRivUGCZtnAK3/1Mi7AdM0dFxbIlDquwWgRGgJk9elc6RK
 ZAvejcacP6lB+rH/i8FHrct33CahwXAecKzBCB4b7SMS1FBFMmN+vfuOpJK5Dyp8qE
 2SGqkn4qmSXBvT1oNMcHN2XapvUrv3nj+nEk6TD4=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jkvsl-003EcH-0j; Mon, 15 Jun 2020 21:39:03 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2] KVM: arm64: Allow in-atomic injection of SPIs
Date: Mon, 15 Jun 2020 21:38:44 +0100
Message-Id: <20200615203844.14793-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, yuzenghui@huawei.com, eric.auger@redhat.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

On a system that uses SPIs to implement MSIs (as it would be
the case on a GICv2 system exposing a GICv2m to its guests),
we deny the possibility of injecting SPIs on the in-atomic
fast-path.

This results in a very large amount of context-switches
(roughly equivalent to twice the interrupt rate) on the host,
and suboptimal performance for the guest (as measured with
a test workload involving a virtio interface backed by vhost-net).
Given that GICv2 systems are usually on the low-end of the spectrum
performance wise, they could do without the aggravation.

We solved this for GICv3+ITS by having a translation cache. But
SPIs do not need any extra infrastructure, and can be immediately
injected in the virtual distributor as the locking is already
heavy enough that we don't need to worry about anything.

This halves the number of context switches for the same workload.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
* From v1:
  - Drop confusing comment (Zenghui, Eric)
  - Now consistently return -EWOULDBLOCK when unable to inject (Eric)
  - Don't inject if the vgic isn't initialized yet (Eric)

 arch/arm64/kvm/vgic/vgic-irqfd.c | 24 +++++++++++++++++++-----
 arch/arm64/kvm/vgic/vgic-its.c   |  3 +--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index d8cdfea5cc96..79f8899b234c 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -100,19 +100,33 @@ int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 
 /**
  * kvm_arch_set_irq_inatomic: fast-path for irqfd injection
- *
- * Currently only direct MSI injection is supported.
  */
 int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 			      struct kvm *kvm, int irq_source_id, int level,
 			      bool line_status)
 {
-	if (e->type == KVM_IRQ_ROUTING_MSI && vgic_has_its(kvm) && level) {
+	if (!level)
+		return -EWOULDBLOCK;
+
+	switch (e->type) {
+	case KVM_IRQ_ROUTING_MSI: {
 		struct kvm_msi msi;
 
+		if (!vgic_has_its(kvm))
+			break;
+
 		kvm_populate_msi(e, &msi);
-		if (!vgic_its_inject_cached_translation(kvm, &msi))
-			return 0;
+		return vgic_its_inject_cached_translation(kvm, &msi);
+	}
+
+	case KVM_IRQ_ROUTING_IRQCHIP:
+		/*
+		 * Injecting SPIs is always possible in atomic context
+		 * as long as the damn vgic is initialized.
+		 */
+		if (unlikely(!vgic_initialized(kvm)))
+			break;
+		return vgic_irqfd_set_irq(e, kvm, irq_source_id, 1, line_status);
 	}
 
 	return -EWOULDBLOCK;
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index c012a52b19f5..40cbaca81333 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -757,9 +757,8 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
 
 	db = (u64)msi->address_hi << 32 | msi->address_lo;
 	irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
-
 	if (!irq)
-		return -1;
+		return -EWOULDBLOCK;
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
