Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9825C5D0
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 17:55:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E4234B2C2;
	Thu,  3 Sep 2020 11:55:56 -0400 (EDT)
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
	with ESMTP id 2ZTVQYTDy2V5; Thu,  3 Sep 2020 11:55:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E706D4B298;
	Thu,  3 Sep 2020 11:55:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5653A4B26B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:55:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3M6bAphTgc3 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 11:55:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 16BE24B249
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:55:51 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E0E3320639;
 Thu,  3 Sep 2020 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599148551;
 bh=YzRkIx+dZ17MEeaeOr7j+6LyvyofGqD9uMAxfbSGWQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ct6hyqPkh0Ha2pp2k/BgpHhTnCeivhZkzVrbFHphW74G+vrKKzueWdZH4VHBFgch7
 nGmY85bU2dns9zUQNyIp35wWk6OEylG09zmHdj0bUR6ps8FxHg0GfF6j9qzf1ftbja
 AM1HaFi3w8T2hIYD9cSEZaen3SSNOO6UGsAt9Yq0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kDr87-008vT9-06; Thu, 03 Sep 2020 16:26:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/23] KVM: arm64: Move kvm_vgic_vcpu_[un]blocking() to
 irqchip_flow
Date: Thu,  3 Sep 2020 16:25:57 +0100
Message-Id: <20200903152610.1078827-11-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200903152610.1078827-1-maz@kernel.org>
References: <20200903152610.1078827-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 Christoffer.Dall@arm.com, lorenzo.pieralisi@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com
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

Move the code dedicated to blocking/unblocking on WFI to
the vgic code itself, and abstract it via the irqchip_flow
structure.

No functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_irq.h |  8 ++++++++
 arch/arm64/kvm/arm.c             | 19 ++-----------------
 arch/arm64/kvm/vgic/vgic-init.c  |  2 ++
 arch/arm64/kvm/vgic/vgic.c       | 25 ++++++++++++++++++++++---
 arch/arm64/kvm/vgic/vgic.h       |  3 +++
 include/kvm/arm_vgic.h           |  1 -
 6 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_irq.h b/arch/arm64/include/asm/kvm_irq.h
index 09df1f46d4de..493b59dae256 100644
--- a/arch/arm64/include/asm/kvm_irq.h
+++ b/arch/arm64/include/asm/kvm_irq.h
@@ -20,6 +20,8 @@ enum kvm_irqchip_type {
 struct kvm_irqchip_flow {
 	void (*irqchip_destroy)(struct kvm *);
 	int  (*irqchip_vcpu_init)(struct kvm_vcpu *);
+	void (*irqchip_vcpu_blocking)(struct kvm_vcpu *);
+	void (*irqchip_vcpu_unblocking)(struct kvm_vcpu *);
 };
 
 /*
@@ -54,4 +56,10 @@ struct kvm_irqchip_flow {
 #define kvm_irqchip_vcpu_init(v)			\
 	__vcpu_irqchip_action_ret((v), vcpu_init, (v))
 
+#define kvm_irqchip_vcpu_blocking(v)			\
+	__vcpu_irqchip_action((v), vcpu_blocking, (v))
+
+#define kvm_irqchip_vcpu_unblocking(v)			\
+	__vcpu_irqchip_action((v), vcpu_unblocking, (v))
+
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d82d348a36c3..b60265f575cd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -295,27 +295,12 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	/*
-	 * If we're about to block (most likely because we've just hit a
-	 * WFI), we need to sync back the state of the GIC CPU interface
-	 * so that we have the latest PMR and group enables. This ensures
-	 * that kvm_arch_vcpu_runnable has up-to-date data to decide
-	 * whether we have pending interrupts.
-	 *
-	 * For the same reason, we want to tell GICv4 that we need
-	 * doorbells to be signalled, should an interrupt become pending.
-	 */
-	preempt_disable();
-	kvm_vgic_vmcr_sync(vcpu);
-	vgic_v4_put(vcpu, true);
-	preempt_enable();
+	kvm_irqchip_vcpu_blocking(vcpu);
 }
 
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
-	vgic_v4_load(vcpu);
-	preempt_enable();
+	kvm_irqchip_vcpu_unblocking(vcpu);
 }
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index d845699c6966..b519fb56a8cd 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -18,6 +18,8 @@ static void kvm_vgic_destroy(struct kvm *kvm);
 static struct kvm_irqchip_flow vgic_irqchip_flow = {
 	.irqchip_destroy		= kvm_vgic_destroy,
 	.irqchip_vcpu_init		= kvm_vgic_vcpu_init,
+	.irqchip_vcpu_blocking		= kvm_vgic_vcpu_blocking,
+	.irqchip_vcpu_unblocking	= kvm_vgic_vcpu_unblocking,
 };
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index c3643b7f101b..f576273c5608 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -939,15 +939,34 @@ void kvm_vgic_put(struct kvm_vcpu *vcpu)
 		vgic_v3_put(vcpu);
 }
 
-void kvm_vgic_vmcr_sync(struct kvm_vcpu *vcpu)
+void kvm_vgic_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(!irqchip_in_kernel(vcpu->kvm)))
-		return;
+	/*
+	 * If we're about to block (most likely because we've just hit a
+	 * WFI), we need to sync back the state of the GIC CPU interface
+	 * so that we have the latest PMR and group enables. This ensures
+	 * that kvm_arch_vcpu_runnable has up-to-date data to decide
+	 * whether we have pending interrupts.
+	 *
+	 * For the same reason, we want to tell GICv4 that we need
+	 * doorbells to be signalled, should an interrupt become pending.
+	 */
+	preempt_disable();
 
 	if (kvm_vgic_global_state.type == VGIC_V2)
 		vgic_v2_vmcr_sync(vcpu);
 	else
 		vgic_v3_vmcr_sync(vcpu);
+
+	vgic_v4_put(vcpu, true);
+	preempt_enable();
+}
+
+void kvm_vgic_vcpu_unblocking(struct kvm_vcpu *vcpu)
+{
+	preempt_disable();
+	vgic_v4_load(vcpu);
+	preempt_enable();
 }
 
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 64fcd7511110..d8a0e3729de4 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -227,6 +227,9 @@ void vgic_v3_load(struct kvm_vcpu *vcpu);
 void vgic_v3_put(struct kvm_vcpu *vcpu);
 void vgic_v3_vmcr_sync(struct kvm_vcpu *vcpu);
 
+void kvm_vgic_vcpu_blocking(struct kvm_vcpu *vcpu);
+void kvm_vgic_vcpu_unblocking(struct kvm_vcpu *vcpu);
+
 bool vgic_has_its(struct kvm *kvm);
 int kvm_vgic_register_its_device(void);
 void vgic_enable_lpis(struct kvm_vcpu *vcpu);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index b2fd0e39af11..2bffc2d513ef 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -351,7 +351,6 @@ int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 
 void kvm_vgic_load(struct kvm_vcpu *vcpu);
 void kvm_vgic_put(struct kvm_vcpu *vcpu);
-void kvm_vgic_vmcr_sync(struct kvm_vcpu *vcpu);
 
 #define vgic_initialized(k)	((k)->arch.vgic.initialized)
 #define vgic_ready(k)		((k)->arch.vgic.ready)
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
