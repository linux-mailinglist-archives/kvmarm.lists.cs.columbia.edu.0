Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C819039F893
	for <lists+kvmarm@lfdr.de>; Tue,  8 Jun 2021 16:12:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76B394A319;
	Tue,  8 Jun 2021 10:12:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Df2g58tYEzUE; Tue,  8 Jun 2021 10:12:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 413C54A193;
	Tue,  8 Jun 2021 10:12:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E8FC40623
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 10:12:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TmSa7urcG0dO for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Jun 2021 10:12:08 -0400 (EDT)
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E75C4406E0
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 10:12:06 -0400 (EDT)
Received: by mail-ed1-f74.google.com with SMTP id
 s25-20020aa7c5590000b0290392e051b029so5891454edr.11
 for <kvmarm@lists.cs.columbia.edu>; Tue, 08 Jun 2021 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=v43My/fh29dQ89VkLemp8JE4rmjkcJppnIwoByZrgds=;
 b=BEcD2PghOJEFU2oMhSGxgZHmAQsOMZoS8FuEDW7kwr3rf7WZqcDNBj0yUCDuKnmRxB
 j3MVM8q3slM0Y/Yzva3xon2zKck/Y5iyW1Y/apk76zR18o/FfmDXGyjg1uyn7pkYbDuO
 QqWXGxMSzrN2GLJoZMdre8Ytq5aI6JYKUCofX8vhb625OmDUg5zeJ2f6jXzGKWhEyaWT
 vRAF48B27WM0JiqifHSQnXRahuUylLR1LbCreV86TpS8sU6h8/xTlL+2xpxRe8EFWRX/
 ZMD5NyzAaA3VNCF73eRjDwaHrR8MVzEL79Ek0bJxFvCLpoNPJDakq3EfWkU/blL4BDFZ
 W3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=v43My/fh29dQ89VkLemp8JE4rmjkcJppnIwoByZrgds=;
 b=i2jyEgTkRiJ5fNp0NjCyPPLkTmS8Svx8XECZfkVKfJhWK5fhzh0qcsbhM6pi6umoC1
 Mfviq5J5z+y7dwd9VNw8tVCQ0pEsegr7w1qed8KsA1cTVHzuIbWAYr4OXeXkgQNW6y17
 59rhQAfoiFq71IKvgYM2AeBRR8ZNZHJ49Hh63HW88J5HN5msuPrzFB7je8YqXMhYXPo1
 kaOPEGEIZ9q3vYopz/Issd70+Qoy4MLO7ft0c6Pn2ggT6eQRPvp0UXWyc2X6vYhabCGI
 gyeIhok5h8RvFcJNdGJ/YeN1cjuvVWN8qL/yb2DmsTBxsGkF4UWfAuqmqW6Sf0KgETF5
 WNuw==
X-Gm-Message-State: AOAM531efkDnJLBjjWoxddHgmhJBkIcVHyOQJ+1FO60jdMDxMGPPUdyg
 1LQMm0buMeG48cJXBIT3pdPApf2B1eyc+ryxjAsD9vHt2aStj7mh/bGdiMN31rpzUmkzObGqFOW
 SyveRSApbg6Kqp8cnl2jDjlaY5zIWCGKLY6UwJWXqWWpyEmjUONf4SQhwxLHdp3m+EjU=
X-Google-Smtp-Source: ABdhPJzHyTAOoCriJLa65Ddn1L9CwZMBcN5UfqwlNYVC38pGMtIMGkU9U+lIMCG6yJr3TTUuIsp+bFjoKA==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a05:6402:188:: with SMTP id
 r8mr25681479edv.75.1623161525939; Tue, 08 Jun 2021 07:12:05 -0700 (PDT)
Date: Tue,  8 Jun 2021 15:11:39 +0100
In-Reply-To: <20210608141141.997398-1-tabba@google.com>
Message-Id: <20210608141141.997398-12-tabba@google.com>
Mime-Version: 1.0
References: <20210608141141.997398-1-tabba@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v1 11/13] KVM: arm64: Trap access to pVM restricted features
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Trap accesses to restricted features for VMs running in protected
mode.

Access to feature registers are emulated, and only supported
features are exposed to protected VMs.

Accesses to restricted registers as well as restricted
instructions are trapped, and an undefined exception is injected
into the protected guest.

Only affects the functionality of protected VMs. Otherwise,
should not affect non-protected VMs when KVM is running in
protected mode.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h |   3 +
 arch/arm64/kvm/hyp/nvhe/switch.c        | 105 ++++++++++++++++++++----
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index f5d3d1da0aec..d9f087ed6e02 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -33,6 +33,9 @@
 extern struct exception_table_entry __start___kvm_ex_table;
 extern struct exception_table_entry __stop___kvm_ex_table;
 
+int kvm_handle_pvm_sys64(struct kvm_vcpu *vcpu);
+int kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu);
+
 /* Check whether the FP regs were dirtied while in the host-side run loop: */
 static inline bool update_fp_enabled(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 967a3ad74fbd..48d5f780fe64 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -34,12 +34,63 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
 DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
+/*
+ * Set EL2 configuration registers to trap restricted register accesses and
+ * instructions for protected VMs.
+ *
+ * Should be called right before vcpu entry to restrict its impact only to the
+ * protected guest.
+ */
+static void __activate_traps_pvm(struct kvm_vcpu *vcpu)
+{
+	u64 mdcr;
+	u64 hcr;
+	u64 cptr;
+
+	if (!kvm_vm_is_protected(kern_hyp_va(vcpu->kvm)))
+		return;
+
+	mdcr = read_sysreg(mdcr_el2);
+	hcr = read_sysreg(hcr_el2);
+	cptr = read_sysreg(cptr_el2);
+
+	hcr |= HCR_TID3 |			/* Feature Registers */
+	       HCR_TLOR |			/* LOR */
+	       HCR_RW |				/* AArch64 EL1 only */
+	       HCR_TERR |			/* RAS */
+	       HCR_ATA | HCR_TID5 |		/* Memory Tagging */
+	       HCR_TACR | HCR_TIDCP | HCR_TID1; /* Implementation defined */
+
+	hcr &= ~(HCR_DCT |	/* Memory Tagging */
+		 HCR_FIEN |	/* RAS */
+		 HCR_AMVOFFEN);	/* Disables AMU registers virtualization */
+
+	/* Debug and Trace */
+	mdcr |= MDCR_EL2_TDRA | MDCR_EL2_TDA | MDCR_EL2_TDE |
+		MDCR_EL2_TDOSA | MDCR_EL2_TDCC | MDCR_EL2_TTRF |
+		MDCR_EL2_TPM | MDCR_EL2_TPMCR |
+		MDCR_EL2_TPMS; /* SPE */
+
+	mdcr &= ~(MDCR_EL2_HPME | MDCR_EL2_MTPME |		/* PMU */
+		  (MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)); /* SPE */
+
+	cptr |= CPTR_EL2_TTA |	/* Trace */
+		CPTR_EL2_TAM |	/* AMU */
+		CPTR_EL2_TZ;	/* SVE */
+
+	/*  __deactivate_traps() restores these registers. */
+	write_sysreg(mdcr, mdcr_el2);
+	write_sysreg(hcr, hcr_el2);
+	write_sysreg(cptr, cptr_el2);
+}
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
 	___activate_traps(vcpu);
 	__activate_traps_common(vcpu);
+	__activate_traps_pvm(vcpu);
 
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TAM;
@@ -165,30 +216,56 @@ static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
 		write_sysreg(pmu->events_host, pmcntenset_el0);
 }
 
+/**
+ * Handle system register accesses for protected VMs.
+ *
+ * Return 1 if handled, or 0 if not.
+ */
+static int handle_pvm_sys64(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vm_is_protected(kern_hyp_va(vcpu->kvm)))
+		return kvm_handle_pvm_sys64(vcpu);
+	else
+		return 0;
+}
+
+/**
+ * Handle restricted feature accesses for protected VMs.
+ *
+ * Return 1 if handled, or 0 if not.
+ */
+static int handle_pvm_restricted(struct kvm_vcpu *vcpu)
+{
+	if (kvm_vm_is_protected(kern_hyp_va(vcpu->kvm)))
+		return kvm_handle_pvm_restricted(vcpu);
+	else
+		return 0;
+}
+
 typedef int (*exit_handle_fn)(struct kvm_vcpu *);
 
 static exit_handle_fn hyp_exit_handlers[] = {
-	[0 ... ESR_ELx_EC_MAX]		= NULL,
+	[0 ... ESR_ELx_EC_MAX]		= handle_pvm_restricted,
 	[ESR_ELx_EC_WFx]		= NULL,
-	[ESR_ELx_EC_CP15_32]		= NULL,
-	[ESR_ELx_EC_CP15_64]		= NULL,
-	[ESR_ELx_EC_CP14_MR]		= NULL,
-	[ESR_ELx_EC_CP14_LS]		= NULL,
-	[ESR_ELx_EC_CP14_64]		= NULL,
+	[ESR_ELx_EC_CP15_32]		= handle_pvm_restricted,
+	[ESR_ELx_EC_CP15_64]		= handle_pvm_restricted,
+	[ESR_ELx_EC_CP14_MR]		= handle_pvm_restricted,
+	[ESR_ELx_EC_CP14_LS]		= handle_pvm_restricted,
+	[ESR_ELx_EC_CP14_64]		= handle_pvm_restricted,
 	[ESR_ELx_EC_HVC32]		= NULL,
 	[ESR_ELx_EC_SMC32]		= NULL,
 	[ESR_ELx_EC_HVC64]		= NULL,
 	[ESR_ELx_EC_SMC64]		= NULL,
-	[ESR_ELx_EC_SYS64]		= NULL,
-	[ESR_ELx_EC_SVE]		= NULL,
+	[ESR_ELx_EC_SYS64]		= handle_pvm_sys64,
+	[ESR_ELx_EC_SVE]		= handle_pvm_restricted,
 	[ESR_ELx_EC_IABT_LOW]		= NULL,
 	[ESR_ELx_EC_DABT_LOW]		= NULL,
-	[ESR_ELx_EC_SOFTSTP_LOW]	= NULL,
-	[ESR_ELx_EC_WATCHPT_LOW]	= NULL,
-	[ESR_ELx_EC_BREAKPT_LOW]	= NULL,
-	[ESR_ELx_EC_BKPT32]		= NULL,
-	[ESR_ELx_EC_BRK64]		= NULL,
-	[ESR_ELx_EC_FP_ASIMD]		= NULL,
+	[ESR_ELx_EC_SOFTSTP_LOW]	= handle_pvm_restricted,
+	[ESR_ELx_EC_WATCHPT_LOW]	= handle_pvm_restricted,
+	[ESR_ELx_EC_BREAKPT_LOW]	= handle_pvm_restricted,
+	[ESR_ELx_EC_BKPT32]		= handle_pvm_restricted,
+	[ESR_ELx_EC_BRK64]		= handle_pvm_restricted,
+	[ESR_ELx_EC_FP_ASIMD]		= handle_pvm_restricted,
 	[ESR_ELx_EC_PAC]		= NULL,
 };
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
