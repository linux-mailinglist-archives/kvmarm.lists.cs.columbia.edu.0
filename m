Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D98943D99FF
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 02:10:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88C9D4A4A3;
	Wed, 28 Jul 2021 20:10:46 -0400 (EDT)
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
	with ESMTP id L9ZEHZN+F8Rz; Wed, 28 Jul 2021 20:10:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C0F54B0D2;
	Wed, 28 Jul 2021 20:10:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BD344B0E4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 20:10:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYQa0viXjvbz for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Jul 2021 20:10:37 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D85B94B0DE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 20:10:33 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 s4-20020a5e98040000b029052c7ba9d3c3so2289292ioj.17
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Jul 2021 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=So4mAAD/dVCoRq8TetBQqRrZgr1cr+U0+Uy1qurvCIQ=;
 b=lWdmJpQ9sgyGo3UxnyjHGhBfxEe6isq5yoxSgbc3IEG/ENRTKvjgbUZgW8MsGFJ6hc
 8Zh1J8YglURl20OiVIvmnHZ84BXocSwl15rJMPWv8yivvJrGIbKkQYoFqxPqCvRJuN6q
 3styAyCF+uyRVjAaryUFCdCW+UdJZjOSHyKtsHikEj7k3ReyOL2esZR/rbGJ09hGpW/2
 ZbgWpPYgc/75NEBfV7BrSmq7ZnFgwJia6QhvQBqg7ea0QAblEOVffe+mMHY2NN4t4egs
 mPjmCbpk+u0RfWhFcH0Wg90DiF2JbJ2KpPzpF0wJ0BzTmh//mRv5gDLeBxGN8gUOvQkg
 SKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=So4mAAD/dVCoRq8TetBQqRrZgr1cr+U0+Uy1qurvCIQ=;
 b=R58wFq8/2BTgMdX+JxYKsiIecj4hlqObvyuBT8s4comOlzJzuaQlY5K/q4YQsczfTG
 IVEhJMgzYaJ+M4eq4NbPK3Di2JS5oK2XXdxVMfOn5bdyy5PS9FXAU7K2eDWdRTzZQ1Lf
 4mkEzqCC2IJ9vBLORSR1L7ckDRjxneGiRuSfUuAiQqJuqprcHraaaAFlVzpNWji/qC9C
 PzEQJnS5e/Mus6ADtEFfTw+6k+c4GaZKzciO2gKiywDnKVKJJqRLPOaIZWab+E/cO7rA
 SiotGQdD42jw5vP1FEHFy/woInnQtnE+ZOAMZ+gcWGHtiYG7S+wyLEsE8/+hMqNDahqk
 T9rw==
X-Gm-Message-State: AOAM533ADpA4f+yaGTzNFRFAmlcMleusMbwhlSlGWp0ParC399/SMqxq
 KODPa+/baY10Ze4wVqx/PFl6yhvTZe0=
X-Google-Smtp-Source: ABdhPJyTqU6tpw5bJdTXTrnwZ61lSwYAv4fiZgbfLa+M0x+K+Heu92Rr1rPgApVDbUhntaomPxmsWmslPqI=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6e02:1a8b:: with SMTP id
 k11mr1664443ilv.136.1627517433290; Wed, 28 Jul 2021 17:10:33 -0700 (PDT)
Date: Thu, 29 Jul 2021 00:10:10 +0000
In-Reply-To: <20210729001012.70394-1-oupton@google.com>
Message-Id: <20210729001012.70394-12-oupton@google.com>
Mime-Version: 1.0
References: <20210729001012.70394-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v4 11/13] KVM: arm64: Provide userspace access to the physical
 counter offset
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Presently, KVM provides no facilities for correctly migrating a guest
that depends on the physical counter-timer. While most guests (barring
NV, of course) should not depend on the physical counter-timer, an
operator may still wish to provide a consistent view of the physical
counter-timer across migrations.

Provide userspace with a new vCPU attribute to modify the guest physical
counter-timer offset. Since the base architecture doesn't provide a
physical counter-timer offset register, emulate the correct behavior by
trapping accesses to the physical counter-timer whenever the offset
value is non-zero.

Uphold the same behavior as CNTVOFF_EL2 and broadcast the physical
offset to all vCPUs whenever written. This guarantees that the
counter-timer we provide the guest remains architectural, wherein all
views of the counter-timer are consistent across vCPUs. Reconfigure
timer traps for VHE on every guest entry, as different VMs will now have
different traps enabled. Enable physical counter traps for nVHE whenever
the offset is nonzero (we already trap physical timer registers in
nVHE).

FEAT_ECV provides a guest physical counter-timer offset register
(CNTPOFF_EL2), but ECV-enabled hardware is nonexistent at the time of
writing so support for it was elided for the sake of the author :)

Cc: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 Documentation/virt/kvm/devices/vcpu.rst   | 22 +++++++
 arch/arm64/include/asm/kvm_host.h         |  1 +
 arch/arm64/include/asm/kvm_hyp.h          |  2 -
 arch/arm64/include/asm/sysreg.h           |  1 +
 arch/arm64/include/uapi/asm/kvm.h         |  1 +
 arch/arm64/kvm/arch_timer.c               | 72 ++++++++++++++---------
 arch/arm64/kvm/arm.c                      |  4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   | 23 ++++++++
 arch/arm64/kvm/hyp/include/hyp/timer-sr.h | 26 ++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c          |  2 -
 arch/arm64/kvm/hyp/nvhe/timer-sr.c        | 21 +++----
 arch/arm64/kvm/hyp/vhe/timer-sr.c         | 27 +++++++++
 include/kvm/arm_arch_timer.h              |  2 -
 13 files changed, 158 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/timer-sr.h

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 7b57cba3416a..a8547ce09b47 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -161,6 +161,28 @@ the following equation:
 KVM does not allow the use of varying offset values for different vCPUs;
 the last written offset value will be broadcasted to all vCPUs in a VM.
 
+2.3. ATTRIBUTE: KVM_ARM_VCPU_TIMER_OFFSET_PTIMER
+------------------------------------------------
+
+:Parameters: Pointer to a 64-bit unsigned counter-timer offset.
+
+Returns:
+
+         ======= ======================================
+         -EFAULT Error reading/writing the provided
+                 parameter address
+         -ENXIO  Attribute not supported
+         ======= ======================================
+
+Specifies the guest's physical counter-timer offset from the host's
+virtual counter. The guest's physical counter is then derived by
+the following equation:
+
+  guest_cntpct = host_cntvct - KVM_ARM_VCPU_TIMER_OFFSET_PTIMER
+
+KVM does not allow the use of varying offset values for different vCPUs;
+the last written offset value will be broadcasted to all vCPUs in a VM.
+
 3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL
 ==================================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 41911585ae0c..de92fa678924 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -204,6 +204,7 @@ enum vcpu_sysreg {
 	SP_EL1,
 	SPSR_EL1,
 
+	CNTPOFF_EL2,
 	CNTVOFF_EL2,
 	CNTV_CVAL_EL0,
 	CNTV_CTL_EL0,
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 9d60b3006efc..01eb3864e50f 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -65,10 +65,8 @@ void __vgic_v3_save_aprs(struct vgic_v3_cpu_if *cpu_if);
 void __vgic_v3_restore_aprs(struct vgic_v3_cpu_if *cpu_if);
 int __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu);
 
-#ifdef __KVM_NVHE_HYPERVISOR__
 void __timer_enable_traps(struct kvm_vcpu *vcpu);
 void __timer_disable_traps(struct kvm_vcpu *vcpu);
-#endif
 
 #ifdef __KVM_NVHE_HYPERVISOR__
 void __sysreg_save_state_nvhe(struct kvm_cpu_context *ctxt);
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7b9c3acba684..d3890a44b7f7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -505,6 +505,7 @@
 #define SYS_AMEVCNTR0_MEM_STALL		SYS_AMEVCNTR0_EL0(3)
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
+#define SYS_CNTPCT_EL0			sys_reg(3, 3, 14, 0, 1)
 
 #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
 #define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 008d0518d2b1..3e42c72d4c68 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -366,6 +366,7 @@ struct kvm_arm_copy_mte_tags {
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 #define   KVM_ARM_VCPU_TIMER_OFFSET_VTIMER	2
+#define   KVM_ARM_VCPU_TIMER_OFFSET_PTIMER	3
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
 
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index d2b1b13af658..249fc29def16 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -89,7 +89,10 @@ static u64 timer_get_offset(struct arch_timer_context *ctxt)
 	switch(arch_timer_ctx_index(ctxt)) {
 	case TIMER_VTIMER:
 		return __vcpu_sys_reg(vcpu, CNTVOFF_EL2);
+	case TIMER_PTIMER:
+		return __vcpu_sys_reg(vcpu, CNTPOFF_EL2);
 	default:
+		WARN_ONCE(1, "unrecognized timer index %ld", arch_timer_ctx_index(ctxt));
 		return 0;
 	}
 }
@@ -134,6 +137,9 @@ static void timer_set_offset(struct arch_timer_context *ctxt, u64 offset)
 	case TIMER_VTIMER:
 		__vcpu_sys_reg(vcpu, CNTVOFF_EL2) = offset;
 		break;
+	case TIMER_PTIMER:
+		__vcpu_sys_reg(vcpu, CNTPOFF_EL2) = offset;
+		break;
 	default:
 		WARN(offset, "timer %ld\n", arch_timer_ctx_index(ctxt));
 	}
@@ -144,9 +150,24 @@ u64 kvm_phys_timer_read(void)
 	return timecounter->cc->read(timecounter->cc);
 }
 
+static bool timer_emulation_required(struct arch_timer_context *ctx)
+{
+	enum kvm_arch_timers timer = arch_timer_ctx_index(ctx);
+
+	switch (timer) {
+	case TIMER_VTIMER:
+		return false;
+	case TIMER_PTIMER:
+		return timer_get_offset(ctx);
+	default:
+		WARN_ONCE(1, "unrecognized timer index %ld\n", timer);
+		return false;
+	}
+}
+
 static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
 {
-	if (has_vhe()) {
+	if (has_vhe() && !timer_emulation_required(vcpu_ptimer(vcpu))) {
 		map->direct_vtimer = vcpu_vtimer(vcpu);
 		map->direct_ptimer = vcpu_ptimer(vcpu);
 		map->emul_ptimer = NULL;
@@ -747,8 +768,9 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-/* Make the updates of cntvoff for all vtimer contexts atomic */
-static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
+/* Make the updates of offset for all timer contexts atomic */
+static void update_timer_offset(struct kvm_vcpu *vcpu,
+				enum kvm_arch_timers timer, u64 offset)
 {
 	int i;
 	struct kvm *kvm = vcpu->kvm;
@@ -756,16 +778,26 @@ static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
 
 	mutex_lock(&kvm->lock);
 	kvm_for_each_vcpu(i, tmp, kvm)
-		timer_set_offset(vcpu_vtimer(tmp), cntvoff);
+		timer_set_offset(vcpu_get_timer(tmp, timer), offset);
 
 	/*
 	 * When called from the vcpu create path, the CPU being created is not
 	 * included in the loop above, so we just set it here as well.
 	 */
-	timer_set_offset(vcpu_vtimer(vcpu), cntvoff);
+	timer_set_offset(vcpu_get_timer(vcpu, timer), offset);
 	mutex_unlock(&kvm->lock);
 }
 
+static void update_vtimer_cntvoff(struct kvm_vcpu *vcpu, u64 cntvoff)
+{
+	update_timer_offset(vcpu, TIMER_VTIMER, cntvoff);
+}
+
+static void update_ptimer_cntpoff(struct kvm_vcpu *vcpu, u64 cntpoff)
+{
+	update_timer_offset(vcpu, TIMER_PTIMER, cntpoff);
+}
+
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = vcpu_timer(vcpu);
@@ -1272,28 +1304,6 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-/*
- * On VHE system, we only need to configure the EL2 timer trap register once,
- * not for every world switch.
- * The host kernel runs at EL2 with HCR_EL2.TGE == 1,
- * and this makes those bits have no effect for the host kernel execution.
- */
-void kvm_timer_init_vhe(void)
-{
-	/* When HCR_EL2.E2H ==1, EL1PCEN and EL1PCTEN are shifted by 10 */
-	u32 cnthctl_shift = 10;
-	u64 val;
-
-	/*
-	 * VHE systems allow the guest direct access to the EL1 physical
-	 * timer/counter.
-	 */
-	val = read_sysreg(cnthctl_el2);
-	val |= (CNTHCTL_EL1PCEN << cnthctl_shift);
-	val |= (CNTHCTL_EL1PCTEN << cnthctl_shift);
-	write_sysreg(val, cnthctl_el2);
-}
-
 static void set_timer_irqs(struct kvm *kvm, int vtimer_irq, int ptimer_irq)
 {
 	struct kvm_vcpu *vcpu;
@@ -1350,6 +1360,9 @@ int kvm_arm_timer_set_attr_offset(struct kvm_vcpu *vcpu, struct kvm_device_attr
 	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
 		update_vtimer_cntvoff(vcpu, offset);
 		break;
+	case KVM_ARM_VCPU_TIMER_OFFSET_PTIMER:
+		update_ptimer_cntpoff(vcpu, offset);
+		break;
 	default:
 		return -ENXIO;
 	}
@@ -1364,6 +1377,7 @@ int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
 		return kvm_arm_timer_set_attr_irq(vcpu, attr);
 	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+	case KVM_ARM_VCPU_TIMER_OFFSET_PTIMER:
 		return kvm_arm_timer_set_attr_offset(vcpu, attr);
 	}
 
@@ -1400,6 +1414,8 @@ int kvm_arm_timer_get_attr_offset(struct kvm_vcpu *vcpu, struct kvm_device_attr
 	switch (attr->attr) {
 	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
 		timer = vcpu_vtimer(vcpu);
+	case KVM_ARM_VCPU_TIMER_OFFSET_PTIMER:
+		timer = vcpu_ptimer(vcpu);
 		break;
 	default:
 		return -ENXIO;
@@ -1416,6 +1432,7 @@ int kvm_arm_timer_get_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
 		return kvm_arm_timer_get_attr_irq(vcpu, attr);
 	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+	case KVM_ARM_VCPU_TIMER_OFFSET_PTIMER:
 		return kvm_arm_timer_get_attr_offset(vcpu, attr);
 	}
 
@@ -1428,6 +1445,7 @@ int kvm_arm_timer_has_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	case KVM_ARM_VCPU_TIMER_IRQ_VTIMER:
 	case KVM_ARM_VCPU_TIMER_IRQ_PTIMER:
 	case KVM_ARM_VCPU_TIMER_OFFSET_VTIMER:
+	case KVM_ARM_VCPU_TIMER_OFFSET_PTIMER:
 		return 0;
 	}
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..47ea1e1ba80b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1558,9 +1558,7 @@ static void cpu_hyp_reinit(void)
 
 	cpu_hyp_reset();
 
-	if (is_kernel_in_hyp_mode())
-		kvm_timer_init_vhe();
-	else
+	if (!is_kernel_in_hyp_mode())
 		cpu_init_hyp_mode();
 
 	cpu_set_hyp_vector();
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e4a2f295a394..c3ae1e0614a2 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -8,6 +8,7 @@
 #define __ARM64_KVM_HYP_SWITCH_H__
 
 #include <hyp/adjust_pc.h>
+#include <hyp/timer-sr.h>
 
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
@@ -113,6 +114,8 @@ static inline void ___activate_traps(struct kvm_vcpu *vcpu)
 
 	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN) && (hcr & HCR_VSE))
 		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
+
+	__timer_enable_traps(vcpu);
 }
 
 static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
@@ -127,6 +130,8 @@ static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
 		vcpu->arch.hcr_el2 &= ~HCR_VSE;
 		vcpu->arch.hcr_el2 |= read_sysreg(hcr_el2) & HCR_VSE;
 	}
+
+	__timer_disable_traps(vcpu);
 }
 
 static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
@@ -405,6 +410,21 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static inline bool __hyp_handle_counter(struct kvm_vcpu *vcpu)
+{
+	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
+	int rt = kvm_vcpu_sys_get_rt(vcpu);
+	u64 rv;
+
+	if (sysreg != SYS_CNTPCT_EL0)
+		return false;
+
+	rv = __timer_read_cntpct(vcpu);
+	vcpu_set_reg(vcpu, rt, rv);
+	__kvm_skip_instr(vcpu);
+	return true;
+}
+
 /*
  * Return true when we were able to fixup the guest exit and should return to
  * the guest, false when we should restore the host state and return to the
@@ -439,6 +459,9 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (*exit_code != ARM_EXCEPTION_TRAP)
 		goto exit;
 
+	if (__hyp_handle_counter(vcpu))
+		goto guest;
+
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
 	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SYS64 &&
 	    handle_tx2_tvm(vcpu))
diff --git a/arch/arm64/kvm/hyp/include/hyp/timer-sr.h b/arch/arm64/kvm/hyp/include/hyp/timer-sr.h
new file mode 100644
index 000000000000..0b0d5d1039a4
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/hyp/timer-sr.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Google LLC
+ * Author: Oliver Upton <oupton@google.com>
+ */
+
+#ifndef __ARM64_KVM_HYP_TIMER_SR_H__
+#define __ARM64_KVM_HYP_TIMER_SR_H__
+
+#include <linux/compiler.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_hyp.h>
+
+static inline bool __timer_physical_emulation_required(struct kvm_vcpu *vcpu)
+{
+	return __vcpu_sys_reg(vcpu, CNTPOFF_EL2);
+}
+
+static inline u64 __timer_read_cntpct(struct kvm_vcpu *vcpu)
+{
+	return read_sysreg(cntpct_el0) - __vcpu_sys_reg(vcpu, CNTPOFF_EL2);
+}
+
+#endif /* __ARM64_KVM_HYP_TIMER_SR_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f7af9688c1f7..4a190c932f8c 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -217,7 +217,6 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	__activate_traps(vcpu);
 
 	__hyp_vgic_restore_state(vcpu);
-	__timer_enable_traps(vcpu);
 
 	__debug_switch_to_guest(vcpu);
 
@@ -230,7 +229,6 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	__sysreg_save_state_nvhe(guest_ctxt);
 	__sysreg32_save_state(vcpu);
-	__timer_disable_traps(vcpu);
 	__hyp_vgic_save_state(vcpu);
 
 	__deactivate_traps(vcpu);
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index 9072e71693ba..ebc3f0d0908d 100644
--- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -9,16 +9,13 @@
 #include <linux/kvm_host.h>
 
 #include <asm/kvm_hyp.h>
+#include <hyp/timer-sr.h>
 
 void __kvm_timer_set_cntvoff(u64 cntvoff)
 {
 	write_sysreg(cntvoff, cntvoff_el2);
 }
 
-/*
- * Should only be called on non-VHE systems.
- * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
- */
 void __timer_disable_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
@@ -29,20 +26,24 @@ void __timer_disable_traps(struct kvm_vcpu *vcpu)
 	write_sysreg(val, cnthctl_el2);
 }
 
-/*
- * Should only be called on non-VHE systems.
- * VHE systems use EL2 timers and configure EL1 timers in kvm_timer_init_vhe().
- */
 void __timer_enable_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
 
 	/*
 	 * Disallow physical timer access for the guest
-	 * Physical counter access is allowed
 	 */
 	val = read_sysreg(cnthctl_el2);
 	val &= ~CNTHCTL_EL1PCEN;
-	val |= CNTHCTL_EL1PCTEN;
+
+	/*
+	 * Disallow physical counter access for the guest if offsetting is
+	 * requested.
+	 */
+	if (__timer_physical_emulation_required(vcpu))
+		val &= ~CNTHCTL_EL1PCTEN;
+	else
+		val |= CNTHCTL_EL1PCTEN;
+
 	write_sysreg(val, cnthctl_el2);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/timer-sr.c b/arch/arm64/kvm/hyp/vhe/timer-sr.c
index 4cda674a8be6..10506f3ce8a1 100644
--- a/arch/arm64/kvm/hyp/vhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/timer-sr.c
@@ -4,9 +4,36 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#include <asm/kvm_host.h>
 #include <asm/kvm_hyp.h>
+#include <hyp/timer-sr.h>
 
 void __kvm_timer_set_cntvoff(u64 cntvoff)
 {
 	write_sysreg(cntvoff, cntvoff_el2);
 }
+
+void __timer_enable_traps(struct kvm_vcpu *vcpu)
+{
+	/* When HCR_EL2.E2H == 1, EL1PCEN nad EL1PCTEN are shifted by 10 */
+	u32 cnthctl_shift = 10;
+	u64 val, mask;
+
+	mask = CNTHCTL_EL1PCEN << cnthctl_shift;
+	mask |= CNTHCTL_EL1PCTEN << cnthctl_shift;
+
+	val = read_sysreg(cnthctl_el2);
+
+	/*
+	 * VHE systems allow the guest direct access to the EL1 physical
+	 * timer/counter if offsetting isn't requested.
+	 */
+	if (__timer_physical_emulation_required(vcpu))
+		val &= ~mask;
+	else
+		val |= mask;
+
+	write_sysreg(val, cnthctl_el2);
+}
+
+void __timer_disable_traps(struct kvm_vcpu *vcpu) {}
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 51c19381108c..f24fc435c401 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -83,8 +83,6 @@ u64 kvm_phys_timer_read(void);
 void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);
 void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);
 
-void kvm_timer_init_vhe(void);
-
 bool kvm_arch_timer_get_input_level(int vintid);
 
 #define vcpu_timer(v)	(&(v)->arch.timer_cpu)
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
