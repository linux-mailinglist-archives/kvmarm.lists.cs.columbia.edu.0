Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3533DB48
	for <lists+kvmarm@lfdr.de>; Tue, 16 Mar 2021 18:46:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E87594B5F5;
	Tue, 16 Mar 2021 13:46:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8XT5R3143hT; Tue, 16 Mar 2021 13:46:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1114B4B5AB;
	Tue, 16 Mar 2021 13:46:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 42F054B4D6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 13:46:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zST28W-gRbUv for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Mar 2021 13:46:49 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AE7A04B430
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 13:46:45 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E620B6512E;
 Tue, 16 Mar 2021 17:46:44 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lMDmF-0021ao-8D; Tue, 16 Mar 2021 17:46:43 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH 08/11] KVM: arm64: timer: Add support for SW-based deactivation
Date: Tue, 16 Mar 2021 17:46:13 +0000
Message-Id: <20210316174617.173033-9-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316174617.173033-1-maz@kernel.org>
References: <20210316174617.173033-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, eric.auger@redhat.com, marcan@marcan.st,
 mark.rutland@arm.com, kernel-team@android.com
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

In order to deal with the lack of active state, we need to use
the mask/unmask primitives (after all, the active state is just an
additional mask on top of the normal one).

To avoid adding a bunch of ugly conditionals in the timer and vgic
code, let's use a timer-specific irqdomain to deal with the state
conversion. Yes, this is an unexpected use of irqdomains, but
there is no reason not to be just as creative as the designers
of the HW...

This involves overloading the vcpu_affinity, set_irqchip_state
and eoi callbacks so that the rest of the KVM code can continue
ignoring the oddities of the underlying platform.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arch_timer.c | 92 +++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 7fa4f446456a..ba3a87880e0e 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -9,6 +9,7 @@
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/uaccess.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -973,6 +974,69 @@ static int kvm_timer_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int timer_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
+{
+	if (vcpu)
+		irqd_set_forwarded_to_vcpu(d);
+	else
+		irqd_clr_forwarded_to_vcpu(d);
+
+	return 0;
+}
+
+static int timer_irq_set_irqchip_state(struct irq_data *d,
+				       enum irqchip_irq_state which, bool val)
+{
+	if (which != IRQCHIP_STATE_ACTIVE || !irqd_is_forwarded_to_vcpu(d))
+		return irq_chip_set_parent_state(d, which, val);
+
+	if (val)
+		irq_chip_mask_parent(d);
+	else
+		irq_chip_unmask_parent(d);
+
+	return 0;
+}
+
+static void timer_irq_eoi(struct irq_data *d)
+{
+	if (!irqd_is_forwarded_to_vcpu(d))
+		irq_chip_eoi_parent(d);
+}
+
+static struct irq_chip timer_chip = {
+	.name			= "KVM",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= timer_irq_eoi,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_vcpu_affinity	= timer_irq_set_vcpu_affinity,
+	.irq_set_irqchip_state	= timer_irq_set_irqchip_state,
+};
+
+static int timer_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *arg)
+{
+	irq_hw_number_t hwirq = (uintptr_t)arg;
+
+	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					     &timer_chip, NULL);
+}
+
+static void timer_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+}
+
+static const struct irq_domain_ops timer_domain_ops = {
+	.alloc	= timer_irq_domain_alloc,
+	.free	= timer_irq_domain_free,
+};
+
+static struct irq_ops arch_timer_irq_ops = {
+	.get_input_level = kvm_arch_timer_get_input_level,
+};
+
 static void kvm_irq_fixup_flags(unsigned int virq, u32 *flags)
 {
 	*flags = irq_get_trigger_type(virq);
@@ -998,9 +1062,33 @@ static int kvm_irq_init(struct arch_timer_kvm_info *info)
 	host_vtimer_irq = info->virtual_irq;
 	kvm_irq_fixup_flags(host_vtimer_irq, &host_vtimer_irq_flags);
 
+	if (kvm_vgic_global_state.no_hw_deactivation) {
+		fwnode = irq_domain_alloc_named_fwnode("kvm-timer");
+		if (!fwnode)
+			return -ENOMEM;
+
+		/* Assume both vtimer and ptimer in the same parent */
+		data = irq_get_irq_data(host_vtimer_irq);
+		domain = irq_domain_create_hierarchy(data->domain, 0,
+						     NR_KVM_TIMERS, fwnode,
+						     &timer_domain_ops, NULL);
+		if (!domain) {
+			irq_domain_free_fwnode(fwnode);
+			return -ENOMEM;
+		}
+
+		arch_timer_irq_ops.flags |= VGIC_IRQ_SW_RESAMPLE;
+		WARN_ON(irq_domain_push_irq(domain, host_vtimer_irq,
+					    (void *)TIMER_VTIMER));
+	}
+
 	if (info->physical_irq > 0) {
 		host_ptimer_irq = info->physical_irq;
 		kvm_irq_fixup_flags(host_ptimer_irq, &host_ptimer_irq_flags);
+
+		if (domain)
+			WARN_ON(irq_domain_push_irq(domain, host_ptimer_irq,
+						    (void *)TIMER_PTIMER));
 	}
 
 	return 0;
@@ -1129,10 +1217,6 @@ bool kvm_arch_timer_get_input_level(int vintid)
 	return kvm_timer_should_fire(timer);
 }
 
-static struct irq_ops arch_timer_irq_ops = {
-	.get_input_level = kvm_arch_timer_get_input_level,
-};
-
 int kvm_timer_enable(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
