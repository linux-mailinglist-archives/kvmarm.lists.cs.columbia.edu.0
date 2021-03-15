Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48233B0AC
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 12:10:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEA984B588;
	Mon, 15 Mar 2021 07:10:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrok+ehVJalb; Mon, 15 Mar 2021 07:10:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CE6C4B548;
	Mon, 15 Mar 2021 07:10:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D945F4B548
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:10:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQVsM17e8Q6X for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 07:10:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E8754B501
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:10:20 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3ED864E90;
 Mon, 15 Mar 2021 11:10:18 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lLl73-001da4-3Q; Mon, 15 Mar 2021 11:10:17 +0000
From: Marc Zyngier <maz@kernel.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH][stable-5.4] KVM: arm64: Ensure I-cache isolation between
 vcpus of a same VM
Date: Mon, 15 Mar 2021 11:10:00 +0000
Message-Id: <20210315111000.4136196-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, kvmarm@lists.cs.columbia.edu,
 kernel-team@android.com, stable@vger.kernel.org, will@kernel.org,
 catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, stable@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

Commit 01dc9262ff5797b675c32c0c6bc682777d23de05 upstream.

It recently became apparent that the ARMv8 architecture has interesting
rules regarding attributes being used when fetching instructions
if the MMU is off at Stage-1.

In this situation, the CPU is allowed to fetch from the PoC and
allocate into the I-cache (unless the memory is mapped with
the XN attribute at Stage-2).

If we transpose this to vcpus sharing a single physical CPU,
it is possible for a vcpu running with its MMU off to influence
another vcpu running with its MMU on, as the latter is expected to
fetch from the PoU (and self-patching code doesn't flush below that
level).

In order to solve this, reuse the vcpu-private TLB invalidation
code to apply the same policy to the I-cache, nuking it every time
the vcpu runs on a physical CPU that ran another vcpu of the same
VM in the past.

This involve renaming __kvm_tlb_flush_local_vmid() to
__kvm_flush_cpu_context(), and inserting a local i-cache invalidation
there.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20210303164505.68492-1-maz@kernel.org
[maz: added 32bit ARM support]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/kvm_asm.h   | 2 +-
 arch/arm/kvm/hyp/tlb.c           | 3 ++-
 arch/arm64/include/asm/kvm_asm.h | 2 +-
 arch/arm64/kvm/hyp/tlb.c         | 3 ++-
 virt/kvm/arm/arm.c               | 8 +++++++-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index f615830f9f57..9d0b7e677faa 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -56,7 +56,7 @@ extern char __kvm_hyp_init_end[];
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
-extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
+extern void __kvm_flush_cpu_context(struct kvm_vcpu *vcpu);
 
 extern void __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high);
 
diff --git a/arch/arm/kvm/hyp/tlb.c b/arch/arm/kvm/hyp/tlb.c
index 848f27bbad9d..80e67108d39d 100644
--- a/arch/arm/kvm/hyp/tlb.c
+++ b/arch/arm/kvm/hyp/tlb.c
@@ -45,7 +45,7 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	__kvm_tlb_flush_vmid(kvm);
 }
 
-void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+void __hyp_text __kvm_flush_cpu_context(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
 
@@ -54,6 +54,7 @@ void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 	isb();
 
 	write_sysreg(0, TLBIALL);
+	write_sysreg(0, ICIALLU);
 	dsb(nsh);
 	isb();
 
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 64d79b288434..c54e759896c1 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -60,7 +60,7 @@ extern char __kvm_hyp_vector[];
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
-extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
+extern void __kvm_flush_cpu_context(struct kvm_vcpu *vcpu);
 
 extern void __kvm_timer_set_cntvoff(u32 cntvoff_low, u32 cntvoff_high);
 
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index eb0efc5557f3..7b7213fc17d9 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -182,7 +182,7 @@ void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 	__tlb_switch_to_host(kvm, &cxt);
 }
 
-void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+void __hyp_text __kvm_flush_cpu_context(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
 	struct tlb_inv_context cxt;
@@ -191,6 +191,7 @@ void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 	__tlb_switch_to_guest(kvm, &cxt);
 
 	__tlbi(vmalle1);
+	asm volatile("ic iallu");
 	dsb(nsh);
 	isb();
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 986fbc3cf667..2e7d2b3f2907 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -373,11 +373,17 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	cpu_data = this_cpu_ptr(&kvm_host_data);
 
 	/*
+	 * We guarantee that both TLBs and I-cache are private to each
+	 * vcpu. If detecting that a vcpu from the same VM has
+	 * previously run on the same physical CPU, call into the
+	 * hypervisor code to nuke the relevant contexts.
+	 *
+         * We might get preempted before the vCPU actually runs, but
 	 * We might get preempted before the vCPU actually runs, but
 	 * over-invalidation doesn't affect correctness.
 	 */
 	if (*last_ran != vcpu->vcpu_id) {
-		kvm_call_hyp(__kvm_tlb_flush_local_vmid, vcpu);
+		kvm_call_hyp(__kvm_flush_cpu_context, vcpu);
 		*last_ran = vcpu->vcpu_id;
 	}
 
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
