Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D252D483
	for <lists+kvmarm@lfdr.de>; Thu, 19 May 2022 15:45:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1911D4B441;
	Thu, 19 May 2022 09:45:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZOb7fY7esYak; Thu, 19 May 2022 09:45:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A31F4B416;
	Thu, 19 May 2022 09:45:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 555D74B3F8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQ1My3smEs5D for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 May 2022 09:45:51 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C4EDB4B416
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 May 2022 09:45:49 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CFC9DB824AB;
 Thu, 19 May 2022 13:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25501C34100;
 Thu, 19 May 2022 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652967947;
 bh=vn94WCmAYZN6zOdSO+ooW8+de2325RR/Q7OATfCvR9k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YWFWQwTQ5O1KPqUp4BW5LPJrK1PuwVjN4EzxwAUnvG9gKXhFK29lUf6lJCynTmQIY
 uuMF81D9IwMYXDoVfnf80ZErySl4bRkjRdJnmNTXylawqPQbuVSX7ng/D9cFD6o35g
 InsiV34IuXF/t7k7pEd+BVAkOnKwqbpkxLsqi0/9qBBcGc/p1RAoQOpXNfg/oZUbNE
 QQAnwIRB783+q8GGoqZRySDQTalK6LEId6R7zRcOepIeV9Pi2pG0wO7Lg3Zeyao50t
 iB3nCYJg/r5LeOJHjZ1PjccVQpsPbVBB7UNvLWkIbzJ43AdLz8rhzMjROferhnKAoX
 ZMdk4tF0CqUgA==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 51/89] KVM: arm64: Introduce per-EC entry/exit handlers
Date: Thu, 19 May 2022 14:41:26 +0100
Message-Id: <20220519134204.5379-52-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220519134204.5379-1-will@kernel.org>
References: <20220519134204.5379-1-will@kernel.org>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, kernel-team@android.com, kvm@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-arm-kernel@lists.infradead.org,
 Michael Roth <michael.roth@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Will Deacon <will@kernel.org>
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

From: Marc Zyngier <maz@kernel.org>

Introduce per-EC entry/exit handlers at EL2 and provide initial
implementations to manage the 'flags' and fault information registers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  3 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c     | 99 +++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index da8de2b7afb4..d070400b5616 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -25,6 +25,9 @@ struct kvm_shadow_vcpu_state {
 	/* A pointer to the shadow vm. */
 	struct kvm_shadow_vm *shadow_vm;
 
+	/* Tracks exit code for the protected guest. */
+	u32 exit_code;
+
 	/*
 	 * Points to the per-cpu pointer of the cpu where it's loaded, or NULL
 	 * if not loaded.
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 229ef890d459..bbf2621f1862 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -24,6 +24,51 @@ DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
 void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
 
+typedef void (*shadow_entry_exit_handler_fn)(struct kvm_vcpu *, struct kvm_vcpu *);
+
+static void handle_vm_entry_generic(struct kvm_vcpu *host_vcpu, struct kvm_vcpu *shadow_vcpu)
+{
+	unsigned long host_flags = READ_ONCE(host_vcpu->arch.flags);
+
+	shadow_vcpu->arch.flags &= ~(KVM_ARM64_PENDING_EXCEPTION |
+				     KVM_ARM64_EXCEPT_MASK);
+
+	if (host_flags & KVM_ARM64_PENDING_EXCEPTION) {
+		shadow_vcpu->arch.flags |= KVM_ARM64_PENDING_EXCEPTION;
+		shadow_vcpu->arch.flags |= host_flags & KVM_ARM64_EXCEPT_MASK;
+	} else if (host_flags & KVM_ARM64_INCREMENT_PC) {
+		shadow_vcpu->arch.flags |= KVM_ARM64_INCREMENT_PC;
+	}
+}
+
+static void handle_vm_exit_generic(struct kvm_vcpu *host_vcpu, struct kvm_vcpu *shadow_vcpu)
+{
+	WRITE_ONCE(host_vcpu->arch.fault.esr_el2,
+		   shadow_vcpu->arch.fault.esr_el2);
+}
+
+static void handle_vm_exit_abt(struct kvm_vcpu *host_vcpu, struct kvm_vcpu *shadow_vcpu)
+{
+	WRITE_ONCE(host_vcpu->arch.fault.esr_el2,
+		   shadow_vcpu->arch.fault.esr_el2);
+	WRITE_ONCE(host_vcpu->arch.fault.far_el2,
+		   shadow_vcpu->arch.fault.far_el2);
+	WRITE_ONCE(host_vcpu->arch.fault.hpfar_el2,
+		   shadow_vcpu->arch.fault.hpfar_el2);
+	WRITE_ONCE(host_vcpu->arch.fault.disr_el1,
+		   shadow_vcpu->arch.fault.disr_el1);
+}
+
+static const shadow_entry_exit_handler_fn entry_vm_shadow_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]		= handle_vm_entry_generic,
+};
+
+static const shadow_entry_exit_handler_fn exit_vm_shadow_handlers[] = {
+	[0 ... ESR_ELx_EC_MAX]		= handle_vm_exit_generic,
+	[ESR_ELx_EC_IABT_LOW]		= handle_vm_exit_abt,
+	[ESR_ELx_EC_DABT_LOW]		= handle_vm_exit_abt,
+};
+
 static void flush_vgic_state(struct kvm_vcpu *host_vcpu,
 			     struct kvm_vcpu *shadow_vcpu)
 {
@@ -99,6 +144,8 @@ static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 {
 	struct kvm_vcpu *shadow_vcpu = &shadow_state->shadow_vcpu;
 	struct kvm_vcpu *host_vcpu = shadow_state->host_vcpu;
+	shadow_entry_exit_handler_fn ec_handler;
+	u8 esr_ec;
 
 	shadow_vcpu->arch.ctxt		= host_vcpu->arch.ctxt;
 
@@ -109,8 +156,6 @@ static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 	shadow_vcpu->arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	shadow_vcpu->arch.cptr_el2	= host_vcpu->arch.cptr_el2;
 
-	shadow_vcpu->arch.flags		= host_vcpu->arch.flags;
-
 	shadow_vcpu->arch.debug_ptr	= kern_hyp_va(host_vcpu->arch.debug_ptr);
 	shadow_vcpu->arch.host_fpsimd_state = host_vcpu->arch.host_fpsimd_state;
 
@@ -118,24 +163,62 @@ static void flush_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
 
 	flush_vgic_state(host_vcpu, shadow_vcpu);
 	flush_timer_state(shadow_state);
+
+	switch (ARM_EXCEPTION_CODE(shadow_state->exit_code)) {
+	case ARM_EXCEPTION_IRQ:
+	case ARM_EXCEPTION_EL1_SERROR:
+	case ARM_EXCEPTION_IL:
+		break;
+	case ARM_EXCEPTION_TRAP:
+		esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(shadow_vcpu));
+		ec_handler = entry_vm_shadow_handlers[esr_ec];
+		if (ec_handler)
+			ec_handler(host_vcpu, shadow_vcpu);
+		break;
+	default:
+		BUG();
+	}
+
+	shadow_state->exit_code = 0;
 }
 
-static void sync_shadow_state(struct kvm_shadow_vcpu_state *shadow_state)
+static void sync_shadow_state(struct kvm_shadow_vcpu_state *shadow_state,
+			      u32 exit_reason)
 {
 	struct kvm_vcpu *shadow_vcpu = &shadow_state->shadow_vcpu;
 	struct kvm_vcpu *host_vcpu = shadow_state->host_vcpu;
+	shadow_entry_exit_handler_fn ec_handler;
+	unsigned long host_flags;
+	u8 esr_ec;
 
 	host_vcpu->arch.ctxt		= shadow_vcpu->arch.ctxt;
 
 	host_vcpu->arch.hcr_el2		= shadow_vcpu->arch.hcr_el2;
 	host_vcpu->arch.cptr_el2	= shadow_vcpu->arch.cptr_el2;
 
-	host_vcpu->arch.fault		= shadow_vcpu->arch.fault;
-
-	host_vcpu->arch.flags		= shadow_vcpu->arch.flags;
-
 	sync_vgic_state(host_vcpu, shadow_vcpu);
 	sync_timer_state(shadow_state);
+
+	switch (ARM_EXCEPTION_CODE(exit_reason)) {
+	case ARM_EXCEPTION_IRQ:
+		break;
+	case ARM_EXCEPTION_TRAP:
+		esr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(shadow_vcpu));
+		ec_handler = exit_vm_shadow_handlers[esr_ec];
+		if (ec_handler)
+			ec_handler(host_vcpu, shadow_vcpu);
+		break;
+	case ARM_EXCEPTION_EL1_SERROR:
+	case ARM_EXCEPTION_IL:
+		break;
+	default:
+		BUG();
+	}
+
+	host_flags = READ_ONCE(host_vcpu->arch.flags) &
+		~(KVM_ARM64_PENDING_EXCEPTION | KVM_ARM64_INCREMENT_PC);
+	WRITE_ONCE(host_vcpu->arch.flags, host_flags);
+	shadow_state->exit_code = exit_reason;
 }
 
 static void handle___pkvm_vcpu_load(struct kvm_cpu_context *host_ctxt)
@@ -231,7 +314,7 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 
 		ret = __kvm_vcpu_run(&shadow_state->shadow_vcpu);
 
-		sync_shadow_state(shadow_state);
+		sync_shadow_state(shadow_state, ret);
 	} else {
 		ret = __kvm_vcpu_run(vcpu);
 	}
-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
