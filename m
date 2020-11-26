Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D39C02C5753
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 15:48:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C4DB4C135;
	Thu, 26 Nov 2020 09:48:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G+inZfN3VhBm; Thu, 26 Nov 2020 09:48:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BD8C4C129;
	Thu, 26 Nov 2020 09:48:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15ECA4C11E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 09:48:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCBZrBZOdVPQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 09:48:13 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B00C14C11F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 09:48:12 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E48731B;
 Thu, 26 Nov 2020 06:48:12 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D6AC3F71F;
 Thu, 26 Nov 2020 06:48:11 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Refuse to run VCPU if PMU is not initialized
Date: Thu, 26 Nov 2020 14:49:16 +0000
Message-Id: <20201126144916.164075-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.29.2
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

When enabling the PMU in kvm_arm_pmu_v3_enable(), KVM returns early if the
PMU flag created is false and skips any other checks. Because PMU emulation
is gated only on the VCPU feature being set, this makes it possible for
userspace to get away with setting the VCPU feature but not doing any
initialization for the PMU. Fix it by returning an error when trying to run
the VCPU if the PMU hasn't been initialized correctly.

The PMU is marked as created only if the interrupt ID has been set when
using an in-kernel irqchip. This means the same check in
kvm_arm_pmu_v3_enable() is redundant, remove it.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Patch is based on top of [1].

This has been reported at [2]. I tested the patch like in the report, with
a modified version of kvmtool that sets the PMU feature, but doesn't do any
initialization.

Without this patch, when running the pmu kvm-unit-tests test, I get the
warning described in the report. With this patch, KVM refuses to run the
VCPU:

$ ./lkvm-pmu run -c1 -m 64 -f /path/to/arm/pmu.flat --pmu -p cycle-counter
  # lkvm run --firmware /path/to/arm/pmu.flat -m 64 -c 1 --name guest-207
  Info: Placing fdt at 0x80200000 - 0x80210000
KVM_RUN failed: Invalid argument

I also tested what happens if I run a Linux guest without this patch with
the modified version of kvmtool. The PMU is detected, but the guest doesn't
receive any PMU interrupts. With this patch, KVM refuses to run the VCPU.

I decided to return -EINVAL instead of -ENOEXEC because that is the error
code that kvm_arm_pmu_v3_enable() was already returning if the interrupt ID
was not initialized, which implies that the PMU hadn't been initialized.

I also noticed that there are other places which return different error
codes for KVM_RUN, and I'm in the process of untangling that to send a
patch to document them.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/log/?h=queue
[2] https://www.spinics.net/lists/arm-kernel/msg857927.html

 arch/arm64/kvm/pmu-emul.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 643cf819f3c0..398f6df1bbe4 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -825,9 +825,12 @@ bool kvm_arm_support_pmu_v3(void)
 
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 {
-	if (!vcpu->arch.pmu.created)
+	if (!kvm_vcpu_has_pmu(vcpu))
 		return 0;
 
+	if (!vcpu->arch.pmu.created)
+		return -EINVAL;
+
 	/*
 	 * A valid interrupt configuration for the PMU is either to have a
 	 * properly configured interrupt number and using an in-kernel
@@ -835,9 +838,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 	 */
 	if (irqchip_in_kernel(vcpu->kvm)) {
 		int irq = vcpu->arch.pmu.irq_num;
-		if (!kvm_arm_pmu_irq_initialized(vcpu))
-			return -EINVAL;
-
 		/*
 		 * If we are using an in-kernel vgic, at this point we know
 		 * the vgic will be initialized, so we can check the PMU irq
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
