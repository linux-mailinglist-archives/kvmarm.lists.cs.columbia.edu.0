Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 58472464D78
	for <lists+kvmarm@lfdr.de>; Wed,  1 Dec 2021 13:04:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED8604B203;
	Wed,  1 Dec 2021 07:04:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vptbJ21H9sCm; Wed,  1 Dec 2021 07:04:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 560D14B218;
	Wed,  1 Dec 2021 07:04:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 67E4E4B1E6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 07:04:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ug7UTKpWKASb for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Dec 2021 07:04:47 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 145CF4B1E9
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Dec 2021 07:04:47 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 27BF0B81E62;
 Wed,  1 Dec 2021 12:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C738BC58319;
 Wed,  1 Dec 2021 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638360283;
 bh=sjTw/0RGY+SXfU0yHu7RuP0HWNF81XgKH/bxHSPuHjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s3XSlmSq2ddCXsdQ/GAA2PMvV9FuoBUwltMzNUuCDtcmSrFJQnFCf9nUCM3SWv3S9
 IwbfLLqM7WAIvjABy3c92O+nFJAu79/Htrfuxx5rWSs/zgcN9AxwJRWvEk+GZRBmtg
 CihSDLKqlCNaDRyGO39CBKKMazn1m0OZV6x3ogPSMHR7mUpr4Ohzb429CV7K/YtL1T
 OUgYJCwg5TAnGXbUB+4tbH+0RvOkItUVKP9L3+MDveEMafb1OzjfqTFG3+9+VO5Zj2
 uvqn4z/kWzCLGH7HuOeiYPTnCaS/jjh8Ox/k41zsT5j3/yxUJfkN1tyQssKpegFgbt
 K4iAlo09ova5A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1msOLq-0097Ab-0T; Wed, 01 Dec 2021 12:04:42 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/6] KVM: arm64: Introduce flag shadowing
 TIF_FOREIGN_FPSTATE
Date: Wed,  1 Dec 2021 12:04:34 +0000
Message-Id: <20211201120436.389756-5-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201120436.389756-1-maz@kernel.org>
References: <20211201120436.389756-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, qperret@google.com,
 will@kernel.org, broonie@kernel.org, yuzenghui@huawei.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>, broonie@kernel.org
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

We currently have to maintain a mapping the thread_info structure
at EL2 in order to be able to check the TIF_FOREIGN_FPSTATE flag.

In order to eventually get rid of this, start with a vcpu flag that
shadows the thread flag on each entry into the hypervisor.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 2 ++
 arch/arm64/kvm/arm.c                    | 1 +
 arch/arm64/kvm/fpsimd.c                 | 8 ++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3ccfc3e3e436..9f1703ebae15 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -441,6 +441,7 @@ struct kvm_vcpu_arch {
 
 #define KVM_ARM64_DEBUG_STATE_SAVE_SPE	(1 << 12) /* Save SPE context if active  */
 #define KVM_ARM64_DEBUG_STATE_SAVE_TRBE	(1 << 13) /* Save TRBE context if active  */
+#define KVM_ARM64_FP_FOREIGN_FPSTATE	(1 << 14)
 
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
@@ -736,6 +737,7 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu);
+void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e4727dc771bf..d1b93dc8d639 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -849,6 +849,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		}
 
 		kvm_arm_setup_debug(vcpu);
+		kvm_arch_vcpu_ctxflush_fp(vcpu);
 
 		/**************************************************************
 		 * Enter the guest
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 2d15e1d6e214..a18b9c1744d5 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -79,6 +79,14 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 		vcpu->arch.flags |= KVM_ARM64_HOST_SVE_ENABLED;
 }
 
+void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
+{
+	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
+		vcpu->arch.flags |= KVM_ARM64_FP_FOREIGN_FPSTATE;
+	else
+		vcpu->arch.flags &= ~KVM_ARM64_FP_FOREIGN_FPSTATE;
+}
+
 /*
  * If the guest FPSIMD state was loaded, update the host's context
  * tracking data mark the CPU FPSIMD regs as dirty and belonging to vcpu
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e65c2956b881..a243a2a82131 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -49,7 +49,7 @@ static inline bool update_fp_enabled(struct kvm_vcpu *vcpu)
 	 * trap the accesses.
 	 */
 	if (!system_supports_fpsimd() ||
-	    vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
+	    vcpu->arch.flags & KVM_ARM64_FP_FOREIGN_FPSTATE)
 		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
 				      KVM_ARM64_FP_HOST);
 
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
