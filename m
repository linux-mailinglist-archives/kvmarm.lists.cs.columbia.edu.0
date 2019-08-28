Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17D32A0363
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 15:39:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B90C84A5A5;
	Wed, 28 Aug 2019 09:38:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIsHRco6v5Xz; Wed, 28 Aug 2019 09:38:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B73F4A5A9;
	Wed, 28 Aug 2019 09:38:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CAD3B4A588
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:38:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O+EhC4qq9-Wi for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 09:38:54 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DD724A581
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 09:38:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C440715AB;
 Wed, 28 Aug 2019 06:38:52 -0700 (PDT)
Received: from e121566-lin.cambridge.arm.com (e121566-lin.cambridge.arm.com
 [10.1.196.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5F923F246;
 Wed, 28 Aug 2019 06:38:51 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [kvm-unit-tests RFC PATCH 02/16] arm/arm64: psci: Don't run C code
 without stack or vectors
Date: Wed, 28 Aug 2019 14:38:17 +0100
Message-Id: <1566999511-24916-3-git-send-email-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The psci test performs a series of CPU_ON/CPU_OFF cycles for CPU 1. This is
done by setting the entry point for the CPU_ON call to the physical address
of the C function cpu_psci_cpu_die.

The compiler is well within its rights to use the stack when generating
code for cpu_psci_cpu_die.  However, because no stack initialization has
been done, the stack pointer is zero, as set by KVM when creating the VCPU.
This causes a data abort without a change in exception level. The VBAR_EL1
register is also zero (the KVM reset value for VBAR_EL1), the MMU is off,
and we end up trying to fetch instructions from address 0x200.

At this point, a stage 2 instruction abort is generated which is taken to
KVM. KVM interprets this as an instruction fetch from an I/O region, and
injects a prefetch abort into the guest. Prefetch abort is a synchronous
exception, and on guest return the VCPU PC will be set to VBAR_EL1 + 0x200,
which is...  0x200. The VCPU ends up in an infinite loop causing a prefetch
abort while fetching the instruction to service the said abort.

cpu_psci_cpu_die is basically a wrapper over the HVC instruction, so
provide an assembly implementation for the function which will serve as the
entry point for CPU_ON.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/cstart.S   | 7 +++++++
 arm/cstart64.S | 7 +++++++
 arm/psci.c     | 5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arm/cstart.S b/arm/cstart.S
index 114726feab82..5d4fe4b1570b 100644
--- a/arm/cstart.S
+++ b/arm/cstart.S
@@ -7,6 +7,7 @@
  */
 #define __ASSEMBLY__
 #include <auxinfo.h>
+#include <linux/psci.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
@@ -138,6 +139,12 @@ secondary_entry:
 	blx	r0
 	b	do_idle
 
+.global asm_cpu_psci_cpu_die
+asm_cpu_psci_cpu_die:
+	ldr	r0, =PSCI_0_2_FN_CPU_OFF
+	hvc	#0
+	b	halt
+
 .globl halt
 halt:
 1:	wfi
diff --git a/arm/cstart64.S b/arm/cstart64.S
index b0e8baa1a23a..20f832fd57f7 100644
--- a/arm/cstart64.S
+++ b/arm/cstart64.S
@@ -7,6 +7,7 @@
  */
 #define __ASSEMBLY__
 #include <auxinfo.h>
+#include <linux/psci.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -128,6 +129,12 @@ secondary_entry:
 	blr	x0
 	b	do_idle
 
+.globl asm_cpu_psci_cpu_die
+asm_cpu_psci_cpu_die:
+	ldr	x0, =PSCI_0_2_FN_CPU_OFF
+	hvc	#0
+	b	halt
+
 .globl halt
 halt:
 1:	wfi
diff --git a/arm/psci.c b/arm/psci.c
index 5cb4d5c7c233..0440c4cdbc59 100644
--- a/arm/psci.c
+++ b/arm/psci.c
@@ -72,6 +72,7 @@ static int cpu_on_ret[NR_CPUS];
 static cpumask_t cpu_on_ready, cpu_on_done;
 static volatile int cpu_on_start;
 
+extern void asm_cpu_psci_cpu_die(void);
 static void cpu_on_secondary_entry(void)
 {
 	int cpu = smp_processor_id();
@@ -79,7 +80,7 @@ static void cpu_on_secondary_entry(void)
 	cpumask_set_cpu(cpu, &cpu_on_ready);
 	while (!cpu_on_start)
 		cpu_relax();
-	cpu_on_ret[cpu] = psci_cpu_on(cpus[1], __pa(cpu_psci_cpu_die));
+	cpu_on_ret[cpu] = psci_cpu_on(cpus[1], __pa(asm_cpu_psci_cpu_die));
 	cpumask_set_cpu(cpu, &cpu_on_done);
 }
 
@@ -104,7 +105,7 @@ static bool psci_cpu_on_test(void)
 	cpu_on_start = 1;
 	smp_mb();
 
-	cpu_on_ret[0] = psci_cpu_on(cpus[1], __pa(cpu_psci_cpu_die));
+	cpu_on_ret[0] = psci_cpu_on(cpus[1], __pa(asm_cpu_psci_cpu_die));
 	cpumask_set_cpu(0, &cpu_on_done);
 
 	while (!cpumask_full(&cpu_on_done))
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
