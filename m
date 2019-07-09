Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5947C635BA
	for <lists+kvmarm@lfdr.de>; Tue,  9 Jul 2019 14:26:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 06B5B4A516;
	Tue,  9 Jul 2019 08:26:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xo7m9Zy5g9Il; Tue,  9 Jul 2019 08:26:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54F644A563;
	Tue,  9 Jul 2019 08:25:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C1ED4A515
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jul 2019 08:25:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DezWbNcXZCP8 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Jul 2019 08:25:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC0AE4A566
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Jul 2019 08:25:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8BE015BF;
 Tue,  9 Jul 2019 05:25:56 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (unknown [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D264B3F59C;
 Tue,  9 Jul 2019 05:25:54 -0700 (PDT)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 18/18] KVM: arm/arm64: Initialise host's MPIDRs by reading the
 actual register
Date: Tue,  9 Jul 2019 13:25:07 +0100
Message-Id: <20190709122507.214494-19-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709122507.214494-1-marc.zyngier@arm.com>
References: <20190709122507.214494-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>, Steven Price <steven.price@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

As part of setting up the host context, we populate its
MPIDR by using cpu_logical_map(). It turns out that contrary
to arm64, cpu_logical_map() on 32bit ARM doesn't return the
*full* MPIDR, but a truncated version.

This leaves the host MPIDR slightly corrupted after the first
run of a VM, since we won't correctly restore the MPIDR on
exit. Oops.

Since we cannot trust cpu_logical_map(), let's adopt a different
strategy. We move the initialization of the host CPU context as
part of the per-CPU initialization (which, in retrospect, makes
a lot of sense), and directly read the MPIDR from the HW. This
is guaranteed to work on both arm and arm64.

Reported-by: Andre Przywara <Andre.Przywara@arm.com>
Tested-by: Andre Przywara <Andre.Przywara@arm.com>
Fixes: 32f139551954 ("arm/arm64: KVM: Statically configure the host's view of MPIDR")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 6 ++----
 arch/arm64/include/asm/kvm_host.h | 7 +++----
 virt/kvm/arm/arm.c                | 3 ++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index e74e8f408987..8a37c8e89777 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -15,7 +15,6 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
 #include <asm/fpstate.h>
-#include <asm/smp_plat.h>
 #include <kvm/arm_arch_timer.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -147,11 +146,10 @@ struct kvm_host_data {
 
 typedef struct kvm_host_data kvm_host_data_t;
 
-static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt,
-					     int cpu)
+static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
 	/* The host's MPIDR is immutable, so let's set it up at boot time */
-	cpu_ctxt->cp15[c0_MPIDR] = cpu_logical_map(cpu);
+	cpu_ctxt->cp15[c0_MPIDR] = read_cpuid_mpidr();
 }
 
 struct vcpu_reset_state {
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d9770daf3d7d..63a196c19fed 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -19,12 +19,12 @@
 #include <asm/arch_gicv3.h>
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
-#include <asm/smp_plat.h>
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
@@ -484,11 +484,10 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
 DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
 
-static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt,
-					     int cpu)
+static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
 	/* The host's MPIDR is immutable, so let's set it up at boot time */
-	cpu_ctxt->sys_regs[MPIDR_EL1] = cpu_logical_map(cpu);
+	cpu_ctxt->sys_regs[MPIDR_EL1] = read_cpuid_mpidr();
 }
 
 void __kvm_enable_ssbs(void);
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index bd5c55916d0d..f149c79fd6ef 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1332,6 +1332,8 @@ static void cpu_hyp_reset(void)
 
 static void cpu_hyp_reinit(void)
 {
+	kvm_init_host_cpu_context(&this_cpu_ptr(&kvm_host_data)->host_ctxt);
+
 	cpu_hyp_reset();
 
 	if (is_kernel_in_hyp_mode())
@@ -1569,7 +1571,6 @@ static int init_hyp_mode(void)
 		kvm_host_data_t *cpu_data;
 
 		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
-		kvm_init_host_cpu_context(&cpu_data->host_ctxt, cpu);
 		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
 
 		if (err) {
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
