Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 29B80C314A
	for <lists+kvmarm@lfdr.de>; Tue,  1 Oct 2019 12:24:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6B824A80D;
	Tue,  1 Oct 2019 06:24:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEUkaraBPm1K; Tue,  1 Oct 2019 06:24:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E45224A81F;
	Tue,  1 Oct 2019 06:24:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 041494A58C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 06:24:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IoXm8DK6ugbu for <kvmarm@lists.cs.columbia.edu>;
 Tue,  1 Oct 2019 06:24:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6D8A4A806
 for <kvmarm@lists.cs.columbia.edu>; Tue,  1 Oct 2019 06:24:04 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97D8E15AD;
 Tue,  1 Oct 2019 03:24:04 -0700 (PDT)
Received: from e123195-lin.cambridge.arm.com (e123195-lin.cambridge.arm.com
 [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DEED3F739;
 Tue,  1 Oct 2019 03:24:03 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH v2 18/19] arm64: selftest: Expand EL2 test
 to disable and re-enable VHE
Date: Tue,  1 Oct 2019 11:23:22 +0100
Message-Id: <20191001102323.27628-19-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001102323.27628-1-alexandru.elisei@arm.com>
References: <20191001102323.27628-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: maz@kernel.org, andre.przywara@arm.com, pbonzini@redhat.com
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

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Disabling VHE is broken with version v1 of the NV patches; to run the tests
I use this patch:

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1d896113f1f8..977905f6aacd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -333,7 +333,8 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
                 * to reverse-translate virtual EL2 system registers for a
                 * non-VHE guest hypervisor.
                 */
-               __vcpu_sys_reg(vcpu, reg) = val;
+               if (reg != HCR_EL2)
+                       __vcpu_sys_reg(vcpu, reg) = val;
 
                switch (reg) {
                case ELR_EL2:
@@ -370,7 +371,17 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
                return;
 
 memory_write:
-        __vcpu_sys_reg(vcpu, reg) = val;
+       if (reg == HCR_EL2 && vcpu_el2_e2h_is_set(vcpu) && !(val & HCR_E2H)) {
+               preempt_disable();
+               kvm_arch_vcpu_put(vcpu);
+
+               __vcpu_sys_reg(vcpu, reg) = val;
+
+               kvm_arch_vcpu_load(vcpu, smp_processor_id());
+               preempt_enable();
+       } else {
+                __vcpu_sys_reg(vcpu, reg) = val;
+       }
 }
 
 /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */

 arm/selftest.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arm/selftest.c b/arm/selftest.c
index 69994dcd3506..f94498e83d97 100644
--- a/arm/selftest.c
+++ b/arm/selftest.c
@@ -404,6 +404,18 @@ static void check_el2_cpu(void *data __unused)
 	report("CPU(%3d) Running at EL2", current_level() == CurrentEL_EL2, cpu);
 	report("CPU(%3d) VHE supported and enabled",
 			vhe_supported() && vhe_enabled(), cpu);
+
+	report_info("CPU(%3d) Disabling VHE", cpu);
+	disable_vhe();
+
+	report("CPU(%3d) Running at EL2", current_level() == CurrentEL_EL2, cpu);
+	report("CPU(%3d) VHE disabled", !vhe_enabled(), cpu);
+
+	report_info("CPU(%3d) Re-enabling VHE", cpu);
+	enable_vhe();
+
+	report("CPU(%3d) Running at EL2", current_level() == CurrentEL_EL2, cpu);
+	report("CPU(%3d) VHE enabled", vhe_enabled(), cpu);
 }
 
 static bool psci_check(void);
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
