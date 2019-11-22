Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E81CB1073C0
	for <lists+kvmarm@lfdr.de>; Fri, 22 Nov 2019 14:59:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67C1A4AEAE;
	Fri, 22 Nov 2019 08:59:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qfzi8J0-6V7a; Fri, 22 Nov 2019 08:59:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 603304AEB6;
	Fri, 22 Nov 2019 08:59:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E705E4AEAD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Nov 2019 08:59:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ado5ik6bdEy for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Nov 2019 08:59:03 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D0E9E4AEAA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Nov 2019 08:59:03 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iY9Sf-0003Nj-Qt; Fri, 22 Nov 2019 14:59:01 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
Date: Fri, 22 Nov 2019 13:58:33 +0000
Message-Id: <20191122135833.28953-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, peter.maydell@linaro.org, qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
SError interrupts.

Unfortunately, QEMU's implementation only considers the HCR_EL2
bits, and ignores the current exception level. This means a hypervisor
trying to look at its own interrupt state actually sees the guest
state, which is unexpected and breaks KVM as of Linux 5.3.

Instead, check for the running EL and return the physical bits
if not running in a virtualized context.

Fixes: 636540e9c40b
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 target/arm/helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a089fb5a69..027fffbff6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1934,8 +1934,11 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = env_cpu(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     uint64_t ret = 0;
+    bool allow_virt = (arm_current_el(env) == 1 &&
+                       (!arm_is_secure_below_el3(env) ||
+                        (env->cp15.scr_el3 & SCR_EEL2)));
 
-    if (hcr_el2 & HCR_IMO) {
+    if (allow_virt && (hcr_el2 & HCR_IMO)) {
         if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
             ret |= CPSR_I;
         }
@@ -1945,7 +1948,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
         }
     }
 
-    if (hcr_el2 & HCR_FMO) {
+    if (allow_virt && (hcr_el2 & HCR_FMO)) {
         if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
             ret |= CPSR_F;
         }
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
