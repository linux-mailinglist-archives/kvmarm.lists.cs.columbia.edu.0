Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1D71417EC7
	for <lists+kvmarm@lfdr.de>; Sat, 25 Sep 2021 02:55:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A6CC4B164;
	Fri, 24 Sep 2021 20:55:56 -0400 (EDT)
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
	with ESMTP id QYpnFfJex4UP; Fri, 24 Sep 2021 20:55:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3B3E4B149;
	Fri, 24 Sep 2021 20:55:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CC0854B0C0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 20:55:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROWz0KP0uVzF for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Sep 2021 20:55:51 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5CA1F4B121
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 20:55:51 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 83-20020a251956000000b0059948f541cbso5814127ybz.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 17:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=LT6C+EWoOPXhX4LJMaTzuDL1M8Rr6/vPXMSs6obnDmQ=;
 b=Ua7RJBRheYdHxoUnkraV+tMlefvn8d9v5aPSzNmBSMhvVH2E+pEtJXtpCJk6L0p0ww
 hLl0OOf7yVxU4sjGwaAcX/rUcual8dEHvZFFyE3H3Xcrn29Zh5Isc0M2Lu6OqWv3d7sB
 h8fZSd2y01ucTLs5HFjaBY4r+726v03HilKx6F8o8EBTN2apnDi2M/ecyas5+dbAjsqu
 1ZU63ybagCSMPpfqqLGTBZWAQq/RWPNyEc/pvbz8ilDeC9p5AmUD+8Tlh8GUxwdtT+v0
 Mr6WZlTpLBDiyASS5bJOrhdHhjfBSjS020D1P9JIqWiius3oU0xeTDRiUs5hsWqlM6aj
 qYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=LT6C+EWoOPXhX4LJMaTzuDL1M8Rr6/vPXMSs6obnDmQ=;
 b=Q/92Gbgd0vwn4JvMI8SALA7Xjp6UoI/J7J0J5mq6BhEsttdBzMe9MLc5bFpXMQu5So
 YOwV/eHMv8jfzIk91djUpItYkZ8W7LHE2fbi7thrR6OlO6+FCWMGWCy6obwDcbUxOf8i
 PizFQGID78AsuH40FpJeJnQobT3szD/NNG/KSdR5C9LSsrNB1ZwiT/Ona5+5dKS7qJLb
 noJo6iYLWRQCJ8M5Dp1J2iyLZw2Pgyar1G9KxDGX6+X1DiPppd8b67miq6MdTHl70CTp
 Q7eccCUbvLGzkUKjCE3Ex9j/OU+BaKGyFGERVTW19ixOod9amni+3tjL7Z59Q9DGT85e
 OpSQ==
X-Gm-Message-State: AOAM531sbwSm3dO/MlQukFg3ZCAxPCNPYi5Uu34r6OnGdhq/3/Ci6uoc
 aleBi/9aAkKI9jXuOkz+vDd+aylKmmw=
X-Google-Smtp-Source: ABdhPJzzql6gEBkojiK/LaRzX7IPmRCR5RI0SK4XOE2giOld5arrnviAwZ71BFy0rFlL9OOLvlNjRaV/AOU=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:4c72:89be:dba3:2bcb])
 (user=seanjc job=sendgmr) by 2002:a25:1584:: with SMTP id
 126mr15674510ybv.126.1632531350780; 
 Fri, 24 Sep 2021 17:55:50 -0700 (PDT)
Date: Fri, 24 Sep 2021 17:55:23 -0700
In-Reply-To: <20210925005528.1145584-1-seanjc@google.com>
Message-Id: <20210925005528.1145584-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210925005528.1145584-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 09/14] KVM: Rename kvm_vcpu_block() => kvm_vcpu_halt()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, David Matlack <dmatlack@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

Rename kvm_vcpu_block() to kvm_vcpu_halt() in preparation for splitting
the actual "block" sequences into a separate helper (to be named
kvm_vcpu_block()).  x86 will use the standalone block-only path to handle
non-halt cases where the vCPU is not runnable.

Rename block_ns to halt_ns to match the new function name.

Opportunistically move an x86-specific comment to x86, and enhance it, too.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arch_timer.c       |  2 +-
 arch/arm64/kvm/handle_exit.c      |  4 ++--
 arch/arm64/kvm/psci.c             |  2 +-
 arch/mips/kvm/emulate.c           |  2 +-
 arch/powerpc/kvm/book3s_pr.c      |  2 +-
 arch/powerpc/kvm/book3s_pr_papr.c |  2 +-
 arch/powerpc/kvm/booke.c          |  2 +-
 arch/powerpc/kvm/powerpc.c        |  2 +-
 arch/s390/kvm/interrupt.c         |  2 +-
 arch/x86/kvm/x86.c                | 11 +++++++++--
 include/linux/kvm_host.h          |  2 +-
 virt/kvm/kvm_main.c               | 20 +++++++++-----------
 12 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 3df67c127489..7e8396f74010 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -467,7 +467,7 @@ static void timer_save_state(struct arch_timer_context *ctx)
 }
 
 /*
- * Schedule the background timer before calling kvm_vcpu_block, so that this
+ * Schedule the background timer before calling kvm_vcpu_halt, so that this
  * thread is removed from its waitqueue and made runnable when there's a timer
  * interrupt to handle.
  */
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 275a27368a04..08f823984712 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -82,7 +82,7 @@ static int handle_no_fpsimd(struct kvm_vcpu *vcpu)
  *
  * WFE: Yield the CPU and come back to this vcpu when the scheduler
  * decides to.
- * WFI: Simply call kvm_vcpu_block(), which will halt execution of
+ * WFI: Simply call kvm_vcpu_halt(), which will halt execution of
  * world-switches and schedule other host processes until there is an
  * incoming IRQ or FIQ to the VM.
  */
@@ -95,7 +95,7 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu)
 	} else {
 		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), false);
 		vcpu->stat.wfi_exit_stat++;
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 	}
 
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 74c47d420253..e275b2ca08b9 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -46,7 +46,7 @@ static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
 	 * specification (ARM DEN 0022A). This means all suspend states
 	 * for KVM will preserve the register state.
 	 */
-	kvm_vcpu_block(vcpu);
+	kvm_vcpu_halt(vcpu);
 	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 
 	return PSCI_RET_SUCCESS;
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 22e745e49b0a..b494d8d39290 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -952,7 +952,7 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.pending_exceptions) {
 		kvm_vz_lose_htimer(vcpu);
 		vcpu->arch.wait = 1;
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 
 		/*
 		 * We we are runnable, then definitely go off to user space to
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 6bc9425acb32..0ced1b16f0e5 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -492,7 +492,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 
 	if (msr & MSR_POW) {
 		if (!vcpu->arch.pending_exceptions) {
-			kvm_vcpu_block(vcpu);
+			kvm_vcpu_halt(vcpu);
 			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 			vcpu->stat.generic.halt_wakeup++;
 
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index ac14239f3424..1f10e7dfcdd0 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -376,7 +376,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		return kvmppc_h_pr_stuff_tce(vcpu);
 	case H_CEDE:
 		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 		vcpu->stat.generic.halt_wakeup++;
 		return EMULATE_DONE;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 977801c83aff..12abffa40cd9 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -718,7 +718,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.shared->msr & MSR_WE) {
 		local_irq_enable();
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 		hard_irq_disable();
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 8ab90ce8738f..565eed2dab81 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -236,7 +236,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 		break;
 	case EV_HCALL_TOKEN(EV_IDLE):
 		r = EV_SUCCESS;
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 		break;
 	default:
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 520450a7956f..10bd648170b7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1335,7 +1335,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 4, "enabled wait: %llu ns", sltime);
 no_timer:
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
-	kvm_vcpu_block(vcpu);
+	kvm_vcpu_halt(vcpu);
 	vcpu->valid_wakeup = false;
 	__unset_cpu_idle(vcpu);
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eade8a2bdccf..0d71c73a61bb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8645,6 +8645,13 @@ void kvm_arch_exit(void)
 
 static int __kvm_emulate_halt(struct kvm_vcpu *vcpu, int state, int reason)
 {
+	/*
+	 * The vCPU has halted, e.g. executed HLT.  Update the run state if the
+	 * local APIC is in-kernel, the run loop will detect the non-runnable
+	 * state and halt the vCPU.  Exit to userspace if the local APIC is
+	 * managed by userspace, in which case userspace is responsible for
+	 * handling wake events.
+	 */
 	++vcpu->stat.halt_exits;
 	if (lapic_in_kernel(vcpu)) {
 		vcpu->arch.mp_state = state;
@@ -9886,7 +9893,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 	if (!kvm_arch_vcpu_runnable(vcpu) &&
 	    (!kvm_x86_ops.pre_block || static_call(kvm_x86_pre_block)(vcpu) == 0)) {
 		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 
 		if (kvm_x86_ops.post_block)
@@ -10120,7 +10127,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			r = -EINTR;
 			goto out;
 		}
-		kvm_vcpu_block(vcpu);
+		kvm_vcpu_halt(vcpu);
 		if (kvm_apic_accept_events(vcpu) < 0) {
 			r = 0;
 			goto out;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3f87d6ad20bf..d2a8be3fb9ba 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -965,7 +965,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn);
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
-void kvm_vcpu_block(struct kvm_vcpu *vcpu);
+void kvm_vcpu_halt(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f96cda8312f3..280cf1dca7db 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3221,16 +3221,13 @@ static inline void update_halt_poll_stats(struct kvm_vcpu *vcpu, ktime_t start,
 	}
 }
 
-/*
- * The vCPU has executed a HLT instruction with in-kernel mode enabled.
- */
-void kvm_vcpu_block(struct kvm_vcpu *vcpu)
+void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 {
 	bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
 	bool do_halt_poll = halt_poll_allowed && vcpu->halt_poll_ns;
 	ktime_t start, cur, poll_end;
 	bool waited = false;
-	u64 block_ns;
+	u64 halt_ns;
 
 	start = cur = poll_end = ktime_get();
 	if (do_halt_poll) {
@@ -3273,7 +3270,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	}
 
 out:
-	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
+	/* The total time the vCPU was "halted", including polling time. */
+	halt_ns = ktime_to_ns(cur) - ktime_to_ns(start);
 
 	/*
 	 * Note, halt-polling is considered successful so long as the vCPU was
@@ -3287,24 +3285,24 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		if (!vcpu_valid_wakeup(vcpu)) {
 			shrink_halt_poll_ns(vcpu);
 		} else if (vcpu->kvm->max_halt_poll_ns) {
-			if (block_ns <= vcpu->halt_poll_ns)
+			if (halt_ns <= vcpu->halt_poll_ns)
 				;
 			/* we had a long block, shrink polling */
 			else if (vcpu->halt_poll_ns &&
-					block_ns > vcpu->kvm->max_halt_poll_ns)
+				 halt_ns > vcpu->kvm->max_halt_poll_ns)
 				shrink_halt_poll_ns(vcpu);
 			/* we had a short halt and our poll time is too small */
 			else if (vcpu->halt_poll_ns < vcpu->kvm->max_halt_poll_ns &&
-					block_ns < vcpu->kvm->max_halt_poll_ns)
+				 halt_ns < vcpu->kvm->max_halt_poll_ns)
 				grow_halt_poll_ns(vcpu);
 		} else {
 			vcpu->halt_poll_ns = 0;
 		}
 	}
 
-	trace_kvm_vcpu_wakeup(block_ns, waited, vcpu_valid_wakeup(vcpu));
+	trace_kvm_vcpu_wakeup(halt_ns, waited, vcpu_valid_wakeup(vcpu));
 }
-EXPORT_SYMBOL_GPL(kvm_vcpu_block);
+EXPORT_SYMBOL_GPL(kvm_vcpu_halt);
 
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
