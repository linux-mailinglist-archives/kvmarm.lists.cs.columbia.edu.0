Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFF2D6107
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 17:04:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 031184B2D2;
	Thu, 10 Dec 2020 11:04:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2JW9xQidRpIL; Thu, 10 Dec 2020 11:04:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 69CC24B2DD;
	Thu, 10 Dec 2020 11:04:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F2A8D4B28D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:04:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eX4oaWeuim7g for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 11:04:54 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B171B4B27D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 11:04:51 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD69223DE8;
 Thu, 10 Dec 2020 16:04:50 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1knONq-0008Di-RZ; Thu, 10 Dec 2020 16:01:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v3 63/66] KVM: arm64: nv: Allocate VNCR page when required
Date: Thu, 10 Dec 2020 15:59:59 +0000
Message-Id: <20201210160002.1407373-64-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160002.1407373-1-maz@kernel.org>
References: <20201210160002.1407373-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, alexandru.elisei@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>
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

If running a NV guest on an ARMv8.4-NV capable system, let's
allocate an additional page that will be used by the hypervisor
to fulfill system register accesses.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 3 ++-
 arch/arm64/kvm/nested.c           | 8 ++++++++
 arch/arm64/kvm/reset.c            | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 78630bd5124d..dada0678c28e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -523,7 +523,8 @@ struct kvm_vcpu_arch {
  */
 static inline u64 *__ctxt_sys_reg(const struct kvm_cpu_context *ctxt, int r)
 {
-	if (unlikely(r >= __VNCR_START__ && ctxt->vncr_array))
+	if (unlikely(cpus_have_final_cap(ARM64_HAS_ENHANCED_NESTED_VIRT) &&
+		     r >= __VNCR_START__ && ctxt->vncr_array))
 		return &ctxt->vncr_array[r - __VNCR_START__];
 
 	return (u64 *)&ctxt->sys_regs[r];
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index eef8f9873814..88147ec99755 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -47,6 +47,12 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	if (!cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
 		return -EINVAL;
 
+	if (cpus_have_final_cap(ARM64_HAS_ENHANCED_NESTED_VIRT)) {
+		vcpu->arch.ctxt.vncr_array = (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!vcpu->arch.ctxt.vncr_array)
+			return -ENOMEM;
+	}
+
 	mutex_lock(&kvm->lock);
 
 	/*
@@ -64,6 +70,8 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 		    kvm_init_stage2_mmu(kvm, &tmp[num_mmus - 2])) {
 			kvm_free_stage2_pgd(&tmp[num_mmus - 1]);
 			kvm_free_stage2_pgd(&tmp[num_mmus - 2]);
+			free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
+			vcpu->arch.ctxt.vncr_array = NULL;
 		} else {
 			kvm->arch.nested_mmus_size = num_mmus;
 			ret = 0;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 2d2c780e6c69..d281eb39036f 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -150,6 +150,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	kfree(vcpu->arch.sve_state);
+	free_page((unsigned long)vcpu->arch.ctxt.vncr_array);
 }
 
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
