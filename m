Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 718CB3D348
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 19:04:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 258334A533;
	Tue, 11 Jun 2019 13:04:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vhj43lYE26C; Tue, 11 Jun 2019 13:04:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 001784A518;
	Tue, 11 Jun 2019 13:03:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 20B0B4A536
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ERl8-NmHI5uW for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 13:03:57 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 58ECF4A4D5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 13:03:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DBD1EBD;
 Tue, 11 Jun 2019 10:03:56 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30143F73C;
 Tue, 11 Jun 2019 10:03:54 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 5/9] KVM: arm/arm64: vgic-its: Invalidate MSI-LPI
 translation cache on disabling LPIs
Date: Tue, 11 Jun 2019 18:03:32 +0100
Message-Id: <20190611170336.121706-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611170336.121706-1-marc.zyngier@arm.com>
References: <20190611170336.121706-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: "Raslan, KarimAllah" <karahmed@amazon.de>, "Saidi,
 Ali" <alisaidi@amazon.com>
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

If a vcpu disables LPIs at its redistributor level, we need to make sure
we won't pend more interrupts. For this, we need to invalidate the LPI
translation cache.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
index 936962abc38d..cb60da48810d 100644
--- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
+++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
@@ -192,8 +192,10 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 
 	vgic_cpu->lpis_enabled = val & GICR_CTLR_ENABLE_LPIS;
 
-	if (was_enabled && !vgic_cpu->lpis_enabled)
+	if (was_enabled && !vgic_cpu->lpis_enabled) {
 		vgic_flush_pending_lpis(vcpu);
+		vgic_its_invalidate_cache(vcpu->kvm);
+	}
 
 	if (!was_enabled && vgic_cpu->lpis_enabled)
 		vgic_enable_lpis(vcpu);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
