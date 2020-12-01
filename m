Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4232CA671
	for <lists+kvmarm@lfdr.de>; Tue,  1 Dec 2020 16:00:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EAC464C1EE;
	Tue,  1 Dec 2020 10:00:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I2ln3Kdk6kJv; Tue,  1 Dec 2020 10:00:46 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD4C14C28B;
	Tue,  1 Dec 2020 10:00:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 201414C1FC
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 10:00:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZuDaB6YaivnW for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Dec 2020 10:00:44 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 146374B1DF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Dec 2020 10:00:44 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC6B11063;
 Tue,  1 Dec 2020 07:00:43 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947CE3F575;
 Tue,  1 Dec 2020 07:00:42 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com
Subject: [PATCH 2/5] KVM: arm64: arch_timer: Remove VGIC initialization check
Date: Tue,  1 Dec 2020 15:01:54 +0000
Message-Id: <20201201150157.223625-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201150157.223625-1-alexandru.elisei@arm.com>
References: <20201201150157.223625-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

kvm_timer_enable() is called in kvm_vcpu_first_run_init() after
kvm_vgic_map_resources() if the VGIC wasn't ready. kvm_vgic_map_resources()
is the only place where kvm->arch.vgic.ready is set to true.

For a v2 VGIC, kvm_vgic_map_resources() will attempt to initialize the VGIC
and set the initialized flag.

For a v3 VGIC, kvm_vgic_map_resources() will return an error code if the
VGIC isn't already initialized.

The end result is that if we've reached kvm_timer_enable(), the VGIC is
initialzed and ready and vgic_initialized() will always be true, so remove
this check.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kvm/arch_timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 32ba6fbc3814..2e0ca8bcc6ff 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -1129,9 +1129,6 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 	if (!irqchip_in_kernel(vcpu->kvm))
 		goto no_vgic;
 
-	if (!vgic_initialized(vcpu->kvm))
-		return -ENODEV;
-
 	if (!timer_irqs_are_valid(vcpu)) {
 		kvm_debug("incorrectly configured timer irqs\n");
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
