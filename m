Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9592229D58
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jul 2020 18:45:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8AE654B2C7;
	Wed, 22 Jul 2020 12:45:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tYrRp7pbe42; Wed, 22 Jul 2020 12:45:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 495874B2BA;
	Wed, 22 Jul 2020 12:45:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7501D4B2A8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:45:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qd7qGViizg8f for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jul 2020 12:45:04 -0400 (EDT)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E39E94B2B9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 12:45:03 -0400 (EDT)
Received: by mail-wr1-f66.google.com with SMTP id f1so2008899wro.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eImpnhEO4VwAZh9DFGEK47etMR4IqLUuZar0HHVWIYc=;
 b=nDh5CTG/ZDTR3Wf0MrlsOp7iOd3+YLoaPlpD6Bd+S6cx9plMTW+TRhrMPSNz0g4YON
 B5/2L0zyt4puhDMJz8i6g/0fcnTYdFbJxnxZgDwO+8D1f4p5pEoaT6WIWZsWLRM6bfqq
 Z9gycLLkiEyo1xBqk7+sLoqPv6LI3xNvDihpVjjCunFBjCHJSpqgg+wVlHfLsKtUNSTt
 6iygFJoWDq2Do8PRj+neXgNJhvpHt58Ho9lS3sLZXjpIlAR0snEIbO9PjwlFMn5v+RZR
 QlQzorddi/Bcy8kczzNq8nBrmuBMF2CiOtImpTwevuKkiAJOM44tYdE0qATGIa9HlmtK
 /hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eImpnhEO4VwAZh9DFGEK47etMR4IqLUuZar0HHVWIYc=;
 b=qEvXuZyk29SMoAETj1bzlip6BUkphLpPfJMt2g9Jc5JUC97v5zRUIz/Klg/v5/P/Dd
 LGZ7y0JJQC299hpjCNBAsoN6AgEI/NyQnKpJWHh0kHHVGO20ZKcnbbrEvKMfWzq9fTQ9
 c+d+kJm2Py2RahY2bN5bFV6j5L9DENX1v/wurJbeNEsO2mdB87eeosouXS1EWin14WJv
 NwLWiWywY8No4ufYcG/vkgsiWoQFoiHOf4unets7ZzWiMm9A8fWUZXv0KJBM6bncNKw1
 9NFupmWnHJD9WDm2JsaDNC848M+0DXBt1zRX2J5+Itk3zVvXZQcchSlXfnSnXxIOmMKV
 m9nw==
X-Gm-Message-State: AOAM532x4K43Q5UesbNZ5CLSSugx3c7poTSkM5Gx6AQGQaFIyesiF8ar
 GHkLv/0Mv1UG0rNjZw6oRWeLNw==
X-Google-Smtp-Source: ABdhPJyxyJUAxG9reBle7yXKCyrv+T4kQrCRc8RdgMK057wOMWcrkVqWbo9PqLlkpstGMWqATZ6LGw==
X-Received: by 2002:adf:bc54:: with SMTP id a20mr371420wrh.227.1595436302760; 
 Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
 by smtp.gmail.com with ESMTPSA id d13sm469069wrq.89.2020.07.22.09.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:45:02 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/9] kvm: arm64: Remove __hyp_this_cpu_read
Date: Wed, 22 Jul 2020 17:44:17 +0100
Message-Id: <20200722164424.42225-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@google.com, kvmarm@lists.cs.columbia.edu,
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

this_cpu_ptr is meant for use in kernel proper because it selects between
TPIDR_EL1/2 based on nVHE/VHE. __hyp_this_cpu_ptr was used in hyp to always
select TPIDR_EL2. Unify all users behind this_cpu_ptr and friends by
selecting _EL2 register under __KVM_NVHE_HYPERVISOR__.

Under CONFIG_DEBUG_PREEMPT, the kernel helpers perform a preemption check
which is omitted by the hyp helpers. Preserve the behavior for nVHE by
overriding the corresponding macros under __KVM_NVHE_HYPERVISOR__. Extend
the checks into VHE hyp code.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h          | 20 --------------
 arch/arm64/include/asm/percpu.h           | 33 +++++++++++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 +--
 arch/arm64/kvm/hyp/include/hyp/switch.h   |  6 ++---
 arch/arm64/kvm/hyp/nvhe/switch.c          |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |  2 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 +--
 7 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index fb1a922b31ba..da4a0826cacd 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -149,26 +149,6 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 		addr;							\
 	})
 
-/*
- * Home-grown __this_cpu_{ptr,read} variants that always work at HYP,
- * provided that sym is really a *symbol* and not a pointer obtained from
- * a data structure. As for SHIFT_PERCPU_PTR(), the creative casting keeps
- * sparse quiet.
- */
-#define __hyp_this_cpu_ptr(sym)						\
-	({								\
-		void *__ptr;						\
-		__verify_pcpu_ptr(&sym);				\
-		__ptr = hyp_symbol_addr(sym);				\
-		__ptr += read_sysreg(tpidr_el2);			\
-		(typeof(sym) __kernel __force *)__ptr;			\
-	 })
-
-#define __hyp_this_cpu_read(sym)					\
-	({								\
-		*__hyp_this_cpu_ptr(sym);				\
-	 })
-
 #else /* __ASSEMBLY__ */
 
 .macro hyp_adr_this_cpu reg, sym, tmp
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 0b6409b89e5e..b4008331475b 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -19,7 +19,21 @@ static inline void set_my_cpu_offset(unsigned long off)
 			:: "r" (off) : "memory");
 }
 
-static inline unsigned long __my_cpu_offset(void)
+static inline unsigned long __hyp_my_cpu_offset(void)
+{
+	unsigned long off;
+
+	/*
+	 * We want to allow caching the value, so avoid using volatile and
+	 * instead use a fake stack read to hazard against barrier().
+	 */
+	asm("mrs %0, tpidr_el2" : "=r" (off) :
+		"Q" (*(const unsigned long *)current_stack_pointer));
+
+	return off;
+}
+
+static inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
 
@@ -35,7 +49,12 @@ static inline unsigned long __my_cpu_offset(void)
 
 	return off;
 }
-#define __my_cpu_offset __my_cpu_offset()
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define __my_cpu_offset __hyp_my_cpu_offset()
+#else
+#define __my_cpu_offset __kern_my_cpu_offset()
+#endif
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -227,4 +246,14 @@ PERCPU_RET_OP(add, add, ldadd)
 
 #include <asm-generic/percpu.h>
 
+/* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
+#if defined(__KVM_NVHE_HYPERVISOR__) && defined(CONFIG_DEBUG_PREEMPT)
+#undef	this_cpu_ptr
+#define	this_cpu_ptr		raw_cpu_ptr
+#undef	__this_cpu_read
+#define	__this_cpu_read		raw_cpu_read
+#undef	__this_cpu_write
+#define	__this_cpu_write	raw_cpu_write
+#endif
+
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
index 0297dc63988c..3b2056a225ff 100644
--- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
@@ -135,7 +135,7 @@ static inline void __debug_switch_to_guest_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
@@ -154,7 +154,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 0511af14dc81..e69c2c6098a1 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -382,7 +382,7 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	    !esr_is_ptrauth_trap(kvm_vcpu_get_esr(vcpu)))
 		return false;
 
-	ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__ptrauth_save_key(ctxt, APIA);
 	__ptrauth_save_key(ctxt, APIB);
 	__ptrauth_save_key(ctxt, APDA);
@@ -491,7 +491,7 @@ static inline void __set_guest_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * guest wants it disabled, so be it...
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 0, NULL);
 #endif
 }
@@ -503,7 +503,7 @@ static inline void __set_host_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * If the guest has disabled the workaround, bring it back on.
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 1, NULL);
 #endif
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 341be2f2f312..ddb602ffb022 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -175,7 +175,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	vcpu = kern_hyp_va(vcpu);
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index c52d714e0d75..746fcc3974c7 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -108,7 +108,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt;
 	u64 exit_code;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 996471e4c138..2a0b8c88d74f 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -66,7 +66,7 @@ void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__sysreg_save_user_state(host_ctxt);
 
 	/*
@@ -100,7 +100,7 @@ void kvm_vcpu_put_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	deactivate_traps_vhe_put();
 
 	__sysreg_save_el1_state(guest_ctxt);
-- 
2.27.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
