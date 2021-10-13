Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F222B42BF7C
	for <lists+kvmarm@lfdr.de>; Wed, 13 Oct 2021 14:04:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A24F84B099;
	Wed, 13 Oct 2021 08:04:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-jmPOcZgjpx; Wed, 13 Oct 2021 08:04:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D142F4B174;
	Wed, 13 Oct 2021 08:04:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C562B4B103
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 08:04:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0IQkkHWU06Jy for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Oct 2021 08:04:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AF3E24B126
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 08:04:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D7A6610E6;
 Wed, 13 Oct 2021 12:04:02 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1maczI-00GTgY-Pj; Wed, 13 Oct 2021 13:04:00 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 20/22] KVM: arm64: pkvm: Move kvm_handle_pvm_restricted
 around
Date: Wed, 13 Oct 2021 13:03:44 +0100
Message-Id: <20211013120346.2926621-10-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013120346.2926621-1-maz@kernel.org>
References: <20211010145636.1950948-12-tabba@google.com>
 <20211013120346.2926621-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, mark.rutland@arm.com,
 pbonzini@redhat.com, drjones@redhat.com, oupton@google.com, qperret@google.com,
 kernel-team@android.com, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, pbonzini@redhat.com, will@kernel.org
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

Place kvm_handle_pvm_restricted() next to its little friends such
as kvm_handle_pvm_sysreg().

This allows to make inject_undef64() static.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c               | 12 ------------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 14 +++++++++++++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 747fc79ae784..eea1f6a53723 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -194,7 +194,7 @@
 
 u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu, u32 id);
 bool kvm_handle_pvm_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code);
+bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code);
 int kvm_check_pvm_sysreg_table(void);
-void inject_undef64(struct kvm_vcpu *vcpu);
 
 #endif /* __ARM64_KVM_FIXED_CONFIG_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 317dba6a018d..be6889e33b2b 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -159,18 +159,6 @@ static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
 		write_sysreg(pmu->events_host, pmcntenset_el0);
 }
 
-/**
- * Handler for protected VM restricted exceptions.
- *
- * Inject an undefined exception into the guest and return true to indicate that
- * the hypervisor has handled the exit, and control should go back to the guest.
- */
-static bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code)
-{
-	inject_undef64(vcpu);
-	return true;
-}
-
 /**
  * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
  *
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 052f885e65b2..3787ee6fb1a2 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -30,7 +30,7 @@ u64 id_aa64mmfr2_el1_sys_val;
  * Inject an unknown/undefined exception to an AArch64 guest while most of its
  * sysregs are live.
  */
-void inject_undef64(struct kvm_vcpu *vcpu)
+static void inject_undef64(struct kvm_vcpu *vcpu)
 {
 	u32 esr = (ESR_ELx_EC_UNKNOWN << ESR_ELx_EC_SHIFT);
 
@@ -473,3 +473,15 @@ bool kvm_handle_pvm_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 	return true;
 }
+
+/**
+ * Handler for protected VM restricted exceptions.
+ *
+ * Inject an undefined exception into the guest and return true to indicate that
+ * the hypervisor has handled the exit, and control should go back to the guest.
+ */
+bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	inject_undef64(vcpu);
+	return true;
+}
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
