Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9625C54C
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 17:26:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E13F94B33C;
	Thu,  3 Sep 2020 11:26:41 -0400 (EDT)
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
	with ESMTP id GEjM+BY9Pwl4; Thu,  3 Sep 2020 11:26:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A4AF14B2F1;
	Thu,  3 Sep 2020 11:26:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 159E34B345
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:26:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a4mFOZH0KP1a for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 11:26:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47CE64B275
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:26:28 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 70AD420BED;
 Thu,  3 Sep 2020 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599146787;
 bh=lgvTIsBwIP9Y/PcN/yqslqFkcX9YiCZ8blsuaMOPDkc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i8RlzDHlKY+D5mo66/XjpZhjegAirCBEbltXSFY7q09KIP73f/eVVTF/+d6GXF7k5
 eDwoBUVS13yui6Ckq1GknNgOl1viwaPwbHiAV4XAwItt/Q+CPhTpjUAbVXZVql9cUB
 IU8J9yvDyDsLNeouqZlgn0M3anr9xt17Hp/phbuA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kDr85-008vT9-RB; Thu, 03 Sep 2020 16:26:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/23] KVM: arm64: Move kvm_vgic_destroy to kvm_irqchip_flow
Date: Thu,  3 Sep 2020 16:25:55 +0100
Message-Id: <20200903152610.1078827-9-maz@kernel.org>
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

Let's start the VGIC split by moving the act of destroying it,
as it is simple and doesn't require much effort.

Whilst we're at it, make kvm_vgic_vcpu_destroy() static,
as it isn't called from anywhere else.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_irq.h | 4 ++++
 arch/arm64/kvm/arm.c             | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c  | 7 +++++--
 include/kvm/arm_vgic.h           | 2 --
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_irq.h b/arch/arm64/include/asm/kvm_irq.h
index 7a70bb803560..f83594257bc4 100644
--- a/arch/arm64/include/asm/kvm_irq.h
+++ b/arch/arm64/include/asm/kvm_irq.h
@@ -18,6 +18,7 @@ enum kvm_irqchip_type {
 #define irqchip_is_gic_v3(k)	((k)->arch.irqchip_type == IRQCHIP_GICv3)
 
 struct kvm_irqchip_flow {
+	void (*irqchip_destroy)(struct kvm *);
 };
 
 /*
@@ -46,4 +47,7 @@ struct kvm_irqchip_flow {
 #define __vcpu_irqchip_action_ret(v, ...)		\
 	__kvm_irqchip_action_ret((v)->kvm, __VA_ARGS__)
 
+#define kvm_irqchip_destroy(k)				\
+	__kvm_irqchip_action((k), destroy, (k))
+
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 41f98564f507..09b4bcb2c805 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -143,7 +143,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	int i;
 
-	kvm_vgic_destroy(kvm);
+	kvm_irqchip_destroy(kvm);
 
 	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 		if (kvm->vcpus[i]) {
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 6b8f0518c074..4e2c23a7dab1 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -12,7 +12,10 @@
 #include <asm/kvm_mmu.h>
 #include "vgic.h"
 
+static void kvm_vgic_destroy(struct kvm *kvm);
+
 static struct kvm_irqchip_flow vgic_irqchip_flow = {
+	.irqchip_destroy		= kvm_vgic_destroy,
 };
 
 /*
@@ -341,7 +344,7 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 		vgic_v4_teardown(kvm);
 }
 
-void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
+static void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
@@ -368,7 +371,7 @@ static void __kvm_vgic_destroy(struct kvm *kvm)
 	kvm_vgic_dist_destroy(kvm);
 }
 
-void kvm_vgic_destroy(struct kvm *kvm)
+static void kvm_vgic_destroy(struct kvm *kvm)
 {
 	mutex_lock(&kvm->lock);
 	__kvm_vgic_destroy(kvm);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 8d30fc645148..e8bdc304ec9b 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -337,8 +337,6 @@ extern struct static_key_false vgic_v3_cpuif_trap;
 int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write);
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
 int kvm_vgic_create(struct kvm *kvm, u32 type);
-void kvm_vgic_destroy(struct kvm *kvm);
-void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vgic_map_resources(struct kvm *kvm);
 int kvm_vgic_hyp_init(void);
 void kvm_vgic_init_cpu_hardware(void);
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
