Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 955A3E6370
	for <lists+kvmarm@lfdr.de>; Sun, 27 Oct 2019 15:46:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4255E4ACB0;
	Sun, 27 Oct 2019 10:46:35 -0400 (EDT)
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
	with ESMTP id JlZVeGSKTS8U; Sun, 27 Oct 2019 10:46:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F7604ACAF;
	Sun, 27 Oct 2019 10:46:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 90C1B4A5A8
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:46:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-2VQpa6O6-4 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 27 Oct 2019 10:46:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A287E4AC6A
 for <kvmarm@lists.cs.columbia.edu>; Sun, 27 Oct 2019 10:46:31 -0400 (EDT)
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6818221850;
 Sun, 27 Oct 2019 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572187590;
 bh=FYlDbIFh5b/0C2W3OiBNU9F9i6Y1G6GI0tp0Fll66W0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vpp9sIeDQe2ZKZmhpPEfjNqRemOSxtVWMCjxYNCIpMJcxPCLQJ6Zd+wrz+89kHcBQ
 fFWXnikTkKAr7/TQ+B5r3DPUIfLDs6u6vnE/wc68VPpG/R8VMo9LEP0l8LQPFQiBFz
 sXpW1UvnpX39gtIfl2sSJUPWI9bFvQXHtojg4wDo=
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/36] KVM: arm64: GICv4.1: Let doorbells be auto-enabled
Date: Sun, 27 Oct 2019 14:42:31 +0000
Message-Id: <20191027144234.8395-34-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Robert Richter <rrichter@marvell.com>,
 Jayachandran C <jnair@marvell.com>, Thomas Gleixner <tglx@linutronix.de>
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

As GICv4.1 understands the life cycle of doorbells (instead of
just randomly firing them at the most inconvenient time), just
enable them at irq_request time, and be done with it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-v4.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 50f84f4ce903..e61c7a149515 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -141,6 +141,7 @@ int vgic_v4_init(struct kvm *kvm)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		int irq = dist->its_vm.vpes[i]->irq;
+		unsigned long irq_flags = DB_IRQ_FLAGS;
 
 		/*
 		 * Don't automatically enable the doorbell, as we're
@@ -148,8 +149,14 @@ int vgic_v4_init(struct kvm *kvm)
 		 * blocked. Also disable the lazy disabling, as the
 		 * doorbell could kick us out of the guest too
 		 * early...
+		 *
+		 * On GICv4.1, the doorbell is managed in HW and must
+		 * be left enabled.
 		 */
-		irq_set_status_flags(irq, DB_IRQ_FLAGS);
+		if (kvm_vgic_global_state.has_gicv4_1)
+			irq_flags &= ~IRQ_NOAUTOEN;
+		irq_set_status_flags(irq, irq_flags);
+
 		ret = request_irq(irq, vgic_v4_doorbell_handler,
 				  0, "vcpu", vcpu);
 		if (ret) {
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
