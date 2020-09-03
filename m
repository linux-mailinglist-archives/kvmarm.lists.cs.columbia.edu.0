Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 215AC25C5DE
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 17:56:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB3024B2C6;
	Thu,  3 Sep 2020 11:56:12 -0400 (EDT)
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
	with ESMTP id UuzAD0zjBLoo; Thu,  3 Sep 2020 11:56:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 22ED84B2FA;
	Thu,  3 Sep 2020 11:56:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6718E4B2C7
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1NhKYFe-l+4 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 11:56:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 458844B2EA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 11:56:08 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 595F8206EB;
 Thu,  3 Sep 2020 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599148567;
 bh=aj+Fs9Q6pOgZaVj6SGqCD2Sw6aTbniJQUhxSCCJXvQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jCQWNSw0bGkHV2+MuDGlMsuuESUnitk2BSfQn+Sln8Qe1TMFsu57MYEj6S9I1Q/lc
 DxL5jb1p07isW/F9yZrs4DZGWpMRoiGtm/2o9jVKfQUWX4q3THYZcrIKYs9qqlKZ1P
 OI6JhupaRQC4vV1bxFZvZoRN7tuSj7YsSoAwcwN0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kDr87-008vT9-Jh; Thu, 03 Sep 2020 16:26:27 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/23] KVM: arm64: Move kvm_vgic_vcpu_load/put() to
 irqchip_flow
Date: Thu,  3 Sep 2020 16:25:58 +0100
Message-Id: <20200903152610.1078827-12-maz@kernel.org>
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

Abstract the calls to kvm_vgic_vcpu_load/put() via the irqchip_flow
structure.

No functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_irq.h | 8 ++++++++
 arch/arm64/kvm/arm.c             | 4 ++--
 arch/arm64/kvm/vgic/vgic-init.c  | 2 ++
 arch/arm64/kvm/vgic/vgic.h       | 3 +++
 include/kvm/arm_vgic.h           | 3 ---
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_irq.h b/arch/arm64/include/asm/kvm_irq.h
index 493b59dae256..50dfd641cd67 100644
--- a/arch/arm64/include/asm/kvm_irq.h
+++ b/arch/arm64/include/asm/kvm_irq.h
@@ -22,6 +22,8 @@ struct kvm_irqchip_flow {
 	int  (*irqchip_vcpu_init)(struct kvm_vcpu *);
 	void (*irqchip_vcpu_blocking)(struct kvm_vcpu *);
 	void (*irqchip_vcpu_unblocking)(struct kvm_vcpu *);
+	void (*irqchip_vcpu_load)(struct kvm_vcpu *);
+	void (*irqchip_vcpu_put)(struct kvm_vcpu *);
 };
 
 /*
@@ -62,4 +64,10 @@ struct kvm_irqchip_flow {
 #define kvm_irqchip_vcpu_unblocking(v)			\
 	__vcpu_irqchip_action((v), vcpu_unblocking, (v))
 
+#define kvm_irqchip_vcpu_load(v)			\
+	__vcpu_irqchip_action((v), vcpu_load, (v))
+
+#define kvm_irqchip_vcpu_put(v)				\
+	__vcpu_irqchip_action((v), vcpu_put, (v))
+
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b60265f575cd..84d48c312b84 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -322,7 +322,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	vcpu->cpu = cpu;
 
-	kvm_vgic_load(vcpu);
+	kvm_irqchip_vcpu_load(vcpu);
 	kvm_timer_vcpu_load(vcpu);
 	if (has_vhe())
 		kvm_vcpu_load_sysregs_vhe(vcpu);
@@ -346,7 +346,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	if (has_vhe())
 		kvm_vcpu_put_sysregs_vhe(vcpu);
 	kvm_timer_vcpu_put(vcpu);
-	kvm_vgic_put(vcpu);
+	kvm_irqchip_vcpu_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
 
 	vcpu->cpu = -1;
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index b519fb56a8cd..24b3ed9bae5d 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -20,6 +20,8 @@ static struct kvm_irqchip_flow vgic_irqchip_flow = {
 	.irqchip_vcpu_init		= kvm_vgic_vcpu_init,
 	.irqchip_vcpu_blocking		= kvm_vgic_vcpu_blocking,
 	.irqchip_vcpu_unblocking	= kvm_vgic_vcpu_unblocking,
+	.irqchip_vcpu_load		= kvm_vgic_load,
+	.irqchip_vcpu_put		= kvm_vgic_put,
 };
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index d8a0e3729de4..190737402365 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -321,4 +321,7 @@ int vgic_v4_init(struct kvm *kvm);
 void vgic_v4_teardown(struct kvm *kvm);
 void vgic_v4_configure_vsgis(struct kvm *kvm);
 
+void kvm_vgic_load(struct kvm_vcpu *vcpu);
+void kvm_vgic_put(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 2bffc2d513ef..a06d9483e3a6 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -349,9 +349,6 @@ bool kvm_vgic_map_is_active(struct kvm_vcpu *vcpu, unsigned int vintid);
 
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
 
-void kvm_vgic_load(struct kvm_vcpu *vcpu);
-void kvm_vgic_put(struct kvm_vcpu *vcpu);
-
 #define vgic_initialized(k)	((k)->arch.vgic.initialized)
 #define vgic_ready(k)		((k)->arch.vgic.ready)
 #define vgic_valid_spi(k, i)	(((i) >= VGIC_NR_PRIVATE_IRQS) && \
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
