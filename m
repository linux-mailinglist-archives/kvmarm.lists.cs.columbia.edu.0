Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0137025C5E2
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 17:56:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A884E4B30A;
	Thu,  3 Sep 2020 11:56:18 -0400 (EDT)
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
	with ESMTP id 4uop3iIPovYL; Thu,  3 Sep 2020 11:56:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8294C4B33E;
	Thu,  3 Sep 2020 11:56:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B7954B227
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RD6bNjmiFy6c for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 11:56:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 51B784B2C5
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:14 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5DFE3208C7;
 Thu,  3 Sep 2020 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599148573;
 bh=ixc6smJXqyfDNyAO1JLLkDueX6FgJ+DaRlFRfhqH6bI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o0fS08VmaCSc3sU0V226iALI31gEEJGuXoqjjAKIXVvcrH8vdNC4e77mAh8ejY11B
 dnc8Li1k8JlAhBELkVoyJ5Nnf+74Li7dsfrUMouoXvQqw6OpF28chxiub9PYHNb+8S
 QRkOJIst0b2txuTpdK4U3sZPqOLrnCuQPaJqNAWk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kDr8B-008vT9-9b; Thu, 03 Sep 2020 16:26:31 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 17/23] KVM: arm64: Move mapping of HW interrupts into
 irqchip_flow
Date: Thu,  3 Sep 2020 16:26:04 +0100
Message-Id: <20200903152610.1078827-18-maz@kernel.org>
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

As we continue cutting a VGIC-shaped hole in KVM, let's indirect
all of the handling of mapped interrupts into the bit irqchip_flow
bucket.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_irq.h | 17 +++++++++++++++++
 arch/arm64/kvm/arch_timer.c      | 22 +++++++++++-----------
 arch/arm64/kvm/vgic/vgic-init.c  |  4 ++++
 arch/arm64/kvm/vgic/vgic.h       |  6 ++++++
 include/kvm/arm_vgic.h           |  7 -------
 5 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_irq.h b/arch/arm64/include/asm/kvm_irq.h
index f816d4814fcf..16556417bd4a 100644
--- a/arch/arm64/include/asm/kvm_irq.h
+++ b/arch/arm64/include/asm/kvm_irq.h
@@ -33,6 +33,11 @@ struct kvm_irqchip_flow {
 	int  (*irqchip_inject_userspace_irq)(struct kvm *, unsigned int type,
 					     unsigned int cpu,
 					     unsigned int intid, bool);
+	bool (*irqchip_map_is_active)(struct kvm_vcpu *, unsigned in);
+	void (*irqchip_reset_mapped_irq)(struct kvm_vcpu *, u32);
+	int  (*irqchip_map_phys_irq)(struct kvm_vcpu *, unsigned int,
+				     u32, bool (*)(int));
+	int  (*irqchip_unmap_phys_irq)(struct kvm_vcpu *, unsigned int);
 };
 
 /*
@@ -97,4 +102,16 @@ struct kvm_irqchip_flow {
 #define kvm_irqchip_inject_userspace_irq(k, ...)	\
 	__kvm_irqchip_action_ret((k), inject_userspace_irq, (k), __VA_ARGS__)
 
+#define kvm_irqchip_map_is_active(v, ...)		\
+	__vcpu_irqchip_action_ret((v), map_is_active, (v), __VA_ARGS__)
+
+#define kvm_irqchip_reset_mapped_irq(v, ...)		\
+	__vcpu_irqchip_action((v), reset_mapped_irq, (v), __VA_ARGS__)
+
+#define kvm_irqchip_map_phys_irq(v, ...)		\
+	__vcpu_irqchip_action_ret((v), map_phys_irq, (v), __VA_ARGS__)
+
+#define kvm_irqchip_unmap_phys_irq(v, ...)		\
+	__vcpu_irqchip_action_ret((v), unmap_phys_irq, (v), __VA_ARGS__)
+
 #endif
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 397bd7aea1f5..16999de299a7 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -562,7 +562,7 @@ static void kvm_timer_vcpu_load_gic(struct arch_timer_context *ctx)
 	kvm_timer_update_irq(ctx->vcpu, kvm_timer_should_fire(ctx), ctx);
 
 	if (irqchip_in_kernel(vcpu->kvm))
-		phys_active = kvm_vgic_map_is_active(vcpu, ctx->irq.irq);
+		phys_active = kvm_irqchip_map_is_active(vcpu, ctx->irq.irq);
 
 	phys_active |= ctx->irq.level;
 
@@ -734,9 +734,9 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
 		kvm_timer_update_irq(vcpu, false, vcpu_ptimer(vcpu));
 
 		if (irqchip_in_kernel(vcpu->kvm)) {
-			kvm_vgic_reset_mapped_irq(vcpu, map.direct_vtimer->irq.irq);
+			kvm_irqchip_reset_mapped_irq(vcpu, map.direct_vtimer->irq.irq);
 			if (map.direct_ptimer)
-				kvm_vgic_reset_mapped_irq(vcpu, map.direct_ptimer->irq.irq);
+				kvm_irqchip_reset_mapped_irq(vcpu, map.direct_ptimer->irq.irq);
 		}
 	}
 
@@ -1139,18 +1139,18 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 
 	get_timer_map(vcpu, &map);
 
-	ret = kvm_vgic_map_phys_irq(vcpu,
-				    map.direct_vtimer->host_timer_irq,
-				    map.direct_vtimer->irq.irq,
-				    kvm_arch_timer_get_input_level);
+	ret = kvm_irqchip_map_phys_irq(vcpu,
+				       map.direct_vtimer->host_timer_irq,
+				       map.direct_vtimer->irq.irq,
+				       kvm_arch_timer_get_input_level);
 	if (ret)
 		return ret;
 
 	if (map.direct_ptimer) {
-		ret = kvm_vgic_map_phys_irq(vcpu,
-					    map.direct_ptimer->host_timer_irq,
-					    map.direct_ptimer->irq.irq,
-					    kvm_arch_timer_get_input_level);
+		ret = kvm_irqchip_map_phys_irq(vcpu,
+					       map.direct_ptimer->host_timer_irq,
+					       map.direct_ptimer->irq.irq,
+					       kvm_arch_timer_get_input_level);
 	}
 
 	if (ret)
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 7a8504a5b634..ed62c0a27b53 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -29,6 +29,10 @@ static struct kvm_irqchip_flow vgic_irqchip_flow = {
 	.irqchip_vcpu_sync_hwstate	= kvm_vgic_sync_hwstate,
 	.irqchip_inject_irq		= kvm_vgic_inject_irq,
 	.irqchip_inject_userspace_irq	= kvm_vgic_inject_userspace_irq,
+	.irqchip_map_is_active		= kvm_vgic_map_is_active,
+	.irqchip_reset_mapped_irq	= kvm_vgic_reset_mapped_irq,
+	.irqchip_map_phys_irq		= kvm_vgic_map_phys_irq,
+	.irqchip_unmap_phys_irq		= kvm_vgic_unmap_phys_irq,
 };
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index cddbd9b951e4..af4a0e5f31c1 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -329,6 +329,12 @@ int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
 void vgic_v4_configure_vsgis(struct kvm *kvm);
 
+bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
+void kvm_vgic_reset_mapped_irq(struct kvm_vcpu *vcpu, u32 vintid);
+int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
+			  u32 vintid, bool (*get_input_level)(int));
+int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid);
+
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 
 void kvm_vgic_load(struct kvm_vcpu *vcpu);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index fba68129337d..ff8c49c0ebbd 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -339,17 +339,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type);
 int kvm_vgic_hyp_init(void);
 void kvm_vgic_init_cpu_hardware(void);
 
-int kvm_vgic_map_phys_irq(struct kvm_vcpu *vcpu, unsigned int host_irq,
-			  u32 vintid, bool (*get_input_level)(int vindid));
-int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid);
-bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
-
 #define vgic_initialized(k)	((k)->arch.vgic.initialized)
 #define vgic_valid_spi(k, i)	(((i) >= VGIC_NR_PRIVATE_IRQS) && \
 			((i) < (k)->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS))
 
-void kvm_vgic_reset_mapped_irq(struct kvm_vcpu *vcpu, u32 vintid);
-
 void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg, bool allow_group1);
 
 /**
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
