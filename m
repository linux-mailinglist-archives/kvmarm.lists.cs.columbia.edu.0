Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E603C25C5DF
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 17:56:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B2554B326;
	Thu,  3 Sep 2020 11:56:15 -0400 (EDT)
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
	with ESMTP id 1jrtcO2CHxtd; Thu,  3 Sep 2020 11:56:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 486454B22C;
	Thu,  3 Sep 2020 11:56:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DD804B28C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4n8sSRLLJzo for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 11:56:11 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 015864B320
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20BF720786;
 Thu,  3 Sep 2020 15:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599148569;
 bh=YZ/pztr3vl93u3bbVzuK03akBTWI2lok4N89WyFl2kU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QRFsVSlgo3f+7pdacR80/iD5214GeqozUyq6/fKeg+SzdG5ZjHCdLtEREg8VEnsWY
 NWXpyP647aGtTCw54PnwdqRZZ4CQbbCpoINVYTEspG0McR0B1awk/6rTe8VqNYNYOM
 Nja/++jfZn92NDy34FIilbHKf4PI7Ps3QpdZw4IY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kDr88-008vT9-7d; Thu, 03 Sep 2020 16:26:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/23] KVM: arm64: Move kvm_vgic_vcpu_pending_irq() to
 irqchip_flow
Date: Thu,  3 Sep 2020 16:25:59 +0100
Message-Id: <20200903152610.1078827-13-maz@kernel.org>
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

Abstract the calls to kvm_vgic_vcpu_pending_irq() via the irqchip_flow
structure.

No functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_irq.h | 4 ++++
 arch/arm64/kvm/arm.c             | 4 ++--
 arch/arm64/kvm/vgic/vgic-init.c  | 1 +
 arch/arm64/kvm/vgic/vgic.h       | 6 ++++++
 include/kvm/arm_vgic.h           | 3 ---
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_irq.h b/arch/arm64/include/asm/kvm_irq.h
index 50dfd641cd67..e7a244176ade 100644
--- a/arch/arm64/include/asm/kvm_irq.h
+++ b/arch/arm64/include/asm/kvm_irq.h
@@ -24,6 +24,7 @@ struct kvm_irqchip_flow {
 	void (*irqchip_vcpu_unblocking)(struct kvm_vcpu *);
 	void (*irqchip_vcpu_load)(struct kvm_vcpu *);
 	void (*irqchip_vcpu_put)(struct kvm_vcpu *);
+	int  (*irqchip_vcpu_pending_irq)(struct kvm_vcpu *);
 };
 
 /*
@@ -70,4 +71,7 @@ struct kvm_irqchip_flow {
 #define kvm_irqchip_vcpu_put(v)				\
 	__vcpu_irqchip_action((v), vcpu_put, (v))
 
+#define kvm_irqchip_vcpu_pending_irq(v)			\
+	__vcpu_irqchip_action_ret((v), vcpu_pending_irq, (v))
+
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 84d48c312b84..3496d200e488 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -399,8 +399,8 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
-	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
-		&& !v->arch.power_off && !v->arch.pause);
+	return ((irq_lines || kvm_irqchip_vcpu_pending_irq(v)) &&
+		!v->arch.power_off && !v->arch.pause);
 }
 
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 24b3ed9bae5d..8bb847045ef9 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -22,6 +22,7 @@ static struct kvm_irqchip_flow vgic_irqchip_flow = {
 	.irqchip_vcpu_unblocking	= kvm_vgic_vcpu_unblocking,
 	.irqchip_vcpu_load		= kvm_vgic_load,
 	.irqchip_vcpu_put		= kvm_vgic_put,
+	.irqchip_vcpu_pending_irq	= kvm_vgic_vcpu_pending_irq,
 };
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 190737402365..c5511823eec5 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -321,7 +321,13 @@ int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
 void vgic_v4_configure_vsgis(struct kvm *kvm);
 
+int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
+
 void kvm_vgic_load(struct kvm_vcpu *vcpu);
 void kvm_vgic_put(struct kvm_vcpu *vcpu);
 
+void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
+void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
+
+
 #endif
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index a06d9483e3a6..b2adf9cca334 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -347,14 +347,11 @@ int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
 int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid);
 bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
 
-int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
-
 #define vgic_initialized(k)	((k)->arch.vgic.initialized)
 #define vgic_ready(k)		((k)->arch.vgic.ready)
 #define vgic_valid_spi(k, i)	(((i) >= VGIC_NR_PRIVATE_IRQS) && \
 			((i) < (k)->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS))
 
-bool kvm_vcpu_has_pending_irqs(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_reset_mapped_irq(struct kvm_vcpu *vcpu, u32 vintid);
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
