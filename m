Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 892A1414A49
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 15:12:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 370FF4B115;
	Wed, 22 Sep 2021 09:12:22 -0400 (EDT)
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
	with ESMTP id X7+hFHmgGZcL; Wed, 22 Sep 2021 09:12:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A5804B1D0;
	Wed, 22 Sep 2021 09:11:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 089A2405A6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 20:06:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jMfTHUh8k9x for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Sep 2021 20:06:09 -0400 (EDT)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C5F144048B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 20:06:09 -0400 (EDT)
Received: by mail-qt1-f202.google.com with SMTP id
 a22-20020ac86116000000b002a1463f30ddso4664305qtm.17
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 17:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=UXKfzNBbNa1Oo/hLKODwyb6nbYWV7pmBiaBRuwKp1U0=;
 b=sij3IoihiiMGm0/dG5Xp7BiIKh2nJQSIypS3WrTNWrVOZHFksiSjBYstCiHLVbnJ13
 CGIedE83H/3gmCrV9RK/JpQ9g0u3tHEiQjhbTFJXXUrXV0ft34vTsOgWhRp1Wa7A8C6I
 ga/7VQ/lJSnUZA4NLjOrvJImdkqCnE8O/y4QTBssRcfWcNJ0EsLS/eKEb164VYhOZOrl
 XsSNnTRGSdZnzbutkd59kyydwUypRuPSaJDQOMl26PrdMRkBEJw/9N/QFBs8eSa/Xmr4
 6N1Q3twhtyak+avdO0kUbzl2cTxe08M4fiWduj9T2KL+up/0OzkOWDOk2cLy28m5k44C
 o7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=UXKfzNBbNa1Oo/hLKODwyb6nbYWV7pmBiaBRuwKp1U0=;
 b=NiI9m9ntMU/QUBWmueQ5w4FAxahqSLmoavSL8h9Ts9G8jR+gF9V0yz8EX7Oh68JeYp
 n0zB+DUqiNZ5w5wO/YmBRyWz6By0qCiWZHlwadmVg7D0UueyZK4oPYXcyCfphqZF0SKy
 AM88kFfAqwnoBoLGj9EKdfgHe1OwcZxEcKUWLAbB36DZou55nP1i2rTcFMbcn+BLG3sE
 jidgMlRu/5L98G4z/Yf/vNR4eOqu0iHVYCSbsiz6vGb3GBrWI8c+4Pta4VwFEILMP0er
 dD1xmV4DrLvxwmBUMobGZe9y7bYD9bPDcK203TY6ttN0bdUbuv15RNKNlsHpDVg7cNi5
 P2pA==
X-Gm-Message-State: AOAM532fAm+3xHNVKk/vXHaF4+A2qYlvMlSYWxvVMi528rJJxpYVOl7F
 wI2zhtC3U+N0StmH0lTzOX6Qh2sYUlY=
X-Google-Smtp-Source: ABdhPJxYtz6r8xJfl/cejZ4zPL5NzU57zPkIfCxWD2RF7CxQQEMc8shvHNk6SkGK7OMvvH0aEjDtmqay0xg=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a0c:8061:: with SMTP id
 88mr7515654qva.5.1632269169468; 
 Tue, 21 Sep 2021 17:06:09 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:05:29 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 12/16] KVM: Move x86's perf guest info callbacks to generic
 KVM
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
 Nick Hu <nickhu@andestech.com>, 
 Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
X-Mailman-Approved-At: Wed, 22 Sep 2021 09:11:52 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-riscv@lists.infradead.org, Jiri Olsa <jolsa@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Stefano Stabellini <sstabellini@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-csky@vger.kernel.org,
 xen-devel@lists.xenproject.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Artem Kashkanov <artem.kashkanov@intel.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Like Xu <like.xu.linux@gmail.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Move x86's perf guest callbacks into common KVM, as they are semantically
identical to arm64's callbacks (the only other such KVM callbacks).
arm64 will convert to the common versions in a future patch.

Implement the necessary arm64 arch hooks now to avoid having to provide
stubs or a temporary #define (from x86) to avoid arm64 compilation errors
when CONFIG_GUEST_PERF_EVENTS=y.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  8 +++++
 arch/arm64/kvm/arm.c              |  5 +++
 arch/x86/include/asm/kvm_host.h   |  3 ++
 arch/x86/kvm/x86.c                | 53 +++++++------------------------
 include/linux/kvm_host.h          | 10 ++++++
 virt/kvm/kvm_main.c               | 44 +++++++++++++++++++++++++
 6 files changed, 81 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed940aec89e0..828b6eaa2c56 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -673,6 +673,14 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 void kvm_perf_init(void);
 void kvm_perf_teardown(void);
 
+#ifdef CONFIG_GUEST_PERF_EVENTS
+static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
+{
+	/* Any callback while a vCPU is loaded is considered to be in guest. */
+	return !!vcpu;
+}
+#endif
+
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
 void kvm_update_stolen_time(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..2b542fdc237e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -500,6 +500,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return *vcpu_pc(vcpu);
+}
+
 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
 {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2d86a2dfc775..6efe4e03a6d2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1543,6 +1543,9 @@ static inline int kvm_arch_flush_remote_tlb(struct kvm *kvm)
 		return -ENOTSUPP;
 }
 
+#define kvm_arch_pmi_in_guest(vcpu) \
+	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
+
 int kvm_mmu_module_init(void);
 void kvm_mmu_module_exit(void);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 412646b973bb..1bea616402e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8264,43 +8264,12 @@ static void kvm_timer_init(void)
 			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
 }
 
-static inline bool kvm_pmi_in_guest(struct kvm_vcpu *vcpu)
-{
-	return vcpu && vcpu->arch.handling_intr_from_guest;
-}
-
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!kvm_pmi_in_guest(vcpu))
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (static_call(kvm_x86_get_cpl)(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_guest_get_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	/* Retrieving the IP must be guarded by a call to kvm_guest_state(). */
-	if (WARN_ON_ONCE(!kvm_pmi_in_guest(vcpu)))
-		return 0;
-
-	return kvm_rip_read(vcpu);
-}
-
 static unsigned int kvm_handle_intel_pt_intr(void)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 
 	/* '0' on failure so that the !PT case can use a RET0 static call. */
-	if (!kvm_pmi_in_guest(vcpu))
+	if (!kvm_arch_pmi_in_guest(vcpu))
 		return 0;
 
 	kvm_make_request(KVM_REQ_PMI, vcpu);
@@ -8309,12 +8278,6 @@ static unsigned int kvm_handle_intel_pt_intr(void)
 	return 1;
 }
 
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state			= kvm_guest_state,
-	.get_ip			= kvm_guest_get_ip,
-	.handle_intel_pt_intr	= NULL,
-};
-
 #ifdef CONFIG_X86_64
 static void pvclock_gtod_update_fn(struct work_struct *work)
 {
@@ -11068,9 +11031,11 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
+	/* Temporary ugliness. */
 	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
-		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+		kvm_register_perf_callbacks(kvm_handle_intel_pt_intr);
+	else
+		kvm_register_perf_callbacks(NULL);
 
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
@@ -11099,8 +11064,7 @@ int kvm_arch_hardware_setup(void *opaque)
 
 void kvm_arch_hardware_unsetup(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
-	kvm_guest_cbs.handle_intel_pt_intr = NULL;
+	kvm_unregister_perf_callbacks();
 
 	static_call(kvm_x86_hardware_unsetup)();
 }
@@ -11727,6 +11691,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu->arch.preempted_in_kernel;
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return kvm_rip_read(vcpu);
+}
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e4d712e9f760..b9255a6439f2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1163,6 +1163,16 @@ static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
 }
 #endif
 
+#ifdef CONFIG_GUEST_PERF_EVENTS
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu);
+
+void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void));
+void kvm_unregister_perf_callbacks(void);
+#else
+static inline void kvm_register_perf_callbacks(void *ign) {}
+static inline void kvm_unregister_perf_callbacks(void) {}
+#endif /* CONFIG_GUEST_PERF_EVENTS */
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e67c93ca403..179fb110a00f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5460,6 +5460,50 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
         return &kvm_running_vcpu;
 }
 
+#ifdef CONFIG_GUEST_PERF_EVENTS
+static unsigned int kvm_guest_state(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	unsigned int state;
+
+	if (!kvm_arch_pmi_in_guest(vcpu))
+		return 0;
+
+	state = PERF_GUEST_ACTIVE;
+	if (!kvm_arch_vcpu_in_kernel(vcpu))
+		state |= PERF_GUEST_USER;
+
+	return state;
+}
+
+static unsigned long kvm_guest_get_ip(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	/* Retrieving the IP must be guarded by a call to kvm_guest_state(). */
+	if (WARN_ON_ONCE(!kvm_arch_pmi_in_guest(vcpu)))
+		return 0;
+
+	return kvm_arch_vcpu_get_ip(vcpu);
+}
+
+static struct perf_guest_info_callbacks kvm_guest_cbs = {
+	.state			= kvm_guest_state,
+	.get_ip			= kvm_guest_get_ip,
+	.handle_intel_pt_intr	= NULL,
+};
+
+void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void))
+{
+	kvm_guest_cbs.handle_intel_pt_intr = pt_intr_handler;
+	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+}
+void kvm_unregister_perf_callbacks(void)
+{
+	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+}
+#endif
+
 struct kvm_cpu_compat_check {
 	void *opaque;
 	int *ret;
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
