Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C99CF1E82EC
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 18:03:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CFDB4B24F;
	Fri, 29 May 2020 12:03:37 -0400 (EDT)
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
	with ESMTP id bO00n0kmRXs4; Fri, 29 May 2020 12:03:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 051474B297;
	Fri, 29 May 2020 12:03:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFE654B27F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:03:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LaflBNKGFG0w for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 12:03:33 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6B5724B281
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:03:33 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AE46207BC;
 Fri, 29 May 2020 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590768212;
 bh=2hQmI7GgrYdyZRgpFPRYm0ExqQ/4SSn0n/Amq99SIIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lztXq8nIsqBAIyNx9pWnZg9FWjhYETfJoEKtH5tzIjx1sd08Y82QtDFCy/SanDyki
 oppmXPP58b5+vPcYb5fnoDYohPu8ZSKAkWA6jEpLXYaSnV8F4opMILOHhoE1tiUo5b
 nuZ5NU1+wnvzbS6naY/MXaTY7CESnR4NC5Qnk1nU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jehSF-00GJKc-BQ; Fri, 29 May 2020 17:01:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 15/24] KVM: arm64: Clean up cpu_init_hyp_mode()
Date: Fri, 29 May 2020 17:01:12 +0100
Message-Id: <20200529160121.899083-16-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529160121.899083-1-maz@kernel.org>
References: <20200529160121.899083-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 ascull@google.com, ardb@kernel.org, christoffer.dall@arm.com,
 dbrazdil@google.com, tabba@google.com, james.morse@arm.com, giangyi@amazon.com,
 zhukeqian1@huawei.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, yuzenghui@huawei.com, julien.thierry.kdev@gmail.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jiang Yi <giangyi@amazon.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

From: David Brazdil <dbrazdil@google.com>

Pull bits of code to the only place where it is used. Remove empty function
__cpu_init_stage2(). Remove redundant has_vhe() check since this function is
nVHE-only. No functional changes intended.

Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200515152056.83158-1-dbrazdil@google.com
---
 arch/arm64/include/asm/kvm_asm.h  |  2 ++
 arch/arm64/include/asm/kvm_host.h | 35 -------------------------------
 arch/arm64/kvm/arm.c              | 32 +++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 59e314f38e43..0c9b5fc4ba0a 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -70,6 +70,8 @@ extern int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu);
 
 extern int __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu);
 
+extern void __kvm_enable_ssbs(void);
+
 extern u64 __vgic_v3_get_ich_vtr_el2(void);
 extern u64 __vgic_v3_read_vmcr(void);
 extern void __vgic_v3_write_vmcr(u32 vmcr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a723f84fab83..69a338a390a6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -533,39 +533,6 @@ static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 	cpu_ctxt->sys_regs[MPIDR_EL1] = read_cpuid_mpidr();
 }
 
-void __kvm_enable_ssbs(void);
-
-static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
-				       unsigned long hyp_stack_ptr,
-				       unsigned long vector_ptr)
-{
-	/*
-	 * Calculate the raw per-cpu offset without a translation from the
-	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
-	 * so that we can use adr_l to access per-cpu variables in EL2.
-	 */
-	u64 tpidr_el2 = ((u64)this_cpu_ptr(&kvm_host_data) -
-			 (u64)kvm_ksym_ref(kvm_host_data));
-
-	/*
-	 * Call initialization code, and switch to the full blown HYP code.
-	 * If the cpucaps haven't been finalized yet, something has gone very
-	 * wrong, and hyp will crash and burn when it uses any
-	 * cpus_have_const_cap() wrapper.
-	 */
-	BUG_ON(!system_capabilities_finalized());
-	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
-
-	/*
-	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
-	 * at EL2.
-	 */
-	if (!has_vhe() && this_cpu_has_cap(ARM64_SSBS) &&
-	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
-		kvm_call_hyp(__kvm_enable_ssbs);
-	}
-}
-
 static inline bool kvm_arch_requires_vhe(void)
 {
 	/*
@@ -601,8 +568,6 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
 
-static inline void __cpu_init_stage2(void) {}
-
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e01d44df98df..b0b569f2cdd0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1273,19 +1273,41 @@ static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
 	unsigned long hyp_stack_ptr;
-	unsigned long stack_page;
 	unsigned long vector_ptr;
+	unsigned long tpidr_el2;
 
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors(kvm_get_idmap_vector());
 
+	/*
+	 * Calculate the raw per-cpu offset without a translation from the
+	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
+	 * so that we can use adr_l to access per-cpu variables in EL2.
+	 */
+	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
+		     (unsigned long)kvm_ksym_ref(kvm_host_data));
+
 	pgd_ptr = kvm_mmu_get_httbr();
-	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
-	hyp_stack_ptr = stack_page + PAGE_SIZE;
+	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
 	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
-	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
-	__cpu_init_stage2();
+	/*
+	 * Call initialization code, and switch to the full blown HYP code.
+	 * If the cpucaps haven't been finalized yet, something has gone very
+	 * wrong, and hyp will crash and burn when it uses any
+	 * cpus_have_const_cap() wrapper.
+	 */
+	BUG_ON(!system_capabilities_finalized());
+	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
+
+	/*
+	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
+	 * at EL2.
+	 */
+	if (this_cpu_has_cap(ARM64_SSBS) &&
+	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
+		kvm_call_hyp(__kvm_enable_ssbs);
+	}
 }
 
 static void cpu_hyp_reset(void)
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
